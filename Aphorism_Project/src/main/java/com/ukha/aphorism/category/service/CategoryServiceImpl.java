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
		
		//JSONArray 에서 JSONObject로 변환하고 전달된 카테고리의 Object를 List에 담아서 세션에 담는다.
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject obj = (JSONObject) jsonArr.get(i);
			if(obj.get("category").equals(category)) { //명언의 카테고리 키값의 밸류가 전달되어온 category키값과 같다면 
				Data data = new Data(); //JSONObject를 Data객체로 만들고
				data.setId(Integer.parseInt(String.valueOf(obj.get("id"))));
				data.setDescripK((String) obj.get("descripK"));
				data.setAuthK((String) obj.get("authK"));
				data.setDescripE((String) obj.get("descripE"));
				data.setAuthE((String) obj.get("authE"));
				
				list.add(data); //리스트에 넣기 
			}
		} 
		
		return list;
		
	}
}
