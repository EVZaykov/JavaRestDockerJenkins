import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(glue = {"steps"},
        plugin = {"pretty", "html:target/cucumber-html-reports", "io.qameta.allure.cucumber4jvm.AllureCucumber4Jvm",
                "json:target/cucumber-html-reports/cucumber.json", "json:target/cucumber.json"}, features = "src/test/resources/features", tags = "@all")
public class RunCucumberTest {

}
