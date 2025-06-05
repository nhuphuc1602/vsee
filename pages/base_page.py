from SeleniumLibrary import SeleniumLibrary

class BasePage:
    def __init__(self, lib: SeleniumLibrary):
        self.selib = lib
