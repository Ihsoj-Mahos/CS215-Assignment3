rng(1); %setting the seed

N = [5, 10, 20, 40, 60, 80, 100, 500, 1000, 10000];
M = 100;
mu = 10; %true value
sigma = 4; %true value
MLE = zeros([M length(N)]);
post_mu_gaussian = zeros([M length(N)]);
post_mu_uniform = zeros([M length(N)]);
for i = 1:length(N)
    for j = 1:M
        X = randn([N(i) 1]);
        X = X .* sigma + mu; %the dataset
        Y = mean(X);
        post_mu_gaussian(j, i) = (Y + (10.5*16)/N(i))/(1 + (16/N(i))); %MAP for the gaussian case
        if Y > 11.5 %MAP for the uniform case
            post_mu_uniform(j, i) = 11.5;
        elseif Y < 9.5
            post_mu_uniform(j, i) = 9.5;
        else
            post_mu_uniform(j, i) = Y;
        end
        MLE(j, i) = Y; %MLE estimate is sample mean
    end
end
%plotting the boxplots
figure();
MLE = abs(MLE - mu)./mu;
boxplot(MLE, N);
xlabel('Sample Size')
ylabel('Relative Error')
title('Maximum Likelihood Estimate')

figure();
post_mu_gaussian = abs(post_mu_gaussian - mu)./mu;
boxplot(post_mu_gaussian, N);
xlabel('Sample Size')
ylabel('Relative Error')
title('MAP Estimate with Gaussian Prior')

figure();
post_mu_uniform = abs(post_mu_uniform - mu)./mu;
boxplot(post_mu_uniform, N);
xlabel('Sample Size')
ylabel('Relative Error')
title('MAP Estimate with Uniform Prior')