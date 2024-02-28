<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="API TEST4"></c:set>

<%@ include file="../common/head.jspf"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 이동시키기</title>

</head>
<body>

	<div id="map" style="width: 100%; height: 350px;"></div>
	 <!-- 지도 위에 표시될 마커 카테고리 -->
	
	<p>
		<button class="btn btn-outline" type="button" onclick="setCenter()">지도 중심좌표 이동시키기</button>
		<button class="btn btn-outline" type="button" onclick="panTo()">지도 중심좌표 대전으로 이동시키기</button>
		<button class="btn btn-outline" type="button" onclick="hideMarkers()">마커 감추기</button>
    	<button class="btn btn-outline" type="button" onclick="showMarkers()">마커 보이기</button>
	</p>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef50bc8210ed6065bd9b724884224a1c"></script>
	<script>
	
	var MARKER_WIDTH = 33, // 기본, 클릭 마커의 너비
	    MARKER_HEIGHT = 36, // 기본, 클릭 마커의 높이
	    OFFSET_X = 12, // 기본, 클릭 마커의 기준 X좌표
	    OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
	    OVER_MARKER_WIDTH = 40, // 오버 마커의 너비
	    OVER_MARKER_HEIGHT = 42, // 오버 마커의 높이
	    OVER_OFFSET_X = 13, // 오버 마커의 기준 X좌표
	    OVER_OFFSET_Y = OVER_MARKER_HEIGHT, // 오버 마커의 기준 Y좌표
	    SPRITE_MARKER_URL = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markers_sprites2.png', // 스프라이트 마커 이미지 URL
	    SPRITE_WIDTH = 126, // 스프라이트 이미지 너비
	    SPRITE_HEIGHT = 146, // 스프라이트 이미지 높이
	    SPRITE_GAP = 10; // 스프라이트 이미지에서 마커간 간격

	var markerSize = new kakao.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
	    markerOffset = new kakao.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
	    overMarkerSize = new kakao.maps.Size(OVER_MARKER_WIDTH, OVER_MARKER_HEIGHT), // 오버 마커의 크기
	    overMarkerOffset = new kakao.maps.Point(OVER_OFFSET_X, OVER_OFFSET_Y), // 오버 마커의 기준 좌표
	    spriteImageSize = new kakao.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기

	var positions = [  // 마커의 위치
	        new kakao.maps.LatLng(33.44975, 126.56967),
	        new kakao.maps.LatLng(33.450579, 126.56956),
	        new kakao.maps.LatLng(33.4506468, 126.5707)
	    ],
    selectedMarker = null; // 클릭한 마커를 담을 변수
	
		var lat;
		var lon;
// 		주차장
		async function getData2() {
			const API_KEY = 'ef50bc8210ed6065bd9b724884224a1c';
			const url = 'https://www.yuseong.go.kr/ys_parking/ysparkingList/ORP/getJSONData.do?_wadl&type=json';
			const response = await fetch(url);
			const data = await response.json();
			
			console.log("data", data);
			console.log(data.response);
			console.log(data.response.body);
			console.log(data.response.header);
			console.log(data.response.body.items);
			console.log(data.response.body.items[0]);
			console.log(data.response.body.items[0].item.addr);
			console.log(data.response.body.items[0].item.latitude);
			console.log(data.response.body.items[0].item.longitude);
			
			lat = data.response.body.items[0].item.latitude;
			lon = data.response.body.items[0].item.longitude;
		}
		getData2();


		// 		카카오지도
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
// 		// 지도에 마커를 표시합니다
// 		marker.setMap(map);

		// 지도를 클릭했을때 클릭한 위치에 마커를 추가하도록 지도에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    // 클릭한 위치에 마커를 표시합니다 
		    addMarker(mouseEvent.latLng);             
		});
		
		// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
		var markers = [];

		// 마커 하나를 지도위에 표시합니다 
		addMarker(new kakao.maps.LatLng(33.450701, 126.570667));

		// 마커를 생성하고 지도위에 표시하는 함수입니다
