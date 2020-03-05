package sns.board.mapper;

import java.util.List;

import sns.domain.Board;
import sns.domain.Board_File;

public interface BoardMapper {
	List<String> selectFollow(String mem_email);
	List<Board> selectBoard(String mem_email);
	List<Board_File> selectBoardFile(long b_seq);
}
