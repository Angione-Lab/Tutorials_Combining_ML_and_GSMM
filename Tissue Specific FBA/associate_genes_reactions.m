function strings_output = associate_genes_reactions(strings)

%unfortunately Recon grRules have no parentheses, which means that we need
%to find a smart way to make sure that AND is solved before OR when we
%substitute MIN and MAX respectively. This means that in the final expression, the MINs have to be
%calculated before the MAXs.
%To do so, we substitute the ORs first (which become MAXs), and then the ANDs inside
%the MAXs. This is to ensure that we have an expression that first solves
%the  ANDs (which are internal) and then solves the ORs (which are
%external), thus respecting the common rule that AND is solved before OR
   
    while ( ~isempty(findstr(' or ', strings)) )   %loops until all the AND and OR are not found because they have been substituted by MIN and MAX
    
        i = 1;
       while ( (strcmp(strings(i:i+3),' or ')==0) )
            i = i+1;        %while it does not find any 'and' and any 'or', keeps scrolling the array
        end
        
        strings = substitute(strings,i);
        %strings = regexprep(strings,'//','/'); 
    end
 
    while ( ~isempty(findstr(' and ', strings) ) )  %loops until all the AND and OR are not found because they have been substituted by MIN and MAX
    
        i = 1;
        
        while ( (strcmp(strings(i:i+4),' and ')==0)    )
            i = i+1;        %while it does not find any 'and' and any 'or', keeps scrolling the array
        end
        
        strings = substitute(strings,i);
      %strings = regexprep(strings,'//','/'); %eliminates duplicate /
    end
    
    if (isempty(findstr('max(', strings)) && isempty(findstr('min(', strings)) && ~strcmp(strings,''))
        strings_output = strings;  
    else
        strings_output = strings; %if strings is empty or is a combination of max/min of genes, we leave it as it is
    end
end
    
    
    



    function strings = substitute(strings,i)
         
        
        i = i+1;
        %a questo punto i e' posizionato sulla a di 'and' o sulla o di 'or' (prima era posizionato sullo spazio vuoto che precedeva and oppure or), e lo capiamo con questo if
        if (strings(i)=='a')
            found_and = 1;
        else
            found_and = 0 ;
        end
            
        
        parenthesis_find=0;
        
        j = i;
        while (  (strcmp(strings(j),'(')==0) || (parenthesis_find~=-1) ) && (strcmp(strings(j),',')==0 || (parenthesis_find~=0) ) && (j>1)   %si ferma se trova una parentesi ( che non e' intermedia. E' necessario questo altrimenti si fermerebbe alla prima parentesi ( trovata, anche se questa non e' quella relativa all'AND, ma appartiene ad esempio a un "sotto-OR" che costituisce il ramo sinistro dell'AND, cioe' nel caso ((C or D) and (B or E))
            j = j-1;
            if (strings(j)==')')
                parenthesis_find = parenthesis_find+1; %segnala altre parentesi trovata lungo il percorso
            end
            if (strings(j)=='(')
                parenthesis_find = parenthesis_find-1; %segnala la chiusura delle parentesi find lungo il percorso
            end
        end
        if (parenthesis_find == -1 || strcmp(strings(j),',')~=0)    %it means that it exited from the WHILE because it actually found a bracket that was not intermediate, or it found a comma. This IF is necessary because it may happen that it exits because it reaches the end of the strings, so in this case j is already on the first character of the gene, and j=j+1 must not be executed otherwise the first character will not be copied later in the new strings
            j = j+1;
        end
        %a questo punto j e' posizionato sul carattere iniziale del primo componente dell'and/or
        
        
        
        if (found_and == 1)
            k = i+3;
        else
            k = i+2;
        end
       
        parenthesis_find=0;
       
        while ( (strcmp(strings(k),')')==0) || ( parenthesis_find~=-1 )) && (strcmp(strings(k),',')==0 || (parenthesis_find~=0) ) && (k<length(strings))    %si ferma se trova una parentesi ) che non e' intermedia. E' necessario questo altrimenti si fermerebbe alla prima parentesi) trovata, anche se questa non e' quella relativa all'AND, ma appartiene ad esempio a un "sotto-OR" che costituisce il ramo sinistro dell'AND, cioe' nel caso ((C or D) and (B or E))
            k = k+1;
            if (strings(k)=='(')
                parenthesis_find = parenthesis_find+1; %segnala altre parentesi trovata lungo il percorso
            end
            if (strings(k)==')')
                parenthesis_find = parenthesis_find-1; %segnala la chiusura delle parentesi trovata lungo il percorso
            end
        end
        if parenthesis_find == -1 ||  strcmp(strings(k),',')~=0 %this IF is necessary for the same reason as the step "if parenthesis_find == -1, j=j+1" a few lines before
            k = k-1;
        end
        %a questo punto k e' posizionato sul carattere finale del secondo componente dell'and/or
        
        
        parenthesis_find=0;
        
        if (found_and == 1)
            strings_new = strrep( strings, strings(j:k), strcat('min(',strings(j:i-1),',',strings(i+4:k), ')') );
        else
            strings_new = strrep( strings, strings(j:k), strcat('max(',strings(j:i-1),',',strings(i+3:k), ')') );
        end
        strings = strings_new;
    end


    