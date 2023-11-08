Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925C641
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCKJOlaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A23C433C8;
	Wed,  8 Nov 2023 01:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699405375;
	bh=ZEcloge7EvcLciwxWbJyUqAK3+uw3aSKssS3rdqKcW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCKJOlaPPiAsb3hjysLpyMF41K+ef7+yYrBxLUm1WAIj3099aNHo4EkCPdeh4tDk0
	 VeEVVdJCqzXceYtRXU0ToKjiDpojWlOjWfy58365MVFwUc1VBcPCXe8xrlxbBUTR6P
	 KBoH+BWOxinsiV9SrxfwJ84gQMGF3iJRNBl9Qt2QFCtzN1pCMLPAvbNjs+TN/Wvtb9
	 tQy1HH7D6dr/H6erkEeOlktdCsRg7yLIOsI/4KdPFdqkRVjYa3dsRS/W6YThKyO7X8
	 JuFRlhDJZK0o1OOz4+lrIliNlXL/5b/G7ImphrGhx54MwBQLxF/QhtT58M44l/4LRw
	 X4yggtgrv2vNQ==
Date: Wed, 8 Nov 2023 10:02:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, shorne@gmail.com, geert@linux-m68k.org,
 andi.shyti@linux.intel.com, mingo@kernel.org, palmer@rivosinc.com,
 andrzej.hajda@intel.com, arnd@arndb.de, peterz@infradead.orgm,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mattwu@163.com, linux@roeck-us.ne
Subject: Re: [PATCH v2 2/4] locking/atomic: arc: arch_cmpxchg[64]_local
 undefined
Message-Id: <20231108100248.5376b99c62a1b24fb0ce62c0@kernel.org>
In-Reply-To: <20231104091615.4884-3-wuqiang.matt@bytedance.com>
References: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
	<20231104091615.4884-3-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Nov 2023 17:16:13 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> For architectures that support native cmpxchg, we'd like to
> implement arch_cmpxchg[64]_local with the native variants of
> supported data size. If not, the generci_cmpxchg[64]_local
> will be used.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  arch/arc/include/asm/cmpxchg.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index bf46514f6f12..91429f2350df 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -80,6 +80,34 @@
>  
>  #endif
>  
> +/*
> + * always make arch_cmpxchg[64]_local available, native cmpxchg
> + * will be used if available, then generic_cmpxchg[64]_local
> + */
> +#include <asm-generic/cmpxchg-local.h>
> +static inline unsigned long __cmpxchg_local(volatile void *ptr,
> +				      unsigned long old,
> +				      unsigned long new, int size)
> +{
> +	switch (size) {
> +#ifdef CONFIG_ARC_HAS_LLSC
> +	case 4:
> +		return __cmpxchg_32((int32_t *)ptr, old, new);
> +#endif
> +	default:
> +		return __generic_cmpxchg_local(ptr, old, new, size);
> +	}
> +
> +	return old;
> +}
> +#define arch_cmpxchg_local(ptr, o, n) ({				\
> +	(__typeof__(*ptr))__cmpxchg_local((ptr),			\
> +					(unsigned long)(o),		\
> +					(unsigned long)(n),		\
> +					sizeof(*(ptr)));		\
> +})
> +#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
> +
>  /*
>   * xchg
>   */
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
