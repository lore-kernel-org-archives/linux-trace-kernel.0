Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBB266581;
	Tue, 10 Mar 2026 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121154; cv=none; b=f2bX9KrYWcUK9tIe4HybHuv6tMDn2VBRolQ2OAvUNK4lPb6rKKu3OW1MGz59Q8DVvPQ5oMnI4Z2JRZljSHtSW10+tvkkPLnzsG7UIer5j+/VATXJdrZKl1DAtE5xxaPZt0Eyy6pLjHmIT57HDPJVkU+Zh6laqth1nqOqXna08Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121154; c=relaxed/simple;
	bh=B0BCBOmocOCtqGdk39ONhdjxyt49Cg18WfWz34E2ndg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n/se4O2YswPXSpsrn1UTLZ/RH0T7CV4J6hgAtpq3Yofu3q4XDWuJ5c95xqyZp9wANCz1zsfNAjA6ScF2QZzF3HiyXZ8v8srv7NsjGRt4D+Nvzx8V+JG+KxZf4WweI/IXJ0ARbNPkdPf0VhWH+AAlnauxfM/2A91SYRbQH/btckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq9QKKfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq9QKKfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA52C19423;
	Tue, 10 Mar 2026 05:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773121154;
	bh=B0BCBOmocOCtqGdk39ONhdjxyt49Cg18WfWz34E2ndg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cq9QKKfpOfjHUnIARHUPHH0EiTlIoYy5U3d1ouWK4S7inWmB3QBEJp0BZe8Pkhpyc
	 7bsCSM2y+Jo8e7DN5V/ADogLgunsw+UfgxmNBZKIXBLEgZLrYSBwzn2VVT7P58yzzi
	 dCa9SYS/rjjyEBRKy0raZQgthKqI4EuQhT0uHUpNxEaH8zVDSS72BmMopem00at0Cu
	 yQLMLYhD5Mn/YFsPoopVVusOmjRJSttMaOZSeuGyYyKB9ry7zlImCMXjU6b+EyZmLo
	 DYlBpLK35XUyI5hJjy1ikddgtcGwbKqtNDuMogLRsCXhTJJmbzzAiTRiCZlc19Lbe4
	 gqIUfUyhpLHcA==
Date: Tue, 10 Mar 2026 14:39:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: preserve repeated boot-time tracing
 parameters
Message-Id: <20260310143911.89ec35c716515e51483f27be@kernel.org>
In-Reply-To: <20260309195220.2726094-1-atwellwea@gmail.com>
References: <20260309195220.2726094-1-atwellwea@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Mar 2026 13:52:19 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

> Bootconfig expands arrays into repeated param=value entries, and the
> kernel command line can repeat the same tracing parameter as well.
> Several tracing __setup() handlers still overwrite their boot buffers,
> so only the last ftrace filter, graph filter, trace option, kprobe
> event, or trace trigger entry survives boot.

Actually I expected to use it as a string instead of array.

kernel.ftrace_filter="funcA,funcB,funcC"

Because this "funcA,funcB,funcC" is the parameter for ftrace_filter
option.

And admins can choose to specify it as an array or a string by themselves.
(according to the behavior)

For parameters which supports appending values.

  param=value1, value2, value3

For parameters which does NOT supports appending values.

  param="value1,value2,value3"

The problem, if there is one, is that admin-guide/kernel-parameters.txt
doesn't provide any information about this behavior.
(Whether the subsequent parameters should overwrite, be appended,
 or be ignored)

Maybe it is better to document it.

> 
> Preserve repeated values in the format their existing parsers already
> consume: comma-delimited lists for ftrace filters and trace options,
> semicolon-delimited lists for kprobe events, and per-chunk parsing for
> trace_trigger=. The trace_trigger parser tokenizes its storage in
> place, so keep a running length and only parse the newly appended
> chunk into bootup_triggers[].
> 
> Fixes: 2af15d6a44b8 ("ftrace: add kernel command line function filtering")
> Fixes: 7bcfaf54f591 ("tracing: Add trace_options kernel command line parameter")
> Fixes: a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
> Fixes: 970988e19eb0 ("tracing/kprobe: Add kprobe_event= boot parameter")

And I think this is improvement to support appending subsequent parameters.
Not Fix, because this is not a bug.


> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  kernel/trace/ftrace.c       | 29 +++++++++++++++++++++++++----
>  kernel/trace/trace.c        | 23 ++++++++++++++++++++++-
>  kernel/trace/trace_events.c | 23 ++++++++++++++++++++---
>  kernel/trace/trace_kprobe.c | 23 ++++++++++++++++++++++-
>  4 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8df69e702706..cdd46f639333 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6835,13 +6835,34 @@ EXPORT_SYMBOL_GPL(ftrace_set_global_notrace);
>  static char ftrace_notrace_buf[FTRACE_FILTER_SIZE] __initdata;
>  static char ftrace_filter_buf[FTRACE_FILTER_SIZE] __initdata;
>  
> +static void __init append_ftrace_boot_param(char *buf, const char *str,
> +					    char sep)
> +{
> +	size_t len, str_len;
> +
> +	if (buf[0] == '\0') {
> +		strscpy(buf, str, FTRACE_FILTER_SIZE);
> +		return;
> +	}
> +
> +	len = strlen(buf);
> +	str_len = strlen(str);
> +	if (!str_len)
> +		return;
> +	if (str_len >= FTRACE_FILTER_SIZE - len - 1)
> +		return;
> +
> +	buf[len] = sep;
> +	strscpy(buf + len + 1, str, FTRACE_FILTER_SIZE - len - 1);
> +}

