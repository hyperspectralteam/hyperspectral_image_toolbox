function C=Spectral_clustering(data,k)

%Spectral_clustering is a clustering algorithm based on spectral theory.
% data is the matrix of vector coordinates.
% data should be a n*2 matrix.
% k is the number of classifications.

  n = size(data,1);
  W = zeros(n,n);             %Adjacency matrix
  q = 0.2;
  for i=1:n
      for j=1:n
          V=data(i,:)-data(j,:);
          if i==j
              W(i,j) = 0;
          else
              W(i,j) = exp(-norm(V)/(q*q));
          end
      end
  end

  d = sum(W, 2);
  D = diag(d);                 %Degree matrix
  L = D-W;                     %Laplace matrix
  [v,d] = eig(L);
  [~,ind] = sort(diag(d),'ascend');
  vs = v(:,ind);
  V = vs(:,1:k);
  C=kmeans(V,k);
end
  
  
     