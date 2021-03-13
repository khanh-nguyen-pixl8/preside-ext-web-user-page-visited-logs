component output=false {

	public void function configure( required struct config ) output=false {
		var conf     = arguments.config;
		var settings = conf.settings ?: {};

		_setupCustomAdminNavigation( settings );
	}

	private void function _setupCustomAdminNavigation( settings ) {
		settings.adminConfigurationMenuItems.append( "websiteUserPageVisitAction" );
	}

}