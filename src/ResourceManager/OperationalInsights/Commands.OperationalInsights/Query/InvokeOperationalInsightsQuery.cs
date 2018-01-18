﻿using Microsoft.Azure.Commands.Common.Authentication;
using Microsoft.Azure.Commands.OperationalInsights.Models;
using Microsoft.Azure.OperationalInsights;
using Microsoft.Rest;
using System;
using System.Management.Automation;
using System.Net;
using Microsoft.Azure.Commands.Common.Authentication.Abstractions;

namespace Microsoft.Azure.Commands.OperationalInsights.Query
{
    [Cmdlet("Invoke", "AzureRmOperationalInsightsQuery"), OutputType(typeof(PSQueryResponse))]
    public class InvokeOperationalInsightsQuery : ResourceManager.Common.AzureRMCmdlet
    {
        private const string ParamSetNameByWorkspaceId = "ByWorkspaceId";
        private const string ParamSetNameByWorkspaceObject = "ByWorkspaceObject";

        [Parameter(Mandatory = true, ParameterSetName = ParamSetNameByWorkspaceId, HelpMessage = "The workspace ID.")]
        [ValidateNotNullOrEmpty]
        public string WorkspaceId { get; set; }

        [Parameter(Mandatory = true, ParameterSetName = ParamSetNameByWorkspaceObject, HelpMessage = "The workspace", ValueFromPipeline = true)]
        public PSWorkspace Workspace { get; set; }

        [Parameter(Mandatory = true, HelpMessage = "The query to execute.")]
        [ValidateNotNullOrEmpty]
        public string Query { get; set; }

        [Parameter(Mandatory = false, HelpMessage = "The timespan to bound the query by.")]
        public TimeSpan? Timespan { get; set; } = null;

        [Parameter(Mandatory = false, HelpMessage = "Puts an upper bound on the amount of time the server will spend processing the query. See: https://dev.loganalytics.io/documentation/Using-the-API/Timeouts")]
        [ValidateRange(1, int.MaxValue)]
        public int? Wait { get; set; }

        [Parameter(Mandatory = false, HelpMessage = "If specified, rendering information for metric queries will be included in the response.")]
        public SwitchParameter IncludeRender { get; set; }

        [Parameter(Mandatory = false, HelpMessage = "If specified, query statistics will be included in the response.")]
        public SwitchParameter IncludeStatistics { get; set; }

        [Parameter(Mandatory = false,
            HelpMessage = "When specified, uses the 'DEMO_KEY' API key for authentication. This is only valid when querying against the workspace 'DEMO_WORKSPACE'.")]
        public SwitchParameter UseDemoKey { get; set; }

        private OperationalInsightsDataClient _operationalInsightsDataClient;

        internal OperationalInsightsDataClient OperationalInsightsDataClient
        {
            get
            {
                if (this._operationalInsightsDataClient == null)
                {
                    ServiceClientCredentials clientCredentials = null;
                    if (UseDemoKey.IsPresent)
                    {
                        if (ParameterSetName != ParamSetNameByWorkspaceId || WorkspaceId != "DEMO_WORKSPACE")
                        {
                            throw new Exception("DEMO_KEY is only valid when querying DEMO_WORKSPACE");
                        }

                        clientCredentials = new ApiKeyClientCredentials("DEMO_KEY");
                    }
                    else
                    {
                        clientCredentials = AzureSession.Instance.AuthenticationFactory.GetServiceClientCredentials(DefaultContext, AzureEnvironment.ExtendedEndpoint.OperationalInsightsEndpoint);
                    }

                    this._operationalInsightsDataClient =
                        AzureSession.Instance.ClientFactory.CreateCustomArmClient<OperationalInsightsDataClient>(clientCredentials);
                    this._operationalInsightsDataClient.Preferences.IncludeRender = IncludeRender.IsPresent;
                    this._operationalInsightsDataClient.Preferences.IncludeStatistics = IncludeStatistics.IsPresent;
                    this._operationalInsightsDataClient.NameHeader = "LogAnalyticsPSClient";

                    Uri targetUri= null;
                    DefaultContext.Environment.TryGetEndpointUrl(
                        AzureEnvironment.ExtendedEndpoint.OperationalInsightsEndpoint, out targetUri);
                    if (targetUri == null)
                    {
                        throw new Exception("Operational Insights is not supported in this Azure Environment");
                    }

                    this._operationalInsightsDataClient.BaseUri = targetUri;

                    if (targetUri.AbsoluteUri.Contains("localhost"))
                    {
                        ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
                    }
                }

                return this._operationalInsightsDataClient;
            }
            set
            {
                this._operationalInsightsDataClient = value;
            }
        }

        protected override void ProcessRecord()
        {
            if (ParameterSetName == ParamSetNameByWorkspaceId)
            {
                OperationalInsightsDataClient.WorkspaceId = WorkspaceId;
            }
            else if (ParameterSetName == ParamSetNameByWorkspaceObject)
            {
                // This seems like a weird mapping, but rest assurured, CustomerId is what we want here
                OperationalInsightsDataClient.WorkspaceId = Workspace.CustomerId.ToString();
            }

            if (Wait.HasValue)
            {
                OperationalInsightsDataClient.Preferences.Wait = Wait.Value;
            }

            WriteObject(PSQueryResponse.Create(OperationalInsightsDataClient.Query(Query, Timespan)));
        }
    }
}