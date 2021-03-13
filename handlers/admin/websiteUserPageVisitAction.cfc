component output="false" extends="preside.system.base.AdminHandler" {

	property name="pageVisitActionService" inject="WebsiteUserPageVisitActionService";

	function prehandler( event, rc, prc ) output=false {
		super.preHandler( argumentCollection = arguments );

		event.addAdminBreadCrumb(
			  title = translateResource( "cms:websiteUserPageVisitAction.page.crumb"  )
			, link  = event.buildAdminLink( linkTo="websiteUserPageVisitAction" )
		);
	}

	public void function index( event, rc, prc ) output=false {
		var dateFrom   = rc.dateFrom   ?: "";
		var dateTo     = rc.dateTo     ?: "";
		var user       = rc.user       ?: "";
		var identifier = rc.identifier ?: "";

		prc.actions = pageVisitActionService.getActions(
			  page       = 1
			, pageSize   = 10
			, dateFrom   = dateFrom
			, dateTo     = dateTo
			, user       = user
			, identifier = identifier
		);

		prc.pageTitle    = translateResource( "cms:websiteUserPageVisitAction.page.title"    );
		prc.pageSubTitle = translateResource( "cms:websiteUserPageVisitAction.page.subtitle" );
		prc.pageIcon     = "address-book";
	}

	public any function loadMore( event, rc, prc ) {
		var dateFrom   = rc.dateFrom   ?: "";
		var dateTo     = rc.dateTo     ?: "";
		var user       = rc.user       ?: "";
		var identifier = rc.identifier ?: "";
		var page       = Val( rc.page ?: 2 );
		var actions    = pageVisitActionService.getActions(
			  page       = page
			, pageSize   = 10
			, dateFrom   = dateFrom
			, dateTo     = dateTo
			, user       = user
			, identifier = identifier
		);

		if ( actions.recordCount ) {
			event.renderData( data=renderView( view="/admin/websiteUserPageVisitAction/_logs", args={ logs=actions } ), type="html" );
		} else {
			event.renderData( data="", type="html" );
		}
	}

}