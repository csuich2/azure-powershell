using Microsoft.WindowsAzure.Commands.Test.Utilities.Common;
using Xunit;

namespace Microsoft.Azure.Commands.ApplicationInsights.Test.ScenarioTests.DataPlane
{
    public class QueryTests : RMTestBase
    {
        [Fact]
        public void TestSimpleQuery()
        {
            TestController.NewInstance.RunPsTest("Test-SimpleQuery");
        }

        [Fact]
        public void TestSimpleQueryWithTimespan()
        {
            TestController.NewInstance.RunPsTest("Test-SimpleQueryWithTimespan");
        }

        [Fact]
        public void TestExceptionWithSyntaxError()
        {
            TestController.NewInstance.RunPsTest("Test-ExceptionWithSyntaxError");
        }

        [Fact]
        public void TestExceptionWithShortWait()
        {
            TestController.NewInstance.RunPsTest("Test-ExceptionWithShortWait");
        }

        [Fact]
        public void TestAsJob()
        {
            TestController.NewInstance.RunPsTest("Test-AsJob");
        }
    }
}
