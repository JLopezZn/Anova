

function main()
println("\n\n")
println("                                  ______                                    ")
println("      .'.       |..          |  .~      ~.  `.           .'       .'.       ") 
println("    .''```.     |  ``..      | |          |   `.       .'       .''```.     ") 
println("  .'       `.   |      ``..  | |          |     `.   .'       .'       `.   ")    
println(".'           `. |          ``|  `.______.'        `.'       .'           `.")    
println("                                                                           ")                                       
                                    
    println("\n\n\n*********************************************************")
    print("Ingresa cuantas muestras hay: ")
    x=readInt()
    print("Ingresa cuantas datos por muestra hay: ")
    n=readInt()
    muestras=[]
    op=1
    println("\n********************************************************")
    while op!=1 || op!=2

    println("\n\n\n*************************MENU***************************")
   
    println("* ¿Como desea leer las muestras?                       *")
    println("* [1]. CSV                                             *")
    println("* [2]. Manualmente                                     *")
    print("* Respuesta: ")
    op=asknumber()
    println("********************************************************")
   
   if op==1
   aux=leer_csv()
   muestras=convertir_matriz(aux,x,n)
   break
   elseif op==2
    muestras=llenar_muestras(x,n)
    break
      else
        println("Opcion Inexistente")
      end
   end

   

    medias=Medias(muestras)
    
    supermedia=media(medias)
    sce=SCE(muestras,medias)
    sct=SCT(muestras,supermedia)
    sctr=SCTR(medias,supermedia,n)
    cmt=sct/((n*length(muestras))-1)
    cmtr=sctr/(length(muestras)-1)
    cme=sce/((n*length(muestras)-length(muestras)))
    gl_num=(length(muestras)-1)
    gl_denom=(n*length(muestras))-(gl_num+1)
    fisher=cmtr/cme
    F= FDist(gl_num,gl_denom)
    pvalue=1-cdf(F,fisher)
    
    println("___________________________________________________________")
    println("| SCE                |  $sce")
    println("___________________________________________________________")
    println("| SCTR               |  $sctr")
    println("___________________________________________________________")
    println("| SCT                |  $sct")
    println("___________________________________________________________")
    println("| Grados de libertad |  $gl_num/$gl_denom")
    println("___________________________________________________________")
    println("| Fisher             |  $fisher")  
    println("___________________________________________________________")
    println("| p_value            |  $pvalue")
    println("__________________________________________________________\n\n\n ")
    println("_____________________________________________________________________________ \n")
    hipotesis(pvalue)
    println("_____________________________________________________________________________ ")
    end

    
    function hipotesis(p)
     if p<0.05 
    println("CONCLUSION: SI existe evidencia estadistica para rechazar la igualda de medias")
     else
        println("CONCLUSION:NO existe evidencia estadistica para rechazar la igualda de medias")
     end
    end
    
    function llenar_muestras(x,n)
        muestras=[]
       
                 for l=1:x
           muestra=[]
           for k = 1:n
               println("Ingresa dato [$k] para muestra <$l>")
               push!(muestra,asknumber()) 
            end
                   
                   push!(muestras,muestra)
       
                   end
            return muestras
       
       end
       
       function Medias(muestras)
       
       medias=[]
         
       foreach(m->push!(medias,suma(m)/length(m)),muestras)
         
        return medias 
       end
       
       
       function media(a)
           
       return suma(a)/length(a)
       
       end
       
       
       
       
       
       
       function suma(a)
           s=0
       foreach(x->s+=x,a)
       return s
       end
       
       
       
       function SCE(muestras,medias)
           s=0
       for i=1:length(muestras)
          
           muestra=get(muestras,i,Float64)
           media=get(medias,i,Float64)
           foreach(d->s+=(d-media)^2,muestra)
         
       end  
       
       
        return s
       end
       
       
       function SCT(muestras,supermedia)
           s=0
       for i=1:length(muestras)
          
           muestra=get(muestras,i,Float64)
           
           foreach(d->s+=(d-supermedia)^2,muestra)
         
       end  
       
       return s
       end
       
       
       function SCTR(medias,supermedia,n)
           s=0
       
         foreach(m->s+=n*(m-supermedia)^2,medias)
       
       
       return s
       end
       
       function Input(prompt)
           print(prompt)
           readline()
       end
       
       
       
       
       
       function asknumber()
          
           parse(Float64, readline())
       end
       
       
       
       





























    
    
    
    function leer_csv()
       
        
        dt = CSV.read("c:/users/jessy/desktop/julia/anova.cvs.csv")
        x=convert(Matrix,dt )
        return x
       
    end
  
    function readInt()
    return parse(Int64,readline())
    end

   


    function convertir_matriz(x,n,d)
     muestras=[]
     muestra=[]
     aux=[]
   foreach(e->push!(aux,e),x)
    
   for i=1:n
    for j=1:d
    push!(muestra,splice!(aux,1))
    end
    push!(muestras,muestra)
    muestra=[]
   end
   
  
    
     return muestras

    end
    
   
    
    main()