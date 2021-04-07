package com.ukha.aphorism.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

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
	public List<Data> getData(ModelAndView mView) {
		
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
			String description = (String) item.get("description");
			String author = (String) item.get("author");
			
			Data data = new Data();
			
			data.setId(id);
			data.setDescription(description);
			data.setAuthor(author);
			
			list.add(data);
			
		}
		
		
		return list;
	}

}
