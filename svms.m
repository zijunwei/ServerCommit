% iteratively update models based on current model and new incoming
classdef svms
    properties(Constant)
        sigular_thres=1e-16;
        dim=109056;
        it=1;
        libsvm_path='/Users/zijunwei/Dev/MatlabLibs/libsvm/matlab';
    end;
    methods(Static)
        
        
        % linear kernel svm for all data
        % trD: d*n matrix for training data, each column is a FV, n is number of training instances
        % trLb: 12*n label matrix for training data
        % trLb(i,:) is binary lable vector for class i. trLb(i,j) is the label of video j for class i.
        function aps = kerSVM(C, trD, trLb, tstD, tstLb,classTxt)
            addpath(svms.libsvm_path);
            trK = trD'*trD;
            tstK = tstD'*trD;
            
            
            
            fprintf('Train SVMs\n');
            % suspicious
            trK = [(1:size(trK,1))', trK];
            tstK = [(1:size(tstK,1))', tstK];
            
            nAction = length(classTxt);
            aps = zeros(1, nAction);
            for i=1:nAction
                fprintf('training SVM model %d\n', i);
                trLb_i = trLb(i,:)';
                trLb_i(trLb_i == 0) = -1;
                
                tstLb_i = tstLb(i,:)';
                tstLb_i(tstLb_i == 0) = -1;
                
                aps(i)=svms.kerSVM_s(trK,trLb_i,tstK,tstLb_i,C);
                
            end;
            
            svms.printAP(classTxt,aps);
        end
        
        
        % single cate classification
        function ap=kerSVM_s(trK,trLb,tstK,tstLb,C)
            model = libsvmtrain(trLb, trK, sprintf('-t 4 -c %g -q', C));
            [~, ~, prob] = libsvmpredict(tstLb, tstK, model);
            prob = prob*model.Label(1);
            ap = ml_ap(prob, tstLb, 0);
        end
        
        
        
        % non linear svm:
         function aps = NLSVM(C, trD, trLb, tstD, tstLb,classTxt)
            addpath(svms.libsvm_path);

            
                      
            
            nAction = length(classTxt);
            aps = zeros(1, nAction);
            for i=1:nAction
                fprintf('training SVM model %d\n', i);
                trLb_i = trLb(i,:)';
                trLb_i(trLb_i == 0) = -1;
                
                tstLb_i = tstLb(i,:)';
                tstLb_i(tstLb_i == 0) = -1;
                
                aps(i)=svms.kerSVM_s(trD,trLb_i,tstD,tstLb_i,C);
                
            end;
            
            svms.printAP(classTxt,aps);
        end
        
        
       
        
        % lsssvm
        function aps = kerLSSVM(Lambda, trD, trLb, tstD, tstLb,classTxt)
            
            trK = trD'*trD;
            tstK = tstD'*trD;
            
            fprintf('Train SVMs\n');
            
            
            
            
            nAction = length(classTxt);
            aps = zeros(1, nAction);
            for i=1:nAction
                fprintf('training LSSVM model %d\n', i);
                trLb_i = trLb(i,:)';
                trLb_i(trLb_i == 0) = -1;
                
                tstLb_i = tstLb(i,:)';
                tstLb_i(tstLb_i == 0) = -1;
                
                
                aps(i)=svms.kerLSSVM_s(trK,trLb_i,tstK,tstLb_i,Lambda);
            end;
            
            
            svms.printAP(classTxt,aps);
            
            
        end
        
        
        
        
        function ap=kerLSSVM_s(trK,trLb,tstK,tstLb,lambda)
            n=length(trLb);
            s=ones(n,1)/(n);
            Lambda0=lambda*n;
            [alphas,b]=ML_Ridge. kerRidgeReg(trK,trLb,Lambda0,s);
            prob=tstK*alphas+b;
            ap= ml_ap(prob, tstLb, 0);
        end
        
        
        
        
        function printAP(classTxt,aps)
            for i=1:length(classTxt)
                cls = classTxt{i};
                fprintf('%-11s & %.1f \\\\ \\hline\n', cls, 100*aps(i));
            end
            fprintf('%-11s & %.1f \\\\ \\hline\n', 'mean', 100*mean(aps));
        end
        
        
        % iterative both, start from the postive sum up and negative sum up
        
    end
end