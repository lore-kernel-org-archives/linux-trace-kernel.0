Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2588318EF0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186079; cv=none; b=f/BseJ5EIKYLDdNBO62W2Y7/adLTkgA/h1u4ibyLXvL0SeHwflSiOn86vJCSCaUFsuDAoTf11wW3MIz9Jkl9UgD292zsrhcx9HsJSmvCOgzfF6Sm7AhTSAmIYevpZCkGOJ+g4iAzrZUaLOwMGkfalBBTQl4cwT86nIB7FDEs5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186079; c=relaxed/simple;
	bh=XICUZV4Q3vo1bwz1aYHmgOLx20RYd7LOuzutPezZwNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PFDIjFI2JU2pTNVQeWI8OiPGbwsiY/E0iZozyZJALolMzSOswRumhDT/AOPYReQDjsgtzVVOpMVlIYqsq/mht2JYC/kSh9HTm7Hiv509OrRQpBjvo0z+ChiLkZI9TMmbUIgTkqpihgi7oxOSTOIG65wDQuT/sswzAoCe2SOaQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smH7WZWt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smH7WZWt"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so764677a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778186076; x=1778790876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rSsfG+RQhLqlg/UzpmHhS2dOMMTtnfzAhKgDM/p2is=;
        b=smH7WZWtygoLpgQlrcAiof8k5ONzz3OURLH0ACDzOIh3kzUtpYgw916DeNUQKqEyFx
         U9UiRr4bH5XT0D0KMk/FYz7O2AM6wrj77ycRM9MFVih3q1c23gR+Iifl4mwiRSj5L4VA
         CVdBSrqJ8ZVmcJYvtynPBjpmtEgDQ9bROQ/mMXkSiOBREqkGfFMPW0s6l2LcKvJqOdtC
         EGxyH6xqQX0SlUNE4WCIDc0V8whpd/REVFzyV+ech8FkECmdkfQ6YBS5WomK9Y9HmubI
         A9s43B9k5oE+KoOsGCMh3vY/cB1CBOXE0ZGWrlm2x1Mkyuk6EXW2jyF3H6WfKJxdqI7W
         M2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186076; x=1778790876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rSsfG+RQhLqlg/UzpmHhS2dOMMTtnfzAhKgDM/p2is=;
        b=mrGCJczO+rltNrR7HGY0SCb0uDb6FqHXbTfOwiltBV6jJvTQFgyQQdRWc/bJ3Jynh1
         RIqyesWo6rUA5WqSO0ZbVY+e2TQzIWDM1IVMAgDQ0B4mZF4VE6w/hajSUWg+/Ta+9MrM
         28fWll2ov8OG5JWjdsuLgiuk2qcA+FVukv6N68QhhjqIwk/pR52uC9bGhaiCy0V/sVYQ
         IqIErDJfZNs8XzZlgOAYa8USkA+HdGsOk3Ypd/jXommerWEGixM4m4apsI549eGSwRNN
         R2TCFV7tqQJMlHhfrixpUZDSwgi8mLTvTLJjO5X4/1mFckuEFnedLe4jN12IEVhLEVDH
         GyAA==
X-Forwarded-Encrypted: i=1; AFNElJ/UWEbih8kxumh3rm62lfZeTFJuA1I4G0JOXEZxrgswzTzSTEsY1CJcZ5rLE5C57gYJynDBnxbNC++NCM6s+8NR7+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjvJimVBTBEbAygAwJfOlF7RhvfQa9RkOO9PgkME1cjXdqCQf
	pIrp1IRhnVNFuBQ+CNg4JtEZc5ZTvNeURTgQKufjSs0X9LdlZ0Zzmcb4r6lRRO8bP6PBcIAYRpF
	BIIbScF4A+HinshCU5ndU95n0Vw==
X-Received: from pgbdp8.prod.google.com ([2002:a05:6a02:f08:b0:c76:8ec1:5090])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a108:b0:3a2:f05a:795e with SMTP id adf61e73a8af0-3aa8be52328mr4117250637.3.1778186075304;
 Thu, 07 May 2026 13:34:35 -0700 (PDT)
Date: Thu,  7 May 2026 13:34:22 -0700
In-Reply-To: <cover.1778185936.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <cover.1778185936.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <47758a2b79c4bc570a17c9216929693953bdf5a0.1778185936.git.ackerleytng@google.com>
Subject: [POC PATCH 1/5] KVM: selftests: Initialize guest_memfd with INIT_SHARED
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, liam@infradead.org, 
	linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com, 
	Sagi Shahar <sagis@google.com>
Content-Type: text/plain; charset="UTF-8"

Initialize guest_memfd with INIT_SHARED for VM types that require
guest_memfd.

Memory in the first memslot is used by the selftest framework to load
code, page tables, interrupt descriptor tables, and basically everything
the selftest needs to run. The selftest framework sets all of these up
assuming that the memory in the memslot can be written to from the
host. Align with that behavior by initializing guest_memfd as shared so
that all the writes from the host are permitted.

guest_memfd memory can later be marked private if necessary by CoCo
platform-specific initialization functions.

Suggested-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d1befa3f4b305..a377e5f333116 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -483,8 +483,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 {
 	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
 						 nr_extra_pages);
+	enum vm_mem_backing_src_type src_type;
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
+	u64 gmem_flags;
 	int i, flags;
 
 	kvm_set_files_rlimit(nr_runnable_vcpus);
@@ -502,7 +504,15 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 	if (is_guest_memfd_required(shape))
 		flags |= KVM_MEM_GUEST_MEMFD;
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
+	gmem_flags = 0;
+	src_type = VM_MEM_SRC_ANONYMOUS;
+	if (is_guest_memfd_required(shape) && kvm_has_gmem_attributes) {
+		src_type = VM_MEM_SRC_SHMEM;
+		gmem_flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+	}
+
+	vm_mem_add(vm, src_type, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
+
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
-- 
2.54.0.563.g4f69b47b94-goog

