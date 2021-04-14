package com.ukha.aphorism.service;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.ukha.aphorism.data.Data;


@Service
public class AphorismHomeServiceImpl implements AphorismHomeService {
	
	@Override//home.do 접속시 명언과 이전or다음 명언을 에이작스로 요청받아 json데이터를 가져오고 파싱하는 메소드_2021.04.12 -> 04.14 수정
	public Data getHomeQuote(int id, String btn) {
		
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
		
		int size = jsonArr.size(); // 총 명언 갯수
		int inputId = 0;
		
		if(btn.equals("prev")) { //누른버튼이 prev버튼이면
			inputId = id-1;
		} else if(btn.equals("next")) { // 누른버튼이 next 버튼이면
			inputId = id;
		} else if(btn.equals("not")) { //처음 홈화면을 로딩할 시 
			int ran = new Random().nextInt(size);
			inputId = ran; // 랜덤으로 나온걸 처음 보여주겠다. 
			
		}
		JSONObject item = (JSONObject) jsonArr.get(inputId);
		String idd = String.valueOf(item.get("id"));
		int receiveId = Integer.parseInt(idd);
		String descripK = (String) item.get("descripK");
		String authK = (String) item.get("authK");
		String descripE = (String) item.get("descripE");
		String authE = (String) item.get("authE");
		String category = (String) item.get("category");
		
		Data data = new Data();
		
		data.setId(receiveId);
		data.setDescripK(descripK);
		data.setAuthK(authK);
		data.setDescripE(descripE);
		data.setAuthE(authE);
		data.setCategory(category);
		data.setSize(size);
		
		return data;
	}

}
