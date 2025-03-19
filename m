Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA53A16BE3A;
	Wed, 19 Mar 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395908; cv=none; b=uQnPMOLkeDeuOpImzPjdBgMwk2N7t+cLXbCQXITS0JjUTrxGgaj1q51J6n8R2fBEQ5Z1JRGc+xr3bElwTnYA9FRDPlpAMf3jAzcvcmIVnFsdxGcyhQv1CsDv9siyDBEEBwCjJ5Zo+49UJ4R8rFL+MgQW38SFG8y5ZroAptWKFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395908; c=relaxed/simple;
	bh=8fnh+mxNSdWC4xYUebdlycVe1MnQjASavmalZ/YWqzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRGUOC/c4QcM8oPCPcZPmWu5LsquEojaBmG3EANDehJxsfUT7DkQnQiKTBZGbOAk9LL4tUs8+kCk7tSzi3cti2SppKBptYlvltjWyxQn8sozpL9PrUc6UEdrC/M01tjf3rV+wolaq77CDw4/u9PtFlI+8nFG9f3j3BUaVW0b/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 360E8106F;
	Wed, 19 Mar 2025 07:51:54 -0700 (PDT)
Received: from [10.1.39.66] (e132430.arm.com [10.1.39.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29473F694;
	Wed, 19 Mar 2025 07:51:44 -0700 (PDT)
Message-ID: <3732e7f8-a452-4f65-8e8b-1575c01d33b9@arm.com>
Date: Wed, 19 Mar 2025 14:51:42 +0000
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
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250319223728.ca7a5ac6fa37798d17bd2e29@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19-03-2025 13:37, Masami Hiramatsu (Google) wrote:
> On Tue, 18 Mar 2025 18:08:12 +0000
> Douglas RAILLARD <douglas.raillard@arm.com> wrote:
> 
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> Rename the frehsly exposed trace_synth() to synth_event_trace2() to
>> comply with the existing naming convention. Since synth_event_trace()
>> already exists (and operates on a "struct trace_event_file *"), use a
>> new name for it.
>>
> 
> I don't like this '2' and similar version digit naming for the functions.
> Can you choose another better name?

I was hoping for some suggestions as I don't like it either :)

The natural prefix for functions operating on "struct synth_event *" would by "synth_event_*",
but most of the existing API already uses the "synth_event_*" prefix, and is using
"struct trace_event_file*".

> BTW, can you also write a cover mail so that what is the goal of this
> series, background and results? 

Ok, I'll respin the series with a proper cover letter. The gist is I was following the doc [1] on how
to create a synthetic event, trying to apply that to a kernel module we have that needs to create new events.

Unfortunately, it turned out that all the exposed APIs to emit the events (such as synth_event_trace()) require
getting a "struct trace_event_file*" before the call. This breaks when a user starts creating instances in tracefs,
as each instance will have its own "struct trace_event_file*". The way this is done for normal trace events is
that each instance registers a probe on the tracepoint with the struct trace_event_file* as the void *data pointer.
Then when the tracepoint is called, all the probes are called and the event data is copied in all instances in which
it was enabled.

Although the synthetic event API does create that tracepoint and has an appropriate probe function, none of the exposed API
I could find make use of it. The exception is trace_events_hist.c had its own private version of it that actually calls all
the probes of the tracepoint "manually", so that the event is correctly emitted in all the instances it was enabled in. This
is the function touched by this patch.

So that means that as it stands:
1. The exposed API is only really usable with the "NULL" struct trace_event_file*, which maps to the top-level one.
2. If a user creates an instance and enables the event in it using tracefs, the code that emits the event using the existing API
    will completely ignore that and keep emitting the event in the top-level instance that it was wired to do.

Approximately nothing in the synth event API that takes a "struct trace_event_file*" will work properly with user-created instances.

[1] https://docs.kernel.org/trace/events.html#dyamically-creating-synthetic-event-definitions

> 
> Thank you,
> 
>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>> ---
>>   include/linux/trace_events.h      | 2 +-
>>   kernel/trace/trace_events_hist.c  | 2 +-
>>   kernel/trace/trace_events_synth.c | 4 ++--
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
>> index e069d84a73f0..753ce8aecfe4 100644
>> --- a/include/linux/trace_events.h
>> +++ b/include/linux/trace_events.h
>> @@ -521,7 +521,7 @@ struct synth_event;
>>   
>>   extern struct synth_event *synth_event_find(const char *name);
>>   
>> -extern void trace_synth(struct synth_event *event, u64 *var_ref_vals,
>> +extern void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
>>   			       unsigned int *var_ref_idx);
>>   
>>   extern int synth_event_delete(const char *name);
>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
>> index 7067f6fedb1a..ee0fee123c91 100644
>> --- a/kernel/trace/trace_events_hist.c
>> +++ b/kernel/trace/trace_events_hist.c
>> @@ -822,7 +822,7 @@ static void action_trace(struct hist_trigger_data *hist_data,
>>   {
>>   	struct synth_event *event = data->synth_event;
>>   
>> -	trace_synth(event, var_ref_vals, data->var_ref_idx);
>> +	synth_event_trace2(event, var_ref_vals, data->var_ref_idx);
>>   }
>>   
>>   struct hist_var_data {
>> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
>> index 4a9a44d37ffc..8837aa258479 100644
>> --- a/kernel/trace/trace_events_synth.c
>> +++ b/kernel/trace/trace_events_synth.c
>> @@ -850,7 +850,7 @@ EXPORT_SYMBOL_GPL(synth_event_find);
>>   typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
>>   				    unsigned int *var_ref_idx);
>>   
>> -void trace_synth(struct synth_event *event, u64 *var_ref_vals,
>> +void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
>>   			       unsigned int *var_ref_idx)
>>   {
>>   	struct tracepoint *tp = event->tp;
>> @@ -873,7 +873,7 @@ void trace_synth(struct synth_event *event, u64 *var_ref_vals,
>>   		}
>>   	}
>>   }
>> -EXPORT_SYMBOL_GPL(trace_synth);
>> +EXPORT_SYMBOL_GPL(synth_event_trace2);
>>   
>>   static struct trace_event_fields synth_event_fields_array[] = {
>>   	{ .type = TRACE_FUNCTION_TYPE,
>> -- 
>> 2.43.0
>>
> 
> 

