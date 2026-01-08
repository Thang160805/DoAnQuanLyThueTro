package model.bo;

import java.util.ArrayList;

import model.bean.HoaDon;
import model.dao.HoaDonDao;

public class HoaDonBO {
	HoaDonDao hdDao = new HoaDonDao();
	public ArrayList<HoaDon> getListHoaDonByIdCT(int ID_ChuTro,String ThangNam){
		return hdDao.getListHoaDonByIdCT(ID_ChuTro, ThangNam);
	}
	
	public boolean themHoaDonThanhToan(HoaDon hd) {
		return hdDao.themHoaDonThanhToan(hd);
	}
	
	public HoaDon getChiTietHoaDonById(int idHoaDon) {
		return hdDao.getChiTietHoaDonById(idHoaDon);
	}
	
	public int getTotalCountListHDById(int ID_NguoiThue) {
		return hdDao.getTotalCountListHDById(ID_NguoiThue);
	}
	
	public ArrayList<HoaDon> getHoaDonByID_NguoiThue(int idNguoiThue,int page) {
		return hdDao.getHoaDonByID_NguoiThue(idNguoiThue, page);
	}
	
	public void capNhatHoaDonTreHan() {
		hdDao.capNhatHoaDonTreHan();
	}
	
	public HoaDon getHoaDonThanhToanById(int idHoaDon) {
		return hdDao.getHoaDonThanhToanById(idHoaDon);
	}
	
	public boolean updateTrangThaiHoaDon(int idHoaDon) {
		return hdDao.updateTrangThaiHoaDon(idHoaDon);
	}
}
