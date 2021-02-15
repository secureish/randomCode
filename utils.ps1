Function Invoke-SplitStringEvenly
{
<#
.SYNOPSIS
    Breaks down an inputted string of text into strings of a specified length, each of 
    which is pre-pended with the variable name that it will be adding to.

.DESCRIPTION
    Invoke-SplitString Evenly Breaks down an inputted string of text into strings of a 
    specified length. Each returned string is pre-pended with the variable name that it
    will be adding to.
    This can be used for example to take your long C2 output string and split it into 
    an appropriate format for your required behaviour.
    E.g. Input an encoded loader from Cobalt Strike / Covenant and have it outputted
    as a string builder for VBA which can be copied directly into a macro.

.PARAMETER TextIn
    The text string to be broken down

.PARAMETER StringLength
    The length that you would like each output string to be (defaults to 150).
    Note: This does not include the string precursor.

.PARAMETER StringPrecursor
    The startpoint of the string, language dependent (defaults to a VBA style string)

.EXAMPLE
     Invoke-SplitStringEvenly -Text "powershell -Sta -Nop -Window Hidden -EncodedCommand cwB2ACAAbwAg[...]"

.EXAMPLE
     Invoke-SplitStringEvenly -Text "powershell -Sta -Nop -Window Hidden -EncodedCommand cwB2ACAAbwAg[...]" 
        -StringLength 300

.EXAMPLE
     $myEncodedString | Invoke-SplitStringEvenly -StringLength 300

.INPUTS
    String

.OUTPUTS
    String

.NOTES
    Author:  Darren Fitzpatrick
    LinkedIn: https://www.linkedin.com/in/darrenfitz/
    Twitter: @mrdarrenm
#>
    Param(
        [Parameter(Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$TextIn,
 
        [ValidateNotNullOrEmpty()]
        [ValidateRange(1,1000)]
        [int]$StringLength = 150,

        [ValidateNotNullOrEmpty()]
        [string]$VarName = 'theString'
    )

    $i = 0
    While ($i -le ($TextIn.length-$StringLength)){
        if ($i -eq 0){
            write-host ($VarName + ' = "' + $TextIn.Substring($i,$StringLength) + '"')
        }else{
            write-host ($VarName + ' = ' + $VarName + ' + "' + $TextIn.Substring($i,$StringLength) + '"')
        }
        $i += $StringLength
    }
    write-host ($VarName + ' = ' + $VarName + ' + "' + $TextIn.Substring($i) + '"')
}