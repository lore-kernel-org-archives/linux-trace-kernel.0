Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B31FE47B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370277; cv=none; b=UWslRCBWIRGjwXHbvYS7Q4arivfInmiJIPL3DZCuWeRF3LHv+dmh0IdMo0ugUi9xFbOehmTgpVBHHFR+wGvWNh7rqmg+j9xf2gK1geb2ZgV5BJlhbUMnIq/QW7Zz40hMDDi/CLwKrBAIwGnMH7W8WXzAZypc5xJJxD4k14jbuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370277; c=relaxed/simple;
	bh=t+Zvw3OJCdd7aLvPU2Y07KNUlkbBJoLjXPqHeDhHkts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YmIsJso/86tYiSz4yrGhGS6AMhln1jeJLiCNUOml2CTWqi4sMpVMz2uJZ1ohdWd2zcHQrCrsgVUG+4Qro6BEj84ZvrptWwWaMbNlWOe0m4Z4R4umnNbEFpyn23oUHBjrogJ9P6zuEoMoojw5qvY3SrUfVn4JAEEp3/9SCiSr0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFbIcOa6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFbIcOa6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82bd90afbbso3184988a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779370276; x=1779975076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=55Qyjr301rCPWrgG1oq6BJ9BiVpqhO1a4dUCIfsketY=;
        b=BFbIcOa6tsLopRpXEegaYyJ9dLuDtj6c6LvwHJBtQzjNpgRSDKHaj2XBaGI51Z1bgZ
         25SKIbfPp8YjI5wMdOzSGFD4EYTOExX4u8+qyDX3Ka5hNyRyn93z/mCZyXy4Xnl8Vv9P
         y6WjUOF5LjzNpSF2gIENEa8sevkFul7s/xPOiL0mXJZWQ+looyEijUfDHBwpIm01fjVi
         fFdX4pVqF067NTnh/FeR5rHFPhV6h6ot0204Ednn5WM6C8fFz3eYGAf+XXO1le+tpNFk
         16pwC4Z5pkXiT3+souy/8aTgUQqZIkQHisyW9VMXEhydQ+j0glC6cqKydgU6htjh1eoG
         xjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370276; x=1779975076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55Qyjr301rCPWrgG1oq6BJ9BiVpqhO1a4dUCIfsketY=;
        b=C7LhkD5Djanm+MjVMa2VPkCY8cuwQg1RY3ZtizMKe0dUeLTUGNo6MnaKolpKMhhjVY
         UPy4fEkBUaXTgYePqUXIDIydlvJzRRarZ/1IBwWr273mYG4b9P68O1gcoKPjOwi1zfmM
         SYgmrm//Q9TW367C2C5pK2FT55hyPWBVgmxxzRkoH0cJxO5C5RkWmQompgEaWWFZThBT
         Ld4SHRLJOrSor2lAgXGyLZMdFJSXxMJgTNgZ9AJHDvNVXD+rLt9+wX/XgvEBNpTiB4qj
         7EKUtO13Y9If+W3BGy1S1ZypehOoH6ZQReatVfv/6wqjQ3TnX4nm5YiodEr7wZce9JZg
         TWvw==
X-Forwarded-Encrypted: i=1; AFNElJ92G1c9uks9kIKQN0y5ayq83dz5zYhJWdKfF1T2VvronnYbTQOMwJkLgL+ULleX7FfBgNgO2bBwF7TxTmcghzieR3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/5VQGRAKaCN3J53Dg3BHBMTMnHj1YOJpPUwVab5Od0w4Ub56
	RR7eC1OnEWxBpM3p1UMzk84tDKRAuOv5NSgTmplG+wroF7qYOrygReHMEh/ULdcEx3F5V/mWwzQ
	0lY1EJQ==
