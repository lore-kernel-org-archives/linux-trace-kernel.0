Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67523C1
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Oct 2023 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpJYdbTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA6FC433C8;
	Sat, 28 Oct 2023 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698497363;
	bh=RvctOKckPEGJDlfeMTJyO5DP8QKBqFPoGje7oB2vf9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpJYdbTldRFplojd0mpiAOAEfryVwEp9S1rR7XIqQbo1XbsE0n3jjJUdwz5u4xm87
	 7rIh1MzAMGerkytZdDJxXM72iRb58AHHu8Iryq8EMIej++2ZMfqUWkPSbk4vT4Vv+h
	 FXOd24f9+724P0qXM0S8mprCcijzkbid/gbGw/ANsULDacIb59irdngRb/4t6YCF8O
	 ywWtmTLv+kibp2DArWjyYEJdBRapQqAIPlkuv0M7cdioGYc9t0BzicQfcLsOhZcQdB
	 wOFbSJwLTeP3ThYTnw1Zg7AKviLNE/ITuFruuy3/0O9y44zoSVTQuLtpWPEOFQU4B1
	 ntZmMdUjGuetQ==
Date: Sat, 28 Oct 2023 21:49:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>, Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Andi Shyti <andi.shyti@linux.intel.com>, Palmer
 Dabbelt <palmer@rivosinc.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 mattwu@163.com
Subject: Re: [PATCH 3/3] locking/atomic: openrisc: use
 generic_cmpxchg[64]_local for arch_cmpxchg[64]_local
Message-Id: <20231028214918.e32265f1dd2ef26fd9d2d1c2@kernel.org>
In-Reply-To: <66f5645c-f9f5-4c53-9503-a1f8470a9bee@bytedance.com>
References: <20231026073932.702197-1-wuqiang.matt@bytedance.com>
	<1e3aba7d-89ac-4b62-840e-992527115a70@app.fastmail.com>
	<66f5645c-f9f5-4c53-9503-a1f8470a9bee@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Wuqiang,

On Thu, 26 Oct 2023 19:05:51 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> On 2023/10/26 16:46, Arnd Bergmann wrote:
> > On Thu, Oct 26, 2023, at 09:39, wuqiang.matt wrote:
> >> arch_cmpxchg[64]_local() are not defined for openrisc. So implement
> >> them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.
> >>
> >> Closes:
> >> https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
> >> Closes:
> >> https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com
> >>
> >> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> > 
> > I think on architectures that have actual atomics, you
> > generally want to define this to be the same as arch_cmpxchg()
> > rather than the generic version.
> > 
> > It depends on the relative cost of doing one atomic compared
> > to an irq-disable/enable pair, but everyone else went with
> > the former if they could. The exceptions are armv4/armv5,
> > sparc32 and parisc, which don't have a generic cmpxchg()
> > or similar operation.
> 
> Sure, better native than the generic. I'll try to collect more
> insights before next move.

So I will temporally remove the last change (use arch_cmpxchg_local
in objpool) until these series are rewritten with arch native code,
so that the next release will not break the kernel build.

But this must be fixed because arch_cmpxchg_local() is required
for each arch anyway.

> 
> > You could do the thing that sparc64 and xtensa do, which
> > use the native cmpxchg for supported word sizes but the
> > generic version for 1- and 2-byte swaps, but that has its
> > own set of problems if you end up doing operations on both
> > the entire word and a sub-unit of the same thing.
> 
> Thank you for pointing out this. I'll do some research on these
> implementations.

arc also has the LL-SC instruction but depends on the core feature,
so I think we can use it.

Thank you,

> 
> >      Arnd
> 
> Regards,
> wuqiang
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
