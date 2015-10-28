<cfset test = "foo">

<cfoutput>#test#</cfoutput>
<br/>
<cfset listone="tree,frog,dog,cat">
<cfset listtwo="tree,pig,dog,bird">
<cfset result=compareLists(listone,listtwo)>
<br/>

<cfdump var="#result#">

<cffunction name="compareLists" access="public" returntype="struct" output="false" hint="Given two versions of a list, I return a struct containing the values that were added, the values that were removed, and the values that stayed the same.">
	<cfargument name="originalList" type="any" required="true" hint="List of original values." />
	<cfargument name="newList" type="any" required="true" hint="List of new values." />
	<cfset var local = StructNew() />
	
	<cfset local.results = StructNew() />
	<cfset local.results.addedList = "" />
	<cfset local.results.removedList = "" />
	<cfset local.results.sameList = "" />
	
	<cfloop list="#arguments.originalList#" index="local.thisItem">
		<cfif ListFindNoCase(arguments.newList, local.thisItem)>
			<cfset local.results.sameList = ListAppend(local.results.sameList, local.thisItem) />
		<cfelse>
			<cfset local.results.removedList = ListAppend(local.results.removedList, local.thisItem) />
		</cfif>
	</cfloop>
	
	<cfloop list="#arguments.newList#" index="local.thisItem">
		<cfif not ListFindNoCase(arguments.originalList, local.thisItem)>
			<cfset local.results.addedList = ListAppend(local.results.addedList, local.thisItem) />
		</cfif>
	</cfloop>
	
	<cfreturn local.results />
</cffunction>
