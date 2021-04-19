package com.ukha.aphorism.category.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.ukha.aphorism.data.Data;

@Service
public class CategoryServiceImpl implements CategoryService{

	@Override
	public List<Data> putDataByCategory(String category) {
		
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
		
		if(category.equals("celebrity")) { //Celebrity 탭을 선택했다면
			for(int i=0; i<jsonArr.size(); i++) {
				JSONObject obj = (JSONObject) jsonArr.get(i);
				if(obj.containsKey("kinda")) { //"kinda"라는 키를 jsonObject가 가지고 있다면 
					
					Data data = this.extraction(obj);// JSONObject를 Data객체로 파싱하는 메소드 extraction을 호출 
					
					list.add(data); //리스트에 넣기 
				}
			}
			
			return list; //여기서 서비스 메소드를 종료한다.
			
		}
		
		if(category.equals("new")) { // Recently added 탭을 선택했다면
			int size = jsonArr.size() - 16; // 명언의 총 개수 얻기
			for(int i=size; i<jsonArr.size(); i++) {
				JSONObject obj = (JSONObject) jsonArr.get(i);
				
				Data data = this.extraction(obj);//JSONObject를 Data객체로 파싱한다.
				
				list.add(data); //리스트에 넣기 
			}
			return list; //여기서 서비스 메소드를 종료한다.
		}
		
		
		//JSONArray 에서 JSONObject로 변환하고 전달된 카테고리의 Object를 List에 담아서 세션에 담는다.
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject obj = (JSONObject) jsonArr.get(i);
			if(obj.get("category").equals(category)) { //명언의 카테고리 키값의 밸류가 전달되어온 category키값과 같다면 
				
				Data data = this.extraction(obj); //JSONObject를 Data객체로 파싱한다.
				
				list.add(data); //리스트에 넣기 
			}
		} 
		
		return list;
		
	}
	
	//JSONObject를 Data객체로 파싱하는 메소드(중복코드 줄이기 위해 정의함)_2021.04.19
	private Data extraction(JSONObject obj){
		
		Data data = new Data(); //JSONObject를 Data객체로 만들고
		data.setDescripK((String) obj.get("descripK"));
		data.setAuthK((String) obj.get("authK"));
		data.setDescripE((String) obj.get("descripE"));
		data.setAuthE((String) obj.get("authE"));
		
		return data;	
	}
}
