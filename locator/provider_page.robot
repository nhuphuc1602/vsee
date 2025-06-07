*** Variables ***
${LOGIN_LINK}                /providers/login
${USERNAME_INPUT}            id=AppUserUsername
${PASSWORD_INPUT}            id=AppUserPassword
${SIGNIN_BUTTON}             id=btnSignIn
${USERNAME_SPAN}             xpath=//span[@class="username"]
${READY_FOR_VISITS}          xpath=//h4[text()="Ready for Visits (1)"]
${CALL_LINK}                 xpath=//a[@title='Call']
${TIMEZONE_POPUP}            id=sync-timezone
${TIMEZONE_CANCEL_BTN}       xpath=//div[@id='sync-timezone']//button[text()='Cancel']            