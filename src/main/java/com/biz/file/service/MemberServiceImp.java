package com.biz.file.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.biz.file.mapper.MemberDao;
import com.biz.file.model.MemberVO;

import lombok.extern.slf4j.Slf4j;

/*
 * 	구현체
 * 		Service interface를 implements 하여
 *		구현한 실체(메서드의 구체적인 기능들을 코딩한 클래스)
 * 
 *  인터페이스와 구현체의 사용
 *  일반적으로 클래스를 사용하기 위해서 아래와 같이 생성
 *  	클래스 객체 = new 클래스()
 *  	이름              생성자
 *  
 *  인터페이스와 구현체일 경우는
 *  인터페이스 객체 = new 구현체()
 *  	List<MemberVO> memberList = new ArrayList<MemberVO>();
 *  	리스트형 인터페이스             구현체생성자
 *  	* List memberList = new List 형식은 사용 불가
 *  
 *  자바에서는 어떤 클래스의 인터페이스가 있는경우는
 *  가능하면 인터페이스로 선언을하고 클래스로 생성을 하라고 한다.
 *  일반적으로 아래와 같으나
 *  	ArrayList<MemberVO> memberList = new ArrayList<MemberVO>();
 *  권장하는방식은 다음과 같다
 *  	List<MemberVO> memberList = new ArrayList<MemberVO>();
 */
@Slf4j
@Service
public class MemberServiceImp implements MemberService {

	@Autowired
	MemberDao mDao;
	
	@Autowired
	BCryptPasswordEncoder encoder;
	
	@Override
	public List<MemberVO> selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberVO findByUserId(String m_userid) {
		
		return mDao.findByUserId(m_userid);
	}

	@Override
	public int insert(MemberVO memberVO) {
		
		// 비밀번호를 암호화 시키자
		String plainPass = memberVO.getM_password();
		String crypPass = encoder.encode(plainPass);
		
		log.debug("비밀번호: " + plainPass);
		log.debug("암호 비밀번호: " + crypPass);
		
		memberVO.setM_password(crypPass);
		int ret = mDao.insert(memberVO); 
		return ret;
	}

	@Override
	public int update(MemberVO memberVO) {
		
		String plainPass = memberVO.getM_password();
		String crypPass = encoder.encode(plainPass);
		
		log.debug("비밀번호: " + plainPass);
		log.debug("암호 비밀번호: " + crypPass);
		
		memberVO.setM_password(crypPass);
		int ret = mDao.update(memberVO); 
		return ret;
	}

	@Override
	public int delete(String m_userid) {
		// TODO Auto-generated method stub
		return 0;
	}

}