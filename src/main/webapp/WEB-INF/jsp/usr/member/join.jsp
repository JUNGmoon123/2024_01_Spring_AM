<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN"></c:set>
<%@ include file="../common/head.jspf"%>
<style type="text/css">
.rs-msg {
	border: 5px solid green;
	margin-top: 10px;
	padding: 10px;
	font-size: 2rem;
}
</style>
<script>
	function callByAjaxV4() {
		var form = document.form1;
		var loginId = form.loginId.value;
// 		var loginPw = form.loginPw.value;
// 		var name = form.name.value;
// 		var cellphoneNum = form.cellphoneNum.value;
// 		var nickname = form.nickname.value;
// 		var email = form.email.value;
		
		
		$.get('../member/doPlusJoin', {
			loginId : loginId,
// 			loginPw : loginPw,
// 			name : name,
// 			cellphoneNum : cellphoneNum,
// 			nickname : nickname,
// 			email : email
			
		}, function(data) {
			$('.rs-msg').text(data.msg);
		}, 'json');

	}
</script>

<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<form name="form1" action="../member/doJoin" method="POST">
			<table class="join-box table-box-1" border="1">
				<tbody>
					<tr>
						<th>아이디</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="아이디를 입력해주세요" name="loginId" />
							<button class="btn btn-outline btn-info" onclick="callByAjaxV4();" type="button" >검사</button>
							<div class="rs-msg"></div>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="비밀번호를 입력해주세요" name="loginPw" />
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="이름을 입력해주세요" name="name" />
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="닉네임을 입력해주세요" name="nickname" />
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="전화번호를 입력해주세요" name="cellphoneNum" />
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="이메일을 입력해주세요" name="email" />
						</td>
					</tr>

					<tr>
						<th></th>
						<td>
							<input class="btn btn-outline btn-info" type="submit" value="가입" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn btn-outline" class="" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>