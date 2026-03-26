Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7F3939A6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563907; cv=none; b=aQg5IqlebyJd1B9vDYmYh/2+QH2AQM6eclroD452R65BRcFWozJhuRRGKdcUhyBPRBSiCzD7Sc33uuuzyLJ/E06Tcus1+JDSQdTTPqUK/MQe4otXB1gOSRFxRDWoc5+aQPYjGJMqba5Zjx/uCkBS51YOq5JokGKK7ss8j4qyt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563907; c=relaxed/simple;
	bh=lV6fFCVa5Ssv2nfU9VT8o7Ba92Z0xl34eyZmNTzM1LQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JBBr5f6a5+MVVF7AYSjQrJMx3ew64Z+xUCJCBh19i1C1Y88s7zvbvrCTXtRs9AlC+zvcuQ/4yZ82jmVDzwmLKgOYPj613aSlGIuDgQDDEMI3cpazI4K/wWpVm5JSiezcK64l1Z0fNoXY596iw0TFLIbxeuI80UvFTUPmEnyqeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7Ck2tL9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7Ck2tL9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b051befbb8so16243175ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563906; x=1775168706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WEpiZ3Ie+u8cFKZvwOJ8qoXWS/RraT/cFEJPQll04wM=;
        b=X7Ck2tL9CIRdZJcvS2cfTNT5TdkzrEHAbPoU+UskZCPmsCOF9GSDsEgqHsKvbenByc
         d8TqnkI4pZtKvSgzljm8WHZJjSaWmxoZFkGQDtnftSiQ5RIHOps0EViO4/g5bqbk13Iy
         s53tr1LbW/nGmft1qcgkqHGd2Sf9pE4LkKA1yF7WYIYda4nuugVQx1FFJLC17J/3ITMv
         fpbxLcXAnhekhDpJ28BvOTpmmMcGrbfJteKg4e9/v7C+PcgXF0icRhByLjQIhZIxE/Xf
         EedJFpETjVrkqdfsnAT8PHBZP/N9b118lNc3rdSHHWWGN9fL6LWmasXeEpKCtnZyjrdq
         Tsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563906; x=1775168706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEpiZ3Ie+u8cFKZvwOJ8qoXWS/RraT/cFEJPQll04wM=;
        b=EmON2SVdodd9+bIXtMzaqetWvE4xgDaX1QI1TiNlMTDMs3zaYw0D1B2NHDCmqdiRNk
         p2McDIcL5zxmC8HUbyrShXxlfbbWFzy5OT8HtL8UoiyzOmvn1VlS0vKRwFxPprkhqQeE
         /fBJTdjRHTD7RaJiIJ8K7eolAhiEWFuri6jLrapWydhqRQsh/ZEmOYlPraYjvKlt6OE0
         7H/T5aSsLC1yHlgbXUtSdjouvcHzMLVtna0qRNVN+4kBB6KnBwERDW+ZauW7mKFD/Dsx
         fmYJn1WMPLxx99eg3C5ISk0DoZPNf0AAAhj3E2/AaqCryU6/PWTt/FS6vrWxMKa0POMW
         3yfA==
X-Forwarded-Encrypted: i=1; AJvYcCWyN5VkSn/H63SlfHMFTjNOKjlrADyhr/O8gjApBFixD0WwN/8smwuXg9tMXzyXw7Iu+tZ56QJ1GMyul0+YDS7HNRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/y9ABoFA5Cj2CeFXMuTqqfwovUXi0+Z1XEXHctUP07gZF4MDV
	s+iKpejF0lCj9VkJmjDjvK6kbCh9nTFfdxtRBcB0uXSAKn7gxYV+AWLuvi8JkvGp1oDWkQ8la3V
	ZOxzJ3UjS/UyQPJ6+M9rzqWEUWw==
