/*   Copyright (C) 2013-2014 Computer Sciences Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. */

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.


//= require jquery
//= require jquery_ujs
//= require jquery-switch
//= require jquery-accordion
//= require js-routes
//= require angular
//= require angular-resource
//= require lodash
//= require chosen-jquery
//= require angular-chosen

//= require_tree


// turbolinks must be included after jquery
// <> require turbolinks

//= require bootstrap-sprockets
//= require angular-ui-bootstrap-tpls

$(document).ready(function () {

    // Sliding Panel Toggle
	
	$('#webapp-menu-panel').on('click', function(){
		    
	    if($('#webapp-side-panel').hasClass('bounceInLeft')) {       
	        $('#webapp-side-panel').removeClass('bounceInLeft');
	        $('#webapp-side-panel').addClass('bounceOutLeft');
	        $('#webapp-content').addClass('bounceOutLeftCustom');
	        $('#webapp-content').removeClass('bounceInLeftCustom');
	    }
	    else{
	    	$('#webapp-side-panel').removeClass('bounceOutLeft');
	        $('#webapp-side-panel').addClass('bounceInLeft');
	        $('#webapp-content').addClass('bounceInLeftCustom');
	        $('#webapp-content').removeClass('bounceOutLeftCustom');
	    }
	    
	});
	
	/*
    $('#webapp-menu-panel').on('click', function(e){
        if($('#webapp-content').hasClass('content-full')) {
            $('#webapp-content').removeClass('content-full');
        }
        else{
            $('#webapp-content').addClass('content-full');
        }
        if($('#webapp-side-panel').hasClass('hide')) {
            $('#webapp-side-panel').removeClass('hide');
        }
        else{
            $('#webapp-side-panel').addClass('hide');
        }
        e.preventDefault();
    });
    */

    // Add Shadow to Header onScroll

    $('.section').scroll(function() {

        var scroll = $('.section').scrollTop();
        if (scroll > 0) {
            $('.controls-wrapper').addClass('shadow');
        }
        else {
            $('.controls-wrapper').removeClass('shadow');
        }

    });

    // Results Text-Only Tables Draw Height + 20px for Padding-Bottom

	/*
    $('.results-draw-table').each(function(){
        $(this).height($('ul.results-list-return',this).height()+$('.pagination',this).outerHeight()+54);
    });
    */

    // Results Text-Only Tables

    // Results Text-Only Tables (Toggle Features)

    $('.results-toggle-features').on('click', function(){
        if($('.results-toggle-features').hasClass('toggle-inactive')) {
            $('.results-toggle-features').removeClass('toggle-inactive');
        }
        else{
            $('.results-toggle-features').addClass('toggle-inactive');
        }
    });
    $('.results-toggle-features').on('click', function(){
        if($('.results-draw-features').hasClass('draw-collapse')) {
            $('.results-draw-features').removeClass('draw-collapse');
            $('a.collapse').addClass('active');
            $('a.expand').removeClass('active');
        }
        else{
            $('.results-draw-features').addClass('draw-collapse');
            $('a.collapse').removeClass('active');
            $('a.expand').addClass('active');
        }
    });

    // Results Text-Only Tables (Toggle Returns)

    $('.results-toggle-return').on('click', function(){
        if($('.results-toggle-return').hasClass('toggle-inactive')) {
            $('.results-toggle-return').removeClass('toggle-inactive');
        }
        else{
            $('.results-toggle-return').addClass('toggle-inactive');
        }
    });
    $('.results-toggle-return').on('click', function(){
        if($('.results-draw-return').hasClass('draw-collapse')) {
            $('.results-draw-return').removeClass('draw-collapse');
            $('a.collapse').addClass('active');
            $('a.expand').removeClass('active');
        }
        else{
            $('.results-draw-return').addClass('draw-collapse');
            $('a.collapse').removeClass('active');
            $('a.expand').addClass('active');
        }
    });

    // Results Text-Only Tables (Toggle Features - Auto Gen)

    $('.results-toggle-return-features').on('click', function(){
        if($('.results-toggle-return-features').hasClass('toggle-inactive')) {
            $('.results-toggle-return-features').removeClass('toggle-inactive');
        }
        else{
            $('.results-toggle-return-features').addClass('toggle-inactive');
        }
    });
    $('.results-toggle-return-features').on('click', function(){
        if($('.results-draw-return-features').hasClass('draw-collapse')) {
            $('.results-draw-return-features').removeClass('draw-collapse');
            $('a.collapse').addClass('active');
            $('a.expand').removeClass('active');
        }
        else{
            $('.results-draw-return-features').addClass('draw-collapse');
            $('a.collapse').removeClass('active');
            $('a.expand').addClass('active');
        }
    });

    // Results Text-Only Toggle Layout

    $('.results-toggle-table').on('click', function(){
	        $('.results-toggle-table').addClass('active');
	        $('.results-toggle-tile').removeClass('active');
	        $('ul.results-list-return').removeClass('format-tiles');
	});
	$('.results-toggle-tile').on('click', function(){
	        $('.results-toggle-tile').addClass('active');
	        $('.results-toggle-table').removeClass('active');
	        $('ul.results-list-return').addClass('format-tiles');
	});

    // Results Charts-Only

    $('.results-toggle-charts-selected').on('click', function(){
        if($('.results-toggle-charts-selected').hasClass('toggle-inactive')) {
            $('.results-toggle-charts-selected').removeClass('toggle-inactive');
        }
        else{
            $('.results-toggle-charts-selected').addClass('toggle-inactive');
        }
    });
    $('.results-toggle-charts-selected').on('click', function(){
        if($('.results-draw-charts-selected').hasClass('draw-collapse')) {
            $('.results-draw-charts-selected').removeClass('draw-collapse');
            $('a.collapse').addClass('active');
            $('a.expand').removeClass('active');
        }
        else{
            $('.results-draw-charts-selected').addClass('draw-collapse');
            $('a.collapse').removeClass('active');
            $('a.expand').addClass('active');
        }
    });

    $('.results-toggle-charts-population').on('click', function(){
        if($('.results-toggle-charts-population').hasClass('toggle-inactive')) {
            $('.results-toggle-charts-population').removeClass('toggle-inactive');
        }
        else{
            $('.results-toggle-charts-population').addClass('toggle-inactive');
        }
    });
    $('.results-toggle-charts-population').on('click', function(){
        if($('.results-draw-charts-population').hasClass('draw-collapse')) {
            $('.results-draw-charts-population').removeClass('draw-collapse');
            $('a.collapse').addClass('active');
            $('a.expand').removeClass('active');
        }
        else{
            $('.results-draw-charts-population').addClass('draw-collapse');
            $('a.collapse').removeClass('active');
            $('a.expand').addClass('active');
        }
    });

});