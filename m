Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A8725D8E1;
	Mon, 24 Mar 2025 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811543; cv=none; b=m8LZH1Ww7qCxboRFF0gM4u/Kz2rn20C2YcLI5JhWM6PKrlcdbIC+exF0OaXLHc/1hAYR1RaPtqbeBA/env6gARTUg04tXjc/vuIkwGcaK0oYi0mgXkBAewvmUsvDSYdNy1dDU42WiMl1EV+3GlkkIbsqlRvZGwCtQ42UANXWIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811543; c=relaxed/simple;
	bh=9rq2nJDVTpNtebFu0O0NSHqfeNp/dCiYbreZxeitcxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfadF9lcijCKSBu28d1tMmhXkd+EvZGvgjvyBOSn3BDkUpZCVpD9V+Mv6pUGA7Js0Fm59zqHJjArz+uD2vrjFAnpDEG8NYCXvLFNRFb5mAYhDpSjJ7LUukUi9L+d2fTZ2Nf+3ecg9Gz09wxSUWANLlvnyYs61cWDChckJNBDePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E15F1A2D;
	Mon, 24 Mar 2025 03:19:00 -0700 (PDT)
Received: from [10.1.38.52] (e132430.arm.com [10.1.38.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBB273F63F;
	Mon, 24 Mar 2025 03:18:51 -0700 (PDT)
Message-ID: <a5af352b-9f0d-4280-8d7b-e72597e6265d@arm.com>
Date: Mon, 24 Mar 2025 10:18:50 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Fix synth event printk format for str fields
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250318180939.227696-1-douglas.raillard@arm.com>
 <20250319211858.6d8166e3fb202e6e5a658557@kernel.org>
 <9d234136-05b9-46b6-849f-901df83bf54c@arm.com>
 <20250324144551.fc290f9cf9f57b3d2f205354@kernel.org>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250324144551.fc290f9cf9f57b3d2f205354@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24-03-2025 05:45, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Mar 2025 14:34:19 +0000
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>> Hi,
>>
>> On 19-03-2025 12:18, Masami Hiramatsu (Google) wrote:
>>> Hi,
>>>
>>> On Tue, 18 Mar 2025 18:09:38 +0000
>>> Douglas RAILLARD <douglas.raillard@arm.com> wrote:
>>>
>>>> From: Douglas Raillard <douglas.raillard@arm.com>
>>>>
>>>> The printk format for synth event uses "%.*s" to print string fields,
>>>> but then only passes the pointer part as var arg.
>>>>
>>>> Add the missing precision var arg.
>>>
>>> I'm not sure what you want to. Would you mean showing the string length too?
>>> But I think actual output(*) shows only string, right?
>>>
>>> (*) the output data which can be read from `trace` file.
>>
>> The "%.*s" printf/printk format specifier has 2 components:
>> 1. the "*" part that in printf documentation called the "precision"
>> 2. the "s" part that is called the "specifier"
>>
>> For a "s" specifier, the precision is interpreted as the number of chars to display from that string.
>> In any case, using "*" as precision means the value is passed dynamically, as a parameter to printf/printk,
>> before the actual char *. Both those args are consumed by printk to display "%.*s", the precision is never
>> displayed on its own.
>>
>> In the current state, synthetic event use "%.*s" for string fields, but then only a single `__get_str(field)`
>> is passed to printk, so it's missing the precision arg. Both trace-cmd and our parser report an error because of that.
>>
>> The alternative would be to just use "%s" instead of "%.*s", but I assume whoever wrote the code initially had a reason
>> to use the precision (maybe to print non-null-terminated strings ?), so I simply fixed the arguments.
> 
> Ah, got it. It seems that the first precision parameter is for limiting
> the length of the string according to the commit;
> 
> https://lore.kernel.org/all/b6bdb34e70d970e8026daa3503db6b8e5cdad524.1601848695.git.zanussi@kernel.org/T/#u
> 
> So, I think it should always print the STR_VAR_LEN_MAX value.

That makes sense. It's tempting to keep the actual length value though as native Rust strings are not null-terminated, so
it could make it nicer to emit events from Rust code. From a cursory look, the in-tree Rust code seems to be using both
&str and &CStr (the latter being null-terminated for FFI needs) so I'm not sure what's the plan around those
and what's the established convention if any.

> Steve, can you check it?
> 
> Thank you,
> 
>>
>>>
>>> Thank you,
>>>
>>>>
>>>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>>>> ---
>>>>    kernel/trace/trace_events_synth.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
>>>> index e3f7d09e5512..274b9b1d9f7d 100644
>>>> --- a/kernel/trace/trace_events_synth.c
>>>> +++ b/kernel/trace/trace_events_synth.c
>>>> @@ -620,7 +620,8 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
>>>>    		if (event->fields[i]->is_string &&
>>>>    		    event->fields[i]->is_dynamic)
>>>>    			pos += snprintf(buf + pos, LEN_OR_ZERO,
>>>> -				", __get_str(%s)", event->fields[i]->name);
>>>> +				", (int)__get_dynamic_array_len(%s), __get_str(%s)",
>>>> +				event->fields[i]->name, event->fields[i]->name);
>>>>    		else if (event->fields[i]->is_stack)
>>>>    			pos += snprintf(buf + pos, LEN_OR_ZERO,
>>>>    				", __get_stacktrace(%s)", event->fields[i]->name);
>>>> -- 
>>>> 2.43.0
>>>>
>>

Thank you,

Douglas

