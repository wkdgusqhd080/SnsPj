package sns.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardReplyUpdateVo {
	private String b_seq;
	private String brp_content;
	private String cpStr;
}
