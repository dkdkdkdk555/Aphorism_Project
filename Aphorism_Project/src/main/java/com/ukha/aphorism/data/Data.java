package com.ukha.aphorism.data;

//명언을 담는 객체_20210406
public class Data { 
	private int id; //아이디
	private String descripK; //한국어 본문
	private String authK; //한국어 말한이
	private String descripE; //영어 본문
	private String authE; // 영어 말한이
	private String category; //명언 카테고리 
	
	public Data() {};
	
	public Data(int id, String descripK, String authK, String descripE, String authE, String category) {
		super();
		this.id = id;
		this.descripK = descripK;
		this.authK = authK;
		this.descripE = descripE;
		this.authE = authE;
		this.category = category;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescripK() {
		return descripK;
	}

	public void setDescripK(String descripK) {
		this.descripK = descripK;
	}

	public String getAuthK() {
		return authK;
	}

	public void setAuthK(String authK) {
		this.authK = authK;
	}

	public String getDescripE() {
		return descripE;
	}

	public void setDescripE(String descripE) {
		this.descripE = descripE;
	}

	public String getAuthE() {
		return authE;
	}

	public void setAuthE(String authE) {
		this.authE = authE;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	
}
