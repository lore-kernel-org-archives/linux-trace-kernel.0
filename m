Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091233EC2E6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287494; cv=pass; b=I/uBTTQlcZnzR75QDPptTIjUbDGCcPl6k6VuC5TAMgfb2QzEOnJlORJdGmBCoSpSshsdkzKbLENIrSQTecWxFIBXjhvn/VZDHaZNe9d4B09VjRJWj9X2BwG4Qa99YUBupGx2T5RP5g7VEqDtSsXibCpso5K2fw53Wttskfae204=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287494; c=relaxed/simple;
	bh=X/hV5ljxWA12U5TVhXUBeSsDz7VPis8ajbh1wO1J3cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWjeNa9qTgtc/u42MpjRDQ/GPxxPONtu4fAkvBC7XhtDjqvpvsta1jMnyjUnL7ZqO3l9HaOFJ8CywbCQrx2AJkYbfoIx3tUSR9kypFVI9il5QhCKqmdu7GTb1vhDiEIYISRiq57kKt4gAL5Ujec+JtAoJAoiOTHXwh1xPFE5YGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZBGWHze; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZBGWHze"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d6b393d60so9651cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 07:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287492; cv=none;
        d=google.com; s=arc-20240605;
        b=hkCPOHCRuofG1MkqeULwC4yM76x5E5ixqK1uAKz239h+0lvp0OGLsnpE5QgpjFFCU7
         rcqR2nkPgBq2BRPsre2KSc2QOkEOQFYwFDwrkOiBBOCwVEp7tQQqsKiPFg5TSlFljc26
         4XycmAoJhg2TocOsj0Sl1frZ9LM5Cc/0p8xMoWnDBjMe8IGdigSRcmzvu0zU6BlM67I8
         WtC6mhqTrCxWPo9B7LiCec/QHou02twWmG1fzRpZutctKmNaCzBK7PpjHvVsW/BlLDEA
         gwYaoxVWlT9Kq6O0LZxZafRatG6mT9karyNU+kC3gCkW3VppegyLhOGcab943mub7gi3
         FMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7N5NasgJypbMdlNYb/j7e6t6w9YfyUO25pmJjvirfi4=;
        fh=zYpQh2KV3dx8Y92coaFMXseTuN0ouS/1BdMskmnhuYs=;
        b=Pz2xvXMRiretPe4BloBQhOWPSkk3HVdCbAoSCvqPeuqY9nH6knGMntfcGb0L+xw6iU
         amG+laQn5kptD/AgBMJfC5H6jwHttNMReQdu+JnC7tLyXLuBlC2Zf6+vWAzkTLwlpDZd
         vPRYI5zuVh/zTfGOyG18gbltCBx0JNSrzJFQRW0reDEWOVxEojS3BAkzLbxaP4eJUQv5
         p9/DotGqOdbItB2b6hRFhZiXfydNynYMe2jUJXxtgCL/7xLVC/A7KUUnasHtApXGpEJ9
         ZB3MfR3UJgQXMM5HQDri3b+l904O5rbb6WTlpCvKP2BYd1Zk4aANaxbV7BaXnN1M7jKK
         83HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287492; x=1779892292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7N5NasgJypbMdlNYb/j7e6t6w9YfyUO25pmJjvirfi4=;
        b=DZBGWHzegKC97UHFZ3+t/tHB1FYQc/mvtem+xj+xKBFU/CxHRQ2H2bbxUsxsAQ1jVk
         41gkAXiUWSDAUVNdj3LugPRQzyBmuEIDRX5atqewM7Y4F+Svvh34es898m9fs3N5j80i
         EBvL4la9LJaDwTHY/EHaeQ9Yp+MsNeDA86PlcalVWc8NNa3I4viQM5Xu6X5hkG+O8ZwU
         RWD4DA6rZwN6u8FHVrV24WfObVSG90Ze5oK0YgC4o6tYttjQgTZ5tgi/5WcGXietxTLQ
         nBbKAqAfcZ1YF/vm0UDTj1bqmOFDGNiiUFnkv4MbTH08VBe+uXugUVRI0gC4kqF80Vhl
         9jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287492; x=1779892292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N5NasgJypbMdlNYb/j7e6t6w9YfyUO25pmJjvirfi4=;
        b=DZDgo5Uf5vOWQ6GtnaMhUwlIh4+R7YmAYK6YHdY2E/rkGThQaSF8BVTmiPHQ1sVyNi
         LNkSOsfHM+h+TjU6KITMToKFaJgfQEMIyGMsETENeFqU4ikiivwjNRLak+nyHyuh1BwG
         oVufAj/rpXn5yWh14DiVCfhgBwz0ncPs73llamoUHZ0X8XDhLxLyuMpn/gCdC21EvZFr
         6XNIX3424X/GQO71h1T83twxpuYN6RYjYcPelLaRD9OTRZQPFNZ79C9YDb/1doVO/sBw
         LgJJjnTKcGIE+W94RxrvVSR6vOjXQnubL4i28P6ZCRiVM53bc7rLaOyG9eL0rCArYbVY
         3OaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jmJM5ynirkjcHVuLwj4+216oFpgV9b4gDhsC0WDXxIG5xSKiMg4XUll+YiPSPUw7ZWEZRn09y5tbvxkU8V2VA2Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyR6gxJVghZyFftBUCzSOZrVnyshArLXBnmqUQx/UYxKsgvjc
	QVhEimOI+DSI43aGZy4T3Fq3wA37Im9VPkSowH2OAVkFYMGC/vA4qNdzeeA5wkZkAcMmBWtk6eK
	RexZjkPWNUv9iXwY9GLUwPiFHuorf9nbIzfA/k7s6
