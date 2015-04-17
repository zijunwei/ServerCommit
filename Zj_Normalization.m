classdef Zj_Normalization
    properties(Constant)
        
    end;
    
    methods(Static)
        function checkRow(A)
             if size(A,2)==1
               error('function l2: Input has to be a row vector!'); 
            end
        end
        function output_data=l2(A)
            Zj_Normalization.checkRow(A);
            output_data=bsxfun(@times, A, 1./max( sqrt(sum(A.^2, 2)),eps));
        end
        
         function output_data=l2_col(A)
             A=A';
            Zj_Normalization.checkRow(A);
            output_data=bsxfun(@times, A, 1./max( sqrt(sum(A.^2, 2)),eps));
            output_data=output_data';
        end
        function output_data=l1(A)
            Zj_Normalization.checkRow(A);
            output_data=bsxfun(@times, A, 1./(max(sum(A, 2), eps)));
        end
        % power law normalziaiton alpha=0.5
        function row_out=power2(input)
           
            % Power-law normalized, alpha = 0.5
               row_out = sign(input).*sqrt(abs(input)); 
        end
       
        function row_out=scale_01_row(input)
            row_min=min(input,[],2);
            row_max=max(input,[],2);
            input=input-repmat(row_min,1,size(input,2));
            row_out=diag(1./row_max)*input;
            
        end

    end
    
end