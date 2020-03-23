package sns.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import sns.domain.Board;
import sns.domain.Board_File;
import sns.domain.Board_Like;
import sns.domain.Board_Reply;
import sns.domain.Follow;
import sns.domain.Member;

public interface BoardMapper {
	List<Board> selectBoard(Map map);
	List<Board_File> selectBoardFile(long b_seq);
	List<Board_Reply> selectBoardReply(Map map);
	String selectMemberProfile(String mem_email);
	long selectBoardTotalCount(String mem_email);
	long selectBoardLikeCount(long b_seq);
	List<Board_Like> selectBoardLike(long b_seq);
	Board_Like selectBoardLikeUser(Board_Like board_like);
	void insertBoardLike(Board_Like board_like);
	void deleteBoardLike(Board_Like board_like);
	long selectBoardReplyCount(long b_seq);
	List<Member> selectUser(String keyword);
	List<Follow> selectFollow(String mem_email);
	void deleteFollowing(Follow follow);
	void insertFollowing(Follow follow);
	
	@Insert(value= {"insert into BOARD (B_SEQ, B_CONTENT, MEM_EMAIL, B_RDATE) values (BOARD_SEQ.nextval, #{b_content}, #{mem_email}, SYSDATE)"})
	void insertBoard(Board board);
	
	@Insert(value= {"insert into BOARD_FILE (BF_SEQ, BF_OFNAME, BF_FNAME, BF_SIZE, B_SEQ) values (BOARD_FILE_SEQ.nextval, #{bf_ofname}, #{bf_fname}, #{bf_size}, #{b_seq}"})
	void insertBoardFile(Board_File board_file);
	
	@Select(value= {"select BOARD_SEQ.currval from DUAL"})
	long selectBoardSeqCurrval();
	
	@Select(value = {"select * from (select ROWNUM rnum, board.* from "
			+ "(select * from BOARD where MEM_EMAIL = #{mem_email} order by B_RDATE desc) board) "
			+ "where rnum > #{startRow} and rnum <= #{endRow} and board.MEM_EMAIL = #{mem_email}"})
	List<Board> selectMyBoard(Map map);
	
	@Select(value = {"select count(*) from BOARD where mem_email = #{mem_email} order by b_rdate desc"})
	long selectMyBoardTotalCount(String mem_email);
}
