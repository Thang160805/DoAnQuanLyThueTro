package model.bo;

import java.util.ArrayList;

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
}
