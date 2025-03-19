Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3081C5D7F;
	Wed, 19 Mar 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394865; cv=none; b=hkcdmUbppZggdduqutdT7IJxk+ePhtb3RWeTn+ybgEQfb+avI9HTjEFtfahs4Dzlzwi4//hbbxbJt76noppsIZlH4cffPzGRKvXGveKshe8nqBaPBCMNUUzjHxbL3SgVpeLUSaW8sZFhAGStqWkeJEMm7FaEQwBaJCZ2otyuJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394865; c=relaxed/simple;
	bh=Ah6xE4sMo0jg6QLvbUtlQ+wvR74mqGtmn7rX7SqSee4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJfJwZ4dDpbWNckz0BzMwvS7Wca9j3XjrOaBSjdvO0rbn/WiV10PgrDP4F8tEBfPU0VYwCbqkDW2K6NrxVl1wWk2pZT9Bh34BV2/xR7YS2d/lmC++Y99XoO2vzNVfJllqMDa0YcwXgnfm4DppOX+vvotzYgoGcviYYwxg0MeC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74C9AFEC;
	Wed, 19 Mar 2025 07:34:31 -0700 (PDT)
Received: from [10.1.39.66] (e132430.arm.com [10.1.39.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D66B3F673;
	Wed, 19 Mar 2025 07:34:21 -0700 (PDT)
Message-ID: <9d234136-05b9-46b6-849f-901df83bf54c@arm.com>
Date: Wed, 19 Mar 2025 14:34:19 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Fix synth event printk format for str fields
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250318180939.227696-1-douglas.raillard@arm.com>
 <20250319211858.6d8166e3fb202e6e5a658557@kernel.org>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250319211858.6d8166e3fb202e6e5a658557@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 19-03-2025 12:18, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> On Tue, 18 Mar 2025 18:09:38 +0000
> Douglas RAILLARD <douglas.raillard@arm.com> wrote:
> 
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> The printk format for synth event uses "%.*s" to print string fields,
>> but then only passes the pointer part as var arg.
>>
>> Add the missing precision var arg.
> 
> I'm not sure what you want to. Would you mean showing the string length too?
> But I think actual output(*) shows only string, right?
> 
> (*) the output data which can be read from `trace` file.

The "%.*s" printf/printk format specifier has 2 components:
1. the "*" part that in printf documentation called the "precision"
2. the "s" part that is called the "specifier"

For a "s" specifier, the precision is interpreted as the number of chars to display from that string.
In any case, using "*" as precision means the value is passed dynamically, as a parameter to printf/printk,
before the actual char *. Both those args are consumed by printk to display "%.*s", the precision is never
displayed on its own.

In the current state, synthetic event use "%.*s" for string fields, but then only a single `__get_str(field)`
is passed to printk, so it's missing the precision arg. Both trace-cmd and our parser report an error because of that.

The alternative would be to just use "%s" instead of "%.*s", but I assume whoever wrote the code initially had a reason
to use the precision (maybe to print non-null-terminated strings ?), so I simply fixed the arguments.

> 
> Thank you,
> 
>>
>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>> ---
>>   kernel/trace/trace_events_synth.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
>> index e3f7d09e5512..274b9b1d9f7d 100644
>> --- a/kernel/trace/trace_events_synth.c
>> +++ b/kernel/trace/trace_events_synth.c
>> @@ -620,7 +620,8 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
>>   		if (event->fields[i]->is_string &&
>>   		    event->fields[i]->is_dynamic)
>>   			pos += snprintf(buf + pos, LEN_OR_ZERO,
>> -				", __get_str(%s)", event->fields[i]->name);
>> +				", (int)__get_dynamic_array_len(%s), __get_str(%s)",
>> +				event->fields[i]->name, event->fields[i]->name);
>>   		else if (event->fields[i]->is_stack)
>>   			pos += snprintf(buf + pos, LEN_OR_ZERO,
>>   				", __get_stacktrace(%s)", event->fields[i]->name);
>> -- 
>> 2.43.0
>>

