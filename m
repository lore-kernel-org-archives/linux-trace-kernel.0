Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DE3CF69A;
	Thu,  5 Mar 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732563; cv=none; b=tdTdg5DVKvMx2J9kWUEVHfVxCgK1o1bL+rEn1jI88rwq5/efz2aSnxEEg3CAOjA7zK1thBxkx6lpoLsCORDKQbtUF97jHrREL4Cksxx40wAnVf1oG66PUrl3s7rt4GjgWdkJ7dn/HiNjMiLMmRdRYboOK5Gzj7Hp837BW4+KI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732563; c=relaxed/simple;
	bh=GEDoOvOFWYc/+jec7Z+TyPOLdLoow46quoPv9ttnFZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrJ6qQ5pbMCaEhnpdvRR7440vntwNCLQlapY++Vsv/dvFDC0+6HjwQFhZgNCStjrOWeLQp7CwhG8P3j9Jkx7oZoKkjhmMoJN7T16zQSnbDrWP5pnmcc46R3Qw5wIwmtki8a5lMNsCORlz3bBhPGxcaYi5tSa0Q23WSVM0fLe4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BLKLlUS+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BLKLlUS+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v62qxDPGMf43nSWUVOFWJmlONh5WT3QlqDMXHIbC27Q=; b=BLKLlUS+FX6VcTXIcA8Sewn2I5
	I6rmP+PRF0KJAe1hwJpoXo9F2rPDVKPI+B45TxuS3MdmPqiXge582xOQSbbqyGsBF3YHm/1Clsre4
	yM5Fj8GbXNWNjGB5+0FiHMQlxO+4F4C70JdmOapv/Ezi9zDexCZDtv4mDKROdkSJaYpCBdEvpSoX2
	fYnPMVw+nx8+7u/CVP+yBvcJy1Di0xChciiwZWgZ8kYIkjSwFQicJM7mzIg6BcFJfAXwRWHVIooqx
	yIvhNH4GR6vYuBFDSwAzc90xg9GmsFhCdcz9bDIkXA6go5kHnr2aYmlHmPsZocrOl4468hm40wUyD
	0Kkm+ZwA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyCiV-00000007Mnu-1Q8e;
	Thu, 05 Mar 2026 17:42:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25732300182; Thu, 05 Mar 2026 18:42:24 +0100 (CET)
Date: Thu, 5 Mar 2026 18:42:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 3/3] locking: Wire up contended_release tracepoint
Message-ID: <20260305174223.GA1442992@noisy.programming.kicks-ass.net>
References: <cover.1772642407.git.d@ilvokhin.com>
 <8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com>
 <20260305105924.7069eb23@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305105924.7069eb23@gandalf.local.home>

On Thu, Mar 05, 2026 at 10:59:24AM -0500, Steven Rostedt wrote:
> On Wed,  4 Mar 2026 16:56:17 +0000
> Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > @@ -204,6 +206,8 @@ static inline void rwbase_write_unlock(struct rwbase_rt *rwb)
> >  	unsigned long flags;
> >  
> >  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > +	if (rt_mutex_has_waiters(rtm))
> > +		trace_contended_release(rwb);
> 
> Hmm, if statements should never be used just for tracepoints without a
> static branch. The above should be:
> 
> 	if (trace_contended_release_enabled() && rt_mutex_has_waiters(rtm))
> 		trace_contended_release(rwb);
> 

I still wish you would accept:

	if (trace_foo_enabled() && foo)
		__do_trace_foo();

The compilers can't optimize the static branches and thus you'll get it
twice for no reason.

I really wish they would just accept __pure, but alas.
