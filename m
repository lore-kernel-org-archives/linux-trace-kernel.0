Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D282866
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857355; cv=pass; b=FqvbzWQxyBQdNVpi6Id754vNqYQkF2ucHWvkk6mGUZIbKdry777F0GQAsRobm8P7KWgxahX1jRItXzVraJDZdZeqGTZJ/UHGUS88JmpI5smBl87CAbuEgj9T5TbfQ2clExBiwqfySYDFrkwPDgVhBgwNlJEX2ft4P/S6WD7HR6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857355; c=relaxed/simple;
	bh=8G3Iesv6H4uuh2/K8K/iWGA8fNXhb2ucD0ih1NRqF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA49crWIuVJAaHCMT+1hDbCj0CTtBG5Av1iibQYMcY10eBkJn+HzkdB0VVrTREFxshcaX73KdDOg5yUPWQtlct0BaIlCfroyEO/qDV9shSVWIaA+651rCosVJiNksRiar74nYx0vUBqSFnehUHi1gr0EsUapKvz7JE7Ml4Rla8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/tHg6j+; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/tHg6j+"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51765531803so197701cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 01:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781857353; cv=none;
        d=google.com; s=arc-20260327;
        b=cBFNTG+3t3U7bLB4fyvNgKbyaAtihyf8hqP2xEyMNoMh+VZJ4QiF5D9SZO0nYTtXyC
         EPvpb3Q6JYtJe03frD7qAHnZFy79FOJJDbEdBeQf9mXOJPIWAIsDzhOUbKw1uGjngQdY
         xAo4wqV5A/1amM0FAghAY6Yxg8MdH+YWUkCB/xQJk6/Jf3hp3iE1CiO6v+I6gauDpBm6
         fdP8f7TcK6XNh1G+ioh0zm3jgh6X/+gFDvnc1PsckOF1AspMvnSyAltxebz3FqPVID4P
         Ff61DFQo3Aqsa4Nk44sKeyPnea+rNcBTVNKb2NzLS2qj3n0waHPtNX89gU5ON7fMynrM
         sA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WecHCv13rG5Qr395P8gqLpoRjr3ajKQ15qH0wjMFBvs=;
        fh=HKQkAR1wKQMT867LuwTogLG1oFCTMy7pnk2sv1RrX9w=;
        b=PlxhpbiIr2WCOML2SWjbNb0pEqqJSSOB+3+qVPQEJZySrdjq9eGwhwd4YkIi9JJGyT
         7A2Z5eHdz1amNUfVrbdZWtaAtnivcGfmzrHr8BQJ2g5u82JkW5R5noXNq3H32qrM1LCt
         oCbnRSd427psw4mAiNdZBPE9B6nGeMthPeRTqH9t84CMYyDz6QgBfR9UiJWBlrengYd9
         czQeEwMqOZjMOE5zLATAxKaQVolT4A3wKtTXOl5BMmQFQ1IpTPLQYEUkOHjdCkg4TsVG
         lFenSXYd/yANldTU/KdZbYLY7678q3bHkj7vfNZqNtD8XbBvtFUweAbMa8t6q7iomNF7
         ++Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781857353; x=1782462153; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WecHCv13rG5Qr395P8gqLpoRjr3ajKQ15qH0wjMFBvs=;
        b=M/tHg6j+C6Vqmb/h1lmvTrgicl8vxiiubgA1EJ+cghpMBmPAQeFLRb4qCFDjAs5lmJ
         Z7pzAd/CL2EhpDHkaENZPa7iepzhfPWHHVx4xagYiJ+AGu/6ykTbOCZyWzum8UoUhs1t
         YS0MyqEUR4MjiRqyIFBFrGQ76ZDD4MTTCABWChiekxTXWqdfB2bAJRJtIgN34ew0SD+X
         2cF3mifgNEivRi1v5D0n76RSKqlY+iuWu02K0Nvhacpop1TvVZl75YlzAkMugSp2PQyk
         1Gd2nQhKkiHpxkfOnGZUUvyHLz5kXGhLyALD0aQxxPem3zzbBj74S/5vya2VGnip//EZ
         kHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781857353; x=1782462153;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WecHCv13rG5Qr395P8gqLpoRjr3ajKQ15qH0wjMFBvs=;
        b=iVOTlQ8de3OG2FzCMEqwRVncVo8y6IftGwOaxErnNzRXjuP3/Jr4jTjWbc4un+iw7j
         zqMC5hCSS7JmzItXM5OQkdcNlFUGPtfPsiTs2CYmKpzhFkQ6ZMf8wqGR1mLJ46ixR/BJ
         mtuhI9fsJFwlldAxGmgvYwpkkCL75KiqGGBCccpQEurbO+Dl/lOqCprZkGuCSLgVyF1S
         YDu7qo5NVL1L0OPARpvNJQRSbIZ4qpkJrUQUxk7pl2QLdoB6S+o+3noolqUfmbXP2+68
         Sd6dQf1pAUCI6V9nLqm1nD7eRAgeQgaCD8PTwsal0hQMSNuennifT2mBvp+sSGcG0VYK
         gBCg==
