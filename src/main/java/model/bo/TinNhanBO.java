package model.bo;

import java.util.ArrayList;

import model.bean.TinNhan;
import model.dao.TinNhanDao;

public class TinNhanBO {
	TinNhanDao tnDao = new TinNhanDao();
	
	public TinNhan insertAndReturnTinNhan(int idCTC, int idNguoiGui, String noiDung) {
		return tnDao.insertAndReturnTinNhan(idCTC, idNguoiGui, noiDung);
	}
	
	public ArrayList<TinNhan> getTinNhanByID(int ID_CuocTroChuyen){
		return tnDao.getTinNhanByID(ID_CuocTroChuyen);
	}
	
	public TinNhan getNewTinNhan(int ID_CuocTroChuyen) {
		return tnDao.getNewTinNhan(ID_CuocTroChuyen);
	}
}
