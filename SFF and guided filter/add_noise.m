function imgOut = add_noise(imgIn,type,x,y)
% �������ܣ�Ϊͼ���������
% ���룺
%    imgIn������ͼ�ξ���Ϊ�Ҷ�ͼ��
%    type:�ַ�����ȡֵ�������������
%        ��˹������gaussian,����Ϊ(x,y)��Ĭ��ֵΪ(0,10)
%        ���������� rayleigh,����Ϊx��Ĭ��ֵΪ30
%        ٤�������� gamma,����Ϊ(x,y),Ĭ��ֵΪ(2,10)
%        ָ�������� exp������Ϊx,Ĭ��ֵΪ15
%        ���ȷֲ��� uniform������Ϊ(x.y)��Ĭ��ֵΪ(-20,20)
%        ���������� salt & pepper��ǿ��Ϊx��Ĭ��ֵΪ0.02
% �����
%    imgOut������������ͼ��

% Ԥ����
if ndims(imgIn)>=3
    imgIn=rgb2gray(imgIn);
end
[M,N]=size(imgIn);  % ����ͼ��Ĵ�С
% ����Ĭ����������
if nargin==1
    type='gaussian';
end
% ��ʼ����
switch lower(type)
    case 'gaussian'  % ��˹����
        if nargin<4
            y=10;
        end
        if nargin<3
            x=0;
        end
        % ������˹�ֲ������
        R=normrnd(x,y,M,N);
        imgOut=double(imgIn)+R;
        imgOut=uint8(round(imgOut));
    case 'uniform' % ���ȷֲ�
        if nargin<4
            y=20;
        end
        if nargin<3
            x=-20;
        end
        % �������ȷֲ������
        R=unifrnd(x,y,M,N);
        imgOut=double(imgIn)+R;
        imgOut=uint8(round(imgOut));
    case 'salt & pepper'  % ��������
        imgOut=imnoise(imgIn,'salt & pepper',x);
        if nargin<3
            x=0.02;
        end
        a1=rand(M,N)<x;  
        a2=rand(M,N)<x;
        imgOut=imgIn;
        imgOut(a1)=0; 
        imgOut(a2)=255;
    case 'rayleigh'        % ��������
        if nargin<3
            x=30;
        end
        R=raylrnd(x,M,N);
        imgOut=double(imgIn)+R;
        imgOut=uint8(round(imgOut));
    case 'exp'             % ָ������
        if nargin<3
            x=15;
        end
        R=exprnd(x,M,N);
        imgOut=double(imgIn)+R;
        imgOut=uint8(round(imgOut));
    case 'gamma'   % ٤������
        if nargin<4
            y=10;
        end
        if nargin<3
           x=2;
        end
        R=gamrnd(x,y,M,N);
        imgOut=double(imgIn)+R;
        imgOut=uint8(round(imgOut));
    otherwise
        error('Unkown distribution type')    
end
end