package model.bean;

import java.time.LocalDateTime;

public class CuocTroChuyen {
	private int ID_CuocTroChuyen;
	private int User1;
	private int User2;
	private LocalDateTime NgayTao;
	private String TenNguoiNhan;
	private String Avatar;
	private int ID_NguoiNhan;
	
	
	
	public int getID_NguoiNhan() {
		return ID_NguoiNhan;
	}
	public void setID_NguoiNhan(int iD_NguoiNhan) {
		ID_NguoiNhan = iD_NguoiNhan;
	}
	public int getID_CuocTroChuyen() {
		return ID_CuocTroChuyen;
	}
	public void setID_CuocTroChuyen(int iD_CuocTroChuyen) {
		ID_CuocTroChuyen = iD_CuocTroChuyen;
	}
	public int getUser1() {
		return User1;
	}
	public void setUser1(int user1) {
		User1 = user1;
	}
	public int getUser2() {
		return User2;
	}
	public void setUser2(int user2) {
		User2 = user2;
	}
	public LocalDateTime getNgayTao() {
		return NgayTao;
	}
	public void setNgayTao(LocalDateTime ngayTao) {
		NgayTao = ngayTao;
	}
	public String getTenNguoiNhan() {
		return TenNguoiNhan;
	}
	public void setTenNguoiNhan(String tenNguoiNhan) {
		TenNguoiNhan = tenNguoiNhan;
	}
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	
	

}
