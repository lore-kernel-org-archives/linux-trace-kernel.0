Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84922759C;
	Mon,  9 Mar 2026 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017590; cv=none; b=hpW366XCap7VVyzQu0Dw6vDQkUBZuPt7Ya/sORmmMMGH3eoALkW5CgsSxMUj2vYFNmsKJnySWB9NBFMOl6IeIeAJrkQQHMQYjidqUeJtorDmRYCdjETfBGvks27wWV1wRfwVpesBGMOM/TrlWeoESdkrEp2aK+Y4Wop0yZLSXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017590; c=relaxed/simple;
	bh=sj5DRqp/qleNxgls9lrZob1D0mNNeLZoCFDXs6w1yJk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SVs3D8HNdvRiwFOaIySXPzl0B5I9x/xyuWHHb7GSU9mB/JakYBD6zRvc2pICIOZAuJ1qJhENZZPhmQKeaYYyMVWd87C+FwROFikj9tJHVu0k/+Jwp/aBnYpuLtTHmOG/LHm3++yD7k2Ixh+imn996b26fQ74cysobYf7ceXOFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0dDx3XW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0dDx3XW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DBEC116C6;
	Mon,  9 Mar 2026 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773017589;
	bh=sj5DRqp/qleNxgls9lrZob1D0mNNeLZoCFDXs6w1yJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0dDx3XWipR3G8Ymj6FpInoTO5jCT6VtOOCOX4QYFjL1uDB7DsUpdwaw70U3Lkll3
	 KCBmDnys7R4untS+FXfYl1gxQgSARQbvN9wgfp/qPXwGVCVanE6PNg4jGLUDm/sudZ
	 21UlcQtfemb9grJ6K8VBCY5oAOrzKeFwXC9DnfvaaqW9wbIoReWJ4t9UzdvVACuZKp
	 5UUKhCkme45TcfsH6TeWNruTa49itibo8tzgzguLPx4nTUyBrNA+c9fmCy1n4L7bYE
	 BukedzLQ9x42EEOWRN1cJD6udJ5K+SxBgUi9nVzjGIFZ2NhY3t1hlB8qFtta2KzVcJ
	 l95EsXZdIdt6g==
Date: Mon, 9 Mar 2026 09:53:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-Id: <20260309095307.19a504c6880407bbf36b2cca@kernel.org>
In-Reply-To: <20260309085317.6679cf91151767eff7130cc4@kernel.org>
References: <177289358078.248514.14947007976699929481.stgit@devnote2>
	<177289359843.248514.164858607457269337.stgit@devnote2>
	<20260307102711.50932648@robin>
	<20260309085317.6679cf91151767eff7130cc4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Mar 2026 08:53:17 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat, 7 Mar 2026 10:27:11 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat,  7 Mar 2026 23:26:38 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > >  kernel/trace/ring_buffer.c |   63 +++++++++++++++++++++++---------------------
> > >  1 file changed, 33 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index b6f3ac99834f..8599de5cf59b 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -396,6 +396,12 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
> > >  	return local_read(&bpage->page->commit);
> > >  }
> > >  
> > > +/* Size is determined by what has been committed */
> > > +static __always_inline unsigned int rb_page_size(struct buffer_page *bpage)
> > > +{
> > > +	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
> > > +}
> > > +
> > >  static void free_buffer_page(struct buffer_page *bpage)
> > >  {
> > >  	/* Range pages are not to be freed */
> > > @@ -1819,7 +1825,7 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> > >  
> > >  	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
> > >  
> > > -	/* Is the meta buffers and the subbufs themselves have correct data? */
> > > +	/* Is the meta buffers themselves have correct data? */
> > 
> > I just realized that the origin didn't have correct grammar. But we
> > still check the subbufs, why remove that comment?
> > 
> > The original should have said:
> > 
> > 	/* Do the meta buffers and subbufs have correct data? */
> 
> I just removed the data check from this loop, so I think this should
> focus on checking metadata itself. The data is checked later.

Other checks in the loop are;

- the entries in meta::buffers[] are inside correct range.
- the duplicated entries in the meta::buffers[].

So this only checks the meta::buffers[] (index array) now.

/*
 * Ensure the meta::buffers have correct data. The data in each subbufs are
 * checked later in rb_meta_validate_events().
 */

This will be more clear.

> 
> > 
> > >  	for (i = 0; i < meta->nr_subbufs; i++) {
> > >  		if (meta->buffers[i] < 0 ||
> > >  		    meta->buffers[i] >= meta->nr_subbufs) {
> > > @@ -1827,11 +1833,6 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> > >  			return false;
> > >  		}
> > >  
> > > -		if ((unsigned)local_read(&subbuf->commit) > subbuf_size) {
> > > -			pr_info("Ring buffer boot meta [%d] buffer invalid commit\n", cpu);
> > > -			return false;
> > > -		}
> > 
> > This should still be checked, although it doesn't need to fail the loop
> > but instead continue to the next buffer.
> 
> We already have another check of the data in the loop in
> rb_meta_validate_events() so data corruption should be
> handled there.
> 
> > 
> > Also, I mentioned that if the commit == RB_MISSED_EVENTS, then we know
> > the sub buffer was corrupted and should be skipped.
> 
> Yes, if RB_MISSED_EVENTS bit is set, the commit field is out of range.
> That is checked in rb_validate_buffer().
> 
> > 
> > And honestly, the commit should never be greater than the subbuf_size,
> > even if corrupted. As we are only worried about corruption due to cache
> > not writing out. That should not corrupt the commit size (now we can
> > ignore the flags and use page size instead).
> 
> Hmm, but if the kernel crash and reboot when it sets RB_MISSED_EVENTS,
> we will see the bit is set and commit size is different. 
> 
> Note, I think the reader_page RB_MISSED_EVENTS flag is not cleared after
> read. commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent
> ring buffer on reboot") drops clearing commit field for unwinding the
> buffer.
> 
> @@ -5342,7 +5440,6 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>          */
>         local_set(&cpu_buffer->reader_page->write, 0);
>         local_set(&cpu_buffer->reader_page->entries, 0);
> -       local_set(&cpu_buffer->reader_page->page->commit, 0);
>         cpu_buffer->reader_page->real_end = 0;
>  
> Should we clear the RB_MISSED_* bits here?

Ah, no. ignore this. If there is a sudden reboot, the broken
commit will be there anyway. But we can recover it.

Thank you,

> 
> Thanks,
> 
> > 
> > So, perhaps we should invalidate the entire buffer if the commit part
> > is corrupted, as that is a major corruption.
> > 
> > -- Steve
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
