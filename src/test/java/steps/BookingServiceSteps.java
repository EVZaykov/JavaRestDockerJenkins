package steps;

import com.jayway.jsonpath.JsonPath;
import config.TestConfig;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.restassured.response.ValidatableResponse;
import net.minidev.json.JSONArray;
import org.junit.Assert;
import pojos.Booking;
import pojos.Bookingdates;
import services.BookingService;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.MatcherAssert.assertThat;
import static utils.CheckVariable.checkVariable;
import static utils.RunContext.RUN_CONTEXT;

public class BookingServiceSteps {

    BookingService bookingService = new BookingService();
    TestConfig testConfig = new TestConfig();

    @Given("I get ids of all the bookings and save the response into the variable {string}")
    public void user_gets_all_books_s_Ids_and_saves_response_to_var(String varName) {
        ValidatableResponse validatableResponse = bookingService.getBookingIds();
        RUN_CONTEXT.put(varName, validatableResponse);
    }

    @Given("I create the booking and save response into the variable {string}")
    public void user_creates_booking_and_save_response_to_var(String varName, DataTable dataTable) {
        Booking body = Booking.builder()
                .firstname(dataTable.cell(1, 0))
                .lastname(dataTable.cell(1, 1))
                .totalprice(Integer.parseInt(dataTable.cell(1, 2)))
                .depositpaid(Boolean.parseBoolean(dataTable.cell(1, 3)))
                .bookingdates(Bookingdates.builder().checkin(dataTable.cell(1, 4)).checkout(dataTable.cell(1, 5)).build())
                .additionalneeds(dataTable.cell(1, 6)).build();
        ValidatableResponse validatableResponse = bookingService.createBooking(body);
        RUN_CONTEXT.put(varName, validatableResponse);
    }

    @Given("I get booking with parameters and save response into the variable {string}")
    public void user_gets_booking_by_id_and_save_response_to_var(String varName, DataTable dataTable) {
        ValidatableResponse validatableResponse = bookingService.getBooking(dataTable.asMap(String.class, String.class));
        RUN_CONTEXT.put(varName, validatableResponse);
    }

    @Given("I update the booking with id {string} and save response into the variable {string}")
    public void user_updates_booking_with_id_and_save_response_to_var(String id, String varName, io.cucumber.datatable.DataTable dataTable) {
        Booking booking = Booking.builder()
                .firstname(dataTable.cell(1, 0))
                .lastname(dataTable.cell(1, 1))
                .totalprice(Integer.parseInt(dataTable.cell(1, 2)))
                .depositpaid(Boolean.parseBoolean(dataTable.cell(1, 3)))
                .bookingdates(Bookingdates.builder().checkin(dataTable.cell(1, 4)).checkout(dataTable.cell(1, 5)).build())
                .additionalneeds(dataTable.cell(1, 6)).build();
        ValidatableResponse validatableResponse = bookingService.updateBooking(booking, checkVariable(id).toString());
        RUN_CONTEXT.put(varName, validatableResponse);
    }

    @Given("I delete the booking with id {string} and save the response into the variable {string}")
    public void user_deletes_booking_with_id_and_save_response_to_var(String id, String varName) {
        ValidatableResponse validatableResponse = bookingService.deleteBooking(checkVariable(id).toString());
        RUN_CONTEXT.put(varName, validatableResponse);
    }

    @Given("I do partial update for booking with id {string} body like the file {string} and save response into the variable {string}")
    public void user_partial_updates_with_id_body_like_file_and_save_response_to_var(String id, String fileName, String varName) throws IOException {
        FileInputStream body = new FileInputStream(String.format(testConfig.getPathToJson().toFile().getAbsolutePath(), fileName));
        ValidatableResponse validatableResponse = bookingService.partialUpdateBooking(body, checkVariable(id).toString());
        RUN_CONTEXT.put(varName, validatableResponse);
    }


    @Given("I get the booking by id {string} and save the response into the variable {string}")
    public void user_gets_booking_by_id_and_save_response_to_var(String id, String varName) {
        Object d = RUN_CONTEXT.get(id, Object.class);
        if (d instanceof ArrayList) {
            for (int i = 0; i < ((ArrayList<?>) d).size(); i++) {
                ValidatableResponse validatableResponse = bookingService.getBooking(((ArrayList<?>) d).get(i).toString());
                validatableResponse.extract().statusCode();
                RUN_CONTEXT.put(varName, validatableResponse);
            }
        }
        ValidatableResponse validatableResponse = bookingService.getBooking(checkVariable(id).toString());
        RUN_CONTEXT.put(varName, validatableResponse);
    }

    @Given("I get the booking by id {string} and check status code, expected code = {string}, parameters")
    public void i_get_the_booking_by_id_and_check_status_code_expected_code_parameters(String id, String statusCode, DataTable dataTable) {
        //noinspection unchecked
        List<Integer> ids = RUN_CONTEXT.get(id, List.class);
        for (int bookingId : ids) {
            ValidatableResponse validatableResponse = bookingService.getBooking(String.valueOf(bookingId));
            int actualStatus = validatableResponse.extract().statusCode();
            int expectStatus = Integer.parseInt(statusCode);
            Assert.assertEquals(expectStatus, actualStatus);
            for (int i = 0; i < dataTable.height(); i++) {
                String expected = dataTable.cell(i, 1);
                Object pathValue = JsonPath.read(validatableResponse.extract().body().asString(), dataTable.cell(i, 0));
                if (pathValue instanceof JSONArray) {
                    JSONArray sizes = (JSONArray) pathValue;
                    if (sizes.isEmpty()) {
                        Assert.fail("I got the booking with wrong date! JsonPath : " + dataTable.cell(i, 0) + " returned : empty");
                        Assert.fail("JsonPath : " + dataTable.cell(i, 0) + " returned : empty");
                    }
                    assertThat(String.valueOf(sizes.get(0)), equalTo(expected));
                } else {
                    assertThat(pathValue, equalTo(expected));
                }
            }
        }
    }
}