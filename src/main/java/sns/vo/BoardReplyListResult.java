package sns.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import sns.domain.Board;
//import sns.domain.Board_File;
import sns.domain.Board_Reply;

@Data
@NoArgsConstructor
public class BoardReplyListResult {
	private long currentPage;
	private long pageSize;
	private long totalCount;
	private long totalPageCount;
	List<Board_Reply> boardReplyList;
	
	public BoardReplyListResult(long currentPage, long pageSize, long totalCount, List<Board_Reply> boardReplyList) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.totalPageCount = calTotalPageCount();
		this.boardReplyList = boardReplyList;
	}
	
	public long calTotalPageCount() {
		long tpc = totalCount / pageSize;
		if((totalCount % pageSize) != 0) {
			tpc++;
		}
		return tpc;
	}

}
