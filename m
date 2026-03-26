Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C03BED2A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568222; cv=none; b=oDKcZQXYSUVWZhaAWG1rqy3IBehhyEBzwvXBXzGOEbvxFSzEL0geqWG+wtbh1cWV2kfM1R3hUzGgQU6YpYtc2xJcWf+9mvT79OgM4wplaUj/2RZtJCK5M4pkPkNsbXHopxERMUf7q4nzcINKLYojq51uZsRPUZUtQcHZQNo2Uyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568222; c=relaxed/simple;
	bh=ROguWgeRYmW2NGhxshL1J1m27mkAuyVZqWW+Rnqw28E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fcau/VAN1nn6g4fkLKHR76cNTMA0JzuvseTfU/vhNG3qmYfnbmbCLZ+SPKu6fccUbqDJOHPPawpiUFat9tHek+1pfaF5pcGuMjR04t6oo4pOzMxeLAWJbU+y6gYzfpYGp0vKmeMnLB+CONlLLZ8fXoNM0v0wv3zVpm06c0rj8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZgrgyId; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZgrgyId"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c714cb65eso1240038b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774568221; x=1775173021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDbojp2aZv00FIsDRORjdXTSkhyjR06hadNHaz3T5HI=;
        b=vZgrgyIdruznXS3apR6PkaMLFIwfMMJ3+VFF7qXbh95cEVD90txuA+wi5KhKmSTnyP
         lVUloHXpPI9Gubiy5AyoAN+hrCy6wL0cDeWuPVaV2t0OtKj+cS6At14SxUFDIJ2c4Z7G
         2G+zmhLn5unIjEQZjfPWXqKU5F3C5OaKBvIc9PCA8pYW71dblj5yyHSYSpL5HdENT4mu
         J4P8lZkJY1zXjjJG03+olBXKSgu1kjg86FqKXokkdXo/raJ6L0x1ruuK5o6awquFgJZ8
         EaJQHd9/oG2VKbPvlL/xx8ZUE/FVSNli6gNcP3AEfhasIFCo11g3BxAWaBoXGqBK2rQ+
         NESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568221; x=1775173021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDbojp2aZv00FIsDRORjdXTSkhyjR06hadNHaz3T5HI=;
        b=BKH2DcpIgVMTiOhFo8+9Bc+ZdSqGtGjz9iNQDwCe/xYVEimyG1jgh5zkrZDjiiSDRc
         M5XsmJ6qAFlW3PlXzLjOx+/kx09Yv/pg55W4FZwX7ltQVj0jtmfx+mfSZXr5snkQr/Jg
         itZQcRLzP1q8oZNHEukXTWn4shA0vVP0x/kRltMQO8XKbVoLSnqYhdRDjYVvUyYctvBS
         RNGxcxAJ9u6uHAHD1Ix7/IJbOt1jrKrQONHuMhs8Lhjv2ybTi1pRIgfJkDEZlblwgQoq
         UqMcmqUKY8tdauTK67k76hQoPdAVvtETsRFSgzBZZ96AEcoW1oQk0uXWPH5cmbGQSYjM
         4ypA==
X-Forwarded-Encrypted: i=1; AJvYcCXSsLfsUa9acWG96WtcPdMzabF8Sajf3ZF4ljvdO7zlqLPE4hsgB92Owgt4qlR55coDgYanpyZUSpE76QFPgz/ge14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2n6GcOX+qFdALRCZLmsYECAcGERBHe0THZlmUIos4Q29R4BN2
	7cdsD1UkM2U/1MVTgNr28QoywItTi8uNxM12zMhoifsHWMIbXIkX9J6boN2GMC2qPZDE2DzRpuh
	qYy/ZWR9NzXxni21RBZonTxO6OA==
X-Received: from pfnj5.prod.google.com ([2002:aa7:83c5:0:b0:82c:649d:baf4])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9090:b0:82c:6cbe:7935 with SMTP id d2e1a72fcca58-82c95ee4b93mr291131b3a.28.1774568220675;
 Thu, 26 Mar 2026 16:37:00 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:36:39 -0700
In-Reply-To: <cover.1774568083.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com> <cover.1774568083.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <5f3dc762b9f08c1c398027e2ff4863ab46c3c04d.1774568083.git.ackerleytng@google.com>
Subject: [POC PATCH 1/6] KVM: selftests: Initialize guest_memfd with INIT_SHARED
From: Ackerley Tng <ackerleytng@google.com>
To: ackerleytng@google.com
Cc: aik@amd.com, akpm@linux-foundation.org, andrew.jones@linux.dev, 
	aneesh.kumar@kernel.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, chrisl@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, forkloop@google.com, 
	hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, jmattson@google.com, 
	jroedel@suse.de, jthoughton@google.com, kasong@tencent.com, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, rostedt@goodmis.org, 
	seanjc@google.com, shikemeng@huaweicloud.com, shivankg@amd.com, 
	shuah@kernel.org, skhan@linuxfoundation.org, steven.price@arm.com, 
	suzuki.poulose@arm.com, tabba@google.com, tglx@kernel.org, 
	vannapurve@google.com, vbabka@kernel.org, weixugc@google.com, 
	willy@infradead.org, wyihan@google.com, x86@kernel.org, yan.y.zhao@intel.com, 
	yuanchu@google.com, Sagi Shahar <sagis@google.com>
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
index eaa5a1afa1d9b..68241e458807a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -483,8 +483,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 {
 	uint64_t nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
 						 nr_extra_pages);
+	enum vm_mem_backing_src_type src_type;
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
+	u64 gmem_flags;
 	int i, flags;
 
 	kvm_set_files_rlimit(nr_runnable_vcpus);
@@ -502,7 +504,15 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
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
2.53.0.1018.g2bb0e51243-goog

