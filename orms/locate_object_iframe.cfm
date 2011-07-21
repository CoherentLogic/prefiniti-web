<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="/css/gecko.css" />

<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<cfset orms_rec = CreateObject("component", "OpenHorizon.Storage.ObjectRecord").Get(URL.orms_id)>
<cfif orms_rec.r_has_location NEQ 0>
	<cfset hasloc = true>
    <cfset lat = orms_rec.r_latitude>
	<cfset lon = orms_rec.r_longitude>
<cfelse>
	<cfset hasloc = false>
</cfif>

<cfif NOT hasloc>
	<script type="text/javascript">
        var map = null;
        var geocoder = null;
        function locationLoaded()
        {
            geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(32.30339559581623, -106.76542664909363);
            var myOptions = {
              zoom: 10,
              center: latlng,
              mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById("map_canvas"),
                myOptions);
                
            google.maps.event.addListener(map, 'click', function(event) {
                populateLocation(event.latLng);
            });
        }
        
        
        function codeAddress() {
            var address = document.getElementById("address_search").value;
            geocoder.geocode( { 'address': address}, function(results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                populateLocation(results[0].geometry.location);
                map.setCenter(results[0].geometry.location);
                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
              } else {
                alert("Geocode was not successful for the following reason: " + status);
              }
            });
        }
    
        function populateLocation(location)
        {
            SetValue('latitude', location.lat());
            SetValue('longitude', location.lng());
            
        }
        
        function searchAddress(e)
        {
            if (window.event) { 
                e = window.event; 
            }
            if (e.keyCode == 13) {
                codeAddress();
            }
        }
    </script>
<cfelse>								<!--- this object has a location --->
	<script type="text/javascript">
        var map = null;
        var geocoder = null;
        function locationLoaded()
        {            
			geocoder = new google.maps.Geocoder();
			<cfoutput>
            var latlng = new google.maps.LatLng(#lat#, #lon#);			
			</cfoutput>
            var myOptions = {
              zoom: 10,
              center: latlng,
              mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById("map_canvas"),
                myOptions);
			var marker = new google.maps.Marker({map: map, position: latlng});				
                
            google.maps.event.addListener(map, 'click', function(event) {
                populateLocation(event.latLng);
            });
        }
        
	 	function codeAddress() {
            var address = document.getElementById("address_search").value;
            geocoder.geocode( { 'address': address}, function(results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                populateLocation(results[0].geometry.location);
                map.setCenter(results[0].geometry.location);
                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location
                });
              } else {
                alert("Geocode was not successful for the following reason: " + status);
              }
            });
        }
    
        
       
    
        function populateLocation(location)
        {
            SetValue('latitude', location.lat());
            SetValue('longitude', location.lng());
            
        }
        
       
    </script>
</cfif>
</head>


<body onload="locationLoaded();">
	<cfoutput>
    	
    	<form name="location_form" method="post" action="/orms/set_object_location.cfm" id="location_form" target="set_location">
        <table cellpadding="0" cellspacing="0">
        <tr>
        <td valign="top"> 
    	<div id="map_canvas" style="height:200px;width:350px;">
        
        </div>
        </td>
        <td valign="top">
        	<cfif orms_rec.CanWrite(session.user.r_pk)>
                <div style="padding:8px;" id="location_result">
                	<cfif NOT hasloc>
	                    <p>This #lcase(orms_rec.r_type)# has no location data.</p>
                        <p>You can choose a location by clicking on the map or searching for an address in the <em>Search Address</em> box.</p>
                        <input type="hidden" name="orms_id" id="orms_id" value="#url.orms_id#" />
                        <table>
                            <tr>
                            <td align="right"><strong>Search Address:</strong></td>
                            <td align="left"><input type="text" name="address_search" id="address_search" onkeypress="searchAddress(event);"/></td>
                            </tr>
                            <tr>
                            <td align="right"><strong>Latitude:</strong></td>
                            <td align="left"><input type="text" id="latitude" name="latitude" /></td>
                            </tr>
                            <tr>
                            <td align="right"><strong>Longitude:</strong></td>
                            <td align="left"><input type="text" id="longitude" name="longitude" /></td>
                            </tr>
                        </table>
                        
                        <label><input type="checkbox" id="dontask" name="dontask"  <cfif orms_rec.r_ask_location EQ 0>checked</cfif>/>Don't prompt for location again</label>                        
					<cfelse>
                    	<p>This #lcase(orms_rec.r_type)# has location data.</p>
                        <p>You can change the location by clicking on the map or searching for an address in the <em>Search Address</em> box.</p>
                        <input type="hidden" name="orms_id" id="orms_id" value="#url.orms_id#" />
                        <table>
                            <tr>
                            <td align="right"><strong>Search Address:</strong></td>
                            <td align="left"><input type="text" name="address_search" id="address_search" onkeypress="searchAddress(event);"/></td>
                            </tr>
                            <tr>
                            <td align="right"><strong>Latitude:</strong></td>
                            <td align="left"><input type="text" id="latitude" name="latitude" value="#lat#" /></td>
                            </tr>
                            <tr>
                            <td align="right"><strong>Longitude:</strong></td>
                            <td align="left"><input type="text" id="longitude" name="longitude" value="#lon#" /></td>
                            </tr>
                        </table>
                        
                        <label><input type="checkbox" id="dontask" name="dontask" <cfif orms_rec.r_ask_location EQ 0>checked</cfif>/>Don't prompt for location again</label>                        
                   	</cfif>
                                    
                    
                                    
                    
                </div>
            <cfelse>
                <div style="padding:8px;" id="location_result">
                    <p>This #lcase(orms_rec.r_type)# has no location data.</p>
                    
                    <p>You can choose a location by clicking on the map or searching for an address in the <em>Search Address</em> box.</p>
                                    
                    <input type="hidden" name="orms_id" id="orms_id" value="#url.orms_id#" />
                    <table>
                        <tr>
                        <td align="right"><strong>Search Address:</strong></td>
                        <td align="left"><input type="text" name="address_search" id="address_search" onkeypress="searchAddress(event);"/></td>
                        </tr>
                        <tr>
                        <td align="right"><strong>Latitude:</strong></td>
                        <td align="left"><input type="text" id="latitude" name="latitude" /></td>
                        </tr>
                        <tr>
                        <td align="right"><strong>Longitude:</strong></td>
                        <td align="left"><input type="text" id="longitude" name="longitude" /></td>
                        </tr>
                    </table>
                    
                    <label><input type="checkbox" id="dontask" name="dontask"/>Don't prompt for again</label>                        
                </div>
			</cfif>            
        </td>
        </tr>
        </table>
        </form>
    </cfoutput>
</body>
</html>
