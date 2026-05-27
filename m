Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1440C5C5;
	Wed, 27 May 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888876; cv=none; b=GaXbMTHgKBbjywP0Ji0c0mxBeSCkUpktFcz7pVTjEUkRWsN6cmalJ3iK1SC08HL73klfixLcx2FruPzjhAEMHKg7u6c6Ttqa+F83PE5S5rDXP19ihBh2mqqK3Z81WZdsgZV6YcD6ZTDaGmjUP40GK4jayvPEvj+/V1/tfK6jtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888876; c=relaxed/simple;
	bh=A8H6mcWqMRxZXb7y4hgXEo3gESCDWXbn7NtindldSy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAAzYU2wk5FiNhZzgVUkz4110juJ+4FxOFNziaxZNYC13vlKaduOIKov57+ucx0MigBVLvD4nYpLEu8R8j1fZxLJY3CJ3Ck1qZzuLMo76NljnXG6ehVih8YNK/V7mLatayqY1j1HEzQl6DrAo2ClLYnRMyOs3yD0cBhZv6YBBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWIKGpNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWIKGpNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD27A1F000E9;
	Wed, 27 May 2026 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888874;
	bh=ICIvDYiSDxF7sUI8l3kp9jD9Pcv09PF8mTbl0XQZ77s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iWIKGpNS94zUOhQDQ4cLQhpNtzQXJ/w842/XNdUP4KmvVMwio4osuaw+OsfwnTLVZ
	 x1Y6FjNs3OX2dm5cd8QwsHUYDTQSDCMlatDnNVXyd87qgjbI+PYhcqxh4wxcOFsdaE
	 F81EvIDyhJsdowRajGw6Qd7XfGwTIwgmfdnlOT92NXbWtbx4Voeh36GcbKPlaw+3FL
	 51PMembRfLOi3V3Jk2s7k3IIY1I7xdPeBwV9RoydJNH76OuCJfupMQ0pd6RFZsguZX
	 2aPtnBktkd5+xr6hKRL/Z5dx5a6JHmYBZ5E5b/eY06PzPEr++Hul2JJdrfQEKjHELx
	 jAYhFJyoUT1RQ==
Date: Wed, 27 May 2026 09:35:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 8/9] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-ID: <20260527093507.00ac35d8@gandalf.local.home>
In-Reply-To: <20260527124721.d05102c2f45e6c5bb5fbe476@kernel.org>
References: <20260522170857.263969486@kernel.org>
	<20260522171052.006276604@kernel.org>
	<20260526140609.28faf45d9d347e5d748e7cf1@kernel.org>
	<20260526134116.11e1db99@gandalf.local.home>
	<20260527124721.d05102c2f45e6c5bb5fbe476@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 12:47:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yeah, for the persistent ring buffer, it does not happen.
> But there seems RB_MISSED_EVENTS bit can be cleared in
> "else" path (after applying 1-8 patches)?

Note, *only* the persistent ring buffer adds RB_MISSED_EVENTS to the pages
in the write buffer. In the normal buffer, these bits are only set by this
function. That is, they would not be set from the swap of pages.

> 
> ----------
> 	if (read || (len < (commit - read)) ||
> 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> 	    force_memcpy) { // <-- persistent ring buffer sets force_memcpy = true.
> [...]
> 	} else {
> 		/* update the entry counter */
> [...]
> 		if (!missed_events && rb_data_page_commit(dpage) & RB_MISSED_EVENTS)
> 			missed_events = -1;	
> 			//^-- we check RB_MISSED_EVENTS bit on @dpage->commit and set missed_events = -1.
> 
> 		/*
> 		 * Use the real_end for the data size,
> 		 * This gives us a chance to store the lost events
> 		 * on the page.
> 		 */
> 		if (reader->real_end)
> 			local_set(&dpage->commit, reader->real_end);
>                         // ^- only if @reader->real_end, RB_MISSED_EVENTS bit is dropped.

Because this isn't a persistent ring buffer (if it was, as you noted,
force_memcpy would be true and we wouldn't enter the else path), the
RB_MISSED_EVENTS bit in the commit would never be set here. It is *only* set
by the verifier of the persistent ring buffer logic.

> 	}
> 
> 	cpu_buffer->lost_events = 0;
> 
> 	commit = rb_data_page_commit(dpage);
> 	/*
> 	 * Set a flag in the commit field if we lost events
> 	 */
> 	if (missed_events) {
> 		/*
> 		 * If there is room at the end of the page to save the
> 		 * missed events, then record it there.
> 		 */
> 		if (missed_events > 0 &&
> 		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
> 			memcpy(&dpage->data[commit], &missed_events,
> 			       sizeof(missed_events));
> 			local_add(RB_MISSED_STORED, &dpage->commit);
> 			commit += sizeof(missed_events);
> 		}
> 		local_add(RB_MISSED_EVENTS, &dpage->commit); // <-- @dpage->commit is updated.
> 	}

And this is the first place it would get set.

But yeah, it is very confusing and needs better comments.

Thanks,

-- Steve
