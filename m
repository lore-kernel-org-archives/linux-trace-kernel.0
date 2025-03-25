Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6E2AD13;
	Tue, 25 Mar 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918707; cv=none; b=Sdncs9AST0QXEaFxHmE+6dRsMTotQMzNbB5PkLP3Ahl5GBH28vj4lrApFcpF5igvucHzIPDVCo+rRVEvPBbbAFx1jxl8z051+ZViFTDvKFSX63gVJBN5urIDPOqhPZCMZDKVjTo99caYlvMupW9cAgdAs+nifyQUkmkjvkeAWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918707; c=relaxed/simple;
	bh=h97BkZ75Kmk+Ke3dQGE/18dFtpUap7mvflXQWlZJXr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qA5ysxsIwZAuThnrx6eCrEgKwbW7fjkkLtbaQjKzNVYz+V5hwRnfHX97xMN/hU0dqsWJhQzBb0RJrUM1bhQSIQuWgwVDxTnxDe+P9/BEx/T4E/M3+RLBYbkuC9msH/zzmhILvsCvyUFKIfdyEZzGYsLEsVjKih9ZAyKK8qnHT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86D31756;
	Tue, 25 Mar 2025 09:05:09 -0700 (PDT)
Received: from [10.57.85.102] (unknown [10.57.85.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4CA43F694;
	Tue, 25 Mar 2025 09:05:02 -0700 (PDT)
Message-ID: <9f030639-2ce2-4400-90e4-6c7dfbabf42c@arm.com>
Date: Tue, 25 Mar 2025 16:05:00 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tracing: Rename trace_synth() to synth_event_trace2()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250318180814.226644-1-douglas.raillard@arm.com>
 <20250318180814.226644-3-douglas.raillard@arm.com>
 <20250319223728.ca7a5ac6fa37798d17bd2e29@kernel.org>
 <3732e7f8-a452-4f65-8e8b-1575c01d33b9@arm.com>
 <20250324152945.e47bc6d1e491658cfc6924fe@kernel.org>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250324152945.e47bc6d1e491658cfc6924fe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24-03-2025 06:29, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Mar 2025 14:51:42 +0000
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>> On 19-03-2025 13:37, Masami Hiramatsu (Google) wrote:
>>> On Tue, 18 Mar 2025 18:08:12 +0000
>>> Douglas RAILLARD <douglas.raillard@arm.com> wrote:
>>>
>>>> From: Douglas Raillard <douglas.raillard@arm.com>
>>>>
>>>> Rename the frehsly exposed trace_synth() to synth_event_trace2() to
>>>> comply with the existing naming convention. Since synth_event_trace()
>>>> already exists (and operates on a "struct trace_event_file *"), use a
>>>> new name for it.
>>>>
>>>
>>> I don't like this '2' and similar version digit naming for the functions.
>>> Can you choose another better name?
>>
>> I was hoping for some suggestions as I don't like it either :)
>>
>> The natural prefix for functions operating on "struct synth_event *" would by "synth_event_*",
>> but most of the existing API already uses the "synth_event_*" prefix, and is using
>> "struct trace_event_file*".
>>
>>> BTW, can you also write a cover mail so that what is the goal of this
>>> series, background and results?
>>
>> Ok, I'll respin the series with a proper cover letter. The gist is I was following the doc [1] on how
>> to create a synthetic event, trying to apply that to a kernel module we have that needs to create new events.
>>
>> Unfortunately, it turned out that all the exposed APIs to emit the events (such as synth_event_trace()) require
>> getting a "struct trace_event_file*" before the call. This breaks when a user starts creating instances in tracefs,
>> as each instance will have its own "struct trace_event_file*".
> 
> Yeah, because those are mainly for the tests, and we are expecting that if
> any modules wants to emit its events, it will define new trace-events and
> use it instead of synthetic events. The synthetic events are for
> programming via tracefs, not reporting from the kernel modules.
> It is confusing if any synthetic events are reported without any origin of
> real trace event. (so, it is an intermadiate event type.) IOW, We expect
> that synthetic event is reported by other events via event trigger.
> The current APIs are just for testing.
> 
> Hmm, I should hide those by CONFIG_SYNTH_EVENT_TESTS.
> 
>> The way this is done for normal trace events is
>> that each instance registers a probe on the tracepoint with the struct trace_event_file* as the void *data pointer.
>> Then when the tracepoint is called, all the probes are called and the event data is copied in all instances in which
>> it was enabled.
>>
>> Although the synthetic event API does create that tracepoint and has an appropriate probe function, none of the exposed API
>> I could find make use of it. The exception is trace_events_hist.c had its own private version of it that actually calls all
>> the probes of the tracepoint "manually", so that the event is correctly emitted in all the instances it was enabled in. This
>> is the function touched by this patch.
> 
> No, please don't touch the synthetic events for reporting any events via
> kernel modules. Those should use normal trace events for avoiding the
> confusion.
> 
> Would you have any reason not to use normal trace events?

Yes, the dynamic API was exactly what I needed unfortunately. I'm porting the kernel module we have to Rust (using our own bindings as
we cannot mandate CONFIG_RUST=y). While I have some support for C code generation based on the Rust source, it is significantly more
convenient to simply use a dynamic API. In the current state of my code, defining an event is as simple as:

   let f = new_event! {
   	lisa__myevent2,
   	fields: {
   		field1: u8,
   		field3: &CStr,
   		field2: u64,
   	}
   }?;
   
   // Emit the event
   f(1, c"hello", 2);
   f(3, c"world", 4);

So it's as non-confusing can be: the event name is stated plainly and the field names and types are mentioned once, with no repetition.
The result can simply be called to emit the event, and when dropped, the event is unregistered.


On top of that in ways unrelated to Rust:
1. We have some really high traffic event (PELT-related) that include some data that is not always needed (e.g. taskgroup name).
    We currently regularly hit memory size limitation on our test device (pixel 6), and using trace-cmd record instead of
    trace-cmd start is not always a good idea as this will have an effect on scheduling, disturbing the very thing we are trying
    to observe. Having the dynamic API means we could simply omit the fields in the event that we don't care about in a specific
    experiment via dynamic configuration.

2. Some events may or may not be supported on the system based on some runtime condition. Currently, there is no great way for
    the module to feed back that info. No matter what, the event exists, even if the machinery that is supposed to emit it is
    disabled for whatever reason. If some user starts tracing the event "everything will work" and there will be no event in the
    trace. That may make the user think a condition did not trigger, whereas in fact the whole machinery was simply not operating.
    Being able to register or not the event dynamically solves that cleanly, as enabling the event will simply fail as it won't
    have been registered in the first place.

3. We will likely at some point relay events coming from some non-CPU part of the system into the ftrace buffer. If and when that
    happens, it would be ideal if that producer can simply declare the events it supports, and our module dynamically create the
    matching synthetic events. That would avoid any problem coming from mismatching source that would otherwise plague such setup.

So considering things seem to work overall with not much tuning needed, it would be sad to have to revert to TRACE_EVENT() macro
and end up having to do more work for a worse result. If that's the route you choose though, it may be nice to amend the
documentation to clearly state this API is testing-only and not supported in normal use case, as it currently reads:

   The trace event subsystem provides an in-kernel API allowing modules
   or other kernel code to generate user-defined 'synthetic' events at
   will, which can be used to either augment the existing trace stream
   and/or signal that a particular important state has occurred.


> 
> Thank you,
> 

Thank you,

Douglas
