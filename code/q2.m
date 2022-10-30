rng(1); %setting the seed

N = [5, 10, 20, 40, 60, 80, 100, 500, 1000, 10000];
M = 100;
lambda = 5; %true value
alpha = 5.5;
beta = 1;
MLE = zeros([M length(N)]);
post_lambda = zeros([M length(N)]);
for i = 1:length(N)
    for j = 1:M
        X = rand([N(i) 1]);
        Y = - log(X)./lambda; %the dataset
        MLE(j, i) = 1/mean(Y); %ML estimate
        post_lambda(j, i) = (N(i) + alpha)/(sum(Y) + beta); %posterior mean with Gamma prior
    end
end

figure();
MLE = abs(MLE - lambda)./lambda;
boxplot(MLE, N);
xlabel('Sample Size')
ylabel('Relative Error')
title('Maximum Likelihood Estimate')

figure();
post_lambda = abs(post_lambda - lambda)./lambda;
boxplot(post_lambda, N);
xlabel('Sample Size')
ylabel('Relative Error')
title('Posterior Mean with Gamma Prior')