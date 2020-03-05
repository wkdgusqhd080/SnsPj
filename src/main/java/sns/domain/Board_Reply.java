package sns.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board_Reply {
	private long brp_seq;
	private String brp_content;
	private java.sql.Date brp_rdate;
	private String mem_email;
	private long b_seq;
}