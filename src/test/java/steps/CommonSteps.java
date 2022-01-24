package steps;

import io.cucumber.java.en.Given;
import io.qameta.allure.Allure;

import java.util.ArrayList;

import static utils.RunContext.RUN_CONTEXT;

public class CommonSteps {
    @Given("Pause {string}")
    public void pause(String string) throws InterruptedException {
        Thread.sleep(Integer.parseInt(string));
    }

    @Given("I count elements in ArrayList {string} and save it into the variable {string}")
    public void i_count_elements_in_ArrayList_and_save_it_into_the_variable(String varName, String newVar) {
        ArrayList arrayList = RUN_CONTEXT.get(varName, ArrayList.class);
        RUN_CONTEXT.put(newVar, arrayList.size());
        Allure.step(newVar + " = " + arrayList.size());
    }
}
