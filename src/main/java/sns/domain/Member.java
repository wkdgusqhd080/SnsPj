package sns.domain;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private String mem_email;
	private String mem_pwd;
	private java.sql.Date mem_rdate;
	private String mem_profile;
	private long mem_state;
}
