package sns.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board_File {
	private long bf_seq;
	private String bf_ofname;
	private String bf_fname;
	private String bf_size;
	private long b_seq;
}