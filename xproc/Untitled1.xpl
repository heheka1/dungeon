<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
    version="3.0" name="my-pipeline">
    
    <p:input port="source" primary="true">
        <p:inline>
            <doc/>
        </p:inline>
    </p:input>
    
    <p:input port="images" sequence="true">
        <p:inline>
            <image src="image-1.png"/>
        </p:inline>
        <p:inline>
            <image src="image-2.png"/>
        </p:inline>
    </p:input>
    
    <p:output port="result"/>
    
    <p:insert match="/doc" position="last-child">
        <p:with-input port="insertion" 
            pipe="images@my-pipeline"/>
    </p:insert>
    
</p:declare-step>