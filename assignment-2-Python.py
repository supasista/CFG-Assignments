import requests

# Set the maximum limit for the number of questions
MAX_QUESTIONS = 25

# Ask the user for the number of questions they want
num_questions = int(input("How many questions would you like? "))

# Boolean to check if the limit is exceeded
limit_exceeded = num_questions > MAX_QUESTIONS

if limit_exceeded:
    print(f"The number of questions requested exceeds the limit of {MAX_QUESTIONS}. Please try again.")
else:
    # Define the URL with the user-specified number of questions
    URL = f"https://opentdb.com/api.php?amount={num_questions}"

    res = requests.get(URL)

    if res.status_code == 200:
        data = res.json()
        questions = data.get('results', [])
        
        # Open a file to write the questions to
        with open('questions.txt', 'w') as file:
            for i, question in enumerate(questions, start=1):
                formatted_question = f"Question {i}: {question['question'][:-1]}?"
                print(formatted_question)  # Print to console
                file.write(formatted_question + '\n')  # Write to file
    else:
        print(f"Failed to retrieve data: {res.status_code}")


"""
boolean value used: limit_exceeded
data structure used:
for loop or while loop
string slicing: I removed the last character of each question with [:-1] and added it back '?'
At least two inbuilt functions used: print() and enumerate()
API used: "https://opentdb.com/api.php?amount={num_questions}"
"""