Please make a generic append function in kernel/trace/trace.h, e.g.

void trace_append_boot_param(char *buf, const char *str, char sep, size_t ssize);

and use it instead of strscpy.

Thank you,

> +
>  /* Used by function selftest to not test if filter is set */
>  bool ftrace_filter_param __initdata;
>  
>  static int __init set_ftrace_notrace(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strscpy(ftrace_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	append_ftrace_boot_param(ftrace_notrace_buf, str, ',');
>  	return 1;
>  }
>  __setup("ftrace_notrace=", set_ftrace_notrace);
> @@ -6849,7 +6870,7 @@ __setup("ftrace_notrace=", set_ftrace_notrace);
>  static int __init set_ftrace_filter(char *str)
>  {
>  	ftrace_filter_param = true;
> -	strscpy(ftrace_filter_buf, str, FTRACE_FILTER_SIZE);
> +	append_ftrace_boot_param(ftrace_filter_buf, str, ',');
>  	return 1;
>  }
>  __setup("ftrace_filter=", set_ftrace_filter);
> @@ -6861,14 +6882,14 @@ static int ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer);
>  
>  static int __init set_graph_function(char *str)
>  {
> -	strscpy(ftrace_graph_buf, str, FTRACE_FILTER_SIZE);
> +	append_ftrace_boot_param(ftrace_graph_buf, str, ',');
>  	return 1;
>  }
>  __setup("ftrace_graph_filter=", set_graph_function);
>  
>  static int __init set_graph_notrace_function(char *str)
>  {
> -	strscpy(ftrace_graph_notrace_buf, str, FTRACE_FILTER_SIZE);
> +	append_ftrace_boot_param(ftrace_graph_notrace_buf, str, ',');
>  	return 1;
>  }
>  __setup("ftrace_graph_notrace=", set_graph_notrace_function);
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebd996f8710e..42d03d36ae39 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -327,9 +327,30 @@ __setup("trace_instance=", boot_instance);
>  
>  static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
>  
> +static void __init append_trace_boot_options(const char *str)
> +{
> +	size_t len, str_len;
> +
> +	if (trace_boot_options_buf[0] == '\0') {
> +		strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
> +		return;
> +	}
> +
> +	len = strlen(trace_boot_options_buf);
> +	str_len = strlen(str);
> +	if (!str_len)
> +		return;
> +	if (str_len >= MAX_TRACER_SIZE - len - 1)
> +		return;
> +
> +	trace_boot_options_buf[len] = ',';
> +	strscpy(trace_boot_options_buf + len + 1, str,
> +		MAX_TRACER_SIZE - len - 1);
> +}
> +
>  static int __init set_trace_boot_options(char *str)
>  {
> -	strscpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
> +	append_trace_boot_options(str);
>  	return 1;
>  }
>  __setup("trace_options=", set_trace_boot_options);
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 249d1cba72c0..c3981f62e4bc 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3679,20 +3679,37 @@ static struct boot_triggers {
>  } bootup_triggers[MAX_BOOT_TRIGGERS];
>  
>  static char bootup_trigger_buf[COMMAND_LINE_SIZE];
> +static int bootup_trigger_buf_len;
>  static int nr_boot_triggers;
>  
>  static __init int setup_trace_triggers(char *str)
>  {
>  	char *trigger;
>  	char *buf;
> +	ssize_t copied;
>  	int i;
> +	int start;
>  
> -	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> +	if (bootup_trigger_buf_len >= COMMAND_LINE_SIZE)
> +		return 1;
> +
> +	start = bootup_trigger_buf_len;
> +	if (start && !*str)
> +		return 1;
> +
> +	copied = strscpy(bootup_trigger_buf + start, str,
> +			 COMMAND_LINE_SIZE - start);
> +	if (copied < 0) {
> +		if (start)
> +			return 1;
> +		copied = strlen(bootup_trigger_buf + start);
> +	}
> +	bootup_trigger_buf_len += copied + 1;
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
> index a5dbb72528e0..a63a56b55570 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -29,9 +29,30 @@
>  /* Kprobe early definition from command line */
>  static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
>  
> +static void __init append_kprobe_boot_event(const char *str)
> +{
> +	size_t len, str_len;
> +
> +	if (kprobe_boot_events_buf[0] == '\0') {
> +		strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
> +		return;
> +	}
> +
> +	len = strlen(kprobe_boot_events_buf);
> +	str_len = strlen(str);
> +	if (!str_len)
> +		return;
> +	if (str_len >= COMMAND_LINE_SIZE - len - 1)
> +		return;
> +
> +	kprobe_boot_events_buf[len] = ';';
> +	strscpy(kprobe_boot_events_buf + len + 1, str,
> +		COMMAND_LINE_SIZE - len - 1);
> +}
> +
>  static int __init set_kprobe_boot_events(char *str)
>  {
> -	strscpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
> +	append_kprobe_boot_event(str);
>  	disable_tracing_selftest("running kprobe events");
>  
>  	return 1;
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
