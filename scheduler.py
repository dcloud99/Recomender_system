#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug  5 00:59:11 2019

@author: nicolas
"""
from ecommerce_postgresql import EcommercePostgres
#-----

import turicreate as tc


import schedule
import time

def do_n():
    ecommerce_postgres = EcommercePostgres()
    ratings = ecommerce_postgres.getDataframe() 
    
    
 
    '''-----------------------------------------------------------------------------
    Preprocesamiento de los datos utilizando tc
    -----------------------------------------------------------------------------
    '''
    
    '''
    Convirtiendo a SFrame para la entrada del modelo
    '''
    
    data = tc.SFrame(ratings)
    
    
    '''-----------------------------------------------------------------------------
    Separando datos para evaluación del modelo
    -----------------------------------------------------------------------------
    '''
       
    training_data, validation_data = tc.recommender.util.random_split_by_user(data, 'user_id', 'item_id')
    
    
    '''-----------------------------------------------------------------------------
    Creando Modelo:
    -----------------------------------------------------------------------------
    '''
       # Turi Create proporciona un método turicreate.recommender.create 
       # que elegirá automáticamente un modelo apropiado para su conjunto de datos.
       
    model = tc.recommender.create(training_data, 'user_id', 'item_id',target='rating')
    
    
    
    
    '''----> Making recommendations for ALL USERS:'''
        
    
    print("##############################################")
    print("ALL USERS:")
    results = model.recommend()
    print(results)
    
    
    
    '''----> Making recommendations for NEW USER:'''
        

       # Esto se conoce como el problema de "arranque en frío". 
       # La función recomendar () funciona a la perfección con los nuevos usuarios. 
       # Si el modelo nunca ha visto al usuario, entonces se recomienda elementos populares:
    
    print("##############################################")
    print("NEW USER:")
          
    results1 = model.recommend(['-1'])
    print(results1);
    
    

    '''----> Making recommendations for SPECIFIC USERS'''
        

    #QUERY BD: 
    #SELECT user_id,product_id,rating FROM reviews WHERE user_id=2;
    print("##############################################")
    users=['2']
    print("USER: "+''.join(users))
    recommendations = model.recommend(users)
    print(recommendations);
    
    '''
    -----------------------------------------------------------------------------
    SAVING model:
    -----------------------------------------------------------------------------
    '''
    
    model.save("my_model.model")
    
    
    ''' ----> Obtener resumen del modelo recado con turicreate.recommender.create'''
     
    
    model.summary()

schedule.every(5).minutes.do(do_n)

while 1:
    schedule.run_pending()
    time.sleep(1)    