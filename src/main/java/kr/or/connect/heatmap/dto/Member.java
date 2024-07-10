package kr.or.connect.heatmap.dto;

public class Member {
	
	private int idNum;
	private String id;
	private String password;
	private String password2;  //비밀번호 확인용
	private String changepassword;
	private String changepassword2;//비밀번호 변경 확인용
	private String email;
	private String mtype; // 관리자인지 일반회원인지
	
	
	
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}
	
	
	
	
	public String getChangepassword() {
		return changepassword;
	}
	public void setChangepassword(String changepassword) {
		this.changepassword = changepassword;
	}
	public String getChangepassword2() {
		return changepassword2;
	}
	public void setChangepassword2(String changepassword2) {
		this.changepassword2 = changepassword2;
	}
	
	public int getIdNum() {
		return idNum;
	}
	public void setIdNum(int idNum) {
		this.idNum = idNum;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	@Override
	public String toString() {
		return "Member [id=" + id + ", password=" + password + ", password2=" + password2 + ", email=" + email + "]";
	}
	

	
	
	
}
