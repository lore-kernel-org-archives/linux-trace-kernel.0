Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A039478B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400811; cv=none; b=F/dP828UzqcViviW2FO0UQ4Dnm/jdyRZWbPl/+z9woug3o+m5ONcbG3huUKRwiYvtkdDC9el96HCIW2qj4GUPjmiSuKKo9XDVjtqKa8XrXMpDd1QyJ5U0s8nYur+bV/IvuTDQbAJES0PvxYI62sGmNsnLmDPMb2VCpFn9NXvyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400811; c=relaxed/simple;
	bh=acthpId0xxIMHj8cbxHwbEk9kB79SbNDgsYVPE9NfSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tvkm6+emO9THR4HUD3A71S54+JoVkcAYAqbKImtT/ZX6xiB4xSRqv6wzKD8W0lifwn83kHE5oVNzaA6X7NeAw68grv1QpNQFN8esGpnetokvJjPcUUIPbm/k6511Br65wrHPVIv42O+oGACdxNcpdHPuHwNR1XtYqyOFtU/n5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rq9DNgO7; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rq9DNgO7"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so59815765ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786400808; x=1787005608; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eCvqvKq7txaLhgLohGrMSKSRSQETuQwS11gkekNEjOI=;
        b=Rq9DNgO7M8Hx2BpymgTHIitV+njbE7QQsUeUXoUa2RWALem7yxHF1Y+oDnVmQeMvCJ
         SPY+QRu9QJSzn37UMH3VYzG8SE2YO+UzWk15ZmZkVowCVMTx5YN6Tflk1Mk0bISSokAY
         LY7UL5K5sVNg9vIZy+B/YFt+LwZDl3g0s3i5kbJjoeMZPfyKeBHYM08RQQXdX7CmVAC2
         balI8JfVdKLCqmI8iZ/bGgQ5yPsRrIegf8LjQQNpJRM9ENCv88pnWeJNmg6nUCB+WYTU
         zjvJOaetbWf1efGmHyP/YpbHmipqII+SAH8xGo9CBaudItHyy8gRcqg61lJetiiXg2kA
         V6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786400808; x=1787005608;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCvqvKq7txaLhgLohGrMSKSRSQETuQwS11gkekNEjOI=;
        b=kwfBo0AY7GM3QwjgLvhkKo5TZ8IAZs8e0KYiQ/kvyUpjmBm1N07BhWx4DcvJrAKEva
         2zamJj2w3bbQQ5KFZdbwrRHbsTJs+2vOPYSffk17daVYWqcKLYQ/pAjEQNTZPtvya+Nj
         ErabsLk8da7b/wac1zRUuSAJT2CHA8OUXDgdr9dqeBSwCHIL28/M9bP3J47iVYR8M57f
         QI22kxu95tixgKd2HMzNqrPVZeaiMPnIwnJHEh3yQShRqGCpU0x3MbtBtCHj/XhgttH7
         1of3ZKq1eBnDYI7DZkBWFK6rQUzj33Vcj0RF+jR794TlbKORRpy2U6muOU9jKnvq6DmC
         lSwg==
X-Forwarded-Encrypted: i=1; AHgh+Rpzk4ztybdY9gHzbG3ItJDo8d/mDxgrakABW/QlCyU/OLwwgf14gfdLUbdB4VKnaNlZFZ0ySzBky2iyDq2pbFegajc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUz14IN5GanaIwv+2DjjW8VIMtpjhhz5XxyANbRyQyPNpHnuc
	CQupzIhf0qrDyvjQ76PLTBsDwLf4VBAzOE5EL/kH3uj0y0jTfimDeO+V2AR5LNqEc+qWUhR4KQ2
	c0gNnyg==
X-Received: from pgv28.prod.google.com ([2002:a63:155c:0:b0:cbe:3002:6608])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a121:b0:3c3:8651:b317
 with SMTP id adf61e73a8af0-3cc1a13d4d0mr5100843637.10.1786400807414; Mon, 10
 Aug 2026 15:26:47 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:26:46 -0700
