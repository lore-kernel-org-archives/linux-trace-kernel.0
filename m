Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4F30567F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288331; cv=pass; b=mH+GwEAf62dY0s7XqWmsFLsyzsmXMK6tTqkwoYsK87cnf/nFOI1L3WtjH5QrMcaTIuBfYSU7tjMGbxS3BNdQnAC9LJEyPUMAYzLL+iUWHI2WJjcqFP0slLzc2Rgw6TbdNi9zxq4XbaDJe0eeiJ1JpC5vwOQM4RR1xQ9ilKKnujw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288331; c=relaxed/simple;
	bh=mWVxXGnAXrLsmeGW6dcs9mbi7yfF/v+MCyKGHC9nj44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU5jOxb3Gt6z2abqY8hn27Y50vyiO+5TiGPOIWLGzZhTuGroB8odReKaCtn3vnuPmtE29t73d2Jz23lnILCR8ds6TinPBL9OGgJSaHcuC2XznBeuMbVhPhnCmFoOK1gFSDft/f5Z2yCAP2wFEwL52EF5UL6lWSo29R5OBHG5BKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOpyJLLw; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOpyJLLw"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-515548f390fso3241cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 07:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288326; cv=none;
        d=google.com; s=arc-20240605;
        b=bInfKmoI+CXyvsHG86oGb5ndWFDCeiXe/73wCKHicHF2kTRR0GJqdHhLbw2I2MLXKy
         CABHo8KJwcGIoIvVmRx8+5WZBoPp2Z9GtY9Ifotqr9iogcgOYGHDoSsRC0pbUsj7LHSE
         X6Oa2F4qM+F2PLl+qFf3KifldGBNOk7xImrF95sC44Np9QmocTsAUaW7Gs8EHw5I6X0x
         bHr8OF03sW4+rpyjnWf7Cmuo4X9LtJzAKcGUpxJl99/+a6o4CNuDyD5BiGui+y3kqFjR
         htAHcKkxxpNfwYTVKqMcSizIZ14X2qWyQipqGqUgQDNbfS0xQ/kkMBQ0JVukQNdeaQ2m
         efjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BXmdRbmYCHoIn3PGJ6dUolIetDSUosv3AORcVct4e6A=;
        fh=uBhqGv6AfDUeFNJCVMWa+HORCP5EBwdoJozrGylPndY=;
        b=WcoI6F81l3T5Dci+d589zp2XFFFyk4EKAgAgji2tvZEX/YtBcKNQtqUV5q/g3A1Y6G
         PFeh9GW7NpIOGsLK8sOWrLq+qCmQzAuXWx3ZpHoJEhQcQPxe2UDaVgFeLrvvGKvnUiJF
         6Kt5H71kz/Fkrt+nfDRqQrGOtdqS9Vimok8CpLZM78ugwgdfpAFCGDNIOMNINk0pcUQM
         iKlfJniJN2kyothEhfmRCJavkKbfoQ63NUohEfR1Dk5hc57EE308T7GG+eYESIRd3JWP
         dKEVJ45+RySnuAnvezrLR9v1NACSpRbQwevaDZEiRLefxrrHJEwnnER6S/K80iFoE4zb
         nQjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779288326; x=1779893126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXmdRbmYCHoIn3PGJ6dUolIetDSUosv3AORcVct4e6A=;
        b=pOpyJLLwMlvgp5JuJePT535f/8O8q6hmleeL9Baxy9BkjqiZm51QFbSyI/1jGbTlia
         88KLEA2HZAzKsEfpSwm+p26yNW37LyqhA8tin8CGzdooinpiINlmWAOgbHWwu71aAgYG
         uze2Zov6D3K/lWB6kqalZvTGT1vNnibaH0R6iYNmnBmOfpDtCGgIHJE7E3aJfC/rq+mu
         aK7h09eeCJ0hl7bp1/i9DxzsXBcRqrXixQhqw70BrNp+kbLO5ewX8PRv3anzWi/l0Dha
         AXaJnVszvS5LIrL3Qb72f+qlNnEHw0JELqrjD0vU1LmMwoV4bhZpWSLS+XtcoaAQ/bh4
         n6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288326; x=1779893126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXmdRbmYCHoIn3PGJ6dUolIetDSUosv3AORcVct4e6A=;
        b=nPII1OrAI3z5TXuIWuMpz0YL3d/5f0ZU2EOKlvwjLwPluA/cEmRxhvlDXsz0OZFVwG
         52Tu6P08CzNYfordpEjLlsRGx9ZPqdt4ERUeePZyQHinL7C8At0msa9Sa6GLAo4eY586
         PwsAW7UMj+Q/O3lZ765Ypw2pkqcaDFG+XMIhFGl5ijc/yOjWY8vGAH6Ueccsx/5H/fKD
         wz5nuZkpYCpdEyd72/eR7zq2AgMJB3aBaiitQREXlnePsNOraGMiGjzf4GfIp0SMGsoH
         k2LlfLKZlYVl64Qd13uHGVQpO5aoCzGD/xBiRMdmVEmW/j9OmHzf4UQQWu8VzZporNc2
         dQyA==
