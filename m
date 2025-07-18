Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784B2DECAA;
	Fri, 18 Jul 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861361; cv=none; b=lBu8TORQyBYs/jESdeG89yNNmmnlesgHAPY5TKkWWOcEbnLMqK7T4Z8cMAMA5v4IxJXUZGr0fVVjVB9S8Kl9aB4CgOjitHKpeHoO1c/IMI5P/riji0W2a6Pp1bcID2d2xBgrcY7FIsDJsCdM6PUJoGpL+zUuJ2wgXBq7z5+Fkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861361; c=relaxed/simple;
	bh=lD/JCFakuUElJ2BVsQtIXUmGdNp8eUEkV6kqDpFooBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EobRFyD7uD2llEM1kA9QGdWfK9og1R+011luBzfBLt5WlTejGriwFEXGIMrstMUPYoeyMguFKukB+EbLj258TZpqELbKUrKqnOuioauWUwFreZoIYtiMyxM0Acndgv4RIEVae8adxqtui95u9RGQxXsk8jE1YHNKoBJlwv8Kcb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 944B710A7F7;
	Fri, 18 Jul 2025 17:55:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id F149120028;
	Fri, 18 Jul 2025 17:55:50 +0000 (UTC)
Date: Fri, 18 Jul 2025 13:55:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] tracing: eprobe-event: Allocate string buffers from
 heap
Message-ID: <20250718135549.387b98ab@batman.local.home>
In-Reply-To: <175283848063.343578.12113784863348416166.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283848063.343578.12113784863348416166.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i8u5ds8qb5u4pf5tgohhzrpy13ih7shn
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: F149120028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+f1kfNTgW9AW8Wz5tLPVZedW1+1de5Afc=
X-HE-Tag: 1752861350-668683
X-HE-Meta: U2FsdGVkX1/WE/6urmYczhVqGk1BcfM05fcfC7gS0K13bUfG7FSSqWXmitBKiTX0OlZvMJnjrnxu44gjFtXVUUKJuD+OYRmtsOslXRQ7jpGeDNpvNqW/1Ze5w9pY8Oi0IBr/qP2NdVSqnNS7qMp2QWojM+1oD19jkH9NWybVRVhSdbl0LUKjTHIeDqOFqvsOkzdW7afMffS12HJDtDucRF2mNRzlnauW3fuo8rA5HafUy6lD2aP2NE5lGtyK5mC+5dB9AlCpTTUB990PyYG87QdyS45Gdmm/ep8yOD9p9FcEpXBRsb/iMioxOlVbdEV1dJWudWG+55Ugurk8Wl3+jGWwhsneJFg5tHtiWbYiv2clltTQmm85Eg==

On Fri, 18 Jul 2025 20:34:40 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allocate temporary string buffers for parsing eprobe-events
> from heap instead of stack.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_eprobe.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 1e18a8619b40..75d8208cd859 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -9,6 +9,7 @@
>   * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
>   *
>   */
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/ftrace.h>
> @@ -871,10 +872,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
>  	const char *sys_event = NULL, *sys_name = NULL;
>  	struct trace_event_call *event_call;
> +	char *buf1 __free(kfree) = NULL;
> +	char *buf2 __free(kfree) = NULL;
> +	char *gbuf __free(kfree) = NULL;
>  	struct trace_eprobe *ep = NULL;
> -	char buf1[MAX_EVENT_NAME_LEN];
> -	char buf2[MAX_EVENT_NAME_LEN];
> -	char gbuf[MAX_EVENT_NAME_LEN];
>  	int ret = 0, filter_idx = 0;
>  	int i, filter_cnt;
>  
> @@ -885,6 +886,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  
>  	event = strchr(&argv[0][1], ':');
>  	if (event) {
> +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +		if (!gbuf) {
> +			ret = -ENOMEM;
> +			goto parse_error;
> +		}
>  		event++;
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
>  						  event - argv[0]);
> @@ -894,6 +900,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  
>  	trace_probe_log_set_index(1);
>  	sys_event = argv[1];
> +
> +	buf2 = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +	if (!buf2) {
> +		ret = -ENOMEM;
> +		goto parse_error;
> +	}
>  	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
>  	if (ret || !sys_event || !sys_name) {
>  		trace_probe_log_err(0, NO_EVENT_INFO);
> @@ -901,7 +913,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	}
>  
>  	if (!event) {
> -		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
> +		buf1 = kstrdup(sys_event, GFP_KERNEL);
> +		if (!buf1) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}

I kinda hate all these updating of "ret" before jumping to error.

>  		event = buf1;
>  	}
>  

What about this:

-- Steve

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 916555f0de81..48cc1079a1dd 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
  *
  */
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
@@ -869,10 +870,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
 	const char *sys_event = NULL, *sys_name = NULL;
 	struct trace_event_call *event_call;
+	char *buf1 __free(kfree) = NULL;
+	char *buf2 __free(kfree) = NULL;
+	char *gbuf __free(kfree) = NULL;
 	struct trace_eprobe *ep = NULL;
-	char buf1[MAX_EVENT_NAME_LEN];
-	char buf2[MAX_EVENT_NAME_LEN];
-	char gbuf[MAX_EVENT_NAME_LEN];
 	int ret = 0, filter_idx = 0;
 	int i, filter_cnt;
 
@@ -883,6 +884,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	event = strchr(&argv[0][1], ':');
 	if (event) {
+		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+		if (!gbuf)
+			goto mem_error;
 		event++;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
@@ -892,6 +896,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
+
+	buf2 = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
+	if (!buf2)
+		goto mem_error;
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
 	if (ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
@@ -899,7 +907,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	}
 
 	if (!event) {
-		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
+		buf1 = kstrdup(sys_event, GFP_KERNEL);
+		if (!buf1)
+			goto mem_error;
 		event = buf1;
 	}
 
@@ -972,6 +982,9 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	trace_probe_log_clear();
 	return ret;
 
+mem_error:
+	ret = -ENOMEM;
+	goto error;
 parse_error:
 	ret = -EINVAL;
 error:
