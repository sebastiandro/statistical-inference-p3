data_raw = readtable('./fruitfly.txt');
housed_with_8_females = data_raw(data_raw{:,1} == 8, :);
housed_with_1_female = data_raw(data_raw{:,1} == 1, :);
group1 = housed_with_8_females(housed_with_8_females.x_type_ == 1,:);
group2 = housed_with_1_female(housed_with_1_female.x_type_ == 1,:);
group3 = housed_with_8_females(housed_with_8_females.x_type_ == 0,:);
group4 = housed_with_1_female(housed_with_1_female.x_type_ == 0,:);
group5 = data_raw(data_raw{:,1} == 0, :);

n = length(data); %% Number of counties