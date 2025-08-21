Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489402727E7;
	Thu, 21 Aug 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764049; cv=none; b=BCzcj4cic+eEQQq3ADWQJx96qG8sCgNYDHOfhsnXH4Q9j3pz+sJZfW/+YQT3ZXypa7RFV+ii/IoQBWtw6XbQuYaqMyXXfvHObEBu06Tzetz8DttvNn/3JfWJ+blC3Lh9mb/9HxYLuayTqrgELIRPkGoyIejZfvoOZVEc/VKB7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764049; c=relaxed/simple;
	bh=4DkZhm+ttNFAoF/CFkhooXB7A4sxmjtdUUXaeN4G7EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A79cIqM5n/yGVV4wJnv0UF/A4XFxrAFEpClC8fN1DButJ5E5cOn3+K/IF/sDidAAnpeOsIPkuYZXfnqf7JQnvWNe7t7Qa2vMgbWvthFfUwrBOEr1dnIoi+Uw0XPfFW72HqckMPdKDn6/TyqxpilGlYtnzURax3oNx4DYen3VT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmALpqai; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dXvHp8xc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmALpqai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dXvHp8xc"
Date: Thu, 21 Aug 2025 10:14:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755764046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GIC4ZUCvr94Zkuj3kqHlKBZXwaMTSK6R/2NbQXv5yo=;
	b=qmALpqai0wHoCYwbwLz3SCD2uda0CsodGTMl03Of5yPGjMHJ28EiAHyhNmW06G5oHR0CLC
	wlFlvkcUb4vq58d4wL6S4o4SKqI9qnhqo900wP2mWVT+a2bUiNtLIis2seMbdGshCbW/7Y
	9gQo9k8kIQKg1jFJ/N3zOz3p6klRdrF2N5dxPDc1BkKWw+cNlquhD7FgXNHtNkewIpuj66
	hGovjF/GYrEcDlqO54f3A4DDMEVtR3CQbUSRTJ2YPQ6ezhu/0U7wSKQFosGK2V8J2xg4Vl
	yVuA8Z1cnPCEr1t3kf8eEvMq7GPZHcwei3NLiUfmjVWZUdgSLkUQqUZ6ATg2Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755764046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GIC4ZUCvr94Zkuj3kqHlKBZXwaMTSK6R/2NbQXv5yo=;
	b=dXvHp8xcckHKGBWgHl/7MdL1Nr+lrBExAxp1sjNQBXjwo5+dJVz923TeX8O+ehZRzxeoZg
	FsS8U0INCJcBScBw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 01/17] rv: Refactor da_monitor to minimise macros
Message-ID: <20250821081405.RQhrWVKp@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-2-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:07:53PM +0200, Gabriele Monaco wrote:
> The da_monitor helper functions are generated from macros of the type:
> 
> DECLARE_DA_FUNCTION(name, type) \
> static void da_func_x_##name(type arg) {} \
> static void da_func_y_##name(type arg) {} \
> 
> This is good to minimise code duplication but the long macros made of
> skipped end of lines is rather hard to parse. Since functions are
> static, the advantage of naming them differently for each monitor is
> minimal.
> 
> Refactor the da_monitor.h file to minimise macros, instead of declaring
> functions from macros, we simply declare them with the same name for all
> monitors (e.g. da_func_x) and for any remaining reference to the monitor
> name (e.g. tracepoints, enums, global variables) we use the CONCATENATE
> macro.
> In this way the file is much easier to maintain while keeping the same
> generality.
> Functions depending on the monitor types are now conditionally compiled
> according to the value of RV_MON_TYPE, which must be defined in the
> monitor source.
> The monitor type can be specified as in the original implementation,
> although it's best to keep the default implementation (unsigned char) as
> not all parts of code support larger data types, and likely there's no
> need.
> 
> We keep the empty macro definitions to ease review of this change with
> diff tools, but cleanup is required.
> 
> Also adapt existing monitors to keep the build working.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Yes please! The macros are not pleasant to work with.

> ---
>  include/linux/rv.h                     |   4 +
>  include/rv/automata.h                  | 132 ++--
>  include/rv/da_monitor.h                | 912 ++++++++++++-------------
>  kernel/trace/rv/monitors/nrp/nrp.c     |  22 +-
>  kernel/trace/rv/monitors/nrp/nrp.h     |   2 +
>  kernel/trace/rv/monitors/opid/opid.c   |  32 +-
>  kernel/trace/rv/monitors/opid/opid.h   |   2 +
>  kernel/trace/rv/monitors/sco/sco.c     |  18 +-
>  kernel/trace/rv/monitors/sco/sco.h     |   2 +
>  kernel/trace/rv/monitors/scpd/scpd.c   |  20 +-
>  kernel/trace/rv/monitors/scpd/scpd.h   |   2 +
>  kernel/trace/rv/monitors/snep/snep.c   |  20 +-
>  kernel/trace/rv/monitors/snep/snep.h   |   2 +
>  kernel/trace/rv/monitors/snroc/snroc.c |  18 +-
>  kernel/trace/rv/monitors/snroc/snroc.h |   2 +
>  kernel/trace/rv/monitors/sssw/sssw.c   |  30 +-
>  kernel/trace/rv/monitors/sssw/sssw.h   |   2 +
>  kernel/trace/rv/monitors/sts/sts.c     |  26 +-
>  kernel/trace/rv/monitors/sts/sts.h     |   2 +
>  kernel/trace/rv/monitors/wip/wip.c     |  18 +-
>  kernel/trace/rv/monitors/wip/wip.h     |   2 +
>  kernel/trace/rv/monitors/wwnr/wwnr.c   |  20 +-
>  kernel/trace/rv/monitors/wwnr/wwnr.h   |   2 +
>  23 files changed, 650 insertions(+), 642 deletions(-)
> 
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..3134681553b4 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -13,6 +13,10 @@
>  #define MAX_DA_NAME_LEN			32
>  #define MAX_DA_RETRY_RACING_EVENTS	3
>  
> +#define RV_MON_GLOBAL   0
> +#define RV_MON_PER_CPU  1
> +#define RV_MON_PER_TASK 2
> +
>  #ifdef CONFIG_RV
>  #include <linux/bitops.h>
>  #include <linux/types.h>
> diff --git a/include/rv/automata.h b/include/rv/automata.h
> index eb9e636809a0..5b5d2e94c034 100644
> --- a/include/rv/automata.h
> +++ b/include/rv/automata.h
> @@ -6,6 +6,20 @@
>   * models in C generated by the dot2k tool.
>   */
>  
> +#ifndef MONITOR_NAME
> +#error "MONITOR_NAME macro is not defined. Did you include $(MODEL_NAME).h generated by rvgen?"
> +#endif
> +
> +#ifndef type
> +#define type unsigned char
> +#endif
> +
> +#define RV_AUTOMATON_NAME CONCATENATE(automaton_, MONITOR_NAME)
> +#define EVENT_MAX CONCATENATE(event_max_, MONITOR_NAME)
> +#define STATE_MAX CONCATENATE(state_max_, MONITOR_NAME)
> +#define events CONCATENATE(events_, MONITOR_NAME)
> +#define states CONCATENATE(states_, MONITOR_NAME)

