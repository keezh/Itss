/**
 * Created by kee on 15/10/25.
 */
requirejs.config({

    baseUrl: ctx + '/static',


    shim: {
        'datatables.net': {deps: ['jquery', 'bootstrap', 'datatables'], exports: "datatables.net"},
        'metisMenu': ['jquery'],
        'slimscroll': ['jquery'],
        'bootstrap': ['jquery'],
        'jstree': ['jquery'],
        'ztree': ['jquery'],
        'validateZh': ['validate'],
        'additionalMethods': ['validate'],
        'validate': ['jquery'],
        'jsonFormat': ['jquery'],
        'layer': ['jquery']
    },


    paths: {
        'jquery': 'jquery/jquery-2.2.4.min',
        'bootstrap': 'bootstrap/js/bootstrap.min',
        'validate': 'validate/jquery.validate.min',
        'validateZh': 'validate/localization/messages_zh.min',
        'additionalMethods': 'validate/additional-methods.min',
        'metisMenu': 'metisMenu/metisMenu.min',
        'slimscroll': 'slimscroll/jquery.slimscroll.min',
        'datatables.net': 'dataTables/js/dataTables.bootstrap.min',
        'datatables': 'dataTables/js/jquery.dataTables.min',
        'jstree': 'jstree/jstree.min',
        'ztree': 'ztree/js/jquery.ztree.all.min',
        'layer': 'layer/layer',
        'jsonFormat': 'jsonFormat/jsonFormat',
        'yaya': 'yaya/js/yaya'
    }
});