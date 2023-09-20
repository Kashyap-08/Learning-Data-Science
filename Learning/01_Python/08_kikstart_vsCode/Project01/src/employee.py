class Employee:
    def __init__(self, id, first_name, last_name):
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
    
    def display(self):
        print(f"The Employee registered with id: {self.id} has first name as {self.first_name} and last name as {self.last_name}")