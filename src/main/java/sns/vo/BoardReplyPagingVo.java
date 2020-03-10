package sns.vo;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class BoardReplyPagingVo {
	private long cp; //페이지 번호 
	private long ps; //페이지 사이즈  ( 한페이지당 글 갯수 )

	public long getStartRow() {
		return (cp-1) * ps; // ex) 0
	}
	public long getEndRow() {
		return cp * ps; //ex) 5
	}
}
