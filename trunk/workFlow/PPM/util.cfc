<cfcomponent displayname="util" hint="utility functions">
	<cffunction name="parse_line" access="public" returntype="array"> 
    	<cfargument name="input_line" type="string" required="yes" hint="The line to be parsed">
        
        <cfparam name="tmpArray" default="">
        <cfparam name="ch" default="">
        <cfparam name="buildup" default="">
        <cfparam name="qword" default="">
        <cfparam name="iqbu" default="">
        <cfparam name="iqch" default="">
        <cfparam name="line_length" default="">
        <cfset line_length = len(input_line)>
		
		<cfset tmpArray = ArrayNew(1)>
        
        <cfscript>			
			
			for(i = 1; i <= line_length; i++) {
				ch = mid(input_line, i, 1);
				
				if(ch == '"') {
					for(j = i + 1; j <= line_length; j++) {
						iqch = mid(input_line, j, 1);
						
						if(iqch == '"') {
							cword = iqbu;
							i = j + 1;
							arrayappend(tmpArray, cword);
							iqbu = "";
							cword = "";
							buildup = "";
							break;
						}
						else {
							iqbu = iqbu & iqch;
						}
					}					
				}
				else if(ch == ' ') {
					cword = buildup;
					arrayappend(tmpArray, cword);
					buildup = "";
				}				
				else {
					buildup = buildup & ch;
				}
							
			}
			cword = buildup;
			arrayappend(tmpArray, cword);
			
		</cfscript>
        
        <cfreturn #tmpArray#>
	</cffunction>        

</cfcomponent>