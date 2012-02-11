<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Live Location</title>
<link rel="stylesheet" type="text/css" href="/css/gecko.css" />

<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.orms_id)>
<cfset mobile_device = CreateObject("component", "OpenHorizon.Objects.MobileDevice").Open(URL.device_id)>
<cfset location = mobile_device.GetLocation()>
	
<cfoutput>
	<script type="text/javascript">
        var map = null;        
        function locationLoaded()
        {
            geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(#location.latitude#, #location.longitude#);
            var myOptions = {
              zoom: 17,
              center: latlng,
              mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById("map_canvas"),
                myOptions);
                
            var marker = new google.maps.Marker({
			  map: map,
			  position: new google.maps.LatLng(#location.latitude#, #location.longitude#),
			  title: '#orms_rec.r_name#'
			});
			
			
			var circle = new google.maps.Circle({
			  map: map,
			  radius: #location.accuracy#,    
			  fillColor: '##2957A2',
			  strokeColor: 'red'
			});
			circle.bindTo('center', marker, 'position');
			
			
			google.maps.event.addListener(marker, 'click', function() {
			    var contentString = "<strong>#orms_rec.r_name#</strong><br><br>";
			    //contentString += "Latitude: #location.latitude#<br>";
			    //contentString += "Longitude: #location.longitude#<br>";
			    contentString += "Accuracy: #location.accuracy#m<br>";
			    contentString += "Bearing: #location.bearing#<br>";
			    contentString += "Speed: #location.speed#<br>";
			    contentString += "Fix Time: #DateFormat(location.fixtime, 'mm/dd/yyyy')# #TimeFormat(location.fixtime, 'h:mm tt')#<br>";
			    contentString += "Comment: #location.comment#";
  
			    			 
			    
			    var infowindow = new google.maps.InfoWindow();
			    infowindow.setContent(contentString); // contentString can be html as far as i  know whose style you can override
			    infowindow.setPosition(latlng);
			    infowindow.open(map);
			});
        }
                     
    </script>
</cfoutput>	
</head>


<body onload="locationLoaded();">
	   			
	<div id="map_canvas" style="height:230px;width:580px;">
	        
    </div>        
</body>
</html>
