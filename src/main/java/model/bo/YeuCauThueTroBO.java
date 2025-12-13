package model.bo;

import java.util.ArrayList;

import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.YeuCauThueTro;
import model.dao.YeuCauThueTroDao;

public class YeuCauThueTroBO {
	YeuCauThueTroDao ycttDao = new YeuCauThueTroDao();
	public boolean insertYeuCauThueTro(YeuCauThueTro yctt) {
		return ycttDao.insertYeuCauThueTro(yctt);
	}
	
	public ArrayList<YeuCauThueTro> getListYeuCau(){
		return ycttDao.getListYeuCau();
	}
	
	public int getCountYeuCau() {
		return ycttDao.getCountYeuCau();
	}
	
	public TaiKhoan getThongTinTaiKhoanByIDYeuCau(int ID_YeuCau) {
		return ycttDao.getThongTinTaiKhoanByIDYeuCau(ID_YeuCau);
	}
	
	public PhongTro getThongTinPhongByIDYeuCau(int ID_YeuCau) {
		return ycttDao.getThongTinPhongByIDYeuCau(ID_YeuCau);
	}
	
	public YeuCauThueTro getChiTietYeuCauThueByID(int ID_YeuCau) {
		return ycttDao.getChiTietYeuCauThueByID(ID_YeuCau);
	}
	
	public boolean UpdateTrangThaiYeuCauThue(int ID_YeuCau,String TrangThai) {
		return ycttDao.UpdateTrangThaiYeuCauThue(ID_YeuCau, TrangThai);
	}
	
	public int getID_PhongByID(int ID_YeuCau) {
		return ycttDao.getID_PhongByID(ID_YeuCau);
	}
}
