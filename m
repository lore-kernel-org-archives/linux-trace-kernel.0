Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355A2F84F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783628; cv=none; b=eHNGgQCJajPr2liqEjjdY1Hh2IEhH3/1PjJS1ETaZDsL83Tm/xlzUe0SVN+DXHzC3SMvA62MBzmlmp2XS6Xq5ltu342Acj3w1sXbJtct3wDcKV11JFTEkfbM90iKQ1YdG84SD14VqVHxLer1Au62UuQIej22hS05cfW3EPOGuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783628; c=relaxed/simple;
	bh=xSXyqUElRzi4ro8cHC0OBS6VEnVwYq1rEqVbqm8HcoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AORb11Y/Pkpm0y6jDwI7u85dZ1LPAG+Zrv4a2vqVOVWq5as7fwIzQV2fJxbjP35HrY2Lg2NCqAi0kZLkklFpU4oJCaBZSoV0vqKbViV/diE4NH1Cajed631mLQMzV6keuLAz16TYetOAIg/ykJYnjtMypfqcJGSxBrkQMAd4Cj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVzTjsCd; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVzTjsCd"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1c2f1acebso134834a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787783625; x=1788388425; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpUANZHm7Ku5ncYu7RPUYz8NQSkFG4aKOc/nSfGf9bs=;
        b=AVzTjsCdZ7ZJjFIRsHm+VtHDqmrKHPqZQS2ewLb8BgMhajOAzQ/FguDzxtEQMYnwKc
         r7anwtQTJFn/ucy+x7VRsdLtrfGJIQDc9OV9NQeOP/i/bY4LcgB+zVGfo76+WslQmHmg
         hJCjQXt1FA7LdcfRWLzDFjaGF2akzYu+ZhCMdnmqHV21gZO4B9UFyeq2otvTZhPkC2kn
         aR26dtEXAtPQ54EyKvmVzuKZbFI+Bkv27GlRjza5X583vVfk3fUqpIMjzesvx43gNuph
         aEd36NIKVaDrhXWu+oRz4/h6ei0nZb1kDjo8vFe+x7GK/4kcoXvlRDWlnl6kxS9VkSiS
         M11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787783625; x=1788388425;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IpUANZHm7Ku5ncYu7RPUYz8NQSkFG4aKOc/nSfGf9bs=;
        b=XQGmJhZohQWEJSqpe0dXGasic2XMNZ+egil8f52Om8nyyhW8xcERLVI7VGHoRIx8NX
         4jmVuHsGI9Ke4PXn/FDmPt4Rf3w9teMz18XKszWzEOGwurKR1mfTvAadh0ahoOV+Fp1O
         zcF+BejCKMM4/OoDzCAoeB/kZp7fTmjePaKrGj/kdm2hMdXQL1wyJQuxA/SZPeXLuctO
         tER/HEZWztjjjp22a7/PveZpd9YH9CT01vUtQevVcjLl6MJbuTNttN4sbPrQnetapvkp
         bVy69bkRExfaoQb20d/7SiawOZFKqDcftkjOuoV+OgZ4/0zBHgnFAu8MuIOktdA+Dtzh
         xQ4g==
X-Forwarded-Encrypted: i=1; AHgh+RoGxIxF+7gQW1yuESN7xMadQSkjZ+7LZBUVVu8qgexSl/5sO84KLcfFI3fcfbdI6iL1075bI1jbITnVHP8HhRCQ49E=@vger.kernel.org
X-Gm-Message-State: AFuF++korfXWcwxL/LbAHFQhN53u2HaQMMxYIJgJ74OpTB2JyJaNlPPm
	qcVqjyk0c3Kisk8M9IYnMdjw2f/6wiVMWS1nabve6FPIKWhUc+OUXOuZQWVKHj3Z0OHajzdUn17
	hdt4ocA==
