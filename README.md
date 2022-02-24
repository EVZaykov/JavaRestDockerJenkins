# Test Automation
Tech Stack: Java, Maven, Junit, Rest Assured, Cucumber, Allure.

Installation (pre-requisites)
-----------------------------
1. JDK 1.8+ (make sure Java class path is set)
2. Maven (make sure .m2 class path is set)
3. IDE (Eclipse, IntelliJ, etc)
4. Plugin - Cucumber for java

Setup Instructions
--------------
Clone the repo from below command or download zip and set it up in your local workspace.
```
git clone https://github.com/EVZaykov/JavaRestDockerJenkins.git
```

Running Test
------------
Go to your project directory from terminal and hit following commands
```
mvn clean test "-Dcucumber.options=-t @all"; mvn allure:serve

```
Optional arguments for maven command
------------------------------------
| Argument          | Description                                           | Default value                         |Example                      |
| ------------------| -------------                                         |---------------------------------------|-----------------------------|
| ENV               | set baseUri                                           | https://restful-booker.herokuapp.com  | "-DENV=https://dev-env.com" |
| USERNAME          | username                                              | admin                                 | "-DUSERNAME=anotherUser"    |
| PASSWORD          | password                                              | password123                           | "-PASSWORD=anotherPassword" |
| cucumber.options  | all cucumber options                                  |-                                      | "-Dcucumber.options=-t @all"|
| allure:serve      | Generates report and opens it in the default browser  |-                                      | allure:serve

PowerShell/Zsh Example: mvn clean test "-DUSERNAME=admin" "-DPASSWORD=password123" "-DENV=https://restful-booker.herokuapp.com" "-Dcucumber.options=-t @all"; mvn allure:serve 

Advantages
----------
- Cucumber.
- Very informative report.
- Launch automation scripts on different environment and user.
- Unlimited threads but not more than feature files.
- Reusable steps.
- If you have failed automation scripts it will be relaunched and added into Allure report into "Retries" tab.

Comments
--------
- If the tests stop running, don't worry, tests for checking filters are most likely running, sometimes it takes more than 100 requests to do this.
- If we use CI/CD tool, Allure report will be more informative.
- Library allure-cucumber4-jvm is using Slf4j. Slf4j is using Log4j, Slf4j was excluded. A new version slf4j with log4j2 was added.
- Apache Log4j 2 is an upgrade to Log4j that provides significant improvements over its predecessor, Log4j 1.x, and provides many of the improvements available in Logback while fixing some inherent problems in Logback’s architecture.





