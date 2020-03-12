package sns.board.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;

import sns.domain.Board_Reply;

public interface BoardRestMapper {
	List<Board_Reply> selectBoardReply(Map map);
	long selectBoardReplyCount(long b_seq);
	
	
	@Insert(value= {"insert into BOARD_REPLY (BRP_SEQ, BRP_CONTENT, BRP_RDATE, MEM_EMAIL, B_SEQ) values(BOARD_REPLY_SEQ.nextval, #{brp_content}, SYSDATE, #{mem_email}, #{b_seq})"})
	void insertBoardReply(Board_Reply board_reply);
	//@Select(value= {"select BOARD_REPLY_SEQ.nextval from DUAL"})
	//long selectBoardReplyNextSeq()
}
