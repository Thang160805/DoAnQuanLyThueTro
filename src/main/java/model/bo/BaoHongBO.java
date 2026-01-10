package model.bo;

import java.util.ArrayList;

import model.bean.BaoHong;
import model.dao.BaoHongDao;

public class BaoHongBO {
	BaoHongDao bhDao = new BaoHongDao();
	public void insertAnhBaoHong(int ID_BaoHong, ArrayList<String> dsAnhBaoHong) {
		bhDao.insertAnhBaoHong(ID_BaoHong, dsAnhBaoHong);
	}
	
	public int insertBaoHong(BaoHong bh) {
		return bhDao.insertBaoHong(bh);
	}
	
	public ArrayList<BaoHong> getTOP3BaoHongByID_NguoiGui(int ID_NguoiGui){
		return bhDao.getTOP3BaoHongByID_NguoiGui(ID_NguoiGui);
	}
	
	public ArrayList<BaoHong> listBaoHongByIdCT(int idChuTro){
		return bhDao.listBaoHongByIdCT(idChuTro);
	}
	
	public BaoHong getBaoHongById(int idBaoHong) {
		return bhDao.getBaoHongById(idBaoHong);
	}
	
	public boolean updateTrangThaiXuLy(int idBaoHong) {
		return bhDao.updateTrangThaiXuLy(idBaoHong);
	}
	
	public boolean updateTrangThaiHoanThanh(int idBaoHong) {
		return bhDao.updateTrangThaiHoanThanh(idBaoHong);
	}
	
	public boolean updateTrangThaiTuChoi(int idBaoHong) {
		return bhDao.updateTrangThaiTuChoi(idBaoHong);
	}
}
