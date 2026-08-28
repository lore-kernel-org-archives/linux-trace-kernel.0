Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A356471423
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929025; cv=none; b=r/m5gqfYClXOT1G1dIT8TpcnGFtTAOjlxRqe7Iwy2ziUY650H5bnajgFIaAB10ZbP3QhgrFGgo0X4+c5GZhirfwxfzDcs2hdYcBNyLc7I02VNqgBCmFqcHLtWBmyxBeswkIOCtAEf48gyjSsOZzWS/tpActPOs8iPXDXutSVkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929025; c=relaxed/simple;
	bh=LZpPvS21SRGUjRRQo9YMu2uphCB+Yb/O1WCRXm1EFjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b+4Q34gfA+TG5LU2oh0NALWQPhA+iA+Oa4nqfQ0LIuyRcG/D44QcxpV2EINAbDXuezqwT3lFuqwqqhlvDF0BHgwWOVDqVD8fZI4qn82z8XqloV5kiqw6ZnnCpmRuMC5gcLqeTrOlSgWdAse/HdRwi+p0nhVuJyYyaQGxZl7m2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKi8VdUO; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKi8VdUO"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso13986945ad.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787929023; x=1788533823; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKyTv2j02zbnlF+PSfGKNUB7r5AsnRVQJaAhKBT0UgU=;
        b=HKi8VdUOMQ+VhGwRtStYGF2qLx+TKzH7citcBlKEg4hjaizk6X5JWUqFLqtF7AizQ3
         ayxD6h+lwClPnw6h1ap2n6vfGqEVYLJ2LjsafVfVzZyMekM1kM8ZYNK2Z1azvsXDDPVs
         y1hqvhtzpK/60tJN1XmbkQM0BDmxgUaznhlQ5bLTWAxRWWIJeDWN+IEHSfH0qvUFR1FL
         fj7bz6dko7atEYi1As+Sb18pSNahp6AmydieQp7TV82IiGh5UIQC4u4sPrudKgfvUAlO
         K5AZ2FO9HITDBDFoVv0NDYV5z/n37h+Mgs7BgeuVTMvGTJJA+Ro4thpoa0pAf9tPq9b3
         CXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787929023; x=1788533823;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rKyTv2j02zbnlF+PSfGKNUB7r5AsnRVQJaAhKBT0UgU=;
        b=cit/m5woNLSlsS/Fl92ck3s2ZCqGbLg1XegZ3pIOd/PVtLXDJxBQ+NHz83q84PNjfS
         aXZCR/hFM0cMuOjC1h/MP0OXGVv3mR3IC1XTQZDFMK3Kla40qRvT/+/jrSmOrPNwYILH
         Zj3odn1L/YOJpM/5DN3KRGRPP6SLqD/xZ0DFMUbqMZ26UMQT/P3RZ3LemMDMsONV74PG
         AKsDRQpe0uBikwh3m6FXIgWFa3BcKiy75UEpRJCTElXNH8mEEFRJvGVSr7PKV3cyPWXc
         fQUA/VbIrtk9tvEHRLJOlI5yKRdkrDqr11DOjymEdJSnRjF3ZGHdiNoEtGIICpp0GlUL
         9ljQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzNr9K8hOa7XuDv92Ym0UVnqewO2nZFqhkfxdjiRIc6IjQAp4czFK4O3B86+rFCwSfc33L8L6cTAghxT6Uybx9j40=@vger.kernel.org
X-Gm-Message-State: AFuF++kr2ibwRoXcYhZb/X1eYp1igYT/Fz2hRzshP2RJA/AL65xVAvZ5
	LaVSpBbJ5xYDFVka15M3VB21JQTrDQqTwO6PCffEq6jKUD+XKBUlkLzv5PcUtu4izCrFuFQO4P/
	7fMXWlg==
X-Received: from plbkz13.prod.google.com ([2002:a17:902:f9cd:b0:2ca:ed29:ea82])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1984:b0:2d8:d4d3:da4f
 with SMTP id d9443c01a7336-2d8d4d3db7dmr6783485ad.19.1787929022578; Fri, 28
 Aug 2026 07:57:02 -0700 (PDT)
Date: Fri, 28 Aug 2026 07:57:01 -0700
In-Reply-To: <CAEvNRgG7n6F=dW9V_QqQPDDgLiZ7x08uLDanJgSzerNtN8sqBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
 <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
 <ao9CKMXAX-hScRSa@google.com> <CAEvNRgG7n6F=dW9V_QqQPDDgLiZ7x08uLDanJgSzerNtN8sqBQ@mail.gmail.com>
