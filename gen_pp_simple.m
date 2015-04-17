function [ output ] = gen_pp_simple( input_d )
%generate perference matrix
dim=input_d;
sg_mat=zeros(dim,dim);
sg_mat0=sg_mat;
for i=1:1:input_d-1
    sg_mat(i,i)=-1;
    sg_mat(i,i+1)=+1;
    

    
end
output=[sg_mat sg_mat0;sg_mat0,sg_mat];

% output=sparse(output);
end

