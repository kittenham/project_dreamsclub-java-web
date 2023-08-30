<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 커뮤니티 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/community.css">

<!--게시판 전체-->
<div class="communityContainer">
    <div class="commnunityTitle">
        <h2 style="color: #003E00;">꿈들의 모임</h2>
        <h4 style="margin-bottom: 40px;">자유롭게 의견을 나눠보세요.</h4>
    </div>

    <!--게시판테이블-->
    <div class="boardMain">
        <!--검색창-->
        <div class="boardSerchBig">
            <div class="boardSearch">
                <select class="selectBox" id="selectBox" style="width:13%;   border: 1px solid #000;  background-color: #fff;">
                    <option class="search_option" value="searchTitle">제목</option>
                    <option class="search_option" value="searchId">아이디</option>
                    <option class="search_option" value="searchContent">내용</option>
                </select>
                <!--돋보기 이미지-->
                <div class="searchTalk" style="width: 70%; padding: 0 10px" ><input type="text" id="searchTalk" placeholder="검색어를 입력해주세요."></div>
                <div class="searchBtn"><button type="button">검색</button></div>
            </div>
        </div>

        <!--테이블-->
        <div class="commnunityTable">
            <!--테이블 본체-->
            <div class="boardTable" style="margin: 0 auto">
                <table class="boardTableMain" width="1200px">
                    <thead>
                        <tr>
                            <th class="t1" scope="col" style="width: 100px">번호</th>
                            <th class="t2" style="width: 700px">제목</th>
                            <th class="t3" style="width: 150px">작성자</th>
                            <th class="t4" style="width: 150px">작성일</th>
                            <th class="t5" style="width: 100px">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${communityList }" var="community" >
	                        <tr class="boardTableList">
	                            <td class="t1"><c:out value="${community.commNo }"/></td>
	                            <td class="t2 text-left">
	                            	<a class="move" href="<c:url value="/community/detail?commNo=${community.commNo}"/>">
	                            		<c:out value="${community.commTitle }"/>
	                            	</a>
	                           	</td>
	                            <td class="t3"><c:out value="${community.memberId }"/></td>
	                            <td class="t4"><c:out value="${community.commDate }"/></td>
	                            <td class="t5"><c:out value="${community.commHit }"/></td>
	                        </tr>
	                    </c:forEach>                      
                    </tbody>
                </table>
                <form id="moveForm" method="get">
                </form>
            </div>

            <!--글쓰기 버튼-->
            <div class="writeBtnContainer">
                <div class="boardWriteBtn" style="text-align: right;">
                	<c:if test="${!empty(member)}">
                    	<a href=<c:url value="/community/write"/>>글쓰기</a>
                    </c:if>
                </div>
            </div>

            <!--페이징-->
            <div class="boardPageContainer">
                <div class="boardPage">
					<c:choose>
						<c:when test="${pager.startPage > pager.blockSize }">
							<a href="<c:url value="/community"/>?pageNum=${pager.prevPage}">《</a>
						</c:when>
						<c:otherwise>
							《
						</c:otherwise>
					</c:choose>	
					
					<c:forEach var="i" begin="${pager.startPage }" end="${pager.endPage }" step="1">
						<c:choose>
							<c:when test="${pager.pageNum != i  }">
								<a href="<c:url value="/community"/>?pageNum=${i}">${i}</a>
							</c:when>
							<c:otherwise>
								${i }
							</c:otherwise>
						</c:choose>	
					</c:forEach>
				
					<c:choose>
						<c:when test="${pager.endPage != pager.totalPage }">
							<a href="<c:url value="/community"/>?pageNum=${pager.nextPage}">》</a>
						</c:when>
						<c:otherwise>
							》
						</c:otherwise>
					</c:choose>	
                </div>
            </div>
        </div>

<script type="text/javascript"
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">

//글 등록 성공 경고창
$(document).ready(function(){
	let result = '<c:out value="${result}"/>';
	checkAlert(result);
	function checkAlert(result){
		if(result==""){
			return;
		} else if(result=="enroll success"){
			alert("글이 등록되었습니다.")
		}
	}
});
  

//<a>태그 동작코드
let moveForm=$("#moveForm");

$(".move").on("click", funtion(e){
	e.preventDefault();
	
	moveForm.append("<input type='hidden' name='commNo' value='"+$(this).attr("href")+"'>");
	moveForm.attr("action", "/community/detail");
	moveForm.submit();
}

</script>

    </div>
</div>

