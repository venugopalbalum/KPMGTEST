#!/usr/bin/env

import urllib.request
import urllib.parse
import json
import xlsxwriter

workbook = xlsxwriter.workbook('Sonar_Report.xlsx',{'string_to_numbers': True'})
worksheet = workbook.add_worksheet('coverage')
columns= ['Repo name','Code Coverage %', 'Branch', 'SonarQube url']

# need input file of Repos to which you want report
with open('repos.txt') as fp
     data = []
     for line in fp:
         line.rsstrip()   
          #this is the format we gave in input file                                          
         track,repo,component=line.split(':')
          #to which brnach we need report                                          
         branch = 'release/v1.0.0' 
         sonar_url = 'https://sonar_url/dashboard?branch={}&id={}'.format(brnach, component.rstrip())
         try:
            params = urllib.parse.urlencode({'component': component, 'brnach': brnach, 'metrickeys': 'coverage'})     
            response = urllib.request.urlopen("https://sonar_url/api/measures/component?%s" % params)                                        
            reponse_data = json.loads(response.read())                                        
            data.append('{},{},{},{}'.format(track, repo,response_data['component']['measure']['0']['value'],branch, sonar_url ).split(','))                                        
         except:
            data.append('{},{},{},{}'.format(track, repo,'not found',branch, sonar_url ).split(','))                                                                                

for row_num,cell_values in enumarate(data, 1):
 worksheet.write_row(0,0, columns)
 worksheet.write_row(row_num,0, cell_values) 
                                                    
workbook.close()                                                    