Message-ID: <apGhvboNAlExQFsK@google.com>
Subject: Re: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Aug 26, 2026, Ackerley Tng wrote:
> >> Omit support for calling the arch hook to make private, since SNP, the only
> >> implementer of the arch make-private hook today, would actually prefer
> >> making private only just before faulting memory into the NPTs.
> >>
> >> Calling the make-private arch hook would require iterating both bindings
> >> and the filemap to find the intersection of bindings and allocated
> >> folios.
> >
> > Why would KVM need to iterate over the bindings?  Only the RMP needs to be updated,
> > whether or not the RMP is currently reachable is irrelevant, no?
> >
> > Subsequent calls to kvm_arch_gmem_make_private() from kvm_gmem_get_pfn() would be
> > superfluous, but that's already possible, e.g. if an NPT mappings is removed for
> > whatever reason.
> >
> 
> make_private takes a gfn and pfn, so __kvm_gmem_set_attributes() would
> need to iterate bindings to get gfns and filemap to find folios to get
> pfns.

Oooh, right, unassigned a page in the RMP only needs the PFN, but assigned a page
needs the ASID and GFN.

> > I don't care terribly about how SNP handles this, but I do want accurate reasoning
> > and justification so that if/when we revisit any of this in the future, we can make
> > informed decisions.  Because unless I'm missing something, this is an optimization
> > choice (eager vs. lazy to-private conversions), not a complexity tradeoff, and it's
> > not clear to me how we decided the lazy approach would provide better performance.
> >
> 
> How's this, to replace the entire commit message? I hope it captures
> points from this discussion:
> 
>   When memory in guest_memfd is converted from private to shared, the
>   platform-specific state associated with the guest-private pages must
>   be invalidated or cleaned up.
> 
>   Iterate over the folios in the affected range and call the
>   kvm_arch_gmem_make_shared() hook for each PFN range. This allows
>   architectures to update hardware metadata or encryption states to
>   transition pages to the shared state, instead of leaving hardware
>   state as private while guest_memfd tracks it as shared. Transitioning
>   hardware state ensures that guest_memfd upholds the guarantee that
>   userspace only maps shared memory.

Nit, don't reference functions by name when it's easy-ish to avoid doing so.  And
don't give a play-by-play: the patch makes it pretty obvious the code is iterating
over folios, what isn't obvious is *why* the code does that.

>   Invoke this helper after indicating to KVM's mmu code that an
>   invalidation is in progress to stop in-flight page faults from
>   succeeding. Calling the invalidation helper also calls the arch
>   invalidate hook. For SNP, this kicks any vCPU with a registered VMSA
>   within the range being converted out of the guest. This ensures that
>   make_shared never fails due to the VMSA page being in-use and is
>   important because if make_shared fails, the RMP table would track the
>   page as private while guest_memfd is unaware and tracks the page as
>   shared.

Exaclty what SNP does isn't relevant.  Or rather, it's but on example of how this
needs to work.  I.e. the conversion needs to happen within the invalidtion sequence
because thems the rules for KVM.

>   Omit support for calling the arch hook to make private during
>   to-private conversions. Making private lazily at fault time aligns
>   with how it works on other platforms like TDX.

To me, this isn't a valid argument.  We've fully committed to relying on vendor
specific behavior, and SNP can't truly work like TDX because the underlying
implementations are so different.

>   Furthermore, making pages shared only requires PFNs, which are
>   obtained by iterating folios in the filemap. In contrast, making pages
>   private in the RMP also requires the GFN, which would require
>   iterating bindings to get GFNs and the filemap to get PFNs from
>   allocated folios. Deferring the transition to fault time avoids this
>   additional complexity.

It's not just complexity, it's that the bindings might not even exist.  I.e. for
all intents and purposes, doing on-demand updates is mandatory, because that's the
only time a relevant memslot binding is guaranteed to exist.

All in all, this?

   When doing in-place conversion from PRIVATE to SHARED, immediately inform
   arch code of the conversion for all allocated pages/folios, e.g. so that
   arch code can put hardware metadata tables in the correct state.  Eagerly
   updating the table for to SHARED conversions avoids having to implement
   on-demand updates, e.g. when faulting in host userspace mappings.  Skip
   the entire flow if the arch doesn't implement conversion callbacks, as
   getting folios from the filemap is noticeably expensive, especially when
   converting large chunks of memory.

   Deliberately don't eagerly update the metadata table on conversions from
   SHARED to PRIVATE, because assigning a page to a VM (versus "returning" it
   to the host) requires the exact GFN associated with the page, i.e would
   require walking the memslot bindings.  And because KVM *must* do on-demand
   metadata updates when getting a PFN for KVM-internal usage, as that's the
   only time a relevant memslot binding is guaranteed to exist.

   Note!  Inform arch code of the conversion within the protection of the
   invalidation sequence, to ensure that any existing mappings are dropped
   before hardware is updated, and to ensure that new mappings can't be
   established until after the conversion is complete.
