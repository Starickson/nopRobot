"""
Ce fichier permet la configuration du driver chrome ou firefox au choix à definir dans la keyword 
ce fichier sera appelé en librairie dans le fichier keyword.robot
"""
import random
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from robot.api.deco import keyword


def get_driver_path_with_browser(browser_name):
    if browser_name.lower() == 'chrome':
        driver_path = ChromeDriverManager().install()
    elif browser_name.lower() == 'firefox':
        driver_path = GeckoDriverManager().install()
    print(driver_path)
    return driver_path




#Merci à https://haibgit.blogspot.com/2021/06/how-to-use-webdrivermanager-in.html