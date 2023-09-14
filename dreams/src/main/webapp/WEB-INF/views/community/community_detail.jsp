<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>


<!-- 커뮤니티 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/community.css">

<!--전체(글+댓글)-->
<div class="communityDetail">
    <!--글제목+내용+목록으로-->
    <div class="communityDetailWrtten">
        <!--글 경로 (커뮤니티 > 꿈들의 모임)-->
        <div class="communityDetailPath">
            <h5>커뮤니티  >  꿈들의 모임</h5>
        </div>

        <!--글 컨테이너-->
        <div class="communityDetailContainer">
               <!--글 제목-->
               <div class="headwrap">
                	<div class="pageNo" style="width: 5%;"><c:out value="${pageInfo.commNo }"/></div>
                   <div class="title" style="width: 65%;"><strong><c:out value="${pageInfo.commTitle }"/></strong></div>
                   <div class="writer" style="width: 15%; text-align: right;">작성자 : <c:out value="${pageInfo.memberId }"/></div>
                   <div class="wrtieDate" style="width: 15%; text-align: right;">작성일자 : <c:out value="${pageInfo.commDate }"/></div>
               </div>
               
   
               <!--글 내용-->
               <div class="communityDetailContainerBody" style="white-space: pre;"><c:out value="${pageInfo.commCont}"/></div>
        </div>

            <!--버튼-->
            <div class="communityDetailBtn">
            	<a href=<c:url value="/community"/>>목록으로</a>
                	<c:if test="${member.memberId == pageInfo.memberId }" >
                		<a href=<c:url value="/community/modify?commNo=${pageInfo.commNo }"/> role="button" id="modify_btn" name="modify_btn">수정하기</a>
						<a href="#" role="button" id="delete_btn" name="delete_btn" onclick="deleteCheck()">삭제하기</a>   
					</c:if>
			</div>

            
           	<form id="infoForm" action=<c:url value="/community/detail"/> method="get">
				<input type="hidden" id="commNo" name="commNo" value='<c:out value="${pageInfo.commNo}"/>'>
			</form>
    </div>
    
    <!--[댓글]-->

    <!--댓글 입력폼-->
    <form id="communityReplyFrom" name=register> 
        <div class="communityReply">
            <div class="onekan" >
	            <input type="hidden" id="memberId" value="${member.memberId }">
	            <!--댓글 입력칸-->
	            <textarea class="communityReplyText" id="commReCont"></textarea>
				<div class="count_btn">
		            <!--글자수 카운팅(최대 400자로 이거 나중에 메소드 걸어주기)-->
		            <div class="countwritten"><strong>0자</strong>/400자</div>
		            <!--댓글 입력 버튼-->
		            <div><button type="button" class="onekanBtn" id="addBtn">댓글쓰기</button></div>
	            </div>
        	</div>
        </div>
    </form>
    <div>
        <div class="communityReplyCount">
            <!-- ((여기에 개수 세는 기능 넣어야함)) -->
            <strong style="color: green;">0개</strong>의 댓글이 등록되었습니다.
        </div>
    	<div id="replyList"></div>
	</div>

    <!--댓글 목록-->
    <!--댓글 개수 알려줌-->
    <!-- <div class="communityReplyView">
        <div class="communityReplyCount">
            ((여기에 개수 세는 기능 넣어야함))
            <strong style="color: green;">0개</strong>의 댓글이 등록되었습니다.
        </div>
        댓글 목록뷰
        <ul>
            <li style="border-top: none">
                <p class="txt">제작년에 반짝하고 끝날 줄 알았는데 계속 상위권ㄷㄷㄷ 꼴림즈한테 이런날이 오다니</p>
                <div>
                    <p>아이디</p>
                    <p>작성날짜</p>
                    <p>
                        <a href="답글 링크" class="commentReRely">답글</a>
                    </p>
                </div>
            </li>
            <div class="addReplyWrite" id=""></div>
                대댓글
                <div class="communityReReplyView"  
                        style="background:#f9f9f9;padding:20px 35px; margin-left:30px;">
                    <p class="text">제 생애 이런날이 다시올 줄 몰랐습니다ㅠㅠㅠ</p>
                    <div>
                        <p>아이디</p>
                        <p>작성날짜</p>
                        <p>
                            <a href="답글 링크" class="commentReRely">답글</a>
                        </p>
                    </div>
                </div>
            <div class="addReplyWrite" id=""></div>
            대댓글 작성폼(답글 누르지 않을때는 div에 style="display: none" 전부 설정해놓으면 된다.)
            <div class="communityReReplyForm">
                <div class="communityReReplyWrite">
                    <textarea></textarea>
                    <a href="#">답글 달기</a>
                    <a href="#">답글 취소</a>
                </div>
                글자수 카운팅(최대 400자로 이거 나중에 메소드 걸어주기)
                <div class="countwritten"><strong>0자</strong>/400자</div>
            </div>
        </ul>
    </div>
     -->
</div>


<!-- JS -->
<script type="text/javascript">

//삭제 확인하기
function deleteCheck(){
   if(confirm("정말 삭제하시겠습니까?")==true){
      location.href="<c:url value='/community/delete?commNo=${pageInfo.commNo}'/> ";
      alert("삭제되었습니다.");
   }else if(confirm==false){
      alert("취소되었습니다.");
   }
}



//댓글 출력
function replyDisplay() {
	$.ajax({
		type: "get",
		url: "<c:url value="/reply/list"/>/"+${pageInfo.commNo },
		dataType: "json",
		success: function(result) {
			if(result.length == 0) {
				var html="<div style='width: 600px; border-bottom: 1px solid black;'>";
				html+="댓글이 하나도 없습니다.";
				html+="</div>";
				$("#replyList").html(html);
				return;
			}
			
			var html="";
			$(result).each(function() {
				html+="<div class='commentList' style='border-top: none'>";
				//html+="<div>";
				html+="<p><strong>"+this.memberId+"</strong></p>";
				html+="<p class='txt'>"+this.commReCont+"</p>";
				html+="<p class='commentList_date'>"+this.commReDate+"</p>";
				//html+="<p><a href='#' class='commentReRely'>답글</a></p>";
				//html+="</div>";
				html+="</div>";
			})
			$("#replyList").html(html);
		},
		error: function(xhr) {
			alert("에러 = "+xhr.status);
		}
	});
}

replyDisplay();


//댓글 등록
$("#addBtn").click(function() {
	var writer=$("#memberId").val();
	
	var content=$("#commReCont").val();
	if(content == "") {
		alert("댓글 내용을 입력해 주세요.");
		return;
	}
	$("#content").val("");
	$.ajax({
		type: "post",
		url: "<c:url value="/reply/register"/>",
		contentType: "application/json",
 		data: JSON.stringify({"memberId": writer, "commReCont": content, "commNo": ${pageInfo.commNo}}),
		
		dataType: "text",
		success: function(result) {
			if(result=="success") {
				//댓글 입력 성공시 댓글이 입력됨
				replyDisplay();
				//댓글을 쓴 후 댓글 창에 기입한 텍스트 사라지도록 함
				$("#memberId").val("");
				$("#commReCont").val("");
			}
		},
		error: function(xhr) {
			alert("로그인이 필요한 서비스입니다.");
		}
	});
});

</script>