function [ output ] = gen_pp( input_d )
%generate perference matrix
dim=input_d;
sg_mat=zeros((dim*(dim-1))/2,dim);
sg_mat0=sg_mat;
idx=1;
for i=1:1:input_d
    
    for j=i+1:1:input_d
        sg_mat(idx,i)=-1;
        sg_mat(idx,j)=+1;
        idx=idx+1;
    end
    
end
output=[sg_mat sg_mat0;sg_mat0,sg_mat];

% make the matrix sparse
output=sparse(output);
end

