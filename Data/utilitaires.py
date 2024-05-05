import random
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from robot.api.deco import keyword




@keyword
def get_random_number():
    """
    Retourne un nombre aléatoire entre 0 et 6.
    """
    return random.randint(0,6)