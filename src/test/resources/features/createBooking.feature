@all
@severity=blocker
Feature: Creates a new booking in the API

  Scenario Outline: Create a booking with different values
    * I create the booking and save response into the variable "responseAfterCreate"
      | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
      | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
    * I get the response "responseAfterCreate" and check status code, expected result = "<statusCode>"
    * I check parameters in the response "responseAfterCreate"
      | booking.firstname             | <firstname>       |
      | booking.lastname              | <lastname>        |
      | booking.totalprice            | <totalprice>      |
      | booking.depositpaid           | <depositpaid>     |
      | booking.bookingdates.checkin  | <checkin>         |
      | booking.bookingdates.checkout | <checkout>        |
      | booking.additionalneeds       | <additionalneeds> |

    * I check headers in the response "responseAfterCreate" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | statusCode |
      | Abraham   | Smith    | 1200       | false       | 2022-02-01 | 2022-03-01 | Need TV         | 200        |
      | Adam      | Williams | 1500       | true        | 2023-01-01 | 2023-02-01 | Need Internet   | 200        |
