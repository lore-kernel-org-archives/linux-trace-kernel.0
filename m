Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE33A758F;
	Tue, 24 Mar 2026 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377789; cv=none; b=hPWa9OXA69GNzaxWj1j3jMNMFk+h1O4Mmi8N6chWEU+xj2CfcvJRRlwAbEA6QL+GnZtV+pue7eAQ9c+rlB6hUuHnpRPx6eb6/hi3WWS907a4qRWINwO55I7JD0EEZOkqPKtZKPcdk+EkWl3BH19maTqugAjuqN7yfJQD5aGf698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377789; c=relaxed/simple;
	bh=wB03bJFHQsLxVwqb32vJbGbzt4aYoelP+6FV8EYWLHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGrOd5c/EGSq7N4TgIeElUggpOsimv+TVlCOSKfKjvI0ag6ofy7Xp9OvQa9OFldkw2uB+/yk9oFnbV7zbspFLw6WnoSsAlwnM1rsI1AHPEFNAn/97HN/SI992SAiA1UWH2dNaxspDswuFxnFLGP6VR0YjruXjlbCRDC7yxA6gxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CDC201A03BA;
	Tue, 24 Mar 2026 18:43:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id AEC262000E;
	Tue, 24 Mar 2026 18:43:03 +0000 (UTC)
Date: Tue, 24 Mar 2026 14:43:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: preserve repeated boot-time tracing
 parameters
Message-ID: <20260324144345.0fff670b@gandalf.local.home>
In-Reply-To: <20260310064715.527906-2-atwellwea@gmail.com>
References: <20260310064715.527906-1-atwellwea@gmail.com>
	<20260310064715.527906-2-atwellwea@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ws3do4qe696pgwwtyynbhqiuef5htwf5
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AEC262000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sKPZRBSUHJdO9MLhcgnQRHAdk9jcP2DQ=
X-HE-Tag: 1774377783-882305
X-HE-Meta: U2FsdGVkX1+G0qllFPSl9yFfHbaeFILaNuD51kOgxMLMpusk+podMjX/tMvpCrxNYvk40hf3SWtbbECWyS9djw2y7xborDfAONEie5BmKCUJjqspxdkgZpc/t0IBYSn0Re5KgTdWwVZVlu/T4IWnN2FhoOn973ECUrbma9Ar5A8vr+6hulPcAAZJnLhqWTW0bBqMUxOG4QG7/29+urFUGarlsotY+w4YaH7vrEaYiloF1qJ6FPVcvRnHyUpfy171HRBpiQUZeciS+5aIDHYm30UK2PfgbLMv7B9KBwfJfSKkqGCBAbb8B/dHj59aVGnG56agdW2qkWZqpkz4aPlccnjc+bxsDgQwh+03PJMP3Qbur02vzurHYfAh73fGgbi5M0S/y9rEVKhKWaOOjwFBsQ==

On Tue, 10 Mar 2026 00:47:14 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

Hi,

FYI, the tracing subsystem uses capital letters in subjects:

   tracing: Preserve repeated boot-time tracing parameters

