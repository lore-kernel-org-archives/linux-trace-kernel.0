Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197604A0926
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823131; cv=none; b=IQEUUqc6uxUER8NkQWQ6L3xVXSjHJN81cIFzwYYNY9wxgYQ1K3dB1mipKXch2uf99IFk45DsqZ4EzU8PH9AS6qoD76QpI4kYoLL4ROgmHTKlMzW3NUPHBXsgDY4DDuIdaEsWrdEvdFL0v1BBGxFFaZjGLtBRuUF80f1yiL/yyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823131; c=relaxed/simple;
	bh=F1H5MyQMuXam71E+nKkOYHzZwg6EalJS+Z3MC7TNSRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W28DfhAGUVDFukxdrf8EN18YEOx/PoCgML5VNtdRIN58+rlyu8JBcptq7mf2PRT/6aRsxCGZenl2JIhgy1GFLSULizFu+qGDmZWgxZ6qVAkK3hM0m842Nah5XgZcmoIBQKeN91EhGOqdMdtt2so656kss/sqw/u9BrEu5U4eh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OaRyrzcm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OaRyrzcm"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso1239570f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791823128; x=1792427928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuWCbCHALjFKQvI6kk2Kyts8iE/+EiR+kuOdFcAFHro=;
        b=OaRyrzcm/6gD+o7+BEmLhi5mzagEMcFzuXzlcCwSqbFaRsmfrW7kG1B984Qbi1sHLM
         QQKi/qpfxUsh9eKwC5IIonJHtnA4zkcTKx0I4+UHqnQw5skScqyv1WjxBlk3Jd25pqee
         eFCfOY1hi/qk4A6NSnzHH8KWQOcegWZjFhRCLCRhlFBqvWQXx7asu0PKdUqBy0RVhaZ5
         jK6UH5KQ9j3+NpkJXVZK+uN1u4XqMcvXuTJryuEl6NztgY5K90I189ECQk13Gq4Frg58
         44b1BiQKtUsNG4ox9yeeX11fMX5/q5ZawnI/Dy2EixgSKifp4beRY9QJroMNe7r+Uzn5
         PUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823128; x=1792427928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HuWCbCHALjFKQvI6kk2Kyts8iE/+EiR+kuOdFcAFHro=;
        b=b7Sw0U+a6QK6xJZqhYGxwdivXnbSe9Y6ypXoHGgoR+RMCeepmp1+zd39quPk9Kr6mv
         fZ+dv91iVOLH7Yo1MGXiPrVg0I98MhtJjKOf4NADM8XOf0Yp8Bam9KJPQ5f3ONgEK73g
         hCxI7FJbRilaN7I23ErbsxDMTArQ+eAxuUV/gUyes5KqQ/EGEWeDL2uNisNo3lJ5Y7QH
         KpJeHaozUF6iM2/kbBiLvqovBnK8uYSCc7l15VN32MmYz92XYxJSl6t+eBzgO/WKBP/e
         N1PgsYYAtkCLUoTcFRzbpB6EhD2juMNYgEmpvw6OToMTR7QQv85d09hsGcZup2Pg84/8
         mwlA==
X-Forwarded-Encrypted: i=1; AKwUvBzEGI3dJGTnt0Xve7/nAJN0uA3zQ+T8Tq+6SuZiQmcT+QMwJev4eZF6B3fX4pPmElQNy/yolxjm+kTpBDZBufUiCPY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIViPLl/48l8BYQDej8WHsmzxdnuG5K9JZ+c5eNcMQKneF6kItf
	n/4aZoxCid6MJVPPUiuKKE4txlRhP64IrwpjeyoPhrHt8NTNj4Tnm9kE26bpp768mg==
