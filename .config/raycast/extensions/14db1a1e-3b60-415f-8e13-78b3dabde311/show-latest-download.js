"use strict";var x=Object.create;var c=Object.defineProperty;var A=Object.getOwnPropertyDescriptor;var h=Object.getOwnPropertyNames;var F=Object.getPrototypeOf,T=Object.prototype.hasOwnProperty;var M=(o,e)=>()=>(e||o((e={exports:{}}).exports,e),e.exports),R=(o,e)=>{for(var r in e)c(o,r,{get:e[r],enumerable:!0})},d=(o,e,r,i)=>{if(e&&typeof e=="object"||typeof e=="function")for(let s of h(e))!T.call(o,s)&&s!==r&&c(o,s,{get:()=>e[s],enumerable:!(i=A(e,s))||i.enumerable});return o};var k=(o,e,r)=>(r=o!=null?x(F(o)):{},d(e||!o||!o.__esModule?c(r,"default",{value:o,enumerable:!0}):r,o)),q=o=>d(c({},"__esModule",{value:!0}),o);var f=M((G,p)=>{"use strict";var O=require("os"),l=O.homedir();p.exports=o=>{if(typeof o!="string")throw new TypeError(`Expected a string, got ${typeof o}`);return l?o.replace(/^~(?=$|\/|\\)/,l):o}});var C={};R(C,{default:()=>P});module.exports=q(C);var n=require("@raycast/api");var a=require("@raycast/api"),t=require("fs"),w=require("path"),u=k(f()),_=require("react/jsx-runtime"),y=(0,a.getPreferenceValues)(),m=(0,u.default)(y.downloadsFolder??"~/Downloads");function S(){return(0,t.readdirSync)(m).filter(e=>!e.startsWith(".")).map(e=>{let r=(0,w.join)(m,e),i=(0,t.statSync)(r).mtime;return{file:e,path:r,lastModifiedAt:i}}).sort((e,r)=>r.lastModifiedAt.getTime()-e.lastModifiedAt.getTime())}function g(){let o=S();if(!(o.length<1))return o[0]}function D(){try{return(0,t.accessSync)(y.downloadsFolder,t.constants.R_OK),!0}catch(o){return console.error(o),!1}}async function P(){if(!D()){await(0,n.showHUD)("No permission to access the downloads folder");return}let o=g();if(!o){await(0,n.showHUD)("No downloads found");return}await(0,n.showInFinder)(o.path),await(0,n.popToRoot)()}
