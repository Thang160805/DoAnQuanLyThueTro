package model.bean;

import java.time.LocalDateTime;

public class TinNhan {
	private int ID_TinNhan;
	private int ID_CuocTroChuyen;
	private int ID_NguoiGui;
	private String NoiDung;
	private LocalDateTime ThoiGian;
	private String TrangThai;
	public int getID_TinNhan() {
		return ID_TinNhan;
	}
	public void setID_TinNhan(int iD_TinNhan) {
		ID_TinNhan = iD_TinNhan;
	}
	public int getID_CuocTroChuyen() {
		return ID_CuocTroChuyen;
	}
	public void setID_CuocTroChuyen(int iD_CuocTroChuyen) {
		ID_CuocTroChuyen = iD_CuocTroChuyen;
	}
	public int getID_NguoiGui() {
		return ID_NguoiGui;
	}
	public void setID_NguoiGui(int iD_NguoiGui) {
		ID_NguoiGui = iD_NguoiGui;
	}
	public String getNoiDung() {
		return NoiDung;
	}
	public void setNoiDung(String noiDung) {
		NoiDung = noiDung;
	}
	public LocalDateTime getThoiGian() {
		return ThoiGian;
	}
	public void setThoiGian(LocalDateTime thoiGian) {
		ThoiGian = thoiGian;
	}
	public String getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(String trangThai) {
		TrangThai = trangThai;
	}
	
	
}
