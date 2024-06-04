function [M, A, B] = bank_marketing()
% Load and preprocess the Bank Marketing dataset

% Load the dataset from the CSV file
data = csvread('bank.csv');

% Vector of sensitive attributes
sensitive = data(:,1);

% Define the sensitive attribute: 1 for aged (>= 65 years) and 0 for < 65 years
normalized = (sensitive >= 65);

% Extract the sensitive attribute from the dataset
data = data(:,2:end);

% Get the number of instances (m) and features (n)
[m,n] = size(data);

% Center and normalize the dataset
data = (data - repmat(mean(data), m, 1)) ./ repmat(std(data), m, 1);

% Data for sensitive group (aged >= 65 years)
data_sensitive = data(find(normalized), :);

% Data for non-sensitive group (aged < 65 years)
data_nonsensitive = data(find(~normalized), :);

% Center and normalize the sensitive attributes
data_nonsensitive = (data_nonsensitive - repmat(mean(data_nonsensitive), size(data_nonsensitive, 1), 1));
data_sensitive = (data_sensitive - repmat(mean(data_sensitive), size(data_sensitive, 1), 1));

% Assign the data to output variables
A = data_nonsensitive;
B = data_sensitive;
M = [A; B];

end