package sns.board.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import sns.domain.Follow;
import sns.domain.Member;
import sns.vo.BoardLikeVo;
import sns.vo.BoardListResult;
import sns.vo.InsertBoardVo;
import sns.vo.UserSearchListResult;

public interface BoardService {
	BoardListResult getBoardListResult(long cp, long ps, String mem_email);
	BoardLikeVo likePlusMinus(long b_seq, String mem_email, String cmd);
	UserSearchListResult getUserSearchListResult(String keyword, String mem_email);
	void insertFollowingS(Follow follow);
	void deleteFollowingS(Follow follow);
	BoardListResult insertBoardS(InsertBoardVo insertBoardVo);
	BoardListResult getMyBoardListResult(long cp, long ps, String mem_email);
	Member selectMemberS(String mem_email);
	void updateProfileImageS(String mem_email, String mem_profile);
}
