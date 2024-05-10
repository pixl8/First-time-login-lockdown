component {

	property name="loginService" inject="loginService";

	public void function firstTimeUserSetupAction( event, rc, prc ) {
		if ( !loginService.isUserDatabaseNotConfigured() ) {
			setNextEvent( url=event.buildAdminLink( linkTo="login" ) );
		}

		var emailAddress         = rc.email_address ?: "";
		var password             = rc.password ?: "";
		var passwordConfirmation = rc.passwordConfirmation ?: "";

		if ( !Len( Trim( emailAddress ) ) || !Len( Trim( password ) ) ) {
			setNextEvent( url=event.buildAdminLink( linkTo="login" ), persistStruct={
				message = "EMPTY_PASSWORD"
			} );
		}

		if ( password != passwordConfirmation ) {
			setNextEvent( url=event.buildAdminLink( linkTo="login" ), persistStruct={
				message = "PASSWORDS_DO_NOT_MATCH"
			} );
		}

		loginService.firstTimeUserSetup( emailAddress=emailAddress, password=password );
		setNextEvent( url=event.buildAdminLink( linkTo="login" ), persistStruct={
			message = "FIRST_TIME_USER_SETUP"
		} );
	}

}