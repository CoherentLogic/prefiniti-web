<cfoutput>#DateFormat(DateAdd("d", "-#DayOfWeek(Now()) - 1#", Now()), "mm/dd/yyyy")#</cfoutput>