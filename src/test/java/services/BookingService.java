package services;

import config.TestConfig;
import io.qameta.allure.restassured.AllureRestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.builder.ResponseSpecBuilder;
import io.restassured.response.ValidatableResponse;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;
import org.apache.tika.io.IOUtils;
import pojos.Booking;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class BookingService {
    TestConfig testConfig = new TestConfig();

    private final RequestSpecification REQ_SPEC =
            new RequestSpecBuilder()
                    .addFilter(new AllureRestAssured())
                    .setBaseUri(testConfig.getBaseUri())
                    .setBasePath(testConfig.getBasePath())
                    .setContentType("application/json")
                    .setAccept("application/json")
                    .build();

    private final ResponseSpecification RES_SPEC =
            new ResponseSpecBuilder()
                    .expectHeader("Server", "Cowboy")
                    .expectHeader("Connection", "keep-alive")
                    .expectHeader("X-Powered-By", "Express")
                    .expectHeader("Via", "1.1 vegur")
                    .build();

    public ValidatableResponse getBookingIds() {
        ValidatableResponse validatableResponse = given()
                .spec(REQ_SPEC)
                .when()
                .get().then().spec(RES_SPEC);
        return validatableResponse;
    }

    public ValidatableResponse getBooking(String id) {
        ValidatableResponse validatableResponse = given()
                .spec(REQ_SPEC)
                .get(id).then().spec(RES_SPEC);
        return validatableResponse;
    }

    public ValidatableResponse getBooking(Map<String, String> hashMap) {
        ValidatableResponse validatableResponse = given()
                .spec(REQ_SPEC)
                .queryParams(hashMap)
                .when()
                .get().then().spec(RES_SPEC);
        return validatableResponse;
    }

    public ValidatableResponse createBooking(Booking body) {
        ValidatableResponse validatableResponse = given()
                .spec(REQ_SPEC)
                .body(body)
                .post().then().spec(RES_SPEC);
        return validatableResponse;
    }

    public ValidatableResponse partialUpdateBooking(FileInputStream body, String id) throws IOException {
        InputStream inStream = body;
        String bodyAsString = IOUtils.toString(inStream, StandardCharsets.UTF_8.name());
        ValidatableResponse validatableResponse = given()
                .spec(REQ_SPEC)
                .auth()
                .preemptive()
                .basic(testConfig.getUsername(), testConfig.getPassword())
                .body(bodyAsString)
                .patch(id).then().spec(RES_SPEC);
        return validatableResponse;
    }

    public ValidatableResponse updateBooking(Booking body, String id) {
        ValidatableResponse validatableResponse = given()
                .spec(REQ_SPEC)
                .auth()
                .preemptive()
                .basic(testConfig.getUsername(), testConfig.getPassword())
                .body(body)
                .patch(id).then().spec(RES_SPEC);
        return validatableResponse;
    }

    public ValidatableResponse deleteBooking(String id) {
        ValidatableResponse validatableResponse = given()
                .spec(REQ_SPEC)
                .auth()
                .preemptive()
                .basic(testConfig.getUsername(), testConfig.getPassword())
                .delete(id).then().spec(RES_SPEC);
        return validatableResponse;
    }
}
