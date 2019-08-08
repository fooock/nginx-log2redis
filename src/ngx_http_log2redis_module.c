#include <nginx.h>
#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>

static ngx_int_t
ngx_http_log2redis_postconfig(ngx_conf_t *cf)
{
    return NGX_OK;
}

static ngx_http_module_t ngx_http_log2redis_module_ctx = {
    NULL,                          /* preconfiguration */
    ngx_http_log2redis_postconfig, /* postconfiguration */
    NULL,                          /* create main configuration */
    NULL,                          /* init main configuration */
    NULL,                          /* create server configuration */
    NULL,                          /* merge server configuration */
    NULL,                          /* create location configuration */
    NULL                           /* merge location configuration */
};

static ngx_command_t ngx_log2redis_commands[] = {};

ngx_module_t ngx_http_log2redis_module = {
    NGX_MODULE_V1,
    &ngx_http_log2redis_module_ctx, /* module context */
    ngx_log2redis_commands,         /* module directives */
    NGX_HTTP_MODULE,                /* module type */
    NULL,                           /* init master */
    NULL,                           /* init module */
    NULL,                           /* init process */
    NULL,                           /* init thread */
    NULL,                           /* exit thread */
    NULL,                           /* exit process */
    NULL,                           /* exit master */
    NGX_MODULE_V1_PADDING};
