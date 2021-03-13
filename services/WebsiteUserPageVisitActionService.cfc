/**
 * Provides logic for interacting Preside's [[auditing|Audit log system]]
 *
 * @singleton
 * @presideservice
 * @autodoc
 */
component displayName="Audit Service" {

// CONSTRUCTOR
	/**
	 * @dao.inject presidecms:object:website_user_action
	 */
	public any function init( required any dao ) {
		_setDao( arguments.dao );

		return this;
	}

// PUBLIC METHODS
	public query function getActions(
		  numeric page      = 1
		, numeric pageSize  = 10
		, string  dateFrom  = ""
		, string  dateTo    = ""
		, string  user      = ""
		, string  identifier = ""
	) {
		var filter       = "";
		var filterDelim  = "";
		var params       = {};
		var extraFilters = [ { filter={ action="pagevisit", type="request" } } ];

		if ( IsDate( arguments.dateFrom ) ) {
			filter = "webiste_user_action.datecreated >= :datefrom";
			params.datefrom = { value=arguments.dateFrom, type="cf_sql_timestamp" };
		}

		if ( IsDate( arguments.dateTo ) ) {
			filter &= filterDelim & "webiste_user_action.datecreated <= :dateTo";
			params.dateTo = { value=arguments.dateTo, type="cf_sql_timestamp" };
		}

		if ( Len( Trim( arguments.user ) ) ) {
			extraFilters.append( { filter={ user=arguments.user } } );
		}

		if ( Len( Trim( arguments.identifier ) ) ) {
			extraFilters.append( { filter={ identifier=arguments.identifier } } );
		}

		if ( !Len( Trim( filter ) ) ) {
			filter = {};
		}

		var subset = _getDao().selectData(
			  selectFields = [ "website_user_action.id" ]
			, filter       = filter
			, filterParams = params
			, orderby      = "website_user_action.datecreated desc"
			, maxRows      = arguments.pageSize
			, startRow     = ( ( arguments.page - 1 ) * arguments.pageSize ) + 1
			, extraFilters = extraFilters
		);

		subset = subset.recordCount ? ValueArray( subset.id ) : [];

		return _getDao().selectData(
			  filter       = { "website_user_action.id" = subset }
			, orderby      = "website_user_action.datecreated desc"
			, selectFields = [
				  "website_user_action.id"
				, "website_user_action.type"
				, "website_user_action.datecreated"
				, "website_user_action.action"
				, "website_user_action.detail"
				, "website_user_action.uri"
				, "website_user_action.user_ip"
				, "website_user_action.user_agent"
				, "website_user_action.identifier"
				, "user.email_address"
				, "user.display_name as known_as"
				, _getDao().getDbAdapter().escapeEntity( "website_user_action.user" )
			 ]
		);
	}

// PRIVATE GETTERS AND SETTERS
	private any function _getDao() {
		return _dao;
	}
	private void function _setDao( required any dao ) {
		_dao = arguments.dao;
	}
}