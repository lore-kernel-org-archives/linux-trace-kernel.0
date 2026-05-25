Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B451DB95E;
	Mon, 25 May 2026 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687594; cv=none; b=AMCaTXMJzaY5w7IZNNvSuNoq25ReByQ3soKSx6YXWNR7n7JVrsrfmkJ3VLyURj/dD4gydsdpAOEQYyoV2wVhp9T1cYA5bmnypBeoMFhwMaSoidFz92rX279qwFGIooN6e5LbWWdBMA76dEGTKftEn27DDWkVR57QT8NxUBqstbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687594; c=relaxed/simple;
	bh=BoqwVIwbfKG6qRBUp1zat90ce/lbL2YJQuhRJf89MYI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RDQPK18gAefg6twMSkj5wshQClAUcfWX3v9UocKjjwUpjtVTfPJCcuWg/mopv7yL6p27caFw8FcjOnjWds1oblSBH1bWU8AwOwqdA/xdJ62n/zkpHfSdT/7Puq03Cn++UDuL0nVIFKHRT8FiIZHtVNdheflw6O/4LDEZoNjqUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVTskoiu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVTskoiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B0A1F000E9;
	Mon, 25 May 2026 05:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779687592;
	bh=MZaQM1CIJb5tYUUWFqF9iRavZPbaMyVkrb1OWsctPgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gVTskoiudeMEtTDZow+oGtOHkkXNFHc3FTd1Y38WmGR+97pExD9MpScPG1mRlr1jP
	 Padw9L0KJKZMC89hBqBRVexRzCSuu3i8KSvenHJflbaNprqVQqCjuZcdkYP69ysl4P
	 AN70DWTVPKWC4bzW9kbrevY1GfFU9nI0WCC2rwWaWZp89zcJCTd8lkSO/GD4tkaPVC
	 nVsBEuZtiB9l+5dP5YyUTJJtkMhXe3xnQISF15pjW0RLYxK2NehB2mNpIZtvz7AOJK
	 6AB9owBfqIhSkpojc8eyweAk3jdhej9H4cfWKGeskCEYrLEm2IdfPpXDw2Gutrc/59
	 slHM1jvRCZrkQ==
Date: Mon, 25 May 2026 14:39:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-Id: <20260525143947.ea1c0a7b29146d22faa5feda@kernel.org>
In-Reply-To: <8f8d0cd380f40b84557304d110f38ecefc994a35.camel@surriel.com>
References: <20260513161916.04151502@fangorn>
	<20260520164117.528d02fd@gandalf.local.home>
	<8f8d0cd380f40b84557304d110f38ecefc994a35.camel@surriel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 16:39:41 -0400
Rik van Riel <riel@surriel.com> wrote:

> On Wed, 2026-05-20 at 16:41 -0400, Steven Rostedt wrote:
> > 
> > Rik,
> > 
> > Can you reply to Sashiko here?
> > 
> > The below comes from Sashiko:
> > https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260513161916.04151502%40fangorn
> > 
> > Thanks,
> > 
> > -- Steve
> > 
> > 
> > > commit f90ac36f39b79a19c015522bb1caf7ef903caf02
> > > Author: Rik van Riel <riel@surriel.com>
> > > perf/ftrace: Fix WARNING in __unregister_ftrace_function
> > > This commit attempts to fix a WARN_ON triggered during
> > > perf_event_alloc() error
> > > cleanup by checking FTRACE_OPS_FL_ENABLED before unregistering the
> > > ftrace
> > > function. The warning occurs because the ftrace_ops registration
> > > failed or was
> > > torn down by perf_try_init_event() earlier, but the event->destroy
> > > callback is
> > > executed again during the error path.
> > > > diff --git a/kernel/trace/trace_event_perf.c
> > > > b/kernel/trace/trace_event_perf.c
> > > > index 61e3a2620fa3c..8d64f17135e8f 100644
> > > > --- a/kernel/trace/trace_event_perf.c
> > > > +++ b/kernel/trace/trace_event_perf.c
> > > > @@ -495,7 +495,11 @@ static int
> > > > perf_ftrace_function_register(struct perf_event *event)
> > > >  static int perf_ftrace_function_unregister(struct perf_event
> > > > *event)
> > > >  {
> > > >  	struct ftrace_ops *ops = &event->ftrace_ops;
> > > > -	int ret = unregister_ftrace_function(ops);
> > > > +	int ret = 0;
> > > > +
> > > > +	if (ops->flags & FTRACE_OPS_FL_ENABLED)
> > > > +		ret = unregister_ftrace_function(ops);
> > > > +
> > > >  	ftrace_free_filter(ops);
> > 
> > > Does calling ftrace_free_filter() unconditionally here mask a
> > > double-teardown
> > > regression while leaving the underlying double-free active?
> 
> I don't see how calling ftrace_free_filter() twice would
> call issues, given that it sets the ->*_hash values to
> EMPTY_HASH:
> 
> void ftrace_free_filter(struct ftrace_ops *ops)
> {
>         ftrace_ops_init(ops);
>         if (WARN_ON(ops->flags & FTRACE_OPS_FL_ENABLED))
>                 return;
>         free_ftrace_hash(ops->func_hash->filter_hash);
>         free_ftrace_hash(ops->func_hash->notrace_hash);
>         ops->func_hash->filter_hash = EMPTY_HASH;
>         ops->func_hash->notrace_hash = EMPTY_HASH;
> }
> 
> void free_ftrace_hash(struct ftrace_hash *hash)
> {
>         if (!hash || hash == EMPTY_HASH)
>                 return;
> ..
> 

Yeah, confirmed.

> 
> > > In perf_try_init_event(), if a PMU event_init() succeeds but a
> > > subsequent
> > > capability check fails, it explicitly calls event->destroy(event)
> > > to roll back:
> > > kernel/events/core.c:perf_try_init_event() {
> > >     ...
> > > 		if (ret && event->destroy)
> > > 			event->destroy(event);
> > >     ...
> > > }
> 
> The error handling there all seems to "goto err_destroy"
> 
> err_destroy:
>         if (event->destroy) {
>                 event->destroy(event);
>                 event->destroy = NULL;
>         }
> 
> 
> > > However, it does not set event->destroy to NULL.
> 
> ... but it does?
> 
> I am not sure what code Sashiko is looking at,
> but it does not look like the code I just pulled.

Indeed.

> 
> Is there a different tree I should be looking at
> than upstream Linus?

You can see the baseline info if you expand the collapsed triangle.
Anyway, it said:

linux-trace/HEAD (70575e77839f4c5337ce2653b39b86bb365a870e)

So that is linux-trace/master.

commit 70575e77839f4c5337ce2653b39b86bb365a870e (linux-trace/master)
Merge: 7bc6e90d7aa4 a43ae8057cc1
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Sep 30 09:41:34 2022 -0700

    Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost


Hmm, this is too old. And linux-trace/master is not used anymore.

Reported to Sashiko.

https://github.com/sashiko-dev/sashiko/issues/218

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
