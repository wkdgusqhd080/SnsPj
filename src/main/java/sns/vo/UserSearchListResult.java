package sns.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import sns.domain.Follow;
import sns.domain.Member;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserSearchListResult {
	private List<Member> member_list;
	private List<Follow> follow_list;
}
