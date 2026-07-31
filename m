Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312524A078;
	Fri, 31 Jul 2026 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457772; cv=none; b=B65QFmu31eFsbresKw3lPL4Y+Xh6SODrJcPCRtLntczAoKOzgeWI6OdYkBJUuFnjPl8wMFWsrCiDIXRFB/VsOC+LP4KCs2QNGMKL4D+i8Q+tRUTUQ+SB4kGXUjAtFXkBMjfo1wBm3xPbxJI6tCWmeAekV7YwFFSHdY2FkDFTHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457772; c=relaxed/simple;
	bh=B3LafZ6nB3hzwsfFLYT18Ze8bFl17M7wkhoTtoGzt6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lHq19CljOWIpA5BLgSo69qsI0a2ADENB8XU2v4A3dumhpuhbQ/fvE+ahZx2/jm6MRYjAozdOFIBhj0JygDS9bZuJ9SY3cMf4yMrVClLPOZd4z/DIlaTxJs3arafN5UTG45l7ZmFdPx+jTLdk9cykmOaajWvYSiixRSh4xJG0jJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuPyTuhG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuPyTuhG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00231F00A3D;
	Fri, 31 Jul 2026 00:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785457771;
	bh=4fpw1PD+IoN4Qal6qIlfTJ2apL9VtE2N0LOR8LSCuzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NuPyTuhGkd7QP1oZdO1yDsGTp7CJ9bEZxS9eRlj5saDGNHpT7qRU4OZ4JQ4uAgRLT
	 xi/cQab9NLitDtdBE5/ppMGG4mSv3rfe/281pvYwaWfgLqAjYJfBes/tSCMI04Cgji
	 LrGlf0xcpLr1jiijv+NYFJPQ4IfH1w5tSS9pn5RS3Ox+WTNFSs65xzjOvqB0PHviTg
	 TEDl3BC9nkzI7MrV8zXzTemAmg1dzUbHAWK6Pcgc/0dl2AnH4vIIuDLF04HTmFMy0l
	 LzxRCNGMziGWYwSFPERUzjkDJb4gsrXWigTfnngRVn0ED4rExWxn2MgYJoriga191A
	 xS32m69FyyxZw==
Date: Fri, 31 Jul 2026 09:29:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Fix subbuf_ids memory leak in
 rb_allocate_cpu_buffer() error path
Message-Id: <20260731092927.6952161ecdd43fa6b51f2e42@kernel.org>
In-Reply-To: <amsHlMCNHV9JWA0l@google.com>
References: <178539491147.180138.1181424244288838594.stgit@devnote2>
	<amsHlMCNHV9JWA0l@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 09:13:08 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Thu, Jul 30, 2026 at 04:01:51PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In rb_allocate_cpu_buffer(), cpu_buffer->subbuf_ids is allocated using
> > kcalloc() when buffer->remote is non-NULL. If a subsequent page allocation
> > fails (e.g., ring_buffer_desc_page() returns NULL or rb_allocate_pages()
> > fails), execution jumps to fail_free_reader.
> > 
> > While __free(kfree) automatically frees the outer cpu_buffer structure
> > at scope exit, kfree(cpu_buffer) does not recursively free nested heap
> > pointers such as cpu_buffer->subbuf_ids, resulting in a memory leak.
> > 
> > Fix this by explicitly freeing cpu_buffer->subbuf_ids in the
> > fail_free_reader error unwinding path when cpu_buffer->remote is set.
> > 
> > Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> > Assisted-by: Antigravity:gemini-3.6-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/ring_buffer.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 78d3875a47a5..03f6baf6a5f5 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2599,6 +2599,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> >  	return_ptr(cpu_buffer);
> >  
> >   fail_free_reader:
> > +	if (cpu_buffer->remote)
> > +		kfree(cpu_buffer->subbuf_ids);
> 
> alloc_cpu_buffer() being kzalloc, I suppose here we could just unconditionally
> call kfree(cpu_buffer->subbuf_ids) ?
> 

Ah, indeed. Thanks for the comment!

> >  	free_buffer_page(cpu_buffer->reader_page);
> >  
> >  	return NULL;
> > 
> 
> -- 
> Vincent


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
