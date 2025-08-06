Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66735155322;
	Wed,  6 Aug 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497278; cv=none; b=TsciZcQ05fjRCjeYaPNexDjOmtXIStDU6BxTHDAdXTo3DRunUHFv012aNArqpNS7MBQB2rTiS5Lf7sKDL9B7xMt0zrhyjhFoG6fczIu66tLCl97QcYDM54IIBvZPY5yOPgjIk4KbXm0Tpx5HFbvBFCV2u4pWzC/RvglAaEIsiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497278; c=relaxed/simple;
	bh=xNPe3PPplwaaGLX/120BS7jrhEUfIWtmdutVxXCBYCc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kIuhiXaZOMAIuqDl41n6nrbNEqxUBignTBYzC6NvLEPC0kFwqq03V7yIjWXNO0Q1bYRBIBYkniuSXgQ9Yizl6fIYTROQHfXbuXEKVzSDm2VXRqxiI+jvKqqIRpksyjnYT6UxkVj08OnjMYGRj+8R8V9BCLROAR6646KMvZwIXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CB36176C;
	Wed,  6 Aug 2025 09:21:06 -0700 (PDT)
Received: from [192.168.1.127] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EB9E3F738;
	Wed,  6 Aug 2025 09:21:11 -0700 (PDT)
Message-ID: <8a1d7510-0cc3-4b87-a862-2b34f3c9f03f@arm.com>
Date: Wed, 6 Aug 2025 17:21:10 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH 7/7] tracing: Add syscall_user_buf_size to limit amount
 written
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
References: <20250805192646.328291790@kernel.org>
 <20250805193235.747004484@kernel.org>
 <91cd9924-aaff-404a-8be7-79a6c7452a89@arm.com>
 <20250806084347.79360a5e@batman.local.home>
Content-Language: en-US
In-Reply-To: <20250806084347.79360a5e@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06-08-2025 13:43, Steven Rostedt wrote:
> On Wed, 6 Aug 2025 11:50:06 +0100
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>> On 05-08-2025 20:26, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> When a system call that reads user space addresses copy it to the ring
>>> buffer, it can copy up to 511 bytes of data. This can waste precious ring
>>> buffer space if the user isn't interested in the output. Add a new file
>>> "syscall_user_buf_size" that gets initialized to a new config
>>> CONFIG_SYSCALL_BUF_SIZE_DEFAULT that defaults to 128.
>>
>> Have you considered dynamically removing some event fields ? We routinely hit
>> the same problem with some of our events that have rarely-used large fields.
> 
> We do that already with eprobes. Note, syscall events are pseudo events
> hooked on the raw_syscall events. Thus modifying what is displayed is
> trivial as it's done manually anyway. For normal events, it's all in
> the TRACE_EVENT() macro which defines the fields at boot. Trying to
> modify it later is very difficult.

I was thinking at a filtering step between assigning to an event struct
with TP_fast_assign and actually writing it to the buffer. An array of (offset, size)
would allow selecting which field is to be copied to the buffer, the rest would
be left out (a bit like in some parts of the synthetic event API). The format
file would be impacted to remove some fields, but hopefully not too many other
corners of ftrace.

The advantage of that over eprobe would be:
1. full support of all field types
2. probably lower overhead than the fetch_op interpreter, but maybe not by much.
3. less moving pieces for the user (e.g. no need to have BTF for by-name field access,
    no new event name to come up with etc.)

> 
>>
>> If we could have a "fields" file in /sys/kernel/tracing/events/*/*/fields
>> that allowed selecting what field is needed that would be amazing. I had plans
>> to build something like that in our kernel module based on the synthetic events API,
>> but did not proceed as that API is not exported in a useful way.
> 
> Take a look at eprobes. You can make a new event based from an existing
> event (including other dynamic events and syscalls).
> I finally got around to adding documentation about it:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/trace/eprobetrace.rst
> 