X-Received: from pgvi12.prod.google.com ([2002:a65:61ac:0:b0:cbe:e0a7:536b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c786:b0:3c3:b57b:627d
 with SMTP id adf61e73a8af0-3cf84c5a493mr23198540637.12.1787783624481; Wed, 26
 Aug 2026 15:33:44 -0700 (PDT)
Date: Wed, 26 Aug 2026 15:33:43 -0700
In-Reply-To: <mtbqvvvpwbzybgy6z47lwui6ag53kyubub3hkczui7u72zxesl@lnwsglrgwl5p>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
 <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
 <ao9CKMXAX-hScRSa@google.com> <mtbqvvvpwbzybgy6z47lwui6ag53kyubub3hkczui7u72zxesl@lnwsglrgwl5p>
Message-ID: <ao9px1j7CLYXMiGP@google.com>
Subject: Re: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
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

On Wed, Aug 26, 2026, Michael Roth wrote:
> On Wed, Aug 26, 2026 at 12:44:40PM -0700, Sean Christopherson wrote:
> > On Wed, Aug 26, 2026, Ackerley Tng wrote:
> > > Omit support for calling the arch hook to make private, since SNP, the only
> > > implementer of the arch make-private hook today, would actually prefer
> > > making private only just before faulting memory into the NPTs.
> > > 
> > > Calling the make-private arch hook would require iterating both bindings
> > > and the filemap to find the intersection of bindings and allocated
> > > folios.
> > 
> > Why would KVM need to iterate over the bindings?  Only the RMP needs to be updated,
> > whether or not the RMP is currently reachable is irrelevant, no?
> > 
> > Subsequent calls to kvm_arch_gmem_make_private() from kvm_gmem_get_pfn() would be
> > superfluous, but that's already possible, e.g. if an NPT mappings is removed for
> > whatever reason.
> > 
> > > On top of that, SNP would need to figure out whether to actually
> > > make private based on whether the memory is about to be faulted, or
> > > whether it is a conversion.
> > 
> > This is a non-issue, no?  As above, sev_gmem_make_private() already bails early
> > if the page is already assigned in the RMP.
> > 
> > I don't care terribly about how SNP handles this, but I do want accurate reasoning
> > and justification so that if/when we revisit any of this in the future, we can make
> > informed decisions.  Because unless I'm missing something, this is an optimization
> > choice (eager vs. lazy to-private conversions), not a complexity tradeoff, and it's
> > not clear to me how we decided the lazy approach would provide better performance.
> 
> I'm not sure it was discussed in this context, but there was some past
> discussion around preallocation (i.e. "should we call make-private arch
> hooks at allocation time to allow for faster boot for prealloc guests"
> and then that ran into the TDX side of things where that would
> necessarily entail pre-mapping into the sEPT as well, so
> KVM_PRE_FAULT_MEMORY ended up being the interface we adopted for this
> purpose.
> 
> Since then, KVM_PRE_FAULT_MEMORY was added on the QEMU side and gets
> called after all conversions for both SNP/TDX, and even without
> preallocation it's a decent performance boost to SNP. If we were to
> switch to pre-calling the make-private arch hook then the
> KVM_PRE_FAULT_MEMORY call because partly redundant and in practice we'd
> probably see a small performance loss.
> 
> So there's real performance differences here but it's sort of been
> addressed through a solution that offers additional performance
> benefits on top so there's no longer as much to be gained here I think.

Or another way to look at it, eager conversion would allow QEMU to drop its
workaround.

To be clear, I'm a-ok with the code as-is, I just want to make sure we document
exactly why we're choosing this implementation.

> But I guess that's a moot point...
> 
> > 
> > > Calling the make-shared arch hook and not the make-private arch hook does
> > > leak SNP-specific details into guest_memfd (as in, why only make-shared
> > > during conversions but not make-private?), but the additional complexity is
> > > not worth taking on until guest_memfd has a user actually requiring an arch
> > > make-private call.
> > 
> > ...
> > 
> > > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> > > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
> > > +{
> > > +	struct folio_batch fbatch;
> > > +	pgoff_t next = start;
> > > +	int i;
> > > +
> > > +	folio_batch_init(&fbatch);
> > > +	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> > > +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> > > +			struct folio *folio = fbatch.folios[i];
> > > +			pgoff_t start_index, end_index;
> > > +			kvm_pfn_t start_pfn;
> > > +			kvm_pfn_t nr_pages;
> > > +
> > > +			start_index = max(start, folio->index);
> > > +			end_index = min(end, folio_next_index(folio));
> > > +			/*
> > > +			 * end_index is either in folio or points to
> > > +			 * the first page of the next folio. Hence,
> > > +			 * all pages in range [start_index, end_index)
> > > +			 * are contiguous.
> > > +			 */
> > > +			start_pfn = folio_file_pfn(folio, start_index);
> > > +			nr_pages = end_index - start_index;
> > > +
> > > +			kvm_arch_gmem_make_shared(start_pfn, nr_pages);
> > > +		}
> > > +
> > > +		folio_batch_release(&fbatch);
> > > +		cond_resched();
> > > +	}
> > > +}
> > > +#else
> > > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) {}
> > > +#endif
> > > +
> > >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > >  				     size_t nr_pages, uint64_t attrs,
> > >  				     pgoff_t *err_index)
> > > @@ -624,7 +661,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > >  
> > >  	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
> > >  	kvm_gmem_invalidate_start(inode, start, end, filter);
> > > +
> > > +	if (!to_private && kvm_arch_has_gmem_convert())
> > > +		kvm_gmem_make_shared(inode, start, end);
> > > +
> > >  	mas_store_prealloc(&mas, xa_mk_value(attrs));
> > > +
> > >  	kvm_gmem_invalidate_end(inode, start, end);
> > 
> > The real reason I responded...
> > 
> > Thinking about the Secure AVIC mess made me realize zapping NPTs for SNP VMs isn't
> > strictly necessary in this path.  The PFN isn't changing, just the attributes, and
> > that's (obviously) tracked in the RMP.  KVM doesn't need to zap SPTEs to induce a
> > fault, because the mismatched C-bit vs. RMP status will cause an #NPF(RMP), and
> > AFAICT kvm_mmu_page_fault() will do the right thing.  A misbehaving guest could
> > continue to access the shared data (assuming we stick with lazy conversions), but
> > that should be fine?  E.g. it's not really any different than implicit conversions.
> 
> I think this should work in theory...
> 
> zapping NPTs means the vCPUs will keep retrying until they get the page first
> vCPU that faulted is trying to grab from gmem. If we don't zap, then they will
> instead be racing with the first vCPU, and if they lose they will be
> generating implicit page faults that trigger conversions back to shared,

