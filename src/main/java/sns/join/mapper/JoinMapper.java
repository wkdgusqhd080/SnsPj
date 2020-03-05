package sns.join.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import sns.domain.Mail_Auth;
import sns.domain.Member;

public interface JoinMapper {
	String selectEmailCheck(String mem_email);
	
	@Insert(value= {"INSERT INTO MEMBER VALUES(#{mem_email}, #{mem_pwd}, SYSDATE, 'defaultProfile.jpg', #{mem_state})"})
	void insertMember(Member member);
	
	@Insert(value = {"INSERT INTO MAIL_AUTH VALUES(#{mem_email}, #{mail_authkey})"})
	void insertMailAuth(Mail_Auth mail_auth);
	
	String selectJoinAuthCheck(String mem_email);
	
	@Update(value= {"UPDATE MEMBER SET MEM_STATE = 1 WHERE MEM_EMAIL = #{mem_email}"})
	void updateMemberState(String mem_email);
	
	@Delete(value= {"DELETE FROM MAIL_AUTH WHERE MEM_EMAIL = #{mem_email}"})
	void deleteMailAuth(String mem_email);
	
}