That's very interesting, I did not realize that you could access the actual event fields
and not just the tracepoint args. With your recent BTF patch, there is now little limits
on how deep you can drill down in the structs which is great (and actually more powerful
than the original event itself).

Before userspace tooling could make use of that as a field filtering system, a few friction
points would need to be addressed:

1. Getting the field list programmatically is currently not really possible as dealing with
    the format file is very tricky. We could just pass on the user-requested field
    to the kernel but that would prevent userspace validation with usable error reporting
    (the 6.15 kernel I tried it on gave me EINVAL and not even a dmesg error when trying to use
    a field that does not exist)

2. The type of the field is not inferred, e.g. an explicit ":string" is needed here:
      
      e:my/sched_switch sched.sched_switch prev_comm=$prev_comm:string
    
    The only place a tool can get this info from is the format file, which means you have to
    parse it and apply some conversions (e.g. "__data_loc char[]" becomes "string").

3. Only a restricted subset of field types is supported, e.g. no cpumask, buffers other
    than strings etc. In practice, this means the userspace tooling will have to either:
      * pass on the restriction to the users (can easily lead to a terrible UX by misleading
        the user to think filtering is generally available when in fact it's not).
      * or only treat that as a hint and use the unfiltered original event if the user asks
        for a field with an unsupported type.

On the bright side, creating a new event like "e:my/sched_switch" gives the event name "sched_switch" but
trace-cmd start -e my/sched_switch will only enable the new event which is exactly what we need.
This way, the trace can look like a normal one except less fields, so downstream data processing
is not impacted and only the data-gathering step needs to know about it.

Depending on whether we want/can deal with those friction point, it could either become a high-level
layer usable like the base event system with extra low-level abilities, or stay as a tool only suitable for
hand-crafted use cases where the user has deeper knowledge of layout on all involved kernels.


On a related note, if we wanted to make something that allowed reducing the amount of stored data and
that could deeply integrate with the userspace tooling in charge of collecting the data to run a user-defined query,
the best bet is to target SQL-like systems. That family is very established and virtually all trace-processing system
will use it as first stage (e.g. Perfetto with sqlite, or LISA with Polars dataframes).
In those systems, some important information can typically be extracted from the user query [1]:

1. Projection: which tables and columns the query needs. In ftrace, that's the list of events and what fields
    are needed. Other events/fields can be discarded as they won't be read by the query.

2. Row limit: how many rows the query will read (not always available obviously). In ftrace, that would allow
    automatically stopping the tracing when the event count reaches a limit, or set the buffer size based on
    the event size for a flight-recorder approach. Additional event occurrences would be discarded by the query
    anyway.

3. Predicate filtering: If the query contains a filter to only select rows with a column equal to a specific
    value. Other rows don't need to be collected as the query will discard them anyway.

Currently:
1. is partially implemented as you can select specific events, but not what field you want.
2. is partially implemented (buffer size, but AFAIK there is no way of telling ftrace to stop tracing after N events).
3. is fully implemented with /sys/kernel/debug/tracing/events/*/*/filter

If all those are implemented, ftrace would be able to make use of the most important implicit info available
in the user query to limit the collected data size, without the user having to tune anything manually
and without turning the kernel into a full-blown SQL interpreter.

[1] In the Polars dataframe library, data sources such as a parquet file served over HTTP are called "scans".
     When Polars executes an expression, it will get the data from the scans the expression refers to,
     and will pass the 3 pieces of info to the scan implementation so that processed data size can be minimized
     as early as possible in the pipeline. This is referred to as "projection pushdown", "slice pushdown" and "predicate pushdown":
     https://docs.pola.rs/user-guide/lazy/optimizations/
     If some filtering condition is too complex to express in the limited scan predicate language, filtering will happen
     later in the pipeline. If the scan does not have a smart way to apply the filter (e.g. projection pushdown for a row-oriented file format
     will probably not bring massive speed improvements) then more data than necessary will be fetched and filtering will happen
     later in the pipeline.

> -- Steve

--
Douglas

