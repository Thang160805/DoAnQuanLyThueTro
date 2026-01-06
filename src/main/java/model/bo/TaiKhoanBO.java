package model.bo;

import java.util.ArrayList;

import model.bean.TaiKhoan;
import model.dao.TaiKhoanDao;

public class TaiKhoanBO {
	TaiKhoanDao tkDao = new TaiKhoanDao();
	public TaiKhoan checkLogin(String TenDangNhap, String matKhauPlain) {
		return tkDao.checkLogin(TenDangNhap, matKhauPlain);
	}
	
	public int insertTaiKhoanReturnID(TaiKhoan tk) {
		return tkDao.insertTaiKhoanReturnID(tk);
	}
	
	public boolean checkUserName(String username) {
		return tkDao.checkUserName(username);
	}
	
	public boolean checkPassword(int id, String passwordInput) {
		return tkDao.checkPassword(id, passwordInput);
	}
	
	public boolean ChangePass(int id,String newPass) {
		return tkDao.ChangePass(id, newPass);
	}
	
	public TaiKhoan getThongTinCaNhan(int id) {
		return tkDao.getThongTinCaNhan(id);
	}
	
	public boolean updateThongTinCaNhan(TaiKhoan tk) {
		return tkDao.updateThongTinCaNhan(tk);
	}
	
	public boolean updateAvatar(int id, String imgURL) {
		return tkDao.updateAvatar(id, imgURL);
	}
	
	public TaiKhoan getThongTinByTenDN(String TenDangNhap) {
		return tkDao.getThongTinByTenDN(TenDangNhap);
	}
	
	public boolean DoiMatKhau(String TenDangNhap,String MatKhau) {
		return tkDao.DoiMatKhau(TenDangNhap, MatKhau);
	}
	
	public boolean existsThongTinNguoiDungById(int id) {
		return tkDao.existsThongTinNguoiDungById(id);
	}
	
	public boolean insertThongTinNguoiDung(TaiKhoan tk) {
	    return tkDao.insertThongTinNguoiDung(tk);
	}
	
	public boolean insertAnh(int id, String linkAnh) {
		return tkDao.insertAnh(id, linkAnh);
	}
	
	public TaiKhoan getNgayThamGia(int ID_ChuTro) {
		return tkDao.getNgayThamGia(ID_ChuTro);
	}
	
	public void insertThongTinNguoiDungMoi(int ID_TaiKhoan) {
		tkDao.insertThongTinNguoiDungMoi(ID_TaiKhoan);
	}
	
	public ArrayList<TaiKhoan> getListTaiKhoan(){
		return tkDao.getListTaiKhoan();
	}
	
	public int getCountTaiKhoan() {
		return tkDao.getCountTaiKhoan();
	}
	
	public ArrayList<Integer> getAllAdmins(){
		return tkDao.getAllAdmins();
	}
}
