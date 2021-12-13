package login;

import common.JDBConnect;

public class LoginDAO extends JDBConnect{
	public LoginDAO(String driver, String url, String id, String pwd) {
		super(driver, url, id, pwd);
	}
	
	public LoginDTO getLoginDTO(String userId, String userPw) {
		LoginDTO dto = new LoginDTO();

		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, userId);
			psmt.setString(2, userPw);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setRegidate(rs.getString("regidate"));
			}
		} catch (Exception e) {
			System.out.println("getLoginDTO 오류");
			e.printStackTrace();
		}
		return dto;
	}
}
