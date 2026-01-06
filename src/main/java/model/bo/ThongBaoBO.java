package model.bo;

import java.util.ArrayList;

import model.bean.ThongBao;
import model.dao.ThongBaoDao;

public class ThongBaoBO {
	ThongBaoDao tbDao =  new ThongBaoDao();
	public ArrayList<ThongBao> getListThongBaoById(int Id_TaiKhoan, int page){
		return tbDao.getListThongBaoById(Id_TaiKhoan, page);
	}
	
	public void DocTatCa(int ID_TaiKhoan) {
		tbDao.DocTatCa(ID_TaiKhoan);
	}
	
	public ThongBao getThongBaoById(int id) {
		return tbDao.getThongBaoById(id);
	}
	
	public void DaDocById(int id) {
		tbDao.DaDocById(id);
	}
	
	public int getIsReadById(int id) {
		return tbDao.getIsReadById(id);
	}
	
	public int getCountThongBao(int TaiKhoan_id) {
		return tbDao.getCountThongBao(TaiKhoan_id);
	}
	
	public ArrayList<ThongBao> getTop3TB(int id){
		return tbDao.getTop3TB(id);
	}
	
	public void insertGuiThongBao(ThongBao tb) {
		tbDao.insertGuiThongBao(tb);
	}
	
	public int getTotalCountThongBao(int TaiKhoan_id) {
		return tbDao.getTotalCountThongBao(TaiKhoan_id);
	}
	
	public void sendThongBaoToAdmins(ThongBao tb) {
		tbDao.sendThongBaoToAdmins(tb);
	}
}
