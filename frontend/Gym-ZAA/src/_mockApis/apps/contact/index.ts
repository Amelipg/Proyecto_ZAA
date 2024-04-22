import mock from '../../mockAdapter';
// import type { ContactType } from '@/types/apps/ContactType';

let contacts: KeyedObject[] = [
];

await fetch('http://localhost:8000/gimnasio/api/v1Equipo/')
            .then(res => {
                if (!res.ok) {
                    throw new Error('Error al obtener los registros');
                }
                return res.json();
            })
            .then(equipo => {
                contacts = equipo
		        console.log(contacts)
            })
            .catch(error => {
                console.error('Error al obtener los registros: ' + error);
            });
// types
export type KeyedObject = {
    [key: string]: string | number | KeyedObject | any;
};

// ==============================|| MOCK SERVICES ||============================== //

// mock.onGet('/api/products/list').reply(200, { products });
mock.onGet('/api/contacts').reply(() => {
    return [200, contacts];
});


export default contacts;
