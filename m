Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195327A477;
	Mon, 30 Mar 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888919; cv=none; b=SK9CczLotLIACCr4JGbOlcz564ci1H4dQxaCsiH5FYuVdXjroDcCu4fxYrOk5a7I+u1XlXDL276+VUqr9ECF6KmwdZNNUrVzRJit9ZZHqoMPcA6MT1xsMjaBzGxAD9QuNv7dmc75qombsSl8VsEK47AAZwfPikb4UEIehIpwzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888919; c=relaxed/simple;
	bh=alS1ZH61rrzKojmf73Og9NJrQfq0d1hwfnodBaGAHtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRrKcv02GaIfiOmIO+uQmIRwl1yHZjKAVW8FSSoGLLIsiTXnNlLd0NXrs0pJoLwwTwWFYm0FqQOwQnK+CgvooG87RjUbwuh86W3rMBLUyzNTVJS6qYQcNVvA1vtZFXPI9gyxKne7xkPGteqvlS3fUWXybjLliaGybohSV+jzpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C52E11A04C9;
	Mon, 30 Mar 2026 16:41:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 0971518;
	Mon, 30 Mar 2026 16:41:53 +0000 (UTC)
Date: Mon, 30 Mar 2026 12:42:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tracing: Preserve repeated boot-time tracing
 parameters
Message-ID: <20260330124249.5259a89d@gandalf.local.home>
In-Reply-To: <20260330123743.5cd30e56@gandalf.local.home>
References: <20260328201842.1782806-1-atwellwea@gmail.com>
	<20260329184254.1813273-1-atwellwea@gmail.com>
	<20260330104322.7403c660@gandalf.local.home>
	<20260330123743.5cd30e56@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: obkk55niuiruhe68xyqgfzzpuoywfsrr
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 0971518
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+l9l2NheDFavRFdggvB4rrc1UaK/KNJPE=
X-HE-Tag: 1774888913-736318
X-HE-Meta: U2FsdGVkX18nBBGHecDJlkcGtAA3GzpPv76scUpT6aQjW5pFRAP6qfQP0PyTq++dvmVFgstJsdrRVNYB5eNPZEbYh/1nekEeqMOy7iY1cJPa7L7Fq3ZWY5HpAxO5TNze9ioM+Dm6mhVuuWy9OjkU9s/zTVLBjGLAQDjAb6MDFzbO9J4XGbopTW/AHErAUMrg/XXEtuhNqRkkr24/T/RasKUFy8X0+RtUQRkZjHP9x/y8SwsnQKzaYeeKz1Qd+EMcpEYLvVWA6zVwnpCLXJTWtSLbtRH/27jWX1koxyW1xpulX3Rw5EYu5SOyFPy1HAXnln0PSLh2cbhj1LIxzUY5cgyWEENMibT3Attv28gvKxBUQRkShzyks81PlpUv3Q8q0NZdem4ODnXwk7dyoEOIgeYfhB7UW5UY

On Mon, 30 Mar 2026 12:37:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Mar 2026 10:43:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 9928da636c9d..7754a8adb58a 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -3677,20 +3677,24 @@ static struct boot_triggers {
> >  } bootup_triggers[MAX_BOOT_TRIGGERS];
> >  
> >  static char bootup_trigger_buf[COMMAND_LINE_SIZE];
> > +static int boot_trigger_buf_len;
> >  static int nr_boot_triggers;
> >  
> >  static __init int setup_trace_triggers(char *str)
> >  {
> >  	char *trigger;
> >  	char *buf;
> > +	int len = boot_trigger_buf_len;
> >  	int i;
> >  
> > -	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> > +	strscpy(bootup_trigger_buf + len , str, COMMAND_LINE_SIZE - len);
> >  	trace_set_ring_buffer_expanded(NULL);
> >  	disable_tracing_selftest("running event triggers");
> >  
> > -	buf = bootup_trigger_buf;
> > -	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
> > +	buf = bootup_trigger_buf + len;
> > +	boot_trigger_buf_len += strlen(buf);  
> 
> The above needs to skip the '\0' too:
> 
> 	boot_trigger_buf_len += strlen(buf) + 1;
> 

And since this option is different from the rest, lets make it a separate patch.

-- Steve

> 
> > +
> > +	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
> >  		trigger = strsep(&buf, ",");
> >  		if (!trigger)
> >  			break;  
> 

