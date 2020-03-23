package sns.board.controller;



import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import sns.board.service.BoardService;
import sns.domain.Follow;
import sns.domain.Member;
import sns.vo.BoardLikeVo;
import sns.vo.BoardListResult;
import sns.vo.BoardPagingVo;
import sns.vo.InsertBoardVo;

@Log4j
@RequestMapping("board")
@Controller
@AllArgsConstructor
public class BoardController {
	
	BoardService boardService;

	final long PS = 3;
	
	@RequestMapping(value = "list.do", method = RequestMethod.GET)
	public String boardList(HttpSession session, Model model, String mem_email) {
		long cp = 1;
		Member m = (Member)session.getAttribute("loginUser");
		mem_email = m.getMem_email();
		BoardListResult boardListResult = boardService.getBoardListResult(cp, PS, mem_email);
		model.addAttribute("boardListResult", boardListResult);
		return "board/list";
	}
	@GetMapping("infinityList.do")
	@ResponseBody
	public BoardListResult infinityList(long cp, HttpSession session) {
		String mem_email = getClientEmail(session);
		return boardService.getBoardListResult(cp, PS, mem_email);
	}
	
	
	@PostMapping("likeAjax.do")
	@ResponseBody
	public BoardLikeVo likeAjax(String str) {
		String[] strs = str.split(",");
		String cmd = strs[0];
		String b_seqStr = strs[1]; long b_seq = Integer.parseInt(b_seqStr);
		String mem_email = strs[2]; //log.info("#cmd: " + cmd);
		BoardLikeVo boardLikeVo = boardService.likePlusMinus(b_seq, mem_email, cmd);
		return boardLikeVo;
	}
	
	@RequestMapping(value ="searchList.do", method=RequestMethod.GET)
	public ModelAndView boardSearch(String keyword, HttpSession session) {
		String mem_email = getClientEmail(session);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/search_list");
		mv.addObject("userSearchListResult", boardService.getUserSearchListResult(keyword, mem_email));
		return mv;
	}
	
	private String getClientEmail(HttpSession session) {
		Member m = (Member)session.getAttribute("loginUser");
		String mem_email = m.getMem_email();
		return mem_email;
	}
	
	@RequestMapping(value="follow.do", method=RequestMethod.POST)
	@ResponseBody
	public String userFollow(@RequestBody String flr_email, HttpSession session) {
		String mem_email = getClientEmail(session);
		boardService.insertFollowingS(new Follow(flr_email, mem_email));
		return "follow";
	}
	@RequestMapping(value="unfollow.do", method=RequestMethod.POST)
	@ResponseBody
	public String userUnfollow(@RequestBody String flr_email, HttpSession session) {
		String mem_email = getClientEmail(session);
		boardService.deleteFollowingS(new Follow(flr_email, mem_email));
		return "unfollow";
	}
	@RequestMapping(value="/board_create_form.do", method=RequestMethod.GET)
	public String boardCreateForm() {
		return "board/create_form";
	}
	@RequestMapping(value="fileUpload.do")
	public void fileUpload(Model model, HttpServletResponse response, HttpServletRequest request, @RequestParam("Filedata") MultipartFile Filedata) {
	   	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	   	String newfilenameTime = df.format(new Date()) + Integer.toString((int) (Math.random()*10));
	   	
	   	String ofname = Filedata.getOriginalFilename();
	   	StringBuffer sb = new StringBuffer();
	   	sb.append(newfilenameTime); sb.append("_"); sb.append(ofname);  
	   	
		File f = new File(FilePath.FILE_STORE + sb.toString());

		try { 
			Filedata.transferTo(f);
		   	response.getWriter().write(sb.toString());
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("")
	
	@PostMapping("boardUpload.do")
	public String boardUpload(HttpServletRequest request, HttpSession session, Model model) {
		String mem_email = getClientEmail(session);
		String b_content = request.getParameter("b_content");
		String filename = request.getParameter("filename");
		String realname = request.getParameter("realname");
		String filesize = request.getParameter("filesize");
    	String[] sizelist = realname.split(",");//파일사이즈
    	String[] ofilelist = filename.split(",");//오리지날파일이름
    	String[] filelist = filesize.split(",");//저장되는파일이름
    	BoardListResult boardListResult = boardService.insertBoardS(new InsertBoardVo(mem_email, b_content, ofilelist, filelist, sizelist));
    	model.addAttribute("boardListResult", boardListResult);
    	return "board/my_board_list";
	}
	
	
	
}