import mock from '../../mockAdapter';

// third-party
import { add, sub } from 'date-fns';
import { Chance } from 'chance';
import product1 from '@/assets/images/products/s11.jpg';
import product2 from '@/assets/images/products/s2.jpg';
import product3 from '@/assets/images/products/s3.jpg';
import product4 from '@/assets/images/products/s4.jpg';
import product5 from '@/assets/images/products/s5.jpg';
import product6 from '@/assets/images/products/s6.jpg';
import product7 from '@/assets/images/products/s7.jpg';
import product8 from '@/assets/images/products/s8.jpg';

//Types
import type { Products } from '@/types/apps/EcommerceType';

const chance = new Chance();
// products list
const products: Products[] = [
    {
        id: 1,
        image: product1,
        name: 'Minibandas "Disponible"',
        description: chance.paragraph({ sentences: 1 }),
        rating: chance.floating({ min: 0.1, max: 5.0 }),
     
        popularity: chance.natural(),
        date: chance.natural(),
        created: sub(new Date(), { days: 8, hours: 6, minutes: 20 }),
        
    },
    {
        id: 2,
        image: product2,
        name: 'Torre Inflable "Disponible"',
        
        popularity: chance.natural(),
        
        created: sub(new Date(), { days: 10, hours: 8, minutes: 69 }),
      
    },
    {
        id: 3,
        image: product3,
        name: 'Bola Gimnasia "Agotado"',
        description: chance.paragraph({ sentences: 2 }),
        rating: chance.floating({ min: 0.1, max: 5.0 }),
        popularity: chance.natural(),
        date: chance.natural(),
        created: sub(new Date(), { days: 4, hours: 9, minutes: 50 }),
    },
    {
        id: 4,
        image: product4,
        name: 'Mancuerna "Disponible"',
        description: chance.paragraph({ sentences: 2 }),
        
        popularity: chance.natural(),
        date: chance.natural(),
        created: sub(new Date(), { days: 7, hours: 6, minutes: 45 }),
        
    },
    {
        id: 5,
        image: product5,
        name: 'Maquina "Mantenimiento"',
        description: chance.paragraph({ sentences: 2 }),
        rating: chance.floating({ min: 0.1, max: 5.0 }),
        
        popularity: chance.natural(),
        date: chance.natural(),
        created: sub(new Date(), { days: 2, hours: 9, minutes: 45 }),
       
    },
    {
        id: 6,
        image: product6,
        name: 'Brincolin "Disponible"',
        description: chance.paragraph({ sentences: 2 }),
        rating: chance.floating({ min: 0.1, max: 5.0 }),
        
        popularity: chance.natural(),
        date: chance.natural(),
        created: add(new Date(), { days: 6, hours: 10, minutes: 0 }),
        
    },
    {
        id: 7,
        image: product7,
        name: 'Tabla Abdominal Básica "No Disponible"',
        description: chance.paragraph({ sentences: 2 }),
        rating: chance.floating({ min: 0.1, max: 5.0 }),
       
        popularity: chance.natural(),
        date: chance.natural(),
        created: add(new Date(), { days: 14, hours: 1, minutes: 55 }),
        
    },
    {
        id: 8,
        image: product8,
        name: 'Liga de Resistencia "Disponible"',
        description: chance.paragraph({ sentences: 2 }),
        popularity: chance.natural(),
        date: chance.natural(),
        created: sub(new Date(), { days: 0, hours: 11, minutes: 10 }),
      
    }
];

// ==============================|| MOCK SERVICES ||============================== //

// mock.onGet('/api/products/list').reply(200, { products });
mock.onGet('/api/products/list').reply(() => {
    return [200, products];
});

export default products;

