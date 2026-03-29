Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E2269B1C;
	Sun, 29 Mar 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799393; cv=none; b=FdwCZzaGCyZmLVN3YGGeXtx739453ghEsz+q8/ZYgw5C79FwA8B3C33cWxyUul/pMbYMax4jIvaTvhLkjqBSXV48EJcD4a5/vL/ozCmBo7G2EtFoNoMyYkNQpHgWZFrpxIv8HGX4b0tllgBok4UH0JSERFZB+Fvag3Yq5h0CP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799393; c=relaxed/simple;
	bh=SB9CKjRsH3VMmgiBzPW0LXY/M4OK+DdKzDjVT1KJl5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgRyDOqEmSCunSmu/TCQC6iI5xuHYYu8+GyWK5rBRAMr++DfqXdzYQlTEtbVMCGiIAQgZ/3gTXwpFIDRYeY8wJT50lxiqgaTGl4rHCyJVpngBpd1/qTgcZ+ioMSsiE1emLHIWqkjZm5E611xhQwFWOZsl47EnIk28yza1ffT7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DF7018BA56;
	Sun, 29 Mar 2026 15:49:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 131F434;
	Sun, 29 Mar 2026 15:49:42 +0000 (UTC)
Date: Sun, 29 Mar 2026 11:49:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tracing: Preserve repeated boot-time tracing
 parameters
Message-ID: <20260329114941.25d3541d@robin>
In-Reply-To: <20260328201842.1782806-1-atwellwea@gmail.com>
References: <20260324221326.1395799-2-atwellwea@gmail.com>
	<20260328201842.1782806-1-atwellwea@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nsaky5a7ycw9forrfqng44emi1uu5dqb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 131F434
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Ymt6c4Jv6JGgR2UwcLF7w26w9M5ok7Sw=
X-HE-Tag: 1774799382-60872
X-HE-Meta: U2FsdGVkX1/sDxZ2wX40YmXSsfh5ObZNu64ImHJjgOT3iOA48jiqcDoP1pz80UELUrEPHE4S1ql+uMGskGM74xg+9rN5wxPUNHNQVAIiH8RAWELBLOR2kR6t086X1UFwSoaZYu+W5kxIQ/7TMByTisTMYmPdOldqIGoXkf0zc4L+LZOaPJQEbkBUDYdZhihTPUHBDOtRgtpoHP5IvSqpwfOkijPLHg4NOk++h4Aboi36fBOrosJAb7WhXRvGuEsajsel/7Gmu9NCVVvnDZRQcWxqxgvxcyvneL4LeVs5yNO95YkHKSPUom2B6L/1MwdW/iejYV3fVSttbnhuFDWImPAUW6Qx7B2yRvpK5entURu+QToVCilV4g==

On Sat, 28 Mar 2026 14:18:42 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

> Some tracing boot parameters already accept delimited value lists, but
> their __setup() handlers keep only the last instance seen at boot.
> Make repeated instances append to the same boot-time buffer in the
> format each parser already consumes.
> 
> Use a shared trace_append_boot_param() helper for the ftrace filters,
> trace_options, and kprobe_event boot parameters. trace_trigger=
> tokenizes its backing storage in place, so keep a running offset and
> only parse the newly appended chunk into bootup_triggers[].
> 
> This also lets Bootconfig array values work naturally when they expand
> to repeated param=value entries.
> 
> Validated by booting with repeated ftrace_filter=, ftrace_notrace=,
> ftrace_graph_filter=, ftrace_graph_notrace=, trace_options=,
> kprobe_event=, and trace_trigger= parameters and confirming that the
> resulting tracefs state preserved every requested entry. Before this
> change, only the last instance from each repeated parameter survived
> boot.
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
> v5:

FYI, it's nice to have a daisy chain connection of previous versions. I
suggest instead of just saying "v5:" use:

Changes since v4: https://lore.kernel.org/all/20260324221326.1395799-2-atwellwea@gmail.com/

> - use int sizes in the shared append helper and trace_trigger bookkeeping
> - keep a single bounded append path that only inserts the separator after
>   the first entry
> - only advance the trace_trigger buffer offset after a successful append
> 
>  kernel/trace/ftrace.c       | 12 ++++++++----
>  kernel/trace/trace.c        | 29 ++++++++++++++++++++++++++++-
>  kernel/trace/trace.h        |  2 ++
>  kernel/trace/trace_events.c | 23 ++++++++++++++++++++---
>  kernel/trace/trace_kprobe.c |  3 ++-
>  5 files changed, 60 insertions(+), 9 deletions(-)
> 

> +/*
> + * Repeated boot parameters, including Bootconfig array expansions, need
> + * to stay in the delimiter form that the existing parser consumes.
> + */
> +void __init trace_append_boot_param(char *buf, const char *str, char sep,
> +				    int size)
> +{

This is much better.

> +	int len, needed, str_len;
> +
> +	if (!*str)
> +		return;
> +
> +	len = strlen(buf);
> +	str_len = strlen(str);
> +	needed = len + str_len + 1;

Perhaps add a comment:

	/* For continuation, account for separator */
> +	if (len)
> +		needed++;
> +	if (needed > size)
> +		return;
> +
> +	if (len)
> +		buf[len++] = sep;
> +
> +	strscpy(buf + len, str, size - len);
> +}
> +
>  static int __init set_cmdline_ftrace(char *str)
>  {
>  	strscpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);


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
> +	char *slot;
>  	char *trigger;
>  	char *buf;
>  	int i;
>  
> -	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> +	if (bootup_trigger_buf_len >= COMMAND_LINE_SIZE)
> +		return 1;
> +
> +	slot = bootup_trigger_buf + bootup_trigger_buf_len;

The bootup_trigger_buf is a temporary buffer for this function only. It
works fine as is. There's no reason to modify this function.

-- Steve

> +
> +	/*
> +	 * trace_trigger= parsing tokenizes the backing storage in place.
> +	 * Copy each repeated parameter into fresh space and only parse that
> +	 * newly copied chunk here.
> +	 */
> +	trace_append_boot_param(slot, str, '\0',
> +				COMMAND_LINE_SIZE - bootup_trigger_buf_len);
> +	if (!*slot)
> +		return 1;
> +
> +	bootup_trigger_buf_len += strlen(slot) + 1;
>  	trace_set_ring_buffer_expanded(NULL);
>  	disable_tracing_selftest("running event triggers");
>  
> -	buf = bootup_trigger_buf;
> -	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
> +	buf = slot;
> +	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
>  		trigger = strsep(&buf, ",");
>  		if (!trigger)
>  			break;
