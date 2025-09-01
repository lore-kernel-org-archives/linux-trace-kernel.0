Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8F30DD10;
	Mon,  1 Sep 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720616; cv=none; b=iIA8Q6Mh3WSikvzJQX8tUE/nsWXRZZurkYAf7csTDGq4F9P1UEITvTesJ0rdbgFPstOoqR0vljFZ8OR43pLcfvo6Coz72Ywh4LXjcKJBLjvZQTReg14B/vNIvB0LMpHsEZIg0uITjunVYP1UuU2ZyDzcRAbuhHsnITKJP9S8W/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720616; c=relaxed/simple;
	bh=/hqCkOwtBOhHQ1dFLUCN9G4AgIEKlLyHRGqnlAn23so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnn7gHygqoMOuUBC7PQdyMCyHf0ncGbaJBN54CNwIZ3Da/zgC5FsLn7+2d6cd1njuIR03xwX3QtdsCZkQFf3PndVYeWXFt20YZi+MUGSS3UAEqnH63PnJNygjl5raTRfVDPjPsC6wepiKkBZmj4x7kD0vL+9/fLMQ47m0RFmxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00C0C1A25;
	Mon,  1 Sep 2025 02:56:45 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 308D43F6A8;
	Mon,  1 Sep 2025 02:56:50 -0700 (PDT)
Date: Mon, 1 Sep 2025 10:56:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <aLVt30-Lc9lesqS6@J2N7QTR9R3>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
 <20250819135008.5f1ba00e@gandalf.local.home>
 <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
 <20250829082604.1e3fd06e@gandalf.local.home>
 <20250829083655.3d38d02b@gandalf.local.home>
 <aLIFRHcsEo2e2GE7@arm.com>
 <20250829181311.079f33bf@gandalf.local.home>
 <aLLQ-43Ll8rF7kon@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLLQ-43Ll8rF7kon@arm.com>

On Sat, Aug 30, 2025 at 11:22:51AM +0100, Catalin Marinas wrote:
> On Fri, Aug 29, 2025 at 06:13:11PM -0400, Steven Rostedt wrote:
> > On Fri, 29 Aug 2025 20:53:40 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > valid user address.
> > > BTW, arm64 also bails out early in do_page_fault() if in_atomic() but I
> > > suspect that's not the case here.
> > > 
> > > Adding Al Viro since since he wrote a large part of uaccess.h.
> > 
> > So, __copy_from_user_inatomic() is supposed to be called if
> > pagefault_disable() has already been called? If this is the case, can we
> > add more comments to this code? I've been using the inatomic() version this
> > way in preempt disabled locations since 2016.
> 
> This should work as long as in_atomic() returns true as it's checked in
> the arm64 fault code. With PREEMPT_NONE, however, I don't think this
> works.

Sorry, what exactly breaks for the PREEMPT_NONE case?

> __copy_from_user_inatomic() could be changed to call
> pagefault_disable() if !in_atomic() but you might as well call
> copy_from_user_nofault() in the trace code directly as per Luo's patch.

That makes sense to me. I'll go check the arm64 users of
__copy_from_user_inatomic(), in case they're doing something dodgy.

> > I just wanted to figure out why __copy_from_user_inatomic() wasn't atomic.
> > If anything, it needs to be better documented.
> 
> Yeah, I had no idea until I looked at the code. I guess it means it can
> be safely used if in_atomic() == true (well, making it up, not sure what
> the intention was).

I think that was the intention -- it's the caller asserting that they
know the access won't fault (and hence won't sleep), and that's why
__copy_to_user_inatomic() and __copy_to_user() only differ by the latter
calling might_sleep().

It looks like other inconsistencies have crept in by accident. AFAICT
the should_fail_usercopy() check in __copy_from_user() was accidentally
missed from __copy_from_user_inatomic() when it was introduced in
commit:

  4d0e9df5e43dba52 ("lib, uaccess: add failure injection to usercopy functions")

... and the instrumentation is ordered inconsistently w.r.t.
should_fail_usercopy() since commit:

  33b75c1d884e81ec ("instrumented.h: allow instrumenting both sides of copy_from_user()")

... so there's a bunch of scope for cleanup, and we could probably have:

	/*
	 * TODO: comment saying to only call this directly when you know
	 * that the fault handler won't sleep.
	 */
	static __always_inline __must_check unsigned long
	__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
	{
		...
	}

	static __always_inline __must_check unsigned long
	__copy_from_user(void *to, const void __user *from, unsigned long n)
	{
		might_fault();
		return __copy_from_user_inatomic();
	}

... to avoid the inconsistency.

Mark.
