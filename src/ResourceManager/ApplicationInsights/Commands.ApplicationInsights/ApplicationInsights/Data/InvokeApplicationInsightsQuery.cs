using Microsoft.Azure.ApplicationInsights;
using Microsoft.Azure.Commands.ApplicationInsights.Models;
using Microsoft.Azure.Commands.ApplicationInsights.Models.Data;
using Microsoft.Azure.Commands.Common.Authentication;
using Microsoft.Azure.Commands.Common.Authentication.Abstractions;
using Microsoft.Rest;
using System;
using System.Management.Automation;
using System.Net;

namespace Microsoft.Azure.Commands.ApplicationInsights.ApplicationInsights.Data
{
    [Cmdlet("Invoke", "AzureRmApplicationInsightsQuery", DefaultParameterSetName = ParamSetNameByApplicationId),
        OutputType(typeof(PSQueryResponse))]
    public class InvokeApplicationInsightsQuery : ResourceManager.Common.AzureRMCmdlet
    {
        private const string ParamSetNameByApplicationId= "ByApplicationId";
        private const string ParamSetNameByApplicationObject = "ByApplicationObject";

        [Parameter(Mandatory = true, ParameterSetName = ParamSetNameByApplicationId, HelpMessage = "The application ID.")]
        [ValidateNotNullOrEmpty]
        public string ApplicationId { get; set; }

        [Parameter(Mandatory = true, ParameterSetName = ParamSetNameByApplicationObject, HelpMessage = "The application", ValueFromPipeline = true)]
        public PSApplicationInsightsComponent Application { get; set; }

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

        private ApplicationInsightsDataClient _appInsightsDataClient;

        internal ApplicationInsightsDataClient ApplicationInsightsDataClient
        {
            get
            {
                if (this._appInsightsDataClient == null)
                {
                    ServiceClientCredentials clientCredentials = null;
                    if (ParameterSetName == ParamSetNameByApplicationId && ApplicationId == "DEMO_WORKSPACE")
                    {
                        clientCredentials = new ApiKeyClientCredentials("DEMO_KEY");
                    }
                    else
                    {
                        clientCredentials = AzureSession.Instance.AuthenticationFactory.GetServiceClientCredentials(DefaultContext, AzureEnvironment.ExtendedEndpoint.ApplicationInsightsEndpoint);
                    }

                    this._appInsightsDataClient =
                        AzureSession.Instance.ClientFactory.CreateCustomArmClient<ApplicationInsightsDataClient>(clientCredentials);
                    this._appInsightsDataClient.Preferences.IncludeRender = IncludeRender.IsPresent;
                    this._appInsightsDataClient.Preferences.IncludeStatistics = IncludeStatistics.IsPresent;
                    this._appInsightsDataClient.NameHeader = "LogAnalyticsPSClient";

                    Uri targetUri = null;
                    DefaultContext.Environment.TryGetEndpointUrl(
                        AzureEnvironment.ExtendedEndpoint.ApplicationInsightsEndpoint, out targetUri);
                    if (targetUri == null)
                    {
                        throw new Exception("Application Insights is not supported in this Azure Environment");
                    }

                    this._appInsightsDataClient.BaseUri = targetUri;

                    if (targetUri.AbsoluteUri.Contains("localhost"))
                    {
                        ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
                    }
                }

                return this._appInsightsDataClient;
            }
            set
            {
                this._appInsightsDataClient = value;
            }
        }

        protected override void ProcessRecord()
        {
            if (ParameterSetName == ParamSetNameByApplicationId)
            {
                ApplicationInsightsDataClient.AppId = ApplicationId;
            }
            else if (ParameterSetName == ParamSetNameByApplicationObject)
            {
                // This seems like a weird mapping, but rest assurured, CustomerId is what we want here
                ApplicationInsightsDataClient.AppId = Application.AppId;
            }

            if (Wait.HasValue)
            {
                ApplicationInsightsDataClient.Preferences.Wait = Wait.Value;
            }

            WriteObject(PSQueryResponse.Create(ApplicationInsightsDataClient.Query(Query, Timespan)));
        }
    }
}
