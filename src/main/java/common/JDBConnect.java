package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;

public class JDBConnect {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	public JDBConnect(String driver, String url, String id, String pwd) {
		System.out.println("넘어 오셧나요???");
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url,id,pwd);
			System.out.println("DB 연결 성공(인자생성자 1)");
		}catch (Exception e) {
			System.out.println("Oracle 연결시 예외발생");
			e.printStackTrace();
		}
	}
	
	public JDBConnect(ServletContext application) {
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleURL");
		String id = application.getInitParameter("OracleId");
		String pwd = application.getInitParameter("OraclePwd");
		try {
			Class.forName(driver);
			
			con = DriverManager.getConnection(url,id,pwd);
			System.out.println("DB 연결 성공(이게 되나?)");
		} catch (Exception e) {
			System.out.println("DB 연결 실패");
			e.printStackTrace();
		}
	}
	
	public void close() {
		try {
			
			if(con != null) con.close();
			if(stmt != null) rs.close();
			if(psmt != null) rs.close();
			if(rs != null) rs.close();
			
			System.out.println("자원 해제");
		} catch (Exception e) {
			System.out.println("자원반납 실패");
			e.printStackTrace();
		}
		
	}
}
