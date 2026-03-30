Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB72E5B2A;
	Mon, 30 Mar 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881752; cv=none; b=LWk+ZB4MJLXi5+yQ+m/CBKQWu+Whj7JNvL9B81cRAPg32Kx+N46fox2ftIzCWRAhCOD3Y2DyfhixgB66hHY5ryqQIztzFCQI6WzwjCxSuwhVFep32FXL6oSQSREUxD8ZNjyafbLSQoCvD0xJ7EVCfr0lv9WPBfFk/QaaGcZQNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881752; c=relaxed/simple;
	bh=ROF5NCFpUjSyZHwQUZH2FxXLeQYKdxbj2jg/Hq+PbUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCoN4CInTx2jzOgW5vpVSsTvAm4yOusZ8SEkmQQv5AhITO1lRrMGgWEo8DFY1O5rrx3d8u2D8RzANrbJ+jVQ4Kzuca/ufOCrbX6G5/uur2GOOXK85G14YTKnZZu6rCTz7Abo7sDBUyv86ld2egUJBBAJ5ihKMghcRrobkFgkEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id E782EE0C35;
	Mon, 30 Mar 2026 14:42:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 194BE60012;
	Mon, 30 Mar 2026 14:42:27 +0000 (UTC)
Date: Mon, 30 Mar 2026 10:43:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tracing: Preserve repeated boot-time tracing
 parameters
Message-ID: <20260330104322.7403c660@gandalf.local.home>
In-Reply-To: <20260329184254.1813273-1-atwellwea@gmail.com>
References: <20260328201842.1782806-1-atwellwea@gmail.com>
	<20260329184254.1813273-1-atwellwea@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 194BE60012
X-Stat-Signature: fqo4z6qctu1g6t1ef863bx77rmheg7ei
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//L+obKW4XLU+8IlQC4kAbyTDRBubWEpE=
X-HE-Tag: 1774881747-664039
X-HE-Meta: U2FsdGVkX180bijUX9eftYm7vhXCLaavWyTZMwDqrtIpC/q+CxaYWBCtoq5D/dTLC6GySzBeT8rYZbMUuLgtLZWtt1ZbyHom3H1W/i8oJZcz+I05FpenufpaalfFXmlbtgvlTGJKU9yzTxe70RyiLKe/VT6g43vsKR7/oCw17sFCNLY5mSSuV//rswZsJHe9fYdpsofPwLCV3KtcD275dR9yHGjnGRrnFPdwYCFbYkbVl4ji5S9j4DNZVxiRvhyDBy0aaLfOzPZ+NERVcGgRK3ls+aGSV3/af2MAQwSJ1oPqcz5+iPVd/2XMZc2PX+AJd5+zyW2xe5wSUAEK7o5CT5UFkAKKXKUYgSKwPMun0eT8OiuUAdRtwA==

On Sun, 29 Mar 2026 12:42:54 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

BTW, please do not reply to old versions of a patch with new versions. It
makes it much more difficult for maintainers to find what is the last patch.

New versions of a patch should *always* be a start of a new thread!

> Some tracing boot parameters already accept delimited value lists, but
> their __setup() handlers keep only the last instance seen at boot.
> Make repeated instances append to the same boot-time buffer in the
> format each parser already consumes.
> 
> Use a shared trace_append_boot_param() helper for the ftrace filters,
> trace_options, and kprobe_event boot parameters. trace_trigger=
> still tokenizes a temporary parse buffer in place, but now copies each
> parsed event/trigger pair into boot-time storage so repeated instances
> do not overwrite earlier ones.
> 
> This also lets Bootconfig array values work naturally when they expand
> to repeated param=value entries.
> 
> Before this change, only the last instance from each repeated
> parameter survived boot.
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
> Changes since v5: https://lore.kernel.org/all/20260328201842.1782806-1-atwellwea@gmail.com/

This is also why I suggested using the above link. The link shows how to
find the old version of the patch, without relying on "In-Reply-To" header.

> - add the separator accounting comment in trace_append_boot_param()
> - keep the existing trace_trigger= temporary buffer and copy each
>   parsed event/trigger pair into boot-time storage instead of tracking
>   a running offset inside that buffer
> 
>  kernel/trace/ftrace.c       | 12 ++++++++----
>  kernel/trace/trace.c        | 30 +++++++++++++++++++++++++++++-
>  kernel/trace/trace.h        |  2 ++
>  kernel/trace/trace_events.c | 24 +++++++++++++++++++++---
>  kernel/trace/trace_kprobe.c |  3 ++-
>  5 files changed, 62 insertions(+), 9 deletions(-)
> 

> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -228,6 +228,33 @@ static int boot_instance_index;
>  static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
>  static int boot_snapshot_index;
>  
> +/*
> + * Repeated boot parameters, including Bootconfig array expansions, need
> + * to stay in the delimiter form that the existing parser consumes.
> + */
> +void __init trace_append_boot_param(char *buf, const char *str, char sep,
> +				    int size)
> +{
> +	int len, needed, str_len;
> +
> +	if (!*str)
> +		return;
> +
> +	len = strlen(buf);
> +	str_len = strlen(str);
> +	needed = len + str_len + 1;

Nit, but it would be nice to have a blank line here.

> +	/* For continuation, account for the separator. */
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
> @@ -329,7 +356,8 @@ static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
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
> index b8f3804586a0..237a0417de1c 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -863,6 +863,8 @@ extern int DYN_FTRACE_TEST_NAME(void);
>  extern int DYN_FTRACE_TEST_NAME2(void);
>  
>  extern void trace_set_ring_buffer_expanded(struct trace_array *tr);
> +void __init trace_append_boot_param(char *buf, const char *str,
> +				    char sep, int size);
>  extern bool tracing_selftest_disabled;
>  
>  #ifdef CONFIG_FTRACE_STARTUP_TEST
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 249d1cba72c0..1c4a4a46169e 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -17,6 +17,7 @@
>  #include <linux/kthread.h>
>  #include <linux/tracefs.h>
>  #include <linux/uaccess.h>
> +#include <linux/memblock.h>
>  #include <linux/module.h>
>  #include <linux/ctype.h>
>  #include <linux/sort.h>
> @@ -3674,7 +3675,7 @@ trace_create_new_event(struct trace_event_call *call,
>  #define MAX_BOOT_TRIGGERS 32
>  
>  static struct boot_triggers {
> -	const char		*event;
> +	char			*event;
>  	char			*trigger;
>  } bootup_triggers[MAX_BOOT_TRIGGERS];
>  
> @@ -3683,6 +3684,7 @@ static int nr_boot_triggers;
>  
>  static __init int setup_trace_triggers(char *str)
>  {
> +	char *event;
>  	char *trigger;
>  	char *buf;
>  	int i;
> @@ -3692,14 +3694,30 @@ static __init int setup_trace_triggers(char *str)
>  	disable_tracing_selftest("running event triggers");
>  
>  	buf = bootup_trigger_buf;
> -	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
> +	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {

Let's not make this so complex.

This function isn't the same as the other functions. It doesn't need to add
separators to the temp buffer. It only needs to append it.


>  		trigger = strsep(&buf, ",");
>  		if (!trigger)
>  			break;
> -		bootup_triggers[i].event = strsep(&trigger, ".");
> +		event = strsep(&trigger, ".");
>  		bootup_triggers[i].trigger = trigger;
>  		if (!bootup_triggers[i].trigger)
>  			break;
> +
> +		/*
> +		 * Keep each parsed trigger outside the temporary setup
> +		 * buffer so repeated trace_trigger= entries do not
> +		 * overwrite earlier ones.
> +		 */
> +		bootup_triggers[i].event =
> +			memblock_alloc_or_panic(strlen(event) + 1,
> +						SMP_CACHE_BYTES);
> +		strscpy(bootup_triggers[i].event, event,
> +			strlen(event) + 1);
> +		bootup_triggers[i].trigger =
> +			memblock_alloc_or_panic(strlen(trigger) + 1,
> +						SMP_CACHE_BYTES);
> +		strscpy(bootup_triggers[i].trigger, trigger,
> +			strlen(trigger) + 1);
>  	}

I believe all you need for the boot triggers is this:

  (Not even compiled tested)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9928da636c9d..7754a8adb58a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3677,20 +3677,24 @@ static struct boot_triggers {
 } bootup_triggers[MAX_BOOT_TRIGGERS];
 
 static char bootup_trigger_buf[COMMAND_LINE_SIZE];
+static int boot_trigger_buf_len;
 static int nr_boot_triggers;
 
 static __init int setup_trace_triggers(char *str)
 {
 	char *trigger;
 	char *buf;
+	int len = boot_trigger_buf_len;
 	int i;
 
-	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	strscpy(bootup_trigger_buf + len , str, COMMAND_LINE_SIZE - len);
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event triggers");
 
-	buf = bootup_trigger_buf;
-	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
+	buf = bootup_trigger_buf + len;
+	boot_trigger_buf_len += strlen(buf);
+
+	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
 		trigger = strsep(&buf, ",");
 		if (!trigger)
 			break;
