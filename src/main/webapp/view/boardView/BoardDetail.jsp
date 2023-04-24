<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="path" value="${pageContext.request.contextPath }" scope="application"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/view/boardView/boardDetail.css" rel="stylesheet" />
<script src="${path}/jq/jquery-3.6.4.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body class="main">
	<%@include file="../header.jsp"%>
	<div class="body">
		<div class="board_detail">
			<div class="board_title">
				<h1>${board_name }</h1>
			</div>
			<div class="board_list">
				<ul class="post_title">
				<c:forEach items="${pclist }" var="post" varStatus ="status">
				    
					<li id="${status.count}" value="${status.count}"> <span>${post.POST_TITLE }</span> [좋아요:<p class="like"></p>] [댓글:<p class="com_count">${post.COUNT }개</p>]</li>
					<input type="hidden" id="${status.count}create" value="${post.POST_CREATE }">
					<input type="hidden" id="${status.count}content" value="${post.POST_CONTENT }">
					<input type="hidden" id="${status.count}code" value="${post.POST_CODE }">
					<%-- <input type="hidden" id="${status.count}like" value="${post.POST_LIKE }"> --%>
				</c:forEach>
					</ul>
				<div class="posting">
					<button class="posting_btn"
						onclick="location.href='/shinDTown/post/create.jm?board_name=${board_name}'">글쓰기</button>
				</div>
			</div>

			<div class="post_detail" id="post_detail" name ="post_detail" value="1">
				<div class="post">

					<div class="title">
						<h3>제목 : </h3>
					</div>
					
					<div class="date" id ="date">
						<h3>날짜: </h3>
					</div>

					<div class="content">
						<p>내용:</p>
					</div>
					
					<div class="like">
						<p>좋아유:</p>
					</div>

				</div>

				<div class="comment">
					<form class="create_comment" method="POST" action="/shinDTown/comment/create.jm">
						<input type="hidden" id="post_code" name="post_code">
						<input type="text" class="comment" name="com_comment" > <input
							type="submit" value="등록">
					</form>
				</div>

				<div class="comment_list" id = "comments">
				</div>
		</div>
	</div>
	
	<script>
		$(document).ready(function() {
			$("li").click(function() {
				var title= $(this).find("span").text();
				var date = "#"+$(this).val()+"create";
				var content = "#"+$(this).val()+"content";
				var like = "#"+$(this).val()+"like";
				var code = "#"+$(this).val()+"code";
				
				console.log($(code).val());
				
				$("#post_detail .title h3 ").text(title);
				$("#post_detail .date h3 ").text($(date).val());
				$("#post_detail .content p ").text($(content).val());
				$("#post_detail .like p ").text($(like).val());
				$("#post_code").val($(code).val());
				$("#post_detail").css("visibility", "visible"); 
			});
		});
		
		
	</script>
	<script>
$(function(){
		$("li").on("click",function(){
			//page이동 없이 서버에 요청보내고 응답받기 :ajax
		$.ajax({
			url:"/shinDTown/comment/list.jm",
			data:{"post_code":$("#"+$(this).val()+"code").val()},
		
			success:function(data){
				$("#comments").html("");
				var responseData = eval("(" + data + ")");
				
// 				<div class='comment_list'>
// 				<div class='comms'>
// 					<div class='comm' id="comm">
// 						<p id="pppp"></p>
// 					</div>
// 				<button class='good'>공감</button>
// 				<p class='points'></p>
// 				</div>
// 			<hr class='line'/>
// 			</div>
				$.each(responseData.comlist, function(index,item){
 					var head = "<div class='comment_list'><div class='comms'><div class='comm'>";
 	 				var foot = "</div><button class='good'>공감</button><p class='points'></p></div><hr class='line'/></div>";
	 					
					$("#comments").append(head + 
 					"<p>"+item.COM_COMMENT+"</p>" +
 					foot);
				})
				
					
				
			},
			error:function(message){
				
				console.log(message);
			}
		});
		})
	});
	</script>
	
</body>
</html>