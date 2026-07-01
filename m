Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EA220F49;
	Wed,  1 Jul 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938257; cv=none; b=R5wLKKF1x/0DOOyNKKP872E3rjNDp55TyQCxc9UHdrYHQsYpjovBMgSBfSr+hABomYYqbJQCflKwfgofCd36P+EHRuRkdX8jzdG8zvew1xrPtxA3czR38RETosBED7OizdNuftlh4xQt/oI59tzIcQOmljFLrBDi7iQKnbshqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938257; c=relaxed/simple;
	bh=JFL8+wkZiQTzM586hPLnoDLaXXSr32HQoYX+kzDUde0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbHKhdLr5ZyHmFJ4giwyeqFYD2xRIo4EE8FLMxtyprXdRfheUxCfzTWJvn06mnxe9+ajadlHMBOAaCjeEWmqMdCAGPyGcxOCAP5AHV+ohTeHZ5vai3/NEHziI8oH5e1kZR//9VSrAxx0NcBsPeBZxR6V8+XxuMUH4YSDJV8FHZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6247A404A1;
	Wed,  1 Jul 2026 20:37:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 6727720026;
	Wed,  1 Jul 2026 20:37:32 +0000 (UTC)
Date: Wed, 1 Jul 2026 16:37:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing: Use more common error handling code in
 event_enable_trigger_parse()
Message-ID: <20260701163733.204f06b4@gandalf.local.home>
In-Reply-To: <bddf7714-0b80-4e94-9da8-55a263c270a5@web.de>
References: <bddf7714-0b80-4e94-9da8-55a263c270a5@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6727720026
X-Stat-Signature: rrk1ddx8hip7cyg64pzu1w5aab6rhduj
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX195yE+PqpFqQ0GeW6GmL0hES49nOf/660I=
X-HE-Tag: 1782938252-633865
X-HE-Meta: U2FsdGVkX18yorhT+NY7tFutK/xMUWRWl9StPaeKdCWKseH+DSMUMgodxxMIaioyyB7EFtGvLySXeva/xzyTDkUFLIoI5z9kVj0VcZqd3cdDAe6o/MZz8SgVOe8Rvln0nRlmsz2b0PVGlEEwoKoYhPQpy9jP0FlS2S5bPWym1OCmxvR/VQyt8jbNxZOrqDCAtKePLFGqoqWgiMHD6HrL2RvreBNtCSyPU+3AwkS4awlKHnUgKvqTkod8Tr4xkwqW1ZeG5crroMpxlv/UR8M0/RdHHSYmgOiCF5u5sU1flR84ULvFxoTzykGj8waOVsXEzQ13QSbsiISZ5TGpfpBHXJTRFX/3V/J1

On Tue, 16 Jun 2026 22:33:17 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 16 Jun 2026 22:22:52 +0200
> 
> Use an additional label so that a bit of exception handling can be better
> reused at the end of this function implementation.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  kernel/trace/trace_events_trigger.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 655db2e82513..7e17dd6d5b50 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1789,17 +1789,14 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
>  	enable_data->file = event_enable_file;
>  
>  	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
> -	if (!trigger_data) {
> -		kfree(enable_data);
> -		return ret;
> -	}
> +	if (!trigger_data)
> +		goto out_free_enable_data;
>  
>  	if (remove) {
>  		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
>  		kfree(trigger_data);
> -		kfree(enable_data);
>  		ret = 0;
> -		return ret;
> +		goto out_free_enable_data;
>  	}
>  
>  	/* Up the trigger_data count to make sure nothing frees it on failure */
> @@ -1837,6 +1834,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
>   out_free:
>  	event_trigger_reset_filter(cmd_ops, trigger_data);
>  	event_trigger_free(trigger_data);
> +out_free_enable_data:
>  	kfree(enable_data);

Ug, let's not add more error labels now that we have cleanup code.

Untested, but this would be cleaner:

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..7da096acaf2b 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1739,7 +1739,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       char *glob, char *cmd, char *param_and_filter)
 {
 	struct trace_event_file *event_enable_file;
-	struct enable_trigger_data *enable_data;
+	struct enable_trigger_data *enable_data __free(kfree) = NULL;
 	struct event_trigger_data *trigger_data;
 	struct trace_array *tr = file->tr;
 	char *param, *filter;
@@ -1789,17 +1789,13 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->file = event_enable_file;
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
-	if (!trigger_data) {
-		kfree(enable_data);
+	if (!trigger_data)
 		return ret;
-	}
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
-		kfree(enable_data);
-		ret = 0;
-		return ret;
+		return 0;
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
@@ -1829,6 +1825,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 		goto out_disable;
 
 	event_trigger_free(trigger_data);
+	no_free_ptr(enable_free);
 	return ret;
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
@@ -1837,7 +1834,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
 	event_trigger_free(trigger_data);
-	kfree(enable_data);
 
 	return ret;
 }

-- Steve
