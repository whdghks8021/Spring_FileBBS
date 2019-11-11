package com.biz.file.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.file.mapper.LoginDao;
import com.biz.file.model.MemberVO;

@Service
public class LoginServiceImp implements LoginService {

	@Autowired
	LoginDao lDao;
	
	@Autowired
	BCryptPasswordEncoder encoder;
	
	public MemberVO getMemberInfo(MemberVO loginVO) {
		
		/*
		 * 정상적인 login인지 확인하기 위해
		 * userid와 password를 조회해서 일치하는지 알아 보아야 하지만
		 * password를 암호화 하였고,
		 * 지금 암호화 한 password는 단방향 암호화 방식이다.
		 * 단방향 : 똑같은 password를 입력해서 확인하는 방식
		 * 
		 * 단방향 암호화된 비밀번호가 일치하는지 알아보는 방법
		 * 1. 로그인 할때 입력한 비밀번호를 다시 암호화를한다.
		 * 2. 생성된 암호 문자열을
		 * 3. DB에서 가져온 문자열과 비교해서 일치하는지 알아 본다.
		 * 
		 * 그런데
		 * BCryp... 암호화 방식에서는 모든것을 내장된(기본제공되는)
		 * method를 통해서만 가능하다.
		 */
		
		String m_userid = loginVO.getM_userid();
		MemberVO vo = lDao.getMemberInfo(m_userid);
		
		if(vo == null) return null ;
		
		String crypPass = vo.getM_password(); // 암호화된 password
		String encodedPassword = vo.getM_password();
		
		String plainPass = loginVO.getM_password(); // 유저가 입력한 password
		String rawPassword = loginVO.getM_password();
		
		boolean match = encoder.matches(plainPass, crypPass);

		// match가 true : 비밀번호가 일치
		if(match) {
			// DB에서 불러온 vo를 컨트롤러에게 리턴
			return vo;
		} else {
			return null;
		}
	}

}
