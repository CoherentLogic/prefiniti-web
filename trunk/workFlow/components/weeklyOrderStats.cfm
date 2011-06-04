<cfquery name="orderD" datasource="webwarecl">
	SELECT 
		count(ordered_date) AS DailyCount, 
		date(ordered_date) AS od
	FROM 
		projects 
	WHERE 
		ordered_date>=#CreateODBCDate(DateFormat(DateAdd("d", "-#DayOfWeek(Now()) - 1#", Now()), "mm/dd/yyyy"))# 
	AND 
		ordered_date<=#CreateODBCDate(DateFormat(DateAdd("d", 5, DateAdd("d", "-#DayOfWeek(Now()) - 1#", Now())), "mm/dd/yyyy"))# 
	GROUP BY DATE(ordered_date)
</cfquery>

<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">Orders Placed This Week</h3>

<div align="center" style="margin-top:30px;">
<cfchart xAxisTitle="Date" yAxisTitle="Orders Placed" chartwidth="400" show3d="yes">

   <cfchartseries 
      type="bar"
      query="orderD" 
      valueColumn="DailyCount" 
      itemColumn="od"
	  seriescolor="##3399CC"
      />

</cfchart>
</div>