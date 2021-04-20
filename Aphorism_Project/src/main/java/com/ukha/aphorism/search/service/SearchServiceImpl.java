package com.ukha.aphorism.search.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.ukha.aphorism.data.Data;

@Service
public class SearchServiceImpl implements SearchService{

	//전달받은 keyword에 대한 명언 검색결과를 list로 리턴하는 메소드_2021.04.20
	@Override
	public List<Data> getData(String keyword) {
		//정규표현식으로 전달된 키워드의 언어 구분
		boolean isEn = Pattern.matches("^[a-zA-Z]*$", keyword);
		System.out.println(isEn);
		
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
		
		List<Data> list = new ArrayList<Data>();//결과로 전달할 List객체
		
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject obj = (JSONObject) jsonArr.get(i); //명언 하나마다 JSONObject 객체로 만든다.
			if(isEn) { //전달된 키워드가 영어면 descripE만 추출
				String descripE = (String) obj.get("descripE");
				String authE = (String) obj.get("authE");
				boolean isContain = descripE.contains(keyword) || authE.contains(keyword);
				if(isContain) { //검색어를 포함하고 있다면 Data객체로 파싱하고 List에 담는다.
					Data data = new Data();
					data.setDescripE(descripE);
					data.setAuthE(authE);
					list.add(data);
				}
			} else { //전달된 키워드가 한글이면 descripK만 추출
				String descripK = (String) obj.get("descripK");
				String authK = (String) obj.get("authK");
				boolean isContain = descripK.contains(keyword) || authK.contains(keyword);
				if(isContain) { //검색어를 포함하고 있다면 Data객체로 파싱하고 List에 담는다.
					Data data = new Data();
					data.setDescripK(descripK);
					data.setAuthK(authK);
					list.add(data);
				}
			}
		}
		
		
		return list;
	}

}
