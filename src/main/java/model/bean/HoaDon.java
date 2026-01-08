package model.bean;
import java.sql.Date;
import java.time.LocalDateTime;

public class HoaDon {
	private int id;
	private int ID_HopDong;
	private int ID_NguoiThue;
	private int ID_ChuTro;
	private int ID_Phong;
	private String ThangNam;
	private int TienPhong;
	private int TienDien;
	private int TienNuoc;
	private int TongTien;
	private Date HanThanhToan;
	private Date NgayThanhToan;
	private String TrangThai;
	private String GhiChu;
	private HopDong hopDongPhong;
	private String TenNguoiThue;
	private String TenChuTro;
	private String TenPhong;
	private String DiaChiPhong;
	private int GiaDien;
	private int GiaNuoc;
	private String AnhPhong;
	private LocalDateTime created_at;
	private String QRThanhToan;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getID_HopDong() {
		return ID_HopDong;
	}
	public void setID_HopDong(int iD_HopDong) {
		ID_HopDong = iD_HopDong;
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
	public String getThangNam() {
		return ThangNam;
	}
	public void setThangNam(String thangNam) {
		ThangNam = thangNam;
	}
	public int getTienPhong() {
		return TienPhong;
	}
	public void setTienPhong(int tienPhong) {
		TienPhong = tienPhong;
	}
	public int getTienDien() {
		return TienDien;
	}
	public void setTienDien(int tienDien) {
		TienDien = tienDien;
	}
	public int getTienNuoc() {
		return TienNuoc;
	}
	public void setTienNuoc(int tienNuoc) {
		TienNuoc = tienNuoc;
	}
	public int getTongTien() {
		return TongTien;
	}
	public void setTongTien(int tongTien) {
		TongTien = tongTien;
	}
	public Date getHanThanhToan() {
		return HanThanhToan;
	}
	public void setHanThanhToan(Date hanThanhToan) {
		HanThanhToan = hanThanhToan;
	}
	public Date getNgayThanhToan() {
		return NgayThanhToan;
	}
	public void setNgayThanhToan(Date ngayThanhToan) {
		NgayThanhToan = ngayThanhToan;
	}
	public String getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(String trangThai) {
		TrangThai = trangThai;
	}
	public String getGhiChu() {
		return GhiChu;
	}
	public void setGhiChu(String ghiChu) {
		GhiChu = ghiChu;
	}
	public HopDong getHopDongPhong() {
		return hopDongPhong;
	}
	public void setHopDongPhong(HopDong hopDongPhong) {
		this.hopDongPhong = hopDongPhong;
	}
	public String getTenNguoiThue() {
		return TenNguoiThue;
	}
	public void setTenNguoiThue(String tenNguoiThue) {
		TenNguoiThue = tenNguoiThue;
	}
	
	public String getTenChuTro() {
		return TenChuTro;
	}
	public void setTenChuTro(String tenChuTro) {
		TenChuTro = tenChuTro;
	}
	public String getTenPhong() {
		return TenPhong;
	}
	public void setTenPhong(String tenPhong) {
		TenPhong = tenPhong;
	}
	public String getDiaChiPhong() {
		return DiaChiPhong;
	}
	public void setDiaChiPhong(String diaChiPhong) {
		DiaChiPhong = diaChiPhong;
	}
	public int getGiaDien() {
		return GiaDien;
	}
	public void setGiaDien(int giaDien) {
		GiaDien = giaDien;
	}
	public int getGiaNuoc() {
		return GiaNuoc;
	}
	public void setGiaNuoc(int giaNuoc) {
		GiaNuoc = giaNuoc;
	}
	
	public String getAnhPhong() {
		return AnhPhong;
	}
	public void setAnhPhong(String anhPhong) {
		AnhPhong = anhPhong;
	}
	public LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}
	public String getQRThanhToan() {
		return QRThanhToan;
	}
	public void setQRThanhToan(String qRThanhToan) {
		QRThanhToan = qRThanhToan;
	}
	
	
	
}
