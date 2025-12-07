package model.bo;

import java.util.ArrayList;

import model.bean.KhuVuc;
import model.dao.KhuVucDao;

public class KhuVucBO {
	KhuVucDao kvDao = new KhuVucDao();
	public ArrayList<KhuVuc> getListKhuVuc(){
		return kvDao.getListKhuVuc();
	}
	
	public ArrayList<KhuVuc> getListKhuVucSoPhong(){
		return kvDao.getListKhuVucSoPhong();
	}
}
