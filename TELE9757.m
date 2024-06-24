%% Error Correction

%r is a 7x11 matrix. All elements are bits from the lab, which are split
%into 11 bit strings with 7 elements each. 3 bits are thrown away.
r = [0 1 0 1 1 1 0;
0 1 0 0 0 0 1;
1 0 0 1 0 0 0
0 1 1 1 0 0 0;
0 0 1 1 1 1 1;
1 1 1 1 1 1 1;
0 1 0 0 1 1 0;
0 1 0 0 1 1 1;
1 1 1 0 1 1 0;
1 1 1 0 0 0 1;
1 0 0 1 0 1 1].'

%h is the [7,4] hamming matrix 
h = [1 1 1 0 1 0 0; 1 1 0 1 0 1 0; 0 1 1 1 0 0 1]

%empty array for syndrome 
s= zeros(3,11)
%calculating syndrome for each row in r. 
for i = 1:11
    s(:,i)= mod(h*r(:,i), 2)
end 

%These are all the possible error vectors that can be generated. 
Error_vectors=eye(7)

%these are the corrected errors: the syndrome is always column in h. 
%example: if syndrome is (1 1 0), which is the first column in h, then 
%error vector = (1 0 0 0 0 0 0)
%subtract error vector from each bit string to get answer. if syndrome is
%(0 0 0), then there are no errors. 
rc1 = mod(r(:,1)-Error_vectors(:,6),2).' %error vector (0 0 0 0 0 1 0), syndrome of (0 1 0)
rc2 = mod(r(:,2)-Error_vectors(:,1),2).' %error vector (1 0 0 0 0 0 0), syndrome of (1 1 0)
rc3 = mod(r(:,3)-Error_vectors(:,3),2).' %error vector (0 0 1 0 0 0 0), syndrome of (1 0 1)
rc4 = mod(r(:,4)-Error_vectors(:,7),2).' %error vector (0 0 0 0 0 0 1), syndrome of (0 0 1)
rc5 = mod(r(:,5)-Error_vectors(:,7),2).' %error vector (0 0 0 0 0 0 1), syndrome of (0 0 1)
rc6 = r(:,6).' %no error vector, syndrome of (0 0 0)
rc7 = mod(r(:,7)-Error_vectors(:,7),2).' %error vector (0 0 0 0 0 0 1), syndrome of (0 0 1)
rc8 = r(:,8).' %no error vector, syndrome of (0 0 0)
rc9 = mod(r(:,9)-Error_vectors(:,6),2).' %error vector (0 0 0 0 0 1 0), syndrome of (0 1 0)
rc10 = mod(r(:,10)-Error_vectors(:,3),2).' %error vector (0 0 1 0 0 0 0), syndrome of (1 0 1)
rc11 = mod(r(:,11)-Error_vectors(:,1),2).' %error vector (1 0 0 0 0 0 0), syndrome of (1 1 0)

%% Privacy Amplification

%rc is a 7x11 matrix. Each row is the key from the lab 
% which is split in 7 blocks
rc = [rc1; rc2; rc3; rc4; rc5; rc6; rc7; rc8; rc9; rc10; rc11].'

%Generator matrix with random. We choose t = 2 and s = 3 
G = [0	1	0	0	1	0	1; 1	0	1	0	0	1	1]

%empty matrix for key
key = zeros(2,11)

%each string of 7 corrected bits are multiplied by the G matrix to generate 2 bits
%this is done for all 11 bit strings, resulting in 22 bits for the key, going down from 77.  
for i = 1:11
    key(:,i) = mod(G*rc(:,i),2)
end 
%% Final Key
fprintf('The Key is: ')
for j = 1:11
    for k = 1:2
        fprintf('%d\t', key(k, j));
    end
end




























