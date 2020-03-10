package sns.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import sns.board.mapper.BoardMapper;
import sns.domain.Board;
import sns.domain.Board_File;
import sns.domain.Board_Like;
import sns.vo.BoardListResult;
import sns.vo.BoardPagingVo;

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
		
		for(Board b : boardList) {
			String mem_profile = boardMapper.selectMemberProfile(b.getMem_email());
			b.setMem_profile(mem_profile);
			long board_like_count = boardMapper.selectBoardLikeCount(b.getB_seq());
			b.setBoard_like_count(board_like_count);
			
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
				
		}
				log.info("#boardList: " + boardList);
		return new BoardListResult(cp, ps, boardMapper.selectBoardTotalCount(mem_email), boardList);
	}

	@Override
	public boolean likePlusMinus(long b_seq, String mem_email, String cmd) {
		// TODO Auto-generated method stub
		return false;
	}

}
