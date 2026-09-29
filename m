Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590674FDA4D;
	Tue, 29 Sep 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675386; cv=none; b=OvRpfIWbkIMHZ6dbJwRoAzHrBl9V5g1oy5a77CVFGzw+DeRk79dWwbTORfmBAtvG1ZSlecF1WmJioP2g7BQ0IQrc04J+Ljo/1xQWYViTMmIZTd2ALxaUFmXtON38/pyt59lTUbXuPj5bmv+zagYJjZEYYPz+BMZSlInVDZYJtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675386; c=relaxed/simple;
	bh=xyQiEg8J5C6AndKTyPKA1JFthTC47DtNPxckDejzBkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utJlgSFsEDQ3zuDwyyVJjg467ogQ/C2zk0J8zlINDrFmUgrEt0xE+J7Zaaiah1L4sGOjhRzs3gPwcNyToetjQCYew4axjvpoKLceXjsP6D33Hz2QEKnHNW+QPaQXzO8wkFRuPLP/P2adBeYudg+RlVeVGb109IuNVNcHXw3KPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJEDp5k6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJEDp5k6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDD31F000FF;
	Tue, 29 Sep 2026 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790675383;
	bh=4EGzsamnE7S9zSPfntnKu9/cfo1q7r+TWTQ73npLdn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MJEDp5k6Ucc8s3Ifyqwotl+EOWiB4VH4kDYItmut6mgr4p1E/fmdMvwOHJTXukLeB
	 lShwNXpwS3GAq/BhUEwLMKlSNEdSOMbXvC5r4cSpQP4Nok6AvIHRvKixxlTMTjyjiF
	 luhwn9msVSLEZnDoSn/SY/pi2BvbgXSp7DyFh8mXZr5MoN+Vjd+aeUjDzmRpDqR0Bw
	 v/UfiISJWwrUkNbctv0c4I4elnCaOY2RS1qLupTGasgl7rPeeTH2FOZOnOC4xe9Sfq
	 mCx6OtB50a0+nCo0u9eENpuVd9OFkoY+mf655PeiHb5T0eykMekeRKD1wnk4BKG39T
	 T2TaAKHdE6XNA==
Date: Tue, 29 Sep 2026 15:10:41 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, steven.price@arm.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
Message-ID: <art6ARechyK0iytK@blrnaveerao1>
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
 <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
 <ao9CKMXAX-hScRSa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao9CKMXAX-hScRSa@google.com>

On Wed, Aug 26, 2026 at 12:44:40PM -0700, Sean Christopherson wrote:
> On Wed, Aug 26, 2026, Ackerley Tng wrote:
> > +
> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >  				     size_t nr_pages, uint64_t attrs,
> >  				     pgoff_t *err_index)
> > @@ -624,7 +661,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >  
> >  	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
> >  	kvm_gmem_invalidate_start(inode, start, end, filter);
> > +
> > +	if (!to_private && kvm_arch_has_gmem_convert())
> > +		kvm_gmem_make_shared(inode, start, end);
> > +
> >  	mas_store_prealloc(&mas, xa_mk_value(attrs));
> > +
> >  	kvm_gmem_invalidate_end(inode, start, end);
> 
> The real reason I responded...
> 
> Thinking about the Secure AVIC mess made me realize zapping NPTs for SNP VMs isn't
> strictly necessary in this path.  The PFN isn't changing, just the attributes, and
> that's (obviously) tracked in the RMP.  KVM doesn't need to zap SPTEs to induce a
> fault, because the mismatched C-bit vs. RMP status will cause an #NPF(RMP), and
> AFAICT kvm_mmu_page_fault() will do the right thing.  A misbehaving guest could
> continue to access the shared data (assuming we stick with lazy conversions), but
> that should be fine?  E.g. it's not really any different than implicit conversions.

Brilliant idea!

> 
> In other words, couldn't we do this (as an on-top optimization)?  The only wrinkle
> I can think of is that it could delay reconstituion of a hugepage, especially if
> we opted for eager conversion (because the guest wouldn't hit #NPFs to trigger the
> hugepage promotion).
> 
> diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
> index 62f751952ad8..61f3e270ab61 100644
> --- arch/x86/kvm/mmu/mmu.c
> +++ arch/x86/kvm/mmu/mmu.c
> @@ -1670,6 +1670,7 @@ static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,
>  
>  bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
> +       unsigned long shared_private =  KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
>         bool flush = false;
>  
>         /*
> @@ -1683,6 +1684,10 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>         lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
>                             lockdep_is_held(&kvm->slots_lock));
>  
> +       if (gmem_in_place_conversion && !kvm_has_mirrored_tdp(kvm) &&
> +           ((range->attr_filter & shared_private) != shared_private))
> +               return false;
> +
>         if (kvm_memslots_have_rmaps(kvm))
>                 flush = __kvm_rmap_zap_gfn_range(kvm, range->slot,
>                                                  range->start, range->end,

Can this be a problem with gmem hugepages? Not sure how that is going to 
look like, so this may be covered in other ways.

But, as it exists today, if the guest converts part of a 2M page to 
shared, then this skips zapping the SPTEs from the call in 
kvm_gmem_invalidate_start(). sev_gmem_make_shared() then issues PSMASH 
to convert RMP entry to 4k entries and we end up with 2M NPT+4K RMP. If 
the guest then writes to any private page in that range, 
page_fault_can_be_fast() returns true, fast_page_fault() only checks 
permissions with spte_permission_fault() and does not do anything.  
sev_handle_rmp_fault() also does not issue a zap since it finds that the 
RMP entry is already 4k, and we end up in a loop.


- Naveen

