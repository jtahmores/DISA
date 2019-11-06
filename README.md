# DISA
Discriminative and domain invariant subspace alignment for visual tasks

This code implements Discriminative and domain invariant subspace alignment for visual tasks (DISA), which is published at Iran Journal of Computer Science (2019). You can download the paper from : "https://doi.org/10.1007/s42044-019-00037-y". 
# Motivation

Transfer learning and domain adaptation are promising solutions to solve the problem that the training set (source domain) and the test set (target domain) follow different distributions. In this method, we investigate the unsupervised domain adaptation in which the target samples are unlabeled whereas the source domain is fully labeled. We find distinct transformation matrices to transfer both the source and the target domains into the disjointed subspaces where the distribution of each target sample in the transformed space is similar to the source samples. Moreover, the marginal and conditional probability disparities are minimized across the transformed source and target domains via a non-parametric criterion, i.e., maximum mean discrepancy. Therefore, different classes in the source domain are discriminated using the between-class maximization and within-class minimization. Also, the local information of the source and target data including geometrical structures of the data are preserved via sample labels. The performance of the proposed method is verified using various visual benchmarks experiments. The average accuracy of our proposed method on three standard benchmarks is 70.63%. We compared our method against other state-of-the-art domain adaptation methods where the results prove that it outperforms other domain adaptation methods with 22.9% improvement.
# RUN
The original code is implemented using Matlab R2016a. For running the code, run the "Office_object.m" file.

# Datasets
We evaluate the effectiveness of our proposed method in comparison with baseline methods and other state-of-the-art domain adaptation methods for image classification tasks through visual datasets including Office dataset, CMU-PIE and MNIST and USPS datasets.

# Reference
Rezaei, S., & Tahmoresnezhad, J. (2019). Discriminative and domain invariant subspace alignment for visual tasks. Iran Journal of Computer Science, pp. 1-12. DOI: https://doi.org/10.1007/s42044-019-00037-y.




