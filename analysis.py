import pandas as pd
import numpy as np
from sklearn import linear_model
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA

dataset = pd.read_csv('output.csv')[['win', 'time', 'score']]
dataset = dataset[dataset.time <= 0.5]
dataset, test_data = dataset.iloc[:-5], dataset.iloc[-5:]

x_col = ['win', 'time']
X = dataset[x_col]
Y = dataset.score

win_dataset = dataset[dataset.win == True]
lose_dataset = dataset[dataset.win == False]


pca = PCA(n_components=2, random_state=42)
fit_x, fit_y = pca.fit_transform(X, Y).T

fit_win_x, _ = pca.fit_transform(win_dataset[x_col]).T
fit_lose_x, _ = pca.fit_transform(lose_dataset[x_col]).T

fig = plt.figure(figsize=(10, 10))
m1 = plt.scatter(fit_win_x, win_dataset.score, 10, "blue")
m2 = plt.scatter(fit_lose_x, lose_dataset.score, 10, "green")
plt.show()

model = linear_model.LinearRegression()

model.fit(X, Y)

y_pred_line_win = model.predict(win_dataset[x_col])
y_pred_line_lose = model.predict(lose_dataset[x_col])

fit_pred_win_X, fit_pred_win_Y = pca.fit_transform(win_dataset[x_col], pd.DataFrame(y_pred_line_win)[0]).T
fit_pred_lose_X, fit_pred_lose_Y = pca.fit_transform(lose_dataset[x_col], pd.DataFrame(y_pred_line_lose)[0]).T

fig = plt.figure(figsize=(10, 10))
m1 = plt.scatter(fit_win_x, win_dataset.score, 10, color="blue")
m2 = plt.scatter(fit_lose_x, lose_dataset.score, 10, color="green")
plt.plot(fit_pred_win_X, y_pred_line_win, color="blue", linewidth=2, label="Prediction")
plt.plot(fit_pred_lose_X, y_pred_line_lose, color="green", linewidth=2, label="Prediction")
plt.show()

comparison_table = pd.DataFrame(columns=['win', 'time', 'score', 'predicted_score'])

comparison_table.win = test_data.win
comparison_table.time = test_data.time
comparison_table.score = test_data.score 
comparison_table.predicted_score = comparison_table.apply(lambda row: model.predict(pd.DataFrame(columns = x_col).append(row[x_col]))[0], axis=1)

print(comparison_table)



