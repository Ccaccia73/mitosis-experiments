function [Fnorm, Fmean, Fstd] = normalizeF( inputF, Fmean, Fstd )
%normalizeF normalize feature matrix
%   trasforms the feature matrix (1 column per feature) so that
%	each feature has 0 mean and 1 std

switch nargin
	case 1
		Fmean = mean(inputF);
		Fstd = std(inputF);
	
	case 2
		Fstd = std(inputF);
		if length(Fmean) ~= size(inputF,2)
			disp('Wrong dimension in mean vector')
			return
		end
		
	otherwise
		if length(Fmean) ~= size(inputF,2)
			disp('Wrong dimension in mean vector')
			return
		end

		if length(Fstd) ~= size(inputF,2)
			disp('Wrong dimension in STD vector')
			return
		end
		
end
	
Fnorm = bsxfun(@rdivide,bsxfun(@minus,inputF,Fmean),Fstd);

end

