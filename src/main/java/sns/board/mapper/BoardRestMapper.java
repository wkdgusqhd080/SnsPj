package sns.board.mapper;


import java.util.List;
import java.util.Map;

import sns.domain.Board_Reply;

public interface BoardRestMapper {
	List<Board_Reply> selectBoardReply(Map map);
	long selectBoardReplyCount(long b_seq);
}
