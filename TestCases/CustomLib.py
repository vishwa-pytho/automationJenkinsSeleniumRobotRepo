import random

class CustomLib(object):
    ROBOT_LIBRARY_SCOPE = 'TEST CASE'

    def get_random_name(self):
        username = ["standard_user", "problem_user", "performance_glitch_user"]
        return random.choice(username)

