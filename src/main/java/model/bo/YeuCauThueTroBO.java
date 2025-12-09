package model.bo;

import model.bean.YeuCauThueTro;
import model.dao.YeuCauThueTroDao;

public class YeuCauThueTroBO {
	YeuCauThueTroDao ycttDao = new YeuCauThueTroDao();
	public boolean insertYeuCauThueTro(YeuCauThueTro yctt) {
		return ycttDao.insertYeuCauThueTro(yctt);
	}
}
