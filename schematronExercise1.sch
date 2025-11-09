<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <h:pattern>
        <sch:rule context= "location [contains(.,'AU')]>
        <sch: report test ="@long lt 100">
            mao check
        </sch:>
            <sch:assert test ="number(@lat) lt
    </h:pattern>
    
</schema>