> Some tracing boot parameters already accept delimited value lists, but
> their __setup() handlers keep only the last instance seen at boot.
> Make repeated instances append to the same boot-time buffer in the
> format each parser already consumes, and document that behavior in
> admin-guide/kernel-parameters.txt.
> 
> Use a shared trace_append_boot_param() helper for the ftrace filters,
> trace_options, and kprobe_event boot parameters. trace_trigger=
> tokenizes its backing storage in place, so keep a running offset and
> only parse the newly appended chunk into bootup_triggers[].
> 
> This also lets Bootconfig array values work naturally when they expand
> to repeated param=value entries.
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 18 ++++++++++--
>  kernel/trace/ftrace.c                         | 12 +++++---
>  kernel/trace/trace.c                          |  3 +-
>  kernel/trace/trace.h                          | 29 +++++++++++++++++++
>  kernel/trace/trace_events.c                   | 26 +++++++++++++++--
>  kernel/trace/trace_kprobe.c                   |  3 +-
>  6 files changed, 79 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 55ffc0f8858a..203863c1839b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1803,13 +1803,15 @@ Kernel parameters
>  			tracer at boot up. function-list is a comma-separated
>  			list of functions. This list can be changed at run
>  			time by the set_ftrace_filter file in the debugfs
> -			tracing directory.
> +			tracing directory. Repeated instances append more
> +			functions to the same list.
>  
>  	ftrace_notrace=[function-list]
>  			[FTRACE] Do not trace the functions specified in
>  			function-list. This list can be changed at run time
>  			by the set_ftrace_notrace file in the debugfs
> -			tracing directory.
> +			tracing directory. Repeated instances append more
> +			functions to the same list.
>  
>  	ftrace_graph_filter=[function-list]
>  			[FTRACE] Limit the top level callers functions traced
> @@ -1817,12 +1819,16 @@ Kernel parameters
>  			function-list is a comma-separated list of functions
>  			that can be changed at run time by the
>  			set_graph_function file in the debugfs tracing directory.
> +			Repeated instances append more functions to the same
> +			list.
>  
>  	ftrace_graph_notrace=[function-list]
>  			[FTRACE] Do not trace from the functions specified in
>  			function-list.  This list is a comma-separated list of
>  			functions that can be changed at run time by the
>  			set_graph_notrace file in the debugfs tracing directory.
> +			Repeated instances append more functions to the same
> +			list.
>  
>  	ftrace_graph_max_depth=<uint>
>  			[FTRACE] Used with the function graph tracer. This is
> @@ -3053,6 +3059,8 @@ Kernel parameters
>  			The probe-list is a semicolon delimited list of probe
>  			definitions. Each definition is same as kprobe_events
>  			interface, but the parameters are comma delimited.
> +			Repeated instances append more probe definitions to
> +			the same boot-time list.
>  			For example, to add a kprobe event on vfs_read with
>  			arg1 and arg2, add to the command line;
>  
> @@ -7820,6 +7828,9 @@ Kernel parameters
>  
>  			    /sys/kernel/tracing/trace_options
>  
> +			Repeated instances append more options to the same
> +			boot-time list.
> +
>  			For example, to enable stacktrace option (to dump the
>  			stack trace of each event), add to the command line:
>  
> @@ -7831,7 +7842,8 @@ Kernel parameters
>  	trace_trigger=[trigger-list]
>  			[FTRACE] Add an event trigger on specific events.
>  			Set a trigger on top of a specific event, with an optional
> -			filter.
> +			filter. Repeated instances append more triggers to
> +			the same boot-time list.

I know Masami mentioned to document this, but honestly, I don't think this
update is needed. Please remove it.