X-Forwarded-Encrypted: i=1; AFNElJ+Nb9By8dDaZ9i2dX3bXG4ZY3tDTdqTpYrYglLyKQ4An+W6INvvLGT/SQsdiWl8ERYCOBn9DyMgCq/IR52LVXe4lho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6NjIyMZ62+HLT58faOYFeBPrcxcIdpPpSDmrEkGyF81LM9fK
	FBdBJOYDEevxtXRczO/gcqjrhBYQp21V0QHW+gcXnf7E7M2ng+1dT62ZOlzkqNhmKgqIaIabnET
	KTncZ30jA+nKBHaPF4uZFrfwB/qPC8ozhxWSVFrW/
X-Gm-Gg: AfdE7ck/sGpElC9FLVYZ4JGc1zYYn5mhsPQiKgcu7VPGz2aGfIDl4Kzz7ZfL5oNa9qW
	ZxNJLRoKqbZfSggWj8SlABkH/071DqQZcw3afp3GvwoTX/iz+zdtyiRdW88Ph6YUaaKK1S7eP4p
	nc6w3a9osji+gAmUBdmGqOUJrc0pQtwOFH7+582QjEN2kpWWqnOuhh+ffn8whH0ruaac/MLsxcw
	Ehk01C2tVBPviTXV4IrPRHUBm5HFeCFNpulRHgFuh+ymGtXoFQJ8ygJMCeLihuxLg5MKUfK5zki
	M6ywRloa
X-Received: by 2002:a05:622a:1b1d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-519e877e8c5mr4724561cf.1.1781857352209; Fri, 19 Jun 2026
 01:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-8-9d2959357853@google.com> <CA+EHjTw6x-mxDnJjnhE-6SV73tMrb0paKDTtOC2j6zJ1fXZDLA@mail.gmail.com>
In-Reply-To: <CA+EHjTw6x-mxDnJjnhE-6SV73tMrb0paKDTtOC2j6zJ1fXZDLA@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:21:55 +0100
X-Gm-Features: AVVi8CebV0NVi3MbMdc8DhRrav01L0h7Tt3z2YxRqWoRJXqhOu4WExRErk69dGE
Message-ID: <CA+EHjTxu32nQ+vPV7Zmcw76_-V4g2_g=P_UzRnnO2dP1PFO2ww@mail.gmail.com>
Subject: Re: [PATCH v8 08/46] KVM: Provide generic interface for checking
 memory private/shared status
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 09:19, Fuad Tabba <tabba@google.com> wrote:
>
> On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Introduce a generic kvm_mem_is_private() interface using a static call to
> > determine if a GFN is private. This allows the implementation for checking
> > a GFN's private/shared status to be set at runtime.
> >
> > In preparation for choosing implementations between a guest_memfd lookup
> > and the existing VM attribute lookup, rename the existing
> > VM-attribute-based check to kvm_vm_mem_is_private to emphasize that it
> > looks up VM attributes.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>
> (SoB fix plz)
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
>
> Cheers,
> /fuad
> > ---
> >  include/linux/kvm_host.h | 12 +++++++++++-
> >  virt/kvm/kvm_main.c      | 15 +++++++++++++++
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index eb26d4ea8945a..3915da2a61778 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2546,7 +2546,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> >  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> >                                          struct kvm_gfn_range *range);
> >
> > -static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)

Should have read the Sashiko review first, but where is this used?
It's not used at all in this series...

/fuad

> >  {
> >         return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> >  }
> > @@ -2557,6 +2557,16 @@ static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
> >                                                   KVM_MEMORY_ATTRIBUTE_PRIVATE,
> >                                                   KVM_MEMORY_ATTRIBUTE_PRIVATE);
> >  }
> > +#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> > +
> > +#ifdef kvm_arch_has_private_mem
> > +typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
> > +DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
> > +
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +       return static_call(__kvm_mem_is_private)(kvm, gfn);
> > +}
> >  #else
> >  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >  {
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 6669f1477013c..8b238e461b854 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2627,6 +2627,20 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> >  }
> >  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> >
> > +#ifdef kvm_arch_has_private_mem
> > +DEFINE_STATIC_CALL_RET0(__kvm_mem_is_private, kvm_mem_is_private_t);
> > +EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
> > +
> > +static void kvm_init_memory_attributes(void)
> > +{
> > +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> > +       static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
> > +#endif
> > +}
> > +#else
> > +static void kvm_init_memory_attributes(void) { }
> > +#endif
> > +
> >  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
> >  {
> >         return __gfn_to_memslot(kvm_memslots(kvm), gfn);
> > @@ -6528,6 +6542,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
> >         kvm_preempt_ops.sched_in = kvm_sched_in;
> >         kvm_preempt_ops.sched_out = kvm_sched_out;
> >
> > +       kvm_init_memory_attributes();
> >         kvm_init_debug();
> >
> >         r = kvm_vfio_ops_init();
> >
> > --
> > 2.55.0.rc0.738.g0c8ab3ebcc-goog
> >
> >
