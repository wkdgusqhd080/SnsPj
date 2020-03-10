package sns.board.service;

import sns.vo.BoardLikeVo;
import sns.vo.BoardListResult;
import sns.vo.BoardPagingVo;

public interface BoardService {
	BoardListResult getBoardListResult(long cp, long ps, String mem_email);
	BoardLikeVo likePlusMinus(long b_seq, String mem_email, String cmd);
}
