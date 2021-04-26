package com.ukha.aphorism.setting.service;

import java.util.List;


import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.ukha.aphorism.data.Data;

@Service
public interface SettingService {
	//좋아요누른 명언 리스트를 얻어오는 메소드_2021.04.24
	public List<Data> getLikeList(HttpServletRequest request);
}
