package model.bean;

import java.sql.Date;
import java.time.LocalDateTime;

public class YeuCauThueTro {
	private int id;
	private int ID_Phong;
	private int ID_TaiKhoan;
	private Date NgayDonVao;
	private String ThoiHanThue;
	private String LoiNhan;
	private String TrangThai;
	private String LienHe;
	private LocalDateTime create_at;
	private String TenPhong;
	private String HoTen;
	private String SDT;
	private String Avatar;
	private PhongTro phongTro;
	
	public YeuCauThueTro() {
		super();
	}
	
	


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
	public Date getNgayDonVao() {
		return NgayDonVao;
	}
	public void setNgayDonVao(Date ngayDonVao) {
		NgayDonVao = ngayDonVao;
	}
	public String getThoiHanThue() {
		return ThoiHanThue;
	}
	public void setThoiHanThue(String thoiHanThue) {
		ThoiHanThue = thoiHanThue;
	}
	public String getLoiNhan() {
		return LoiNhan;
	}
	public void setLoiNhan(String loiNhan) {
		LoiNhan = loiNhan;
	}
	public String getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(String trangThai) {
		TrangThai = trangThai;
	}
	public String getLienHe() {
		return LienHe;
	}
	public void setLienHe(String lienHe) {
		LienHe = lienHe;
	}
	public LocalDateTime getCreate_at() {
		return create_at;
	}
	public void setCreate_at(LocalDateTime create_at) {
		this.create_at = create_at;
	}
	public String getTenPhong() {
		return TenPhong;
	}
	public void setTenPhong(String tenPhong) {
		TenPhong = tenPhong;
	}
	public String getHoTen() {
		return HoTen;
	}
	public void setHoTen(String hoTen) {
		HoTen = hoTen;
	}
	public String getSDT() {
		return SDT;
	}
	public void setSDT(String sDT) {
		SDT = sDT;
	}

	public PhongTro getPhongTro() {
		return phongTro;
	}

	public void setPhongTro(PhongTro phongTro) {
		this.phongTro = phongTro;
	}




	public String getAvatar() {
		return Avatar;
	}




	public void setAvatar(String avatar) {
		Avatar = avatar;
	}
	
	
	
}
