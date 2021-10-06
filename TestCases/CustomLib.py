#This is the test Assignment

import random


class CustomLib(object):

    def get_random_name(self):
        username= ["standard_user", "problem_user", "performance_glitch_user"]
        return random.choice(username)


