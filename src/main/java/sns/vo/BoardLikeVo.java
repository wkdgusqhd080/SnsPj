package sns.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import sns.domain.Board;
//import sns.domain.Board_File;
import sns.domain.Board_Like;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardLikeVo {
	private long b_seq;
	private long board_like_count;
	private List<Board_Like> board_like_list;
}