X-Forwarded-Encrypted: i=1; AFNElJ+4Q8oKcfIQwU23x3TujPl1d/7vEzK6+t8fuYlDJP6X636d29obJH72NcZm6f1MWz79oJx6k77LMo3xEeoKyFLFsrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZm+MD3wvlyMzeF+MXSxtRdOQsdeTSKR12UwTOKMWp5UvJNcpn
	oEWi1KBCPztVzhrEvk828evRhJ7GfDCIv8nkQz41geh0jgizTq6pAjRioEYJsOvb7nb0yQ1beZX
	p7qDIXnUoQieHjbtkfTITiBYLCYgNgKYQ+eurLO0Q
X-Gm-Gg: Acq92OH6G6jgnyDWUYnMAIaLHsuUsYuzPFhFAOyxwynj3u1Z8cJRPt9Lj5RWkvVaymw
	YCYBFT60t5KncBB24GRmrWIDi+nEvoaI/p+cTkIUgGVmFonJWDRBs58tyPCqfpaHCstSSqEp2VV
	4ycbTBswG2rwVdCHV7rFBSN9h53kxjTXcJZa4N+ydRSBKrPrQTpgUDRT5Ot7Nbrj1oSEMiXftHy
	5ucbIWL3/xMTiSL+yAn7fuX/q+uXdetJ814nPwFesbgb78tHkP9GZ+gHxDRamRx/fZn7rwCwWFg
	ZCyBCd5JP+GVhg6voD1e3v+ir58Hjw==
X-Received: by 2002:a05:622a:5d4:b0:516:4197:361 with SMTP id
 d75a77b69052e-5167937f111mr20387831cf.4.1779288323895; Wed, 20 May 2026
 07:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-13-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-13-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 15:44:46 +0100
X-Gm-Features: AVHnY4KqHADZuRuQJRLOmHo6Gq8ybi2wyD-GO9LIDMQsvWy73n-zAaUp_TqUxxQ
Message-ID: <CA+EHjTzDx01W5Xy=eMg54DGe8-+Pfz9u8XDgfSDiAJYu8MznmQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/43] KVM: guest_memfd: Return early if range already
 has requested attributes
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
> Extract a helper out of kvm_gmem_range_is_private() that checks that a
> range has given attributes.
>
> Optimize setting memory attributes by returning early if all pages in the
> requested range already has the requested attributes.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  virt/kvm/guest_memfd.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index baf4b88dead1f..034b72b4947fb 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -86,6 +86,23 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
>         return !kvm_gmem_is_private_mem(inode, index);
>  }
>
> +static bool kvm_gmem_range_has_attributes(struct maple_tree *mt,
> +                                         pgoff_t index, size_t nr_pages,
> +                                         u64 attributes)
> +{
> +       pgoff_t end = index + nr_pages - 1;
> +       void *entry;
> +
> +       lockdep_assert(mt_lock_is_held(mt));
> +
> +       mt_for_each(mt, entry, index, end) {
> +               if (xa_to_value(entry) != attributes)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>                                     pgoff_t index, struct folio *folio)
>  {
> @@ -649,12 +666,15 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>         pgoff_t end = start + nr_pages;
>         struct maple_tree *mt;
>         struct ma_state mas;
> -       int r;
> +       int r = 0;
>
>         mt = &gi->attributes;
>
>         filemap_invalidate_lock(mapping);
>
> +       if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs))
> +               goto out;
> +
>         mas_init(&mas, mt, start);
>         r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>         if (r) {
> @@ -1140,20 +1160,13 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>  static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
>                                       size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>  {
> -       pgoff_t end = index + nr_pages - 1;
> -       void *entry;
> -
>         if (vm_memory_attributes)
>                 return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>                                                        KVM_MEMORY_ATTRIBUTE_PRIVATE,
>                                                        KVM_MEMORY_ATTRIBUTE_PRIVATE);
>
> -       mt_for_each(&gi->attributes, entry, index, end) {
> -               if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
> -                       return false;
> -       }
> -
> -       return true;
> +       return kvm_gmem_range_has_attributes(&gi->attributes, index, nr_pages,
> +                                            KVM_MEMORY_ATTRIBUTE_PRIVATE);
>  }
>
>  static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
