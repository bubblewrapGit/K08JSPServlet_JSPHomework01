package board;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class BoardDAO extends JDBConnect {
	public BoardDAO(ServletContext application) {
		super(application);
	}
	
	public int selectCount(Map<String, Object> param) {
		int totalCount = 0;
		
		String query = "SELECT COUNT(*) FROM board";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	public List<BoardDTO> selectList(Map<String, Object> map) {
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		String query = " SELECT * FROM (SELECT tb.*, ROWNUM rnum FROM (SELECT * FROM board  ";
				
				if(map.get("searchKey") != null) {
					query += " WHERE " + map.get("serachArea") + " LIKE '%" + map.get("searchKey") + "%' ";
				}
		
				query += " ORDER BY num DESC) tb) WHERE rnum BETWEEN ? AND ? ";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("crtListFirst").toString());
			psmt.setString(2, map.get("crtListLast").toString());
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setId(rs.getString("id"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));;
				
				bbs.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO();
		String query = "SELECT "
				+ " num, title, content, id, postdate, visitcount, name "
				+ " FROM board INNER JOIN member "
				+ " USING(id) "
				+ " WHERE num=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setPostdate(rs.getDate("postdate"));
			}
		} catch (Exception e) {
			System.out.println("상세보기 오류");
			e.printStackTrace();
		}
		return dto;
	}
	
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		try {
			String query = "INSERT INTO board "
					+ " ( num, id, title, content, postdate, VISITCOUNT ) "
					+ " VALUES ( seq_board_num.nextval, ?, ?, ?, sysdate, 0 ) ";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("글쓰기 오류 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		
		try {
			String query = "UPDATE board SET "
						 + " title=?, content=? "
						 + " WHERE num=?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			System.out.println(
					"dto.getNum() : " + dto.getNum()
					);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("글수정 오류");
			e.printStackTrace();
		}
		System.out.println("result1 : " + result);
		return result;
	}
}
