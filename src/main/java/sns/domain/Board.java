package sns.domain;

import lombok.NoArgsConstructor;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
	private long b_seq;
	private String b_content;
	private String mem_email;
	private java.sql.Date b_rdate;
}