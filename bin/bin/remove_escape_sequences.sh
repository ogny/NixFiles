# Copyright SwaJime's Cove, 2009; all rights reserved
#
# Copyright SwaJime's Cove, 2009; all rights reserved
#
# Based on data obtained from http://www.gnu.org/software/teseq/manual/html_node/Escape-Sequence-Recognition.html
#
#!/bin/bash
                                # A control sequence starts with
CSI='\x1b\['			# the two-character csi escape sequence ‘Esc [’, followed by
Rp='[0-9:;<=>?]'		# an optional sequence of parameter bytes in the range x30–x3F,
Ri='[- !\"#$%&'\''()*+,./]'	# an optional sequence of intermediate bytes in the range x20–x2F,
Rf='[]@A-Z[\\^_`a-z{|}~]'	# and a final byte in the range x40–x7e.
				# The set of standard control sequence functions are defined in Ecma-48 / ISO/IEC 6429. 
sed -e 's/'"$CSI$Rp"'*'"$Ri"'*'"$Rf"'//g'
