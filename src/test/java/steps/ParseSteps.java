package steps;

import io.cucumber.java.en.Given;
import io.qameta.allure.Allure;
import io.restassured.response.ValidatableResponse;
import org.junit.Assert;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.hamcrest.CoreMatchers.equalTo;
import static utils.RunContext.RUN_CONTEXT;

public class ParseSteps {

    @Given("I parse the response {string} with JsonPath {string} and save into the variable {string}")
    public void user_gets_value_from_json_path_from_response_and_saves_to_var(String varName, String jsonPath, String newVar) {
        ValidatableResponse response = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        Object value = response.extract().body().jsonPath().get(jsonPath);
        if (value == null) {
            Assert.fail("Value NOT FOUND");
        } else {
            RUN_CONTEXT.put(newVar, value);
            Allure.step("JsonPath :" + jsonPath + " Returned : " + value);
        }
    }

    @Given("I parse the response {string} with JsonPath {string}, expected result = {string}")
    public void user_gets_response_and_checks_value_form_json_path_er(String varName, String jsonPath, String expected) {
        ValidatableResponse response = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        response.assertThat().body(jsonPath, equalTo(expected));
    }

    @Given("I parse the response {string} with JsonPath {string} and check with the regular expression {string}")
    public void user_gets_response_and_checks_value_form_JsonPath_ans_check_with_regular_exp(String varName, String jsonPath, String regular) {
        ValidatableResponse response = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        Object path = response.extract().body().path(jsonPath);
        Pattern pattern = Pattern.compile(regular);
        Matcher matcher = pattern.matcher(path.toString());
        if (matcher.find()) {
            Allure.step("Value " + matcher.group(0));
        } else {
            Assert.fail("Value NOT FOUND");
        }
    }

    @Given("I parse the response {string} with JsonPath {string}and save into the variable {string}")
    public void i_parse_the_response_with_JsonPath_and_save_into_the_variable(String varName, String jsonPath, String newVar) {
        ValidatableResponse response = RUN_CONTEXT.get(varName, ValidatableResponse.class);
        Object valueJsonPath = response.extract().body().jsonPath().get(jsonPath);
        RUN_CONTEXT.put(newVar, valueJsonPath);
        Allure.step(newVar + " = " + valueJsonPath);
    }
}
