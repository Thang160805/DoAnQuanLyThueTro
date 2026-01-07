package model.bean;

import java.time.LocalDateTime;
import java.util.ArrayList;

public class BaoHong {
	private int id;
	private int ID_Phong;
	private int ID_NguoiGui;
	private String TieuDe;
	private String LoaiHuHong;
	private String MucDoUuTien;
	private String MoTa;
	private String TrangThai;
	private LocalDateTime ThoiGianGui;
	private LocalDateTime Updated_At;
	private String TenPhong;
	private String TenNguoiGui;
	private String Avatar;
	private ArrayList<String> anhBaoHong;
	
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
	public int getID_NguoiGui() {
		return ID_NguoiGui;
	}
	public void setID_NguoiGui(int iD_NguoiGui) {
		ID_NguoiGui = iD_NguoiGui;
	}
	public String getTieuDe() {
		return TieuDe;
	}
	public void setTieuDe(String tieuDe) {
		TieuDe = tieuDe;
	}
	public String getLoaiHuHong() {
		return LoaiHuHong;
	}
	public void setLoaiHuHong(String loaiHuHong) {
		LoaiHuHong = loaiHuHong;
	}
	public String getMucDoUuTien() {
		return MucDoUuTien;
	}
	public void setMucDoUuTien(String mucDoUuTien) {
		MucDoUuTien = mucDoUuTien;
	}
	public String getMoTa() {
		return MoTa;
	}
	public void setMoTa(String moTa) {
		MoTa = moTa;
	}
	public String getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(String trangThai) {
		TrangThai = trangThai;
	}
	public LocalDateTime getThoiGianGui() {
		return ThoiGianGui;
	}
	public void setThoiGianGui(LocalDateTime thoiGianGui) {
		ThoiGianGui = thoiGianGui;
	}
	
	public LocalDateTime getUpdated_At() {
		return Updated_At;
	}
	public void setUpdated_At(LocalDateTime updated_At) {
		Updated_At = updated_At;
	}
	public String getTenPhong() {
		return TenPhong;
	}
	public void setTenPhong(String tenPhong) {
		TenPhong = tenPhong;
	}
	public String getTenNguoiGui() {
		return TenNguoiGui;
	}
	public void setTenNguoiGui(String tenNguoiGui) {
		TenNguoiGui = tenNguoiGui;
	}
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	public ArrayList<String> getAnhBaoHong() {
		return anhBaoHong;
	}
	public void setAnhBaoHong(ArrayList<String> anhBaoHong) {
		this.anhBaoHong = anhBaoHong;
	}
	
	
	
	

}