In-Reply-To: <CAEvNRgHyRdt7rp=5e5FMbTT=fXNfB=np7VWd_GdmJcPOQgps4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
 <eb1b5763-37bc-4cb3-890c-1e619e5a8ae4@kernel.org> <CAEvNRgHyRdt7rp=5e5FMbTT=fXNfB=np7VWd_GdmJcPOQgps4g@mail.gmail.com>
Message-ID: <anpQJvFw9s-XP3pW@google.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Ackerley Tng wrote:
> "David Hildenbrand (Arm)" <david@kernel.org> writes:
> 
> > On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
> >> From: Ackerley Tng <ackerleytng@google.com>
> >>
> >> When converting memory to private in guest_memfd, it is necessary to ensure
> >> that the pages are not currently being accessed by any other part of the
> >> kernel or userspace to avoid any current user writing to guest private
> >> memory.
> >>
> >> guest_memfd checks for unexpected refcounts to determine whether a page is
> >> still in use. The only expected refcounts after unmapping the range
> >> requested for conversion are those that are held by guest_memfd itself.
> >>
> >> Update the kvm_memory_attributes2 structure to include an error_offset
> >> field. This allows KVM to report the exact offset where a conversion
> >> failed to userspace. If the safety check fails, return -EAGAIN and copy
> >> the error_offset back to userspace so that it can potentially retry the
> >> operation or handle the failure gracefully.
> >>
> >> Update documentation to document the error_offset field and the possible
> >> -EAGAIN error.
> >>
> >> Suggested-by: David Hildenbrand <david@kernel.org>
> >> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> >> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> >> Reviewed-by: Fuad Tabba <tabba@google.com>
> >> Tested-by: Shivank Garg <shivankg@amd.com>
> >> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >> ---
> >
> > [...]
> >
> >>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> >> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >> index 3783e63476569..13c3989136f67 100644
> >> --- a/virt/kvm/guest_memfd.c
> >> +++ b/virt/kvm/guest_memfd.c
> >> @@ -524,8 +524,42 @@ static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
> >>  	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
> >>  }
> >>
> >> +static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
> >> +					    size_t nr_pages, pgoff_t *err_index)
> >
> > I would focus on the "to_private" aspect or abstract it to
> > "kvm_gmem_mem_has_unexpected_refs" or sth like that.

+1.  Maybe "kvm_gmem_page_has_outstanding_references"?

> Do you mean something like kvm_gmem_is_safe_for_to_private_conversion,
> as in that you want to emphasise that "safe" here refers to a to_private
> and not a to_shared conversion?

I'm obviously not David, but for me, the problem with names like
kvm_gmem_is_safe_for_conversion() is that (a) it conflates what the function is
literally doing with how the function is being used, which often makes the code
harder to understand as it obfuscates things, and (b) can become stale or even
outright broken far too easily.  E.g. if KVM adds more checks on whether
or not a conversion is "safe", then the name of the function is a lie because it
doesn't actually check that the target data is safe for conversion, only that
its "safe" for a specific aspect of conversion.

And there is real risk to hiding what a function does.  E.g. looking at this code
without diving into the details:

        if (to_private) {
                unmap_mapping_pages(mapping, start, nr_pages, false);

                if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
                                                     err_index)) {
                        mas_destroy(&mas);
                        r = -EAGAIN;
                        goto out;
                }
        }

and one might thing that it's perfectly find to check for "safety" before
unmapping pages.   In fact, looking at the code without a priori knowledge of
the rules, and the above flat out looks wrong.  E.g. I could definitely see
someone "fixing" the code to:

        if (to_private) {
                if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
                                                     err_index)) {
                        mas_destroy(&mas);
                        r = -EAGAIN;
                        goto out;
                }

                unmap_mapping_pages(mapping, start, nr_pages, false);
	}