X-Received: from plco20.prod.google.com ([2002:a17:902:e294:b0:29f:25cf:e576])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:40cf:b0:2b0:9a6f:cbb with SMTP id d9443c01a7336-2b0cdcb0c85mr2171345ad.26.1774563905367;
 Thu, 26 Mar 2026 15:25:05 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:29 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=5500;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=3vNAWgtLoposophLWrViaHYvvOXZ6Fk6ckKHKISBIQw=; b=5ZW/84CSiLisXbfe1r14r83e3Hy3AoEnZdshNnLemzJjOMY2dPsrs925RHSHU1mSj258Dyyz5
 VMpW+WjIPY4DZdPwGAgjCBX703FNh7usPXzDd1fpjoEGG2Zj0tLFl/f
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-20-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 20/44] KVM: selftests: Add support for mmap() on
 guest_memfd in core library
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Accept gmem_flags in vm_mem_add() to be able to create a guest_memfd within
vm_mem_add().

When vm_mem_add() is used to set up a guest_memfd for a memslot, set up the
provided (or created) gmem_fd as the fd for the user memory region. This
makes it available to be mmap()-ed from just like fds from other memory
sources. mmap() from guest_memfd using the provided gmem_flags and
gmem_offset.

Add a kvm_slot_to_fd() helper to provide convenient access to the file
descriptor of a memslot.

Update existing callers of vm_mem_add() to pass 0 for gmem_flags to
preserve existing behavior.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[For guest_memfds, mmap() using gmem_offset instead of 0 all the time.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h        |  7 ++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c            | 19 +++++++++++--------
 .../selftests/kvm/x86/private_mem_conversions_test.c  |  2 +-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index b2d35824f2a72..4e06724cd2935 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -701,7 +701,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 uint32_t flags);
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int gmem_fd, uint64_t gmem_offset);
+		int gmem_fd, uint64_t gmem_offset, uint64_t gmem_flags);
 
 #ifndef vm_arch_has_protected_memory
 static inline bool vm_arch_has_protected_memory(struct kvm_vm *vm)
@@ -735,6 +735,11 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
 
+static inline int kvm_slot_to_fd(struct kvm_vm *vm, uint32_t slot)
+{
+	return memslot2region(vm, slot)->fd;
+}
+
 #ifndef vcpu_arch_put_guest
 #define vcpu_arch_put_guest(mem, val) do { (mem) = (val); } while (0)
 #endif
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3b64fbadcd88d..82d6945efa29a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -979,12 +979,13 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int gmem_fd, uint64_t gmem_offset)
+		int gmem_fd, uint64_t gmem_offset, uint64_t gmem_flags)
 {
 	int ret;
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t mem_size = npages * vm->page_size;
+	off_t mmap_offset = 0;
 	size_t alignment;
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
@@ -1063,8 +1064,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	if (flags & KVM_MEM_GUEST_MEMFD) {
 		if (gmem_fd < 0) {
-			uint32_t gmem_flags = 0;
-
 			TEST_ASSERT(!gmem_offset,
 				    "Offset must be zero when creating new guest_memfd");
 			gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
@@ -1085,13 +1084,17 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	}
 
 	region->fd = -1;
-	if (backing_src_is_shared(src_type))
+	if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP) {
+		region->fd = kvm_dup(gmem_fd);
+		mmap_offset = gmem_offset;
+	} else if (backing_src_is_shared(src_type)) {
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
+	}
 
-	region->mmap_start = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
-				      vm_mem_backing_src_alias(src_type)->flag,
-				      region->fd);
+	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
+					vm_mem_backing_src_alias(src_type)->flag,
+					region->fd, mmap_offset);
 
 	TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
 		    region->mmap_start == align_ptr_up(region->mmap_start, backing_src_pagesz),
@@ -1152,7 +1155,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 uint64_t gpa, uint32_t slot, uint64_t npages,
 				 uint32_t flags)
 {
-	vm_mem_add(vm, src_type, gpa, slot, npages, flags, -1, 0);
+	vm_mem_add(vm, src_type, gpa, slot, npages, flags, -1, 0, 0);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 1969f4ab9b280..41f6b38f04071 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -399,7 +399,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
 			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i);
+			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, 0);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		uint64_t gpa =  BASE_DATA_GPA + i * per_cpu_size;

-- 
2.53.0.1018.g2bb0e51243-goog