X-Received: from pfblt3.prod.google.com ([2002:a05:6a00:7443:b0:839:65e2:e48f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1494:b0:83f:2568:d469
 with SMTP id d2e1a72fcca58-8414adfae19mr3245544b3a.32.1779370274841; Thu, 21
 May 2026 06:31:14 -0700 (PDT)
Date: Thu, 21 May 2026 06:31:14 -0700
In-Reply-To: <CA+EHjTzLCD-dU-euZKgzwyEr2ecPqFDNutcaHm2fCDGA+MHVXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com>
 <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
 <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com> <CA+EHjTzLCD-dU-euZKgzwyEr2ecPqFDNutcaHm2fCDGA+MHVXA@mail.gmail.com>
Message-ID: <ag8JIlHjohAOC3-g@google.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Fuad Tabba wrote:
> On Wed, 20 May 2026 at 22:44, Ackerley Tng <ackerleytng@google.com> wrote:
> >
> > Fuad Tabba <tabba@google.com> writes:
> >
> > >
> > > [...snip...]
> > >
> > >> +unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> > >> +{
> > >> +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> > >> +       struct inode *inode;
> > >> +
> > >> +       /*
> > >> +        * If this gfn has no associated memslot, there's no chance of the gfn
> > >> +        * being backed by private memory, since guest_memfd must be used for
> > >> +        * private memory, and guest_memfd must be associated with some memslot.
> > >> +        */
> > >> +       if (!slot)
> > >> +               return 0;
> > >> +
> > >> +       CLASS(gmem_get_file, file)(slot);
> > >> +       if (!file)
> > >> +               return 0;
> > >> +
> > >> +       inode = file_inode(file);
> > >> +
> > >> +       /*
> > >> +        * Rely on the maple tree's internal RCU lock to ensure a
> > >> +        * stable result. This result can become stale as soon as the
> > >> +        * lock is dropped, so the caller _must_ still protect
> > >> +        * consumption of private vs. shared by checking
> > >> +        * mmu_invalidate_retry_gfn() under mmu_lock to serialize
> > >> +        * against ongoing attribute updates.
> > >> +        */
> > >> +       return kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
> > >> +}
> > >
> > > Doesn't this imply that all consumers of kvm_mem_is_private() should
> > > validate the result using mmu_lock and the invalidation sequence?
> >
> > Let me know how I can improve the comment.
> 
> Given Sean's context, the comment is good I think. I would quibble
> with the the "_must_ still protect" phrasing being a bit too strict.
> 
> Maybe just soften it slightly to acknowledge the exception? Something like:
> 
>   * lock is dropped, so callers that require a strict result _must_ protect
>   * consumption of private vs. shared by checking mmu_invalidate_retry_gfn()
>   * under mmu_lock to serialize against ongoing attribute updates. Callers
>   * doing lockless reads must be able to tolerate a stale result.
> 
> That aligns the comment with how KVM is actually using it today. That
> said, this is nitpicking. Feel free to use or ignore.

Hmm, I wonder if we can figure out a way to consolidate some documentation,
because this is _exactly_ the same pattern that x86's host_pfn_mapping_level()
deals with (see its big comment below).

There's also the stale comment in kvm_invalidate_memslot(), which, stating the
obvious, speaks to the memslot+SRCU side of things.

Maybe it makes sense to to find a central location for one giant comment about
how how MMU notifier events and memslot+SRCU protections work?  And then refer
to that in paths where some asset needs to be tied into MMU notifiers and/or
memslots+SRCU?

[*] https://lore.kernel.org/all/agcbWe8s9lmPuJwG@google.com


/*
 * Lookup the mapping level for @gfn in the current mm.
 *
 * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
 * consumer to be tied into KVM's handlers for MMU notifier events!
 *
 * There are several ways to safely use this helper:
 *
 * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
 *   consuming it.  In this case, mmu_lock doesn't need to be held during the
 *   lookup, but it does need to be held while checking the MMU notifier.
 *
 * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
 *   event for the hva.  This can be done by explicit checking the MMU notifier
 *   or by ensuring that KVM already has a valid mapping that covers the hva.
 *
 * - Do not use the result to install new mappings, e.g. use the host mapping
 *   level only to decide whether or not to zap an entry.  In this case, it's
 *   not required to hold mmu_lock (though it's highly likely the caller will
 *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
 *
 * Note!  The lookup can still race with modifications to host page tables, but
 * the above "rules" ensure KVM will not _consume_ the result of the walk if a
 * race with the primary MMU occurs.
 */
