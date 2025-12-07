package model.bean;

public class TienIch {
	private int id;
	private String TenTienIch;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTenTienIch() {
		return TenTienIch;
	}
	public void setTenTienIch(String tenTienIch) {
		TenTienIch = tenTienIch;
	}
	public TienIch(int id, String tenTienIch) {
		super();
		this.id = id;
		TenTienIch = tenTienIch;
	}
	public TienIch() {
		super();
	}
	
}
