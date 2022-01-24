@all
Feature: Updates a current booking with a partial payload

  Background:
    * I create the booking and save response into the variable "responseAfterCreate"
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Felix     | Garcia   | 9999       | true        | 2022-03-01 | 2023-03-01 | nothing         |
    * I get the response "responseAfterCreate" and check status code, expected result = "200"
    * I parse the response "responseAfterCreate" with JsonPath "bookingid" and save into the variable "IdOfNewBooking"

  Scenario Outline: Partial update a current booking with a different Json
    * I do partial update for booking with id "${IdOfNewBooking}" body like the file "<fileName>" and save response into the variable "responseAfterPartialUpdate"
    * I get the response "responseAfterPartialUpdate" and check status code, expected result = "<code>"
    * I check parameters in the response "responseAfterPartialUpdate"
      | <firstPath>  | <firstER>  |
      | <secondPath> | <secondER> |
      | <thirdPath>  | <thirdER>  |
    Examples: Success
      | fileName                      | code | firstPath | firstER | secondPath | secondER | thirdPath  | thirdER |
      | firstName,lastName            | 200  | firstname | John    | lastname   | Doe      | totalprice | 9999    |
      | firstName,lastName,totalPrice | 200  | firstname | Jim     | lastname   | Jim      | totalprice | 1111    |

  Scenario Outline: Partial update a current booking with spoiled Json
    * I do partial update for booking with id "${IdOfNewBooking}" body like the file "<fileName>" and save response into the variable "responseAfterPartialUpdate"
    * I get the response "responseAfterPartialUpdate" and check status code, expected result = "<code>"
    Examples:
      | fileName | code |
      | badJson  | 400  |