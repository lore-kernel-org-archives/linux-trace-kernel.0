Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0C30648A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666919; cv=none; b=U86qaitYWi0lp4ThjjJkO12W9e0TIU0GiSX6gKp+iw3/mq/GKGS9WyIPR4MZUXCehy7qGpTA5EYdPBimuGnErsAQRBL53Q+AqEjEuGKtzm8xRj4l7W5PP3PFGSaDBnVOWjufMgzx1j/kbuYkQ7+3nocMTtwkPJYOaWltttpcguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666919; c=relaxed/simple;
	bh=7+r23TKgmsqBLQcWF7hPMEFFvse7t0aIst8UmzgU0FE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Om3OK7PWZ3EmGBT+PfVVfJZipFlQuZeOhK22aof9XilCCVK123QAeZ2nTQt10kLrMRD7qvMRWmjiKFYp+NGecdri0SIHKsjUU/PJ7qqoqCO0kq7eymjTkNW/STklN0Gh4uUaIWRJzMwoqYw6M6HLD+oNPxTPOEKUIlnU77UP0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaVT1Rv5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaVT1Rv5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf281d523eso15566275ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780666917; x=1781271717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUZLRDZINPeKp8iZBTkFhcKneeUpQ2lNxFBRVRcVkWQ=;
        b=qaVT1Rv56hLfQyh6p2xChAQIwV5eH2fDrVCVrtyDmVGHPrX1eyYCdq8hU7/3TzssPy
         iSsIE8ZCPPt9y5BJjwczRSW4pc6Nyhzg5sj1L6IMMyduAjxlMOYqZcnh3iZvuq1OOx6e
         mmSjupvVK75uL/lyV1D4i5ad8fnfFIDvp5AkiUPAF0Yci+Ij2I7zaWsEJzOKiFf0z4C+
         iVLs6JPX1W9zQUM8M7LQB9vcDhiYIPdz/TE7a+FkduHWZ+Iyo9SmtaDLIK4Ti8CS2Mw1
         Fp231V+nsnmF5ouF4hETilNJmTkVqF0mutBtIGO3OWpYx04+Cj3K/sCwOfQUduP3SOwx
         WnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780666917; x=1781271717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUZLRDZINPeKp8iZBTkFhcKneeUpQ2lNxFBRVRcVkWQ=;
        b=XOUkqM3C8wwFlo3WKieo7L8wp/nA5u1iI/PlGx+xH6wfs16kCiKDrWtkDpW+EZQUQW
         48PfYNLhE7b/lzzmaMTR/DLngiU7i94XNDcvnsy3wI5ug4XTu7UOBHVIgCB5C8W+lfPf
         brQqZW83DCDeP8vyjjtEq8fdfagqO0/9k++BJVxn1DHQkLkupDxCkuM4zE8maYyxzUZv
         aLf/FRmtQvK5wSXEfpw5fapIqBqjgGRvdDfizXouqGmakKfMfnGC4DlcKFxUu2ni3IDX
         vUCtIZRlGHTsqpdmTNVZBql9vFsYVWiqskkRdZgPVjfvEHfjerAe+oWGGmgvLBFnZcQA
         TRoA==
X-Forwarded-Encrypted: i=1; AFNElJ/oznDlv3ffd5VgAYKFdtVDCIvRb8im1MJ4L5BeAecvCdLUcQiHdWSMGYUKc273Va94Mxps7fJ6ZyJpOOtzxRxuq/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnHYHy4aGSRF98o/w01J5wo1B6JptXhqFDwLINxvmQDwpBEUt
	ssresFmmDCLmrQygbXcdWTv6hjDMV3AABhTVSF2VGQUdN0HLOPoYI/nckTzDbmt1YaB18weMCyU
	rXc4lTT1bg9VzQhSe/yMHHtjKXg==
