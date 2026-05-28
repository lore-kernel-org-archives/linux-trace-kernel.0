Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EF44D6BD;
	Thu, 28 May 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981311; cv=none; b=h8eAwWw4zSqDqcbN6KODbYjhQW8R6LYHQQR46KeA/AazpkuBifk6KciVDzPYngmWFLr06l5p4rOTr5c+y7W/ukqYceOwBqTjgo0EHp5XqJfriwCRn6yQ67qSiPALZVY8bbZubxZdaCVXA8cGwqvEOQ0esXGlBylnZHkK9KcZXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981311; c=relaxed/simple;
	bh=1jJdeoj1VNGQbPKk2FDfXElGc+1RQFmiRoq+ed77r9U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JhzES7jhpbvhuEUYUO3XVxftuNuedIleu6hManohZ6As6CMr/XM9gIbGEtQCOcCfZJJqA1bY/DGr4YWmH3ZqOvTtU3Etuor2+lPoXfDI6nSfz2vSqWPjc8n1EJBNoZmQ3Uuw5qp9bYPMiuGY1QqVt/HZQU0rxqThy7MBjV1yww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0jRTBOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0jRTBOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584631F000E9;
	Thu, 28 May 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981309;
	bh=IIwOlTvjfHMTeRT5JPdmAJR6btvI5WEod19iA0dmXQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h0jRTBOT32U8/OETOyfUiPGAci2BlrSdTHJOEuX+fXxOtvnrJ6Apc6Nr5S53B/iif
	 Hhbn4nqnGDjbS3zjFI7oQ0Cu0jZZIqVCYNE8wUmNaSpPM0Tv+johnmKQMVPOXgsAS5
	 h/4ygiseLZPUBuehkrm2jwWgZBip2Imu5OBswnuYuCKJ76oD5THf2hzf7UWzrT0LZM
	 Ot742utl7Ub3FY8zm9ySxU5cViF5VoL5nwl5IZBl99G2kphfydh9/F7t9r1dV7Uy3V
	 kq7g/7tTIrfXJ8vq5XTeJ7UtLh+H7uxn8AMAMaJViyAD4WWjd1ZGR4Un22qV59AS+G
	 nPQJYL6y+Eo7w==
Date: Fri, 29 May 2026 00:15:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 8/9] ring-buffer: Show persistent buffer dropped
 events in trace file
Message-Id: <20260529001500.14178455a046a5cbc6180861@kernel.org>
In-Reply-To: <20260527093507.00ac35d8@gandalf.local.home>
References: <20260522170857.263969486@kernel.org>
	<20260522171052.006276604@kernel.org>
	<20260526140609.28faf45d9d347e5d748e7cf1@kernel.org>
	<20260526134116.11e1db99@gandalf.local.home>
	<20260527124721.d05102c2f45e6c5bb5fbe476@kernel.org>
	<20260527093507.00ac35d8@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 09:35:07 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Wed, 27 May 2026 12:47:21 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Yeah, for the persistent ring buffer, it does not happen.
> > But there seems RB_MISSED_EVENTS bit can be cleared in
> > "else" path (after applying 1-8 patches)?
> 
> Note, *only* the persistent ring buffer adds RB_MISSED_EVENTS to the pages
> in the write buffer. In the normal buffer, these bits are only set by this
> function. That is, they would not be set from the swap of pages.
> 

Ah, OK. For normal ring buffers, it is only set by reader.

> > 
> > ----------
> > 	if (read || (len < (commit - read)) ||
> > 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> > 	    force_memcpy) { // <-- persistent ring buffer sets force_memcpy = true.
> > [...]
> > 	} else {
> > 		/* update the entry counter */
> > [...]
> > 		if (!missed_events && rb_data_page_commit(dpage) & RB_MISSED_EVENTS)
> > 			missed_events = -1;	
> > 			//^-- we check RB_MISSED_EVENTS bit on @dpage->commit and set missed_events = -1.
> > 
> > 		/*
> > 		 * Use the real_end for the data size,
> > 		 * This gives us a chance to store the lost events
> > 		 * on the page.
> > 		 */
> > 		if (reader->real_end)
> > 			local_set(&dpage->commit, reader->real_end);
> >                         // ^- only if @reader->real_end, RB_MISSED_EVENTS bit is dropped.
> 
> Because this isn't a persistent ring buffer (if it was, as you noted,
> force_memcpy would be true and we wouldn't enter the else path), the
> RB_MISSED_EVENTS bit in the commit would never be set here. It is *only* set
> by the verifier of the persistent ring buffer logic.

OK, I got it.

Thanks for confirmation!

> 
> > 	}
> > 
> > 	cpu_buffer->lost_events = 0;
> > 
> > 	commit = rb_data_page_commit(dpage);
> > 	/*
> > 	 * Set a flag in the commit field if we lost events
> > 	 */
> > 	if (missed_events) {
> > 		/*
> > 		 * If there is room at the end of the page to save the
> > 		 * missed events, then record it there.
> > 		 */
> > 		if (missed_events > 0 &&
> > 		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
> > 			memcpy(&dpage->data[commit], &missed_events,
> > 			       sizeof(missed_events));
> > 			local_add(RB_MISSED_STORED, &dpage->commit);
> > 			commit += sizeof(missed_events);
> > 		}
> > 		local_add(RB_MISSED_EVENTS, &dpage->commit); // <-- @dpage->commit is updated.
> > 	}
> 
> And this is the first place it would get set.
> 
> But yeah, it is very confusing and needs better comments.

Yeah, the relationship between the persistent ring buffer (which is mapped)
and the RB_MISSED_EVENTS is a bit unclear.

Thanks, 


> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
