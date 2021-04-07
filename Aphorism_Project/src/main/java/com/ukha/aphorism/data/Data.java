package com.ukha.aphorism.data;

//명언을 담는 객체_20210406
public class Data { 
	private int id; //번호
	private String description; //본문
	private String author; //말한이
	
	public Data(int id, String description, String author) {
		super();
		this.id = id;
		this.description = description;
		this.author = author;
	}
	
	public Data() {}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	
	
}
