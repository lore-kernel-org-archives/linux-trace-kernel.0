Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472B14F9C5;
	Wed, 21 Aug 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254933; cv=none; b=uFtpdNuKg7lKcoyQd2My4T+p/GzPkMgy1tWQNjadzjEe5jBcX/dRzX9U2TYCNTYPixCvc8/5Gp4SDDMQ9QWYDSV8pFoNl7TGUI9K0OSGVtteoYNF4eKahUfdcorZl+NoY4ajfRdGgFOj894ROxoKGs8zDiJblY5uJNP8CiTWLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254933; c=relaxed/simple;
	bh=jegzxbbiB+UZX2v3Bp9jNKjbmv+Bhs7rh5DY+VeeNII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCIQ8Bi4FI8auAD8ssFlHThRY6tN34BeEtyGKqYBTd9DesnfWiwwCObmUzd4jNSq1BQIIcmtOIOKUT5+3ZNzzwMlJss5FUdVMpxl5/FLZ2/PklPKEQRnbiOkzJJM7IIOL61/bxVJj++2a/nmdpY9/NK4v3HvuIsMvC8ZaQqZTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95578152B;
	Wed, 21 Aug 2024 08:42:37 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587AB3F73B;
	Wed, 21 Aug 2024 08:42:10 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:42:07 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	clang-built-linux <llvm@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <ZsYKz6ycI8fiQbdh@J2N7QTR9R3.cambridge.arm.com>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
 <20240819112902.11451fe8@gandalf.local.home>
 <20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
 <20240819120244.5657eb2f@gandalf.local.home>
 <20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
 <ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
 <CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
 <20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
 <ZsYInqSc-WS4UldP@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsYInqSc-WS4UldP@J2N7QTR9R3.cambridge.arm.com>

On Wed, Aug 21, 2024 at 04:32:46PM +0100, Mark Rutland wrote:
> On Wed, Aug 21, 2024 at 07:05:39AM +0900, Masami Hiramatsu wrote:
> > On Tue, 20 Aug 2024 08:10:42 -0700
> > Sami Tolvanen <samitolvanen@google.com> wrote:
> > 
> > > On Tue, Aug 20, 2024 at 3:48 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Aug 20, 2024 at 10:03:30AM +0900, Masami Hiramatsu wrote:
> > > > > On Mon, 19 Aug 2024 12:02:44 -0400
> > > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > >
> > > > > > On Tue, 20 Aug 2024 00:56:49 +0900
> > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > > > >
> > > > > > > >
> > > > > > > > We may need to add "noinline" or something to make sure those functions
> > > > > > > > don't get inlined for LTO.
> > > > > > >
> > > > > > > Yeah, we need such option at least for function call test.
> > > > > >
> > > > > > Could you add the noinline, and if it fixes the issue send a patch?
> > > > >
> > > > > I found the target function already has "noinline". I tried to add noinline
> > > > > to the testing function (callsite), but it also did not work.
> > > > > I think "noinline" is for the compiler, but LTO is done by the linker.
> > > >
> > > > If LTO is breaking noinline, then that has much larger implications for
> > > > noinstr code and similar, and means that LTO is unsound...
> > > 
> > > The noinline attribute is preserved in LLVM IR, so it should continue
> > > to work with LTO. Which function are we talking about here? Are you
> > > sure the function was inlined instead of being dropped completely?
> > > Does marking the function __used help?
> > 
> > We are talking about trace_selftest_startup_dynamic_tracing() in
> > kernel/trace/trace_selftest.c. The callee is func() which is actually
> > DYN_FTRACE_TEST_NAME() in kernel/trace/trace_selftest_dynamic.c.
> > That function passed as pointer (but the compiler can embed it by constant
> > propagation.)
> 
> Ah, so IIUC the function isn't being inlined; the call is being
> optimized away becase callee() has no side-effects.
> 
> That can happen without LTO if the caller is in the same compilation
> unit, and I have worked around that in the past by adding a barrier()
> into the callee.

FWIW, that was in samples/ftrace/ftrace-ops.c, where tracee_relevant() and
tracee_irrelevant() have the barrier():

| /*
|  * Marked as noinline to ensure that an out-of-line traceable copy is
|  * generated by the compiler.
|  *
|  * The barrier() ensures the compiler won't elide calls by determining there
|  * are no side-effects.
|  */
| static noinline void tracee_relevant(void)
| {
|         barrier();
| }

... so we already have precedent for that in tracing code.

Mark.
