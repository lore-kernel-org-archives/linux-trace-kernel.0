Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033518;
	b=nsmwu/XtQ/lsX9sR6RNc+bzXBn9sCiU2tl3cnaLr4Us31pO/1fyR3GQnL0HwOMqXUQOC
	 9OsvDcJEROMEx6phEWQXKOnKnk3L2nJPW+9WyOfYfQT6Fw1tw/o7hrjosZcxOpEH7BnDk
	 3h2gs4oRayYznP7v8hQtbR6k12zCk26Bve/4My8wUDL/b/QCfG4FLszwCxtRTrslXgQ/9
	 26Jntcdez7ywKgVRRMNy5iJGgc2XBfqfJEcK91y+cSDaRtrg7L1MYJBRLZKwfSRHJjIba
	 klGpl0ZslF0+Kz41r0mfdNagIeBXYFdocZri+bYlL5pRE3WROQqFn+kF9BHEzM4TYfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
	b=sl6RbmWhB/LdLhzL9Gbim9l9V5n4hwd5IgiuufuoXiY73406vS+MuHRZdaP3AyNFqLTj
	 hhQHOdWkmmf4Fx4gkm1r+yVG9zCuiXzMZyHQip+1MIl/WAqTFtZqjY2VMcQle3x8Dlf4W
	 IyHhl6FYMuOYn2RedZSXmIcCiPlAt/TAHqfuGOMCdVRxdn6PSU6mUtov9I1+tNLi2Vw6g
	 M7nRIO2mt6wa3bKmazuHeEE4sAyAlm2xeAFx1UZ0FV7/4MLxOv1YLXBCpO/70LM428eTA
	 xlXelZSnFK6crdCh7R4ASMmuIf3gBJhvwTgmhc5VtULTuD0gm3g8HeSerXd0tORCqOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uMdD4p6K;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313AC606A32E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 16:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313AC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uMdD4p6K
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so14085695e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793033516; x=1793638316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=uMdD4p6KVakawh179kk8FHBLF5CXO9wel4SSzout3Cv109M7RXUmUmrC9sJPIgWsSH
         9ABB0JV8Z5NUOTGY7GHDP30lVe2PF06Z5Rb3sGZu9AHhb2etfX/cHvQCyiGlPRRn3Cbe
         CFLeOIxpliD0sRukb/bWQTt0J7k1R+JKXgZVJ1KMgCeuSSmAA57l+zaNLFl6HnQ/Ahaw
         zQi33bNvGhiw52l+kM3vvg4nLkAUFO3pt8PlK45P8ZDXb1WCt8rTiBonnjcILrrKElFt
         fjlgVO/cXdwsEDjIa5uw8AyiN4qBUQXEww/1M11No4eGietgwgSL41okjBF4DwT+0EjC
         VbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033516; x=1793638316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=hyPdMO65fFRGZM4xW8euRmsJXxCvDYpOoUAWC8jq/vMqgAh9N7Baw1FRxB1vaCZEQI
         MaLD6r5ns9P+4dDSQPBwyRyvAUOQrdUs88egvZG9RDtyyix6M99LunL+SxsEnbJL899v
         itwImmZRQpt44aGiuMvBzJbmrilSupisz79xzT6zPX8ZtstOyOlzGfiEAPSkYZeGnZkR
         XvtlGeQ05+3+jVXfaNrVWWf6jWZhnZnpw9clga54wQ4PAONoRmCv08Pecw8qkAASsDOl
         GjnsFP5zjm7kEer25zGedwzUV125JDtDP/nkG8dTFu7gF4WJPZlyMqxlG3ECROzDf8ya
         /lbw==
X-Forwarded-Encrypted: i=1; AKwUvBzk0NuxRnMPotAgHUTPcfayxT4mTWXU0IMk1ZmTgMPaqX3rQNJMH44xiQ7j9K63LsOcLqkueeutON1Ki00RWQocdAY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAwWkz3it22bDUljTTpEBJ6zjOU8qlyN+prv5SGZ+dVvk4UGCM
	JeXE4vpksrqjEOOt7Gj8CNT241mcsMRIjeO3rmq3Ak4yn/LnYPqLJA+ifNUU/4j/HA==
