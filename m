Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088C43E4AE;
	Tue, 10 Mar 2026 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137485; cv=none; b=jIxsxfTFGrbwSukErJK6wph1h9d5FY3XCxJYdisIvfShvpWqx37XLtLEompGFG7MiAWZJHYuKcygcN0IHeBe3a6OEuMnIS4wDqjEoKOWKR0q+75842Y122/VkcNFTCYKh+smj/yXjDwwQF3Zi25AajzQmgx3BCI00M1ldt8dLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137485; c=relaxed/simple;
	bh=jUCxBjsAPDaeezrI/5rCi/CgQaNeXI906tx6dw4weeM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ndwy4PV4jnbtL7fLkNaO5YmsPnylH/mhpB5Sgg6qm0bsVqroY+hZLWpT8d2E9dyNERBtipMCu3t8e7wZuCw1dHgx0Bn2LqUWT0INT57W5G6rGJljSWmaa/GSBf8OI8pDhhuwIPQhRez6BMS3a1UYmq7hUTBAtR9tNA0IbeCHjj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msFK2+eF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msFK2+eF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B51BC19423;
	Tue, 10 Mar 2026 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773137485;
	bh=jUCxBjsAPDaeezrI/5rCi/CgQaNeXI906tx6dw4weeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=msFK2+eFRn8Dk1fTXaRBM2IgKQGXuinC1O7CUBsZlPl9EJAxNuHIdIuH5FWGn4LQr
	 Sje48CXkamt410uGqpBBtY0N1YGLf5vtqKYJ9XgVLUSZRFfkCdrpOYl+H//FWGWulJ
	 AkQ0jVoNsYtInExL76dkbmg17UglW/6UW0yLza8aZvLuZ9af30EMK1PDHb6M1AS0gA
	 joCcPpgRxluh96wst5OCye/aIwodyzlWNRP6I9MilHHH3LLZVB/aO3gd9gwrZxpKmT
	 0YwA9cF6ChOz8LFBSFArrQfV/XD+JlYd1Tstaw/wRUYM3JHIaCDMM7+wjoEuJ5iWwY
	 rZzO5BGpqW16g==
Date: Tue, 10 Mar 2026 19:11:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] ring-buffer: Handle RB_MISSED_* flags on commit
 field correctly
Message-Id: <20260310191122.f9666707b8fdb4f2c4b3393e@kernel.org>
In-Reply-To: <20260306095935.5d155964@gandalf.local.home>
References: <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
	<177211312362.419230.15156461178245984273.stgit@mhiramat.tok.corp.google.com>
	<20260305130348.3266e4c9@gandalf.local.home>
	<20260306174609.d387b67d04e05328ea262fba@kernel.org>
	<20260306095935.5d155964@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 09:59:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 6 Mar 2026 17:46:09 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 5 Mar 2026 13:03:48 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 26 Feb 2026 22:38:43 +0900
> > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > >   
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > Since the MSBs of rb_data_page::commit are used for storing
> > > > RB_MISSED_EVENTS and RB_MISSED_STORED, we need to mask out those bits
> > > > when it is used for finding the size of data pages.
> > > > 
> > > > Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
> > > > Fixes: 5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")
> > > > Cc: stable@vger.kernel.org  
> > > 
> > > This is unneeded for the current way things work.
> > > 
> > > The missed events flags are added when a page is read, so the commits in
> > > the write buffer should never have those flags set. If they did, the ring
> > > buffer code itself would break.  
> > 
> > Hmm, but commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent 
> > ring buffer on reboot") may change it. Maybe we should treat it while
> > unwinding it?
> 
> Might change what?

So the above commit removes clearing (resetting) meta->commit after read the
page (thus the missed events flags will be there). But those pages will be
recovered (rewound) after reboot. Thus the validation runs on those pages
(and detect invalid pages)

> 
> > 
> > > 
> > > But as patch 3 is adding a flag, you should likely merge this and patch 3
> > > together, as the only way that flag would get set is if the validator set
> > > it on a previous boot. And then this would be needed for subsequent boots
> > > that did not reset the buffer.  
> > 
> > It is OK to combine these 2 patches. But my question is that when the flag
> > must be checked and when it must be ignored. Since the flags are encoded
> > to commit, if that is used for limiting or indexing inside the page,
> > we must mask the flag or check the max size to avoid accessing outside of
> > the subpage.
> > 
> > > 
> > > Hmm, I don't think we even need to do that! Because if it is set, it would
> > > simply warn again that a page is invalid, and I think we *want* that! As it
> > > would preserve that pages were invalid and not be cleared with a simple
> > > reboot.  
> > 
> > OK, then I don't mark it, but just invalidate the subpage.
> 
> No, I mean you can mark it, but then just have the validator skip it.
> Something like:

This may not work because RB_MISSED_EVENTS are added, instead of set.
So the commit will be `original_commit + RB_MISSED_EVENTS`.

Anyway, in v8, any of invalid (out of range) commit value is treated
as corrupted in rb_validate_buffer().

Thanks,

> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 156ed19fb569..c98ab86cf384 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1950,6 +1951,10 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	rb_dec_page(&head_page);
>  	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
>  
> +		/* Skip if this buffer was flagged as bad before */
> +		if (local_read(&head_page->page->commit) ==  RB_MISSED_EVENTS)
> +			continue;
> +
>  		/* Rewind until tail (writer) page. */
>  		if (head_page == cpu_buffer->tail_page)
>  			break;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
