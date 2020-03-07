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
		}
		
		List<List<Board_File>> board_file_List = new ArrayList<List<Board_File>>();
			if(boardList.size() != 0) {
				for(Board b : boardList) {
					List<Board_File> board_file_list = boardMapper.selectBoardFile(b.getB_seq());
						if(board_file_list.size() != 0) {
							board_file_List.add(board_file_list);
						}
				}
			}
				log.info("#boardList: " + boardList);
				log.info("#board_file_List: " + board_file_List);
		return new BoardListResult(cp, ps, boardMapper.selectBoardTotalCount(mem_email), boardList, board_file_List);
	}

}
