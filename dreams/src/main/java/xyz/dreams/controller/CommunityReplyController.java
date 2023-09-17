package xyz.dreams.controller;

import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import xyz.dreams.dto.CommunityReplyDTO;
import xyz.dreams.service.CommunityReplyService;

@RestController
@RequiredArgsConstructor
@RequestMapping("/reply")
public class CommunityReplyController {
	private final CommunityReplyService communityReplyService;
	
	/*댓글 등록*/
	@PostMapping("/register")
	public String register(@RequestBody CommunityReplyDTO reply) {
		System.out.println("****************************");
		System.out.println(reply);
		System.out.println("****************************");
		communityReplyService.addCommunityReply(reply);
		return "success";
	}
	
	/*댓글 출력 목록*/
	@GetMapping("/list/{commNo}")
	public List<CommunityReplyDTO> list(@PathVariable int commNo, HttpSession session) throws Exception{

		return communityReplyService.getCommunityReplyList(commNo);
		
	}
	
		
	/*댓글 삭제*/
	@DeleteMapping("/delete/{commReNo}")
	public String deleteReply(@PathVariable int commReNo) {
		communityReplyService.deleteCommunityReply(commReNo);
		return "success";
	}
	
	
	/*댓글 수정*/
	@PutMapping("/update/{commReNo}")
	/*
	public Map<String, Object> updateReply(@PathVariable int commReNo, @PathVariable String commReCont){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			CommunityReplyDTO reply = new CommunityReplyDTO();
			reply.setCommNo(commReNo);
			reply.setCommReCont(commReCont);
			communityReplyService.modifyCommunityReply(reply);
			map.put("result", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
		}
		return map;
	}
	*/
	public String updateReply(@RequestBody CommunityReplyDTO reply) {
		System.out.println("****************************");
		System.out.println(reply);
		System.out.println("****************************");
		communityReplyService.modifyCommunityReply(reply);
		return "success";
	}
	
}
