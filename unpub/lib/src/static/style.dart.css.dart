const content =
"""*{box-sizing:border-box}body{background-color:#fff;color:#4a4a4a;font-size:14px;line-height:1.6;margin:0;padding:0;overflow-wrap:break-word}body,input,button{font-family:"Roboto",sans-serif;-webkit-font-smoothing:antialiased}p{font-size:16px}body,.markdown-body{font-weight:400;font-size:16px}body h1,body h2,body h3,body h4,body h5,body h6,.markdown-body h1,.markdown-body h2,.markdown-body h3,.markdown-body h4,.markdown-body h5,.markdown-body h6{font-family:"Google Sans","Roboto",sans-serif;font-weight:400}body h1,.markdown-body h1{font-size:36px}body h2,.markdown-body h2{font-size:24px}body h3,.markdown-body h3{font-size:18px}body h4,.markdown-body h4{font-size:18px}body h5,.markdown-body h5{font-size:16px}body h6,.markdown-body h6{font-size:16px}img{max-width:100%}:root{--mdc-theme-primary: #0175C2}summary{cursor:pointer;background:transparent;transition:background-color .3s}summary:hover{background:#ddf1ff}summary:focus{outline:0}button{cursor:pointer;border:none}button.pub-button-danger{--mdc-theme-primary: #ff4242}button.pub-button-cancel{--mdc-theme-primary: #f0f0f0;--mdc-theme-on-primary: #000000}a{text-decoration:none;color:#0175c2;cursor:pointer;opacity:1}a:hover{opacity:.8}main{min-height:calc(100vh - 222px)}.container,.-wide-header-detail-page .detail-container{max-width:auto;margin:0 auto;padding:0 20px}code{background:#f8f8f8;border:1px solid #eee;font-family:"Roboto Mono","Source Code Pro",Menlo,"Bitstream Vera Sans Mono","DejaVu Sans Mono",Monaco,Consolas,monospace;font-size:85%;padding:2px}.standalone-side-image-block{display:none;float:right;max-width:400px}.standalone-content{max-width:700px;margin:0px auto}@media(min-width: 1000px){.standalone-side-image-block{display:block}.standalone-wrapper.-has-side-image .standalone-content{margin:0px}}strong{font-weight:500}.markdown-body code,code{background:#f5f5f7;border:none;border-radius:4px;font-family:"Roboto Mono","Source Code Pro",Menlo,"Bitstream Vera Sans Mono","DejaVu Sans Mono",Monaco,Consolas,monospace;padding:2px 4px}.markdown-body pre,pre{background:#f5f5f7;line-height:1.2;padding:30px;overflow-x:auto}.markdown-body pre>code,pre>code{padding:0px !important;border-radius:0;display:inline-block}.-pub-pre-copy-container{position:relative}.-pub-pre-copy-container:hover .-pub-pre-copy-button{opacity:.35}.-pub-pre-copy-container .-pub-pre-copy-button{position:absolute;top:4px;right:4px;width:20px;height:20px;background:url("/static/img/content-copy-icon.svg?hash=fg6h81ph6ii0740g39jkvci8jiqi2j4p");background-position:center;background-repeat:no-repeat;background-size:16px 16px;cursor:copy;opacity:.15;transition:opacity .5s}.-pub-pre-copy-container .-pub-pre-copy-button:hover{opacity:1}.-pub-pre-copy-container .-pub-pre-copy-feedback{display:none;position:absolute;top:32px;right:4px;font-size:11px;padding:8px;background:#fafaff;box-shadow:0px 0px 2px 2px rgba(0,0,0,.05);white-space:nowrap;transition:opacity .9s}.-pub-pre-copy-container .-pub-pre-copy-feedback.visible{display:block}.-pub-pre-copy-container .-pub-pre-copy-feedback.fadeout{opacity:0}.markdown-body p{margin-top:8px;margin-bottom:12px}.markdown-body table td,.markdown-body table th{padding:12px 12px 12px 0;border:none}.markdown-body table tr{border-top:none}.markdown-body table tr:nth-child(2n){background-color:inherit}.markdown-body table th{font-family:"Google Sans","Roboto",sans-serif;font-size:16px;font-weight:400;border-bottom:1px solid #c8c8ca;text-align:left}.markdown-body table td{border-bottom:1px solid #f5f5f7}.markdown-body table img{background-color:inherit}._banner-bg{background:#132030;background-image:url("/static/img/hero-bg-static.svg?hash=pvblnkq8qgr4g10hr78tnibbr2qdpuqt");background-size:cover;color:#8d9399;padding:10px 0px}._banner-bg a{color:#FFFFFF}._visuallyhidden{border:0;clip:rect(0 0 0 0);height:1px;margin:-1px;overflow:hidden;padding:0;position:absolute;width:1px}._visuallyhidden:active,._visuallyhidden:focus{clip:auto;height:auto;margin:0;overflow:visible;position:static;width:auto}.-pub-publisher-shield{vertical-align:middle;margin:-1px 2px 0 0;width:15px;height:15px}.-pub-publisher{display:inline-block}.-pub-like-button{--mdc-theme-primary: #f8f8f8;--mdc-theme-on-primary: \$site-font-color}.-pub-like-button-img{opacity:.7}.center{text-align:center}.spinner-frame{position:fixed;top:0;bottom:0;left:0;right:0;z-index:10000;background:rgba(0,0,0,.2);display:flex;align-items:center;justify-content:center}.spinner-frame .spinner{border:8px solid #f3f3f3;border-top:8px solid #0175c2;border-radius:50%;width:60px;height:60px;animation:spin 3s linear infinite}@keyframes spin{0%{transform:rotate(0deg)}100%{transform:rotate(360deg)}}.hash-link{color:#ccc;opacity:0;visibility:hidden;transition:opacity .5s ease-in-out .1s}.hash-header:hover .hash-link{visibility:visible;opacity:1}.foldable .foldable-content{display:none;overflow:hidden;transition:max-height .6s ease}.announcement-banner{padding:10px 0;background:#e7f8ff;font-size:16px;text-align:center}@media(max-width: 640px){.page-landing .site-header a.logo{display:none}}.site-header{background:#1c2834;color:#f8f9fa;display:flex;align-items:center;height:40px;padding:0px 18px;font-size:14px;position:relative}@media(max-width: 640px){.site-header:focus-within .hamburger,.site-header:focus-within .site-logo{opacity:.3}}@media(min-width: 641px){.site-header{height:121px;padding:0px 45px 0px 50px}}.site-header .site-header-space{flex-grow:1}.site-header .hamburger{display:block;background-color:transparent;width:24px;height:40px;background-position:center;margin-right:18px;background-image:url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfjBB0KByvlnQBfAAAANklEQVRYw+3TsQkAMAgAQZP9dzZVwAESRLjrbBSLjwDot+qQ+Whp2bp/fzD/AChZyaBkJQNcB6AzBhZq14GdAAAAAElFTkSuQmCC");background-size:100%;background-repeat:no-repeat;opacity:.8}@media(min-width: 641px){.site-header .hamburger{display:none}}.site-header a.logo{display:inline-block;height:30px;align-items:center}.site-header a.logo .site-logo{height:30px;width:auto}.site-header .site-header-mask{display:none;position:fixed;top:0;left:0;bottom:0;right:0;background:rgba(0,0,0,.5);z-index:1000}.site-header .site-header-mask.-show{display:block}@media(max-width: 640px){.site-header .site-header-search{flex-grow:10;text-align:right}}.site-header .site-header-search .site-header-search-input{height:25px;width:25px;padding:5px 20px 5px 5px;color:#f8f9fa;background-color:#1c2834;background-image:url("/static/img/search-icon-light.svg?hash=lbddtniv14k12bosn0phhc7jlr5i4rb4");background-repeat:no-repeat;background-position:right;background-size:23px 23px;transition:width .4s ease-in-out,background-color .4s linear;border:none;border-radius:5px;outline:none;cursor:pointer}.site-header .site-header-search .site-header-search-input:focus{width:240px;background-color:#2e4255;padding-left:10px;padding-right:30px;cursor:inherit}@media(max-width: 979px){.site-header .site-header-search .site-header-search-input:focus{width:120px}}@media(max-width: 640px){.site-header .site-header-search .site-header-search-input:focus{width:100%}}.site-header .nav-main-button{padding:8px 10px;margin-left:10px;vertical-align:middle;background-color:transparent;color:inherit;font-size:14px;height:50px}.site-header .nav-link{color:#f8f9fa;display:block;line-height:26px;white-space:nowrap}.site-header .nav-profile-img{display:block;width:30px;margin:10px;border-radius:50%}.site-header .nav-account-name{font-size:14px}.site-header .nav-account-email{font-size:12px}.site-header .nav-profile-img-mobile{display:none}.site-header .nav-help-container-mobile{display:none}.site-header .nav-help-container-mobile .foldable-icon{display:inline-block;position:relative;top:3px;left:16px;width:14px;height:14px;transform:rotate(90deg);transition:transform .3s linear}.site-header .nav-help-container-mobile.foldable.-active .foldable-icon{transform:rotate(180deg)}@media(max-width: 640px){.site-header .site-header-nav{position:fixed;top:0;bottom:0;left:0;width:80%;background:#1f3044;transform:translateX(-100%);transition:transform .3s ease;z-index:1001;opacity:0;overflow-y:auto;display:flex;flex-direction:column}.site-header .site-header-nav.-show{transform:translateX(0)}.site-header .site-header-nav .nav-container,.site-header .site-header-nav .nav-login-container{padding:16px;border-bottom:1px solid #4a5868}.site-header .site-header-nav .nav-container .nav-main-button,.site-header .site-header-nav .nav-login-container .nav-main-button{display:none}.site-header .site-header-nav .nav-profile-container{order:1}.site-header .site-header-nav .nav-profile-container .nav-profile-img{margin:0 16px 0 0}.site-header .site-header-nav .nav-profile-container .nav-profile-image-desktop{display:none}.site-header .site-header-nav .nav-profile-container .nav-profile-img-mobile{display:block}.site-header .site-header-nav .nav-profile-container .nav-account-title-mobile{display:flex;align-items:center}.site-header .site-header-nav .nav-login-container{order:1}.site-header .site-header-nav .nav-login-container .nav-main-button{display:block;margin-left:0px;height:auto;padding:0px}.site-header .site-header-nav .nav-my-container{order:2}.site-header .site-header-nav .nav-help-container{display:none}.site-header .site-header-nav .nav-help-container-mobile{display:block;order:3}.site-header .site-header-nav .nav-link{line-height:46px;opacity:.7}}@media(min-width: 641px){.site-header .site-header-nav{display:flex;transform:none}.site-header .site-header-nav .nav-container{position:relative}.site-header .site-header-nav .nav-container .nav-main-button:after{content:"";background-image:url("data:image/svg+xml, %3Csvg xmlns='http://www.w3.org/2000/svg' width='24px' height='24px' viewBox='0 0 24 24' fill='%23757575'%3E %3Cpath d='M7.41 7.84L12 12.42l4.59-4.58L18 9.25l-6 6-6-6z'/%3E %3Cpath d='M0-.75h24v24H0z' fill='none'/%3E %3C/svg%3E ");display:inline-block;width:18px;height:18px;vertical-align:middle;position:relative;top:-3px}.site-header .site-header-nav .nav-container:hover .nav-hover-popup,.site-header .site-header-nav .nav-container.hover .nav-hover-popup{display:block}.site-header .site-header-nav .nav-container .nav-hover-popup{display:none;position:absolute;background:#1f3044;color:#f8f9fa;min-width:200px;padding:8px 12px;top:50px;right:-20px;cursor:auto;cursor:initial;font-size:14px;z-index:2}.site-header .site-header-nav .nav-container .nav-table-columns{display:flex}.site-header .site-header-nav .nav-container .nav-table-column{padding:12px;min-width:100px}.site-header .site-header-nav .nav-container .nav-table-column>h3{border-bottom:1px solid #4a5868}.site-header .site-header-nav .nav-container .nav-separator{border-bottom:1px solid #4a5868;margin:8px 0px}}.activity-log-table{width:100%;border-spacing:0}.activity-log-table td,.activity-log-table th{border-bottom:1px solid #c8c8ca;padding:8px 4px;text-align:left}.activity-log-table td.date,.activity-log-table th.date{white-space:nowrap;width:100px}.activity-log-table>thead>tr>th{font-size:16px;font-weight:400}.activity-log-table>tbody{font-size:14px}.-wide-header-detail-page .detail-header,.-wide-header-detail-page .detail-tabs-wide-header{background:#f5f5f7}@media(min-width: 641px){.-wide-header-detail-page .detail-header{display:flex}}.detail-wrapper{display:none;position:relative}.detail-wrapper.-active{display:block}@media(max-width: 640px){.detail-wrapper .detail-info-box{display:none}}.detail-wrapper.-has-info-box .detail-header-content-block{width:100%}.detail-banners{position:absolute;top:0px;right:0px}@media(min-width: 641px){.detail-banners{width:200px}}.detail-banners .ff-banner{display:none}@media(min-width: 641px){.detail-banners .ff-banner-desktop{display:inline-block;width:75px;height:109px}}@media(max-width: 640px){.detail-banners .ff-banner-mobile{display:inline-block;width:47px;height:58px}}.detail-header{padding:30px 0 20px}.detail-header .title{font-family:"Google Sans Display","Google Sans","Roboto",sans-serif;margin:0;font-size:24px}@media(min-width: 641px){.detail-header .title{font-size:36px}}.detail-header.-is-loose{padding-top:64px}.detail-header.-is-loose .title{padding-bottom:10px}.detail-lead{display:none;margin-top:16px}@media(max-width: 640px){.detail-lead{display:block}}.detail-lead .detail-metadata-toggle-icon{float:right;font-size:18px;width:28px;height:28px;text-align:center;cursor:pointer}.detail-lead .detail-lead-title{font-size:16px;margin:0}.detail-lead-more,.detail-lead-back{padding-right:16px;text-align:right}.detail-header .detail-header-outer-block{display:flex}.detail-header .detail-header-image{border-radius:50%;margin-right:24px;max-width:200px;max-height:200px}@media(max-width: 640px){.detail-header .detail-header-image{max-width:100px;max-height:100px}}.detail-header .metadata{margin-bottom:8px}.detail-header .detail-header-metadata-ref{display:flex;align-items:center}@media(min-width: 641px){.detail-header .detail-header-metadata-ref{display:inline-flex;margin-right:16px}}.detail-header .detail-header-metadata-ref-icon{width:14px;height:14px;margin-right:8px}.detail-header .detail-tags-and-like{display:flex;align-items:center}.detail-header .detail-tags{flex-grow:1}.detail-header .detail-like{font-family:"Roboto",sans-serif;font-size:14px;font-weight:500;text-transform:uppercase;white-space:nowrap;display:flex}.detail-header .detail-like .likes-count{display:inline-block;padding-top:6px}.detail-metadata{display:none}.detail-metadata.-active{display:block}.detail-metadata .title:first-child.pkg-infobox-metadata{display:none}.detail-metadata .detail-metadata-title{font-size:36px;margin:8px 0}.detail-metadata .detail-info-box{margin:0}@media(min-width: 641px){.detail-body>.detail-tabs{vertical-align:top}.detail-body>.detail-info-box{display:inline-block;margin-left:120px;width:190px}}@media(min-width: 641px)and (max-width: 979px){.detail-body>.detail-info-box{margin-left:40px}}@media(min-width: 641px){.detail-wrapper.-has-info-box .detail-header,.detail-wrapper.-has-info-box .detail-body>.detail-tabs{display:inline-block;width:calc(100% - 320px)}}@media(min-width: 641px)and (max-width: 979px){.detail-wrapper.-has-info-box .detail-header,.detail-wrapper.-has-info-box .detail-body>.detail-tabs{width:calc(100% - 240px)}}.detail-info-box{line-height:19px}.detail-info-box>.title{font-size:16px;margin:0}.detail-info-box>.title:not(:first-child){margin-top:16px;border-top:1px solid #c8c8ca;padding-top:16px}.detail-info-box br{content:" " !important;display:block !important;margin-bottom:8px !important}.detail-info-box>.link{text-overflow:ellipsis;overflow:hidden;white-space:nowrap;max-width:100%;display:inline-block;line-height:1.2em}.detail-tabs-header{list-style:none;margin:0 0 24px -12px;padding:0;background:#f5f5f7;display:flex;align-items:center;flex-wrap:wrap;white-space:nowrap}.detail-tabs-header>.detail-tab{display:block;transition:opacity 200ms}.detail-tabs-header>.detail-tab:last-child{margin-right:0}.detail-tabs-header>.detail-tab.-hidden{visibility:hidden;opacity:0}.detail-tabs-header>.tab-button,.detail-tabs-header>.tab-link>a{display:block;color:#4a4a4a;padding:12px 0px;margin:0px 18px 0px 12px;border-bottom:2px solid;border-bottom-color:transparent;cursor:pointer}.detail-tabs-header>.tab-button:hover,.detail-tabs-header>.tab-link>a:hover{border-bottom-color:#ddd}.detail-tabs-header>.tab-button.-active{font-weight:500;color:#1967d2;border-bottom-color:#1967d2}.detail-tabs-header>.tab-button.detail-tab-admin-title,.detail-tabs-header>.tab-link.detail-tab-admin-title>a,.detail-tabs-header>.tab-button.detail-tab-activity-log-title,.detail-tabs-header>.tab-link.detail-tab-activity-log-title>a{color:#900;position:relative;padding-right:9px}.detail-tabs-header>.tab-button.detail-tab-admin-title:hover,.detail-tabs-header>.tab-link.detail-tab-admin-title>a:hover,.detail-tabs-header>.tab-button.detail-tab-activity-log-title:hover,.detail-tabs-header>.tab-link.detail-tab-activity-log-title>a:hover{border-bottom-color:#900}.detail-tabs-header>.tab-button.detail-tab-admin-title:before,.detail-tabs-header>.tab-link.detail-tab-admin-title>a:before,.detail-tabs-header>.tab-button.detail-tab-activity-log-title:before,.detail-tabs-header>.tab-link.detail-tab-activity-log-title>a:before{content:" ";display:block;background:url("/static/img/admin-lock-icon.svg?hash=qv05ca0h6hmlvvp2g8a23qiueaa994u9");background-size:12px 12px;width:12px;height:12px;position:absolute;top:50%;right:4px;margin-top:-8px}.detail-tabs-header>.tab-button.detail-tab-admin-title:after,.detail-tabs-header>.tab-link.detail-tab-admin-title>a:after,.detail-tabs-header>.tab-button.detail-tab-activity-log-title:after,.detail-tabs-header>.tab-link.detail-tab-activity-log-title>a:after{content:"";display:inline-block;width:12px}.detail-tabs-header>.tab-button.detail-tab-admin-title,.detail-tabs-header>.tab-button.detail-tab-activity-log-title{border-bottom-color:#900}.detail-tabs-content>.tab-content{display:none}.detail-tabs-content>.tab-content.-active{display:block}#-pub-like-icon-button{width:26px;height:26px;padding:4px;margin:2px 6px 0 0}#-pub-like-icon-button>img{position:relative;top:-2px}.site-footer{padding:29px 16px 25px;margin:92px 0 0;text-align:center;font-size:14px;background:#27323a;color:#f8f9fa}.site-footer>a.link{color:#f8f9fa;padding-right:12px}.site-footer>a.link>.inline-icon{display:inline-block;max-height:20px;position:relative;top:5px}.site-footer>a.link.icon{padding:0px 6px}.site-footer>a.link.sep{border-left:1px solid #f8f9fa;padding-left:12px}.modal-content-hidden{display:none}#-admin-consent-buttons{margin-top:36px}#-admin-consent-reject-button{margin-right:16px}.-pub-form-row{margin-top:20px}.-pub-form-row label{display:block;margin-bottom:8px}.-pub-form-row .mdc-text-field{min-width:100%;margin-bottom:8px}.-pub-form-right-aligned{margin-top:20px;text-align:right}#-pub-publisher-admin-members-table{width:100%;border-width:0px}#-pub-publisher-admin-members-table .mdc-data-table__row{border-top-color:#f5f5f7}#-pub-publisher-admin-members-table .mdc-data-table__row:hover{background:inherit}#-pub-publisher-admin-members-table .mdc-data-table__row:nth-child(even){background:#f5f5f7}#-pub-publisher-admin-members-table .mdc-data-table__header-cell,#-pub-publisher-admin-members-table .mdc-data-table__cell{font-weight:400}#-pub-publisher-admin-members-table .mdc-data-table__cell{color:rgba(0,0,0,.85)}#-pub-publisher-admin-members-table .email-header{width:60%}#-pub-publisher-admin-members-table .role-header{width:30%}.-pub-remove-uploader-button,.-pub-remove-user-button{border-radius:3px;color:#4a4a4a;display:inline-block;padding:2px 8px}.-pub-remove-uploader-button:hover,.-pub-remove-user-button:hover{background:#ff4242;color:#fff}#-admin-set-publisher-input{min-width:225px}.search-controls-label{display:none;color:#5f6368;font-size:12px;font-weight:bold;margin-bottom:8px;text-transform:uppercase}@media(max-width: 640px){.search-controls-label{display:block}}.search-controls{background:#f5f5f7;display:none}@media(min-width: 641px){.search-controls .search-controls-subsdk{background:#fff;border-bottom:1px solid #d5d5d5;padding-top:8px}}.search-controls .search-controls-advanced{display:none}.search-controls .search-controls-advanced .search-controls-checkbox{display:flex;align-items:center;color:#6d7278}@media(min-width: 641px){.search-controls .search-controls-advanced{background:#fff;border-bottom:1px solid #d5d5d5}.search-controls .search-controls-advanced>.container{text-align:right}.search-controls .search-controls-advanced .search-controls-advanced-block{display:inline-block;text-align:left}}.search-controls.-active{display:block}.search-controls.-active .search-controls-advanced{display:block}@media(min-width: 641px){.search-controls{display:block}}.search-controls .search-controls-primary{padding:8px 0px}@media(min-width: 641px){.search-controls .search-controls-primary{display:flex;align-items:center;padding:0;position:relative}}.search-controls .search-controls-sdk{flex-grow:1}@media(min-width: 641px){.search-controls .search-controls-sdk.search-controls-buttons{display:none}}@media(max-width: 640px){.search-controls .search-controls-sdk.search-controls-tabs{display:none}}.search-controls .search-controls-tabs .list-filters .filter{border-bottom:2px solid transparent;color:#555;display:inline-block;margin-right:18px;padding:18px 0px 10px 0px}.search-controls .search-controls-tabs .list-filters .filter .filter-icon{display:none}.search-controls .search-controls-tabs .list-filters .filter:hover{border-bottom:2px solid #ccc;opacity:1}.search-controls .search-controls-tabs .list-filters .filter.-active{color:#0175c2;font-weight:bold;border-bottom:2px solid #0175c2}@media(max-width: 640px){.search-controls .search-controls-buttons .list-filters{margin-bottom:8px}}.search-controls .search-controls-buttons .list-filters .filter{background:#f5f5f7;border:1px solid #ccc;border-radius:15px;color:#212121;display:inline-block;font-size:14px;margin-bottom:8px;padding:3px 24px}.search-controls .search-controls-buttons .list-filters .filter .filter-icon{width:14px;height:14px;position:relative;left:-4px;top:3px}.search-controls .search-controls-buttons .list-filters .filter.-active{background:#0066d9;border-color:#0066d9;color:#fff}.search-controls .search-controls-more{display:none;color:#555;font-size:12px;white-space:nowrap;cursor:pointer}@media(min-width: 641px){.search-controls .search-controls-more{display:block;margin:1px 0 0 12px}}.search-controls .search-controls-more .search-controls-more-carot{margin-left:3px;width:6px;height:6px;position:relative;top:-1px;opacity:.6;transform:rotate(180deg);transition:transform .3s linear}.search-controls .search-controls-more.-active .search-controls-more-carot{transform:rotate(0deg)}.search-controls .search-controls-checkbox{padding:8px 0px}.listing-info{display:flex;padding:16px 0px 20px 0px}.listing-info .listing-info-count{flex-grow:1;overflow-x:auto;padding-right:12px}.listing-info .info-identifier{font-size:14px;font-weight:bold;text-transform:uppercase;white-space:nowrap}.listing-info .info-identifier .sort-control-selected{color:#1967d2;font-weight:400}@media(max-width: 640px){.listing-info .info-identifier .sort-control-selected{display:none}}.listing-info .count{background:rgba(218,220,224,.26);display:inline-block;font-size:12px;font-family:monospace;padding:5px}.sort-control{position:relative;cursor:pointer}.sort-control .sort-control-popup{display:none;box-shadow:0px 0px 2px 0px rgba(0,0,0,.3);position:absolute;right:0px;white-space:nowrap;z-index:1000}.sort-control .sort-control-popup .sort-control-option{background:#fff;font-size:14px;padding:8px 12px}.sort-control .sort-control-popup .sort-control-option:hover{background:#fafafa}.sort-control .sort-control-popup .sort-control-option.selected{background:#e7f8ff}.sort-control.hover .sort-control-popup{display:block}@media(min-width: 641px){.sort-control:hover .sort-control-popup{display:block}}.packages .packages-item{margin:0px -30px 6px -30px;padding:15px 30px}.packages .packages-item:hover{background:#fafafa}.packages .packages-header{display:flex;align-items:center;flex-wrap:wrap;justify-content:flex-end;min-height:40px}.packages .packages-title{flex-grow:1;font-size:22px;font-weight:500;margin:0;overflow-wrap:anywhere}.packages .packages-recent{color:#6d7278;font-family:"Google Sans","Roboto",sans-serif;font-size:12px;margin:0px 8px 0px 16px;white-space:nowrap}.packages .packages-recent .packages-recent-icon{width:10px;height:10px;opacity:.6;position:relative;top:1px}.packages .packages-description{margin:4px 0px}.packages .packages-metadata{font-size:12px}.packages .packages-metadata-block{margin:0 8px 0 0}.packages .packages-api{color:#3c4043;font-size:12px;margin-top:6px;display:flex}.packages .packages-api .packages-api-label{padding-right:8px}.packages .packages-api .packages-api-links{overflow-wrap:anywhere}.packages .packages-api .-rest{padding-left:16px}.packages.-compact .packages-item{padding:0;margin:8px 0}@media(min-width: 641px){.packages.-compact .packages-item{padding:4px 8px;margin-left:-8px}}.publishers .publishers-item{padding:4px;margin-left:-4px;margin-right:8px}.publishers .publishers-item:hover{background:#fafafa}.publishers .publishers-item .publishers-item-title{font-size:22px;font-weight:500}.publishers.-global{display:flex;flex-wrap:wrap}.publishers.-global .publishers-item{flex:1 1 26%}.pagination{margin:20px auto;padding:0;list-style:none;text-align:center}.pagination>li{display:inline-block;text-transform:uppercase;color:#0175c2;background:#f3f3f3;font-size:14px;border-radius:3px;margin-top:40px}.pagination>li.-disabled{pointer-events:none;color:#aaa}.pagination>li.-active{pointer-events:none;color:#fff;background:#0175c2}.pagination>li>a{display:inline-block;padding:10px 16px;color:inherit;font-weight:600}.landing-page-title{color:gray;font-weight:500;margin-bottom:0px}.landing-page-title-block{text-align:center;margin-bottom:1em}.home-banner{text-align:center;padding:30px 20px 0px 20px}.home-banner>.logo{width:100%;max-width:328px;max-height:70px;margin-bottom:28px}@media(max-width: 640px){.home-banner>.logo{max-width:188px;max-height:40px;margin-bottom:22px}}.home-banner>.text{margin:1em auto;max-width:500px;color:#fff;font-size:18px}.home-banner>.text>a{color:#31b0fc}.home-banner>.link{text-transform:uppercase;display:inline-block;margin:0 16px;font-weight:500;font-size:14px}.home-banner>.link:after{content:" >"}.home-banner>.banner-item{margin:0 auto}.home-banner{padding-top:20px;padding-bottom:20px}.landing-main{background-image:url("/static/img/square-bg-full-2x.png?hash=40uful0p6884ep2h7lt96a8cf5s68lsh");background-position:center top;background-repeat:repeat-y;background-size:1440px 2279px}.home-block{padding:20px}.home-block .home-block-title{color:#254a76;margin-bottom:0}.home-block .home-block-context-info{font-size:18px;margin-top:0}.home-block.home-block-ff,.home-block.home-block-pow{background:#f5f5f7}.home-block .home-block-image{display:none;position:relative;top:60px;transform:scale(1.25);z-index:0}.home-block .home-block-image>img{max-height:240px}.home-block .home-block-content{z-index:1}.home-block .mini-list-item{background:#fff;border-radius:4px;box-shadow:0px 2px 7px 0px rgba(0,0,0,.3);padding:28px 30px 30px;margin-bottom:10px;min-height:100px}.home-block .mini-list-item:hover{background:#fafafa;box-shadow:0px 4px 9px 0px rgba(0,0,0,.4)}@media(min-width: 641px){.home-block .mini-list-item:hover .mini-list-item-body:before{background:linear-gradient(transparent 90%, #fafafa)}}.home-block .mini-list-item .mini-list-item-title>h3{color:#1967d2;font-size:20px;line-height:1.3;margin:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.home-block .mini-list-item .mini-list-item-description{font-size:14px;margin:4px 0 0 0}.home-block .mini-list-item .mini-list-item-publisher{margin:8px 0px 0px 0px}.home-block .mini-list-item .publisher-badge{width:16px;height:16px;position:relative;top:4px}.home-block .mini-list-item .publisher-link{font-size:12px;display:inline-block}.home-block .home-block-view-all{text-align:right;padding-right:8px}@media(min-width: 641px){.home-block .home-block-view-all{margin-right:16px}}.home-block .home-block-view-all-link{font-size:16px;font-weight:500;text-transform:uppercase}@media(min-width: 641px){.home-block .mini-list{display:flex;flex-wrap:wrap;padding:4px;margin:-3px}.home-block .mini-list-item{width:260px;height:190px;margin:0px 16px 16px 0px;display:flex;flex-direction:column}.home-block .mini-list-item-body{flex-grow:1;overflow:hidden;position:relative}.home-block .mini-list-item-body:before{content:"";position:absolute;left:0;top:0;bottom:0;right:0;background:linear-gradient(transparent 90%, white)}}@media(min-width: 641px){.home-block.home-block-ff .home-block-content,.home-block.home-block-pow .home-block-content{margin:0 auto;max-width:556px}}@media(min-width: 641px)and (min-width: 870px){.home-block.home-block-ff .home-block-content,.home-block.home-block-pow .home-block-content{max-width:830px}}@media(min-width: 641px)and (min-width: 1150px){.home-block.home-block-ff .home-block-content,.home-block.home-block-pow .home-block-content{max-width:1110px}}@media(min-width: 641px){.home-block.home-block-ff .home-block-content .mini-list,.home-block.home-block-ff .home-block-content .landing-pow-list,.home-block.home-block-pow .home-block-content .mini-list,.home-block.home-block-pow .home-block-content .landing-pow-list{overflow:hidden;height:200px}}@media(min-width: 641px){.home-block.home-block-mp,.home-block.home-block-tf,.home-block.home-block-td{display:flex;max-width:596px;margin:0 auto;align-items:center}}@media(min-width: 641px)and (min-width: 870px){.home-block.home-block-mp,.home-block.home-block-tf,.home-block.home-block-td{max-width:870px}}@media(min-width: 641px)and (min-width: 1040px){.home-block.home-block-mp,.home-block.home-block-tf,.home-block.home-block-td{max-width:1480px}.home-block.home-block-mp .home-block-image,.home-block.home-block-tf .home-block-image,.home-block.home-block-td .home-block-image{display:block;max-width:calc(100% - 830px);min-width:calc(5% + 100px)}.home-block.home-block-mp .home-block-content,.home-block.home-block-tf .home-block-content,.home-block.home-block-td .home-block-content{width:830px}}.home-block.home-block-tf .home-block-image{left:-2.5%}.landing-pow-list{flex-wrap:wrap;padding:4px;margin:-3px -3px 10px -3px}@media(min-width: 641px){.landing-pow-list{display:flex}}.landing-pow-list .pow-video{margin:0 16px 16px 0;text-align:center;position:relative}.landing-pow-list .pow-video:hover>a{opacity:1}.landing-pow-list .pow-video:hover .pow-video-overlay-img-active{display:inline-block}.landing-pow-list .pow-video:hover .pow-video-overlay-img-inactive{display:none}.landing-pow-list .pow-video-thumbnail{height:auto;width:100%}@media(min-width: 641px){.landing-pow-list .pow-video-thumbnail{max-width:260px;max-height:190px}}.landing-pow-list .pow-video-overlay{display:flex;position:absolute;top:0;left:0;right:0;bottom:0;padding:35%;justify-content:center;align-items:center}.landing-pow-list .pow-video-overlay-img-active{display:none}.package-badge{display:inline-block;background:#fff;border:1px solid #0175c2;border-radius:20px;color:#0175c2;font-size:12px;padding:1px 6px;margin:0 8px 0 0}.package-badge .package-badge-icon{max-width:13px;max-height:13px;position:relative;top:2px}.detail-header-content-block .metadata .package-badge{margin-left:4px;margin-right:4px}.package-vp-icon{display:inline-block;height:14px;position:relative;top:3px;opacity:.5}.version-table{width:100%;border-spacing:0}.version-table td,.version-table th{border-bottom:1px solid #c8c8ca;padding:8px 4px;text-align:left}.version-table td.badge,.version-table th.badge{width:100px}@media(max-width: 640px){.version-table td.badge,.version-table th.badge{display:none}}.version-table td.sdk,.version-table th.sdk{white-space:nowrap;width:80px}.version-table td.uploaded,.version-table th.uploaded{white-space:nowrap;width:100px}.version-table td.documentation,.version-table th.documentation{width:60px;text-align:center}.version-table td.archive,.version-table th.archive{width:40px;text-align:center}.version-table>thead>tr>th{font-size:16px;font-weight:400}.version-table>thead>tr>th.version>span.label{display:inline-block;min-width:100%}.version-table>thead>tr>th.documentation>span.label,.version-table>thead>tr>th.archive>span.label{display:none}@media(max-width: 640px){.version-table>thead>tr>th.sdk>span.label,.version-table>thead>tr>th.uploaded>span.label{display:none}}.version-table>tbody{font-size:14px}.version-table>tbody .version{font-family:"Google Sans","Roboto",sans-serif;font-size:24px}.version-table .version-table-icon{opacity:.7}.changelog-entry{display:flex;padding:12px 0;border-bottom:1px solid #c8c8ca}.changelog-entry .changelog-version{border-bottom:none;margin:0;width:120px}.changelog-entry .changelog-content{flex-grow:1;font-size:14px;margin:4px 0 4px 16px;width:100%}.score-key-figures{display:flex;align-items:center;justify-content:space-evenly;padding:20px 0 30px 0}@media(min-width: 641px){.score-key-figures{padding:40px 0 50px 0}}.score-key-figures .score-key-figure-title{color:#1967d2;text-align:center}.score-key-figures .score-key-figure-value{font-family:"Google Sans Display","Google Sans","Roboto",sans-serif;font-size:32px;line-height:1}@media(min-width: 641px){.score-key-figures .score-key-figure-value{font-size:64px}}.score-key-figures .score-key-figure-supplemental{font-family:"Google Sans","Roboto",sans-serif;font-size:24px}.score-key-figures .score-key-figure-label{color:#555;font-family:"Roboto",sans-serif;font-size:14px;text-align:center;text-transform:uppercase}.pkg-report{border-bottom:1px solid #c8c8ca}.pkg-report .pkg-report-section{border-top:1px solid #c8c8ca;padding:13px 0}.pkg-report .pkg-report-header{display:flex;align-items:center;cursor:pointer}.pkg-report .pkg-report-header-icon,.pkg-report .pkg-report-content-icon{display:flex;align-items:center;min-width:40px;max-width:40px}.pkg-report .pkg-report-header-icon>.pkg-report-icon,.pkg-report .pkg-report-content-icon>.pkg-report-icon{width:18px}.pkg-report .pkg-report-header-title{flex-grow:1}.pkg-report .pkg-report-header-title{font-family:"Google Sans","Roboto",sans-serif;font-size:24px}.pkg-report .pkg-report-header-score{display:flex;align-items:center;font-family:"Google Sans","Roboto",sans-serif;font-size:22px}.pkg-report .pkg-report-header-score.-is-red{color:#e13701}.pkg-report .pkg-report-header-score.-is-yellow{color:orange}.pkg-report .pkg-report-header-score .foldable-icon{margin-left:18px;width:12px;transform:rotate(180deg);transition:transform .3s linear}.pkg-report .foldable.-active .foldable-icon{transform:rotate(360deg)}.pkg-report .pkg-report-content{padding-left:40px}@media(min-width: 641px){.pkg-report .pkg-report-content .markdown-body table{display:table}}.pkg-report .pkg-report-content-summary{margin:12px 0}.pkg-report .pkg-report-content-summary>h3{position:relative}.pkg-report .pkg-report-content-summary>h3 .report-summary-icon{position:absolute;right:100%;top:4px;width:14px;height:14px;margin-right:6px}.pkg-page-title-copy{position:relative;display:inline-block;height:20px;width:20px;margin-left:12px}.pkg-page-title-copy .pkg-page-title-copy-icon{display:block;width:20px;height:20px;cursor:copy;opacity:.1;transition:opacity .3s}h1.title:hover .pkg-page-title-copy .pkg-page-title-copy-icon{opacity:.5}.pkg-page-title-copy .pkg-page-title-copy-feedback{position:absolute;top:-12px;left:32px;font-size:11px;padding:8px;background:#fafaff;box-shadow:0px 0px 2px 2px rgba(0,0,0,.05);white-space:nowrap;opacity:1;display:none;transition:opacity .9s}.pkg-page-title-copy .pkg-page-title-copy-feedback>.code{font-family:"Roboto Mono","Source Code Pro",Menlo,"Bitstream Vera Sans Mono","DejaVu Sans Mono",Monaco,Consolas,monospace;display:block}.pkg-page-title-copy .pkg-page-title-copy-feedback.visible{display:block}.pkg-page-title-copy .pkg-page-title-copy-feedback.fadeout{opacity:0}.tool-env-info{margin-top:40px;font-size:14px}.detail-tab-license-content.markdown-body .highlight pre{font-size:60%}@media(min-width: 641px){.detail-tab-license-content.markdown-body .highlight pre{font-size:1.2vw}}.packages-scores{display:flex;align-items:center;font-family:"Google Sans","Roboto",sans-serif}.packages-scores:hover{opacity:1}.packages-scores .packages-score{min-width:45px}@media(min-width: 641px){.packages-scores .packages-score{min-width:55px}}.detail-info-box .packages-scores .packages-score{min-width:0px}.packages-scores .packages-score:not(:last-child){border-right:1px solid #e0e0e0;margin-right:4px;padding-right:4px}@media(min-width: 641px){.packages-scores .packages-score:not(:last-child){margin-right:8px;padding-right:8px}}.packages-scores .packages-score-value{color:#6d7278;text-align:center;white-space:nowrap}.packages-scores .packages-score-value.-has-value{color:#0175c2}.detail-info-box .packages-scores .packages-score-value{text-align:left}.packages-scores .packages-score-value-number{font-size:18px}@media(min-width: 641px){.packages-scores .packages-score-value-number{font-size:22px}}.packages-scores .packages-score-value-sign{font-size:10px;vertical-align:super}@media(min-width: 641px){.packages-scores .packages-score-value-sign{font-size:12px}}.packages-scores .packages-score-label{color:#6d7278;font-size:10px;letter-spacing:.1px;text-transform:uppercase;text-align:center;white-space:nowrap}@media(min-width: 641px){.packages-scores .packages-score-label{font-size:12x;letter-spacing:.2px}}.detail-info-box .packages-scores .packages-score-label{text-align:left}.search-bar{display:flex;align-items:center;border-radius:3px;max-width:710px;background:transparent;position:relative;margin:0 auto;padding:13px 0}.home-banner .search-bar{max-width:880px}.search-bar>.input{font-size:16px;padding:15px 24px 14px 48px;border:none;border-radius:24px;width:150px;-webkit-box-flex:1;-ms-flex-positive:1;flex-grow:1;background:#35404d;color:#fff}.search-bar>.input::placeholder{color:#888}@media(min-width: 641px){.home-banner .search-bar>.input{font-size:24px;padding:20px 35px 20px 65px;border-radius:35px}}.search-bar>.input:focus{outline:none}.search-bar>.icon{width:45px;height:45px;background-color:#0175c2;background-image:url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABGdBTUEAALGPC/xhBQAAARdJREFUOBHNkz1uwkAQhTGkhCuELlQUiAtwilzHtU8BVLkHF4iokbJJkS41EiTS5nvL2FrQGMsdIz3N7ntvZn+8HgyyiDEuwBv4BifLmi8yW/sQ4xMowRl4Ib4Eo/YuKGYixT9QgSUYW9ZcvKJsbYSo42hFmVeeUbzp8vnHRNAdKCqvSc1JTy78NXeVEXWxiuWVcDORnlz4b6TLFFFfRzF2DUaiT5IrxqPnG0L+mDDzDBn3YuNDxjVDNdrZ7LVh/UGtv7sy2+3z1X7xz91GIhFLoOh6R+vWJtao62VrgW1aKsZP8rSrYf6vHSnYgw1IxyEHoAjgfrN7K6kYBKAI4DGbfbCzZ72j3lEUxRdFKxB6F3sF2okg7R/6f6gee6OuegAAAABJRU5ErkJggg==");background-repeat:no-repeat;background-position:50% 50%;background-color:transparent;opacity:.4;position:absolute;left:10px;transform:scale(0.72)}@media(min-width: 641px){.home-banner .search-bar>.icon{left:20px;transform:scale(1)}}.search-filters-btn-wrapper{display:none}@media(max-width: 640px){.search-filters-btn-wrapper{display:block}}.search-filters-btn-wrapper .search-filters-btn{cursor:pointer;display:block;width:40px;height:40px;margin-left:8px}.search-filters-btn-wrapper .search-filters-btn-inactive{display:block}.search-filters-btn-wrapper .search-filters-btn-active{display:none}.search-filters-btn-wrapper.-active .search-filters-btn-inactive{display:none}.search-filters-btn-wrapper.-active .search-filters-btn-active{display:block}.search-bar-details{position:relative;max-width:650px}.search-bar-options{font-size:14px}@media(min-width: 600px){.search-bar-options{position:absolute;top:16px;right:0px}}.package-tag{background:#eef9fe;text-transform:uppercase;display:inline-block;font-size:12px;margin:0px 0 4px 4px;color:#2465df;padding:7px 10px}.package-tag.missing{background:#f0f0f0;color:#555}.package-tag.unidentified,.package-tag.unlisted{background:#fff0f0;color:#555}.package-tag.legacy,.package-tag.discontinued{background:#c0392b;color:#f8f8f8}.-pub-tag-badge{font-size:12px;display:inline-block;margin-right:15px;background:#e7f8ff}.-pub-tag-badge>.tag-badge-main,.-pub-tag-badge>.tag-badge-sub{display:inline-block;text-transform:uppercase;padding:4px 8px;color:#1967d2}.-pub-tag-badge>.tag-badge-main{color:#1967d2;border-right:1px solid rgba(25,103,210,.5);font-weight:500}/*# sourceMappingURL=style.css.map */""";
