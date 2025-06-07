from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword
from selenium.webdriver.common.by import By

class JsClickKeyword:
    @property
    def driver(self):
        selenium_library = BuiltIn().get_library_instance('SeleniumLibrary')
        return selenium_library.driver

    @keyword("Js Click")
    def js_click(self, locator: str):
        """Click an element using JavaScript."""
        by, value = self._parse_locator(locator)
        element = self.driver.find_element(by, value)
        self.driver.execute_script("arguments[0].click();", element)

    def _parse_locator(self, locator: str):
        if "=" in locator:
            strategy, value = locator.split("=", 1)
            strategy = strategy.lower()
            if strategy == "xpath":
                return By.XPATH, value
            elif strategy == "id":
                return By.ID, value
            elif strategy == "name":
                return By.NAME, value
            elif strategy == "css":
                return By.CSS_SELECTOR, value
            elif strategy == "link":
                return By.LINK_TEXT, value
            # Thêm các strategy khác nếu cần
            else:
                raise ValueError(f"Unsupported locator strategy: {strategy}")
        elif locator.startswith("//"):
            return By.XPATH, locator
        else:
            raise ValueError(f"Invalid locator format: {locator}")

