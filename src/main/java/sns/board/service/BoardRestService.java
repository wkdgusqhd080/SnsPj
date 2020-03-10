package sns.board.service;

import sns.vo.BoardReplyListResult;

public interface BoardRestService {
	BoardReplyListResult getBoardReplyListResult(long cp, long b_seq);
}
