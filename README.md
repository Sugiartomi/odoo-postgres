# odoo-postgres
try odoo application


# Fix Odoo data var/lib/odoo directory permission
$ docker exec -u root odoo chown odoo:odoo -R /var/lib/odoo