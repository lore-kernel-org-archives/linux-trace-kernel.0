Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AC212562;
	Wed, 17 Dec 2025 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996581; cv=none; b=hnpGfgxwK0cZUCxzOnmhrppjRtcJxF2WQvV49dkrRA1WiXMPd+8ItYBfCABPcSkJoDiuFV4DHUAE+6r24tEWIHqr5w5J7H+mD6tG+cxGD5o1HhBRW5LaGd/CbOrEOUYlGvolDx/InNd0rPyR/5dX954bHtIdNKji+7sD48ucVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996581; c=relaxed/simple;
	bh=LpKz8ceRU5r/MkEpc6ZsczJlZ5g1JQengs9f9PBSLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZXZf308wWwP1mB/2CdHtUbYFdQtIMK+gNXEHRL+PC1NnGCmwkhEjHy80nlEk2awpUo8LxDwpV+bx86oj4wKZ1ZqimZNVoSE2YnhzdRR8EhV2vUZcgHMRqetdKvyC7MSfCYMmQ5vWp4+n/J271XrKEgm3DGkrmv27UUmeFRHsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B0D9B60D78;
	Wed, 17 Dec 2025 18:36:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id ED05D20011;
	Wed, 17 Dec 2025 18:36:09 +0000 (UTC)
Date: Wed, 17 Dec 2025 13:37:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-ID: <20251217133744.4a3a33cf@gandalf.local.home>
In-Reply-To: <20250814122141.109076-1-gpaoloni@redhat.com>
References: <20250814122141.109076-1-gpaoloni@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uff5ad94fgmn134zfd1xicxb5th6jpiz
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: ED05D20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19nCDlUg3hHvyqIc+0eBro0z+D1P4sQ/OU=
X-HE-Tag: 1765996569-506779
X-HE-Meta: U2FsdGVkX19CFN+eqSe2bMQSHnPGYqtcv+vO4frv1fvwO5Uf236t3ruSTUGmBdYlCWltWm5LjGKE9UDfrWrf/AWu+AlVQBlE0v4TMP1+8BZPnkquv67q2fYc445PEqrjAwJpjjY9xqKpY5z2HF9bEEtqVahAvraNL7mwCox/drVN/bw+RmshQwjcmSXNdE/iIcxmA35VVWT5xgfvB1SfMHRsxiX2kqmK/2jgMCDufo/ujhbLVP+UasPmGHnl24pws3S7CX0et3revwKJ/5BkOxGEogSj41vLHZ3iKaKpEfkPRRx8ESZm5I/Wh3UiG3tCY0NhKlUObKSWQwh+H+mGPqFVnYTsffwBb9sMyN7Q/xI7gzxBrbW6s251WLBYHNt8tC5Y3xeMovE=

On Thu, 14 Aug 2025 14:21:41 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

Hi Gabriele,

As this patch is still sitting in patchwork, and I like the comments, I
want to move it forward. I know we are still discussing posting
requirements, but regardless of that, this has some good information that I
want to add anyway. But the patch itself needs some clean up.

Note, this email is about documenting the functions and has nothing to do
with the discussions about requirements and such.

First, the subject requires some changes. One, the tracing subsystem uses
capitalized subjects. Two, the subject can be shorter:

  tracing: Add kerneldoc to set_clr_event() functions


> As per Linux Kernel documentation guidelines
> (https://docs.kernel.org/doc-guide/kernel-doc.html),
> <<Every function that is exported to loadable modules using
> EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc
> comment>>;  
> hence this patch adds detailed kernel-doc headers documentation

Change logs should be in imperative mode and never say "this patch".

> for trace_array_set_clr_event(), trace_set_clr_event() and the
> main functions in the respective call-trees that support their
> functionalities.
> 
> For each of the documented functions, as part of the extensive
> description, a set of "Function's expectations" and "Assumptions
> of Use" are described in a way that facilitate:
> 
> 1) evaluating the current code and any proposed modification
>    to behave as described;
> 
> 2) writing kernel tests to verify the code to behave as described.
> 

Actually, the above can simply be replaced with:

Add kernedoc to the following functions:

  <list of functions>


> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
> Changes from v1:
> - Added "Context:" information
> - Added "Assumptions of Use"
> - __ftrace_event_enable_disable Function's expectations have been
>   rewritten to replace the soft mode flag with the soft mode reference
>   counter
> - Addressed other comments from https://lore.kernel.org/linux-trace-kernel/20250620085618.4489-1-gpaoloni@redhat.com/T/#u
> ---
>  kernel/trace/trace_events.c | 150 ++++++++++++++++++++++++++++++++----
>  1 file changed, 133 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 9f3e9537417d..9bad5e9669df 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -763,6 +763,58 @@ void trace_event_enable_tgid_record(bool enable)
>  	} while_for_each_event_file();
>  }
>  
> +/**
> + * __ftrace_event_enable_disable - enable or disable a trace event
> + * @file: trace event file associated with the event.
> + * @enable: 0 or 1 respectively to disable/enable the event.
> + * @soft_disable: 1 or 0 respectively to mark if the enable parameter IS or
> + * IS NOT a soft enable/disable.

The parameter description should be short oneliners. Any more detail should
be in the body of the kerneldoc. Also, please be consistent. @enable uses
"0 or 1" and @soft_disable uses "1 or 0".


> + *
> + * Function's expectations:

Also, thinking about this particular function. It should describe what the
intent is. Something to the effect of:

    This function is used to enable or disable trace events for a given
    instance. The @file maps the event to a specific instance. Normally,
    this will be called with @soft_disabled = 0, where @enable set to 1 will
    enabled the event to start recording, and if @enable is set to 0, will
    disable the event. The @enable is a on/off switch, where calling this
    function multiple times with @enable = 1 will enable the event the
    first time, and the then calling this with @enable = 0 will disable the
    event, regardless of the number of times it was called with @enable for
    a given @file.

    As there are triggers that can enable tracing in a context that cannot
    modify kernel text, the triggers when enabled must "soft enable" the
    events before it has to enable them in one of those prohibited
    contexts. The code would call this function with @soft_disable set
    before it needs to enable the event. If the event is not already
    enabled, the @file flags SOFT_DISABLED bit is set and the event is
    enabled but the callback will see the SOFT_DISABLED set and not do
    anything.

    When the trigger needs the event to be fully enabled, it only needs to
    clear the SOFT_DISABLED flag, which will cause the event to start
    recording.

    Unlike the @enable flag, the @soft_disable has a counter, as multiple
    triggers may need to use it. For every time this is called with
    @enable=1 and @soft_disable=1, it requires a @enable=0 and
    @soft_disable=1 to fully disable the event.

The above can replace the below.

> + * - If soft_disable is 1 a soft mode reference counter associated with the
> + *   trace event shall be increased or decreased according to the enable
> + *   parameter being 1 (enable) or 0 (disable) respectively.
> + *   If the soft mode reference counter is > 0 before the increase or after
> + *   the decrease, no other actions shall be taken.
> + *
> + * - if soft_disable is 1 and the soft mode reference counter is 0 before
> + *   the increase or after the decrease, an enable value set to 0 or 1 shall
> + *   result in disabling or enabling the use of trace_buffered_event
> + *   respectively.
> + *
> + * - If soft_disable is 1 and enable is 0 and the soft mode reference counter
> + *   reaches zero and if the soft disabled flag is set (i.e. if the event was
> + *   previously enabled with soft_disable = 1), tracing for the trace point
> + *   event shall be disabled and the soft disabled flag shall be cleared.
> + *
> + * - If soft_disable is 0 and enable is 0, tracing for the trace point event
> + *   shall be disabled only if the soft mode reference counter is 0.
> + *   Additionally the soft disabled flag shall be set or cleared according to
> + *   the soft mode reference counter being greater than 0 or 0 respectively.
> + *
> + * - If enable is 1, tracing for the trace point event shall be enabled (if
> + *   previously disabled); in addition, if soft_disable is 1 and the soft mode
> + *   reference counter is 0 before the increase, the soft disabled flag shall
> + *   be set.
> + *
> + * - When enabling or disabling tracing for the trace point event
> + *   the flags associated with comms and tgids shall be checked and, if set,
> + *   respectively tracing of comms and tgdis at sched_switch shall be
> + *   enabled/disabled.
> + *
> + * Assumptions of Use:
> + * - for thread-safe execution, event_mutex shall be locked before calling
> + *   this function;
> + * - the file input pointer is assumed to be a valid one;
> + * - the enable input parameter shall not be set to any value other than 0
> + *   or 1.
> + *
> + * Context: process context.

> + *
> + * Return:
> + * * 0 on success
> + * * any error returned by the event register or unregister callbacks

Note, the error document here should not reference other functions.

Should just say "Negative on error" or something similar.

> + */


The rest can be updated similar.

Are you OK with this, or would you prefer that I make these changes?

-- Steve

