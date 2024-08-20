Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991661E86E;
	Tue, 20 Aug 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191545; cv=none; b=f2xNEB5jEk6WqcByacBQUz6Wgi+SCg4eDU5OkT2gZVU8ZjVCR8x1ZN4YUfoFVHr3BWXXXjhZpH2XAYYUkq0vtIFj4l1hqCm0123U2Tw7aH8nTGRGsq2jukcpq1ihxuVkqdu4figgjLLrHBZyjB+3NTXbyeoraaThPFbvcKRUQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191545; c=relaxed/simple;
	bh=YbArkAl112UAm74vlkQSwP1yYe1AflyS8u02f3G/XSo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UfygQaWlQfMHN6x3hZIvwYIC1SaCULHJiGeSmNqJzO4ZJZvAzaExM33/17KJ8j1Mkeev8FdMSOfSDo1F8ap3hVc7CPY7KDHIIe89jKCDqN92SrRM61Did3A3zpMMq0d0srEReOAORdaxwP4T1Laopz6SDJxltr1HCjyuSJzeOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgNSNq5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgNSNq5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB49AC4AF13;
	Tue, 20 Aug 2024 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724191545;
	bh=YbArkAl112UAm74vlkQSwP1yYe1AflyS8u02f3G/XSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MgNSNq5NcniTwiS0TJYsBUUAy90+N7i4/999AhziAyLU/84mTUFUP7E+VJ46Sep35
	 O6Be4X2eRKaddSn3fGB95oDgVK2Ts4Rmjt9iqyY0fm4uIjCh5BrogZWuOQ9qq3PWZn
	 4JDJ6O4VJXwMwtXiHzrXmJ+Ab5itxZiqw2mP5d2DHQ0oDEdr2yz+lCK4Lc2R1s+i/i
	 Iz2I+Cu8QGmlv+HDBTrQaS+4EwyiE4xRdM5TrVGzJ5b2pWs6EEnhPKdOGRQdGyr8nz
	 fuhOmC1SJxeFmA87OH7uvVv0GmSa+Py6MOIUQwYzWnmGaXfEGepPSklYZWDB6f2n5t
	 1JOlh4Ik+r4SQ==
Date: Wed, 21 Aug 2024 07:05:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Linux Trace
 Kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-Id: <20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
In-Reply-To: <CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
	<CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 08:10:42 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Tue, Aug 20, 2024 at 3:48 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Aug 20, 2024 at 10:03:30AM +0900, Masami Hiramatsu wrote:
> > > On Mon, 19 Aug 2024 12:02:44 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > On Tue, 20 Aug 2024 00:56:49 +0900
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > >
> > > > > >
> > > > > > We may need to add "noinline" or something to make sure those functions
> > > > > > don't get inlined for LTO.
> > > > >
> > > > > Yeah, we need such option at least for function call test.
> > > >
> > > > Could you add the noinline, and if it fixes the issue send a patch?
> > >
> > > I found the target function already has "noinline". I tried to add noinline
> > > to the testing function (callsite), but it also did not work.
> > > I think "noinline" is for the compiler, but LTO is done by the linker.
> >
> > If LTO is breaking noinline, then that has much larger implications for
> > noinstr code and similar, and means that LTO is unsound...
> 
> The noinline attribute is preserved in LLVM IR, so it should continue
> to work with LTO. Which function are we talking about here? Are you
> sure the function was inlined instead of being dropped completely?
> Does marking the function __used help?

We are talking about trace_selftest_startup_dynamic_tracing() in
kernel/trace/trace_selftest.c. The callee is func() which is actually
DYN_FTRACE_TEST_NAME() in kernel/trace/trace_selftest_dynamic.c.
That function passed as pointer (but the compiler can embed it by constant
propagation.)

Does the noinline attribute prevent embedding callsite too? I mean

extern callee()

noinline callee()
{
...
}

caller()
{
	callee() // (*)
}

In this case, does noinline prevent LTO to embed the callee at the callsite(*)
or prevent LTO remove the callee() symbol?

Thank you,

> 
> Sami
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
