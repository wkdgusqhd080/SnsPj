package sns.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import sns.board.mapper.BoardMapper;
import sns.domain.Board;
import sns.domain.Board_File;
import sns.domain.Board_Like;
import sns.domain.Follow;
import sns.domain.Member;
import sns.vo.BoardLikeVo;
import sns.vo.BoardListResult;
import sns.vo.BoardPagingVo;
import sns.vo.InsertBoardVo;
import sns.vo.UserSearchListResult;

@Service
@Log4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public BoardListResult getBoardListResult(long cp, long ps, String mem_email) {
		BoardPagingVo boardPagingVo = new BoardPagingVo(cp, ps);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_email", mem_email);
		map.put("startRow", boardPagingVo.getStartRow());
		map.put("endRow", boardPagingVo.getEndRow());

		List<Board> boardList = new ArrayList<Board>();
		boardList = boardMapper.selectBoard(map);
		boardList = setBoardList(boardList);
	    //log.info("#boardList: " + boardList);
		return new BoardListResult(cp, ps, boardMapper.selectBoardTotalCount(mem_email), boardList);
	}
	
	private List<Board> setBoardList(List<Board> boardList) {
		for(Board b : boardList) {
			String mem_profile = boardMapper.selectMemberProfile(b.getMem_email());
			b.setMem_profile(mem_profile);
			long board_like_count = boardMapper.selectBoardLikeCount(b.getB_seq());
			b.setBoard_like_count(board_like_count);
			long board_reply_count = boardMapper.selectBoardReplyCount(b.getB_seq());
			b.setBoard_reply_count(board_reply_count);
			
			List<Board_Like> board_like_list = boardMapper.selectBoardLike(b.getB_seq());
				for(Board_Like board_like : board_like_list) {
					String board_like_mem_profile = boardMapper.selectMemberProfile(board_like.getMem_email());
					board_like.setMem_profile(board_like_mem_profile);
				}
					if(board_like_list.size() != 0) {
							b.setBoard_like_list(board_like_list);
					}
			List<Board_File> board_file_list = boardMapper.selectBoardFile(b.getB_seq());
				List<Board_File> board_file_list2 = new ArrayList<Board_File>();
				
				for(Board_File board_file : board_file_list) {
					if(board_file.getB_seq() == b.getB_seq()) {
						board_file_list2 = board_file_list;
					}
				}
					if(board_file_list2.size() != 0) {
						b.setBoard_file_list(board_file_list2);
					}
				
		}//for
		return boardList;

	}
	

	@Override
	public BoardLikeVo likePlusMinus(long b_seq, String mem_email, String cmd) {
		Board_Like board_like = new Board_Like(mem_email, b_seq, null);
		if(cmd.equals("minus")) {//minus
			boardMapper.deleteBoardLike(board_like);
			return getBoardLikeVo(b_seq);
		}else if(cmd.equals("plus")){//plus
			boardMapper.insertBoardLike(board_like);
			return getBoardLikeVo(b_seq);
		}else {
			return getBoardLikeVo(b_seq);
		}
	}
	
	private BoardLikeVo getBoardLikeVo(long b_seq) {
		long board_like_count = boardMapper.selectBoardLikeCount(b_seq);
		List<Board_Like> board_like_list = boardMapper.selectBoardLike(b_seq);
		for(Board_Like board_like : board_like_list) {
			String board_like_mem_profile = boardMapper.selectMemberProfile(board_like.getMem_email());
			board_like.setMem_profile(board_like_mem_profile);
		}
		return new BoardLikeVo(b_seq, board_like_count, board_like_list);
	}

	@Override
	public UserSearchListResult getUserSearchListResult(String keyword, String mem_email) {
		List<Member> member_list = boardMapper.selectUser(keyword);
		List<Follow> follow_list = boardMapper.selectFollow(mem_email);
		return new UserSearchListResult(member_list, follow_list);
	}

	@Override
	public void insertFollowingS(Follow follow) {
//		log.info("팔로잉 "+follow.getMem_email());
//		log.info("팔로잉 "+follow.getFlr_email());
		boardMapper.insertFollowing(follow);
	}

	@Override
	public void deleteFollowingS(Follow follow) {
//		log.info("언팔 " + follow.getMem_email());
//		log.info("언팔 " + follow.getFlr_email());
		boardMapper.deleteFollowing(follow);
	}

	@Override
	@Transactional
	public BoardListResult insertBoardS(InsertBoardVo insertBoardVo) {
		boardMapper.insertBoard(new Board(-1, insertBoardVo.getB_content(), insertBoardVo.getMem_email(),
								null, null, -1, null, null, -1));
		
		long b_seq = boardMapper.selectBoardSeqCurrval();//log.info("#b_seq: " + b_seq);

		for (int i=0; i<insertBoardVo.getOfilelist().length; i++) {
			if(insertBoardVo.getOfilelist()[i] != "") {
			log.info("#getOflielist : " + insertBoardVo.getOfilelist()[i]);
			boardMapper.insertBoardFile(new Board_File(-1, insertBoardVo.getOfilelist()[i],
					insertBoardVo.getFilelist()[i], insertBoardVo.getSizelist()[i]+"byte" , b_seq));
			}
		}
		
		long cp = 1; long ps = 3;
		BoardPagingVo boardPagingVo = new BoardPagingVo(cp, ps);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_email", insertBoardVo.getMem_email());
		map.put("startRow", boardPagingVo.getStartRow());
		map.put("endRow", boardPagingVo.getEndRow());
		
		List<Board> boardList = new ArrayList<Board>();
		boardList = boardMapper.selectMyBoard(map);
		boardList = setBoardList(boardList);
		
		return new BoardListResult(cp, ps, boardMapper.selectMyBoardTotalCount(insertBoardVo.getMem_email()), boardList);
	}

	@Override
	public BoardListResult getMyBoardListResult(long cp, long ps, String mem_email) {
		BoardPagingVo boardPagingVo = new BoardPagingVo(cp, ps);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("mem_email", mem_email);
		map.put("startRow", boardPagingVo.getStartRow());
		map.put("endRow", boardPagingVo.getEndRow());

		List<Board> boardList = new ArrayList<Board>();
		boardList = boardMapper.selectMyBoard(map);
		boardList = setBoardList(boardList);
	    //log.info("#boardList: " + boardList);
		return new BoardListResult(cp, ps, boardMapper.selectMyBoardTotalCount(mem_email), boardList);
	}

	@Override
	public Member selectMemberS(String mem_email) {
		return boardMapper.selectMember(mem_email);
	}

	@Override
	public void updateProfileImageS(String mem_email, String mem_profile) {
		boardMapper.updateProfileImage(new Member(mem_email, null, null, mem_profile, -1));
	}

}
