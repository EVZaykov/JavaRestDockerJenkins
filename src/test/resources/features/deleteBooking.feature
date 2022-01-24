@all
@severity=critical
Feature: Delete a booking

  Scenario Outline: Delete a booking with valid ID
    * I create the booking and save response into the variable "responseAfterCreate"
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Graham    | Davis    | 8250       | true        | 2022-03-01 | 2022-04-02 | nothing         |
    * I get the response "responseAfterCreate" and check status code, expected result = "200"
    * I check headers in the response "responseAfterCreate" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I parse the response "responseAfterCreate" with JsonPath "bookingid" and save into the variable "IdOfNewBooking"
    * I delete the booking with id "<bookingId>" and save the response into the variable "responseAfterDelete"
    * I check headers in the response "responseAfterDelete" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I get the response "responseAfterDelete" and check status code, expected result = "<statusCodeAfterDelete>"
    * I get the booking by id "<bookingId>" and save the response into the variable "responseAfterGet"
    * I check headers in the response "responseAfterGet" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I get the response "responseAfterGet" and check status code, expected result = "<statusCodeAfterGet>"

    Examples:
      | bookingId         | statusCodeAfterDelete | statusCodeAfterGet |
      | ${IdOfNewBooking} | 201                   | 404                |


  Scenario Outline: Delete a booking with wrong ID
    * I delete the booking with id "<bookingId>" and save the response into the variable "responseAfterDelete"
    * I get the response "responseAfterDelete" and check status code, expected result = "<statusCodeAfterDelete>"
    * I check headers in the response "responseAfterDelete" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |

    Examples:
      | bookingId | statusCodeAfterDelete |
      | -1        | 405                   |


