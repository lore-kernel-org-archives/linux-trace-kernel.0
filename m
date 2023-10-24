Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081E749D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltkngLjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED5BC433C8;
	Tue, 24 Oct 2023 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698190980;
	bh=WtfQPMAPAoe29dresqL9N+APt4m28Nou4YZqsaI0AJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltkngLjyqRxgt+skupFRkqGhhABN2x0xzR33W6jvtpyCSAtPZ37mKIFneIt2F/ccM
	 9hCipZEHMQNJWxH42/KcpqTJx3DeuWAC/eWiM7Ds+LX+TgfuhEIvpP9OUYVG76ohUa
	 3kAcohtvhrFrniNna1LVeYoxZ5be2x/gscU8KwH5fMWAgIxlPPI3xC92dRXIQd/Zsb
	 dpkM9UtkAmaBiDJhzjfAk/JZUHfi1DFRYqnpfqK/6czGBsoXHS6yu221GsLTBYTZ4a
	 eDpIS8eOnrPnrRbI8MmUebcWgVuJm7msz11QeiQwLAuG3QBDNEOJRkXE1Vwwb8pRWH
	 heVLJT6t9FI7Q==
Date: Wed, 25 Oct 2023 08:42:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "wuqiang . matt"
 <wuqiang.matt@bytedance.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for
 arch_cmpxchg_local()
Message-Id: <20231025084255.bc70b9d0e5af9f6f3d2d4735@kernel.org>
In-Reply-To: <ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com>
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
	<ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 16:08:12 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> > in SH architecture because it does not implement arch_cmpxchg_local().
> 
> I do not think this is correct.
> 
> The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
> disables interrupts), whereas arch/sh can be built SMP. We should probably add
> some guards into <asm-generic/cmpxchg-local.h> for that as we have in
> <asm-generic/cmpxchg.h>.

Isn't cmpxchg_local for the data which only needs to ensure to do cmpxchg
on local CPU?

So I think it doesn't care about the other CPUs (IOW, it should not touched by
other CPUs), so it only considers UP case. E.g. on x86, arch_cmpxchg_local() is
defined as raw "cmpxchg" without lock prefix.

#define __cmpxchg_local(ptr, old, new, size)                            \
        __raw_cmpxchg((ptr), (old), (new), (size), "")


Thank you,


> 
> I think the right thing to do here is to define arch_cmpxchg_local() in terms
> of arch_cmpxchg(), i.e. at the bottom of arch/sh's <asm/cmpxchg.h> add:
> 
> #define arch_cmpxchg_local              arch_cmpxchg
> 
> Mark.
> 
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  arch/sh/include/asm/cmpxchg.h |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> > index 288f6f38d98f..e920e61fb817 100644
> > --- a/arch/sh/include/asm/cmpxchg.h
> > +++ b/arch/sh/include/asm/cmpxchg.h
> > @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
> >  				    (unsigned long)_n_, sizeof(*(ptr))); \
> >    })
> >  
> > +#include <asm-generic/cmpxchg-local.h>
> > +
> >  #endif /* __ASM_SH_CMPXCHG_H */
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
