@all
@severity=critical
@known
Feature: Returns the ids of all the bookings that exist within the API. Can take optional query strings to search and return a subset of booking ids.




    Scenario Outline: Get Booking Ids with filter by firstname and lastname
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I check headers in the response "responseAfterCreate" with regular expression
        | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
        | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I check headers in the response "responseAfterCreate" with regular expression
        | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
        | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
      * I get the response "responseAfterCreate" and check status code, expected result = "200"
      * I get booking with parameters and save response into the variable "responseAfterGet"
        | firstname | <firstname> |
        | lastname  | <lastname>  |
      * I check headers in the response "responseAfterGet" with regular expression
        | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
        | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
      * I parse the response "responseAfterGet" with JsonPath "bookingid"and save into the variable "IdOfNewBooking"
      * I get the booking by id "<bookingId>" and check status code, expected code = "<code>", parameters
        | firstname | <firstname> |
        | lastname  | <lastname>  |

      Examples:
        | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | code | bookingId      |
        | Alex      | Moore    | 890        | true        | 2020-01-02 | 2024-02-02 | flat            | 200  | IdOfNewBooking |

    Scenario Outline: Get Booking Ids with filter by firstname
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I get the response "responseAfterCreate" and check status code, expected result = "200"
      * I get booking with parameters and save response into the variable "responseAfterGet"
        | firstname | <firstname> |

      * I parse the response "responseAfterGet" with JsonPath "bookingid"and save into the variable "IdOfNewBooking"
      * I get the booking by id "<bookingId>" and check status code, expected code = "<code>", parameters
        | firstname | <firstname> |

      Examples:
        | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | code | bookingId      |
        | Taylor    | Durden   | 1          | true        | 2020-01-02 | 2030-02-02 | house           | 200  | IdOfNewBooking |

    Scenario Outline: Get Booking Ids with filter by lastname
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I get the response "responseAfterCreate" and check status code, expected result = "200"
      * I get booking with parameters and save response into the variable "responseAfterGet"
        | lastname | <lastname> |
      * I parse the response "responseAfterGet" with JsonPath "bookingid"and save into the variable "IdOfNewBooking"
      * I get the booking by id "<bookingId>" and check status code, expected code = "<code>", parameters
        | lastname | <lastname> |

      Examples:
        | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | code | bookingId      |
        | Robert    | Martin   | 1011       | true        | 2020-01-02 | 2020-02-02 | test            | 200  | IdOfNewBooking |


    Scenario Outline: Get Booking Ids with filter by checkin and checkout parameters
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I get booking with parameters and save response into the variable "responseAfterGet"
        | checkin  | <checkin>  |
        | checkout | <checkout> |
      * I get the response "responseAfterGet" and check status code, expected result = "200"
      * I parse the response "responseAfterGet" with JsonPath "bookingid"and save into the variable "IdOfNewBooking"
      #Why do we compare with 2? If our expression returns true we will get checkin and checkout, after it we will use .size() for count.
      * I get the booking by id "<bookingId>" and check status code, expected code = "<code>", parameters
        | bookingdates[?(@.checkin >= '<checkin>' && @.checkout >= '<checkout>')].size() | 2 |

      Examples:
        | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | code | bookingId      |
        | Memphis   | Depay    | 1112       | true        | 2020-01-02 | 2020-02-02 | test            | 200  | IdOfNewBooking |

    Scenario Outline: Get Booking Ids with filter by checkin
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I get booking with parameters and save response into the variable "responseAfterGet"
        | checkin | <checkin> |
      * I get the response "responseAfterGet" and check status code, expected result = "200"
      * I parse the response "responseAfterGet" with JsonPath "bookingid"and save into the variable "IdOfNewBooking"
      #Why do we compare with 2? If our expression returns true we will get checkin and checkout, after it we will use .size() for count.
      * I get the booking by id "<bookingId>" and check status code, expected code = "<code>", parameters
        | $..bookingdates[?(@.checkin >= '<checkin>')].size() | 2 |

      Examples:
        | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | code | bookingId      |
        | Matthijs  | de Ligt  | 11112      | true        | 2019-01-02 | 2020-02-02 | test            | 200  | IdOfNewBooking |

    Scenario Outline: Get Booking Ids with filter by checkout
      * I create the booking and save response into the variable "responseAfterCreate"
        | firstname   | lastname   | totalprice   | depositpaid   | checkin   | checkout   | additionalneeds   |
        | <firstname> | <lastname> | <totalprice> | <depositpaid> | <checkin> | <checkout> | <additionalneeds> |
      * I get booking with parameters and save response into the variable "responseAfterGet"
        | checkout | <checkout> |
      * I get the response "responseAfterGet" and check status code, expected result = "200"
      * I parse the response "responseAfterGet" with JsonPath "bookingid"and save into the variable "IdOfNewBooking"
      #Why do we compare with 2? If our expression returns true we will get checkin and checkout, after it we will use .size() for count.
      * I get the booking by id "<bookingId>" and check status code, expected code = "<code>", parameters
        | $..bookingdates[?(@.checkout >= '<checkout>')].size() | 2 |

      Examples:
        | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | code | bookingId      |
        | Ruud      | Vormer   | 1112       | true        | 1999-01-02 | 1999-02-02 | test            | 200  | IdOfNewBooking |

  Scenario:Get all booking ids without filters and count  booking.Get booking ids with filter by checkin with 0000-01-01 and count booking. After this I compare them.
    * I get ids of all the bookings and save the response into the variable "responseAfterGetAll"
    * I check headers in the response "responseAfterGetAll" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I get the response "responseAfterGetAll" and check status code, expected result = "200"
    * I parse the response "responseAfterGetAll" with JsonPath "bookingid"and save into the variable "IdsOfAllBooking"
    * I count elements in ArrayList "IdsOfAllBooking" and save it into the variable "countBookingAfterGetAll"
    * I get booking with parameters and save response into the variable "responseGetWithFilter"
      | checkin | 0000-01-01 |
    * I get the response "responseGetWithFilter" and check status code, expected result = "200"
    * I check headers in the response "responseGetWithFilter" with regular expression
      | Etag | ^W\/"[\w]*-[\w\s\W]*"                             |
      | Date | [\w]{3},\s[\d]{2}\s[\w]{3}\s202[\d]\s[\d:]+\sGMT$ |
    * I parse the response "responseGetWithFilter" with JsonPath "bookingid"and save into the variable "IdsBookingAfterFilter"
    * I count elements in ArrayList "IdsBookingAfterFilter" and save it into the variable "countBookingAfterGetWithFilter"
    * I compare two variables "countBookingAfterGetAll" and "countBookingAfterGetWithFilter"
