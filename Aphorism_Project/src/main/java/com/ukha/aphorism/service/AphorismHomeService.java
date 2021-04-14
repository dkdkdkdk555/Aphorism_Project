package com.ukha.aphorism.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.ukha.aphorism.data.Data;

@Service
public interface AphorismHomeService {
	//현재 명언에서 이전or다음 명언을 에이작스로 요청받아 json데이터를 가져오고 파싱하는 메소드_2021.04.12
	public Data getHomeQuote(int id, String btn);

}
