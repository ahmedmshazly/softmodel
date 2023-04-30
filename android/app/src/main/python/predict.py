import pickle

def predict(input_data):
    with open('path/to/your/sav/file/finalized_model.sav', 'rb') as file:
        model = pickle.load(file)
    prediction = model.predict(input_data)
    return prediction
