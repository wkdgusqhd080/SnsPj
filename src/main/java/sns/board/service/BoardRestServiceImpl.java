package sns.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import sns.board.mapper.BoardMapper;
import sns.board.mapper.BoardRestMapper;
import sns.domain.Board_Reply;
import sns.vo.BoardReplyListResult;
import sns.vo.BoardReplyPagingVo;

@Log4j
@Service
public class BoardRestServiceImpl implements BoardRestService {

	@Autowired
	BoardRestMapper boardRestMapper;
	@Autowired
	BoardMapper boardMapper;

	@Override
	public BoardReplyListResult getBoardReplyListResult(long cp, long b_seq) {
		long ps = 5;
		Map<String, Object> map = getPagingVo(cp, ps, b_seq);
		List<Board_Reply> board_reply_list = boardRestMapper.selectBoardReply(map);
		board_reply_list = setProfileBoardReplyList(board_reply_list);
		return new BoardReplyListResult(cp, ps, boardRestMapper.selectBoardReplyCount(b_seq), board_reply_list);
	}
	
	
	private Map<String, Object> getPagingVo(long cp, long ps, long b_seq) {
		Map<String, Object> map = new HashMap<String, Object>();
		BoardReplyPagingVo pagingVo = new BoardReplyPagingVo(cp, ps);
		map.put("b_seq", b_seq); 
		map.put("startRow", pagingVo.getStartRow()); 
		map.put("endRow", pagingVo.getEndRow());
		return map;
	}
	
	private List<Board_Reply> setProfileBoardReplyList(List<Board_Reply> board_reply_list) {
		if(board_reply_list.size() != 0) {
			for(Board_Reply board_reply : board_reply_list) {
				String mem_profile = boardMapper.selectMemberProfile(board_reply.getMem_email());
				board_reply.setMem_profile(mem_profile);
			}
		}
		return board_reply_list;
	}
	
	@Override
	public BoardReplyListResult insertBoardReplyS(long b_seq, String mem_email, String brp_content) {
		Board_Reply board_reply = new Board_Reply(-1, brp_content, null, mem_email, b_seq, null);
		boardRestMapper.insertBoardReply(board_reply);
		long cp = 1; long ps = 5;
		Map<String, Object> map = getPagingVo(cp, ps, b_seq);
		List<Board_Reply> board_reply_list = boardRestMapper.selectBoardReply(map);		
		board_reply_list = setProfileBoardReplyList(board_reply_list);
		return new BoardReplyListResult(cp, ps, boardMapper.selectBoardReplyCount(b_seq), board_reply_list);
	}

}
