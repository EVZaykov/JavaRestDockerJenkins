@all
@severity=blocker
Feature: Returns a specific booking based upon the booking id provided

  Scenario Outline: Create booking -> Get booking
    * I create the booking and save response into the variable "responseAfterCreate"
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    * I get the response "responseAfterCreate" and check status code, expected result = "200"
    * I check headers in the response "responseAfterCreate" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I parse the response "responseAfterCreate" with JsonPath "bookingid" and save into the variable "IdOfNewBooking"
    * I get the booking by id "<bookingId>" and save the response into the variable "responseAfterGet"
    * I get the response "responseAfterGet" and check status code, expected result = "<code>"
    * I check parameters in the response "responseAfterGet"
      | firstname             | <firstname>       |
      | lastname              | <lastname>        |
      | totalprice            | <totalprice>      |
      | depositpaid           | <depositpaid>     |
      | bookingdates.checkin  | <checkin>         |
      | bookingdates.checkout | <checkout>        |
      | additionalneeds       | <additionalneeds> |
    * I check headers in the response "responseAfterGet" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | bookingId         | code |
      | Ethan     | Reed     | 999        | false       | 2022-03-01 | 2023-03-01 | car             | ${IdOfNewBooking} | 200  |

  Scenario Outline: Delete a booking with wrong ID
    * I get the booking by id "<bookingId>" and save the response into the variable "responseAfterGet"
    * I get the response "responseAfterGet" and check status code, expected result = "<code>"
    * I check headers in the response "responseAfterGet" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |

    Examples:
      | bookingId | code |
      | -1        | 404  |
      | 99999999  | 404  |