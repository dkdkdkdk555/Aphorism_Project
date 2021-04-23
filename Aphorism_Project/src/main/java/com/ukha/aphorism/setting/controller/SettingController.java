package com.ukha.aphorism.setting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SettingController {
	
	@RequestMapping("/setting/setting.do")
	public String settingPage() {
		return "setting/setting";
	}
}
