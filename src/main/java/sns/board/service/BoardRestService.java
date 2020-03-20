package sns.board.service;

import sns.vo.BoardReplyListResult;

public interface BoardRestService {
	BoardReplyListResult getBoardReplyListResult(long cp, long b_seq);
	BoardReplyListResult insertBoardReplyS(long b_seq, String mem_email, String brp_content);
	BoardReplyListResult updateBoardReplyS(long b_seq, long brp_seq, String brp_content, long cp);
	BoardReplyListResult deleteBoardReplyS(long b_seq, long brp_seq, long cp);
}
