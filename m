Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB381A6838
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663209; cv=none; b=YBodLQXQN7gA/7HG8xDFdJyXpFcm/luGsbWFUpM6cLnnzCTIJHiSCKBUmXJy2M8fAEav0E64/j9N7zB7vCzNItFMSN0Ka9DBgG1QLVRiKrmm1UeW+AmWelbpYebbXmMce65i3By3EBojUh7q5b79XbBF9D+9kwSMQS5ylUdNH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663209; c=relaxed/simple;
	bh=P1xSyofiihGU4hoXXl6kH7BNXuJ3Sw3I4xzRxoTH5Cs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tf5gEVQ0WPN9G4EcKunwMnVAFIOIYXM1GnHrwGrDbdBB4/WNLYfSC25QcxZ/3jeL6sfne5jiVzYRW7R6JgZViDifD8JdGHjt34YXbf8Gq7/OkjRBkJgVpLBuZhd01sIom2z5kv03zNpB5peG676Vh+1JQ6Pk661eszk8jo/ozlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urv4aPk6; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urv4aPk6"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so502388a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786663206; x=1787268006; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s7W2EF/B1upW3gWk47NaF5dFLDVwJn/JvniCK/05iC4=;
        b=urv4aPk6SOCaLrpve7drVVfnL5qXcye3heu9q+C/C8UvA/0tsPIQvHiGSMliit3v8q
         rxN1MmxfCXaMNfAsFkIao7ki0cHZcw5/0zoeLO4mQOqhTz/0ajwb4T7Bkpz2GwvlBW2o
         WekDcSWvHmTIOdT6lUBGCIXfE4ehj/lSTWjcJJjUgo0BGRjmYeJigwyQioM68Qt/Jnod
         FVxX58Fap+seOSVWOjqXKNmsDF2dGQh0zfalXxjorG1oIWkLOjNCadul6LvFFUP8mBmA
         zNsByWlbNv3HAyh9gGnpej7M0zmz8Nfelju2H20tjMjAL029AjTyKKihTB1LZuwYu7kf
         +vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786663206; x=1787268006;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7W2EF/B1upW3gWk47NaF5dFLDVwJn/JvniCK/05iC4=;
        b=IgumlfcqITlSUoxhJt3tg9e4WTQLt7e5nbt1syR6ayQ2KfRj2Yl3RMVSkEstvgx11s
         OCWLSQSNcNTg9lqw/BU753FBcjN9d2CVR1pMJeY0SCjecwYQPCYKrG5LYF8G+25jb+Q8
         fpI8ghbJ0SdUWUQp7qZHBGEThZyFZz4SH4N9nx0esubU8vNIgJMWStPpQNy+Tmq+YD7Q
         16OGaHeZEialsMFhNgBHYmoklkT2am2SZOkCRnr0AzUMyMT4n+WQ82s3hCjdCLLJAhlj
         TJ/vfUDOFnbS9y/Eb1mFeNBovQVNdHHpyk+2X19QbbZcLCI/QOSbbL0u8qg1r9raCKik
         mAeg==
X-Forwarded-Encrypted: i=1; AHgh+Rruo5h3UODJSFmq3oKt/AlAtSiETQTTuFDmQovFMkBoAgAijNC/HHtOmjV2BA/gjGuCoaJeplNWxOKwzhwDbDoIcHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGPlk0NXm9OxRBGp3Ly0sHaBj3zVm0UtvfgeKvmjDuXNYR7KA
	FNw13wexLEhdVw9LfZ5FyShwd0c8hww8LkRIxYxZfY3Aw0se1YJSX1oyns9hRE3RuazoN2jg2ZD
	s1L+e1A==
