from src.employee import Employee

# Positional arguments and keyword arguments
def print_args(*args, **kwargs):
    print(f"positional arguments: {args}")
    print(f"Keyword Arguments: {kwargs}")


ls = ['kash', 19, 20]
dict = {'age':25, 'degree': "MBA"}

# print_args(*ls, **dict, 1, 2) # ERROR #positional arguments can't be used after keywords arguments
# print_args(**dict, *ls) # ERROR
# print_args(**dict,2,3) # ERROR

print_args(*ls, 1, 2, **dict) 


if __name__ == '__main__':
    emp = Employee(100,'Krish', 'naik')
    emp.display()
