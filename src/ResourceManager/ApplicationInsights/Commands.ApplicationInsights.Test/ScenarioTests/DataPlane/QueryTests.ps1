function Test-SimpleQuery
{
    $appid = "DEMO_APP"
    $query = "union * | take 10"

    $results = Invoke-AzureRmApplicationInsightsQuery -ApplicationId $appId -Query $query

    AssertQueryResults $results 10
}

function Test-SimpleQueryWithTimespan
{
    $appid = "DEMO_APP"
    $query = "union * | take 10"
    $timespan = (New-Timespan -Hours 1)

    $results = Invoke-AzureRmApplicationInsightsQuery -ApplicationId $appId -Query $query -Timespan $timespan

    AssertQueryResults $results 10
}

function Test-ExceptionWithSyntaxError
{
    $appid = "DEMO_APP"
    $query = "union * | foobar"

    Assert-ThrowsContains { Invoke-AzureRmApplicationInsightsQuery -ApplicationId $appId -Query $query } "BadRequest"
}

function Test-ExceptionWithShortWait
{
    $appid = "DEMO_APP"
    $query = "union *"
    $timespan = (New-Timespan -Hours 24)
    $wait = 1;

    Assert-ThrowsContains { $results = Invoke-AzureRmApplicationInsightsQuery -ApplicationId $appId -Query $query -Timespan $timespan -Wait $wait } "GatewayTimeout"
}

function Test-AsJob
{
    $appid = "DEMO_APP"
    $query = "union * | take 10"
    $timespan = (New-Timespan -Hours 1)

    $job = Invoke-AzureRmApplicationInsightsQuery -ApplicationId $appId -Query $query -Timespan $timespan -AsJob
	$job | Wait-Job
	$results = $job | Receive-Job

    AssertQueryResults $results 10
}

function AssertQueryResults($results, $takeCount)
{
    Assert-NotNull $results
    Assert-NotNull $results.Results

    $resultsArray = [System.Linq.Enumerable]::ToArray($results.Results)

    Assert-AreEqual $resultsArray.Length $takeCount

    # Tenant ID should always be populated
    Assert-NotNull $resultsArray[0].TenantId
}
