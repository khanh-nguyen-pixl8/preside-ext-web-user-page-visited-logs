<cfparam name="args.action"          type="string" />
<cfparam name="args.type"            type="string" />
<cfparam name="args.email_address"   type="string" />
<cfparam name="args.known_as"        type="string" />
<cfparam name="args.userLink"        type="string" />
<cfparam name="args.actionLink"      type="string" />
<cfparam name="args.uri"             type="string" />
<cfparam name="args.identifier"       type="string" />
<cfparam name="args.user_ip"         type="string" />
<cfparam name="args.user_agent"      type="string" />
<cfparam name="args.actionTitle"     type="string" />
<cfparam name="args.actionIconClass" type="string" />
<cfparam name="args.typeLink"        type="string" />
<cfparam name="args.typeTitle"       type="string" />
<cfparam name="args.typeIconClass"   type="string" />
<cfparam name="args.recordLink"      type="string" default="" />
<cfparam name="args.logDate"         type="date" />
<cfparam name="args.datecreated"     type="date" />

<cfoutput>
	<div class="timeline-item clearfix" data-date="#args.logDate#">
		<div class="timeline-info">
			<img class="user-photo" src="//www.gravatar.com/avatar/#LCase( Hash( LCase( args.email_address ) ) )#?r=g&d=mm&s=40" alt="" />
			<span class="label label-info label-sm">#TimeFormat( args.datecreated, "HH:mm" )#</span>
		</div>
		<div class="widget-box transparent">
			<div class="widget-header widget-header-small">
				<h5 class="widget-title smaller">
					<i class="fa fa-fw fa-eye"></i>
					<a href="#args.actionLink#" class="blue">Visit page</a>
				</h5>
				<span class="widget-toolbar no-border">
					<i class="fa fa-fw bigger-110 fa-clock-o"></i>
					<a href="#args.userLink#">#args.known_as#</a> @
					#renderContent( renderer="datetime", data=args.dateCreated )#
				</span>
			</div>

			<div class="widget-body">
				<div class="widget-main">
					<a href="http://127.0.0.1:59602/admin/auditTrail/?_sid=68C7CAC6-AD1C-46D5-891C98C881598463&amp;user=5F943C1E-E1FA-463D-9A778C3518AAF69D">#args.known_as#</a> visited page <a href="event.buildAdminLink( linkTo="sites.editSite", queryString="id=" & ( args.identifier ?: "" ) )"><i class="fa fa-fw fa-file-o"></i> #renderLabel( "page", args.identifier )#</a>
				</div>
			</div>

			<div class="widget-header widget-header-small">
				<span class="widget-toolbar no-border light-grey">
					<strong>#translateResource( 'cms:websiteUserPageVisitAction.item.ip'         )#:</strong> #args.user_ip#
					<strong>#translateResource( 'cms:websiteUserPageVisitAction.item.user.agent' )#:</strong> #args.user_agent#
				</span>
			</div>
		</div>
	</div>
</cfoutput>