X-Gm-Gg: AYBFou3YM34HqaUBuEtWR0O2vuQIhdWWPvaNUu4wHLZVHXHKGTfhSZlP+BEEABH7s0K
	O7PcFFAdhzBBlscnILISiXffRu+q7//GLgKNeY01IxHz/mpWiqv1/qjTDpvNum77lG80TOjXkXB
	sog/Darw3flfRyhVD5hZlej3nGqwNz1n7ioM66PWF6MeylpESlHDjeVvhCWpn95I6shEsroJuDq
	WGD1YzlHzGFoJOD1Pmf9stpAm0OS1hapiGFPvr0OHvyRhvSrtC3M0b1FWK8Vf7JiBHmYplq7/j/
	+/VNKJu/lxTY9UJuGs72rLKbtV3notZBHUTjo7XgHpplC/KDHhJSHID6UWxRO5OV/GMomh/DbhL
	AuECdv3BxtSc2VpMKYRq0L/VtHOFPgOjKVkUeBUo+6oPtssXQyhW21+FtDGqiDWwwCxwaKbH3qb
	1iVo49VeXaZE+7alnTogbX+pUvonaUtAzL3O+fd+yMkhGrBh6XJRtaVnI5l6lxrdVOnUDGdvnj5
	O+i6TAuFxoXKN3LfPTuemB6FboMkS7iRHQPinKlbPI=
X-Received: by 2002:a05:6000:4a0b:b0:48b:11e1:8bc8 with SMTP id ffacd0b85a97d-48dbace678emr18199465f8f.39.1791823126911;
        Mon, 12 Oct 2026 09:38:46 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc91e2sm297646f8f.55.2026.10.12.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:38:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:38:39 +0100
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
	kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Do not check si_mem_available() during
 SYSTEM_BOOTING
Message-ID: <as0NDyaXsfQnWPQ4@google.com>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009163557.88467-3-amachhiw@linux.ibm.com>

On Fri, Oct 09, 2026 at 10:05:57PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> defer_init() leaves only a single section per node (e.g.  16 MiB with 64
> KB pages) initialized up-front.  On kernels with large static binary
> footprints (such as debug configurations enabling PAGE_OWNER,
> DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG), the static kernel image and
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this initial pool.
> 
> At T=0.000000, watermarks have not yet been established
> (totalreserve_pages = 0), so si_mem_available() returns the raw free
> page count (often 0-1 pages).  When the snapshot buffer or global trace
> buffer attempts to allocate 2 sub-pages, si_mem_available() returns <
> nr_pages and prematurely aborts with -ENOMEM.
> 
> This failure is false: if the page allocation were actually attempted
> via alloc_pages_node(), the page allocator would trigger
> deferred_grow_zone() on demand to initialise additional deferred memory
> sections.  Checking si_mem_available() before attempting the allocation
> short-circuits this on-demand growth.
> 
> Skip the si_mem_available() check when system_state == SYSTEM_BOOTING.
> Once the system transitions past early boot and page_alloc_init_late()
> initialises all deferred memory, si_mem_available() accurately reflects
> system-wide free memory and the check operates as intended for runtime
> allocations.
> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  kernel/trace/ring_buffer.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..a9f82e2f8fad 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2452,9 +2452,15 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	 * memory. It may not be accurate. But we don't care, we just want
>  	 * to prevent doing any allocation when it is obvious that it is
>  	 * not going to succeed.
> +	 *
> +	 * Skip this check during early boot: with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
> +	 * NR_FREE_PAGES only reflects the initial non-deferred pool at this
> +	 * stage. si_mem_available() returns a false negative while actual
> +	 * allocations succeed by growing the zone on demand via
> +	 * deferred_grow_zone().

As Sashiko pointed-out, if si_mem_available() is only ready after
page_alloc_init_late() when CONFIG_DEFERRED_STRUCT_PAGE_INIT, then checking for
system_state >= SYSTEM_FREEING_INITMEM might be more correct.

Also I wonder if we don't want to guard with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
to keep the verification when CONFIG_DEFERRED_STRUCT_PAGE_INIT is unset.

>  	 */
>  	i = si_mem_available();
> -	if (i < nr_pages)
> +	if (system_state != SYSTEM_BOOTING && i < nr_pages)
>  		return -ENOMEM;
>  
>  	/*
> -- 
> 2.54.0 (Apple Git-157)
> 
> 

-- 
Vincent
