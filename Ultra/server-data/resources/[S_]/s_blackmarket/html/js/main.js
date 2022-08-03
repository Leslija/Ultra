(function (t) {
    
    function e(e) {
        for (var a, i, n = e[0], c = e[1], d = e[2], l = 0, _ = []; l < n.length; l++) i = n[l], Object.prototype.hasOwnProperty.call(r, i) && r[i] && _.push(r[i][0]), r[i] = 0;
        for (a in c) Object.prototype.hasOwnProperty.call(c, a) && (t[a] = c[a]);
        u && u(e);
        while (_.length) _.shift()();
        return o.push.apply(o, d || []), s()
    }
    
    function s() {
        for (var t, e = 0; e < o.length; e++) {
            for (var s = o[e], a = !0, n = 1; n < s.length; n++) {
                var c = s[n];
                0 !== r[c] && (a = !1)
            }
            a && (o.splice(e--, 1), t = i(i.s = s[0]))
        }
        return t
    }
    var a = {},
        r = {
            app: 0
        },
        o = [];

    function i(e) {
        if (a[e]) return a[e].exports;
        var s = a[e] = {
            i: e,
            l: !1,
            exports: {}
        };
        return t[e].call(s.exports, s, s.exports, i), s.l = !0, s.exports
    }
    i.m = t, i.c = a, i.d = function (t, e, s) {
        i.o(t, e) || Object.defineProperty(t, e, {
            enumerable: !0,
            get: s
        })
    }, i.r = function (t) {
        "undefined" !== typeof Symbol && Symbol.toStringTag && Object.defineProperty(t, Symbol.toStringTag, {
            value: "Module"
        }), Object.defineProperty(t, "__esModule", {
            value: !0
        })
    }, i.t = function (t, e) {
        if (1 & e && (t = i(t)), 8 & e) return t;
        if (4 & e && "object" === typeof t && t && t.__esModule) return t;
        var s = Object.create(null);
        if (i.r(s), Object.defineProperty(s, "default", {
                enumerable: !0,
                value: t
            }), 2 & e && "string" != typeof t)
            for (var a in t) i.d(s, a, function (e) {
                return t[e]
            }.bind(null, a));
        return s
    }, i.n = function (t) {
        var e = t && t.__esModule ? function () {
            return t["default"]
        } : function () {
            return t
        };
        return i.d(e, "a", e), e
    }, i.o = function (t, e) {
        return Object.prototype.hasOwnProperty.call(t, e)
    }, i.p = "";
    var n = window["webpackJsonp"] = window["webpackJsonp"] || [],
        c = n.push.bind(n);
    n.push = e, n = n.slice();
    for (var d = 0; d < n.length; d++) e(n[d]);
    var u = c;
    o.push([0, "chunk-vendors"]), s()
})({
    0: function (t, e, s) {
        t.exports = s("56d7")
    },
    "034f": function (t, e, s) {
        "use strict";
        s("85ec")
    },
    "0405": function (t, e, s) {},
    "19ff": function (t, e, s) {
        "use strict";
        s("4cfa")
    },
    "2df2": function (t, e, s) {},
    "463c": function (t, e, s) {
        "use strict";
        s("e41f")
    },
    "4cfa": function (t, e, s) {},
    "53a2": function (t, e, s) {
        "use strict";
        s("0405")
    },
    "56d7": function (t, e, s) {
        "use strict";
        s.r(e);
        s("e260"), s("e6cf"), s("cca6"), s("a79d");
        var a = s("2b0e"),
            r = function () {
                
                var t = this,
                    e = t.$createElement,
                    s = t._self._c || e;
                return s("div", {
                    attrs: {
                        id: "App"
                    }
                }, [t.openned ? s("div", {
                    class: {
                        Light: t.shared.light_mode
                    },
                    attrs: {
                        id: "MarketBox"
                    }
                }, [s("p", {
                    staticClass: "ButtonClose",
                    on: {
                        click: t.Close
                    }
                }, [t._v("X")]), s("div", {
                    class: {
                        Light: t.shared.light_mode
                    },
                    attrs: {
                        id: "HeaderBox"
                    }
                }, [s("div", {
                    attrs: {
                        id: "HeaderTitleBox"
                    }
                }, [s("p", [t._v(t._s(t.shared.translate.BLACK))]), s("p", [t._v(t._s(t.shared.translate.MARKET))])]), s("div", {
                    class: {
                        Light: t.shared.light_mode
                    },
                    attrs: {
                        id: "HeaderOptions"
                    }
                }, [s("div", {
                    class: {
                        selected: "Products" == t.page
                    },
                    on: {
                        click: function (e) {
                            return t.OpenScreen("Products")
                        }
                    }
                }, 
                [s("i", {
                    staticClass: "fa fa-home"
                }), t._v(t._s(""))]), s("div", {

                    class: {
                        selected: "MyAds" == t.page
                    },
                    on: {
                        click: function (e) {
                            return t.OpenScreen("MyAds")
                        }
                    }
                    
                }, [s("i", {
                    staticClass: "fa fa-bullhorn"
                }), t._v(t._s(t.shared.translate.NEWAD))]), s("div", {
                    class: {
                        selected: "NewAd" == t.page
                    },
                    on: {
                        click: function (e) {
                            return t.OpenScreen("NewAd")
                        }
                    }
                }, [s("i", {
                    staticClass: "fa fa-plus"
                }), t._v(t._s())])]), s("div", {
                    class: {
                        Light: t.shared.light_mode
                    },
                    attrs: {
                        id: "HeaderSolds"
                    },
                    on: {
                        click: function (e) {
                            return t.OpenScreen("MySolds")
                        }
                    }
                }, 
                
                
                [s("i", {
                    staticClass: "fa fa-wallet"
                }), t._v(t._s(t.shared.translate.WALLET)  + t._s() + "  " + t._s(t.total_solds)+ (t.shared.translate.CURRENCY_SYMBOL)) ])]), "Products" == t.page ? s("Products", {
                    attrs: {
                        shared: t.shared,
                        functions: t.functions
                    }
                   
                }) : "MyAds" == t.page ? s("MyAds", {
                    attrs: {
                        shared: t.shared,
                        functions: t.functions
                    }
                }) : "MySolds" == t.page ? s("MySolds", {
                    attrs: {
                        shared: t.shared,
                        functions: t.functions
                    }
                }) : "NewAd" == t.page ? s("NewAd", {
                    attrs: {
                        shared: t.shared,
                        functions: t.functions
                    }
                }) : "Transaction" == t.page ? s("Transaction", {
                    attrs: {
                        shared: t.shared,
                        functions: t.functions
                    }
                }) : t._e()], 1) : t._e()])
            },
            o = [],
            i = (s("99af"), s("bc3a")),
            n = s.n(i),
            c = function () {
                var t = this,
                    e = t.$createElement,
                    s = t._self._c || e;
                return s("div", {
                    staticClass: "Products"
                }, [t.is_loading ? s("div", {
                    staticClass: "LoadingBox"
                }, [s("Loading", {
                    attrs: {
                        size: "10",
                        color2: t.shared.light_mode ? "green" : "black",
                        text: t.shared.translate.LOADING_PRODUCTS,
                        use_background: t.shared.light_mode,
                        shared: t.shared
                    }
                })], 1) : s("div", [t.page_product ? s("div", {
                    staticClass: "ProductSelectedBox",
                    class: {
                        Light: t.shared.light_mode
                    }
                }, [s("div", {
                    staticClass: "ButtonBack"
                }, [s("div", {
                    staticClass: "OnClick",
                    on: {
                        click: function (e) {
                            t.page_product = !1
                        }
                    }
                }), s("i", {
                    staticClass: "fas fa-arrow-left"
                }), s("p", [t._v(t._s(t.shared.translate.BACK))])]), s("div", {
                    staticClass: "ProductSelectedImageBox"
                }, [s("p", [t._v(t._s(t.selected_product.label.toUpperCase()))]), s("div", [s("img", {
                    attrs: {
                        src: "img/" + t.selected_product.name + ".png",
                        alt: ""
                    }
                })])]), s("div", {
                    staticClass: "ProductSelectedInfosBox"
                }, [s("p", {
                    staticClass: "ProductSelectedName"
                }, [t._v(t._s(t.selected_product.label))]), s("p", {
                    staticClass: "ProductSelectedDatasBox"
                }, [s("div", [s("p", [t._v(t._s(t.shared.translate.TOTAL_AMOUNT) + ": ")]), s("p", [t._v(t._s(t.selected_product.amount))])]), s("div", [s("p", [t._v(t._s(t.shared.translate.PRICE_PER_UNIT) + ": ")]), s("p", [t._v(t._s("") + " " + t._s(Number(t.selected_product.price) + (t.shared.translate.CURRENCY_SYMBOL)))])]), s("div", [s("p", [t._v(t._s(t.shared.translate.COMMISION) + " " + t._s(100 * t.shared.application_fee) + "%: " )]), s("p", [t._v(t._s("") + " " + t._s(Math.floor(t.selected_product.price * t.shared.application_fee)+ (t.shared.translate.CURRENCY_SYMBOL)))])])]), s("p", {
                    staticClass: "ProductSelectedPrice"
                }, [t._v(t._s("") + " " + t._s(Math.floor(Number(t.selected_product.price * t.selected_amount) + Number(t.selected_product.price * t.selected_amount * t.shared.application_fee) )+ (t.shared.translate.CURRENCY_SYMBOL)))]), s("div", {
                    staticClass: "ProductSelectedButtonsBox"
                }, [s("div", {
                    staticClass: "ProductSelectedAmountBox"
                }, [s("p", {
                    on: {
                        click: function (e) {
                            return t.ChangeAmount(-1)
                        }
                    }
                }, [t._v("-")]), s("input", {
                    directives: [{
                        name: "model",
                        rawName: "v-model.number",
                        value: t.selected_amount,
                        expression: "selected_amount",
                        modifiers: {
                            number: !0
                        }
                    }],
                    attrs: {
                        type: "number"
                    },
                    domProps: {
                        value: t.selected_amount
                    },
                    on: {
                        input: [function (e) {
                            e.target.composing || (t.selected_amount = t._n(e.target.value))
                        }, function (e) {
                            return t.ChangeAmount(0, !0)
                        }],
                        blur: function (e) {
                            return t.$forceUpdate()
                        }
                    }
                }), s("p", {
                    on: {
                        click: function (e) {
                            return t.ChangeAmount(1)
                        }
                    }
                }, [t._v("+")])]), s("div", {
                    staticClass: "ProductSelectedBuyButton"
                }, [s("div", {
                    staticClass: "OnClick",
                    on: {
                        click: t.BuyProduct
                    }
                }), s("i", {
                    staticClass: "fas fa-shopping-cart"
                }), s("p", [t._v(t._s(t.shared.translate.CONFIRM))])])])])]) : s("div", [s("div", {
                    staticClass: "ProductsHeaderBox",
                    class: {
                        Light: t.shared.light_mode
                    }
                }, [s("div", {
                    staticClass: "ProductsSearchBox",
                    class: {
                        Light: t.shared.light_mode
                    }
                }, [s("i", {
                    staticClass: "fas fa-search"
                }), s("input", {
                    directives: [{
                        name: "model",
                        rawName: "v-model",
                        value: t.search,
                        expression: "search"
                    }],
                    attrs: {
                        type: "text",
                        placeholder: t.shared.translate.LOOKING
                    },
                    domProps: {
                        value: t.search
                    },
                    on: {
                        input: [function (e) {
                            e.target.composing || (t.search = e.target.value)
                        }, t.ChangeProductsOrder]
                    }
                })]), s("div", {
                    staticClass: "ProductsOrderByBox"
                }, [s("p", [t._v(t._s(t.shared.translate.SORTBY) + ":")]), s("p", {
                    class: {
                        selected: 0 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(0)
                        }
                    }
                }, [t._v(t._s(t.shared.translate.NAME))]), s("p", {
                    class: {
                        selected: 1 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(1)
                        }
                    }
                },[s("i", {
                    staticClass: "fa fa-arrow-down"
                }), t._v(t._s(t.shared.translate.LOWEST) + t.shared.translate.CURRENCY_SYMBOL)]), s("p", {
                    class: {
                        selected: 2 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(2)
                        }
                    }
                },[s("i", {
                    staticClass: "fa fa-arrow-up"
                }),t._v(t._s(t.shared.translate.BIGGEST)+ t.shared.translate.CURRENCY_SYMBOL)])])]), s("div", {
                    staticClass: "ProductsListItemsBox"
                }, t._l(t.products_bkp, (function (e, a) {
                    return s("div", {
                        key: "product:" + a,
                        staticClass: "ProductsItemBox",
                        class: {
                            Light: t.shared.light_mode
                        }
                    }, [s("div", {
                        staticClass: "OnClick",
                        on: {
                            click: function (s) {
                                return t.SelectProduct(e)
                            }
                        }
                    }), s("p", {
                        staticClass: "ProductsItemName"
                    }, [t._v(t._s(t.functions.ReduceString(e.label, 13)) + " x" + t._s(e.amount))]), s("p", {
                        staticClass: "ProductsItemPrice"
                    }, [t._v(t._s("") + " " + t._s(e.price) + (t.shared.translate.CURRENCY_SYMBOL))]), s("div", {
                        staticClass: "ProductsItemImageBox"
                    }, [s("img", {
                        staticClass: "ProductsItemImage",
                        attrs: {
                            src: "img/" + e.name + ".png",
                            alt: ""
                        }
                    })]), s("p", {
                        staticClass: "ProductsItemOwner"
                    }, [t._v(t._s() + " " + t._s())]), s("div", {
                        staticClass: "ProductsItemButton"
                    }, [s("p", [t._v(t._s(t.shared.translate.BUY))])])])
                })), 0)])])])
            },
            d = [],
            u = (s("4de4"), s("caad"), s("2532"), s("841c"), s("ac1f"), function () {
                var t = this,
                    e = t.$createElement,
                    s = t._self._c || e;
                return s("div", {
                    class: {
                        LoadingBackground: t.use_background
                    },
                    attrs: {
                        id: "Loading"
                    }
                }, [t.error ? s("div", [s("div", {
                    staticClass: "error"
                }, [t._v("X")]), s("p", {
                    staticClass: "LoadingText"
                }, [t._v(t._s(t.error_text))])]) : s("div", [s("div", {
                    staticClass: "loader",
                    style: {
                        width: t.size + "vh",
                        height: t.size + "vh",
                        border: "1vh solid " + t.color,
                        borderTop: "1vh solid " + t.color2 + " !important"
                    }
                }), s("p", {
                    staticClass: "LoadingText",
                    class: {
                        Light: t.shared.light_mode
                    }
                }, [t._v(t._s(t.text))])])])
            }),
            l = [],
            _ = {
                props: {
                    text: {},
                    size: {},
                    color: {
                        default: "#f3f3f3"
                    },
                    color2: {
                        default: "#3498db"
                    },
                    use_background: {
                        default: !0
                    },
                    shared: {},
                    functions: {}
                },
                data: function () {
                    return {
                        error: !1,
                        error_text: "MESSAGE",
                        timeout: null
                    }
                },
                methods: {
                    ReceiveLua: function (t) {
                        var e = this;
                        if (t && t.data) {
                            var s = t.data;
                            s.error && (this.error_text = s.error_text, this.error = !0, this.timeout = setTimeout((function () {
                                e.functions.OpenScreen("Products")
                            }), 3e3))
                        }
                    }
                },
                created: function () {
                    window.addEventListener("message", this.ReceiveLua)
                },
                destroyed: function () {
                    window.removeEventListener("message", this.ReceiveLua), this.timeout && clearTimeout(this.timeout)
                }
            },
            p = _,
            h = (s("53a2"), s("2877")),
            f = Object(h["a"])(p, u, l, !1, null, null, null),
            v = f.exports,
            m = {
                components: {
                    Loading: v
                },
                props: {
                    shared: {},
                    functions: {}
                },
                data: function () {
                    return {
                        products: [{
                            name: "energy",
                            label: "Energy",
                            amount: 500,
                            weight: 1,
                            price: 1e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "firstaid",
                            label: "First Aid",
                            amount: 500,
                            weight: 1,
                            price: 2e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_pistol",
                            label: "Pistol",
                            amount: 500,
                            weight: 1,
                            price: 3e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 5e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 51e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }],
                        products_bkp: [],
                        search: "",
                        sort_by: 0,
                        selected_product: {},
                        selected_amount: 1,
                        page_product: !1,
                        is_loading: !0
                    }
                },
                methods: {
                    SelectProduct: function (t) {
                        this.selected_product = t, this.page_product = !0
                    },
                    ChangeAmount: function (t, e) {
                        e || (this.selected_amount += t), this.selected_amount > this.selected_product.amount ? this.selected_amount = this.selected_product.amount : this.selected_amount <= 0 && (this.selected_amount = 1)
                    },
                    SetSortBy: function (t) {
                        this.sort_by = t, this.ChangeProductsOrder()
                    },
                    SortProducts: function () {
                        for (var t = 0; t < this.products.length; t++)
                            for (var e = 0; e < this.products.length; e++)
                                if (0 == this.sort_by) {
                                    if (this.products[t].label < this.products[e].label) {
                                        var s = this.products[t];
                                        this.products[t] = this.products[e], this.products[e] = s
                                    }
                                } else if (1 == this.sort_by) {
                            if (this.products[t].price < this.products[e].price) {
                                var a = this.products[t];
                                this.products[t] = this.products[e], this.products[e] = a
                            }
                        } else if (2 == this.sort_by && this.products[t].price > this.products[e].price) {
                            var r = this.products[t];
                            this.products[t] = this.products[e], this.products[e] = r
                        }
                        return this.products
                    },
                    ChangeProductsOrder: function () {
                        var t = this;
                        this.products_bkp = this.SortProducts().filter((function (e) {
                            return e.label.toLowerCase().includes(t.search.toLowerCase())
                        }))
                    },
                    BuyProduct: function () {
                        this.functions.SendToClient("BuyProduct", {
                            product: this.selected_product,
                            amount: this.selected_amount
                        }), this.functions.OpenScreen("Transaction")
                    },
                    ReceiveLua: function (t) {
                        var e = this;
                        if (t && t.data) {
                            var s = t.data;
                            if (s.load_products) {
                                for (var a in this.products = [], this.functions.SetTotalSolds(s.total_solds), s.products) null != s.products[a] && s.products[a].amount > 0 && (this.products.push(s.products[a]), this.products_bkp.push(s.products[a]));
                                this.products_bkp = this.SortProducts().filter((function (t) {
                                    return t.label.toLowerCase().includes(e.search.toLowerCase())
                                })), this.is_loading = !1
                            }
                        }
                    }
                },
                created: function () {
                    window.addEventListener("message", this.ReceiveLua), this.is_loading = !0, this.functions.SendToClient("LoadProducts", {})
                },
                destroyed: function () {
                    window.removeEventListener("message", this.ReceiveLua)
                }
            },
            g = m,
            C = (s("463c"), Object(h["a"])(g, c, d, !1, null, null, null)),
            T = C.exports,
            S = function () {
                var t = this,
                    e = t.$createElement,
                    s = t._self._c || e;
                return s("div", {
                    staticClass: "Products"
                }, [t.is_loading ? s("div", {
                    staticClass: "LoadingBox"
                }, [s("Loading", {
                    attrs: {
                        size: "10",
                        color2: "brown",
                        text: t.shared.translate.LOADING_MYADS,
                        use_background: !1,
                        shared: t.shared
                    }
                })], 1) : s("div", [t.page_product ? s("div", {
                    staticClass: "ProductSelectedBox"
                }, [s("div", {
                    staticClass: "ButtonBack"
                }, [s("div", {
                    staticClass: "OnClick",
                    on: {
                        click: function (e) {
                            t.page_product = !1
                        }
                    }
                }), s("i", {
                    staticClass: "fas fa-arrow-left"
                }), s("p", [t._v(t._s(t.shared.translate.BACK))])]), s("div", {
                    staticClass: "ProductSelectedImageBox"
                }, [s("p", [t._v(t._s(t.selected_product.label.toUpperCase()))]), s("div", [s("img", {
                    attrs: {
                        src: "img/" + t.selected_product.name + ".png",
                        alt: ""
                    }
                })])]), s("div", {
                    staticClass: "ProductSelectedInfosBox"
                }, [s("p", {
                    staticClass: "ProductSelectedName"
                }, [t._v(t._s(t.selected_product.label))]), s("p", {
                    staticClass: "ProductSelectedDatasBox"
                }, [s("div", [s("p", [t._v(t._s(t.shared.translate.TOTAL_AMOUNT) + ": ")]), s("p", [t._v(t._s(t.selected_product.amount))])]), s("div", [s("p", [t._v(t._s(t.shared.translate.PRICE_PER_UNIT) + ": ")]), s("p", [t._v(t._s("") + " " + t._s(t.selected_product.price) + (t.shared.translate.CURRENCY_SYMBOL))])]), s("div", [s("p", [t._v(t._s(t.shared.translate.COMMISION) + " " + t._s(100 * t.shared.application_fee) + "%: ")]), s("p", [t._v(t._s("") + " " + t._s(Math.floor(t.selected_product.price * t.shared.application_fee))+ (t.shared.translate.CURRENCY_SYMBOL))])])]), s("p", {
                    staticClass: "ProductSelectedPrice"
                }, [t._v(t._s("") + " " + t._s(Math.floor(Number(t.selected_product.price) + Number(t.selected_product.price * t.shared.application_fee))+ (t.shared.translate.CURRENCY_SYMBOL)))]), s("p", {
                    staticClass: "NewAdSelectedTextPriceFee"
                }, [t._v(t._s(t.shared.translate.MESSAGE_REMOVE))]), s("div", {
                    staticClass: "MyAdsSelectedButtonsBox"
                }, [s("div", {
                    staticClass: "MyAdsSelectedBuyButton"
                }, [s("div", {
                    staticClass: "OnClick",
                    on: {
                        click: t.RemoveItem
                    }
                }), s("i", {
                    staticClass: "fas fa-times"
                }), s("p", [t._v(t._s(t.shared.translate.CONFIRM))])])])])]) : s("div", [s("div", {
                    staticClass: "ProductsHeaderBox"
                }, [s("div", {
                    staticClass: "ProductsSearchBox"
                }, [s("i", {
                    staticClass: "fas fa-search"
                }), s("input", {
                    directives: [{
                        name: "model",
                        rawName: "v-model",
                        value: t.search,
                        expression: "search"
                    }],
                    attrs: {
                        type: "text",
                        placeholder: t.shared.translate.LOOKING,
                    },
                    domProps: {
                        value: t.search
                    },
                    on: {
                        input: function (e) {
                            e.target.composing || (t.search = e.target.value)
                        }
                    }
                })]), s("div", {
                    staticClass: "ProductsOrderByBox"
                }, [s("p", [t._v(t._s(t.shared.translate.SORTBY) + ":")]), s("p", {
                    class: {
                        selected: 0 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(0)
                        }
                    }
                }, [t._v(t._s(t.shared.translate.NAME))]), s("p", {
                    class: {
                        selected: 1 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(1)
                        }
                    }
                }, [s("i", {
                    staticClass: "fa fa-arrow-down"
                }),t._v(t._s(t.shared.translate.LOWEST) + t.shared.translate.CURRENCY_SYMBOL)]), s("p", {
                    class: {
                        selected: 2 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(2)
                        }
                    }
                }, [s("i", {
                    staticClass: "fa fa-arrow-up"
                }),t._v(t._s(t.shared.translate.BIGGEST)+ t.shared.translate.CURRENCY_SYMBOL)])])]), s("div", {
                    staticClass: "ProductsListItemsBox"
                }, t._l(t.SortProducts().filter((function (e) {
                    return e.label.toLowerCase().includes(t.search.toLowerCase())
                })), (function (e, a) {
                    return s("div", {
                        key: "myad:" + a,
                        staticClass: "ProductsItemBox"
                    }, [s("div", {
                        staticClass: "OnClick",
                        on: {
                            click: function (s) {
                                return t.SelectProduct(e)
                            }
                        }
                    }), s("p", {
                        staticClass: "ProductsItemName"
                    }, [t._v(t._s(t.functions.ReduceString(e.label, 13)) + " x" + t._s(e.amount))]), s("p", {
                        staticClass: "ProductsItemPrice"
                    }, [t._v(t._s("") + " " + t._s(e.price) + (t.shared.translate.CURRENCY_SYMBOL))]), s("div", {
                        staticClass: "ProductsItemImageBox"
                    }, [s("img", {
                        staticClass: "ProductsItemImage",
                        attrs: {
                            src: "img/" + e.name + ".png",
                            alt: ""
                        }
                    })]), s("p", {
                        staticClass: "ProductsItemOwner"
                    }, [t._v(t._s() + " " + t._s())]), s("div", {
                        staticClass: "MyAdsItemButton"
                    }, [s("p", [t._v(t._s(t.shared.translate.REMOVE))])])])
                })), 0)])])])
            },
            R = [],
            y = {
                components: {
                    Loading: v
                },
                props: {
                    shared: {},
                    functions: {}
                },
                data: function () {
                    return {
                        products: [{
                            name: "energy",
                            label: "Energy",
                            amount: 500,
                            weight: 1,
                            price: 1e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "firstaid",
                            label: "First Aid",
                            amount: 500,
                            weight: 1,
                            price: 2e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_pistol",
                            label: "Pistol",
                            amount: 500,
                            weight: 1,
                            price: 3e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 5e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 51e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }],
                        search: "",
                        sort_by: 0,
                        selected_product: {},
                        page_product: !1,
                        is_loading: !0
                    }
                },
                methods: {
                    SelectProduct: function (t) {
                        this.selected_product = t, this.page_product = !0
                    },
                    SetSortBy: function (t) {
                        this.sort_by = t
                    },
                    SortProducts: function () {
                        for (var t = 0; t < this.products.length; t++)
                            for (var e = 0; e < this.products.length; e++)
                                if (0 == this.sort_by) {
                                    if (this.products[t].label < this.products[e].label) {
                                        var s = this.products[t];
                                        this.products[t] = this.products[e], this.products[e] = s
                                    }
                                } else if (1 == this.sort_by) {
                            if (this.products[t].price < this.products[e].price) {
                                var a = this.products[t];
                                this.products[t] = this.products[e], this.products[e] = a
                            }
                        } else if (2 == this.sort_by && this.products[t].price > this.products[e].price) {
                            var r = this.products[t];
                            this.products[t] = this.products[e], this.products[e] = r
                        }
                        return this.products
                    },
                    RemoveItem: function () {
                        this.functions.SendToClient("RemoveItem", {
                            product: this.selected_product
                        }), this.functions.OpenScreen("Transaction")
                    },
                    ReceiveLua: function (t) {
                        if (t && t.data) {
                            var e = t.data;
                            if (e.load_ads) {
                                for (var s in this.products = [], e.products) null != e.products[s] && e.products[s].amount > 0 && this.products.push(e.products[s]);
                                this.is_loading = !1
                            }
                        }
                    }
                },
                created: function () {
                    window.addEventListener("message", this.ReceiveLua), this.is_loading = !0, this.functions.SendToClient("LoadMyAds", {})
                },
                destroyed: function () {
                    window.removeEventListener("message", this.ReceiveLua)
                }
            },
            P = y,
            w = (s("19ff"), Object(h["a"])(P, S, R, !1, null, null, null)),
            O = w.exports,
            L = function () {
                var t = this,
                    e = t.$createElement,
                    s = t._self._c || e;
                return s("div", {
                    staticClass: "Products"
                }, [t.is_loading ? s("div", {
                    staticClass: "LoadingBox"
                }, [s("Loading", {
                    attrs: {
                        size: "10",
                        color2: "brown",
                        text: t.shared.translate.LOADING_SOLD,
                        use_background: !1,
                        shared: t.shared
                    }
                })], 1) : s("div", [s("div", {
                    staticClass: "ProductsHeaderBox"
                }, [s("div", {
                    staticClass: "ProductsSearchBox"
                }, [s("i", {
                    staticClass: "fas fa-search"
                }), s("input", {
                    directives: [{
                        name: "model",
                        rawName: "v-model",
                        value: t.search,
                        expression: "search"
                    }],
                    attrs: {
                        type: "text",
                        placeholder: t.shared.translate.LOOKING
                    },
                    domProps: {
                        value: t.search
                    },
                    on: {
                        input: function (e) {
                            e.target.composing || (t.search = e.target.value)
                        }
                    }
                })]), s("div", {
                    staticClass: "ProductsOrderByBox"
                }, [s("p", [t._v(t._s(t.shared.translate.SORTBY) + ":")]), s("p", {
                    class: {
                        selected: 0 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(0)
                        }
                    }
                }, [t._v(t._s(t.shared.translate.NAME))]), s("p", {
                    class: {
                        selected: 1 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(1)
                        }
                    }
                }, [s("i", {
                    staticClass: "fa fa-arrow-down"
                }),t._v(t._s(t.shared.translate.LOWEST)+ t.shared.translate.CURRENCY_SYMBOL)]), s("p", {
                    class: {
                        selected: 2 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(2)
                        }
                    }
                }, [s("i", {
                    staticClass: "fa fa-arrow-up"
                }),t._v(t._s(t.shared.translate.BIGGEST)+ t.shared.translate.CURRENCY_SYMBOL)])])]), s("div", {
                    staticClass: "ProductsListItemsBox"
                }, t._l(t.SortProducts().filter((function (e) {
                    return e.label.toLowerCase().includes(t.search.toLowerCase())
                })), (function (e, a) {
                    return s("div", {
                        key: "sold:" + a,
                        staticClass: "ProductsItemBox"
                    }, [s("div", {
                        staticClass: "OnClick",
                        on: {
                            click: function (s) {
                                return t.ReceiveItem(e)
                            }
                        }
                    }), s("p", {
                        staticClass: "ProductsItemName"
                    }, [t._v(t._s(t.functions.ReduceString(e.label, 13)) + " x" + t._s(e.solds))]), s("p", {
                        staticClass: "ProductsItemPrice"
                    }, [t._v(t._s("") + " " + t._s(e.price * e.solds) + (t.shared.translate.CURRENCY_SYMBOL))]), s("div", {
                        staticClass: "ProductsItemImageBox"
                    }, [s("img", {
                        staticClass: "ProductsItemImage",
                        attrs: {
                            src: "img/" + e.name + ".png",
                            alt: ""
                        }
                    })]), s("p", {
                        staticClass: "MySoldsItemButton"
                    }, [s("p", [t._v(t._s(t.shared.translate.COLLECT))])])])
                })), 0)])])
            },
            E = [],
            A = {
                components: {
                    Loading: v
                },
                props: {
                    shared: {},
                    functions: {}
                },
                data: function () {
                    return {
                        products: [{
                            name: "energy",
                            label: "Energy",
                            amount: 500,
                            weight: 1,
                            price: 1e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "firstaid",
                            label: "First Aid",
                            amount: 500,
                            weight: 1,
                            price: 2e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_pistol",
                            label: "Pistol",
                            amount: 500,
                            weight: 1,
                            price: 3e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 5e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 51e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }],
                        search: "",
                        sort_by: 0,
                        selected_product: {},
                        selected_amount: 1,
                        page_product: !1,
                        is_loading: !0
                    }
                },
                methods: {
                    SetSortBy: function (t) {
                        this.sort_by = t
                    },
                    SortProducts: function () {
                        for (var t = 0; t < this.products.length; t++)
                            for (var e = 0; e < this.products.length; e++)
                                if (0 == this.sort_by) {
                                    if (this.products[t].label < this.products[e].label) {
                                        var s = this.products[t];
                                        this.products[t] = this.products[e], this.products[e] = s
                                    }
                                } else if (1 == this.sort_by) {
                            if (this.products[t].price < this.products[e].price) {
                                var a = this.products[t];
                                this.products[t] = this.products[e], this.products[e] = a
                            }
                        } else if (2 == this.sort_by && this.products[t].price > this.products[e].price) {
                            var r = this.products[t];
                            this.products[t] = this.products[e], this.products[e] = r
                        }
                        return this.products
                    },
                    ReceiveItem: function (t) {
                        this.functions.SendToClient("ReceiveItem", {
                            product: t
                        }), this.functions.OpenScreen("Transaction")
                    },
                    ReceiveLua: function (t) {
                        if (t && t.data) {
                            var e = t.data;
                            if (e.load_solds) {
                                for (var s in this.products = [], this.functions.SetTotalSolds(e.total_solds), e.products) null != e.products[s] && e.products[s].solds > 0 && this.products.push(e.products[s]);
                                this.is_loading = !1
                            }
                        }
                    }
                },
                created: function () {
                    window.addEventListener("message", this.ReceiveLua), this.is_loading = !0, this.functions.SendToClient("LoadSolds", {})
                },
                destroyed: function () {
                    window.removeEventListener("message", this.ReceiveLua)
                }
            },
            b = A,
            B = (s("819f"), Object(h["a"])(b, L, E, !1, null, null, null)),
            I = B.exports,
            N = function () {
                var t = this,
                    e = t.$createElement,
                    s = t._self._c || e;
                return s("div", {
                    staticClass: "Products"
                }, [t.is_loading ? s("div", {
                    staticClass: "LoadingBox"
                }, [s("Loading", {
                    attrs: {
                        size: "10",
                        color2: "brown",
                        text: t.shared.translate.LOADING_NEWAD,
                        use_background: !1,
                        shared: t.shared
                    }
                })], 1) : s("div", [t.page_product ? s("div", {
                    staticClass: "ProductSelectedBox"
                }, [s("div", {
                    staticClass: "ButtonBack"
                }, [s("div", {
                    staticClass: "OnClick",
                    on: {
                        click: function (e) {
                            t.page_product = !1
                        }
                    }
                }), s("i", {
                    staticClass: "fas fa-arrow-left"
                }), s("p", [t._v(t._s(t.shared.translate.BACK))])]), s("div", {
                    staticClass: "ProductSelectedImageBox"
                }, [s("p", [t._v(t._s(t.selected_product.label.toUpperCase()))]), s("div", [s("img", {
                    attrs: {
                        src: "img/" + t.selected_product.name + ".png",
                        alt: ""
                    }
                })])]), s("div", {
                    staticClass: "ProductSelectedInfosBox"
                }, [s("p", {
                    staticClass: "ProductSelectedName"
                }, [t._v(t._s(t.selected_product.label))]), s("div", {
                    staticClass: "NewAdSelectedDatasBox"
                }, [s("div", [s("p", [t._v(t._s(t.shared.translate.TOTAL_AMOUNT) + ": ")]), s("p", [t._v(t._s(t.selected_product.amount))])]), s("div", [s("p", [t._v(t._s(t.shared.translate.PRICE_PER_UNIT) + ": ")]), s("p", [t._v(t._s(t.shared.translate.CURRENCY_SYMBOL) + " " + t._s(t.selected_product.price))])]), s("div", [s("p", [t._v(t._s(t.shared.translate.COMMISION) + " " + t._s(100 * t.shared.application_fee) + "%: ")]), s("p", [t._v(t._s(t.shared.translate.CURRENCY_SYMBOL) + " " + t._s(Math.floor(t.selected_product.price * t.shared.application_fee)))])]), s("div", [s("p", [t._v(t._s(t.shared.translate.FINAL_PRICE) + ": ")]), s("p", [t._v(t._s(t.shared.translate.CURRENCY_SYMBOL) + " " + t._s(Math.floor(t.selected_product.price * t.shared.application_fee) + Number(t.selected_product.price)))])])]), s("div", {
                    staticClass: "NewAdAnonymousBox",
                    class: {
                        Green: t.anonymous
                    }
                }, [s("div", {
                    staticClass: "OnClick",
                    on: {
                        click: function (e) {
                            return t.SetAnonymous(!t.anonymous)
                        }
                    }
                }), s("i", {
                    staticClass: ""
                }), s("p", {
                    staticClass: "NewAdSelectedTextAnonymous"
                }, [t._v(t._s())])]), s("p", {
                    staticClass: "NewAdSelectedTextPrice"
            }, [t._v(t._s(t.shared.translate.PRICE_PER_UNIT))]), s("input", {
                    directives: [{
                        name: "model",
                        rawName: "v-model.number",
                        value: t.selected_price,
                        expression: "selected_price",
                        modifiers: {
                            number: !0
                        }
                    }],
                    staticClass: "NewAdSelectedPrice",
                    attrs: {
                        type: "number"
                    },
                    domProps: {
                        value: t.selected_price
                    },
                    on: {
                        input: [function (e) {
                            e.target.composing || (t.selected_price = t._n(e.target.value))
                        }, function (e) {
                            return t.CheckPriceValue()
                        }],
                        blur: function (e) {
                            return t.$forceUpdate()
                        }
                    }
                }), s("p", {
                    staticClass: "NewAdSelectedTextPriceFee"
                }, [t._v(t._s(t.shared.translate.PRICE_FEE) + " " + t._s("") + " " + t._s(Math.floor(t.selected_product.price * t.selected_amount * t.shared.sell_fee) + (t.shared.translate.CURRENCY_SYMBOL)))]), s("p", {
                    staticClass: "NewAdSelectedTextPriceFee"
                }, [t._v(t._s(t.shared.translate.VALUE_RECEIVE) + " " + t._s("") + " " + t._s(Math.floor(t.selected_product.price * t.selected_amount) + (t.shared.translate.CURRENCY_SYMBOL)))]), s("div", {
                    staticClass: "NewAdSelectedButtonsBox"
                }, [s("div", {
                    staticClass: "ProductSelectedAmountBox"
                }, [s("p", {
                    on: {
                        click: function (e) {
                            return t.ChangeAmount(-1)
                        }
                    }
                }, [t._v("-")]), s("input", {
                    directives: [{
                        name: "model",
                        rawName: "v-model.number",
                        value: t.selected_amount,
                        expression: "selected_amount",
                        modifiers: {
                            number: !0
                        }
                    }],
                    attrs: {
                        type: "number"
                    },
                    domProps: {
                        value: t.selected_amount
                    },
                    on: {
                        input: [function (e) {
                            e.target.composing || (t.selected_amount = t._n(e.target.value))
                        }, function (e) {
                            return t.ChangeAmount(0, !0)
                        }],
                        blur: function (e) {
                            return t.$forceUpdate()
                        }
                    }
                }), s("p", {
                    on: {
                        click: function (e) {
                            return t.ChangeAmount(1)
                        }
                    }
                }, [t._v("+")])]), s("div", {
                    staticClass: "NewAdSelectedBuyButton"
                }, [s("div", {
                    staticClass: "OnClick",
                    on: {
                        click: t.SellProduct
                    }
                }), s("i", {
                    staticClass: "fas fa-bullhorn"
                }), s("p", [t._v(t._s(t.shared.translate.CONFIRM_BUY))])])])])]) : s("div", [s("div", {
                    staticClass: "ProductsHeaderBox"
                }, [s("div", {
                    staticClass: "ProductsSearchBox"
                }, [s("i", {
                    staticClass: "fas fa-search"
                }), s("input", {
                    directives: [{
                        name: "model",
                        rawName: "v-model",
                        value: t.search,
                        expression: "search"
                    }],
                    attrs: {
                        type: "text",
                        placeholder: t.shared.translate.LOOKING,
                    },
                    domProps: {
                        value: t.search
                    },
                    on: {
                        input: function (e) {
                            e.target.composing || (t.search = e.target.value)
                        }
                    }
                })]), s("div", {
                    staticClass: "ProductsOrderByBox"
                }, [s("p", [t._v(t._s(t.shared.translate.SORTBY) + ":")]), s("p", {
                    class: {
                        selected: 0 == t.sort_by
                    },
                    on: {
                        click: function (e) {
                            return t.SetSortBy(0)
                        }
                    }
                }, [t._v(t._s(t.shared.translate.NAME) )])])]), s("div", {
                    staticClass: "ProductsListItemsBox"
                }, t._l(t.SortProducts().filter((function (e) {
                    return e.label.toLowerCase().includes(t.search.toLowerCase())
                })), (function (e, a) {
                    return s("div", {
                        key: "newad:" + a,
                        staticClass: "NewAdItemBox"
                    }, [s("div", {
                        staticClass: "OnClick",
                        on: {
                            click: function (s) {
                                return t.SelectProduct(e)
                            }
                        }
                    }), s("p", {
                        staticClass: "NewAdItemName"
                    }, [t._v(t._s(t.functions.ReduceString(e.label, 13)) + " x" + t._s(e.amount))]), s("div", {
                        staticClass: "NewAdItemImageBox"
                    }, [s("img", {
                        staticClass: "NewAdItemImage",
                        attrs: {
                            src: "img/" + e.name + ".png",
                            alt: ""
                        }
                    })]), s("div", {
                        staticClass: "NewAdItemButton"
                    }, [s("p", [t._v(t._s(t.shared.translate.ANNOUNCE))])])])
                })), 0)])])])
            },
            x = [],
            M = {
                components: {
                    Loading: v
                },
                props: {
                    shared: {},
                    functions: {}
                },
                data: function () {
                    return {
                        products: [{
                            name: "energy",
                            label: "Energy",
                            amount: 500,
                            weight: 1,
                            price: 1e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "firstaid",
                            label: "First Aid",
                            amount: 500,
                            weight: 1,
                            price: 2e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_pistol",
                            label: "Pistol",
                            amount: 500,
                            weight: 1,
                            price: 3e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 5e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }, {
                            name: "weapon_heavyshotgun",
                            label: "Heavy Shotgun",
                            amount: 500,
                            weight: 1,
                            price: 51e3,
                            identifier: "asdad",
                            owner: "Anonymous"
                        }],
                        search: "",
                        sort_by: 0,
                        selected_price: 0,
                        selected_product: {
                            price: 0
                        },
                        selected_amount: 1,
                        anonymous: !1,
                        page_product: !1,
                        is_loading: !0
                    }
                },
                methods: {
                    SelectProduct: function (t) {
                        this.selected_product = t, this.selected_product.price = 0, this.page_product = !0
                    },
                    ChangeAmount: function (t, e) {
                        e || (this.selected_amount += t), this.selected_amount > this.selected_product.amount ? this.selected_amount = this.selected_product.amount : this.selected_amount <= 0 && (this.selected_amount = 1)
                    },
                    SetSortBy: function (t) {
                        this.sort_by = t
                    },
                    SetAnonymous: function (t) {
                        this.anonymous = t
                    },
                    SortProducts: function () {
                        for (var t = 0; t < this.products.length; t++)
                            for (var e = 0; e < this.products.length; e++)
                                if (0 == this.sort_by) {
                                    if (this.products[t].label < this.products[e].label) {
                                        var s = this.products[t];
                                        this.products[t] = this.products[e], this.products[e] = s
                                    }
                                } else if (1 == this.sort_by) {
                            if (this.products[t].price < this.products[e].price) {
                                var a = this.products[t];
                                this.products[t] = this.products[e], this.products[e] = a
                            }
                        } else if (2 == this.sort_by && this.products[t].price > this.products[e].price) {
                            var r = this.products[t];
                            this.products[t] = this.products[e], this.products[e] = r
                        }
                        return this.products
                    },
                    CheckPriceValue: function () {
                        "number" != typeof this.selected_price && (this.selected_price = 0), this.selected_price < 0 && (this.selected_price = 0), this.selected_product.price = this.selected_price
                    },
                    SellProduct: function () {
                        this.functions.SendToClient("SellProduct", {
                            product: this.selected_product,
                            amount: this.selected_amount,
                            anonymous: this.anonymous
                        }), this.functions.OpenScreen("Transaction")
                    },
                    ReceiveLua: function (t) {
                        if (t && t.data) {
                            var e = t.data;
                            if (e.load_inventory) {
                                for (var s in this.products = [], e.products) null != e.products[s] && e.products[s].amount > 0 && this.products.push(e.products[s]);
                                this.is_loading = !1
                            }
                        }
                    }
                },
                created: function () {
                    window.addEventListener("message", this.ReceiveLua), this.is_loading = !0, this.functions.SendToClient("LoadInventory", {})
                },
                destroyed: function () {
                    window.removeEventListener("message", this.ReceiveLua)
                }
            },
            k = M,
            Y = (s("d09a"), Object(h["a"])(k, N, x, !1, null, null, null)),
            U = Y.exports,
            D = function () {
                var t = this,
                    e = t.$createElement,
                    s = t._self._c || e;
                return s("div", [s("div", {
                    attrs: {
                        id: "TransactionBox"
                    }
                }, [s("Loading", {
                    attrs: {
                        text: t.shared.translate.TRANSACTION,
                        size: 10,
                        color2: "black",
                        use_background: !1,
                        shared: t.shared,
                        functions: t.functions
                    }
                })], 1)])
            },
            H = [],
            F = {
                components: {
                    Loading: v
                },
                props: {
                    shared: {},
                    functions: {}
                },
                methods: {
                    ReceiveLua: function (t) {
                        if (t && t.data) {
                            var e = t.data;
                            e.finish_transaction && this.functions.OpenScreen("Products")
                        }
                    }
                },
                created: function () {
                    window.addEventListener("message", this.ReceiveLua)
                },
                destroyed: function () {
                    window.removeEventListener("message", this.ReceiveLua)
                }
            },
            W = F,
            G = (s("6497"), Object(h["a"])(W, D, H, !1, null, null, null)),
            j = G.exports,
            V = {
                components: {
                    Products: T,
                    MyAds: O,
                    MySolds: I,
                    NewAd: U,
                    Transaction: j
                },
                data: function () {
                    return {
                        page: "",
                        total_solds: 0,
                        shared: {
                            application_fee: .5,
                            sell_fee: .2,
                            light_mode: !1,
                            translate: {
                                TR_TITLE_WHITE: "MERCADO     ",
                                TR_TITLE_YELLOW: "NEGRO      ",
                                TR_PRODUCTS: "PRODUCTOS         ",
                                TR_MYADS: "MEUS     ",
                                TR_NEWAD: "NOVO AD       ",
                                TR_SOLD: "SOLD          ",
                                TR_SORTBY: "ORG POR             ",
                                TR_SEARCH: "Procurar um producto            ",
                                TR_NAME: "Nome           ",
                                TR_LOWEST: "Mais baixo          ",
                                TR_BIGGEST: "Mais alto        ",
                                TR_WHITE_BUY: "COMPRAR          ",
                                TR_YELLOW_BUY: "AGORA            ",
                                TR_BY: "Por           ",
                                TR_WALLET: "  ",
                                TR_SIMBOL_MONEY: "€  ",
                                TR_BACK: "Voltar         ",
                                TR_TOTAL_AMOUNT: "Total:          ",
                                TR_WEIGHT: "Peso      ",
                                TR_PRICE_PRODUCT: "Preço do producto          ",
                                TR_APPLICATION_FEE: "Comissão   ",
                                TR_FINAL_PRICE: "Preço final do producto          ",
                                TR_CONFIRM_BUY: "Confirmar        ",
                                TR_REMOVE: "REMOVER           ",
                                TR_CONFIRM_REMOVE: "Confirmar Remover                ",
                                TR_COLLECT: "RECEBER         ",
                                TR_ANNOUNCE: "ANUNCIAR           ",
                                TR_CONFIRM_ANNOUNCE: "Confirmar Anuncio            ",
                                TR_MESSAGE_REMOVE: "Não iras pagar nada quando apagares o anúncio.       ",
                                TR_PRICE_PER_UNIT: "Qual o preço a unidade?            ",
                                TR_ANONYMOUS: "Anonymous           ",
                                TR_PRICE_FEE: "Para anunciar vais pagar comissão de            ",
                                TR_VALUE_RECEIVE: "Quando vender tudo irás recebe         r",
                                TR_LOADING_PRODUCTS: "A carregar productos...           ",
                                TR_LOADING_MYADS: "A carregar anúncios...            ",
                                TR_LOADING_NEWAD: "A carregar teu inventorio...           ",
                                TR_LOADING_SOLD: "A carregar vendas...           ",
                                TR_TRANSACTION: "A fazer transação...          "
                            }
                        },
                        functions: {},
                        name_resource: "s_market",
                        openned: !1
                    }
                },
                methods: {
                    OpenScreen: function (t) {
                        this.page = t
                    },
                    ReduceString: function (t, e) {
                        var s = t;
                        return s.length > e && (s = s.substring(0, e)), s
                    },
                    SetTotalSolds: function (t) {
                        this.total_solds = t
                    },
                    SetFunctions: function () {
                        this.functions = {
                            ReduceString: this.ReduceString,
                            SetTotalSolds: this.SetTotalSolds,
                            OpenScreen: this.OpenScreen,
                            SendToClient: this.SendToClient,
                            Close: this.Close
                        }
                    },
                    ReceiveLua: function (t) {
                        if (t && t.data) {
                            var e = t.data;
                            e.config ? (this.shared.translate = e.translate, this.shared.application_fee = e.application_fee, this.shared.sell_fee = e.sell_fee, this.name_resource = e.name_resource) : e.open && (this.page = "Products", this.openned = !0)
                        }
                    },
                    SendToClient: function (t, e) {
                        n.a.post("https://".concat(this.name_resource, "/").concat(t), e).catch((function (e) {
                            return console.log("An error occurred in: ".concat(t, " , ").concat(e))
                        }))
                    },
                    Close: function () {
                        this.SendToClient("close", {}), this.openned = !1, this.page = ""
                    },
                    KeyPress: function (t) {
                        var e = t.key;
                        "Escape" == e && this.Close()
                    }
                },
                created: function () {
                    this.SetFunctions(), window.addEventListener("message", this.ReceiveLua), window.addEventListener("keydown", this.KeyPress)
                },
                destroyed: function () {
                    window.removeEventListener("message", this.ReceiveLua), window.removeEventListener("keydown", this.KeyPress)
                }
            },
            $ = V,
            z = (s("034f"), Object(h["a"])($, r, o, !1, null, null, null)),
            K = z.exports;
        a["a"].config.productionTip = !1, new a["a"]({
            render: function (t) {
                return t(K)
            }
        }).$mount("#app")
    },
    6497: function (t, e, s) {
        "use strict";
        s("e2f9")
    },
    "819f": function (t, e, s) {
        "use strict";
        s("2df2")
    },
    "85ec": function (t, e, s) {},
    d09a: function (t, e, s) {
        "use strict";
        s("eff5")
    },
    e2f9: function (t, e, s) {},
    e41f: function (t, e, s) {},
    eff5: function (t, e, s) {}
});