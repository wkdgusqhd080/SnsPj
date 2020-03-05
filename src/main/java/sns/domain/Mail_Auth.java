package sns.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Mail_Auth {
	private String mem_email;
	private String mail_authkey;
}
