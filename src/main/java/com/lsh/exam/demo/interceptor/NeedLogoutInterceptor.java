package com.lsh.exam.demo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.lsh.exam.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
//로그인 담당 Interceptor
public class NeedLogoutInterceptor implements HandlerInterceptor{
	private Rq rq;
	
	public NeedLogoutInterceptor(Rq rq) {
		this.rq = rq;
	}
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
	
		if (rq.isLogined()) {
			rq.printHistoryBackJs("로그아웃 후 이용 해주세요.");
			return false;
		}
		
		//System.out.println("로그인 필요!");

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}
