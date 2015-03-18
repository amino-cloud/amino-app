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

$(document).ready(function() {
	 
	//ACCORDION BUTTON ACTION (ON CLICK DO THE FOLLOWING)
	$('.accordionButton').click(function() {
	
		//var buttonsHeight = $($(this).parent).find('.accordionButton').length * $($(this).parent).find('.accordionButton').outerHeight();
		
		// Custom Height Calc for Accordion Content and Lists - Need to make dynamic
		
		$('.accordionContent.home').height($('.accordion-wrapper').height()-80);
		$('.accordionContent.features').height($('.accordion-wrapper').height()-40);
		$('.accordionContent.results').height($('.accordion-wrapper').height()-40);
		$('ul.entries.results').height($('.accordion-wrapper').height()-130);
		$('ul.entries.features').height($('.accordion-wrapper').height()-89);
		window.onresize = (function(){$('.accordionContent.home').height($('.accordion-wrapper').height()-80); $('.accordionContent.features').height($('.accordion-wrapper').height()-40); $('.accordionContent.results').height($('.accordion-wrapper').height()-40); $('ul.entries.results').height($('.accordion-wrapper').height()-130); $('ul.entries.features').height($('.accordion-wrapper').height()-89);})
		
		//REMOVE THE ON CLASS FROM ALL BUTTONS
		$('.accordionButton').removeClass('on');
		  
		//NO MATTER WHAT WE CLOSE ALL OPEN SLIDES
	 	$('.accordionContent').slideUp('normal');
   
		//IF THE NEXT SLIDE WASN'T OPEN THEN OPEN IT
		if($(this).next().is(':hidden') == true) {
			//ADD THE ON CLASS TO THE BUTTON
			$(this).addClass('on');
			  
			//OPEN THE SLIDE
			$(this).next().slideDown('normal');
		 } 
		  
	 });
	
	/*** REMOVE IF MOUSEOVER IS NOT REQUIRED ***/
	
	//ADDS THE .OVER CLASS FROM THE STYLESHEET ON MOUSEOVER 
	$('.accordionButton').mouseover(function() {
		$(this).addClass('over');
		
	//ON MOUSEOUT REMOVE THE OVER CLASS
	}).mouseout(function() {
		$(this).removeClass('over');										
	});
	
	/*** END REMOVE IF MOUSEOVER IS NOT REQUIRED ***/
	
	/********************************************************************************************************************
	CLOSES ALL S ON PAGE LOAD
	********************************************************************************************************************/
	
	$('.accordionContent').hide();
	
	$('.initial-child').click();

});
