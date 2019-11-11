package com.biz.file.service;

import java.util.List;

import com.biz.file.model.MemberVO;

/*
 * interface
 * 1. 클래스를 작성하기 위한 명세
 * 2. 클래스와 클래스간에 기능들을 주고 받을때
 *   그 연결을 조금 느슨하게 하여
 *   한 클래스가 변경이 되어 다른 클래스에 영향을 줄인느 목적
 *   
 * 3. 메서드의 형태만 있고 구현이 없다.
 */
public interface MemberService {
	
	public List<MemberVO> selectAll();
	public MemberVO findByUserId(String m_userid);
	public int insert(MemberVO memberVO);
	public int update(MemberVO memberVO);
	public int delete(String m_userid);

}