// 		function addMarker(position) {
// 		    밑에 addMarker쪽에 합쳐서 추가함, 중복된거때문에 기능이 안될때가 많음
// 		    잘 찾아봐야한다.
// 		}
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
// 		    var resultDiv = document.getElementById('clickLatlng'); 
// 		    resultDiv.innerHTML = message;
		    
		});
		
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도 타입 컨트롤을 지도에 표시합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);


		function setCenter() {
			// 이동할 위도 경도 위치를 생성합니다 
			var moveLatLon = new kakao.maps.LatLng(33.452613, 126.570888);
			// 지도 중심을 이동 시킵니다
			map.setCenter(moveLatLon);
		}
		function panTo() {
			// 이동할 위도 경도 위치를 생성합니다 
			var moveLatLon = new kakao.maps.LatLng(lat, lon);
			// 지도 중심을 부드럽게 이동시킵니다
			// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
			map.panTo(moveLatLon);
		}
		
		//시작시 마커위치 지도 중심으로 자동옮김 
		kakao.maps.event.addListener(map, 'tilesloaded', displayMarker);

		function displayMarker() {
		    
		    // 마커의 위치를 지도중심으로 설정합니다 
		    marker.setPosition(map.getCenter()); 
		    marker.setMap(map); 

		    // 아래 코드는 최초 한번만 타일로드 이벤트가 발생했을 때 어떤 처리를 하고 
		    // 지도에 등록된 타일로드 이벤트를 제거하는 코드입니다 
		    // kakao.maps.event.removeListener(map, 'tilesloaded', displayMarker);
		}
		
		
		// 지도 위에 마커를 표시합니다
		for (var i = 0, len = positions.length; i < len; i++) {
		    var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
		        originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
		        overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
		        normalOrigin = new kakao.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
		        clickOrigin = new kakao.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
		        overOrigin = new kakao.maps.Point(gapX * 2, overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표
		        
		    // 마커를 생성하고 지도위에 표시합니다
		    addMarker(positions[i], normalOrigin, overOrigin, clickOrigin);
		}

		
		
		function addMarker(position, normalOrigin, overOrigin, clickOrigin) {

		    // 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
		    var normalImage = createMarkerImage(markerSize, markerOffset, normalOrigin),
		        overImage = createMarkerImage(overMarkerSize, overMarkerOffset, overOrigin),
		        clickImage = createMarkerImage(markerSize, markerOffset, clickOrigin);
		    
		    // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: position,
		        image: normalImage
		    });

// 		    // 마커를 생성합니다
// 		    var marker = new kakao.maps.Marker({
// 		        position: position
// 		    });
	
		    // 마커가 지도 위에 표시되도록 설정합니다
		    marker.setMap(map);
		    
			// 생성된 마커를 배열에 추가합니다
			markers.push(marker);
		    
		    // 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
		    marker.normalImage = normalImage;

		    // 마커에 mouseover 이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'mouseover', function() {

		        // 클릭된 마커가 없고, mouseover된 마커가 클릭된 마커가 아니면
		        // 마커의 이미지를 오버 이미지로 변경합니다
		        if (!selectedMarker || selectedMarker !== marker) {
		            marker.setImage(overImage);
		        }
		    });

		    // 마커에 mouseout 이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'mouseout', function() {

		        // 클릭된 마커가 없고, mouseout된 마커가 클릭된 마커가 아니면
		        // 마커의 이미지를 기본 이미지로 변경합니다
		        if (!selectedMarker || selectedMarker !== marker) {
		            marker.setImage(normalImage);
		        }
		    });

		    // 마커에 click 이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {

		        // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
		        // 마커의 이미지를 클릭 이미지로 변경합니다
		        if (!selectedMarker || selectedMarker !== marker) {

		            // 클릭된 마커 객체가 null이 아니면
		            // 클릭된 마커의 이미지를 기본 이미지로 변경하고
		            !!selectedMarker && selectedMarker.setImage(selectedMarker.normalImage);

		            // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
		            marker.setImage(clickImage);
		        }

		        // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
		        selectedMarker = marker;
		    });
		}

		// MakrerImage 객체를 생성하여 반환하는 함수입니다
		function createMarkerImage(markerSize, offset, spriteOrigin) {
		    var markerImage = new kakao.maps.MarkerImage(
		        SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
		        markerSize, // 마커의 크기
		        {
		            offset: offset, // 마커 이미지에서의 기준 좌표
		            spriteOrigin: spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
		            spriteSize: spriteImageSize // 스프라이트 이미지의 크기
		        }
		    );
		    
		    return markerImage;
		}
		
		// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
		function setMarkers(map) {
		    for (var i = 0; i < markers.length; i++) {
		        markers[i].setMap(map);
		    }            
		}
		
		// "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
		function showMarkers() {
		    setMarkers(map)    
		}

		// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
		function hideMarkers() {
		    setMarkers(null);    
		}

	
	</script>
</body>
</html>

<%@ include file="../common/foot.jspf"%>