I think these macros make it harder to read the code. E.g. it is not
obvious what is "events" in "enum events event".

How about renaming these to be the same for all monitors, and get rid of
these 4 macros?

Something like

	enum states_wip -> enum da_states
	state_max_wip   -> da_state_max
	etc

Just my preference, of course. You probably have your reasons for doing it
this way?

> +/*
> + * model_get_state_name - return the (string) name of the given state
> + */
> +static char *model_get_state_name(enum states state)
> +{
> +	if ((state < 0) || (state >= STATE_MAX))
> +		return "INVALID";

Just notice that this probably should be
	if (BUG_ON((state < 0) || (state >= STATE_MAX)))

You shouldn't do it in this patch of course. I just want to note it down.

> index 17fa4f6e5ea6..bc02334aa8be 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -13,97 +13,102 @@
>  
>  #include <rv/automata.h>
>  #include <linux/rv.h>
> +#include <linux/stringify.h>
>  #include <linux/bug.h>
>  #include <linux/sched.h>
>  
> +#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> +#define RV_DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)

These macros as well. Should we rename the monitors to be the same and get
rid of the macros?

I see you took this RV_MONITOR_NAME idea from LTL. But I'm starting to
wonder if this is really a good idea.

What do you think?

> +#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU
> +
> +static inline bool
> +da_event(struct da_monitor *da_mon, enum events event)
> +{
> +	enum states curr_state, next_state;
> +
> +	curr_state = READ_ONCE(da_mon->curr_state);
> +	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
> +		next_state = model_get_next_state(curr_state, event);
> +		if (next_state == INVALID_STATE) {
> +			cond_react(curr_state, event);
> +			CONCATENATE(trace_error_, MONITOR_NAME)(model_get_state_name(curr_state),
> +					   model_get_event_name(event));
> +			return false;
> +		}
> +		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
> +			CONCATENATE(trace_event_, MONITOR_NAME)(model_get_state_name(curr_state),
> +					   model_get_event_name(event),
> +					   model_get_state_name(next_state),
> +					   model_is_final_state(next_state));
> +			return true;
> +		}
> +	}
> +
> +	trace_rv_retries_error(__stringify(MONITOR_NAME), model_get_event_name(event));
> +	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
> +		" retries reached for event %s, resetting monitor %s",
> +		model_get_event_name(event), __stringify(MONITOR_NAME));
> +	return false;
> +}

You have two da_event(), which is mostly similar, except the function's
signature and the trace event. Would it be sane to unify them, and only
putting the differences in #ifdef?

Perhaps something like:

#if RV_MON_TYPE == RV_MON_GLOBAL || RV_MON_TYPE == RV_MON_PER_CPU

typedef struct {} monitor_target;

static void da_trace_event(struct da_monitor *da_mon, monitor_target target,
			   enum events event, enum states curr, enum states next)
{
	CONCATENATE(trace_event_, MONITOR_NAME)(model_get_state_name(curr_state),
		    model_get_event_name(event),
		    model_get_state_name(next_state),
		    model_is_final_state(next_state));
}

#elif RV_MON_TYPE == RV_MON_PER_TASK

typedef struct task_struct *monitor_target;

static void da_trace_event(struct da_monitor *da_mon, struct task_struct *task,
			   enum events event, enum states curr, enum states next)
{
	CONCATENATE(trace_event_, MONITOR_NAME)(task->pid,
		   model_get_state_name(curr_state),
		   model_get_event_name(event),
		   model_get_state_name(next_state),
		   model_is_final_state(next_state));
}

#endif

static inline bool
da_event(struct da_monitor *da_mon, monitor_target target, enum events event)
{
	enum states curr_state, next_state;

	curr_state = READ_ONCE(da_mon->curr_state);
	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
		next_state = model_get_next_state(curr_state, event);
		if (next_state == INVALID_STATE) {
			cond_react(curr_state, event);
			da_trace_event(da_mon, event, target, curr_state, next_state);
			return false;
		}
		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
			da_trace_error(...);
			return true;
		}
	}

	trace_rv_retries_error(__stringify(MONITOR_NAME), model_get_event_name(event));
	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)
		" retries reached for event %s, resetting monitor %s",
		model_get_event_name(event), __stringify(MONITOR_NAME));
	return false;
}

Same for the other functions.

Nam
