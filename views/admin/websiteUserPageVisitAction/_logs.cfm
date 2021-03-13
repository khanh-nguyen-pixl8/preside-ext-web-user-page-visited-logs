<cfparam name="args.logs" type="query" />
<cfscript>
	prevLogDate = Trim( rc.latestDate ?: "" );
	logDate     = prevLogDate.len() ? prevLogDate : DateFormat( args.logs.dateCreated[ 1 ], "yyyy-mm-dd" );
</cfscript>

<cfoutput>
	<cfif !prevLogDate.len()>
		#renderView( view="/admin/websiteUserPageVisitAction/_logDateBanner", args={ logDate = logDate } )#
	</cfif>
	<div class="timeline-items">
		<cfloop query="args.logs">
			<cfscript>
				websiteUserPageVisitActionData = QueryRowToStruct( args.logs, args.logs.currentRow );
				websiteUserPageVisitActionData.logDate = DateFormat( websiteUserPageVisitActionData.datecreated, "yyyy-mm-dd" );
				if ( IsJson( websiteUserPageVisitActionData.detail ) ) {
					websiteUserPageVisitActionData.detail = DeserializeJson( websiteUserPageVisitActionData.detail );
				}
				websiteUserPageVisitActionData.userLink = event.buildAdminLink( linkto="websiteUserPageVisitAction", queryString="user=" & websiteUserPageVisitActionData.user );

				websiteUserPageVisitActionData.actionLink      = event.buildAdminLink( linkto="websiteUserPageVisitAction", queryString="action=" & websiteUserPageVisitActionData.action );
				websiteUserPageVisitActionData.actionTitle     = translateResource( uri="auditlog.#websiteUserPageVisitActionData.type#:#websiteUserPageVisitActionData.action#.title", defaultValue=action.action );
				websiteUserPageVisitActionData.actionIconClass = translateResource( uri="auditlog.#websiteUserPageVisitActionData.type#:#websiteUserPageVisitActionData.action#.iconClass" );

				websiteUserPageVisitActionData.typeLink      = event.buildAdminLink( linkto="websiteUserPageVisitAction", queryString="type=" & websiteUserPageVisitActionData.type );
				websiteUserPageVisitActionData.typeTitle     = translateResource( uri="auditlog.#websiteUserPageVisitActionData.type#:title", defaultValue=websiteUserPageVisitActionData.type );
				websiteUserPageVisitActionData.typeIconClass = translateResource( uri="auditlog.#websiteUserPageVisitActionData.type#:iconClass" );

				if ( Len( Trim( websiteUserPageVisitActionData.identifier ) ) ) {
					websiteUserPageVisitActionData.recordLink = event.buildAdminLink( linkto="websiteUserPageVisitAction", queryString="recordId=" & websiteUserPageVisitActionData.identifier );
				}
			</cfscript>

			<cfif DateDiff( "d", websiteUserPageVisitActionData.logDate, logDate )>
				<cfset logDate = websiteUserPageVisitActionData.logDate />
				</div>
				#renderView( view="/admin/websiteUserPageVisitAction/_logDateBanner", args={ logDate = logDate } )#
				<div class="timeline-items">
			</cfif>

			#renderView( view="/admin/websiteUserPageVisitAction/_log", args=websiteUserPageVisitActionData )#
		</cfloop>
	</div>
</cfoutput>