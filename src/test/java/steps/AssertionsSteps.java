package steps;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.qameta.allure.Allure;
import io.restassured.response.ValidatableResponse;
import org.junit.Assert;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.MatcherAssert.assertThat;
import static utils.CheckVariable.checkVariable;
import static utils.RunContext.RUN_CONTEXT;

public class AssertionsSteps {


    @Given("I get the response {string} and check status code, expected result = {string}")
    public void user_gets_response_and_checks_status_code_ER(String varName, String statusCode) {
        ValidatableResponse validatableResponse = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        int actualStatus = validatableResponse.extract().statusCode();
        int expectStatus = Integer.parseInt(statusCode);
        Assert.assertEquals(expectStatus, actualStatus);
    }

    @Given("I get the response {string} and check the header {string} , expected result =  {string}")
    public void user_gets_response_and_checks_header_ER(String varName, String headerName, String expected) {
        ValidatableResponse validatableResponse = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        String headerValue = validatableResponse.extract().header(headerName);
        Assert.assertEquals(headerValue, expected);
    }

    @Given("I compare two variables {string} {string}")
    public void user_compare_two_variables(String firstVar, String secondVar) {
        Object var1 = checkVariable(firstVar);
        Object var2 = checkVariable(secondVar);
        Assert.assertEquals(var1, var2);
    }

    @Given("I check parameters in the response {string}")
    public void user_checks_all_params_in_response(String varName, DataTable dataTable) {
        ValidatableResponse response = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        for (int i = 0; i < dataTable.height(); i++) {
            String expected = dataTable.cell(i, 1);
            Object path = response.extract().body().path(dataTable.cell(i, 0));
            assertThat(String.valueOf(path), equalTo(expected));
        }
    }

    @Given("I check headers in the response {string}")
    public void user_checks_all_headers_in_response(String varName, DataTable dataTable) {
        ValidatableResponse response = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        for (int i = 0; i < dataTable.height(); i++) {
            String expected = dataTable.cell(i, 1);
            response.assertThat().header(dataTable.cell(i, 0), equalTo(expected));
        }
    }

    @Given("I check headers in the response {string} with regular expression")
    public void I_check_check_headers_in_response(String varName, DataTable dataTable) {
        ValidatableResponse response = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        for (int i = 0; i < dataTable.height(); i++) {
            Pattern pattern = Pattern.compile(dataTable.cell(i, 1));
            Matcher matcher = pattern.matcher(response.extract().header(dataTable.cell(i, 0)));
            if (matcher.find()) {
                Allure.step("Value " + matcher.group(0));
            } else {
                Allure.step("Pattern " + pattern);
                Assert.fail("Value doesn't match");
            }
        }
    }

    @Given("I compare two variables {string} and {string}")
    public void i_compare_two_variables_and(String varName1, String varName2) {
        Object variableOne = RUN_CONTEXT.get(varName1, Object.class);
        Object variableTwo = RUN_CONTEXT.get(varName2, Object.class);
        Allure.step("Compare " + variableOne + " " + variableTwo);
        Assert.assertEquals(variableOne, variableTwo);
    }
}
