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
		
		String encodeKeyword = keyword.toLowerCase(); //영어 대소문자건 구분없이 일치 검사 시키기 위해
		
		List<Data> list = new ArrayList<Data>();//결과로 전달할 List객체
		
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject obj = (JSONObject) jsonArr.get(i); //명언 하나마다 JSONObject 객체로 만든다.
			if(isEn) { //전달된 키워드가 영어면 descripE만 검색어 일치검사
				String descripE = (String) obj.get("descripE");
				String authE = (String) obj.get("authE");
				String descripK = (String) obj.get("descripK");
				String authK = (String) obj.get("authK");
				boolean isContain = descripE.toLowerCase().contains(encodeKeyword) || authE.toLowerCase().contains(encodeKeyword);
				if(isContain) { //검색어를 포함하고 있다면 Data객체로 파싱하고 List에 담는다.
					Data data = new Data();
					data.setDescripE(descripE);
					data.setAuthE(authE);
					data.setDescripK(descripK);
					data.setAuthK(authK);
					list.add(data);
				}
			} else { //전달된 키워드가 한글이면 descripK만 검색어 일치검사
				String descripK = (String) obj.get("descripK");
				String authK = (String) obj.get("authK");
				String descripE = (String) obj.get("descripE");
				String authE = (String) obj.get("authE");
				boolean isContain = descripK.contains(keyword) || authK.contains(keyword);
				if(isContain) { //검색어를 포함하고 있다면 Data객체로 파싱하고 List에 담는다.
					Data data = new Data();
					data.setDescripK(descripK);
					data.setAuthK(authK);
					data.setDescripE(descripE);
					data.setAuthE(authE);
					list.add(data);
				}
			}
		}
		
		
		return list;
	}

}
