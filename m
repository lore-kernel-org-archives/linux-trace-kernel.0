Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0731F2D631
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIb8qrJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C144DC433C7;
	Wed, 25 Oct 2023 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698245857;
	bh=FJMuPNiTnN8SIyYPd4VkfWpKSbI2Dx6yU/FVfERd4EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cIb8qrJTfHufYPgWgAUMtJ7uL0F/8QBGvzIhL61Br6iSvX6gKZtor7wd5vT1TVQZF
	 l23at4t8X5tTeBVI/d4bmsOk2GUnRtxi9mhfPMVQPuIqX4K/QqricNmtFHxmCMUBhs
	 WFEvqhtwwpji7FF7ZdVCSPTpmiNan9P9ULxfETq6TrYYVz5SLAZ6Vzv40uaaUMlpeZ
	 v53havv8B1ItVLUE6/xAKtAdMWu2t/zWfqHwObdVaDsRvzYP+agNXfHMyvlZovetuI
	 jDftXoAQh4jevIE/m1QjKdOZXBlEokmwF6pAPuVs4L4pwj+ONBR4mllju6yz5Q7hdN
	 zu7622Fu5tTGQ==
Date: Wed, 25 Oct 2023 23:57:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Mark Rutland
 <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
 Felker <dalias@libc.org>, "wuqiang . matt" <wuqiang.matt@bytedance.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for
 arch_cmpxchg_local()
Message-Id: <20231025235733.bb89c8ffe5b13998a3c2a974@kernel.org>
In-Reply-To: <CAMuHMdXrOt3vWrJcoVZNUSJRH4E45iJgdeXMi6ncb4vOSg6_jw@mail.gmail.com>
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
	<ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com>
	<20231025084255.bc70b9d0e5af9f6f3d2d4735@kernel.org>
	<ZTjuH074CJuLh7Zw@FVFF77S0Q05N>
	<1bce4bc5ccd38bf9108283535470a7a8eb7e06e9.camel@physik.fu-berlin.de>
	<CAMuHMdXrOt3vWrJcoVZNUSJRH4E45iJgdeXMi6ncb4vOSg6_jw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 25 Oct 2023 15:16:16 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Adrian,
> 
> On Wed, Oct 25, 2023 at 12:32 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Wed, 2023-10-25 at 11:30 +0100, Mark Rutland wrote:
> > > On Wed, Oct 25, 2023 at 08:42:55AM +0900, Masami Hiramatsu wrote:
> > > > On Tue, 24 Oct 2023 16:08:12 +0100
> > > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
> > > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > >
> > > > > > Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> > > > > > in SH architecture because it does not implement arch_cmpxchg_local().
> > > > >
> > > > > I do not think this is correct.
> > > > >
> > > > > The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
> > > > > disables interrupts), whereas arch/sh can be built SMP. We should probably add
> > > > > some guards into <asm-generic/cmpxchg-local.h> for that as we have in
> > > > > <asm-generic/cmpxchg.h>.
> > > >
> > > > Isn't cmpxchg_local for the data which only needs to ensure to do cmpxchg
> > > > on local CPU?
> > > > So I think it doesn't care about the other CPUs (IOW, it should not touched by
> > > > other CPUs), so it only considers UP case. E.g. on x86, arch_cmpxchg_local() is
> > > > defined as raw "cmpxchg" without lock prefix.
> > > >
> > > > #define __cmpxchg_local(ptr, old, new, size)                            \
> > > >         __raw_cmpxchg((ptr), (old), (new), (size), "")
> > > >
> > >
> > > Yes, you're right; sorry for the noise.
> > >
> > > For your original patch:
> > >
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> >
> > Geert, what's your opinion on this?
> 
> While this looks OK on first sight (ARM includes the same file, even
> on SMP), it does not seem to work?
> 
> For sh-allnoconfig, as reported by kernel test robot:
> 
> $ make ARCH=sh CROSS_COMPILE=sh2-linux- allnoconfig lib/objpool.o
> lib/objpool.c: In function 'objpool_try_add_slot':
> ./include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit
> declaration of function 'arch_cmpxchg_local'; did you mean
> 'raw_cmpxchg_local'? [-Werror=implicit-function-declaration]
>   384 | #define raw_cmpxchg_local arch_cmpxchg_local
>       |                           ^~~~~~~~~~~~~~~~~~
> ./include/linux/atomic/atomic-arch-fallback.h:392:16: note: in
> expansion of macro 'raw_cmpxchg_local'
>   392 |         ___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
>       |                ^~~~~~~~~~~~~~~~~
> ./include/linux/atomic/atomic-instrumented.h:4980:9: note: in
> expansion of macro 'raw_try_cmpxchg_local'
>  4980 |         raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>       |         ^~~~~~~~~~~~~~~~~~~~~
> lib/objpool.c:169:19: note: in expansion of macro 'try_cmpxchg_local'
>   169 |         } while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
>       |                   ^~~~~~~~~~~~~~~~~
> 
> For an SMP defconfig:
> 
> $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu- sdk7786_defconfig lib/objpool.o
> 
> ./include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit
> declaration of function ‘arch_cmpxchg_local’; did you mean
> ‘try_cmpxchg_local’? [-Werror=implicit-function-declaration]
>   384 | #define raw_cmpxchg_local arch_cmpxchg_local
>       |                           ^~~~~~~~~~~~~~~~~~
> ./include/linux/atomic/atomic-arch-fallback.h:392:16: note: in
> expansion of macro ‘raw_cmpxchg_local’
>   392 |         ___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
>       |                ^~~~~~~~~~~~~~~~~
> ./include/linux/atomic/atomic-instrumented.h:4980:9: note: in
> expansion of macro ‘raw_try_cmpxchg_local’
>  4980 |         raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>       |         ^~~~~~~~~~~~~~~~~~~~~
> lib/objpool.c:169:19: note: in expansion of macro ‘try_cmpxchg_local’
>   169 |         } while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
>       |                   ^~~~~~~~~~~~~~~~~
> 
> Hiramatsu-san: do these build for you?

Thanks for pointing. I thought I just need to include the header file.
That's my fault.

Let me fix that.

Thank you!

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
