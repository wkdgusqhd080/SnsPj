package sns.domain;

import lombok.NoArgsConstructor;

import java.util.Comparator;
import java.util.List;

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
	private String mem_profile;//vo
	private long board_like_count;//vo
	List<Board_Like> board_like_list;//vo
}