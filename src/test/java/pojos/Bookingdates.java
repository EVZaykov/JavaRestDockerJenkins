package pojos;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

@Data
@ToString
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
public class Bookingdates {

    private String checkin;
    private String checkout;
}
