package model.bean;

import java.sql.Date;
import java.time.LocalDateTime;

public class HopDong {
	private int id;
	private int ID_YeuCau;
	private int ID_NguoiThue;
	private int ID_ChuTro;
	private int ID_Phong;
	private Date NgayBatDau;
	private Date NgayKetThuc;
	private String ThoiHanThue;
	private int TienCoc;
	private String NgayThanhToanHangThang;
	private int TongThuBanDau;
	private String DieuKhoan;
	private String TrangThai;
	private LocalDateTime create_at;
	private String TenNguoiThue;
	private String TenPhong;
	private String TrangThaiYeuCau;
	private String AnhPhong;
	private String DiaChi;
	
	
	
	
	public String getDiaChi() {
		return DiaChi;
	}

	public void setDiaChi(String diaChi) {
		DiaChi = diaChi;
	}

	public String getAnhPhong() {
		return AnhPhong;
	}

	public void setAnhPhong(String anhPhong) {
		AnhPhong = anhPhong;
	}

	public int getID_YeuCau() {
		return ID_YeuCau;
	}

	public void setID_YeuCau(int iD_YeuCau) {
		ID_YeuCau = iD_YeuCau;
	}

	public String getTrangThaiYeuCau() {
		return TrangThaiYeuCau;
	}

	public void setTrangThaiYeuCau(String trangThaiYeuCau) {
		TrangThaiYeuCau = trangThaiYeuCau;
	}
	public String getTenNguoiThue() {
		return TenNguoiThue;
	}
	public void setTenNguoiThue(String tenNguoiThue) {
		TenNguoiThue = tenNguoiThue;
	}
	public String getTenPhong() {
		return TenPhong;
	}
	public void setTenPhong(String tenPhong) {
		TenPhong = tenPhong;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getID_NguoiThue() {
		return ID_NguoiThue;
	}
	public void setID_NguoiThue(int iD_NguoiThue) {
		ID_NguoiThue = iD_NguoiThue;
	}
	public int getID_ChuTro() {
		return ID_ChuTro;
	}
	public void setID_ChuTro(int iD_ChuTro) {
		ID_ChuTro = iD_ChuTro;
	}
	public int getID_Phong() {
		return ID_Phong;
	}
	public void setID_Phong(int iD_Phong) {
		ID_Phong = iD_Phong;
	}
	public Date getNgayBatDau() {
		return NgayBatDau;
	}
	public void setNgayBatDau(Date ngayBatDau) {
		NgayBatDau = ngayBatDau;
	}
	public Date getNgayKetThuc() {
		return NgayKetThuc;
	}
	public void setNgayKetThuc(Date ngayKetThuc) {
		NgayKetThuc = ngayKetThuc;
	}
	public String getThoiHanThue() {
		return ThoiHanThue;
	}
	public void setThoiHanThue(String thoiHanThue) {
		ThoiHanThue = thoiHanThue;
	}
	public int getTienCoc() {
		return TienCoc;
	}
	public void setTienCoc(int tienCoc) {
		TienCoc = tienCoc;
	}
	public String getNgayThanhToanHangThang() {
		return NgayThanhToanHangThang;
	}
	public void setNgayThanhToanHangThang(String ngayThanhToanHangThang) {
		NgayThanhToanHangThang = ngayThanhToanHangThang;
	}
	public int getTongThuBanDau() {
		return TongThuBanDau;
	}
	public void setTongThuBanDau(int tongThuBanDau) {
		TongThuBanDau = tongThuBanDau;
	}
	public String getDieuKhoan() {
		return DieuKhoan;
	}
	public void setDieuKhoan(String dieuKhoan) {
		DieuKhoan = dieuKhoan;
	}
	public String getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(String trangThai) {
		TrangThai = trangThai;
	}
	public LocalDateTime getCreate_at() {
		return create_at;
	}
	public void setCreate_at(LocalDateTime create_at) {
		this.create_at = create_at;
	}
	
	
}
