import psycopg2

# with psycopg2.connect(database="netology_db", user="postgres", password="") as conn:

conn = psycopg2.connect(
    database="netology_db",
    user="postgres",
    password=""
)



# Создание таблицы
def create_table():

    with conn.cursor() as cur:
        create_current_table = '''CREATE TABLE IF NOT EXISTS clients
                        (id SERIAL PRIMARY KEY,
                        first_name VARCHAR(100) NOT NULL,
                        last_name VARCHAR(100) NOT NULL,
                        email VARCHAR(50) NOT NULL,
                        phone BIGINT);'''
        cur.execute(create_current_table)

    conn.commit()

create_table()



# Добавление нового клиента
def add_client(first_name, last_name, email, phone):

    with conn.cursor() as cur:
        add_current_client = '''INSERT INTO clients (first_name, last_name, email, phone)
                        VALUES (%s, %s, %s, %s);'''
        cur.execute(add_current_client, (first_name, last_name, email, phone))

    conn.commit()

add_client("Ученик", "Нетологии", "Netology_pupil@dot.com", None)



# Добавление телефона для существующего клиента
def update_phone(id, phone):

    with conn.cursor() as cur:
        update_current_phone = '''UPDATE clients
                        SET phone = %s
                        WHERE id = %s;'''
        cur.execute(update_current_phone, (phone, id))

    conn.commit()

update_phone(4, 79850001122)



#  Изменение данные о клиенте
def update_client_info(id, first_name, last_name, email, phone):

    with conn.cursor() as cur:
        update_current_client_info = '''UPDATE clients
                        SET first_name = %s,
                            last_name = %s,
                            email = %s,
                            phone = %s
                        WHERE id = %s;'''
        cur.execute(update_current_client_info, (first_name, last_name, email, phone, id))

        conn.commit()

update_client_info(7, "Капитан Джек", "Воробей", "Jane_doe@comic.com", 79007895412)



# Удаление телефона для существующего клиента
def delete_phone(id):
    with conn.cursor() as cur:
        update_current_phone = '''UPDATE clients
                                 SET phone = NULL
                                 WHERE id = %s;'''
        cur.execute(update_current_phone, (id,))
    conn.commit()

delete_phone(2)



# Удаление существующего клиента
def delete_client(id):

    with conn.cursor() as cur:
        delete_current_client = '''DELETE FROM clients
                        WHERE id = %s;'''
        cur.execute(delete_current_client, (id,))

        conn.commit()

delete_client(8)



# Поиск клиента по имеющимся данным
def find_client(first_name, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:
        find_current_client = '''SELECT * FROM clients
                                WHERE first_name = %s
                                OR last_name = %s
                                OR email = %s
                                OR phone = %s;'''
        cur.execute(find_current_client, (first_name, last_name, email, phone))
        return cur.fetchall()

result = find_client(None, "Нетологии", None, None)
if result:
    print(f'"Найден клиент:", {result}')
else:
    print("Клиент не найден")



conn.close()