close all;
data_raw = readtable('./fruitfly.txt');
data_raw.Properties.VariableNames = {'females', 'type', 'lifespan', 'thorax', 'sleep'};
housed_with_8_females = data_raw(data_raw{:,1} == 8, :);
housed_with_1_female = data_raw(data_raw{:,1} == 1, :);

% Divide into groups
group1 = housed_with_8_females(housed_with_8_females.type == 1,:);
group2 = housed_with_1_female(housed_with_1_female.type == 1,:);
group3 = housed_with_8_females(housed_with_8_females.type == 0,:);
group4 = housed_with_1_female(housed_with_1_female.type == 0,:);
group5 = data_raw(data_raw{:,1} == 0, :); % :'(

groups_lifespan = [group1.lifespan,group2.lifespan,group3.lifespan,group4.lifespan,group5.lifespan];
groups_sleep_time = [group1.sleep,group2.sleep,group3.sleep,group4.sleep,group5.sleep];
groups_thorax = [group1.thorax, group2.thorax,group3.thorax,group4.thorax,group5.thorax];

% Task a, create boxplot for timespan
figure(1)
boxplot(groups_lifespan, 'Labels', {'Group 1', 'Group 2', 'Group 3', 'Group 4', 'Group 5'});
ylabel('Days alive')

% Task b, create boxplot for time asleep
figure(2);
boxplot(groups_sleep_time, 'Labels', {'Group 1', 'Group 2', 'Group 3', 'Group 4', 'Group 5'});
ylabel('Time asleep')

%% Task c, create scatterplot for lifespan vs throax length
figure(3)

hold on;
scatter(groups_lifespan(:), groups_thorax(:), 25, 'filled');
f = fit(groups_lifespan(:), groups_thorax(:), 'poly1');
plot(f, groups_lifespan(:), groups_thorax(:))
xlabel('Days Alive')
ylabel('Throax Length (mm)')


figure(4)
xlabel('Days Alive')
ylabel('Throax Length(mm)')
hold on;
scatter(group1.lifespan, group1.thorax, 25, 'r', 'filled')
%f = fit(group1.lifespan, group1.thorax, 'poly1');
%plot(f, 'r');


scatter(group2.lifespan, group2.thorax, 25, 'g', 'filled')
%f = fit(group2.lifespan, group2.thorax, 'poly1');
%plot(f, 'g');

scatter(group3.lifespan, group3.thorax, 25, 'b', 'filled')
%f = fit(group3.lifespan, group3.thorax, 'poly1');
%plot(f, 'b');

scatter(group4.lifespan, group4.thorax, 25, 'k', 'filled')
%f = fit(group4.lifespan, group4.thorax, 'poly1');
%plot(f, 'm');

scatter(group5.lifespan, group5.thorax, 25, 'c', 'filled')
%f = fit(group5.lifespan, group5.thorax, 'poly1');
%plot(f, 'c');

legend({'Group 1','Group 2','Group 3','Group 4', 'Group 5'},'Location','southeast')

%% Task d, create scatterplot for lifespan vs throax length
J = 25; % Number of fruit flies in each group
lifespan_matrix = [group1.lifespan group2.lifespan group3.lifespan group4.lifespan group5.lifespan];
% Y..
total_mean = mean(mean(lifespan_matrix));

SB = J*sum((mean(lifespan_matrix)-total_mean).^2);
SW = (J-1)*(sum(var(lifespan_matrix))); % SW or Error
STOT = SW + SB; 

% Created this to make sure that STOT2 == SW+SB (approximately)
STOT2 = sum(sum((lifespan_matrix-total_mean).^2));

group_means = mean(lifespan_matrix);
mean_pairs = nchoosek(group_means,2);
differences = abs(mean_pairs(:,1) - mean_pairs(:,2));

%% Task e
% Create a matrix where we rank the values
[~,R_matrix]=ismember(lifespan_matrix,sort(lifespan_matrix(:),'descend'));
[~, unique_indices] = unique(R_matrix);
duplicate_indices = setdiff(1:125, unique_indices);
duplicates = R_matrix(duplicate_indices);
unique_duplicates = unique(duplicates);

% The values which has the same rank get to share the average rank
for i = 1:length(duplicates)
    duplicate = duplicates(i);
    duplicates_in_R_matrix = R_matrix(R_matrix == duplicate);
    duplicates_sum = 0;
    for j = 1:length(duplicates_in_R_matrix)
        duplicates_sum = duplicates_sum + duplicate + j - 1;
    end
    duplicate_avg = duplicates_sum/length(duplicates_in_R_matrix);
    R_matrix(R_matrix == duplicate) = duplicate_avg;
end

rank_group_means = mean(R_matrix);
rank_mean_pairs = nchoosek(rank_group_means,2);
rank_differences = abs(rank_mean_pairs(:,1) - rank_mean_pairs(:,2));

%% Task f