X-Received: from pjuf1.prod.google.com ([2002:a17:90a:ce01:b0:38e:aa86:7cac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfcd:b0:38e:c7b0:84ad
 with SMTP id 98e67ed59e1d1-3933b503abcmr1679606a91.0.1786663205745; Thu, 13
 Aug 2026 16:20:05 -0700 (PDT)
Date: Thu, 13 Aug 2026 16:20:05 -0700
In-Reply-To: <0c80b9b0e13e3ab2cbe4f9eaf4a02ebba25a7001.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com> <anj2bPrGqzZgZWMF@yzhao56-desk.sh.intel.com>
 <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
 <anp1I64K0KeyQuyo@yzhao56-desk.sh.intel.com> <CAEvNRgFWcndQKJE_q+ZATFZEMYd=6uRLygozLvg7L77bPX0cEQ@mail.gmail.com>
 <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com> <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
 <a71d4fccdffd1f6a12332ddd18fa812542ea2118.camel@intel.com>
 <CAEvNRgHxda6XK_XqWaqqVnA7oW=Fhp_C5gF4vNcL+-HfwfXMqQ@mail.gmail.com> <0c80b9b0e13e3ab2cbe4f9eaf4a02ebba25a7001.camel@intel.com>
Message-ID: <an5RJYTwlYeym--O@google.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "ackerleytng@google.com" <ackerleytng@google.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"steven.price@arm.com" <steven.price@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"forkloop@google.com" <forkloop@google.com>, "tabba@google.com" <tabba@google.com>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, "willy@infradead.org" <willy@infradead.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "wyihan@google.com" <wyihan@google.com>, 
	"pratyush@kernel.org" <pratyush@kernel.org>, "aik@amd.com" <aik@amd.com>, 
	"jmattson@google.com" <jmattson@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "rientjes@google.com" <rientjes@google.com>, 
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "chrisl@kernel.org" <chrisl@kernel.org>, 
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "oupton@kernel.org" <oupton@kernel.org>, 
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "baohua@kernel.org" <baohua@kernel.org>, 
	"tarunsahu@google.com" <tarunsahu@google.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>, 
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jthoughton@google.com" <jthoughton@google.com>, 
	"yuanchu@google.com" <yuanchu@google.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shivankg@amd.com" <shivankg@amd.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "youngjun.park@lge.com" <youngjun.park@lge.com>, 
	"kasong@tencent.com" <kasong@tencent.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "weixugc@google.com" <weixugc@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "qperret@google.com" <qperret@google.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>, "corbet@lwn.net" <corbet@lwn.net>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "liam@infradead.org" <liam@infradead.org>, 
	"axelrasmussen@google.com" <axelrasmussen@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"qi.zheng@linux.dev" <qi.zheng@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 13, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-08-13 at 11:51 -0700, Ackerley Tng wrote:
> > "Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:
> > 
> > > On Tue, 2026-08-11 at 10:35 -0700, Ackerley Tng wrote:
> > > > > > Would like to see what Sean thinks of this. Either way, is it okay to
> > > > > > follow up after conversions lands?
> > > > > Let's see what Sean thinks of this :)
> > > > > I raised this because the issue was encountered by one TDX's stress
> > > > > selftest.
> > > > 
> > > > Which stress selftest is this? I can try running this on my side too.
> > > 
> > > We have some selftests that are built on the basic TDX selftests. One just
> > > hammers the MMU stuff with a bunch of zaps and also weird stuff from the guest.
> > > It was eventually too much work to try to keep the internal enhancements rebased
> > 
> > Would like all the comments we can get on TDX selftests v14 [1]!
> 
> I think we had a few. Let me try to round up some more folks.
> 
> > 
> > > nicely so we actually just run an old branch's TDX selftests against newer
> > > kernels. So the branch is a bit of a pile, and not really suitable for sharing.
> > > We plan to clean it and upstream it when the path clears. So it would really
> > > help to get those basic ones upstream. We remain happy to help, so please let us
> > > know.
> > 
> > I guess at this point I'm hoping y'all and Sean are okay that this
> > conversions series merges, and we let this stress test failure be
> > handled later. I'll be around to fix things :)
> > 
> > I'd say the line of sight to fixing this would be when the KVM MMU only
> > gets PFNs (and no pages at all) from guest_memfd.
> 
> Hmm, I think we shouldn't upstream a uABI that we don't have line of sight to
> making robust. So it would be good to settle this thread at least.

This isn't uABI.  You're talking about hitting a race condition between one task
converting a page and another faulting in the same page.  An NMI, SMI, or IRQ at
just the right/wrong time, especially on a preemptible kernel, could lead to the
same test failures, even if KVM drops the refcount "immediately".

That said, I am 100% in favor of not handing the caller a struct page.  Now that
the TDX APIs no longer require one, it's more than feasible.  But, we absolutely
shouldn't just nullify the pointer, we should drop the param entirely.  Not just
because it's cleaner, but because it also forces an audit of the callers to see
if they subtly require a refcount (spoiler alert).

The lone holdout at this point is sev_handle_rmp_fault(), which could end up
PSMASH-ing a PFN that has since been freed by KVM.  Assuming holding mmu_lock
while doing RMP operations is ok, something like the below?  Completely untested.

As for in-place conversion, this is not a blocker.

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6c941aaa10c6..8ef16ccf26ce 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1641,7 +1641,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
 	smp_rmb();
 
-	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
+	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, NULL);
 	if (ret) {
 		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
 					      write_fault, exec_fault, false);
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index fb54f6dad995..c982a6454fc9 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1411,7 +1411,7 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		if (is_error_noslot_pfn(pfn) || (write_fault && !writable))
 			return -EFAULT;
 	} else {
-		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, &page, NULL);
+		ret = kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL);
 		if (ret) {
 			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
 					      write_fault, false, false);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c519e8e8d646..f0da212ab108 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4603,8 +4603,7 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 		return -EFAULT;
 	}
 
