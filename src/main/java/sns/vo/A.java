package sns.vo;

import java.util.List;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class A {
	private long a_seq;
	private String a_name;
	private List<B> b_list;
}
