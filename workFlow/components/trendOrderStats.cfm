<cfquery name="orderD" datasource="webwarecl">
	SELECT 
		count(clsJobNumber) AS DailyCount, 
		date(CAST(MID(clsJobNumber, 5) AS DATE)) AS od
	FROM 
		projects 
	WHERE
		clsJobNumber!=''
	GROUP BY od
</cfquery>

<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px; margin-bottom:0px; padding-botton:2px;">Ordering Trends</h3>

<div align="center" style="margin-top:30px;">
<cfchart xAxisTitle="Date" yAxisTitle="Orders Placed" chartwidth="800" chartheight="400" show3d="no" >

   <cfchartseries 
      type="step"
      query="orderD" 
	  seriescolor="##3399CC"
      valueColumn="DailyCount" 
      itemColumn="od"
      />

</cfchart>
</div>