X-Gm-Gg: Acq92OEdkrcmjIUo49B6Bvo1OE5MUtfV1l4hhNcv+9U/lBgu5YJLz4UE+dgpAgYlcuv
	wci4TSmHk+ycVQ4VceIsi4whdaWP9VvpYZhxTJXdGWCP9mg7HF386QEkfX6adn6yJIhKsz802bW
	u+I60NTDdrI8kn7L6n42+RbG1t48wyFu55D9WDIwolwataTsWQ2Knz+/94d45DKO2Tu6tDBdmX6
	j/FqjSvcMBXRN2gc7PLf3GGd0rsmq2byLLGak7BqbAuBZBE2zb3hG54Bti0Z7DEdnQ+ER+/OKuq
	6+34TkFSJvvkIHneNWU=
X-Received: by 2002:a05:622a:989:b0:50e:6360:96e with SMTP id
 d75a77b69052e-516791fe73cmr46959761cf.0.1779287488674; Wed, 20 May 2026
 07:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-12-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-12-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 15:30:51 +0100
X-Gm-Features: AVHnY4Lo4l5leoGwp4MOUhUOXd-ZR6_GPypj6bN4fnpU5Ptxtsw2Fzt5rIYMAIk
Message-ID: <CA+EHjTwOfJ=nCRoX3m5uDt=CcF_zrqGsZVBBmo4MscmPqrBxOA@mail.gmail.com>
Subject: Re: [PATCH v6 12/43] KVM: guest_memfd: Call arch invalidate hooks on conversion
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> When memory in guest_memfd is converted from private to shared, the
> platform-specific state associated with the guest-private pages must be
> invalidated or cleaned up.
>
> Iterate over the folios in the affected range and call the
> kvm_arch_gmem_invalidate() hook for each PFN range. This allows
> architectures to perform necessary teardown, such as updating hardware
> metadata or encryption states, before the pages are transitioned to the
> shared state.
>
> Invoke this helper after indicating to KVM's mmu code that an invalidation
> is in progress to stop in-flight page faults from succeeding.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Minor nit below, but lgtm.

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 9d82642a025e9..baf4b88dead1f 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -603,6 +603,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>         return safe;
>  }
>
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +       struct folio_batch fbatch;
> +       pgoff_t next = start;
> +       int i;
> +
> +       folio_batch_init(&fbatch);
> +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +                       struct folio *folio = fbatch.folios[i];
> +                       pgoff_t start_index, end_index;
> +                       kvm_pfn_t start_pfn, end_pfn;
> +
> +                       start_index = max(start, folio->index);
> +                       end_index = min(end, folio_next_index(folio));
> +                       /*
> +                        * end_index is either in folio or points to
> +                        * the first page of the next folio. Hence,
> +                        * all pages in range [start_index, end_index)
> +                        * are contiguous.
> +                        */
> +                       start_pfn = folio_file_pfn(folio, start_index);
> +                       end_pfn = start_pfn + end_index - start_index;
> +
> +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
> +               }
> +
> +               folio_batch_release(&fbatch);
> +               cond_resched();
> +       }
> +}
> +#else
> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> +#endif
> +
>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>                                      size_t nr_pages, uint64_t attrs,
>                                      pgoff_t *err_index)
> @@ -643,7 +679,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>          */
>
>         kvm_gmem_invalidate_begin(inode, start, end);
> +
> +       if (!to_private)
> +               kvm_gmem_invalidate(inode, start, end);
> +
>         mas_store_prealloc(&mas, xa_mk_value(attrs));
> +

Why the unrelated extra space?

>         kvm_gmem_invalidate_end(inode, start, end);
>  out:
>         filemap_invalidate_unlock(mapping);
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
