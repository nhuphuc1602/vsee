*** Variables ***
${CONTINUE_BROWSER}          xpath=//h3[text()='Continue on this browser']
${REMINDER_MODAL_TITLE}      xpath=//div[@id="ReminderModal"]//h4[@class="modal-title"]
${REMINDER_MODAL_OK}         xpath=//button[@class='btn btn-primary']
${MINI_QUICK_HELP_CLOSE}     xpath=//div[@id='MiniQuickHelpModal']//button[@aria-label='Close']
${JITSI_FRAME}               id=jitsiConferenceFrame0
${JOIN_NOW}                  xpath=//div[@aria-label='Join Now']
${WAITING_ROOM}              id=WaitingRoom
${OPEN_CHAT}                 xpath=//div[@aria-label='Open chat']
${CHAT_MESSAGE_NOTICE}       xpath=//div[text()='Messages can be seen by all participants in this visit.']
${CHAT_INPUT}                xpath=//input[@placeholder='Type your message here']
${MESSAGE_BUBBLE}            xpath=//div[@class="webchat-message-bubble"]
${LEAVE_MEETING}             xpath=//div[@aria-label='Leave the meeting']
${LEAVE_CALL_BTN}            xpath=//a[@class='btn btn-leaveCall']
${END_VISIT_BTN}             xpath=//a[text()='End Visit']
${VISIT_SURVEY}              id=VisitSurvey
${CLINIC_GUEST}              id=ClinicGuest
${JITSI_FRAME}               id=jitsiConferenceFrame0
${CALL_SCREEN}               id=controller-visits
${ROOM_NAME_TITLE}           xpath=//span[@class='top-status--show-room-name']
${TEXT_ME_POPUP}             xpath=//a[@data-bind='click: openPhone' and @class='button']
${VISIT_CHAT_BTN}            xpath=//button[@id='group-chat']