package model.bean;

import java.time.LocalDateTime;

public class ThongBao {
	private int id;
	private int receiver_id;
	private int sender_id;
	private String title;
	private String content;
	private String type;
	private int role;
	private String full_content;
	public String getFull_content() {
		return full_content;
	}
	public void setFull_content(String full_content) {
		this.full_content = full_content;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	private int is_read;
	private LocalDateTime create_at;
	private String HoTen;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getReceiver_id() {
		return receiver_id;
	}
	public void setReceiver_id(int receiver_id) {
		this.receiver_id = receiver_id;
	}
	public int getSender_id() {
		return sender_id;
	}
	public void setSender_id(int sender_id) {
		this.sender_id = sender_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getIs_read() {
		return is_read;
	}
	public void setIs_read(int is_read) {
		this.is_read = is_read;
	}
	public LocalDateTime getCreate_at() {
		return create_at;
	}
	public void setCreate_at(LocalDateTime create_at) {
		this.create_at = create_at;
	}
	public String getHoTen() {
		return HoTen;
	}
	public void setHoTen(String hoTen) {
		HoTen = hoTen;
	}
	
	
}
