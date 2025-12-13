package model.bo;

import java.util.ArrayList;

import model.bean.HopDong;
import model.dao.HopDongDao;

public class HopDongBO {
	HopDongDao hdDao = new HopDongDao();
	
	public boolean taoHopDongVaCapNhatPhong(HopDong hd) {
		return hdDao.taoHopDongVaCapNhatPhong(hd);
	}
	
	public boolean phongDaCoHopDong(int idPhong) {
		return hdDao.phongDaCoHopDong(idPhong);
	}
	
	public ArrayList<HopDong> getListHopDong(){
		return hdDao.getListHopDong();
	}
	
	public HopDong getHopDongByID(int id) {
		return hdDao.getHopDongByID(id);
	}
	
	public boolean CapNhatTrangThaiHD(int id) {
		return hdDao.CapNhatTrangThaiHD(id);
	}
}
