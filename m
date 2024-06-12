Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2117C7AF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205775; cv=none; b=AcxcPnUJEP8DOdxJlhe/dsQzHkl53vjU5E+2DwXUV2lEOyB0iGX8xOYJWaa8ibePJva6tAXuE4bEYG8mQgT4htM1pJIxE1BDsnBtKa2AqMa65JsLcm8v/fUn2rbJf3sNRUR5QprP5f7CmoFIJ93CMHxB7Hz9bQA8mVp6K/8FmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205775; c=relaxed/simple;
	bh=tzPtwpV4j1pdrwYCvIYwV29IQG2d6cN6yQ3kAiIoajg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dYGU9QYfVl5zexmIh2E+gErZ7kW6JnxjNvbX66fJb4rc3nGT4zutz6xf/gPTJz9bt5yIAdjGtbMDyAzFYGgc7Xkv1GkT+4TBn5kGT3cX5/qWYufdCIUgfSUq4fXlpp7AQdxmIEHBaz/38BufvaxJoVwIWqJS7zefTNW9YkaBQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AikIDcOP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AikIDcOP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627956be166so134959677b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718205771; x=1718810571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0BqD6y0/VOUpbW8YRHgmGoMOpV6WFqVjQFCsKaKlao=;
        b=AikIDcOP4Vnh4tezmavbFD+CmFuh8QjYsWGaAfFTgJDLHiaq+z3B2sp9P+0kCZ2xy9
         3tCO+xKVYFd0eXKthsvImF+ABQRWdVrt3F2FCpYz70eqr2ovLU4XHkD3cYFyDaSL4wyg
         QuGMwY1x3vEpT2QXMmKX5dsUX9QVEKYqEyHoB3LKnUngbGqAGJ/yBQSuN05/+h9gVQeR
         rQHi4jDXBf/M6JagQHlnQSr7chGNL+UQB3xrQ29/CQdttbRUQDX7jFghPWBM8COQf3o3
         QNtqfkvnMYPTZptgrGC2bDmzHN/AJqrfKjFJS0veAgU+dBtIHbD80gBP5YwmWiCss7Gr
         fAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205771; x=1718810571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0BqD6y0/VOUpbW8YRHgmGoMOpV6WFqVjQFCsKaKlao=;
        b=brGgBmypIIzzkyiFKfI0epUfH9DIE6vxq6PZiHBdFWABzH8aQH+jue2AZcPQ4Y7NqC
         q3HdaORRInLjwxm0qgTCWgZmobYzRGT4+paj4KHQaSeEIuRRD+uqF8cFgbW40y5A6zTN
         OpPRgqur5fHSMGYc3KjzOYGvVx/XwW9v9hKuS5RBnJAVCrDDIubWsHlPUxYGRz/AX9oM
         LsWcSSSokuFN+Wvjj6iP6+FuafPJZ+kTthj2LljhlKr+HWhPYJFCbs73ym0htvr6HZyR
         jqIFRMzG9uGhIh55VN0/u31U8iZxXME0eOCSt6pGP6Q4IrsRDZ2tDwWWU6iHuI4ODL/E
         Geyw==
X-Forwarded-Encrypted: i=1; AJvYcCU428wm+JuOYnFA4Nw0eghNeh9cGIIecUCyVehfBQW0MicJFe/mvq9LxXL6fLfDgK4ox4QYx4gTCCmFhePeKdnqXrnFh/4suPA69GBphSzzI3/D
X-Gm-Message-State: AOJu0Yz64DVkyDtna8dsVioU9Mrbkpd48t1XjAg1aLg/V96Do0KcadXf
	3kbEmEp8ceXx9IP9M+N9IwB0hZhfhZiZgwqSYF4XpSgUL7BwfdxAiG2mja0vKA4dY5noRnYjnKv
	7kQ==
X-Google-Smtp-Source: AGHT+IGTqFQO1W9uWgNfx86uFJoJR25380gE+MX0EH8aoPTaRHgwGtgxURTOkAOuuR3wa2vaOk4BcpKiUBQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:660c:b0:62f:f535:f2c with SMTP id
 00721157ae682-62ff53512f5mr5078687b3.2.1718205771477; Wed, 12 Jun 2024
 08:22:51 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:22:49 -0700
