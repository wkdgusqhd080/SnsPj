package sns.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import sns.domain.Board;
//import sns.domain.Board_File;

@Data
@NoArgsConstructor
public class BoardListResult {
	private long currentPage;
	private long pageSize;
	private long totalCount;
	private long totalPageCount;
	List<Board> boardList;
	//List<List<Board_File>> boardFileList;

	
	/*
	public BoardListResult(long currentPage, long pageSize, long totalCount, List<Board> boardList, List<List<Board_File>> boardFileList) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.totalPageCount = calTotalPageCount();
		this.boardList = boardList;
		this.boardFileList = boardFileList;
	}
	*/
	public BoardListResult(long currentPage, long pageSize, long totalCount, List<Board> boardList) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.totalPageCount = calTotalPageCount();
		this.boardList = boardList;
	}
	
	public long calTotalPageCount() {
		long tpc = totalCount / pageSize;
		if((totalCount % pageSize) != 0) {
			tpc++;
		}
		return tpc;
	}

}
