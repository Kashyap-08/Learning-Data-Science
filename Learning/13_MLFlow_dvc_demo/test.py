import mlflow
import warnings

# Ignore warning 
warnings.filterwarnings("ignore")


def calculate(x, y):
    return (x * y)

if __name__ == "__main__":
    with mlflow.start_run():
        x, y = 129, 200
        result = calculate(x, y)
        print("Here is my result: ",result)
        mlflow.log_param("X", x)
        mlflow.log_param("y", y)
        mlflow.log_param("result", result)
        mlflow.end_run()