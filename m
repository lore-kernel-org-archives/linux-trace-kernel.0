Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1D37C112
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924904; cv=none; b=ZsYEqXzNTt/3cG2HCfC6DWPCMY1WUH47+FUk0G6GhGgzKMYrMpyAYdjB/wPbCM+NU/dvAOFSqfbf+4GCH4mE4WTN9onG9ovdwFCrc8Js/bunuQdWV/ATobRBDwIDLIFcqV1Qffv++jDOn1nUk9bj9ivhVofYjWkffATLrTzzN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924904; c=relaxed/simple;
	bh=L5c3o9vgdgjXHGOQSuIW9q3/2N3iJk6DLv8bljpS7DA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JDw81+T3hkgjyQj93K+y/9UKD2Plx5mb3XSiP+xuUgNVP3aqa5fwj6rYvRAdgz6okfPNajOMVoPtQszc/oa98SJW7c54Z6cI0jb/lv3cZlxqbKt0ieO/3EXrO46eQC9pPYjuQZL7xrHX/zSbhRwqyW9UV0sp7yj0b9v3COqYmeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bm16Jk10; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm16Jk10"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c916d17dd43so1000493a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782924901; x=1783529701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbVYdv7/FNdOOvrw/bcfsmdKoQ369BNbAkiBiKDICVU=;
        b=Bm16Jk10DzFwFM1c7L4fhwdbnVfS0QXzyMzWyFobsZ2zse54L5EUYVd/71MHkeSFHj
         KO50Lstmu5WUaTKkOpNvDhN544ttzDQhhydyddDJJB3vI2q8CnNVUX0LvodCKgB2r/ON
         WlIi271UjYatvD6h1k3itEZwUQUUsJxdOvwekCs1tgd8LZ7rVLPbargP99LeV7LtI9q2
         w+7CnH/Un7Qa9TMiL/hb+t4YlX9LnzrYuIwvc5e61wC+rtzAy8nozGPD0HriOIhqfpLb
         vDY094LXpJ432U4I3O2M6nbsCzPKbRKqfC/xXGmdm2OXVsrOSL6cDSS9LAK/BYlbHv7r
         XRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782924901; x=1783529701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbVYdv7/FNdOOvrw/bcfsmdKoQ369BNbAkiBiKDICVU=;
        b=WcGI/fCONpBTYycG45+rtywWMxoUt7VxJMl7U5ZOIn0DhUUyieMHsNKiBrjUcPTt3Z
         0e5E3fLFHQuFPvUQlrsr8FIhVIFAXurISoXlO2aIu02uHGa3wR3KTQ3PRPLnqz3WkmiT
         pyZC56T0dqeysN7dRUHW7Kd7oalb9HTRAgGQA/lrwyjbCcv0VFWk7gd7jxI8pDxNsAVS
         eOTUof6T9lBNiIDPdK1+phr2r+EA2ODd9mG56tl9Vf541QJD0L3Opev8UlaI48DI219j
         X7FOoJNUimvmgIKJCJVt2FGoqerGK5fScrcRE0163MEfCE3UELkW8p0vyZUwKDVFxXsH
         2HeA==
X-Forwarded-Encrypted: i=1; AFNElJ/+K2f/gypAu9qVEvxu6sWXBFnePnJLb5beG8fU8ghO+7DPKbDeBuHdmZMEYK9hcXxJ1ZbrhvPTOb0CrBAIXDRRU6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4sZLE/MDC/aDAT2JAX9KPFf5BKPV6AMW5xJe4sUQuff83cSq
	f9uewTODwt5VJ/DqXw1Ob/V9nh0MQCi5YVyhstA6oohbmPfnDgtaXKXM5dFYGsIEBv5SStkZ6Ia
	Q7pOVzQ==
X-Received: from pgja21.prod.google.com ([2002:a63:cd55:0:b0:c82:7761:9936])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a49:b0:3b3:bf95:f7e3
 with SMTP id adf61e73a8af0-3bfed477967mr2785820637.43.1782924900819; Wed, 01
 Jul 2026 09:55:00 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:55:00 -0700
In-Reply-To: <739e6834-40b3-405b-ada4-d31c38d8416a@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-6-9d2959357853@google.com> <739e6834-40b3-405b-ada4-d31c38d8416a@intel.com>
Message-ID: <akVGZOeR1ytfkamK@google.com>
Subject: Re: [PATCH v8 06/46] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Xiaoyao Li wrote:
> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> > 
> > Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
> > on kvm_arch_has_private_mem being #defined in anticipation of decoupling
> > kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
> Well, after this series, kvm_supported_mem_attributes() is renamed to
> kvm_supported_vm_mem_attributes(), and it's still under
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
> > guest_memfd support for memory attributes will be unconditional to avoid
> > yet more macros (all architectures that support guest_memfd are expected to
> > use per-gmem attributes at some point), at which point enumerating support
> > KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
> > supported _somewhere_ would result in KVM over-reporting support on arm64.
> 
> I don't understand it. This patch only changes the behavior of
> kvm_supported_mem_attributes(), the usage of which is guarded by
> CONFIG_KVM_VM_MEMORY_ATTRIBUTESq. This is config is only visible to x86 due
> to patch 03. How does it affect arm64?

Hrm, yeah, this is messed up.  Ahh, I think Ackerley shuffled things around and
"broke" stuff in the process.  In v7[1] and earlier, the diff was this:

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 091f201251159..68142bc962953 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifndef kvm_arch_has_private_mem
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 306153abbafa5..abb9cfa3eb04d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2421,8 +2421,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+#ifdef kvm_arch_has_private_mem
 	if (!kvm || kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
 
 	return 0;
 }

which makes a *lot* more sense given the changelog (and IMO for the ordering in
general).  In v8 here, Ackerley combined part of a change[2] (that I provided
off-list) with part of this commit, to create patch 4, "KVM: Decouple
kvm_has_arch_private_mem from CONFIG_KVM_VM_MEMORY_ATTRIBUTESthe".

Ackerley, the cover letter says:

  + Reshuffled the earlier commits that deal with preparing KVM to stop
    seeing VM memory attributes as the only source of attributes.

but there's no explanation for *why* the reshuffling was done.  Reorganizing
code like this at v8 of a series this size is a big "no-no" unless there's a
*really* good reason to do so.  In addition to the resulting confusion, changes
like this invalidate Fuad's Reviewed-by.  And since it's obviously quite difficult
to tease out exactly what changed, it's not realistic to re-review things without
doing a deep audit of the series, which no one wants to do for a series that is/was
so close to being fully ready.  And without such an audit, I can't accept the
patches, because I can't trust that what I am accepting is what I and others have
reviewed.

So, except where there is/was a *need* to shuffle things around relative to v7,
I think we should revert back to the v7 ordering for v9.  And where there is a
need to rework things, each and every one of those needs to be explicitly
documented, because "Reshuffled the earlier commits" is grossly insufficient.

[1] https://lore.kernel.org/all/20260522-gmem-inplace-conversion-v7-3-2f0fae496530@google.com
[2] https://github.com/sean-jc/linux/commit/8a475b1bcf89f1cf776ed9ce7d6bb587aab0d421
