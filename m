Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62D650
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt2CDjhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE5CC433C8;
	Wed,  8 Nov 2023 01:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699405337;
	bh=YCzRL+kVqkfECP59e1QJcGLwwNjryJJh+Cs7cpeWcEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nt2CDjhJwpkem9VZrZ5m/LnBJWzlcPt0G8R+/J6Om5IQsejFGlYCKYlj6udl4WwCB
	 F2HnU4rmciaUff6HS8zKKGnwGmMcq67t/z78urCReiOgvAQB/1SFfB8qu7PMRWjmTB
	 TObwr9QxHm4BzppdwOwlpc37JwLsGo/oaxlJ8lWFKgRDvZZtzCtOTdQZwAh471oPET
	 4y0Da5MkH4G5zGOe+aA+mBaZnLdUC2SXDGTnCZZGaC7mHs70bVpniL6aqGjA0AObJl
	 KVext8xhjSbkkhvbpkpZDr9Yt3UW5F8RrEbBNxal1kpzaHhsD71dCxeoQjOuqhkBnQ
	 9oGT3NFU5cTZQ==
Date: Wed, 8 Nov 2023 10:02:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, shorne@gmail.com, geert@linux-m68k.org,
 andi.shyti@linux.intel.com, mingo@kernel.org, palmer@rivosinc.com,
 andrzej.hajda@intel.com, arnd@arndb.de, peterz@infradead.orgm,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mattwu@163.com, linux@roeck-us.ne
Subject: Re: [PATCH v2 1/4] locking/atomic: arc: data size checking in
 arch_cmpxchg
Message-Id: <20231108100210.8118bdfe6fc67317f3638f1c@kernel.org>
In-Reply-To: <20231104091615.4884-2-wuqiang.matt@bytedance.com>
References: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
	<20231104091615.4884-2-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Nov 2023 17:16:12 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> Macro __cmpxchg() renamed to __cmpxchg_32() to emphasize it's explicit
> support of 32bit data size, BUILD_BUG_ON() added to avoid any possible
> misuses with unsupported data types.
> 
> In case CONFIG_ARC_HAS_LLSC is undefined, arch_cmpxchg() uses spinlock
> to accomplish SMP-safety, so the BUILD_BUG_ON checking is uncecessary.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  arch/arc/include/asm/cmpxchg.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index e138fde067de..bf46514f6f12 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -18,14 +18,16 @@
>   * if (*ptr == @old)
>   *      *ptr = @new
>   */
> -#define __cmpxchg(ptr, old, new)					\
> +#define __cmpxchg_32(ptr, old, new)					\
>  ({									\
>  	__typeof__(*(ptr)) _prev;					\
>  									\
> +	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
> +									\
>  	__asm__ __volatile__(						\
> -	"1:	llock  %0, [%1]	\n"					\
> +	"1:	llock  %0, [%1]		\n"				\
>  	"	brne   %0, %2, 2f	\n"				\
> -	"	scond  %3, [%1]	\n"					\
> +	"	scond  %3, [%1]		\n"				\
>  	"	bnz     1b		\n"				\
>  	"2:				\n"				\
>  	: "=&r"(_prev)	/* Early clobber prevent reg reuse */		\
> @@ -47,7 +49,7 @@
>  									\
>  	switch(sizeof((_p_))) {						\
>  	case 4:								\
> -		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
> +		_prev_ = __cmpxchg_32(_p_, _o_, _n_);			\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
> @@ -65,8 +67,6 @@
>  	__typeof__(*(ptr)) _prev_;					\
>  	unsigned long __flags;						\
>  									\
> -	BUILD_BUG_ON(sizeof(_p_) != 4);					\
> -									\
>  	/*								\
>  	 * spin lock/unlock provide the needed smp_mb() before/after	\
>  	 */								\
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
