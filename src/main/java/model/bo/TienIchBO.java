package model.bo;

import java.util.ArrayList;

import model.bean.TienIch;
import model.dao.TienIchDao;

public class TienIchBO {
	TienIchDao tiDao = new TienIchDao();
	
	public ArrayList<TienIch> getListTienIch(){
		return tiDao.getListTienIch();
	}
	
	public ArrayList<TienIch> getListTienIchByIDPhong(int ID_Phong){
		return tiDao.getListTienIchByIDPhong(ID_Phong);
	}
	
	public void insertTienIchForPhong(int idPhong, String[] tienIchList) {
		if (tienIchList == null) return;

        for (String ti : tienIchList) {
            int idTI = Integer.parseInt(ti);
            tiDao.insertTienIchPhong(idPhong, idTI);
        }
	}
}
