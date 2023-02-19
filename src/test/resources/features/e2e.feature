@smoke
@all
Feature: E2E for booking

  Scenario: Create -> Get -> Partial Update -> Update -> Delete.
    * I create the booking and save response into the variable "responseAfterCreate"
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Harry     | Morgan   | 800        | true        | 2022-03-01 | 2023-03-01 | dvd             |
    * I get the response "responseAfterCreate" and check status code, expected result = "200"
    * I check headers in the response "responseAfterCreate" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I check parameters in the response "responseAfterCreate"
      | booking.firstname             | Harry      |
      | booking.lastname              | Morgan     |
      | booking.totalprice            | 800        |
      | booking.depositpaid           | true       |
      | booking.bookingdates.checkin  | 2022-03-01 |
      | booking.bookingdates.checkout | 2023-03-01 |
      | booking.additionalneeds       | dvd        |
    * I parse the response "responseAfterCreate" with JsonPath "bookingid" and save into the variable "IdOfNewBooking"
    * I get the booking by id "${IdOfNewBooking}" and save the response into the variable "responseAfterGet"
    * I check headers in the response "responseAfterGet" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I get the response "responseAfterGet" and check status code, expected result = "200"
    * I check parameters in the response "responseAfterGet"
      | firstname             | Harry      |
      | lastname              | Morgan     |
      | totalprice            | 800        |
      | depositpaid           | true       |
      | bookingdates.checkin  | 2022-03-01 |
      | bookingdates.checkout | 2023-03-01 |
      | additionalneeds       | dvd        |
    * I do partial update for booking with id "${IdOfNewBooking}" body like the file "firstName,lastName" and save response into the variable "responseAfterPartialUpdate"
    * I check headers in the response "responseAfterPartialUpdate" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I check parameters in the response "responseAfterPartialUpdate"
      | firstname | John |
      | lastname  | Doe  |
    * I update the booking with id "${IdOfNewBooking}" and save response into the variable "responseAfterUpdate"
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Horace    | Sanchez  | 2221       | false       | 2000-03-01 | 2030-03-01 | hi              |
    * I check headers in the response "responseAfterUpdate" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I check parameters in the response "responseAfterUpdate"
      | firstname             | Horace     |
      | lastname              | Sanchez    |
      | totalprice            | 2221       |
      | depositpaid           | false      |
      | bookingdates.checkin  | 2000-03-01 |
      | bookingdates.checkout | 2030-03-01 |
      | additionalneeds       | hi         |
    * I delete the booking with id "${IdOfNewBooking}" and save the response into the variable "responseAfterDelete"
    * I get the response "responseAfterDelete" and check status code, expected result = "201"
    * I check headers in the response "responseAfterDelete" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |









