Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72A14E2DA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947541; cv=none; b=cGmoVgB8+LxvKDNvaE2V9pwcTm9eP/Benzobj+mQfrLxeo+tqLKXA+wehzxqEvzqZWCaDXVM0Znxg4JQDZCeIjDYTNVuC2N6EY52vv1fKX2t7UATrDIsSMeWQTeqaO2YkBPyCzLkW6d/+nr/korKdbeaH/orv+5qBQNGWAqj2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947541; c=relaxed/simple;
	bh=Mxmh9m8cG1SINwjvCiVceMBEadI/CDBdioZFxVCsP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO8QKs86UY5D52hNA2ChC5JGnvuNemEzM999Od6NFo5D8D3XgrMlcmKxB+Ld3iOz8Efjr1ejja/AEP37P+Z/jLOt6C5kyZZ0cA1hvl8oJ4krpOGpKqls+4DZJ/pILbZRZ43dVhTb36ga8cXHF8+wyTjfyuzpf4Vgqk5eQS/jzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1dGZk9+h; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1dGZk9+h"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a536b08d63so824573a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712947539; x=1713552339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISLMFGOGyzbAhcth9c+vgcaA14m4ctbEbkD9TmYI1+8=;
        b=1dGZk9+h1Q2Q9iaogm/cvA5Gz6mo72i/ro8ANc77ALWCk9pUoomZCV5HtZc3B9gK78
         RJJnF3JQEY+ySY7/MUIZcs1FxPGHpw+DmUXC9pv/+7+W2dJXBu01QFHhdQbr8hsaGILT
         6bEfrqaZDwY0mgRTjaxhdHWP/m33XO5k3X7ISKx+hEYcvvzOJTNlWk/EJXyJ5IGM4BDP
         gSM3t5NDjJGirvNAWympm58UnEyz6seuba0uaRW9Li4ZYzsPl1yK99tD97M/ETKM3aqh
         4zX74JUJ3xnee0JvOAPmRXPI4OY7FNtyWa7ncsuHS1GKsX567dqXi3btGvG+z7n9YbRr
         ol0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947539; x=1713552339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISLMFGOGyzbAhcth9c+vgcaA14m4ctbEbkD9TmYI1+8=;
        b=R9VaCBStc+QzWHTRZjPYSEP0nNNszdEVGKW12d6G5rMyP2rehV06CZTEYH0qclx2XZ
         kzKjVk7W1KPnR8r+9bvFiPpRmcQ3r6aCJiQRPyhxyIVyAr9rCjrbBNdSx8znqYwTFbvL
         CyiUTDCpfw33HrDPYjzsG2wPAHt3SGxJvSO7/Ig3rHTM/edUOycohWXr+e8fYbpG+5fX
         ARXJlOvUDhCBvAM4FDSQ80eJx4HAMKPiUj2Nh6XhLINUxT8wZRmbYHo8ClFjPFAFqsDO
         rPXsOLGLPrJXvi8FNFEjifBap5YaOTgbvZtVcnd8MvbcxMSESKq4PvFqYmrDbxZFab2J
         szVg==
X-Forwarded-Encrypted: i=1; AJvYcCVt9N42P0Ca/Kcdqibs7OGewo0PY6PVkXHAEAfHcStcR+3N4ivwth+MW6U/WvKxgr/a2HdLdfoOrhUhz3as0FabABHGxSYgi6CV0M6mwI4n93Ou
X-Gm-Message-State: AOJu0YwwYrtc6bGv339TLGOM+LIp0jbDm+yXUD9Ybbzos+P6pxlKveGF
	5LtbWveT5DMQxvTZlCaYa4FXmNwvBRSD2BELx8IbzW9ZXMl2CbI9SoCPsyZg3g==
X-Google-Smtp-Source: AGHT+IErdx6N/Za0LUKOOdr+VzWwjNC6bZuRp56Svh5aVZ0iXA0UlC0kIs2SDcy0//cfbrlbvHooqg==
X-Received: by 2002:a17:90a:9af:b0:2a5:3e4e:29a0 with SMTP id 44-20020a17090a09af00b002a53e4e29a0mr3344779pjo.6.1712947538843;
        Fri, 12 Apr 2024 11:45:38 -0700 (PDT)
Received: from google.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id i20-20020a632214000000b005cd835182c5sm3009589pgi.79.2024.04.12.11.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:45:38 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:45:33 -0700
From: David Matlack <dmatlack@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhao <yuzhao@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaoqin Huang <shahuang@redhat.com>, Gavin Shan <gshan@redhat.com>,
	Ricardo Koller <ricarkol@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Rientjes <rientjes@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] mm: Add a bitmap into
 mmu_notifier_{clear,test}_young
Message-ID: <ZhmBTUIhypg-Kxbx@google.com>
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-2-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401232946.1837665-2-jthoughton@google.com>

On 2024-04-01 11:29 PM, James Houghton wrote:
> The bitmap is provided for secondary MMUs to use if they support it. For
> test_young(), after it returns, the bitmap represents the pages that
> were young in the interval [start, end). For clear_young, it represents
> the pages that we wish the secondary MMU to clear the accessed/young bit
> for.
> 
> If a bitmap is not provided, the mmu_notifier_{test,clear}_young() API
> should be unchanged except that if young PTEs are found and the
> architecture supports passing in a bitmap, instead of returning 1,
> MMU_NOTIFIER_YOUNG_FAST is returned.
> 
> This allows MGLRU's look-around logic to work faster, resulting in a 4%
> improvement in real workloads[1]. Also introduce MMU_NOTIFIER_YOUNG_FAST
> to indicate to main mm that doing look-around is likely to be
> beneficial.
> 
> If the secondary MMU doesn't support the bitmap, it must return
> an int that contains MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
> 
> [1]: https://lore.kernel.org/all/20230609005935.42390-1-yuzhao@google.com/
> 
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/mmu_notifier.h | 93 +++++++++++++++++++++++++++++++++---
>  include/trace/events/kvm.h   | 13 +++--
>  mm/mmu_notifier.c            | 20 +++++---
>  virt/kvm/kvm_main.c          | 19 ++++++--
>  4 files changed, 123 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index f349e08a9dfe..daaa9db625d3 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -61,6 +61,10 @@ enum mmu_notifier_event {
>  
>  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
>  
> +#define MMU_NOTIFIER_YOUNG			(1 << 0)
> +#define MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE	(1 << 1)

MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE appears to be unused by all callers
of test/clear_young(). I would vote to remove it.

> +#define MMU_NOTIFIER_YOUNG_FAST			(1 << 2)

Instead of MMU_NOTIFIER_YOUNG_FAST, how about
MMU_NOTIFIER_YOUNG_LOOK_AROUND? i.e. The secondary MMU is returning
saying it recommends doing a look-around and passing in a bitmap?

That would avoid the whole "what does FAST really mean" confusion.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fb49c2a60200..ca4b1ef9dfc2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -917,10 +917,15 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
>  static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
>  					struct mm_struct *mm,
>  					unsigned long start,
> -					unsigned long end)
> +					unsigned long end,
> +					unsigned long *bitmap)
>  {
>  	trace_kvm_age_hva(start, end);
>  
> +	/* We don't support bitmaps. Don't test or clear anything. */
> +	if (bitmap)
> +		return MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE;

Wouldn't it be a bug to get a bitmap here? The main MM is only suppost
to pass in a bitmap if the secondary MMU returns
MMU_NOTIFIER_YOUNG_FAST, which KVM does not do at this point.

Put another way, this check seems unneccessary.

> +
>  	/*
>  	 * Even though we do not flush TLB, this will still adversely
>  	 * affect performance on pre-Haswell Intel EPT, where there is
> @@ -939,11 +944,17 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
>  
>  static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
>  				       struct mm_struct *mm,
> -				       unsigned long address)
> +				       unsigned long start,
> +				       unsigned long end,
> +				       unsigned long *bitmap)
>  {
> -	trace_kvm_test_age_hva(address);
> +	trace_kvm_test_age_hva(start, end);
> +
> +	/* We don't support bitmaps. Don't test or clear anything. */
> +	if (bitmap)
> +		return MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE;

Same thing here.
