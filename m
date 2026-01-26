Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCE2E62C0;
	Mon, 26 Jan 2026 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463476; cv=none; b=ncu/gwB0Kaen+asR+n7Upk3Q5GpTo6IbUFoNTwlIubkl8RA7LtyfKWL8bTDgyr9hWzrJt+MT6vz0MN+VL3JpEF4R9rs2bdXRnPZ9Xx24Sc0sMyAh06fyCBDrQnJY5PpVCzt3df8NTTbKw83eGK9HpUxtueEclt0jl9gVHiOTAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463476; c=relaxed/simple;
	bh=Bi+BbTjZF7dffgqlDsGev8VQcqOcP5ksA+yWlGZ6/TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bre3nwqCTEMw+zHKNr5//OEPZIv9qbVQBqyc7C2ve2j6iPF7xWOfzt0X/k7H5X8w59kdwnfJWutxpeHLOMIHul+p8PhDsXsHz3BOzDazdgLru3R5QWhFrP9iBbw6MEyaDs++ramzVKqjLD+ywlBy0MycvHBpqaTZmI7ZNR4Ys1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dn9XPR4P; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dn9XPR4P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l2f2L/7BRQC+PvxoygrLgGLz/fDzYKu++Aa72y9T504=; b=dn9XPR4PG22BS8I6YTfOhD1RIo
	y9f9OWyrhf3V7ymJz+vQqwHk+Rt4O9aitXKIHiwMFzMNlqxljIEMgwqr4UNh85TB8skX6gdVoaBtS
	QJooBAJxCmBGgpLqWZ8SRcpgKPMWcq2vYSF/6AQNocng/U2nFpszhzhnyB77NtZEvDqwIp46/8K3h
	r1PObyQPYmY1RLCMtTlS6VJQtcX3/K+BXHVEnOtmYJeP0kDTjdl/kv9PE2Bxg1wtBU8iVhS3Zv3d/
	sow58KOaAnSt8TgzLQ9DfoLyb00XARMsPEH49PXL8TA8pCP2zB3V4UcHoA6FQ4DbYtB/sRvV1R9Rc
	5tdEkXDw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkUHM-00000005u9f-3Zca;
	Mon, 26 Jan 2026 21:37:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 675F0300756; Mon, 26 Jan 2026 22:37:48 +0100 (CET)
Date: Mon, 26 Jan 2026 22:37:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and
 TRACING
Message-ID: <20260126213748.GR171111@noisy.programming.kicks-ass.net>
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
 <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
 <20260112100006.7db6d31d@gandalf.local.home>
 <aWUO59edshSRit-Y@google.com>
 <20260112115408.48ed4d35@gandalf.local.home>
 <aXddnjiHCX-XS5S9@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXddnjiHCX-XS5S9@google.com>

On Mon, Jan 26, 2026 at 12:27:10PM +0000, Alice Ryhl wrote:
> On Mon, Jan 12, 2026 at 11:54:08AM -0500, Steven Rostedt wrote:
> > On Mon, 12 Jan 2026 15:10:31 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > 
> > > > And have the M of the other sections be R here?  
> > > 
> > > Sure, we can do that.
> > > 
> > > Are you still willing to pick up the patches? I think that is simpler in
> > > case there are any series that touch both the C and Rust parts. (Such as
> > > the initial tracepoint series did.)
> > 
> > Yes. So I guess you can still add me with a 'M:'. But I wanted a separate
> > section so that all the Rust expertise is still included.
> 
> What about the STATIC BRANCH/CALL subsystem? Should I also leave you or
> someone else as 'M:' there? It's unclear to me who usually picks up
> patches for STATIC BRANCH/CALL when they are not a dependency to a patch
> for somewhere else.

I think that'd be me -- I typically do the static branch/call bits.
