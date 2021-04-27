package com.ukha.aphorism.setting.service;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.ukha.aphorism.data.Data;

@Service
public class SettingServiceImpl implements SettingService{
	
	//좋아요누른 명언 리스트를 얻어오는 메소드_2021.04.24
	@Override
	public List<Data> getLikeList(HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies(); //쿠키객체 얻기
		
		String likeCookie = null;
		if(cookies != null) {
			//반복문 돌면서 쿠키 객체를 하나씩 참조
			for(Cookie tmp : cookies) {
				//쿠키의 키값을 읽어온다.
				String key = tmp.getName();
				if(key.equals("like")) { // 쿠키의 키값이 like 라면 
					likeCookie = tmp.getValue();
				} 
			}
		}
		//'like'쿠키 없을때 500번 버스타는거 방지_2021.04.27
		if(likeCookie==null) {
			return null;
		}
		String[] likeArr = likeCookie.split("@");
	
		
		String requestUrl = "https://dkdkdkdk555.github.io/Aphorism_data/data.jsp";
		
		BufferedReader bufferedReader = null;
		JSONArray jsonArr = null;
		try {
			URL url = new URL(requestUrl);
			URLConnection conn = url.openConnection();
			bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			JSONParser jsonParser = new JSONParser();
			jsonArr = (JSONArray) jsonParser.parse(bufferedReader);
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				bufferedReader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		List<Data> list = new ArrayList<Data>();
		
		//아이디값이 일치하는 명언을 파싱하기
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject obj = (JSONObject) jsonArr.get(i);
			String objId = String.valueOf(obj.get("id")); 
			for(String tmp : likeArr) {
				if(objId.equals(tmp)) {
					Data data = new Data();
					data.setId(Integer.parseInt(objId));
					data.setDescripK((String) obj.get("descripK"));
					data.setAuthK((String) obj.get("authK"));
					data.setDescripE((String) obj.get("descripE"));
					data.setAuthE((String) obj.get("authE"));
					
					list.add(data);
				}
			}
		}
		
		
		return list;
	}

}
