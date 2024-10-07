Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D31D416B;
	Mon,  7 Oct 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311632; cv=none; b=t40HSmUmWpspPbOvW/NLT0Rk5mGMvsipLUabsTgy0fiaequ0JJG7WDPEOF7ShyShPg9IWGWP4D0QtKLa47paJhl1gO39s1TNo2jG7l907+uxWM9YyuU9aDdxANL+IkPRgTnqjpVkEy2w+54N7j91A0kBQSruMfrFf58pfmaXBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311632; c=relaxed/simple;
	bh=DSrgYkA2wpT+nsPc4XyV7x4scR6mMUpCmvNZ1QUo8rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4haf27I5q4IHxc5PPoPXIyceg/14hRfAAbaKynLRINvljKJt+eJOWowTSE4Wo3cCtkdvMAH914B4Ydpo9mK5tppWJS3OdKbvhlMwkt2pRAav1qTbv2/O8Diapgffjiakr7lyGjxIvBvL4b7wYQvvnVNU3eW4z+6ClOp3i5z5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 558ECDA7;
	Mon,  7 Oct 2024 07:34:19 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09B883F64C;
	Mon,  7 Oct 2024 07:33:48 -0700 (PDT)
Message-ID: <fdad61fc-c3cf-43b4-a049-b428ea89013f@arm.com>
Date: Mon, 7 Oct 2024 15:33:47 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Consider the NULL character when validating the
 event length
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dave.Martin@arm.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241007135126.873234-1-leo.yan@arm.com>
 <20241007102242.18d2636e@gandalf.local.home>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241007102242.18d2636e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/24 15:22, Steven Rostedt wrote:
> Warning: EXTERNAL SENDER, use caution when opening links or attachments.
> 
> 
> On Mon,  7 Oct 2024 14:51:26 +0100
> Leo Yan <leo.yan@arm.com> wrote:
> 
>> strlen() returns a string length excluding the null byte. This commit
>> adds 1 to account for the NULL terminating character when checking if an
>> event string is within the maximum length.
>>
>> Fixes: dec65d79fd26 ("tracing/probe: Check event name length correctly")
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   kernel/trace/trace_probe.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
>> index 39877c80d6cb..376ba56c3680 100644
>> --- a/kernel/trace/trace_probe.c
>> +++ b/kernel/trace/trace_probe.c
>> @@ -276,7 +276,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>>                }
>>                trace_probe_log_err(offset, NO_EVENT_NAME);
>>                return -EINVAL;
>> -     } else if (len > MAX_EVENT_NAME_LEN) {
>> +     } else if (len + 1 > MAX_EVENT_NAME_LEN) {
> 
> Usually, the check is:
> 
>          } else if (len >= MAX_EVENT_NAME_LEN) {
> 
> Which is a better way to check max length.

Will update. Thanks for suggestion.

Leo