-	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
-			     &fault->refcounted_page, &max_order);
+	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn, &max_order);
 	if (r) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return r;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fcb41dfde4c0..3b1c42e03deb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4060,7 +4060,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 * The new VMSA will be private memory guest memory, so retrieve the
 	 * PFN from the gmem backend.
 	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL))
 		return;
 
 	read_lock(&kvm->mmu_lock);
@@ -5003,7 +5003,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = vcpu->kvm;
 	int order, rmp_level, ret;
-	struct page *page;
+	unsigned long mmu_seq;
 	bool assigned;
 	kvm_pfn_t pfn;
 	gfn_t gfn;
@@ -5030,7 +5030,10 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 		return;
 	}
 
-	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
+	mmu_seq = kvm->mmu_invalidate_seq;
+	smp_rmb();
+
+	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order);
 	if (ret) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for private GPA 0x%llx\n",
 				    gpa);
@@ -5041,7 +5044,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	if (ret || !assigned) {
 		pr_warn_ratelimited("SEV: Unexpected RMP fault, no assigned RMP entry found for GPA 0x%llx PFN 0x%llx error %d\n",
 				    gpa, pfn, ret);
-		goto out_no_trace;
+		return;
 	}
 
 	/*
@@ -5069,26 +5072,29 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
 	if (rmp_level == PG_LEVEL_4K)
 		goto out;
 
-	ret = snp_rmptable_psmash(pfn);
-	if (ret) {
-		/*
-		 * Look it up again. If it's 4K now then the PSMASH may have
-		 * raced with another process and the issue has already resolved
-		 * itself.
-		 */
-		if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
-		    assigned && rmp_level == PG_LEVEL_4K)
+	scoped_guard(read_lock)(&kvm->mmu_lock) {
+		if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
 			goto out;
 
-		pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
-				    gpa, pfn, ret);
+		ret = snp_rmptable_psmash(pfn);
+		if (ret) {
+			/*
+			 * Look it up again. If it's 4K now then the PSMASH may have
+			 * raced with another process and the issue has already
+			 * resolved itself.
+			 */
+			if (!snp_lookup_rmpentry(pfn, &assigned, &rmp_level) &&
+		    	    assigned && rmp_level == PG_LEVEL_4K)
+				goto out;
+
+			pr_warn_ratelimited("SEV: Unable to split RMP entry for GPA 0x%llx PFN 0x%llx ret %d\n",
+					    gpa, pfn, ret);
+		}
 	}
 
 	kvm_zap_gfn_range(kvm, gfn, gfn + PTRS_PER_PMD);
 out:
 	trace_kvm_rmp_fault(vcpu, gpa, pfn, error_code, rmp_level, ret);
-out_no_trace:
-	kvm_release_page_unused(page);
 }
 
 static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..502465119ca0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2586,13 +2586,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
-		     int *max_order);
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
 #else
 static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
-				   kvm_pfn_t *pfn, struct page **page,
-				   int *max_order)
+				   kvm_pfn_t *pfn, int *max_order)
 {
 	KVM_BUG_ON(1, kvm);
 	return -EIO;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b596486d184c..ba7b46c1aa15 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -751,8 +751,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 }
 
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
-		     int *max_order)
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
 	struct folio *folio;
@@ -780,12 +779,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 #endif
 
 	folio_unlock(folio);
-
-	if (!r)
-		*page = folio_file_page(folio, index);
-	else
-		folio_put(folio);
-
+	folio_put(folio);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
