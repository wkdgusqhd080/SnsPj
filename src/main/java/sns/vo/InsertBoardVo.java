package sns.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InsertBoardVo {
	private String mem_email;
	private String b_content;
	private String[] ofilelist;
	private String[] filelist;
	private String[] sizelist;
}
