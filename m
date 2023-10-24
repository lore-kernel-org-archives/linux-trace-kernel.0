Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA113FED
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 446B9BA;
	Tue, 24 Oct 2023 08:08:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91BA32F4;
	Tue, 24 Oct 2023 08:09:02 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD0633F762;
	Tue, 24 Oct 2023 08:08:18 -0700 (PDT)
Date: Tue, 24 Oct 2023 16:08:12 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"wuqiang . matt" <wuqiang.matt@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for
 arch_cmpxchg_local()
Message-ID: <ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com>
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169815917362.8695.13904684741526725648.stgit@devnote2>

On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> in SH architecture because it does not implement arch_cmpxchg_local().

I do not think this is correct.

The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
disables interrupts), whereas arch/sh can be built SMP. We should probably add
some guards into <asm-generic/cmpxchg-local.h> for that as we have in
<asm-generic/cmpxchg.h>.

I think the right thing to do here is to define arch_cmpxchg_local() in terms
of arch_cmpxchg(), i.e. at the bottom of arch/sh's <asm/cmpxchg.h> add:

#define arch_cmpxchg_local              arch_cmpxchg

Mark.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/sh/include/asm/cmpxchg.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> index 288f6f38d98f..e920e61fb817 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>  				    (unsigned long)_n_, sizeof(*(ptr))); \
>    })
>  
> +#include <asm-generic/cmpxchg-local.h>
> +
>  #endif /* __ASM_SH_CMPXCHG_H */
> 
