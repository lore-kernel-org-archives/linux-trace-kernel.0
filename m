Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CB2EA754;
	Tue, 10 Mar 2026 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155579; cv=none; b=iHVE9B5t1cZDxK5vBBptjGTrCiWgNHD7EVVa7JZkaNuUtU+PgTwEB/6uBAbxJzDNYaoUlFnpYXfreaBJeezpqPKlGM78I1PM03RfKCrDID2tcjCIUZQn8KKWnPQz+IN5Zc0fOsKkIQwp2gP9EATJG7blNLioZaM8xIyRurY4MWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155579; c=relaxed/simple;
	bh=PnDvtaIqFNrsJThykUCov5uXEBK5Kj+4U0KQlZX6uD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpo/cJgMlgEGtKHQDorADz2WB9OyOz5+iv7mf75kvXm5s5K7CxfWPzBoTlPZvqr+DerQH3FosKeKOfufArEnozxNcMkvA1e0RsmzzhDnJiU3/h9zy+E2d2yGp19kOqhIRO990IV3+wE1m7qgm6wSaYs4gn6xhPHoIHACjHRSa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=DwW1Af/q; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="DwW1Af/q"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 69064B37F4;
	Tue, 10 Mar 2026 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773155570;
	bh=wQRiW3YlOB3Mb+ib1i0SWorPbB1fJDy5Jpm6Xbydanw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DwW1Af/qGgqi8YmFeKNuZVI6qmStB6IGrHgDHXV3tdDzQ5uyWgEYGvQF5ObX6VFvj
	 HUNmp3kIMXPDX81SvqPKOtzXsmOvdwhl1iGc+zzg9Gbqe8RR9RSqm0IhbD42OQ8HNK
	 o9r16Bdo+8zjsl/t5doqnVtQMjfulecSLq7DICuE=
Date: Tue, 10 Mar 2026 15:12:45 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 3/3] locking: Wire up contended_release tracepoint
Message-ID: <abA07Tn034C66HI2@shell.ilvokhin.com>
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
> The above "trace_contened_release_enabled()" is a static_branch where it
> turns the if statement into a nop when the tracepoint is not enabled, and a
> jmp when it is.

Thanks for catching this, Steven. Fixed locally.
