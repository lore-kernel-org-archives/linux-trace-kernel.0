Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF73546F0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303548; cv=none; b=MsPyv6qsYCYPL9ZvOjSmBil6aF6gwFwbAdl+cJTG1qKyWZIC6+I//Id2H+dRGIu9coftQocZ50j9pT+uB5fLDBe1TIy1sd3WboLtTBhRIW/UE9fr253KKOzZyT/lZKZZVn4m15fqbPsO56KdeC1raN66BTaESzTBkDbeWcSH1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303548; c=relaxed/simple;
	bh=CAg8fHi2CXutX4k3jIaYo/3dkMGuQ6K17aloqCRhD8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcghTdk67PH6qaBYfzNldpNIfofc/6XeRvwOktqzJaKWjvsfJy2QyBh+IlB2A6G4+vRjKmuRlAEgy+krf+QRQtPp0orr3+tuZJ0xBXOStzBl5ZmWpLuroq/8OZZhUKF6flIDkl2HoUrn8OOgn2I1WrjDhTUMFzdhO8E6oG/1oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onKZcqng; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onKZcqng"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36781927b4dso6042081a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303545; x=1779908345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xc+eqLu2deOuDSSfxTvMnxL/tYv4gr65bHOPW09jR0U=;
        b=onKZcqngaSjPPE+f2t12Z1e1WELmaKqAUJkbsPODr4tAIiQv4ODxBi4NeYCZ80HIdL
         XJ62WqlroG3ZhOK1xHVkKJpWkX1Ye9UA6v+lFs9AbBKcYDjwTP6tCs1Ab8m9zu1EwqJc
         1h7NiJV+bXwDVamlOFlHf43enNUSQ3tDotd15SCyTKx9c8Ipkqd1nzTrrUMjbwjwgpdz
         QjpR5TaXcYU0Q2rjGckZSnvkGgBV+e20WFIE4zOcyFfJY/ffn4NUQSMiuyO2G2L7cIR9
         FfQq0bTtZiQdBjKCghiLP5UDVD/54G9wmRGqXbVttw8PqTEh3dEXc++yfUTV9adIHeNc
         iS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303545; x=1779908345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xc+eqLu2deOuDSSfxTvMnxL/tYv4gr65bHOPW09jR0U=;
        b=cQsn3Bhggriz6+EvL4IHazhT0dj+Z0rv2eMcHFfEGAoYGBw+j/iy4Y0U9RSR1GjMLo
         SPmVNmk3FT2HDBZqADwrPXrQIg02S5c15XcyYizbB6egZtp8kqDHwcbyNR85CGoeEHTI
         SXxJPFPOKK4o5vQneDlE/rYEozCmfcmjZQ8AJjp96G1UHgK6aZAgePZ6ZdEomxLeRN6T
         w5M65QVq1b+IOqil6kJn369+NcPSYvc7qkBAYEoyJ0J0x9CPMq+TZ3Aok7VUD/Rn10xR
         lap6wd1Mjz7JucQyCfO28DlDtEebaL5gVG0nBbq6xVM+1rvkHKhbdN59VTPhT/Xq/Gjq
         Z+ng==
X-Forwarded-Encrypted: i=1; AFNElJ8fIy85ihRIK3JYcRZSLjyfQv7gyoS09NF8cMiT/1FiXBSm3VdSXNgjL9/WK+iV8JgiCnrYDnfFRUBGUyw1CsaT06I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9s9Vg09ngPuKI08XMpbeUvrobCmzkgouseNZgr80I4FPVND2
	At2jxKPKDU8TaXKWrAr7yz7Rgub+mV8Mfma+UV3MYHzo5t4V78y6ZvdakXCSoWjdoAxPnyt85VI
	S/kYhHQ==
X-Received: from pgbcz6.prod.google.com ([2002:a05:6a02:2306:b0:c79:8756:1a98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734a:b0:3aa:f9cb:d43a
 with SMTP id adf61e73a8af0-3b22e67fe5emr29278600637.5.1779303545036; Wed, 20
 May 2026 11:59:05 -0700 (PDT)
Date: Wed, 20 May 2026 11:59:04 -0700
In-Reply-To: <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com> <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
Message-ID: <ag4EeByDV-OtGhlk@google.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
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

On Wed, May 20, 2026, Fuad Tabba wrote:
> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Implement kvm_gmem_get_memory_attributes() for guest_memfd to allow the KVM
> > core and architecture code to query per-GFN memory attributes.
> >
> > kvm_gmem_get_memory_attributes() finds the memory slot for a given GFN and
> > queries the guest_memfd file's to determine if the page is marked as
> > private.
> >
> > If vm_memory_attributes is not enabled, there is no shared/private tracking
> > at the VM level. Install the guest_memfd implementation as long as
> > guest_memfd is enabled to give guest_memfd a chance to respond on
> > attributes.
> >
> > guest_memfd should look up attributes regardless of whether this memslot is
> > gmem-only since attributes are now tracked by gmem regardless of whether
> > mmap() is enabled.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  include/linux/kvm_host.h |  2 ++
> >  virt/kvm/guest_memfd.c   | 31 +++++++++++++++++++++++++++++++
> >  virt/kvm/kvm_main.c      |  3 +++
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index c5ba2cb34e45c..28a54298d27db 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2557,6 +2557,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> >                                          struct kvm_gfn_range *range);
> >  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> >
> > +unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
> > +
> >  #ifdef CONFIG_KVM_GUEST_MEMFD
> >  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >                      gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 5011d38820d0d..f055e058a3f28 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -509,6 +509,37 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> >         return 0;
> >  }
> >
> > +unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> > +{
> > +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> > +       struct inode *inode;
> > +
> > +       /*
> > +        * If this gfn has no associated memslot, there's no chance of the gfn
> > +        * being backed by private memory, since guest_memfd must be used for
> > +        * private memory, and guest_memfd must be associated with some memslot.
> > +        */
> > +       if (!slot)
> > +               return 0;
> > +
> > +       CLASS(gmem_get_file, file)(slot);
> > +       if (!file)
> > +               return 0;
> > +
> > +       inode = file_inode(file);
> > +
> > +       /*
> > +        * Rely on the maple tree's internal RCU lock to ensure a
> > +        * stable result. This result can become stale as soon as the
> > +        * lock is dropped, so the caller _must_ still protect
> > +        * consumption of private vs. shared by checking
> > +        * mmu_invalidate_retry_gfn() under mmu_lock to serialize
> > +        * against ongoing attribute updates.
> > +        */
> > +       return kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
> > +}
> 
> Doesn't this imply that all consumers of kvm_mem_is_private() should
> validate the result using mmu_lock and the invalidation sequence?
> sev_handle_rmp_fault() calls kvm_mem_is_private() without holding
> mmu_lock and without any retry mechanism. Is that a problem?

Yes, but my understanding is that sev_handle_rmp_fault() can tolerate false
positives and false negatives.  It's not optimal, but it's "fine", and already
KVM's existing behavior, e.g. KVM gets the PFN and then smashes the RMP, without
ensuring the PFN is fresh.

Mike, is that all correct?
