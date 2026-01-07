package model.bo;

import java.util.ArrayList;

import model.bean.HoaDon;
import model.dao.HoaDonDao;

public class HoaDonBO {
	HoaDonDao hdDao = new HoaDonDao();
	public ArrayList<HoaDon> getListHoaDonByIdCT(int ID_ChuTro,String filter){
		return hdDao.getListHoaDonByIdCT(ID_ChuTro, filter);
	}
}
