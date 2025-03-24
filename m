Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00655291E;
	Mon, 24 Mar 2025 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797790; cv=none; b=dqViy40hnIbFyevpdxRNoKvJfbTsAjj0m9zrPr3F8l5YgeYd1RLDo8THB08aQY6fUFew73bHoSBRcabwqmdlSpilB1euhR9jmhCMGHj4G4UOtdhak+SJXOJvfpS8EPypNNcPqgif1dOEZE6l46UlLWYrB45R2t+ORQX/oz+pc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797790; c=relaxed/simple;
	bh=j0HuqL2AATJYFT1QnDwQ3aiw/QaT5J8zqE2ndjJtY08=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pq0kRxq7cRuWcG8qIgr/sP0vyqrO11pR87kIlmLtjG5KLEnqzNqpAGHeaPIua0V58TTJh4l13jvFPzw1WUHkwDmUSz1YPwlGGQq6qtfddSDXGepu21SElSDKVpdd2W5aylXKm2TWbmV38oLXPzQRZ2Hgxj4L1n/uGcEVt6BnLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD92DmTf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD92DmTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07146C4CEDD;
	Mon, 24 Mar 2025 06:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742797789;
	bh=j0HuqL2AATJYFT1QnDwQ3aiw/QaT5J8zqE2ndjJtY08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PD92DmTfeHHUViTaKsg4gXy2B3Opb/QErZHWTU6FbufFeVAF2JTM8z7E4PJ2qLAuy
	 uMl5IbDC232zBgxxlgWAvlg4NSr9MqJr3TTrKv1L8vU6oFqA+3pQHkbUDRMlo1eNju
	 GOdFLB3+sdEHfD7UvQkciz6J7FKrH7w9gMNHSeP6kT62h8t8RdCIUcIVKiLWRlWzYZ
	 qkyen+gniFLSvZpZIQcIwQNPfqme6/OpGiQkPFEUwwUphWfAyq/vrCtZsUnfOCHRvT
	 Ae+IA/J0cHvpkcyZCZLANrasx5cBGV7Fx++jnzEjDCdTNc8+ESVFgAtBUcR8yljyOl
	 LN38tv9nmR0Ww==
Date: Mon, 24 Mar 2025 15:29:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: rostedt@goodmis.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: Rename trace_synth() to
 synth_event_trace2()
Message-Id: <20250324152945.e47bc6d1e491658cfc6924fe@kernel.org>
In-Reply-To: <3732e7f8-a452-4f65-8e8b-1575c01d33b9@arm.com>
References: <20250318180814.226644-1-douglas.raillard@arm.com>
	<20250318180814.226644-3-douglas.raillard@arm.com>
	<20250319223728.ca7a5ac6fa37798d17bd2e29@kernel.org>
	<3732e7f8-a452-4f65-8e8b-1575c01d33b9@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 14:51:42 +0000
Douglas Raillard <douglas.raillard@arm.com> wrote:

> On 19-03-2025 13:37, Masami Hiramatsu (Google) wrote:
> > On Tue, 18 Mar 2025 18:08:12 +0000
> > Douglas RAILLARD <douglas.raillard@arm.com> wrote:
> > 
> >> From: Douglas Raillard <douglas.raillard@arm.com>
> >>
> >> Rename the frehsly exposed trace_synth() to synth_event_trace2() to
> >> comply with the existing naming convention. Since synth_event_trace()
> >> already exists (and operates on a "struct trace_event_file *"), use a
> >> new name for it.
> >>
> > 
> > I don't like this '2' and similar version digit naming for the functions.
> > Can you choose another better name?
> 
> I was hoping for some suggestions as I don't like it either :)
> 
> The natural prefix for functions operating on "struct synth_event *" would by "synth_event_*",
> but most of the existing API already uses the "synth_event_*" prefix, and is using
> "struct trace_event_file*".
> 
> > BTW, can you also write a cover mail so that what is the goal of this
> > series, background and results? 
> 
> Ok, I'll respin the series with a proper cover letter. The gist is I was following the doc [1] on how
> to create a synthetic event, trying to apply that to a kernel module we have that needs to create new events.
> 
> Unfortunately, it turned out that all the exposed APIs to emit the events (such as synth_event_trace()) require
> getting a "struct trace_event_file*" before the call. This breaks when a user starts creating instances in tracefs,
> as each instance will have its own "struct trace_event_file*".