X-Received: from plbli4.prod.google.com ([2002:a17:903:2944:b0:2bf:238f:8196])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1252:b0:2c0:c625:4010 with SMTP id d9443c01a7336-2c1e8102377mr37507845ad.32.1780666916287;
 Fri, 05 Jun 2026 06:41:56 -0700 (PDT)
Date: Fri,  5 Jun 2026 06:41:53 -0700
In-Reply-To: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605134153.204152-1-ackerleytng@google.com>
Subject: [POC] KVM: selftests: Verify conversion works with TDX
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
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

This POC shows that conversions works with TDX:

1. Find 2 pages in GVA space, map those twice, once as private and once as
   shared. This avoids having to manipulate page tables in the guest.
2. Use memory as private memory in the guest.
3. Request to convert memory to shared.
4. Write shared memory in the guest, check in the host.
5. Write shared memory in the host, check in the guest.
6. Request to convert memory to private.
7. Use memory as private memory in the guest.

I based this on Lisa's series at [1].

[1] https://lore.kernel.org/all/20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com/

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 7cdcaf33b585b..093921af7d93e 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -26,6 +26,160 @@ TEST(verify_td_lifecycle)
 	kvm_vm_free(vm);
 }

+static gva_t conversions_private_gva;
+static gpa_t conversions_private_gpa;
+static gva_t conversions_shared_gva;
+static gpa_t conversions_shared_gpa;
+static size_t conversions_size;
+
+u64 tdx_map_gpa(u64 gpa, u64 size)
+{
+#define TDG_VP_VMCALL 0
+#define TDG_VP_VMCALL_MAP_GPA 0x10001
+#define TDVMCALL_EXPOSE_REGS_MASK 0xFC00
+	register u64 r10_reg asm("r10") = TDG_VP_VMCALL;
+	register u64 r11_reg asm("r11") = TDG_VP_VMCALL_MAP_GPA;
+	register u64 r12_reg asm("r12") = gpa;
+	register u64 r13_reg asm("r13") = size;
+	register u64 rax_reg asm("rax") = TDG_VP_VMCALL;
+	register u64 rcx_reg asm("rcx") = TDVMCALL_EXPOSE_REGS_MASK;
+
+	asm volatile(
+	 ".byte 0x66,0x0f,0x01,0xcc" /* tdcall */
+	 : "+r" (r10_reg), "+r" (r11_reg)
+	 : "r" (r12_reg), "r" (r13_reg), "r" (rax_reg), "r" (rcx_reg)
+	 : "cc", "memory"
+	);
+
+	return r10_reg;
+}
+
+enum accept_page_level {
+	PAGE_LEVEL_4K = 0,
+	PAGE_LEVEL_2M,
+};
+
+u64 tdx_accept_page(u64 gpa, enum accept_page_level level)
+{
+#define TDG_MEM_PAGE_ACCEPT 6
+	register u64 rax_reg asm("rax") = TDG_MEM_PAGE_ACCEPT;
+	register u64 rcx_reg asm("rcx") = gpa | level;
+
+	asm volatile(
+	 ".byte 0x66,0x0f,0x01,0xcc" /* tdcall */
+	 : "+r" (rax_reg)
+	 : "r" (rcx_reg)
+	 : "cc", "memory"
+	);
+
+	return rax_reg;
+}
+
+static void handle_hypercall_map_gpa(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	u64 attributes;
+	size_t size;
+	gpa_t gpa;
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_HYPERCALL);
+	TEST_ASSERT_EQ(run->hypercall.nr, KVM_HC_MAP_GPA_RANGE);
+	TEST_ASSERT_EQ(run->hypercall.flags, KVM_EXIT_HYPERCALL_LONG_MODE);
+
+	gpa = run->hypercall.args[0];
+	size = run->hypercall.args[1] * PAGE_SIZE;
+	attributes = 0;
+	if (run->hypercall.args[2] & KVM_MAP_GPA_RANGE_ENCRYPTED)
+		attributes = KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+	vm_mem_set_memory_attributes(vcpu->vm, gpa, size, attributes);
+}
+
+#define CONVERSIONS_PRIVATE_VAL 'A'
+#define CONVERSIONS_GUEST_SHARED_VAL 'B'
+#define CONVERSIONS_HOST_SHARED_VAL 'C'
+#define CONVERSIONS_STAGE_WROTE_SHARED 0x99
+
+static void guest_code_conversions(void)
+{
+	char *addr;
+
+	addr = (void *)conversions_private_gva;
+	WRITE_ONCE(*addr, CONVERSIONS_PRIVATE_VAL);
+	GUEST_ASSERT_EQ(READ_ONCE(*addr), CONVERSIONS_PRIVATE_VAL);
+
+	GUEST_ASSERT_EQ(tdx_map_gpa(conversions_shared_gpa, conversions_size), 0);
+
+	addr = (void *)conversions_shared_gva;
+	WRITE_ONCE(*addr, CONVERSIONS_GUEST_SHARED_VAL);
+	GUEST_ASSERT_EQ(READ_ONCE(*addr), CONVERSIONS_GUEST_SHARED_VAL);
+
+	GUEST_SYNC(CONVERSIONS_STAGE_WROTE_SHARED);
+
+	GUEST_ASSERT_EQ(READ_ONCE(*addr), CONVERSIONS_HOST_SHARED_VAL);
+
+	GUEST_ASSERT_EQ(tdx_map_gpa(conversions_private_gpa, conversions_size), 0);
+	GUEST_ASSERT_EQ(tdx_accept_page(conversions_private_gpa, PAGE_LEVEL_4K), 0);
+
+	addr = (void *)conversions_private_gva;
+	WRITE_ONCE(*addr, CONVERSIONS_PRIVATE_VAL);
+	GUEST_ASSERT_EQ(READ_ONCE(*addr), CONVERSIONS_PRIVATE_VAL);
+
+	GUEST_DONE();
+}
+
+TEST(verify_conversions)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	char *test_hva;
+
+	vm = __vm_create(VM_SHAPE_TDX, 1, 0);
+	vcpu = vm_vcpu_add(vm, 0, guest_code_conversions);
+
+	conversions_size = getpagesize();
+
+	conversions_private_gva = vm_alloc_page(vm);
+	conversions_shared_gva = vm_alloc_shared(vm, conversions_size,
+						 KVM_UTIL_MIN_VADDR,
+						 MEM_REGION_TEST_DATA);
+	conversions_private_gpa = addr_gva2gpa(vm, conversions_private_gva);
+	conversions_shared_gpa = conversions_private_gpa | BIT_ULL(vm->pa_bits - 1);
+
+	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
+
+	sync_global_to_guest(vm, conversions_size);
+	sync_global_to_guest(vm, conversions_private_gva);
+	sync_global_to_guest(vm, conversions_private_gpa);
+	sync_global_to_guest(vm, conversions_shared_gva);
+	sync_global_to_guest(vm, conversions_shared_gpa);
+
+	kvm_arch_vm_finalize_vcpus(vm);
+
+	test_hva = addr_gva2hva(vm, conversions_shared_gva);
+
+	vcpu_run(vcpu);
+	handle_hypercall_map_gpa(vcpu);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], CONVERSIONS_STAGE_WROTE_SHARED);
+
+	TEST_ASSERT_EQ(READ_ONCE(*test_hva), CONVERSIONS_GUEST_SHARED_VAL);
+
+	WRITE_ONCE(*test_hva, CONVERSIONS_HOST_SHARED_VAL);
+	TEST_ASSERT_EQ(READ_ONCE(*test_hva), CONVERSIONS_HOST_SHARED_VAL);
+
+	vcpu_run(vcpu);
+	handle_hypercall_map_gpa(vcpu);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char **argv)
 {
 	TEST_REQUIRE(is_tdx_supported());
--
2.54.0.1032.g2f8565e1d1-goog
