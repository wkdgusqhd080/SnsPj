package sns.domain;

import lombok.NoArgsConstructor;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Follow {
	private String flr_email;
	private String mem_email;
}