Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0742E41C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857689; cv=none; b=dkkUqoZED8N+/BXYW+K8TKHd7fp6dCnF+MTB1yaJJjthr116nYdjLHIqpElrSgwKmxIL4WW9DzXAJjuRwAbVIs/12kt/RlyjH4cMw4S5R8saJLkRIC8vuwQMvn2lNRIF0WWkYi7rgZJtWPcmWpldDcC+1Nr2gRj+uDfj/ytiwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857689; c=relaxed/simple;
	bh=YAu1i5AWtB/mdPrcibBFB5fs0b8x5YEB+6wjvbVTug4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G5au5uAJvRhwx+hQujVFGS9xr37kLMOrcW3Xx6C4f+dlw1rMVpt37SlzkadYM8wNLy97HIazi0gljvCVk40+C8JurmgwvqIuw4Uw2AF8fu8UoeHNz6keCpjF+Zq+MRSvjsYU9EoC/PRtM3xWa8SebBNCjYbWjOoAPZSIS7ryTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJmxmaO3; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJmxmaO3"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so1639875ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787857687; x=1788462487; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWGZwnfyNQRYCnM1UqJIynPGxtHIQDoEVfaq/bKW7II=;
        b=VJmxmaO31r7QLA8hqwiQw6U4P4CwtVzNizJ3PZzdr5ThgK/gxjKEC3mTiUvUCottSv
         oah9VlHb0ddZ2PEAAUkx8914qBHIH/Kx6vyLtwqflipv1dGedMiZZsVwzgrt0+x7a0Zu
         x/VS8XZNJySa9B1UW3ax7qFGwbQ6yABtFR4v1IulsDfsvjdBJ5y9s1U6j9fiS2eVW6fA
         cccq98BRoExqMMtnC83N50B5qUqeXYzAIALkGGvL/Z2SpfGkoAkcyjitP9S5ZqXZr/lI
         sWpzHFmbhI/RZ63ony6FUltQ8Clo6ZzsL28salyR+gJxS3vYv/tS/eVFW3hDiLANmwuX
         ZTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857687; x=1788462487;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWGZwnfyNQRYCnM1UqJIynPGxtHIQDoEVfaq/bKW7II=;
        b=IiTs52X5Vingj2az9PJFgCBiSb2bYhQc7NI6P/y+K01HrhRzqLR4xu+q5sF9+Xvbo9
         ItpKP/3Tj8hIHh+gl1eA2grBnGD5yRGBiHAehCIH8p1cZ2A9wRkIVHZu3i5D1u6M9Cdx
         89ZkBJFPdcDFojKLpE7lgGaovyLM3YEJa0Vb+owgzPcc761lH8rKqhvfDfEWnJ21hMhq
         RtOujDNUFXoP/XEC7GEocCxAb+K7hlBZ4RUPUzMr/lVy3zNhaDCnDzSW9rmJHy2Hji1D
         A9PXAxeSqmE/R03vwHiABsOPT+DD5Lefivw4Ue/wkFGe8IHAxNmmGp71D0tbx2hhWP2y
         nThQ==
X-Forwarded-Encrypted: i=1; AHgh+RotoV59o03CRVMN213ItTowo2kuO65DrdsvFg1SiwKOi2GBbkDSUsFLGw0wqykWySHFqrW1EA4zBFD/3hut4xYEFH8=@vger.kernel.org
X-Gm-Message-State: AFuF++k35i4t1X5jZ/ABTtDgoDINgKmeHBtx/lLcXdPwc3Qhge/I8adQ
	Ou+ZHE63iiQWXY5SZk6aok4e/nDK1d0GvOrFWLajA4AIUxkKnpxAtPnParvoKWbCu8+dL++fBFO
	17Fh9ig==
X-Received: from plblq15.prod.google.com ([2002:a17:903:144f:b0:2d6:e58f:8e81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15cf:b0:2d7:1aeb:739
 with SMTP id d9443c01a7336-2d74e1295c2mr19606415ad.13.1787857686248; Thu, 27
 Aug 2026 12:08:06 -0700 (PDT)
Date: Thu, 27 Aug 2026 12:08:05 -0700
In-Reply-To: <a151b52d-0afb-4b32-a871-4da67210f416@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com> <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
 <aoZZMQ3Uc8yQWPNA@google.com> <7eba513d-cdae-4832-abac-038dcdd88517@intel.com>
 <meww2a2uf3yeevsfpicyrlg3hch2x4bsdqv2lsv3vfjxg4qzes@co5eogmhkxrk>
 <ao3lOu8-wpGTs2wd@google.com> <ba8d0441-b52f-4357-b2e7-1e352aa385a2@intel.com>
 <CAEvNRgFXJbV78ktsg=b4srFp1OFjtQWQGuNPjr_MmWD-wOvjgw@mail.gmail.com>
 <ao7vwx3nMqCjCHZU@google.com> <a151b52d-0afb-4b32-a871-4da67210f416@intel.com>
Message-ID: <apCLFSbj8sq2biJp@google.com>
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Xiaoyao Li wrote:
> On 8/26/2026 9:53 PM, Sean Christopherson wrote:
> <snip>
> > > Is this just a case of user error? That with gmem_in_place_conversion,
> > > userspace should not use userspace_addr from something other than the
> > > gmem for the same memslot?
> > 
> > Yes.  It's not just invalidations that will go sideways,
> 
> > KVM accesses to guest
> > memory won't hit the same physical page as actual guest accesses.
> 
> Side topic.
> 
> If KVM enforces KVM_MEMSLOT_GMEM_ONLY when gmem_in_place_conversion is true
> like below proposal, should we update KVM's guest memory accessors to access
> gmem directly?

No, because routing KVM accesses through uaccess means we just have to ensure
PRIVATE memory isn't mapped into userspace, which we already have to do anyways.

Now, that doesn't preclude future work from optimizing certain flows to avoid
GUP, or to harden KVM in other ways.  But as a first step, bypassing uaccess is
actively dangerous.

> If still use the existing code of accessing userspace_addr of the memslot, I
> think KVM needs to document clearly that when
> KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES is enumerated, if configuring the
> guest_memfd for a memslot, the userspace_addr passed in needs to be the
> mmaped address of the guest_memfd.

Ya.

> > Huh.  But that isn't strictly guaranteed, because userspace could bind to a
> > memslot that isn't configured with GUEST_MEMFD_FLAG_MMAP, in which case SHARED
> > faults will go through the VMA, not kvm_mmu_faultin_pfn_gmem().  It's a bit early
> > in the morning, but off the top of my head, I can't think of any reason we need
> > to support such a setup.  If userspace really, really wants to use a separate
> > mapping, they could DELETE+CREATE an equivalent memslot without the guest_memfd
> > file descriptor.
> > 
> > So I think we should do this?
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 9c2d52bdf25e..86f53e53a136 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -1013,7 +1013,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >   	 */
> >   	WRITE_ONCE(slot->gmem.file, file);
> >   	slot->gmem.pgoff = start;
> > -	if (kvm_gmem_supports_mmap(inode))
> > +	if (gmem_in_place_conversion || kvm_gmem_supports_mmap(inode))
> >   		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> 
> I like this idea. It makes gmem_in_place_conversion a step closer to what
> its name implies, though in-place conversion is not truly 100%
> guaranteed[*].
> 
> [*] https://lore.kernel.org/all/akUbz_kJvYulaboo@google.com
