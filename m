Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192613DB636
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369713; cv=none; b=i/h/ApFwYoQkqM9TOOIi66OCpMYD0Q3HIiY+NheOmH0aSwZEpph2Ah7ggVEGs1MPD6fSmJJCKKDruD5RWCTbIvr12I+NpHLrsdgQDmpx8M3eeLrbGwd7XXoKrMzz4LM5Re5S/orRh5NZHpBhLOr0TT6Q6ZB8ZU3G+hK1R571p7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369713; c=relaxed/simple;
	bh=GR5EzgovptfxCzgfSgkwiZJkZXAcFVBl5/RrfGUEW8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pwdo+ctWOomlGPe9wkb7HGk36zqv+WeAfW3RX6qT2kFeolmnavd09n1ZJx6c4VLmTKdVXEqdfIuEDESCRcDQjQsaI6ogJ2b+sIhQ90Db9cEiEiY8xiUXbp7IAQ9/YQDMXBs9wBgf7vAp7AAMSvvV7Yaxd4vXBVqLHUKrg0cmZRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYEG3oq2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYEG3oq2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9429f49cso9191289b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369710; x=1779974510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIrwVyrI6nQx/ALkh7jG2SEyqSQ/V8q8plyAwbOOpCU=;
        b=RYEG3oq2ZTrSTV0TH1vtNNxSBDtD4K1xxalLEcrDej4hdaOhsKBHGGGC4EnHOwbQyj
         MvmiJwYop8WRlkRyjeOyFwTeyLhOLE7wNNYKAEIQdy9gDbcnrLrI4MMZyOrz0laO9Qvi
         6h/i6dRSm7shO7Is+86v8dlJVIxxbfRn3WZAEGTWg/8EQ0DRjyIwWFnx94d7lq/MCE+O
         XoVeXRv/WgEL810+3/iYtwQJHIeBr8qDhWb8jsJ4FDFsW06vu+UI1Uj/UNRPDilb1A3x
         xU6XuX/bH9e07NDqGinypBZT05jgSk6etbPND9k2Kkqo3FoVgj/+ItyVAi7tW6sW8FaN
         LG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369710; x=1779974510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIrwVyrI6nQx/ALkh7jG2SEyqSQ/V8q8plyAwbOOpCU=;
        b=eUtJBdzLEtTV0mU7v6EJHPsKlxQJxgqB0tuOndtJhjjooqrJzzce4P1BW/jxgWrArX
         6ow1hFxvSsDvc6J8G7aH/CgA5NAvhG8K40YiLELzIw7eAAlQ5+ZBxxsEFVLtd3AIOa/A
         401VQhLwEcVJ1MDelI5IvQpef2aZn9WTMQZdg+6nc95TRUdTMe8iTmupHHrFfO/pTR+l
         AhPxc2EREfBREGTMCxwGPPUHV/nMJZ7CYamvVr2vvkry4k+kEN+fsRf2W3Mpeq6AXTd4
         IqLzWir6IBVzT/x2qZvoVJUyi0tOn4J3vIPkwrBtsD9A5/D+MvOH13T+4bQNdGwrsUiV
         luAA==
X-Forwarded-Encrypted: i=1; AFNElJ+uUaev2T8gEETHZwWyLvRyyyyzcpU0sgbCFfu5YmvFHbcZN9xTU+U7GsIeKj3rP7NcNQZKCmDnTsoycqZqrDB/wsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywop0RMsd1Qz2scCCL47ExTIjb4BEjyFrYM4pCe4dfZeBlsywbg
	Xrn+/LO0AjL/B4M5B2FOSkuFfMxaOpPKqM29By/W89dxZKu2IY5iV8nIIBMH/GGTsbMXY7Xljdp
	6g3zkPg==
X-Received: from pfbmb13.prod.google.com ([2002:a05:6a00:760d:b0:82f:4abd:a354])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2793:b0:835:cc47:6fe7
 with SMTP id d2e1a72fcca58-8414adf7c0emr2878031b3a.30.1779369710072; Thu, 21
 May 2026 06:21:50 -0700 (PDT)
Date: Thu, 21 May 2026 06:21:49 -0700
In-Reply-To: <CA+EHjTwrygfMrZZSw4y7-ry8fidW2x0C7iuF2Q=dnPNHUmNtUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-21-91ab5a8b19a4@google.com> <CA+EHjTwrygfMrZZSw4y7-ry8fidW2x0C7iuF2Q=dnPNHUmNtUg@mail.gmail.com>
Message-ID: <ag8G7Wq5PbEdKloG@google.com>
Subject: Re: [PATCH v6 21/43] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
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

