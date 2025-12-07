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
}
