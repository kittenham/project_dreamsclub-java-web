package xyz.dreams.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import xyz.dreams.dto.CartDTO;
import xyz.dreams.dto.MemberDTO;
import xyz.dreams.service.CartService;

@Controller
@RequestMapping(value = "/cart")
@RequiredArgsConstructor
public class CartController {
	private final CartService cartService;
	
	/* 장바구니 추가 */
	/**
	 * 0: 등록 실패
	 * 1: 등록 성공
	 * 2: 등록된 데이터 존재
	 * 5: 로그인 필요
	 * 
	 */
	
	/*장바구니 상품 추가하기*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addCartPOST(CartDTO cartDTO, HttpSession session){
		//질문: HttpServletRequest request 이랑 HttpSession session이랑 뭐가 다른거?
		
		//로그인아이디 가져오기
		CartDTO cartLogin = (CartDTO)session.getAttribute("member");
		
		//로그인 안되어있으면 로그인 필요 경고창 반환
		if(cartLogin == null) {
			return "5";
		}
		
		//로그인 되어 있으면 장바구니에 굿즈 추가됨. 아니면 0(등록취소)됨
		int result;
		try {
			result = cartService.addCart(cartDTO);
		} catch (Exception e) {
			return "0";
		}
		
		return result+""; //문자열로 반환
		
		
	}

	
	/*장바구니 목록 보기*/
	@RequestMapping(value = "/{memberId}", method = RequestMethod.GET)
	public String cartPage(@PathVariable("memberId") String memberId, Model model) {
		
		model.addAttribute("cartInfo", cartService.selectCartList(memberId));
		
		return "cart/cart";
	}
	
	
	/*장바구니 수량 수정(추가)*/
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateCartPOST(CartDTO cartDTO) {
		
		cartService.modifyCart(cartDTO);
		
		return "redirect:/cart/"+cartDTO.getMemberId();
	}
	
	
	/*장바구니 삭제(row 삭제)*/
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteCartPOST(CartDTO cartDTO) {
		cartService.deleteCart(cartDTO.getCartNo());
		return "redirect:/cart/"+cartDTO.getMemberId();
	}

}