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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.ukha.aphorism.data.Data;


@Service
public class AphorismHomeServiceImpl implements AphorismHomeService {
	
	//명언을 json형식으로 가지고 있는 웹페이지에 요청하여 json데이터를 가져오고 파싱하는 메소드_2021.04.07
	@Override
	public List<Data> getData() {
		
		//요청 url
		String requestUrl = "https://dkdkdkdk555.github.io/Aphorism_data/data.jsp";
		
		BufferedReader bufferedReader = null;
		JSONArray jsonArr = null;
		try {
			URL url = new URL(requestUrl);
			URLConnection conn = url.openConnection();
			bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			JSONParser jsonParser = new JSONParser();
			jsonArr = (JSONArray) jsonParser.parse(bufferedReader); //받아온 json 데이터를 JSONArray(simple.json)객체로 변환
			
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
		
		//명언객체인 Data객체로 파싱해서 list에 넣는 로직
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject item = (JSONObject) jsonArr.get(i);
			
			String idd = String.valueOf(item.get("id"));
			int id = Integer.parseInt(idd);
			String descripK = (String) item.get("descripK");
			String authK = (String) item.get("authK");
			String descripE = (String) item.get("descripE");
			String authE = (String) item.get("authE");
			String category = (String) item.get("category");
			
			Data data = new Data();
			
			data.setId(id);
			data.setDescripK(descripK);
			data.setAuthK(authK);
			data.setDescripE(descripE);
			data.setAuthE(authE);
			data.setCategory(category);
			
			list.add(data);
		}
		
		
		
		return list;
	}

	@Override//현재 명언에서 이전or다음 명언을 에이작스로 요청받아 json데이터를 가져오고 파싱하는 메소드_2021.04.12
	public Data getNext_Prev(int id, String btn) {
		
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
		
		int inputId = 0;
		
		if(btn.equals("prev")) { //누른버튼이 prev버튼이면
			inputId = id-1;
		} else { // 누른버튼이 next 버튼이면
			inputId = id;
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
		
		return data;
	}

}
