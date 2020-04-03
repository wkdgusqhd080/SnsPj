package sns.domain;

import lombok.NoArgsConstructor;

import java.util.Comparator;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
	private long b_seq;
	private String b_content;
	private String mem_email;
	//private java.sql.Date b_rdate;
	private String b_rdate;
	private String mem_profile;//vo
	private long board_like_count;//vo
	List<Board_Like> board_like_list;//vo
	List<Board_File> board_file_list;//vo
	private long board_reply_count;//vo
}