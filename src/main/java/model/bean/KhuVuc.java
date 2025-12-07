package model.bean;

public class KhuVuc {
	private int id;
	private String TenKhuVuc;
	private int SoPhong;
	public int getSoPhong() {
		return SoPhong;
	}
	public void setSoPhong(int soPhong) {
		SoPhong = soPhong;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTenKhuVuc() {
		return TenKhuVuc;
	}
	public void setTenKhuVuc(String tenKhuVuc) {
		TenKhuVuc = tenKhuVuc;
	}
	public KhuVuc(int id, String tenKhuVuc) {
		super();
		this.id = id;
		TenKhuVuc = tenKhuVuc;
	}
	public KhuVuc() {
		super();
	}
	
	
}
