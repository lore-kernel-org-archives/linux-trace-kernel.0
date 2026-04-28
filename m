Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB13C3449
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419216; cv=none; b=sMdH72NZ7dtT3x4HhLiogYXSaPwTY40PZB7V69Fbc5UwsMtfY6FzXdjTd/fBBfx0sOatBhNFBrIt5rMROP6eJ22WFuJ1xVWqUYm8QSHgzCp9R9pUIP3JCct6B7gZ8srgWaXFzbgNVAqGR8EZA2fLe9vTTSQsempMZmzr/RXDtOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419216; c=relaxed/simple;
	bh=pxP9/9LLgcfS3FwRY48zWn6LZ8mBkoCeEKDgjkyGm4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UchivTjQmKc7via6KASw6ExExjGGK+eTekJfcQFcmqAKknab4xOSda+1EqEOoCynHzhJ6uaS7WJ0ByuZ1v61R9e3kHGHcqnLSr7CM5HlLzuOPKlK4NrHHGjUPVzdRjYAlKd3AkT3Ouwuul1+47mDjjhDC/r5C3m4sdv9z2Lj9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nw7VdXOb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nw7VdXOb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso7080229b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419214; x=1778024014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JdDnj6qR6N2qFPR2vghpCWrCloc8FcwG1Yf0aZJlDY=;
        b=nw7VdXObGlaGP24FZxG6eFR+yNlTiR2tkBjZENsTd683sMUOyJYLwv+2zRyXehfSrU
         1jnZpLgkJ+docIdb8GpNjq6+ppkgFThyeBOI0eC4y70ij8TmuW4y9b65+CCwf24fWFJp
         7KM9XJE6MP0JRReruIHJqcwAZJvX72sEFARtI5zWQnl/eQSTybMLveKP/8kuQpQ3Ed7f
         RqNpPOOQg01/drc6FC/PxbHk/Mevg6e5onxypWMrSNtyzo3xbBDd1jjx4j9DESidCQRQ
         v5QUZLP5cTHeP68TV43X65OElAwIsCvqYPeWELxCYOi23rjqW3VnU8jPGdqrkif1cWuO
         CjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419214; x=1778024014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JdDnj6qR6N2qFPR2vghpCWrCloc8FcwG1Yf0aZJlDY=;
        b=K56zhnhuncYN45/jG8iKoIklkh70tI3Mf8Z2WN9KQkTE3NAb9+akiR0LGrWYKEQVXe
         7CkNshb1mtinLuPtLlNOJl01IgLCtJGEqp+Hm9KH9+3WYTGI57kVL4jkzdAX41R7UGIH
         2doRBkauirAD+LOX2894PvAorRU8GklrEEGHwrFLhoNeFMddDj3tp6sPsoB/8BfpdWaW
         FEJoHF76uwLXjn6taHTWDVTCClaBxJacgA1q0XrC56aP0mkhYORCDRiCb8oJeAeQUuwx
         n/Wc0JHITfDlc2MEtZLwxXsP1Jij4WsGQo1h6MwxpKGYjYAvjsDeUo2ZXb77O5/HlIAu
         OU8g==
X-Forwarded-Encrypted: i=1; AFNElJ+hCQVmdDaFI+tTC7ebPZ1TKU51coP/3X0O6yeGFd8tZYz/1rD+eF3yJ1HQhu+wUB1TCrLYrZW8vJ1OX8+iE4jPctQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LTi0I/sCjY7AOrT3cY8TAwyjR05i5LYs6O80Twl7oLM2YYZ5
	7cqgBNa1/FFKDUuHeT3qgQVvZfBSYhnkwWUXeKXkHkiBLCiOQWFEhsLq4mDXpW4g/Gn2BQ+ARvQ
	gb9bwqtMW059/y2hWdbOyKxvhyQ==
X-Received: from pfbkh40.prod.google.com ([2002:a05:6a00:9468:b0:82f:ac74:4db5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:84b:b0:82a:5ef0:210b with SMTP id d2e1a72fcca58-834ddaec17emr5534199b3a.15.1777419213403;
 Tue, 28 Apr 2026 16:33:33 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:24 -0700
In-Reply-To: <cover.1777418884.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <cover.1777418884.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <a8c4b7958bf1d8667338b816409fd02dbee11174.1777418884.git.ackerleytng@google.com>
Subject: [POC PATCH 4/6] KVM: selftests: Allow specifying CoCo-privateness
 while mapping a page
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h |  2 ++
 tools/testing/selftests/kvm/lib/x86/processor.c     | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 77f576ee7789d..683f21452db58 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1507,6 +1507,8 @@ enum pg_level {
 void tdp_mmu_init(struct kvm_vm *vm, int pgtable_levels,
 		  struct pte_masks *pte_masks);
 
+void ___virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
+		    gpa_t gpa,  int level, bool private);
 void __virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
 		   gpa_t gpa,  int level);
 void virt_map_level(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b51467d70f6e7..02781194f51a2 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -256,8 +256,8 @@ static u64 *virt_create_upper_pte(struct kvm_vm *vm,
 	return pte;
 }
 
-void __virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
-		   gpa_t gpa, int level)
+void ___virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
+		    gpa_t gpa, int level, bool private)
 {
 	const u64 pg_size = PG_LEVEL_SIZE(level);
 	u64 *pte = &mmu->pgd;
@@ -309,12 +309,19 @@ void __virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
 	 * Neither SEV nor TDX supports shared page tables, so only the final
 	 * leaf PTE needs manually set the C/S-bit.
 	 */
-	if (vm_is_gpa_protected(vm, gpa))
+	if (private)
 		*pte |= PTE_C_BIT_MASK(mmu);
 	else
 		*pte |= PTE_S_BIT_MASK(mmu);
 }
 
+void __virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
+		   gpa_t gpa, int level)
+{
+	___virt_pg_map(vm, mmu, gva, gpa, level,
+		       vm_is_gpa_protected(vm, gpa));
+}
+
 void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
 {
 	__virt_pg_map(vm, &vm->mmu, gva, gpa, PG_LEVEL_4K);
-- 
2.54.0.545.g6539524ca2-goog

