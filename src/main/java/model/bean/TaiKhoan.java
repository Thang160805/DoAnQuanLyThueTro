package model.bean;

import java.sql.Date;
import java.time.LocalDateTime;


public class TaiKhoan {
	private int id;
	private String TenDangNhap;
	private String MatKhau;
	private int Role;
	private int Trangthai;
	private LocalDateTime NgayTao;
	
	private String HoTen;
	private String Email;
	private String SDT;
	private String CCCD;
	private String DiaChi;
	private Date NgaySinh;
	private int GioiTinh;
	private String Avatar;
	
	public TaiKhoan() {
		super();
	}
	
	
	

	public TaiKhoan(int id, String hoTen, String sDT, String cCCD, String diaChi, Date ngaySinh,
			int gioiTinh) {
		super();
		this.id = id;
		HoTen = hoTen;
		SDT = sDT;
		CCCD = cCCD;
		DiaChi = diaChi;
		NgaySinh = ngaySinh;
		GioiTinh = gioiTinh;
	}
	
	




	public TaiKhoan(int id, String avatar) {
		super();
		this.id = id;
		Avatar = avatar;
	}




	public TaiKhoan(String tenDangNhap, String matKhau, int role) {
		super();
		TenDangNhap = tenDangNhap;
		MatKhau = matKhau;
		Role = role;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getTenDangNhap() {
		return TenDangNhap;
	}


	public void setTenDangNhap(String tenDangNhap) {
		TenDangNhap = tenDangNhap;
	}


	public String getMatKhau() {
		return MatKhau;
	}


	public void setMatKhau(String matKhau) {
		MatKhau = matKhau;
	}


	public int getTrangthai() {
		return Trangthai;
	}


	public void setTrangthai(int trangthai) {
		Trangthai = trangthai;
	}


	public LocalDateTime getNgayTao() {
		return NgayTao;
	}


	public void setNgayTao(LocalDateTime ngayTao) {
		NgayTao = ngayTao;
	}


	public TaiKhoan(int id, String tenDangNhap, String matKhau, int role, int trangthai, LocalDateTime ngayTao) {
		super();
		this.id = id;
		TenDangNhap = tenDangNhap;
		MatKhau = matKhau;
		Role = role;
		Trangthai = trangthai;
		NgayTao = ngayTao;
	}


	public int getRole() {
		return Role;
	}

	public void setRole(int role) {
		Role = role;
	}


	public String getHoTen() {
		return HoTen;
	}


	public void setHoTen(String hoTen) {
		HoTen = hoTen;
	}


	public String getEmail() {
		return Email;
	}


	public void setEmail(String email) {
		Email = email;
	}


	public String getSDT() {
		return SDT;
	}


	public void setSDT(String sDT) {
		SDT = sDT;
	}


	public String getCCCD() {
		return CCCD;
	}


	public void setCCCD(String cCCD) {
		CCCD = cCCD;
	}


	public String getDiaChi() {
		return DiaChi;
	}


	public void setDiaChi(String diaChi) {
		DiaChi = diaChi;
	}


	public Date getNgaySinh() {
		return NgaySinh;
	}


	public void setNgaySinh(Date ngaySinh) {
		NgaySinh = ngaySinh;
	}


	public int getGioiTinh() {
		return GioiTinh;
	}


	public void setGioiTinh(int gioiTinh) {
		GioiTinh = gioiTinh;
	}


	public String getAvatar() {
		return Avatar;
	}


	public void setAvatar(String avatar) {
		Avatar = avatar;
	}


	

	
	
	
}
