# SODA NOTES

## Disable auth for dev only mode
BEGIN
  ords.delete_privilege_mapping('oracle.soda.privilege.developer', '/andsas/*');
  COMMIT;
END;
/
  
## Readd auth
BEGIN
  ORDS.create_privilege_mapping('oracle.soda.privilege.developer', '/soda/*');
  COMMIT;
END;
/

 
  
## Create URL mapping to schema based on path
BEGIN
  ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'SODA_USER',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'andsas',
    p_auto_rest_auth      => FALSE
  );
    
  COMMIT;
END;
/

  
  
  
  
## Simple test commands
## Creating a collection
curl -i -X PUT http://localhost:8080/ords/database-schema/soda/latest/MyCollection





## Troubleshooting notes
### curl commands revieve error when trying to auth with user
Command: curl -i -X PUT -u SODA_USER:password http://localhost:8080/ords/andsas/soda/latest/test
Error: PLS-00201: identifier 'DBMS_SODA_ADMIN' must be declared
Explination: Its possible the user i am trying to connect with is not apart of the `SODA_APP` role, which it would need to create/update a collection