Why would they trigger conversions back to shared?  Assuming the guest isn't
being silly and accessing the memory with C-bit=0, the #NPF will be tagged ENC
and KVM will treat it as a private access.

	if (is_sev_snp_guest(vcpu) && (error_code & PFERR_GUEST_ENC_MASK))
		error_code |= PFERR_PRIVATE_ACCESS;

kvm_mmu_faultin_pfn() will see "fault->is_private == kvm_is_private_gfn()" as
true, i.e. won't kick out to userspace.  Same for __kvm_mmu_faultin_pfn(), which
will call into kvm_mmu_faultin_pfn_gmem() => kvm_gmem_get_pfn(), see that the
gfn is private, and call kvm_arch_gmem_make_private() as needed.

I don't see how #NPFs due to the RMP being SHARED would be handled differently
than !PRESENT #NPFs.

> and most likely the first vCPU will re-trigger an implicit shared->private
> conversion when it does PVALIDATE. Worst case, the guest fails PVALIDATE
> due to racing with itself.
> 
> It's a bit chaotic, but it shouldn't break anything other than the guest, and
> it's only something we'd generally expect for buggy/malicious guests anyway.
> 
> However...
> 
> > 
> > In other words, couldn't we do this (as an on-top optimization)?  The only wrinkle
> > I can think of is that it could delay reconstituion of a hugepage, especially if
> > we opted for eager conversion (because the guest wouldn't hit #NPFs to trigger the
> > hugepage promotion).
> > 
> > diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
> > index 62f751952ad8..61f3e270ab61 100644
> > --- arch/x86/kvm/mmu/mmu.c
> > +++ arch/x86/kvm/mmu/mmu.c
> > @@ -1670,6 +1670,7 @@ static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,
> >  
> >  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> >  {
> > +       unsigned long shared_private =  KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
> >         bool flush = false;
> >  
> >         /*
> > @@ -1683,6 +1684,10 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> >         lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
> >                             lockdep_is_held(&kvm->slots_lock));
> >  
> > +       if (gmem_in_place_conversion && !kvm_has_mirrored_tdp(kvm) &&
> > +           ((range->attr_filter & shared_private) != shared_private))
> > +               return false;
> > +
> 
> This path would also trigger for hole-punching, where we would want to
> zap the NPT entries. So we might need to adjust the logic for more than
> just shared vs. private to account for that.

No, because PUNCH_HOLE uses kvm_gmem_get_all_gfns_filter(), which does:

	if (gmem_in_place_conversion)
		return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;

i.e. won't get short-circuited.  Though I agree with the implication that this
is super fragile/subtle.

