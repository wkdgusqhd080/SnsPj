package sns.login.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.extern.log4j.Log4j;
import sns.domain.Member;
import sns.login.service.LoginService;
import sns.login.service.LoginSet;

@RequestMapping("login")
@Controller
@Log4j
public class LoginController {
	
	@Autowired
	LoginService service;
	
	@PostMapping("login.do")
	public String login(Model model, String mem_email, String mem_pwd, HttpSession session) {
		int result = service.loginCheck(mem_email, mem_pwd);
		model.addAttribute("result", result);
		if(result == LoginSet.PASS) {
			Member loginUser = service.userLogin(mem_email);
			session.setAttribute("loginUser", loginUser);
		}
		return "login/login_msg";
	}
	
}