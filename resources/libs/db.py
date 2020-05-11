import psycopg2cffi


def remove_product_by_title(title):
	
	query = "delete from public.products where title = '{}';".format(title)

	conn = psycopg2cffi.connect(
		host='pgdb',
		database='ninjapixel',
		user='postgres',
		password='qaninja'
	)

	cur = conn.cursor()
	cur.execute(query)
	conn.commit()
	conn.close()

def outro_metodo():
	print('teste')