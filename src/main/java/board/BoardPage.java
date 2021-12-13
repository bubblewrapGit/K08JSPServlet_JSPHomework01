package board;

public class BoardPage {
	public static String pagingStr(int totalCount, int listVolum, int pagingTotalCnt, int pagingVolum, int pageNum, String rURI) {
		String paging = "";
		
		System.out.println("pageNum : " + pageNum);
		System.out.println("pagingTotalCnt : " + pagingTotalCnt);
		/*
			totalCount : 총 게시물 갯수
			listVolum : 한 페이지당 보여줄 게시물(10)
			pagingTotalCnt : 총 페이지 수(11)  => (int)(Math.ceil(totalCount / 10));
			pagingVolum : 화면에서 보여지는 페이지 수(5)
			pageNum : 현재페이지번호(1)
			rURI : Url (+  "?pageNum=" + pagingTotalCnt)
		*/
		
	// 1~5p => 1 // 6~10p =>2 // 11p~ => 3
		int first = (((pageNum-1) / pagingVolum) * pagingVolum) + 1;
		
		if(first != 1) {
			
			paging = "<li class='page-item'>"
					+ "<a class='page-link' href='listT.jsp?pageNum=" + 1 +"'>"
					+ "<i class='bi bi-skip-backward-fill'></i>"
					+ "</a>"
					+ "</li>";
		}
		
		if(pageNum != 1) {
			paging += "<li class='page-item'>"
					+ "<a class='page-link' href='listT.jsp?pageNum=" + (pageNum-1) + "'><i class=\"bi bi-skip-start-fill\"></i></a></li>";			
		}
		
		
		int flag = 1;
		while(flag <= pagingVolum && first <= pagingTotalCnt) {
			System.out.println("flag : " + flag);
			System.out.println("first : " + first);
			paging += "<li class='page-item ";
			
			if(pageNum == first) {
				paging += "active";
			}
			
			paging += "'><a class='page-link' href='listT.jsp?pageNum="+ first +"'>" + first + "</a></li>";
			flag++;
			first++;
		}
		
		if(pageNum != pagingTotalCnt) {
			paging += "<li class='page-item'>"
					+ "<a class='page-link' href='listT.jsp?pageNum=" + (pageNum+1) + "'><i class=\"bi bi-skip-end-fill\"></i></a></li>";
		}
		
		
		if(first <= pagingTotalCnt) {
			paging += "<li class='page-item'>"
					+ "<a class='page-link' href='listT.jsp?pageNum=" + pagingTotalCnt +"'>"
					+ "<i class='bi bi-skip-forward-fill'></i>"
					+ "</a>"
					+ "</li>";
		}
		
		
		System.out.println(paging);
		return paging;
	}
}
