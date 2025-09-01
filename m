Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91225EFBF;
	Mon,  1 Sep 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729686; cv=none; b=DI1fBLrQEtopje8tCzVhhsmBgI7XE1QajkCJ/nt76BUVRa355w1GbvbOncxaJ6dZPuSbBdZYid8Zb7ERhVIdYaBoff/qvXXJncn0iydpjsQBx78O6WurLwrip2Qy4a3kMIy66xgru+7yfOT2KHwJyxaInrwJJDajJscUJ1Tq3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729686; c=relaxed/simple;
	bh=BzE8vul4lNtBZdM3iz/qHFXjV56fh0CqXNS+kpkk+wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfmy2Ah1V/xkgB7zwQLSfQ4fjfnWoktiR0xND1VWA+xxUuLa1AZFpyz16piVEJWMdH8winSLfcqnWk6yuDw2Qp5ULuwYfkzv8ZftpkVxyGEXhzXQAgr8RB4BCrBfnFbv56AAAeO7j/hiT2lVbXxYQe0z4Zd9O8QY5R07RIg9tDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194E0C4CEF0;
	Mon,  1 Sep 2025 12:28:03 +0000 (UTC)
Date: Mon, 1 Sep 2025 13:28:01 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <aLWRUTFeumwr1--E@arm.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
 <20250819135008.5f1ba00e@gandalf.local.home>
 <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
 <20250829082604.1e3fd06e@gandalf.local.home>
 <20250829083655.3d38d02b@gandalf.local.home>
 <aLIFRHcsEo2e2GE7@arm.com>
 <20250829181311.079f33bf@gandalf.local.home>
 <aLLQ-43Ll8rF7kon@arm.com>
 <aLVt30-Lc9lesqS6@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLVt30-Lc9lesqS6@J2N7QTR9R3>

On Mon, Sep 01, 2025 at 10:56:47AM +0100, Mark Rutland wrote:
> On Sat, Aug 30, 2025 at 11:22:51AM +0100, Catalin Marinas wrote:
> > On Fri, Aug 29, 2025 at 06:13:11PM -0400, Steven Rostedt wrote:
> > > On Fri, 29 Aug 2025 20:53:40 +0100
> > > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > valid user address.
> > > > BTW, arm64 also bails out early in do_page_fault() if in_atomic() but I
> > > > suspect that's not the case here.
> > > > 
> > > > Adding Al Viro since since he wrote a large part of uaccess.h.
> > > 
> > > So, __copy_from_user_inatomic() is supposed to be called if
> > > pagefault_disable() has already been called? If this is the case, can we
> > > add more comments to this code? I've been using the inatomic() version this
> > > way in preempt disabled locations since 2016.
> > 
> > This should work as long as in_atomic() returns true as it's checked in
> > the arm64 fault code. With PREEMPT_NONE, however, I don't think this
> > works.
> 
> Sorry, what exactly breaks for the PREEMPT_NONE case?

This code would trigger a warning:

	preempt_disable();
	WARN_ON(!in_atomic());
	preempt_enable();

More importantly, a faulting __copy_from_user_inatomic() between
get/put_cpu() could trigger migration.

> > > I just wanted to figure out why __copy_from_user_inatomic() wasn't atomic.
> > > If anything, it needs to be better documented.
> > 
> > Yeah, I had no idea until I looked at the code. I guess it means it can
> > be safely used if in_atomic() == true (well, making it up, not sure what
> > the intention was).
> 
> I think that was the intention -- it's the caller asserting that they
> know the access won't fault (and hence won't sleep), and that's why
> __copy_to_user_inatomic() and __copy_to_user() only differ by the latter
> calling might_sleep().
> 
> It looks like other inconsistencies have crept in by accident. AFAICT
> the should_fail_usercopy() check in __copy_from_user() was accidentally
> missed from __copy_from_user_inatomic() when it was introduced in
> commit:

I was wondering about that but some code comment for the inatomic
variant states that it's the responsibility of the caller to ensure it
doesn't fault. Not sure one can do other than pinning the page _and_
taking the mm lock. So I agree we should add the fault injection here as
well.

> ... so there's a bunch of scope for cleanup, and we could probably have:
> 
> 	/*
> 	 * TODO: comment saying to only call this directly when you know
> 	 * that the fault handler won't sleep.
> 	 */
> 	static __always_inline __must_check unsigned long
> 	__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
> 	{
> 		...
> 	}
> 
> 	static __always_inline __must_check unsigned long
> 	__copy_from_user(void *to, const void __user *from, unsigned long n)
> 	{
> 		might_fault();
> 		return __copy_from_user_inatomic();
> 	}
> 
> ... to avoid the inconsistency.

I think the _inatomic variant should be reserved to arch code that knows
the conditions. Generic code/drivers may not necessarily be aware of
what the arch fault handler does. The _nofault API I think is better
suited in generic code.

-- 
Catalin
