//package com.example.demo.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.example.demo.service.ArticleService;
//import com.example.demo.service.BoardService;
//import com.example.demo.service.ReactionPointService;
//import com.example.demo.service.ReplyService;
//import com.example.demo.util.Ut;
//import com.example.demo.vo.Reply;
//import com.example.demo.vo.ResultData;
//import com.example.demo.vo.Rq;
//
//import jakarta.servlet.http.HttpServletRequest;
//
//public class UsrReplyController {
//	
//	@Autowired
//	private Rq rq;
//
//	@Autowired
//	private ReplyService replyleService;
//
//	public UsrReplyController() {
//
//	}
//		
//	@RequestMapping("/usr/reply/doReply")
//	@ResponseBody
//	public String doReply(HttpServletRequest req, int memberId, String relTypecode, int relId, String body) {
//
//		Rq rq = (Rq) req.getAttribute("rq");
//		
//		if(rq.isLogined() == false) {
//			return Ut.jsHistoryBack("F-1", "로그인하고 이용하세요");
//		}
//		
//		if (Ut.isNullOrEmpty(body)) {
//			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
//		}
//
//		ResultData<Integer> writeArticleRd = ReplyService.writeReply(rq.getLoginedMemberId(), body);
//
//		return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id=" + relId);
//
//	}
//}
