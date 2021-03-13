<cfscript>
	actions     = prc.actions   ?: queryNew( '' );
	dateFrom    = rc.dateFrom   ?: "";
	dateTo      = rc.dateTo     ?: "";
	user        = rc.user       ?: "";
	identifier  = rc.identifier ?: "";
	loadMoreUrl = event.buildAdminLink( linkTo='websiteUserPageVisitAction.loadMore', queryString='dateFrom=#dateFrom#&dateTo=#dateTo#&user=#user#&identifier=#identifier#&page=' );
	filtered    = Len( Trim( dateFrom & dateTo & user & identifier ) ) > 0;

	event.include( "/js/admin/specific/auditTrail/" );
</cfscript>

<cfoutput>
	<div class="top-right-button-group">
		<a class="pull-right inline" href="##filter-form" data-toggle="collapse">
			<button class="btn btn-info">
				<i class="fa fa-filter"></i>
				#translateResource( "cms:toggle.filter.btn")#
			</button>
		</a>
	</div>

	<cfif filtered>
		<p class="alert alert-info">
			<i class="fa fa-fw fa-filter"></i> #translateResource( uri="cms:audittrail.filtered.message" )#
			<span class="pull-right">
				<a href="#event.buildAdminLink( linkTo='audittrail' )#">#translateResource( "cms:audittrail.filtered.clear.filter" )#</a>
				|
				<a href="##filter-form" data-toggle="collapse">#translateResource( "cms:audittrail.filtered.show.filter" )#</a>
			</span>
		</p>
	</cfif>

	<div class="collapse" id="filter-form">
		<form class="form-horizontal" method="get" action="">
			#renderForm(
				  formName = "websiteUserPageVisitAction.filter"
				, context  = "admin"
			)#

			<br>

			<div class="row">
				<div class="col-md-offset-2">
					<a href="##filter-form" data-toggle="collapse">
						<i class="fa fa-fw fa-reply bigger-110"></i>
						#translateResource( "cms:cancel.btn" )#
					</a>

					&nbsp;

					<button class="btn btn-info" type="submit" tabindex="#getNextTabIndex()#">
						<i class="fa fa-fw fa-check bigger-110"></i>
						#translateResource( "cms:ok.btn" )#
					</button>
				</div>
			</div>
		</form>
	</div>

	<cfif actions.recordcount>
		<div class="timeline-container" id="audit-trai">
			#renderView( view="/admin/websiteUserPageVisitAction/_logs", args={ logs=actions } )#
		</div>
		<div class="load-more text-center">
			<a class="load-more-logs btn btn-primary" data-load-more-target="audit-trai" data-href="#loadMoreUrl#"><i class="fa fa-plus-circle"></i> #translateResource( uri='cms:auditTrail.loadMore' )#</a>
		</div>
	<cfelse>
		<p><em>#translateResource( uri='cms:auditTrail.noData' )#</em></p>
	</cfif>
</cfoutput>