module namespace datim = "http://www.datim.org"; 


declare namespace dxf = "http://dhis2.org/schema/dxf/2.0";
declare namespace csd = "urn:ihe:iti:csd:2013";
import module namespace functx = "http://www.functx.com";

declare variable $datim:namespace_uuid := "10df44d2-55f4-11e4-af21-705681a860b7";



declare function datim:fixup_date($date) {
  replace(substring(string($date),1,19),'\+(\d{2})(\d{2})','+$1:$2')
};


declare  function datim:get_geocode($doc,$orgUnit) {
  let $ft := $orgUnit/dxf:featureType/text()
  let $coord := $orgUnit/dxf:coordinates/text()
  let $lat := substring-after(substring-before($coord,','),'[')
  let $long := substring-after(substring-before($coord,']'),',')
    
  return 
    if ($ft = 'Point' and $lat and $long) 
      then
      <csd:geocode>
	<csd:latitude>{$lat}</csd:latitude>
	<csd:longitude>{$long}</csd:longitude>
      </csd:geocode>
    else ()
};





