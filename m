Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549534C815
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382396; cv=none; b=s74xt8U0p3W743eFqtzC41+JhN9K/wuu1d2sJuYRP7IoTpqsZ1Lhe3oDNVgWdcwuAlcYQnGn06R31XML3LjO37ajL04uC0j8D08iLudAuh+I3ZrxQtBUSsqn2CP8WW6O0XsMxmBXYu+Gx04wyBqGMZQ9NvH0YtEtaJ62wHpIwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382396; c=relaxed/simple;
	bh=LB/c9880A4gPkN7BFedv8GkhIgobxX+Kgw1lEard0qU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lGMti/eLourBXp48YGO8m5L3Sp5e7oLUK5aKH504Wrpsxdaf0iV/YqAep9KNi/2iq3b84h8VLvz28UXZPKK1VeQGVC17eMLXQpfLp7cPV6UXuA4/T5DKLV4tM8oj26peCjZCwav5vc3G4gYVouBeQ8eo1XEVLGaZnlgL0HKx9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OI9hprbV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OI9hprbV"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3595485abbbso1929742a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382393; x=1773987193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA4vlpQjFWqvT5wQWRcoveFoqdTQ4mLT81y2IZEP3Cg=;
        b=OI9hprbVJtCOwpcwAKWNgrZYQ9VjeCnrxPRQCvXKNh1gKsRbrvYyCV55V3uMZSkbfT
         7zM1nkK1JSkuv8fuQXOLy4lhev2N+Oce+wep0rXkoI1zb2qP232rh4+46T2dOUyorNQQ
         CTZ0AGqG1676FXgZX9LpRxHjIlR69kqrgoAhjZL7y2sNy87x1P45FVGl/JflA9UGfutR
         0QBrXwDiWEz9P+3KUihsKdBYgspJOGW/oV+RI2C2XkjyRfKp7DLPq3XNPxvtYy6/z3Zp
         dbRd4tk4xMoSI/7xhR/pUSPD5+/eNRONyIGZvWYI+23flr8vqrsbbzAmsOak7A8i3CHH
         OiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382393; x=1773987193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA4vlpQjFWqvT5wQWRcoveFoqdTQ4mLT81y2IZEP3Cg=;
        b=T2iVVpMBprAlSAmd1WhuMzEbPY7WABfqHkRf71irf7eWRDfNjokx3mRquHERGrSwxm
         sGQaurYFq15oE4vCcp52kPAcVoUwvsF9+iI9unfDGZBs8LpoxBsV8QbWlnwtFhH9qeWg
         PyJtoJJozKjehMcpyLg/EzMXsxjXxNWUVqxxdPkDss0al0BIzclT5TGGY2m+/F9tz/kf
         Nwqps80ssUaZ9PMuerNsILO69OWgdHxeCn+Lpq/iZqRX/K7GB4Cjvp34H9DgCzCgZigC
         dc7O/uFmmd3JCxwPLXVGzex1oO1NqnrLc8hthIIY6+tnX2yutnNWfm+J2+Mj0bWGB587
         yhYw==
X-Forwarded-Encrypted: i=1; AJvYcCXLLOCrWVeQkt+iyLng5b4m6VJUCxbl2vDfn8kLROf5Y6ppYeCOhVtB5h6lyC5XWMg1OyUMFyY2Pviq1twEC2L4BvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRWmAwETstqC0r44S01+Ve33wDaTwOQA9kCdUvlHckbh+Uos5
	UY7Tr9Kc7JG81Amjx+QnVOwmkXeKXw5bHNZxJ7D38dAocwIYWwiTuhNuOJVP4xbdgjhJFRwoLDu
	UdJKNjAUE1gqfJpfOPnQ+ToXpLQ==
X-Received: from pjpq24.prod.google.com ([2002:a17:90a:a018:b0:359:f13d:47e3])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b82:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-35a22003cfbmr1920770a91.16.1773382393031;
 Thu, 12 Mar 2026 23:13:13 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:54 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=5513;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=wjluatSRa4SZMqiPhVXUZiGzpgBh6y1tcvUXSnigBps=; b=SnHcT6BLijI/s/eop0MIHaP4TDea+AZNypT33DeRdeN6br0y1kobmWHh3mfT63BN0GTKQ/mYX
 JGeVEfKTF+FARlop7kGa3xz2A0KnwROEVv0kpUFAz3RSWyq3EJggbz7
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-15-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 15/43] KVM: selftests: Add support for mmap() on
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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
index 8b39cb919f4fc..caca482aad859 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -701,7 +701,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 uint32_t flags);
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int guest_memfd_fd, uint64_t guest_memfd_offset);
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
2.53.0.851.ga537e3e6e9-goog

