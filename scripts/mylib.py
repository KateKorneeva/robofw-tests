from robot.libraries.BuiltIn import BuiltIn


def do_nothing():
    pass


def element_should_be_readonly(element):
    """Verifies that input field is not editable, because it has a
    'readonly' attribute
    """
    if not is_element_readonly(element):
        raise AssertionError("Element %s is editable (not readonly)." % element)


def is_element_readonly(locator):
    selenium = BuiltIn().get_library_instance('SeleniumLibrary')
    element = selenium.find_element(locator)

    return element.get_attribute('readonly') is not None
