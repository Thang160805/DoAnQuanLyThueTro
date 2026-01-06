package model.bean;

import java.time.LocalDateTime;
import java.util.ArrayList;

public class PhongTro {
	private int ID_Phong;
	private int ID_ChuTro;
	private int ID_KhuVuc;
	private String TenCT;
	private String TenPhong;
	private String DiaChi;
	private int GiaThue;
	private float DienTich;
	private String MoTa;
	private String TrangThai;
	private LocalDateTime NgayDang;
	private String AnhChinh;
	private ArrayList<String> HinhAnh;
	private ArrayList<Comment> comment;
	private String Phone;
	private int GiaDien;
	private int GiaNuoc;
	private String Avatar;
	private String TenKhuVuc;
	
	
	public String getTenKhuVuc() {
		return TenKhuVuc;
	}
	public void setTenKhuVuc(String tenKhuVuc) {
		TenKhuVuc = tenKhuVuc;
	}
	public String getAvatar() {
		return Avatar;
	}
	public void setAvatar(String avatar) {
		Avatar = avatar;
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
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public ArrayList<String> getHinhAnh() {
		return HinhAnh;
	}
	public void setHinhAnh(ArrayList<String> hinhAnh) {
		HinhAnh = hinhAnh;
	}
	public ArrayList<Comment> getComment() {
		return comment;
	}
	public void setComment(ArrayList<Comment> comment) {
		this.comment = comment;
	}
	public PhongTro(int iD_Phong, int iD_ChuTro, int iD_KhuVuc, String tenCT, String tenPhong, String diaChi,
			int giaThue, float dienTich, String moTa, String trangThai, LocalDateTime ngayDang, String anhChinh) {
		super();
		ID_Phong = iD_Phong;
		ID_ChuTro = iD_ChuTro;
		ID_KhuVuc = iD_KhuVuc;
		TenCT = tenCT;
		TenPhong = tenPhong;
		DiaChi = diaChi;
		GiaThue = giaThue;
		DienTich = dienTich;
		MoTa = moTa;
		TrangThai = trangThai;
		NgayDang = ngayDang;
		AnhChinh = anhChinh;
	}
	public PhongTro() {
		super();
	}
	public int getID_Phong() {
		return ID_Phong;
	}
	public void setID_Phong(int iD_Phong) {
		ID_Phong = iD_Phong;
	}
	public int getID_ChuTro() {
		return ID_ChuTro;
	}
	public void setID_ChuTro(int iD_ChuTro) {
		ID_ChuTro = iD_ChuTro;
	}
	public int getID_KhuVuc() {
		return ID_KhuVuc;
	}
	public void setID_KhuVuc(int iD_KhuVuc) {
		ID_KhuVuc = iD_KhuVuc;
	}
	public String getTenCT() {
		return TenCT;
	}
	public void setTenCT(String tenCT) {
		TenCT = tenCT;
	}
	public String getTenPhong() {
		return TenPhong;
	}
	public void setTenPhong(String tenPhong) {
		TenPhong = tenPhong;
	}
	public String getDiaChi() {
		return DiaChi;
	}
	public void setDiaChi(String diaChi) {
		DiaChi = diaChi;
	}
	public int getGiaThue() {
		return GiaThue;
	}
	public void setGiaThue(int giaThue) {
		GiaThue = giaThue;
	}
	public float getDienTich() {
		return DienTich;
	}
	public void setDienTich(float dienTich) {
		DienTich = dienTich;
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
	public LocalDateTime getNgayDang() {
		return NgayDang;
	}
	public void setNgayDang(LocalDateTime ngayDang) {
		NgayDang = ngayDang;
	}
	public String getAnhChinh() {
		return AnhChinh;
	}
	public void setAnhChinh(String anhChinh) {
		AnhChinh = anhChinh;
	}
	
	
}
