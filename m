Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493C15B998;
	Fri, 29 May 2026 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023589; cv=none; b=msMt4XlTLNpilyVWphb/ZNYFGBmogvr8vlWy3ltxSym8z3NBnKg+5wyPHFK8J5werVoC/BHABknpke8daSs/LDHZxw+M7HQC50TtTWkgdZHv5vW+yVkoR0aPJjJb1l3L+7mW1VQ+5NrBqnKmzzXLXO5D3N1g4/QbwerUhcCNVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023589; c=relaxed/simple;
	bh=yUPSunIXsjbEc2oCxXXdUplhPRkr2nsnsRUWuu4uCVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iit2T9vw9kHQ7hXe5d2hGPB1/wVSmGl88ZDMTVkWJMJIUQBozVkmywUSpwCmkCIbJfvAFIQY4VK/N+JReV+JPPDQPkfyH6TnD0qvFF3mvVSiNhu7OV+h9d6xoLYfIhjw8hLaCHJCPzFr8NQFqjsKTxrkvNn0ZPpkB7fU4Q0rh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HyZxp87B; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HyZxp87B"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780023583; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H3e9XryH1b3tknit2Rn4BqVmvGy1OpRYAXsLWC+x/cY=;
	b=HyZxp87BnMwof5M+Z9S+av2yRRbXZUNiEY0puElXdnySQS9TqIwzoSz5UGiITFZV28NZcbMZeOARh8e/d7Afg+bypvk/KaFzPQyjIMG5Qii/80bwylbAu7pa1QFy1dtiBLlXtVm91cUgZAR/EKMfzOdlK1DOViAvRWD5yPqNY50=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X3o56SN_1780023575;
Received: from 30.222.33.224(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0X3o56SN_1780023575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 May 2026 10:59:43 +0800
Message-ID: <bcb52d91-0440-4e73-86af-997e8b723711@linux.alibaba.com>
Date: Fri, 29 May 2026 10:59:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] selftests/ftrace: Fix trace_marker_raw test on 64K
 page kernels
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
 <20260528022417.1813745-1-dtcccc@linux.alibaba.com>
 <20260528091348.71ae3aa3@fedora>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20260528091348.71ae3aa3@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/28/26 9:13 PM, Steven Rostedt wrote:
> On Thu, 28 May 2026 10:24:17 +0800
> Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
> 
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
>> index 8e905d4fe6dd..f68f1901f65f 100644
>> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
>> @@ -43,8 +43,11 @@ write_buffer() {
>>   	id=$1
>>   	size=$2
>>   
>> -	# write the string into the raw marker
>> -	make_str $id $size > trace_marker_raw
>> +	# Pipe through dd to ensure a single atomic write() syscall
>> +	# on architectures with 64K pages, where shell's printf builtin
>> +	# uses stdio buffering which may split the output into multiple
>> +	# writes.
>> +	make_str $id $size | dd of=trace_marker_raw bs=`expr $size + 4` iflag=fullblock
> 
> I was looking at this more, and I'm not comfortable with the hard coded
> 4 above. I rather use the length of the string. Something like:
> 
> 	str=`make_str $id $size`
> 	len=${#str}
> 	echo "$str" | dd of=trace_marker_raw bs=$len iflag=fullblock
> 
> -- Steve
> 

Capturing make_str output into a shell variable doesn't work because make_str 
outputs raw binary that may contain NUL bytes, and shell command substitution 
silently strips them.

However, the val variable inside make_str doesn't hold actual NUL bytes — it 
holds the text of escape sequences (e.g., the literal characters 
\003\000\000\000). The binary conversion only happens at the final printf 
"${val}${data}".

We can take advantage of this by having make_str return the escape-sequence text 
instead of binary, and letting write_buffer handle the conversion:

   make_str() {
         ...
         printf '%s' "${val}${data}"
   }

   write_buffer() {
         id=$1
         size=$2

         str=`make_str $id $size`
         len=$(printf "$str" | wc -c)
         printf "$str" | dd of=trace_marker_raw bs=$len iflag=fullblock
   }

This way str holds only printable escape-sequence text (no NUL), printf "$str" 
converts it to real binary through the pipe, and wc -c measures the true binary 
length.

>>   }
>>   
>>   

