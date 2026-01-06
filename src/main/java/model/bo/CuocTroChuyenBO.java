package model.bo;

import java.util.ArrayList;

import model.bean.CuocTroChuyen;
import model.dao.CuocTroChuyenDao;

public class CuocTroChuyenBO {
	CuocTroChuyenDao ctcDao = new CuocTroChuyenDao();
	
	public int getIDOrInsert(int user1, int user2) {
		return ctcDao.getIDOrInsert(user1, user2);
	}
	
	public void insertCuocTroChuyen(int User1,int User2) {
		ctcDao.insertCuocTroChuyen(User1, User2);
	}
	
	public ArrayList<CuocTroChuyen> getListNguoiTroChuyenByID(int ID_ChuTro){
		return ctcDao.getListNguoiTroChuyenByID(ID_ChuTro);
	}
}