On Thu, May 21, 2026, Fuad Tabba wrote:
> Hi,
> 
> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Michael Roth <michael.roth@amd.com>
> >
> > For vm_memory_attributes=1, in-place conversion/population is not
> > supported, so the initial contents necessarily must need to come
> > from a separate src address, which is enforced by the current
> > implementation. However, for vm_memory_attributes=0, it is possible for
> > guest memory to be initialized directly from userspace by mmap()'ing the
> > guest_memfd and writing to it while the corresponding GPA ranges are in
> > a 'shared' state before converting them to the 'private' state expected
> > by KVM_SEV_SNP_LAUNCH_UPDATE.
> >
> > Update the handling/documentation for KVM_SEV_SNP_LAUNCH_UPDATE to allow
> > for 'uaddr' to be set to NULL when vm_memory_attributes=0, which
> > SNP_LAUNCH_UPDATE will then use to determine when it should/shouldn't
> > copy in data from a separate memory location. Continue to enforce
> > non-NULL for the original vm_memory_attributes=1 case.
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > [Added src_page check in error handling path when the firmware command fails]
> > [Dropped ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES]
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> I'm not very familiar with the SEV-SNP populate flows, but it looks
> like Sashiko is on to something:
> https://sashiko.dev/#/patchset/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4%40google.com?part=21
> 
> - a potential read-only page overwrite, because src_page is acquired
> via get_user_pages_fast() without the FOLL_WRITE flag, but is then
> overwritten via memcpy

Oof, yeah, that's bad.  Adding FOLL_WRITE to kvm_gmem_populate() feels wrong, and
could break uABI, but doing gup() in SNP code would reintroduce the AB-BA issue
with filemap_invalidate_lock().

Aha!  Not if we use get_user_page_fast_only().  Ugh, but then we'd have to plumb
the userspace address into the post-populated callback.

Hrm.  Given that no one has yelled about overwriting their CPUID page, and given
that the CPUID page is likely dynamically created and thus is unlikely to be a
read-only mapping (e.g. versus the initial image), maybe this?

diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
index 37d4cfa5d980..c73c028d72c1 100644
--- arch/x86/kvm/svm/sev.c
+++ arch/x86/kvm/svm/sev.c
@@ -2456,6 +2456,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
        sev_populate_args.type = params.type;
 
        count = kvm_gmem_populate(kvm, params.gfn_start, src, npages,
+                                 params.type == KVM_SEV_SNP_PAGE_TYPE_CPUID,
                                  sev_gmem_post_populate, &sev_populate_args);
        if (count < 0) {
                argp->error = sev_populate_args.fw_error;
diff --git arch/x86/kvm/vmx/tdx.c arch/x86/kvm/vmx/tdx.c
index f97bcf580e6d..33f35be4455b 100644
--- arch/x86/kvm/vmx/tdx.c
+++ arch/x86/kvm/vmx/tdx.c
@@ -3188,7 +3188,7 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
                };
                gmem_ret = kvm_gmem_populate(kvm, gpa_to_gfn(region.gpa),
                                             u64_to_user_ptr(region.source_addr),
-                                            1, tdx_gmem_post_populate, &arg);
+                                            1, false, tdx_gmem_post_populate, &arg);
                if (gmem_ret < 0) {
                        ret = gmem_ret;
                        break;
diff --git include/linux/kvm_host.h include/linux/kvm_host.h
index 61a3430957f2..b83cda2870ba 100644
--- include/linux/kvm_host.h
+++ include/linux/kvm_host.h
@@ -2596,7 +2596,8 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
                                    struct page *page, void *opaque);
 
-long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
+long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
+                      long npages, bool writable,
                       kvm_gmem_populate_cb post_populate, void *opaque);
 #endif
 
diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index a35a55571a2d..6553d4e032ce 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -858,7 +858,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
        return ret;
 }
 
-long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
+long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
+                      long npages, bool writable,
                       kvm_gmem_populate_cb post_populate, void *opaque)
 {
        struct kvm_memory_slot *slot;
@@ -892,8 +893,9 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 
                if (src) {
                        unsigned long uaddr = (unsigned long)src + i * PAGE_SIZE;
+                       unsigned int flags = writable ? FOLL_WRITE : 0;
 
-                       ret = get_user_pages_fast(uaddr, 1, 0, &src_page);
+                       ret = get_user_pages_fast(uaddr, 1, flags, &src_page);
                        if (ret < 0)
                                break;
                        if (ret != 1) {

> - an ordering violation with the kunmap_local() calls

Yeesh, that's a new one for me.  Thankfully this is 64-bit only, so it's not an
issue.

> These predate this patch series and are just being touched by the
> 'src_page' addition, but if Sashiko's right, these should probably be
> fixed sooner rather than later.

Yeah, ditto with the offset wrapping case.
