Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924925F7BF;
	Fri,  9 May 2025 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746835071; cv=none; b=uAInjmZfO4ANJBsTF62I4FGuU2WNbJmbwKYkqgmWXn3Hkn4kypdZK9wutAjP0Gpum4+IiWe7srfJCgyxOaUZTL7RSsXT5f07QilqW49vS7sauKBxs0GCBMm6Q1aXKqM0EfCGzq4wkCB3nkKxGVQhYKZa2F3kcFM7uD6ThAj7qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746835071; c=relaxed/simple;
	bh=z4bdwxQ4iirtZ/jvJ9eNfsPzh7HLffleNgJOXAIIh2I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jOShIMzYUbkpwk88XBPvZvKyfn14HDg271DoZ1BCPbUAUqKqFDsEbahDb/IxeaVzIHFIYh1+7fGS251lS/qjgwG4sfi5h9y98tQtTu6yXUFb8VoKabYOdqppQx6EtM2A2XBxGeg3dOLUyq8+B/ILjVkH7g2xDPDg2G4ac7B3Oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iITW+Awe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iITW+Awe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E8C4CEE4;
	Fri,  9 May 2025 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746835070;
	bh=z4bdwxQ4iirtZ/jvJ9eNfsPzh7HLffleNgJOXAIIh2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iITW+AweHByHjGtEP8JyDrHMmaZpMHJIohWHtBshoxEWsyyDp+AT9A0B1UvQ9OEzx
	 uMxOVY3EMtWi8MAH7eI2fYItYSIYHD1WbUf+FAjFMyyloe/dN2F961uoV5BcVH92gQ
	 DTsTLmhDDO1gi/89yqaW81URrwaEZBxg5nJNbM3DxUBx3WJkugt37aVT8cqVd0Ibq5
	 IJziFr9SsKW99/nbTxynkN1lPmjrifPAtVYzTdTbvGO0kf/4/PP7fBcCbrPDiKI5f7
	 j703su2lMShyhYxS7yf8QA/AUaZu8NbLTUzf1AlWYOJ3I/9pnso7CLM4EP+wyMuFea
	 eeSqxIH3zjMVw==
Date: Sat, 10 May 2025 08:57:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: paulcacheux@gmail.com, Paul Cacheux via B4 Relay
 <devnull+paulcacheux.gmail.com@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing: protect trace_probe_log with mutex
Message-Id: <20250510085744.3dab36f6e314c9e63a673d3e@kernel.org>
In-Reply-To: <20250510074456.805a16872b591e2971a4d221@kernel.org>
References: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
	<20250502-fix-trace-probe-log-race-v2-2-511ecc1521ec@gmail.com>
	<20250510074456.805a16872b591e2971a4d221@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 07:44:56 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 02 May 2025 15:15:53 +0200
> Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:
> 
> > From: Paul Cacheux <paulcacheux@gmail.com>
> > 
> > The shared trace_probe_log variable can be accessed and modified
> > by multiple processes using tracefs at the same time, this new
> > mutex will guarantee it's always in a coherent state.
> 
> Actually that's not happen. For the create part (and currently the
> event_log is used only in the creation), `dyn_event_ops_mutex` is already
> held in create_dyn_event(). Thus, it is already serialized.

Oops, if user writes some commands not directly from dynevent,
(e.g. tracefs/{kprobe_events,uprobe_events} )the mutex is not held.
Hmm, we need to make another patch.

> 
> And even if there are multiple events are done in parallel, this
> is not enough because trace_probe_log::argc/argv can be changed
> before other user finishs to use the log.

But this is still valid. We need to reroute the creation to
dynamic_events.

Thank you,

> 
> Thank you,
> 
> > 
> > There is no guarantee that multiple errors happening at the same
> > time will each have the correct error message, but at least this
> > won't crash.
> > 
> > Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")
> > 
> > Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> > ---
> >  kernel/trace/trace_probe.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 2eeecb6c95eea55502b83af6775b7b6f0cc5ab94..14a7a0b59cd20a8bc43e3e7c653e986081f924c8 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -154,9 +154,11 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
> >  }
> >  
> >  static struct trace_probe_log trace_probe_log;
> > +static DEFINE_MUTEX(trace_probe_log_lock);
> >  
> >  void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
> >  {
> > +	guard(mutex)(&trace_probe_log_lock);
> >  	trace_probe_log.subsystem = subsystem;
> >  	trace_probe_log.argc = argc;
> >  	trace_probe_log.argv = argv;
> > @@ -165,11 +167,13 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
> >  
> >  void trace_probe_log_clear(void)
> >  {
> > +	guard(mutex)(&trace_probe_log_lock);
> >  	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
> >  }
> >  
> >  void trace_probe_log_set_index(int index)
> >  {
> > +	guard(mutex)(&trace_probe_log_lock);
> >  	trace_probe_log.index = index;
> >  }
> >  
> > @@ -178,6 +182,8 @@ void __trace_probe_log_err(int offset, int err_type)
> >  	char *command, *p;
> >  	int i, len = 0, pos = 0;
> >  
> > +	guard(mutex)(&trace_probe_log_lock);
> > +
> >  	if (!trace_probe_log.argv)
> >  		return;
> >  
> > 
> > -- 
> > 2.49.0
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
