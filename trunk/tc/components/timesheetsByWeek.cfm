<!--
	<wwafcomponent>This Week's Timesheets</wwafcomponent>
<wwafpackage>Time Management</wwafpackage>
<wwaficon>time.png</wwaficon>
-->
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> This Week's Timesheets</h3>
        </div>
    </div>
    <br />
    <br />
<cfmodule template="/controls/weekCalendarOld.cfm" viewer="/tc/components/tsDay.cfm" userid="#url.calledByUser#" showWeekend="false" startDate="firstDayOfWeek">
<div id="tsInfo" style="display:block;">
<p>No timesheet selected</p>
</div>