subroutine Con_flux_Tur        !convective flux
    implicit none 
    integer::i
    integer::ncl,ncr                                       !the number of the left and the right cell
                                      
    real(8)::WT_av(2)
    real(8)::ux,uy,Vn                                     
                              
    !set FcT to zero
   
    FcT = 0.0
    do i = 1,nedges
        ncl=iedge(3,i)
        ncr=iedge(4,i)
        
        ux =  U_av(2,i) - 0.5*( U_Rot(1,iedge(1,i)) + U_Rot(1,iedge(2,i)) )
        uy =  U_av(3,i) - 0.5*( U_Rot(2,iedge(1,i)) + U_Rot(2,iedge(2,i)) )
        Vn = ux*vector(1,i) + uy*vector(2,i)
        ! Vn= U_av(2,i)*vector(1,i) + U_av(3,i)*vector(2,i)
       
        WT_av = U_av(1,i)*UT_av(:,i)
       
        if ( ncr .GT. 0) then
            !the left cell plus the convective flux
            
            FcT(:,ncl)  = FcT(:,ncl) + WT_av * Vn
            FcT(:,ncr)  = FcT(:,ncr) - WT_av * Vn
        else 
            FcT(:,ncl)  = FcT(:,ncl) + WT_av * Vn
        end if

    end do
    
end subroutine