Whereas this:

        if (to_private) {
                unmap_mapping_pages(mapping, start, nr_pages, false);

                if (kvm_gmem_has_outstanding_references(inode, start, nr_pages,
							err_index)) {
                        mas_destroy(&mas);
                        r = -EAGAIN;
                        goto out;
                }
        }

helps the reader understand what's being checked without having to look at the
details, and also helps communicate the ordering dependency without needing a
comment.

There are definitely times where the usage of a function bleeds into its name,
but usually that's because the name and the usage are on and the same.  E.g.
get_user() describes both the usage and the "what".  And it's easy/possible to
go too far in the opposite direction, e.g. by giving a play-by-play of what a
function is doing, but that's why we have bikshedding sessions :-)

> Perhaps a little ahead of its time,

Ya.

> but later with restructuring for huge pages, we also need no additional
> refcounts other than gmem's own so that restructuring is safe, hence this
> function name was meant to extend there as well.

Given that I've read that at least five times and still don't understand the
nuance, I think it's safe (ha!) to say we'll need to revisit and review those
changes no matter what. :-)

 
> In this case "unexpected" (especially since the next patch adds checks
> for maybe dma pinned and unmapping), begs the question "unexpected in
> what way"?

Ya, that's why I like "outstanding", it succinctly captures that one or more
references have been "loaned" but not yet "repaid".

> >> +	struct address_space *mapping = inode->i_mapping;
> >> +	const int filemap_get_folios_refcount = 1;
> >> +	pgoff_t last = start + nr_pages - 1;
> >> +	struct folio_batch fbatch;
> >> +	bool safe = true;
> >> +	pgoff_t next;
> >> +	int i;
> >> +
> >> +	folio_batch_init(&fbatch);
> >> +
> >> +	next = start;
> >> +	while (safe && filemap_get_folios(mapping, &next, last, &fbatch)) {
> >> +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> >> +			struct folio *folio = fbatch.folios[i];
> >> +
> >> +			if (folio_ref_count(folio) !=
> >> +			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
> >
> > I'd rather add a comment than have this filemap_get_folios_refcount.

+1, the local variable just made me scratch my head.

> >
> > /*
> >  * We expect one reference per folio-page in the pagecache and one
> >  * reference from filemap_get_folios().

Nit, please no pronouns in KVM code.

> >  */
> > if (folio_ref_count(folio) != folio_nr_pages(folio) + 1)
> >
> 
> This comment explains what's "unexpected". I can do this and switch it
> to kvm_gmem_mem_has_unexpected_refs() unless people have other
> suggestions.
> 
> I wish there was a folio_pagecache_refs(folio) that
> folio_expected_ref_count() can share with this, and also
> folio_swapcache_refs(), to solidify the definition of refcounts taken by
> the pagecache.

...

> >> @@ -542,8 +576,21 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >>
> >>  	mas_init(&mas, mt, start);
> >>  	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> >> -	if (r)
> >> +	if (r) {
> >> +		*err_index = start;
> >>  		goto out;
> >> +	}
> >> +
> >> +	if (to_private) {
> >
> > I'd add a comment here for the "why are we unmapping".
> >
> 
> Does this sound right:
> 
> Unmap here to ensure that userspace page tables have no mappings, which
> also ensures refcounts from those mappings are dropped.

How about:

		/*
		 * Forcefully unmap the pages from all userspace page tables,
		 * and then verify there are no outstanding references, e.g.
		 * acquired via GUP or similar.  Tell userspace to try again if
		 * there are oustanding references and hope that whatever has
		 * pinned the page will put its reference "soon".
		 */
		unmap_mapping_pages(mapping, start, nr_pages, false);

                if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
                                                     err_index)) {
                        mas_destroy(&mas);
                        r = -EAGAIN;
                        goto out;
                }


> 
> > --
> > Cheers,
> >
> > David
