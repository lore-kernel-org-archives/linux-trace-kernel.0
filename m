Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719653BFAFC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735909; cv=none; b=D3khbcn0tIqLc/fz2WUyzG3zJ7A2izkN6HtixaSOtSpA8TvmuPlXebtlQ1qmqjdi+AYgxs04BfzI/bigxr6EaWeqKQH2S7Cvnfg/QVU7pApuonOD6pjgrcRyEeT0nie7fyRAbIX/tb/cRvpFYImZKwyXggK5Jz56mYf1QEzQDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735909; c=relaxed/simple;
	bh=afP/+CCsVFTr2xg/bwgkEuVycKnb+hKmVnnJC1PouTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rr6pYHxjTUimDG1iviOJsp8lcOHh0fyAP+NcuTxqKvw7s4sYxeHzAKUhJxMwkXe+XC2Ozi9mt0ya/fA3VP3wlc6xpVdLlP/As9Ek5sVfIVCfIUcC4MJ3ftFQlOaAGrMqyyDqPPtCe/wHpYBORwDxxw+pYxaqpgf2K2nDWdzmUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIArfXYA; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIArfXYA"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d04908139bso12127865ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735905; x=1788340705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdZRVSrnkEM/WAJPszboRZoIkHXEJBSzC3AJhV/B8JA=;
        b=bIArfXYAQVI+yCexFk1kb/tnIp2bSiznXTxSbayweEKfAZ6WtFzZMpISkZ/czdS/cy
         PHonjFGSL7wPG2AIfWQ3mz0wRwZdwqo2OC75dIIEpB8fBXIa0YD9ooBlD03ti4MoVgUH
         vMFfO7N6V7wKnZFFO9KUV+4zquDvbLZndAInrxVOJe3WBUu2dFNuzMJyHaxzr95XrAsk
         ybSGXlJX78SL1aC9HA0cdZAVSGJZYNc8pV4xYsUSqJkrc7n+8fl5As7YX2gGCk5ZDgfm
         tesStl3nbazMLVlaFKo/mXyu7C7UjqssbQ0I83/2J7eK+xESG5bx+bZUebfNSTsvJQFO
         ryzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735905; x=1788340705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rdZRVSrnkEM/WAJPszboRZoIkHXEJBSzC3AJhV/B8JA=;
        b=EaBdstJfpOtIdyUIGwXbTr0UF4Kvl2U/g7oMwi8oAFZ4+iIQ4XEtTSVQJKA+PTKsUV
         RfH3NHjva0OHvwXtKCTtrK3lNwxuy+AVq+d0ETVI+KRU3Y0I+MG9mIz2j18l9TCaSEvq
         vUqLltrBeTVE1L8AnRoPa81SVgAsgTxGwWIbcZdTACF62WJji0xR1GTp74snokfZo9xC
         ssAPQhU+pKMa8sRuMxo7G+pRT7jdkFF5MYtzXGy8cNhEMsVIUD52PCxNfablxlRmdSu0
         s5XLKx+61FjICQbLW2CPQUD0V2BFsht3YzELsuyuZxD4xv74iZvG5A4bbAoYCGJoJgii
         z2GA==
X-Forwarded-Encrypted: i=1; AHgh+RpIPtFHao7BFSWCe1I0K3JZCLg3kjVCaLT9yrOdDfrcSQT6+UcDUVIoUy4BkOgUgPOylIxpNeUVhYRQf1qcihuPDXg=@vger.kernel.org
X-Gm-Message-State: AFuF++n2oqmQNTfknPFZBgCsiJYhin5w0FRvWTvfRIu7WQFyaqDMu/4y
	9xrBCfezZaFx6T5+tKGzKVoDSAB37u6dm+UbIwtx/OQhES4lBpvxQXwFM+H5By4mFBXbHoL7ufL
	D4L+/PGdhH8ScpSZ6bNMgvpRFNw==
X-Received: from plbki11.prod.google.com ([2002:a17:903:68b:b0:2d0:159a:c32f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19ed:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d7079ffa9fmr95729835ad.6.1787735904427;
 Wed, 26 Aug 2026 02:18:24 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:08 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2542;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=JEqd6+3Jm2IN8pmwc/4dv/jyCthiIWqttsX9YClt2p4=; b=nsKZnu1YDavx7WArwRNpZYT8oZFR13lhfa0X6RxUzams7dxT8V2wkp13BS2tew8618zVQoSdk
 IMAoO1VhDEGCOdZmT0xofpV4JgTgxEjtuLo5vH+ZhyBHGZ/doYV1t9o
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-10-0a15d8a799aa@google.com>
Subject: [PATCH v11 10/46] KVM: Consolidate private memory and guest_memfd
 ifdeffery in kvm_host.h
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Move the kvm_arch_has_private_mem() stub and a few guest_memfd function
definitions/declarations "down" in kvm_host.h to utilize existing #ifdefs,
and so that related code is clustered together.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b0110143d2ff8..ab87effdd221f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -722,27 +722,6 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef kvm_arch_has_private_mem
-static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
-{
-	return false;
-}
-#endif
-
-#ifdef CONFIG_KVM_GUEST_MEMFD
-bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
-
-static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
-{
-	u64 flags = GUEST_MEMFD_FLAG_MMAP;
-
-	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
-		flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
-
-	return flags;
-}
-#endif
-
 #ifndef kvm_arch_has_readonly_mem
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
 {
@@ -2592,6 +2571,11 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 #else
 #define gmem_in_place_conversion false
 
+static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
+{
+	return false;
+}
+
 static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
@@ -2600,6 +2584,17 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn);
+bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
+
+static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
+{
+	u64 flags = GUEST_MEMFD_FLAG_MMAP;
+
+	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
+		flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
+
+	return flags;
+}
 
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order);

-- 
2.55.0.887.g758fc8c411-goog

