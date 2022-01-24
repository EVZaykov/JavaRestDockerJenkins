@all
Feature: Updates a current booking

  Background:
    * I create the booking and save response into the variable "responseAfterCreate"
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Franklin  | Cox      | 32411      | true        | 2022-03-01 | 2025-03-01 | nothing         |
    * I get the response "responseAfterCreate" and check status code, expected result = "200"
    * I parse the response "responseAfterCreate" with JsonPath "bookingid" and save into the variable "IdOfNewBooking"

  Scenario Outline: Updates a current booking
    * I update the booking with id "${IdOfNewBooking}" and save response into the variable "responseAfterUpdate"
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    * I get the response "responseAfterUpdate" and check status code, expected result = "<code>"
    * I check parameters in the response "responseAfterUpdate"
      | firstname             | <firstname>       |
      | lastname              | <lastname>        |
      | totalprice            | <totalprice>      |
      | depositpaid           | <depositpaid>     |
      | bookingdates.checkin  | <checkin>         |
      | bookingdates.checkout | <checkout>        |
      | additionalneeds       | <additionalneeds> |

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | code |
      | Geoffrey  | Brown    | 1012       | false       | 2021-09-02 | 2023-09-01 | test            | 200  |
      | Gabriel   | Jackson  | 0          | true        | 2023-03-01 | 2024-03-01 | lorem           | 200  |