X-Gm-Gg: AYBFou1QXOQR2cpllY/DromTukUcL0P+UF19y8zq3b/HM0z3qV+0h3PL9FwwA44AqTW
	fqZ5mx8tG0jjH+dOIU9F8scCMiewJEi6aH7ZEkTLUGkAtYdtsFoxvsOEgyy9GGRbmPHZ+gB6mvo
	dSIwJ1YsrkTSUfypelX1KpQ0gowGXcurUaPxSPVY0WojJnIF9r7qlEdyWBtrK9yw3EXBNbjNdq7
	Pf9WjHxVk3NFluV1EpLtR9KSnxOq/76JvLKyE8jU1jHBpvVHiiUD2BcOm79grWYoCfkSNpT1eR6
	nclRC/4sJteLJ/TdU9+5HGDaeBcrwQ1KOefiGF8WsibrOz/cUA114TF5H+gXawM7nTaEpUniD18
	OqRdamgReXEDSYwS/1GTIXdO4WDJKyKcVOu/oRJSXM6q8hag7oKLbCs51zsr5D5hOq2Nav+j0nq
	rM/0+Qq21E73BUiiHBRmfYvTmgiSCDTzliw3Jf0PXgKFaUDPGYuLBYqhGsZf+Iph7lHVL4xrG/A
	G/338tZJH7W0EqFYaFRndFifgPR8R9oRgnTN4dJgvwajrEPoSGhuJkIj6aoR5lkDdf3v3j/zXDa
	Tw03iwXOsxt6tXFXYnFajZv8
X-Received: by 2002:a05:600c:46c5:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4a35acba20dmr143926245e9.35.1793033515974;
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a293sm204540985e9.12.2026.10.26.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:51:52 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <at-FKOk_-OrKTP8H@google.com>
References: <20261023145459.47516-1-amachhiw@linux.ibm.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023145459.47516-1-amachhiw@linux.ibm.com>

On Fri, Oct 23, 2026 at 08:24:59PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> period from early_trace_init() through smp_init().  defer_init() leaves
> only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> up-front, and on kernels with large static binary footprints (debug
> configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this pool.
> 
> si_mem_available() therefore returns a false negative (often 0-1 pages)
> across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> 
> This failure is false: the buddy allocator is designed to replenish
> ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> short-circuits this on-demand growth entirely.
> 
> deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> completes (it spawns per-node kthreads and blocks until done), which happens
> inside kernel_init_freeable() — before system_state is set to
> SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> and si_mem_available() is accurate.
> 
> Use IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) to set i = LONG_MAX during
> this window, unconditionally bypassing the threshold check.  On kernels
> without deferred init IS_ENABLED() compiles the branch away and the original
> check is preserved unchanged.

Commit messages are not LLMs' strong suit.

Otherwise.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes since v3:
>  - Replace #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT / #else / #endif with
>    IS_ENABLED() + i = LONG_MAX to avoid duplicating the threshold check.
>    (Vincent Donnefort)
>  - Trim the in-code comment to one sentence. (Vincent Donnefort)
> 
> Changes since v2:
>  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
>    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> 
> Changes since v1:
>  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
>    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
>    completes, so the false negative window spans both SYSTEM_BOOTING and
>    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
>    boundary.  (Sashiko, Vincent Donnefort)
>  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
>    check unchanged on non-deferred kernels. (Vincent Donnefort)
>  - Drop Tested-by: guard condition changed, requesting fresh test.
> 
>  kernel/trace/ring_buffer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..09c02e838c4d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,8 +2463,16 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
> +		 * will reflect the actual available memory only after
> +		 * SYSTEM_FREEING_INITMEM.
>  		 */
>  		i = si_mem_available();
> +		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> +		    system_state < SYSTEM_FREEING_INITMEM)
> +			i = LONG_MAX;
> +
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
>  
> 
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> -- 
> 2.54.0 (Apple Git-157)
> 
