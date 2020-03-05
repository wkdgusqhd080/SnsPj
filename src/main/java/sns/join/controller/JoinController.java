package sns.join.controller;




import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import sns.domain.Member;
import sns.join.service.JoinService;

@RequestMapping("join")
@Controller
@Log4j
public class JoinController {
	
	@Autowired
	JoinService service;
	
	@RequestMapping(value = "joinForm.do", method = RequestMethod.GET)
	public String joinForm() {
		return "join/joinForm";
	}
	
	@RequestMapping(value="emailCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public String emailCheck(@RequestBody String mem_emailStr) throws UnsupportedEncodingException{
		String decodedStr = URLDecoder.decode(mem_emailStr, "UTF-8");
		String mem_email = decodedStr.substring(0, decodedStr.length()-1);//log.info("#mem_email: " + mem_email);
		boolean flag = service.emailCheckS(mem_email);
		if(flag) return "possible";
		else return "impossible";
	}
	
	@PostMapping("joinAccess.do")
	public String joinAccess(Member member) {
		try {
			service.joinEmailAuth(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "join/join_msg";
	}
	
	@GetMapping("joinAuthConfirm.do")
	public ModelAndView joinAuthConfirm(String mail_authkey, String mem_email) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("join/auth_msg");
		boolean flag = service.joinAuthCheck(mail_authkey, mem_email);
		if(flag) {
			mv.addObject("flag",flag);
			return mv;
		}else {
			mv.addObject("flag",flag);
			return mv;
		}
	}
}