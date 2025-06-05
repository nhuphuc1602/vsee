from .base_page import BasePage

class WaitingRoomPage(BasePage):
    def verify_chat_received(self, expected_message):
        self.selib.page_should_contain(expected_message)
