package config;

import lombok.Getter;

import java.nio.file.Path;
import java.nio.file.Paths;

@Getter
public class TestConfig {

    String username = System.getProperty("USERNAME") == null ? "admin" : System.getProperty("USERNAME");
    String password = System.getProperty("PASSWORD") == null ? "password123" : System.getProperty("PASSWORD");
    String baseUri = System.getProperty("ENV") == null ? "https://restful-booker.herokuapp.com" : System.getProperty("ENV");
    String basePath = "/booking";
    Path pathToJson = Paths.get("src/test/resources/jsonTemplates/partialUpdates/%s.json");
}
