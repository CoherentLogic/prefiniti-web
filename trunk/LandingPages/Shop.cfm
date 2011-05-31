<cfmodule template="/LandingPages/LandingHeader.cfm">
<table><tr><td>
<h3>Shop</h3>
<p style="margin-left:5px;">
<cfmodule template="/framework/link.cfm" perm="WF_CREATE" linkname="Place an order" url="/workflow/components/survey_order_form.cfm" help="Place an order"><br />
<cfmodule template="/framework/link.cfm" perm="WF_VIEW" linkname="View priority projects" url="/jobViews/priority.cfm" help="Priority Projects"><br />
<cfmodule template="/framework/link.cfm" perm="AS_LOGIN" linkname="Find companies" help="Find companies to do business with" url="/socialnet/components/find_companies.cfm">
</p></td></tr></table>