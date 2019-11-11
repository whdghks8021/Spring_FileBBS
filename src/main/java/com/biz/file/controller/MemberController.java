package com.biz.file.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.biz.file.model.MemberVO;
import com.biz.file.service.MemberService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
/*
 * Controller에 RequestMapping을 설정하면
 * 페이지를 호출할 주소를 그룹으로 묶어서 관리할 수 있다.
 * 단, Mapping 주소 앞에 반드시 / 로 시작해야 한다.
 */
@Controller
@RequestMapping("/member")
/*
 * @SessionAttributes는 @ModelAttribute로 선언된 객체를
 * Session 정보 안에 포함시켜서
 * 서로다른 method에서 값을 참조할수 있도록 도와주는 지시어
 * 
 * 
 */
@SessionAttributes({"memberVO"})
public class MemberController {
	
	@Autowired
	MemberService mService;
	/*
	위의 Autowired는 MemberService interface로 선언이 되고
	MemberSerivceImp 클래스로 초기화가 된다.
	public MemberService mService() {
		return new MemberServiceImp();
	}
	*/
	
	/*
	 * 이 컨트롤러 내에 있는 어떤 method에서
	 * @ModelAttribute("memberVO")라는 코드가 있는데
	 * memberVO라는 객체 혹시 생성이 안되어서
	 * null 값이면 해당 객체를 생성(new)해서 사용가능한 상태로
	 * 만들어라 하는 지시어
	 * 
	 */
	@ModelAttribute("memberVO")
	public MemberVO newMemberVO() {
		// return new MemberVO();
		MemberVO vo = new MemberVO();
		// vo.setM_userid("test");
		return vo;
	}
	
	// form을 열기 위한 method
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join(
			@ModelAttribute("memberVO") MemberVO memberVO,
			Model model,String strId) {
		memberVO = new MemberVO();
		model.addAttribute("BODY", "JOIN_FORM");
		return "home";
	}
	
	// form에서 데이터를 받기 위한 method
	@RequestMapping(value="/join",method=RequestMethod.POST)
	public String join(
			@ModelAttribute("memberVO") 
			@Valid  
			MemberVO memberVO,
			BindingResult result,
			Model model,
			SessionStatus session) {
		
		// vo에 설정된 contraint 조건에 위배된 값이 form으로 부터
		// 전송되어 오면 hasErrors()는 true를 갖고
		// 조건에 맞는 값이 오면 false를 갖게 된다.
		if( result.hasErrors() ) {
			log.debug("HasError");
			model.addAttribute("BODY","JOIN_FORM");
		} else {
			MemberVO checkId = mService.findByUserId(memberVO.getM_userid());
			if(checkId == null) {
				mService.insert(memberVO);
			} else {
				model.addAttribute("BODY","JOIN_FORM");
				model.addAttribute("MSG","이미 존재하는 아이디입니다.");
				return "home" ;
			}
			
			// 가입이 완료된 후 memberVO를 세션으로부터 제거하라
			session.setComplete();
			model.addAttribute("BODY","JOIN_SUCCESS");
			model.addAttribute("MSG","회원가입이 완료되었습니다.");
			model.addAttribute("BUTTON","로그인");
			log.debug("No Error");
		}
		return "home";
	}
	
	@RequestMapping(value="/mypage", method=RequestMethod.GET)
	public String myPage(Model model) {
		
		model.addAttribute("BODY","MYPAGE");
		return "home";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(
			@ModelAttribute("memberVO") MemberVO memberVO,
			Model model,HttpSession session) {
		memberVO = (MemberVO)session.getAttribute("login_info");
		model.addAttribute("memberVO",memberVO);
		model.addAttribute("BODY", "UPDATE_FORM");
		return "home";
	}
	
	// form에서 데이터를 받기 위한 method
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(
			@ModelAttribute("memberVO") 
			@Valid  
			MemberVO memberVO,
			BindingResult result,
			Model model,
			SessionStatus session,
			HttpSession hSession) {
		
		// vo에 설정된 contraint 조건에 위배된 값이 form으로 부터
		// 전송되어 오면 hasErrors()는 true를 갖고
		// 조건에 맞는 값이 오면 false를 갖게 된다.
		if( result.hasErrors() ) {
			log.debug("HasError");
			model.addAttribute("BODY","UPDATE_FORM");
		} else {
			int ret = mService.update(memberVO);
			if(ret > 0) {
				model.addAttribute("MSG","회원정보 수정이 완료되었습니다.");
				model.addAttribute("BUTTON","로그인");
			} else {
				model.addAttribute("MSG","서버와 통신오류발생. 재시도 바랍니다.");
				model.addAttribute("BUTTON","돌아가기");
			}
			
			// 수정이 완료된 후 memberVO를 세션으로부터 제거하라
			session.setComplete();
			// 재 로그인을 위해 로그인세션 제거
			hSession.removeAttribute("login_info");
			model.addAttribute("BODY","JOIN_SUCCESS");
			log.debug("No Error");
		}
		return "home";
	}
	
	@RequestMapping(value="/join1",method=RequestMethod.GET)
	public String join(Model model) {

		// memberVO를 생성해서
		// form:form tag로 이루어진 폼에 비어있는 데이터를
		// 덫씌워서 새로 작성하는 화면으로 구성
		MemberVO vo = new MemberVO();
		model.addAttribute("memberVO",vo);
		return "body/join_form";
	}
	
	@RequestMapping(value="/join2", method=RequestMethod.GET)
	public String join() {
		return "body/join_form";
	}
	
	
	
}