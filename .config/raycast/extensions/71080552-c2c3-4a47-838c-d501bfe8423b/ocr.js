"use strict";var w=Object.create;var i=Object.defineProperty;var T=Object.getOwnPropertyDescriptor;var k=Object.getOwnPropertyNames;var C=Object.getPrototypeOf,P=Object.prototype.hasOwnProperty;var b=(e,t)=>{for(var o in t)i(e,o,{get:t[o],enumerable:!0})},g=(e,t,o,r)=>{if(t&&typeof t=="object"||typeof t=="function")for(let a of k(t))!P.call(e,a)&&a!==o&&i(e,a,{get:()=>t[a],enumerable:!(r=T(t,a))||r.enumerable});return e};var $=(e,t,o)=>(o=e!=null?w(C(e)):{},g(t||!e||!e.__esModule?i(o,"default",{value:e,enumerable:!0}):o,e)),v=e=>g(i({},"__esModule",{value:!0}),e);var S={};b(S,{default:()=>y});module.exports=v(S);var n=require("@raycast/api"),l=require("child_process"),s=$(require("fs"));function M(e){let{status:t,stdout:o,stderr:r}=(0,l.spawnSync)("/usr/sbin/screencapture",["-i",e],{stdio:"ignore"});return t}async function y(){let{mode:e,language:t,level:o,customWords:r}=(0,n.getPreferenceValues)(),a="deeplink";await(0,n.closeMainWindow)({clearRootSearch:!0});let d=`${n.environment.assetsPath}/ocr_img`,m=`${n.environment.assetsPath}/ocr`,h=u=>new Promise(p=>setTimeout(p,u)),c=`${d}/${Date.now()}.png`;await s.default.promises.mkdir(d,{recursive:!0});try{await s.default.promises.access(m,s.default.constants.X_OK)}catch{await s.default.promises.chmod(m,509)}if(M(c),s.default.existsSync(c)){(0,n.showHUD)("Processing..."),await h(1);let{status:u,output:p,stdout:W,stderr:f,error:x}=(0,l.spawnSync)(m,[...a=="deeplink"?["deeplink",c]:[c],t,`"${r}"`,o,e]);u!=0&&(0,n.showHUD)(`Failed:${f?f.toString():"none"}`)}else(0,n.showHUD)("Cancel")}