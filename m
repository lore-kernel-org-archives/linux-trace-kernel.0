Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F53215075;
	Sat, 30 Aug 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549376; cv=none; b=NhjI17hjRaII/Cfuhfxu+NRxeCJulyZ37d+6mxHQc2L+R81yp4TkL0muGJCHTccqlbBTRDWmdoBe7xvg6ML3Y8+UwtscWBy2jva5vujNJEB+yrtHa+c9x9rI0tethwniQq+3GVLUEuWKLHEx3GD1ulAPZgN6KaqPS1uASu5LMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549376; c=relaxed/simple;
	bh=HwX32QeFjPWmTiGI3BtXr13beWWLdfFnHIp1PwXx2Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed9jged3fkJy0xwUMcfHGwfAutiuEkokF6tzb3mlXvphkfZ7OLpsmJgUsW2r8gzwa/jjwNYmjY/DbRLdflWj1o3Z5iOnsGF2wdrr6ScWsC1X3GCx2hcWSFFbXrMLRWzuP5CVruQ57F5OCHqjsMuD9s9FtYmmiUBAjlIPWtF9yO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05E4C4CEEB;
	Sat, 30 Aug 2025 10:22:53 +0000 (UTC)
Date: Sat, 30 Aug 2025 11:22:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <aLLQ-43Ll8rF7kon@arm.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
 <20250819135008.5f1ba00e@gandalf.local.home>
 <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
 <20250829082604.1e3fd06e@gandalf.local.home>
 <20250829083655.3d38d02b@gandalf.local.home>
 <aLIFRHcsEo2e2GE7@arm.com>
 <20250829181311.079f33bf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829181311.079f33bf@gandalf.local.home>

On Fri, Aug 29, 2025 at 06:13:11PM -0400, Steven Rostedt wrote:
> On Fri, 29 Aug 2025 20:53:40 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> valid user address.
> > BTW, arm64 also bails out early in do_page_fault() if in_atomic() but I
> > suspect that's not the case here.
> > 
> > Adding Al Viro since since he wrote a large part of uaccess.h.
> 
> So, __copy_from_user_inatomic() is supposed to be called if
> pagefault_disable() has already been called? If this is the case, can we
> add more comments to this code? I've been using the inatomic() version this
> way in preempt disabled locations since 2016.

This should work as long as in_atomic() returns true as it's checked in
the arm64 fault code. With PREEMPT_NONE, however, I don't think this
works. __copy_from_user_inatomic() could be changed to call
pagefault_disable() if !in_atomic() but you might as well call
copy_from_user_nofault() in the trace code directly as per Luo's patch.

> I just wanted to figure out why __copy_from_user_inatomic() wasn't atomic.
> If anything, it needs to be better documented.

Yeah, I had no idea until I looked at the code. I guess it means it can
be safely used if in_atomic() == true (well, making it up, not sure what
the intention was).

-- 
Catalin