Yeah, because those are mainly for the tests, and we are expecting that if
any modules wants to emit its events, it will define new trace-events and
use it instead of synthetic events. The synthetic events are for
programming via tracefs, not reporting from the kernel modules.
It is confusing if any synthetic events are reported without any origin of
real trace event. (so, it is an intermadiate event type.) IOW, We expect
that synthetic event is reported by other events via event trigger.
The current APIs are just for testing.

Hmm, I should hide those by CONFIG_SYNTH_EVENT_TESTS.

> The way this is done for normal trace events is
> that each instance registers a probe on the tracepoint with the struct trace_event_file* as the void *data pointer.
> Then when the tracepoint is called, all the probes are called and the event data is copied in all instances in which
> it was enabled.
> 
> Although the synthetic event API does create that tracepoint and has an appropriate probe function, none of the exposed API
> I could find make use of it. The exception is trace_events_hist.c had its own private version of it that actually calls all
> the probes of the tracepoint "manually", so that the event is correctly emitted in all the instances it was enabled in. This
> is the function touched by this patch.

No, please don't touch the synthetic events for reporting any events via
kernel modules. Those should use normal trace events for avoiding the
confusion.

Would you have any reason not to use normal trace events?

Thank you,

> 
> So that means that as it stands:
> 1. The exposed API is only really usable with the "NULL" struct trace_event_file*, which maps to the top-level one.
> 2. If a user creates an instance and enables the event in it using tracefs, the code that emits the event using the existing API
>     will completely ignore that and keep emitting the event in the top-level instance that it was wired to do.
> 
> Approximately nothing in the synth event API that takes a "struct trace_event_file*" will work properly with user-created instances.
> 
> [1] https://docs.kernel.org/trace/events.html#dyamically-creating-synthetic-event-definitions
> 
> > 
> > Thank you,
> > 
> >> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> >> ---
> >>   include/linux/trace_events.h      | 2 +-
> >>   kernel/trace/trace_events_hist.c  | 2 +-
> >>   kernel/trace/trace_events_synth.c | 4 ++--
> >>   3 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> >> index e069d84a73f0..753ce8aecfe4 100644
> >> --- a/include/linux/trace_events.h
> >> +++ b/include/linux/trace_events.h
> >> @@ -521,7 +521,7 @@ struct synth_event;
> >>   
> >>   extern struct synth_event *synth_event_find(const char *name);
> >>   
> >> -extern void trace_synth(struct synth_event *event, u64 *var_ref_vals,
> >> +extern void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
> >>   			       unsigned int *var_ref_idx);
> >>   
> >>   extern int synth_event_delete(const char *name);
> >> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> >> index 7067f6fedb1a..ee0fee123c91 100644
> >> --- a/kernel/trace/trace_events_hist.c
> >> +++ b/kernel/trace/trace_events_hist.c
> >> @@ -822,7 +822,7 @@ static void action_trace(struct hist_trigger_data *hist_data,
> >>   {
> >>   	struct synth_event *event = data->synth_event;
> >>   
> >> -	trace_synth(event, var_ref_vals, data->var_ref_idx);
> >> +	synth_event_trace2(event, var_ref_vals, data->var_ref_idx);
> >>   }
> >>   
> >>   struct hist_var_data {
> >> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> >> index 4a9a44d37ffc..8837aa258479 100644
> >> --- a/kernel/trace/trace_events_synth.c
> >> +++ b/kernel/trace/trace_events_synth.c
> >> @@ -850,7 +850,7 @@ EXPORT_SYMBOL_GPL(synth_event_find);
> >>   typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
> >>   				    unsigned int *var_ref_idx);
> >>   
> >> -void trace_synth(struct synth_event *event, u64 *var_ref_vals,
> >> +void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
> >>   			       unsigned int *var_ref_idx)
> >>   {
> >>   	struct tracepoint *tp = event->tp;
> >> @@ -873,7 +873,7 @@ void trace_synth(struct synth_event *event, u64 *var_ref_vals,
> >>   		}
> >>   	}
> >>   }
> >> -EXPORT_SYMBOL_GPL(trace_synth);
> >> +EXPORT_SYMBOL_GPL(synth_event_trace2);
> >>   
> >>   static struct trace_event_fields synth_event_fields_array[] = {
> >>   	{ .type = TRACE_FUNCTION_TYPE,
> >> -- 
> >> 2.43.0
> >>
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
