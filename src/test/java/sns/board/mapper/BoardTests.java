package sns.board.mapper;

import java.util.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import sns.domain.Board;
import sns.domain.Board_File;
import sns.domain.Board_Like;
import sns.domain.Board_Reply;
import sns.domain.Member;
import sns.vo.BoardPagingVo;
import sns.vo.BoardReplyPagingVo;
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardTests {
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private BoardRestMapper boardRestMapper;
	
	/*
	@Test
	public void testList() {
		//log.info("#mentoringMapper: " + loginMapper.getClass().getName());
		String mem_email = "a@naver.com";
		//log.info("#LoginTests testList(): " + loginMapper.getMembers(mem_email));
		Member m = loginMapper.selectMember(mem_email);
		String mem_pwd = "1234";
		String pwdDb = m.getMem_pwd();
		if(pwdDb != null) pwdDb = pwdDb.trim();
		boolean hashPwd = BCrypt.checkpw(mem_pwd, m.getMem_pwd());
		if(hashPwd == false) {
			log.info("비번불일치"); //비밀번호 불일치
		}else {
			log.info("로그인성공");//로그인 성공
		}	
	}
	*/
	/*
	@Test
	public void testList() {
		//log.info("#mentoringMapper: " + loginMapper.getClass().getName());
		String mem_email = "a@naver.com";
		//String mem_email = "kk070@hanmail.net";
		//log.info("#LoginTests testList(): " + loginMapper.getMembers(mem_email));
		String m = loginMapper.selectKakaoMember(mem_email);
		if(m != null) {
			log.info("#m: " + m);
		}else {
			log.info("#m: " + m);
		}
		*/
	/*
	@Test
	public void testInsert() {
		Member m = new Member("email", null, null, "20-29", 1, null, null, 0, 0, 0);
		joinMapper.insertKakaoMember(m);
		log.info("#MemberTests insert(): 수행완료");
	}
	*/
	/*
	@Test
	public void testInsert() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String mem_email = "wkdgusqhd080@naver.com";
		int uuid = 1234;
		map.put("mem_email", mem_email);
		map.put("email_uuid", uuid);
		joinMapper.insertEmailAuth(map);
	}
	*/
	/*
	@Test
	public void selectList() {
		//log.info("#mentoringMapper: " + loginMapper.getClass().getName());
		String mem_email = "wkdgusqhd080@naver.com";
		//String mem_email = "kk070@hanmail.net";
		//log.info("#LoginTests testList(): " + loginMapper.getMembers(mem_email));
		Email_Auth email_auth = joinMapper.selectEmailAuth(mem_email);
		log.info("#email_auth: " + email_auth);
	}
*/
/*
	@Test
	public void testDelete() {
		String mem_email = "wkdgusqhd080@naver.com";
		joinMapper.deleteEmailAuth(mem_email);
		log.info("#JoinTests delete(): 수행완료");
	}
*/
	/*
	@Test
	public void testEmailCheck() {
		String mem_email = "a@naver.com";
		
		String str = mapper.selectEmailCheck(mem_email);
		switch(StringUtils.defaultString(str)) {
		case "": log.info("str1: " + str); return;
		default: log.info("str2: " + str); return;
		}
		
		//HashMap<String, Object> map = new HashMap<String, Object>();
		//map.put("mem_email", mem_email);
		//map.put("mem_gubun", 0);//0은 순수회원
		//String email = joinMapper.selectCheckEmail(map);
		
		//log.info("#email: " + email);
		
		//String mem_email = "wkdgusqhd080@naver.com";
		//String str = joinMapper.selectCheckNick(mem_email);
		//log.info("#str: " + str);
	}
	*/
	/*
	@Test
	public void boardTest() {
		long cp = 1;
		long ps = 3;
		String mem_email = "a@naver.com";
		BoardPagingVo boardPagingVo = new BoardPagingVo(cp, ps);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_email", mem_email);
		map.put("startRow", boardPagingVo.getStartRow());
		map.put("endRow", boardPagingVo.getEndRow());

		List<Board> boardList = new ArrayList<Board>();
		boardList = mapper.selectBoard(map);
		List<List<Board_File>> board_file_List = new ArrayList<List<Board_File>>();
		//List<List<Board_Reply>> board_reply_List = new ArrayList<List<Board_Reply>>();

			if(boardList.size() != 0) {
				for(Board b : boardList) {
					List<Board_File> board_file_list = mapper.selectBoardFile(b.getB_seq());
						if(board_file_list.size() != 0) {
							board_file_List.add(board_file_list);
						}
					/*
					List<Board_Reply> board_reply_list = mapper.selectBoardReply(map);
						if(board_reply_list.size() != 0) {
							board_reply_List.add(board_reply_list);
						}
					
				}
			}	
				log.info("#boardList: " + boardList);
				log.info("#board_file_List: " + board_file_List);
				//log.info("#board_reply_List: " + board_reply_List);
		}
		*/
		/*
	@Test
	public void boardLikeTest() {
		String mem_email = "a@naver.com";
		long b_seq = 5;
		Board_Like board_like = new Board_Like(mem_email, b_seq, null);
		Board_Like b_like = mapper.selectBoardLikeUser(board_like);
		
		if(b_like != null) {//게시글에 좋아요 있을 경우
			mapper.deleteBoardLike(board_like);
		}else {//게시글에 좋아요 없을 경우
			mapper.insertBoardLike(board_like);
		}
		//mapper.deleteBoardLike(board_like);
	}
	*/
	
	
	/*
	@Test
	public void boardRestTest() {
		Map<String, Object> map = new HashMap<String, Object>();
		long cp = 1; long ps = 5; long b_seq = 1;
		BoardReplyPagingVo pagingVo = new BoardReplyPagingVo(cp, ps);
		map.put("b_seq", b_seq); map.put("startRow", pagingVo.getStartRow()); map.put("endRow", pagingVo.getEndRow());
		List<Board_Reply> board_reply_list = boardRestMapper.selectBoardReply(map);
		
		
		if(board_reply_list.size() != 0) {
			for(Board_Reply board_reply : board_reply_list) {
				String mem_profile = mapper.selectMemberProfile(board_reply.getMem_email());
				board_reply.setMem_profile(mem_profile);
			}
		}
		
		log.info("#list: "+board_reply_list);
	}
	*/
	
	@Test
	public void searchUserText() {
		String mem_email = "b";
		List<Member> member_list = mapper.selectUser(mem_email);
		log.info("#member_list: " + member_list);
		
		
	}
	
		
	}
