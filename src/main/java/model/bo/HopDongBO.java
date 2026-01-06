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
	
	public void insertHopDong(int ID_YeuCau,int ID_NguoiThue,int ID_ChuTro,int ID_Phong) {
		hdDao.insertHopDong(ID_YeuCau,ID_NguoiThue, ID_ChuTro, ID_Phong);
	}
	
	public void deleteHopDongKoDuocDuyet(int ID_Phong, int idHopDong) {
		hdDao.deleteHopDongKoDuocDuyet(ID_Phong, idHopDong);
	}
	
	public ArrayList<HopDong> getListHopDongByIDNguoiThue(int ID_NguoiThue,int page){
		return hdDao.getListHopDongByIDNguoiThue(ID_NguoiThue, page);
	}
	
	public int getTotalCountListHDById(int ID_NguoiThue) {
		return hdDao.getTotalCountListHDById(ID_NguoiThue);
	}
	
	public ArrayList<HopDong> getListNguoiThue(){
		return hdDao.getListNguoiThue();
	}
	
	public ArrayList<Integer> listID_NguoiThue(){
		return hdDao.listID_NguoiThue();
	}
	
	public ArrayList<HopDong> getListPhongDaThueById(int ID_NguoiThue){
		return hdDao.getListPhongDaThueById(ID_NguoiThue);
	}
}
