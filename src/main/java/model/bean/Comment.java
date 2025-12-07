package model.bean;

import java.time.LocalDateTime;

public class Comment {
	private int id;
	private int ID_Phong;
	private int ID_TaiKhoan;
	private String Comment;
	private int rating;
	private LocalDateTime create_at;
	private String TenNguoiDung;
	private String Avatar;
	
	
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getID_Phong() {
		return ID_Phong;
	}
	public void setID_Phong(int iD_Phong) {
		ID_Phong = iD_Phong;
	}
	public int getID_TaiKhoan() {
		return ID_TaiKhoan;
	}
	public void setID_TaiKhoan(int iD_TaiKhoan) {
		ID_TaiKhoan = iD_TaiKhoan;
	}
	public String getComment() {
		return Comment;
	}
	public void setComment(String comment) {
		Comment = comment;
	}
	
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public LocalDateTime getCreate_at() {
		return create_at;
	}
	public void setCreate_at(LocalDateTime create_at) {
		this.create_at = create_at;
	}
	
	public String getTenNguoiDung() {
		return TenNguoiDung;
	}
	public void setTenNguoiDung(String tenNguoiDung) {
		TenNguoiDung = tenNguoiDung;
	}
	
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	
	
}