>  
>  			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
>  			Where more than one trigger may be specified that are comma delimited.
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8df69e702706..d0a486b63ed6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6841,7 +6841,8 @@ bool ftrace_filter_param __initdata;
>  static int __init set_ftrace_notrace(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	trace_append_boot_param(ftrace_notrace_buf, str, ',',
> +				FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_notrace=", set_ftrace_notrace);
> @@ -6849,7 +6850,8 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
>  static int __init set_ftrace_filter(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
> +	trace_append_boot_param(ftrace_filter_buf, str, ',',
> +				FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_filter=", set_ftrace_filter);
> @@ -6861,14 +6863,16 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
>  
>  static int __init set_graph_function(char *str)
>  {
> -	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
> +	trace_append_boot_param(ftrace_graph_buf, str, ',',
> +				FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_graph_filter=", set_graph_function);
>  
>  static int __init set_graph_notrace_function(char *str)
>  {
> -	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	trace_append_boot_param(ftrace_graph_notrace_buf, str, ',',
> +				FTRACE_FILTER_SIZE);
>  	return 1;
>  }
>  __setup("ftrace_graph_notrace=", set_graph_notrace_function);
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebd996f8710e..5086239a75dc 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -329,7 +329,8 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
>  
>  static int __init set_trace_boot_options(char *str)
>  {
> -	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
> +	trace_append_boot_param(trace_boot_options_buf, str, ',',
> +				MAX_TRACER_SIZE);
>  	return 1;
>  }
>  __setup("trace_options=", set_trace_boot_options);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b8f3804586a0..4f5abac4bd19 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -23,6 +23,7 @@
>  #include <linux/once_lite.h>
>  #include <linux/ftrace_regs.h>
>  #include <linux/llist.h>
> +#include <linux/string.h>
>  
>  #include "pid_list.h"
>  
> @@ -262,6 +263,34 @@ static inline bool still_need_pid_events(int type, struct trace_pid_list *pid_li
>  		(!(type & TRACE_NO_PIDS) && no_pid_list);
>  }
>  
> +/*
> + * Repeated boot parameters, including Bootconfig array expansions, need
> + * to stay in the delimiter form that the existing parser consumes.
> + */
> +static inline void __init trace_append_boot_param(char *buf, const char *str,
> +						  char sep, size_t size)
> +{

Masami said:

  Please make a generic append function in kernel/trace/trace.h, e.g.

  void trace_append_boot_param(char *buf, const char *str, char sep, size_t ssize);

  and use it instead of strscpy.

He did not say to make a static inline in the header. Please make this a
normal function in trace.c and just add the prototype in the header.

-- Steve


> +	size_t len, str_len;
> +
> +	if (buf[0] == '\0') {
> +		strscpy(buf, str, size);
> +		return;
> +	}
> +
> +	str_len = strlen(str);
> +	if (!str_len)
> +		return;
> +
> +	len = strlen(buf);
> +	if (len >= size - 1)
> +		return;
> +	if (str_len >= size - len - 1)
> +		return;
> +
> +	buf[len] = sep;
> +	strscpy(buf + len + 1, str, size - len - 1);
> +}
> +
>  typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
>  
>  /**
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 249d1cba72c0..5f72be33f2d1 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3679,20 +3679,40 @@ static struct boot_triggers {
>  } bootup_triggers[MAX_BOOT_TRIGGERS];
>  
>  static char bootup_trigger_buf[COMMAND_LINE_SIZE];
> +static size_t bootup_trigger_buf_len;
>  static int nr_boot_triggers;
>  
>  static __init int setup_trace_triggers(char *str)
>  {
>  	char *trigger;
>  	char *buf;
> +	size_t start, str_len;
>  	int i;
>  
> -	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> +	if (bootup_trigger_buf_len >= COMMAND_LINE_SIZE)
> +		return 1;
> +
> +	start = bootup_trigger_buf_len;
> +	if (start && !*str)
> +		return 1;
> +
> +	str_len = strlen(str);
> +	if (start && str_len >= COMMAND_LINE_SIZE - start)
> +		return 1;
> +
> +	/*
> +	 * trace_trigger= parsing tokenizes the backing storage in place.
> +	 * Copy each repeated parameter into fresh space and only parse that
> +	 * newly copied chunk here.
> +	 */
> +	trace_append_boot_param(bootup_trigger_buf + start, str, '\0',
> +				COMMAND_LINE_SIZE - start);
> +	bootup_trigger_buf_len += strlen(bootup_trigger_buf + start) + 1;
>  	trace_set_ring_buffer_expanded(NULL);
>  	disable_tracing_selftest("running event triggers");
>  
> -	buf = bootup_trigger_buf;
> -	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
> +	buf = bootup_trigger_buf + start;
> +	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
>  		trigger = strsep(&buf, ",");
>  		if (!trigger)
>  			break;
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a5dbb72528e0..e9f1c55aea64 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -31,7 +31,8 @@ static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
>  
>  static int __init set_kprobe_boot_events(char *str)
>  {
> -	strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
> +	trace_append_boot_param(kprobe_boot_events_buf, str, ';',
> +				COMMAND_LINE_SIZE);
>  	disable_tracing_selftest("running kprobe events");
>  
>  	return 1;