>  static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  					 int enable, int soft_disable)
>  {
> @@ -1296,8 +1348,46 @@ static void remove_event_file_dir(struct trace_event_file *file)
>  	event_file_put(file);
>  }
>  
> -/*
> - * __ftrace_set_clr_event(NULL, NULL, NULL, set) will set/unset all events.
> +/**
> + * __ftrace_set_clr_event_nolock - enable or disable an event within a system.
> + * @tr: target trace_array containing the events list.
> + * @match: target system or event name (NULL for any).
> + * @sub: target system name (NULL for any).
> + * @event: target event name (NULL for any).
> + * @set: 1 to enable, 0 to disable.
> + * @mod: target module name (NULL for any).
> + *
> + * Function's expectations:
> + * - If mod is set, the mod name shall be sanitized by replacing all '-' with
> + *   '_' to match the modules' naming convention used in the Kernel.
> + *
> + * - From the events' list in the input tr, the ensemble of events to be enabled
> + *   or disabled shall be selected according to the input match, sub, event and
> + *   mod parameters. Each of these parameters, if set, shall restrict the events
> + *   ensemble to those with a matching parameter's name.
> + *
> + * - For each of the selected events the IGNORE_ENABLE flag shall be checked,
> + *   and, if not set, ftrace_event_enable_disable shall be invoked passing the
> + *   input set parameter to either enable or disable the event.
> + *
> + * Assumptions of Use:
> + * - for thread-safe execution, event_mutex shall be locked before calling
> + *   this function;
> + * - the tr input pointer is assumed to be a valid one;
> + * - the set input parameter shall not be set to any value other than 0
> + *   or 1.
> + *
> + * NOTE: __ftrace_set_clr_event_nolock(NULL, NULL, NULL, set, NULL) will
> + * set/unset all events.
> + *
> + * Context: process context.
> + *
> + * Return:
> + * * 0 on success
> + * * %-EINVAL - the input parameters do not match any registered event
> + * * %-ENOMEM -  memory allocation fails for the module pointer
> + * * any value returned by the first call to ftrace_event_enable_disable that
> + * returned an error
>   */
>  static int
>  __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
> @@ -1440,16 +1530,32 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>  }
>  
>  /**
> - * trace_set_clr_event - enable or disable an event
> - * @system: system name to match (NULL for any system)
> - * @event: event name to match (NULL for all events, within system)
> - * @set: 1 to enable, 0 to disable
> + * trace_set_clr_event - enable or disable an event within a system.
> + * @system: system name (NULL for any system).
> + * @event: event name (NULL for all events, within system).
> + * @set: 1 to enable, 0 to disable.
>   *
>   * This is a way for other parts of the kernel to enable or disable
>   * event recording.
>   *
> - * Returns 0 on success, -EINVAL if the parameters do not match any
> - * registered events.
> + * Function's expectations:
> + * - This function shall retrieve the pointer of the global trace array (global
> + *   tracer) and pass it, along the rest of input parameters, to
> + *   __ftrace_set_clr_event_nolock.
> + *
> + * - This function shall properly lock/unlock the global event_mutex
> + *   before/after invoking ftrace_set_clr_event_nolock.
> + *
> + * Assumptions of Use:
> + * - the set input parameter shall not be set to any value other than 0
> + *   or 1.
> + *
> + * Context: process context, locks and unlocks event_mutex.
> + *
> + * Return:
> + * * 0 on success
> + * * %-ENODEV - the global tracer cannot be retrieved
> + * * any other error condition returned by __ftrace_set_clr_event_nolock
>   */
>  int trace_set_clr_event(const char *system, const char *event, int set)
>  {
> @@ -1463,17 +1569,27 @@ int trace_set_clr_event(const char *system, const char *event, int set)
>  EXPORT_SYMBOL_GPL(trace_set_clr_event);
>  
>  /**
> - * trace_array_set_clr_event - enable or disable an event for a trace array.
> - * @tr: concerned trace array.
> - * @system: system name to match (NULL for any system)
> - * @event: event name to match (NULL for all events, within system)
> - * @enable: true to enable, false to disable
> + * trace_array_set_clr_event - enable or disable an event within a system for
> + * a trace array.
> + * @tr: input trace array.
> + * @system: system name (NULL for any system).
> + * @event: event name (NULL for all events, within system).
> + * @enable: true to enable, false to disable.
>   *
> - * This is a way for other parts of the kernel to enable or disable
> - * event recording.
> + * This is a way for other parts of the kernel to enable or disable event
> + * recording.
> + *
> + * Function's expectations:
> + * - This function shall properly lock/unlock the global event_mutex
> + *   before/after invoking ftrace_set_clr_event_nolock passing along the same
> + *   input parameters.
> + *
> + * Context: process context, locks and unlocks event_mutex.
>   *
> - * Returns 0 on success, -EINVAL if the parameters do not match any
> - * registered events.
> + * Return:
> + * * 0 on success
> + * * %-ENOENT - the input tr is NULL
> + * * any other error condition returned by __ftrace_set_clr_event_nolock
>   */
>  int trace_array_set_clr_event(struct trace_array *tr, const char *system,
>  		const char *event, bool enable)

