Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C982641ED
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925700; cv=none; b=NRNZaeGt8sNM4g8I/Y7QKBu9ZiJPtz2rjmxv6R9YAirjKZZhr1HXZrSiBgorG7JoH31Znk8DYFiwnrRxJfBFet8J45M/l+ZGGJYb9Eo1n/IvNWLATDEq7ERo8+tOhB/qajWs9qgP3tjIrJXN30bT1FRRFMHK1DOg1eu5MGQBOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925700; c=relaxed/simple;
	bh=OGAPR/imB7X2i6ec7HlPmvlcsH2lrESEZzLcEOB4YLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc1wl3PAXVOYEDdaxbX5/bcVL9bS7hwsxl0TsDdfeRiEed/kX1/NMHrXOpEcsRBGy7OHF0C+7nvKvLc3yra1gS3GIEP+2Tu+atrxAxhCYDvo1c93pnKFEPznqsV/IU8A7mDg/IvDcdVR5tlRUl6aTb6BSjvTt2R6R0FZeAiP9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D917C4CEE4;
	Tue, 25 Mar 2025 18:01:39 +0000 (UTC)
Date: Tue, 25 Mar 2025 14:02:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sahil Gupta <s.gupta@arista.com>
Cc: gregkh@linuxfoundation.org, linux-trace-kernel@vger.kernel.org, Kevin
 Mitchell <kevmitch@arista.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <20250325140223.534df027@gandalf.local.home>
In-Reply-To: <CABEuK14t7XR5Oi7kD13AHt-cQ8nc+mM8kojMkSh_WXbbNZbcyw@mail.gmail.com>
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
	<20250324133619.6c3babf7@gandalf.local.home>
	<CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
	<2025032424-custard-volley-bbb6@gregkh>
	<20250324150703.69665622@gandalf.local.home>
	<2025032548-happily-saxophone-4079@gregkh>
	<20250325081551.270947fe@gandalf.local.home>
	<CABEuK14t7XR5Oi7kD13AHt-cQ8nc+mM8kojMkSh_WXbbNZbcyw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 12:52:43 -0500
Sahil Gupta <s.gupta@arista.com> wrote:

> On Tue, 25 Mar 2025 05:15:10 -0700 (PDT)
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > How important is it for you to build 64 bit kernels
> > on 32 bit machines?  
> 
> Yeah I don't disagree at all, it is a fairly idiosyncratic thing to
> do. There are some historical and business justifications for still
> building 32-bit in the first place, but until we deduplicate the
> kernel build, we will continue to have this issue.

Note, that the regression is only the failure in the build of your setup.
As your setup never supported sorting the mcount location at build time,
that part is not the regression.

> 
> > One solution may be to simply disable
> > mcount sorting at build time when it is detected that the host is 32 bit
> > and the target is 64 bit.  
> 
> We are currently doing this. I imagine the performance difference is
> trivial but if we can sort at build time, we might as well. I have a
> fairly simple alternate solution that isn't backporting all of those
> patches. The core idea is to introduce another macro, parse_addr, that
> is defined as
> 
>  # define parse_addr(buf) strtoull(buf, NULL, 16)
> 
> when SORTTABLE_64 is defined and
> 
>  # define parse_addr(buf) strtoul(buf, NULL, 16)
> 
> when it isn't. Seems like a fair thing to do considering unsigned long
> long is guaranteed to be at least 64-bit and unsigned long is
> guaranteed to be at least 32-bit. I can post the patch in a stable-
> thread.

I'm not against you doing that, but it is specific for your setup.

If you do this, make sure to test it by enabling:

  CONFIG_FTRACE_SORT_STARTUP_TEST

Which will verify that the table is indeed sorted at run time. There could
be another bug that could make it build, but not sort it properly, and
without that config, you may not know, but it will cause ftrace to not work
properly.

-- Steve