In-Reply-To: <20240419112432.GB2972@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405115815.3226315-1-pbonzini@redhat.com> <20240405115815.3226315-2-pbonzini@redhat.com>
 <20240412104408.GA27645@willie-the-truck> <86jzl2sovz.wl-maz@kernel.org>
 <ZhlLHtfeSHk9gRRO@google.com> <86h6g5si0m.wl-maz@kernel.org>
 <Zh1d94Pl6gneVoDd@google.com> <20240418141932.GA1855@willie-the-truck>
 <ZiF6NgGYLSsPNEOg@google.com> <20240419112432.GB2972@willie-the-truck>
Message-ID: <Zmm9SdVfg18RECT5@google.com>
Subject: Re: [PATCH 1/4] KVM: delete .change_pte MMU notifier callback
From: Sean Christopherson <seanjc@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Will Deacon wrote:
> On Thu, Apr 18, 2024 at 12:53:26PM -0700, Sean Christopherson wrote:
> > On Thu, Apr 18, 2024, Will Deacon wrote:
> > > > I assume the idea would be to let arch code do single-page invalidations of
> > > > stage-2 entries for each gfn?
> > > 
> > > Right, as it's the only code which knows which ptes actually ended up
> > > being aged.
> > > 
> > > > Unless I'm having a brain fart, x86 can't make use of that functionality.  Intel
> > > > doesn't provide any way to do targeted invalidation of stage-2 mappings.  AMD
> > > > provides an instruction to do broadcast invalidations, but it takes a virtual
> > > > address, i.e. a stage-1 address.  I can't tell if it's a host virtual address or
> > > > a guest virtual address, but it's a moot point because KVM doen't have the guest
> > > > virtual address, and if it's a host virtual address, there would need to be valid
> > > > mappings in the host page tables for it to work, which KVM can't guarantee.
> > > 
> > > Ah, so it sounds like it would need to be an arch opt-in then.
> > 
> > Even if x86 (or some other arch code) could use the precise tracking, I think it
> > would make sense to have the behavior be arch specific.  Adding infrastructure
> > to get information from arch code, only to turn around and give it back to arch
> > code would be odd.
> 
> Sorry, yes, that's what I had in mind. Basically, a way for the arch code
> to say "I've handled the TLBI, don't worry about it."
> 
> > Unless arm64 can't do the invalidation immediately after aging the stage-2 PTE,
> > the best/easiest solution would be to let arm64 opt out of the common TLB flush
> > when a SPTE is made young.
> > 
> > With the range-based flushing bundled in, this?
> > 
> > ---
> >  include/linux/kvm_host.h |  2 ++
> >  virt/kvm/kvm_main.c      | 40 +++++++++++++++++++++++++---------------
> >  2 files changed, 27 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index afbc99264ffa..8fe5f5e16919 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2010,6 +2010,8 @@ extern const struct kvm_stats_header kvm_vcpu_stats_header;
> >  extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
> >  
> >  #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
> > +int kvm_arch_flush_tlb_if_young(void);
> > +
> >  static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
> >  {
> >  	if (unlikely(kvm->mmu_invalidate_in_progress))
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 38b498669ef9..5ebef8ef239c 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -595,6 +595,11 @@ static void kvm_null_fn(void)
> >  }
> >  #define IS_KVM_NULL_FN(fn) ((fn) == (void *)kvm_null_fn)
> >  
> > +int __weak kvm_arch_flush_tlb_if_young(void)
> > +{
> > +	return true;
> > +}
> 
> I tend to find __weak functions a little ugly, but I think the gist of the
> diff looks good to me. Thanks for putting it together!

Circling back to this, I don't think we should pursue this specific tweak, at
least not without hard data for a concrete use case.

The clear_flush_young() hook is the only callback that overloads the return value,
e.g. for invalidate_range_start(), arch code can simply return false if the flush
has already been performed.

And clear_flush_young() _always_ operates on a single page, i.e. the range will
only ever cover a single page in the primary MMU.  It's obviously possible that
KVM's MMU has mapped a transparent hugepage using multiple smaller pages, but
that should be relatively uncommon, and probably not worth optimizing for.
