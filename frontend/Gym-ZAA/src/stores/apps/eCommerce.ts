import { defineStore } from 'pinia';
// project imports
import axios from '@/utils/axios';
// types
import type { ProductStateProps } from '@/types/apps/EcommerceType';
import { eq, filter, map, replace, sum } from 'lodash';

export const useEcomStore = defineStore({
    id: 'eCommerceone',
    state: (): ProductStateProps => ({
        products: [],
        cart: [],
        gender: '',
        category: [],
        price: '',
        subTotal: 0,
        discount: 5,
        total: 0,
        addresses: [],
        color: 'All',
    }),
    getters: {},
    actions: {
        // Fetch Customers from action
        async fetchProducts() {
            try {
                let equipos = []
                await axios.get('http://localhost:8000/gimnasio/api/v1Equipo/').then(res => {
                    equipos = res.data
                });

                let join_equipos = []
                equipos.forEach(equipo => {
                    if (equipo.estatus == 'Disponible') {
                        console.log(equipo)
                        let url_imagen:String = equipo.fotografía
                        
                        url_imagen = url_imagen.substring(url_imagen.indexOf('/assets'));
                        console.log(url_imagen)

                        join_equipos.push({
                            name: equipo.nombre,
                            image: '/src/' + url_imagen,
                            description: equipo.descripcion,
                            id: equipo.id
                        })
                    }
                })

                this.products = join_equipos;
            } catch (error) {
                alert(error);
                console.log(error);
            }
        },
        // Fetch Customers from addresses
        async fetchAddress() {
            try {
                const data = await axios.get('/api/address/list');
                this.addresses = data.data;
            } catch (error) {
                alert(error);
                console.log(error);
            }
        },
        //select gender
        SelectGender(items: any) {
            this.gender = items;
        },
        sortByColor(itemcolor: string) {
            this.color = itemcolor;
        },
        //select category
        SelectCategory(items: any) {
            this.category = items;
        },
        //select Price
        SelectPrice(items: any) {
            this.price = items;
        },
        //AddToCart
        AddToCart(item: any) {
            const product = item;
            this.cart = [...this.cart, product];
        },
        //qty
        incrementQty(item: any) {
            const productId = item;
            const updateCart = map(this.cart, (product: any) => {
                if (product.id === productId) {
                    return {
                        ...product,
                        qty: product.qty + 1
                    };
                }
                return product;
            });
            this.cart = updateCart;
            this.subTotal = sum(this.cart.map((product: any) => product.salePrice * product.qty));
            this.discount = Math.round(this.subTotal * (5 / 100));
            this.total = this.subTotal - this.discount;
        },
        //qty
        decrementQty(item: any) {
            const productId = item;
            const updateCart = map(this.cart, (product: any) => {
                if (product.id === productId) {
                    return {
                        ...product,
                        qty: product.qty - 1
                    };
                }
                return product;
            });
            this.cart = updateCart;
            this.subTotal = sum(this.cart.map((product: any) => product.salePrice * product.qty));
            this.subTotal = sum(this.cart.map((product: any) => product.salePrice * product.qty));
            this.discount = Math.round(this.subTotal * (5 / 100));
            this.total = this.subTotal - this.discount;
        },
        // delete Cart
        deleteCart(item: any) {
            const updateCart = filter(this.cart, (p) => p.id !== item);
            this.cart = updateCart;
        },
        //subtotal
        getsubTotal() {
            this.subTotal = sum(this.cart.map((product: any) => product.salePrice * product.qty));
        },
        //total
        getTotal() {
            this.total = this.subTotal - this.discount;
        },
        //discount
        getDiscount() {
            this.discount = Math.round(this.subTotal * (5 / 100));
        },

        //Reset Filter
        filterReset() { }


    }
});