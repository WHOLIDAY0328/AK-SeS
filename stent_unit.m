function y=stent_unit(X)
    global model
   [i,~]=size(X);
    Y=zeros(i,2);
    for a=1:i
        model.param.set('LL_beta',X(a,1));
        model.param.set('LL_delta',X(a,2));
        model.param.set('LL_delta2',X(a,3));
        model.param.set('LL_gamma',X(a,4));
        model.param.set('LL_l',X(a,5));
        model.sol('sol1').run
        elastic_strain_energy = mphglobal(model,'solid.Ws_tot','dataset','dset1');
        Y(a,1) = abs(elastic_strain_energy(end));
        model.sol('sol2').run
        bending_stiffness = mphglobal(model,'solid.RMtotalx','dataset','dset2');
        Y(a,2) = abs(bending_stiffness(end));
    end
    Y(:,1)=abs(Y(:,1)-11.0624)./0.0732+1;
    Y(:,2)=3.5-(abs(Y(:,2))-0.001191472633907)./(1.3923e-05);
    y = [min(Y,[],2),Y(:,1),Y(:,2)];
end