Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395D17E4;
	Fri,  7 Feb 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738889928; cv=none; b=Ow0ZyUiOlgPXpDYj8DrKZPQL5w73kxkCx8IQxJ52nSzQhC3zLCO3aOdwrDA7X/gLXd29YeVYXnIF8A/UPZ1uksQBtrHq8A8Eu3AsEpaQnMtUVE7iO6ZHOhJxr6x5nofH1wTrG5NqlesliH7XSqIwijmdLnAmA5KT4jril9lw/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738889928; c=relaxed/simple;
	bh=kC+7qqKAj18ka8taKSPR0wYnE5H2YPLLCSxW9e84sZY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h0KBMZZX+7PdjveTf5/NtFqLHLd+ekpWSUIM1TsmB3KMucQ9o33A1Y+lbm3ST8u/20sP8+s+Vc2dKucT801gmWbSc1D9la9pfqfdF5rVb4OmcpTmdZUIkGMtqDO9KWGFR5Cz7kp9BDz+CyshWYkFZTmJCnkFb8jbsGKraOOZf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR5YG3Zm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR5YG3Zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7858EC4CEDD;
	Fri,  7 Feb 2025 00:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738889928;
	bh=kC+7qqKAj18ka8taKSPR0wYnE5H2YPLLCSxW9e84sZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GR5YG3Zm109PEYMlvacaOaTS+Mge9fUcvYXHA5fcFPnQ190sCABUxVQTO56k0Mn0l
	 njei3rGF29RaxBTP9ppN2OAniy8WjXZzd9sdrHBiaUyT/Q3/at4e7+78NDewVKYeGu
	 UsXkH/SbyC6v3CbqlNdQtTvQansRKn30j8fmpIB9J8vcc39B/LL+ZtdCcbJHRxSSvc
	 nkxYVw7a6Jq81YePHvd9bZBKO5mdVSMtlq5yd4QJDfQ1gTdcozZmojXHAbLnyDzdp2
	 pAr0y2ximNQHdTODbPoV5BDKmJmKNaZQx82ecl312xZxFrMcPteEJzy+0J9mFcBPW8
	 PCXr7SnATEVTA==
Date: Fri, 7 Feb 2025 09:58:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] tracing: Have persistent trace instances save KASLR
 offset
Message-Id: <20250207095844.c2d761f3a3588f705e5c5832@kernel.org>
In-Reply-To: <20250206102425.2d1f71ad@gandalf.local.home>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.596907199@goodmis.org>
	<20250206142232.5a10545649210f3b3ba172c2@kernel.org>
	<20250206102425.2d1f71ad@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 10:24:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 6 Feb 2025 14:22:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Wed, 05 Feb 2025 17:50:35 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > There's no reason to save the KASLR offset for the ring buffer itself.
> > > That is used by the tracer. Now that the tracer has a way to save data in
> > > the persistent memory of the ring buffer, have the tracing infrastructure
> > > take care of the saving of the KASLR offset.
> > >   
> > 
> > Looks good to me. But note that the scratchpad size may not enough for
> > module table later, because 1 module requires at least the name[]
> > (64byte - sizeof(ulong)) and the base address (ulong). This means
> > 1 entry consumes 64byte. Thus there can be only 63 entries + meta
> > data in 4K page. My ubuntu loads 189(!) modules;
> > 
> > $ lsmod | wc -l
> > 190
> > 
> > so we want 255 entries, which requires 16KB.
> 
> So, I was thinking of modifying the allocation of the persistent ring
> buffer, which currently is
> 
> #define ring_buffer_alloc_range(size, flags, order, start, range_size)
> 
> [ it's a macro to add lockdep key information in it ]
> 
> But I should change it to include a scratch size, and allow the tracing
> system to define how much of the range it should allocate for scratch.
> 
> Then we could do:
> 
> 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
> 						      tr->range_addr_start,
> 						      tr->range_addr_size,
> 						      struct_size(tscratch, entries, 128));
> 
> Which would make sure that the scratch size contains enough memory to hold
> 128 modules.

Yeah, this idea looks godd to me. BTW, the scratch size will be aligned to
the subbuffer size (or page size?)

Thanks,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
