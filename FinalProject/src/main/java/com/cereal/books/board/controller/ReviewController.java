package com.cereal.books.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cereal.books.board.model.service.ReviewService;
import com.cereal.books.board.model.vo.BookScrap;
import com.cereal.books.board.model.vo.Comment;
import com.cereal.books.board.model.vo.ReviewBoard;
import com.cereal.books.common.util.PageInfo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("board/br_board")
@SessionAttributes("loginMember")
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	@RequestMapping(value="/brBoardMain", method = {RequestMethod.GET})
	public ModelAndView mainView(
			ModelAndView model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "listLimit", required = false, defaultValue = "12") int listLimit) {
		
		List<ReviewBoard> list = null;
		
		int boardCount = service.getBoardCount();
		PageInfo pageInfo = new PageInfo(page, 5, boardCount, listLimit);
		
		System.out.println(boardCount);
		
		// remainDate 업데이트 하는 과정
		
		list = service.getBoardList(pageInfo);
		
		
//		for (ReviewBoard reviewBoard : list) {
//			
//			reviewBoard.setBrIsbn(null);
//		}
		
		
		
		model.addObject("list", list);
		model.addObject("pageInfo", pageInfo);
		model.setViewName("board/br_board/brBoardMain");
		
		System.out.println(list);
		System.out.println(model);
		return model;
	}

	@RequestMapping(value="/brBoardWrite", method = {RequestMethod.GET})
	public void brBoardWriteView() {
		
		//return "board/br_board/brBoardWrite";
	}
	
	
	@RequestMapping(value = "/brBoardWrite", method = {RequestMethod.POST})
	public ModelAndView brWrite(HttpServletRequest request, MultipartFile upload,
							ReviewBoard reviewboard, ModelAndView model)
			throws Exception {
		
		int result = 0;
		
		result = service.saveBoard(reviewboard);
		
		if(result > 0) {
			model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
			model.addObject("location", "/board/br_board/brBoardMain");
		} else {
			model.addObject("msg", "게시글 등록을 실패하였습니다.");
			model.addObject("location", "/board/list");
		}			
		
	
	model.setViewName("common/msg");
	
	return model;
	}
	

	@RequestMapping(value = "/imageUpload", method = { RequestMethod.POST })
	public void brWrite(HttpServletRequest request, HttpServletResponse response, MultipartFile upload)
			throws Exception {
		String renameFileName = null;
		log.info("upload 들어온다! ");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		// 파일 이름 가져오기
		String fileName = upload.getOriginalFilename();
		
		// file이 존재해야 로직실행되도록 null이 아니어야 하고, file 있으면 false이고 !붙여서 true로 로직 실행되도록 한다.
				if(upload != null && !upload.isEmpty()) {
					// 파일을 저장하는 로직 작성
					renameFileName = saveFileRename(upload, request);
					
					System.out.println(renameFileName);
					
//					if(renameFileName != null) {
//						board.setBoardOriginalFileName(upload.getOriginalFilename());
//						board.setBoardRenamedFileName(renameFileName);
//					}
				}
				
		// 파일을 바이트 배열로 변환
		byte[] bytes = upload.getBytes();

		// 이미지를 업로드할 디렉토리를 정해준다
		//String uploadPath = "C:\\finalproject\\final_project\\FinalProject\\src\\main\\webapp\\resources\\upload\\";
		String uploadPath = request.getServletContext().getRealPath("resources/upload/");
		OutputStream out = new FileOutputStream(new File(uploadPath + fileName));

		// 서버에 write
		out.write(bytes);

		// 성공여부 가져오기
		String callback = request.getParameter("CKEditorFuncNum");

		// 클라이언트에 이벤트 추가 (자바스크립트 실행)
		PrintWriter printWriter = response.getWriter(); // 자바스크립트 쓰기위한 도구

		String fileUrl = "http://localhost:8088/books/resources/upload/" + fileName;

		if (!callback.equals("1")) { // callback이 1일 경우만 성공한 것
			printWriter.println("<script>alert('이미지 업로드에 실패했습니다.');" + "</script>");

		} else {
			log.info("upload img 들어온다! " + fileUrl);

			printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl
					+ "','이미지가 업로드되었습니다.')" + "</script>");
			
		}
		
		printWriter.flush();
		
		
	}
	
	
	// ck에디터 이미지 이름 변경하는 메소드
		private String saveFileRename(MultipartFile upload, HttpServletRequest request) {
			// file 이름 뒤에 등록하는 시간 붙여서 rename에 넣기
			String originalFileName = null;
			String renameFileName = null;
			
			originalFileName = upload.getOriginalFilename();
			String ext = (originalFileName.lastIndexOf(".") == -1) ? "" : originalFileName.substring(originalFileName.lastIndexOf("."));
			renameFileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) +	ext;
			
			return renameFileName;
		}
	
	// 북리뷰글 쓸때 책검색창 열기
	@RequestMapping(value="/bookSearch")
		public void brBookSearch() {
			

		}


	@RequestMapping(value="/brReviewDetail", method = {RequestMethod.GET})
	public ModelAndView brReviewDetail(@RequestParam("brNo") int brNo, ModelAndView model) {
		ReviewBoard reviewboard = service.findBoardByNo(brNo);
		
		model.addObject("board", reviewboard);
		model.setViewName("board/br_board/brReviewDetail");
		
		return model;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/brBookScrap", method= {RequestMethod.POST})
	public void brBookScrap(@RequestParam("userId") String userId, @RequestParam("bsIsbn") String bsIsbn, @RequestParam("scrap") String scrap,
			@RequestParam("scrapNo") String scrapNo, BookScrap bookscrap) {
		int result = 0;
		result = service.saveScrapStatus(bookscrap);
	}
	
	@RequestMapping(value = "/insertComment" , method = {RequestMethod.POST})
	@ResponseBody
    public int insertComment(Comment comment, ModelAndView model) throws Exception{
        
        int result = 0;
		
    	result = service.insertComment(comment);
    	
    	if(result > 0) {
			model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
			model.addObject("location", "/board/br_board/brBoardMain");
		} else {
			model.addObject("msg", "게시글 등록을 실패하였습니다.");
			model.addObject("location", "/board/list");
		}			
            
        
        return result;
    }
	
	@RequestMapping(value="/commentList/{brNo}", method = {RequestMethod.GET})
	@ResponseBody
	public ModelAndView getCommentList(@PathVariable int brNo, ModelAndView model) throws Exception {
		List<Comment> list = null;
		
		list = service.listComment(brNo);
		return model;
	}
	
	
}