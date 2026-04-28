Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A63CCFD1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419217; cv=none; b=jCU370IwA/04JMaC0y8EO81384cfwSCNIai5R3at7J8hPbv6NFkZjUiJSh7Wo+ePnfBtNJbrEBX7vmzuQGKmHx8Gpol3yk+u2nI2jzyM0OCEPBPjC4vxI0zwAk0EytoYboyn4M6cnnhBlIG9ma37T8RjHP+U3i8lZCjWhcYvDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419217; c=relaxed/simple;
	bh=7UHYRpw7yO05KvlcB/cjpEvd2t/jycN0nMqBTEpDnEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zi8JwxjTvlXi74kEZ9CY0BP3llJe4U3I2hYg4I0ANnYcpdVCQpJ9ZZPuX5tbReJZ1VTTgyTah9AaJOOLEfPsmk08T+zfys9KrQ3W5Y4r3lqKZ9T9/OX8DFoeDyAbx3K813AzpC8OK2rmZ54eE9x+grKI8xndjUC7CO7TvL2Lv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GveJKM51; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GveJKM51"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so12247993a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419215; x=1778024015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0syyhb9YeGFgBqpqjZEPjnNFKpLHyAFVq8K7QF7sEE=;
        b=GveJKM51mywkYxww3r210uU5EOTnYmVkT+Hml7923h2VWL4K07oSGl7fzfzpxbQMKE
         X6aDNiFxypjuF6bMeUjgFmBnM3tNKLFhm0aVveI4A3ANH0Yp4tQiQOsZ1akQN3BiaJ3W
         cqUGNeexAq9W4R/fBYZGp5Uf/kGGwWLKIHnK/mcBQV6J3VZ9dQ26h38InX9lCCq1YcPv
         qi4T8+MZPnjxAe4HbBwT81sgXFpf+iDmD5lcjM0MpFf13IjrLIJ1bjaYno8Sof95mPPW
         dU8QfDCEqwCykWpllq0aQITljqZ7z3FCLkFfziX6J9U5zw/Yn+LIIZONyCIX+EjIObW3
         mSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419215; x=1778024015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0syyhb9YeGFgBqpqjZEPjnNFKpLHyAFVq8K7QF7sEE=;
        b=GCTyGx7ow77cjnjSkGsd/VHvjAgQbAcxHifgaYd2kQMYUf14EHHXkdWg6v7DB6tnlt
         8EeZUxn5TQ15B7Di04IowXIei+ZZ8zOUMKD8V1iKt/Ec7vLCI57Lwr8AV5xQ8+gpEgoh
         SEL8uaUhhCPKzcA8VQPp50IU+m2iRYHfelkK6hs1KG6QQ1QiWaugodHxYqcsIm6XoeqW
         ovKvsdlvpq+ns6A6Ks9GX421BQaq3EYHZLFYCYHA3AOdUicEoDGpvgC5JP5G0ZaKMv/2
         1xvINlFh4m51pNbuu50FvjAlqdyK7OyKVsR1zwNVYFJKvVI/aWOgZbmFCdBYcYn3ONxj
         jrUw==
X-Forwarded-Encrypted: i=1; AFNElJ8hEWH5inJx4bE3OhI3icotCzR4bGssHgJSUFafJHJLWGN6WKM76GUsEt/0td3+oC2ve/NXdBrVHE/uSPfoRLOCJ90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDK+NVcLnxcEkFfhtwpNRPqReVXas3ZVRecRQRZsac2um9vFjr
	coVMx8IG9c39C6l97WtUZy0YoLOttQ/UzdqWP9NPRwaj2+oZ55wO4Y9qoJ56ALNk5SxXBKtUN4M
	00XrK4Gt1O/T9aO709lOUPabW8w==
X-Received: from plxd18.prod.google.com ([2002:a17:902:ef12:b0:2ae:c8e0:1f12])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:189:b0:2b7:8a56:7cda with SMTP id d9443c01a7336-2b97c3cb634mr50128145ad.4.1777419214303;
 Tue, 28 Apr 2026 16:33:34 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:25 -0700
In-Reply-To: <cover.1777418884.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <cover.1777418884.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <d7a6c561a22a77f9e1dc4f9f8957b23089f8112b.1777418884.git.ackerleytng@google.com>
Subject: [POC PATCH 5/6] KVM: selftests: Test conversions for SNP
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
 .../selftests/kvm/x86/sev_smoke_test.c        | 190 +++++++++++++++++-
 1 file changed, 185 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 8b859adf4cf6f..86f17e59e9392 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -253,17 +253,197 @@ static void test_sev_smoke(void *guest, u32 type, u64 policy)
 	}
 }
 
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_REQ_VAL(v)                \
+	/* GHCBData[63:12] */                      \
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) | \
+	 /* GHCBData[11:0] */			   \
+	 GHCB_MSR_REG_GPA_REQ)
+
+#define GHCB_MSR_REG_GPA_RESP		0x013
+#define GHCB_MSR_REG_GPA_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
+#define GHCB_DATA_LOW			12
+#define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
+#define GHCB_RESP_CODE(v) ((v) & GHCB_MSR_INFO_MASK)
+
+/*
+ * SNP Page State Change Operation
+ *
+ * GHCBData[55:52] - Page operation:
+ *   0x0001	Page assignment, Private
+ *   0x0002	Page assignment, Shared
+ */
+enum psc_op {
+	SNP_PAGE_STATE_PRIVATE = 1,
+	SNP_PAGE_STATE_SHARED,
+};
+
+#define GHCB_MSR_PSC_REQ		0x014
+#define GHCB_MSR_PSC_REQ_GFN(gfn, op)			\
+	/* GHCBData[55:52] */				\
+	(((u64)((op) & 0xf) << 52) |			\
+	/* GHCBData[51:12] */				\
+	((u64)((gfn) & GENMASK_ULL(39, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_PSC_REQ)
+
+#define GHCB_MSR_PSC_RESP		0x015
+#define GHCB_MSR_PSC_RESP_VAL(val)			\
+	/* GHCBData[63:32] */				\
+	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
+
+static u64 ghcb_gpa;
+static void snp_register_ghcb(void)
+{
+	u64 ghcb_pfn = ghcb_gpa >> PAGE_SHIFT;
+	u64 val;
+
+	GUEST_ASSERT(ghcb_gpa);
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_REG_GPA_REQ_VAL(ghcb_gpa >> PAGE_SHIFT));
+	vmgexit();
+
+	val = rdmsr(MSR_AMD64_SEV_ES_GHCB);
+	GUEST_ASSERT_EQ(GHCB_RESP_CODE(val), GHCB_MSR_REG_GPA_RESP);
+	GUEST_ASSERT_EQ(GHCB_MSR_REG_GPA_RESP_VAL(val), ghcb_pfn);
+}
+
+static void snp_page_state_change(u64 gpa, enum psc_op op)
+{
+	u64 val;
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_PSC_REQ_GFN(gpa >> PAGE_SHIFT, op));
+	vmgexit();
+
+	val = rdmsr(MSR_AMD64_SEV_ES_GHCB);
+	GUEST_ASSERT_EQ(GHCB_RESP_CODE(val), GHCB_MSR_PSC_RESP);
+	GUEST_ASSERT_EQ(GHCB_MSR_PSC_RESP_VAL(val), 0);
+}
+
+#define RMP_PG_SIZE_4K			0
+static inline void pvalidate(void *vaddr, bool validate)
+{
+	bool no_rmpupdate;
+	int rc;
+
+	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
+	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
+		     : "=@ccc"(no_rmpupdate), "=a"(rc)
+		     : "a"(vaddr), "c"(RMP_PG_SIZE_4K), "d"(validate)
+		     : "memory", "cc");
+
+	GUEST_ASSERT(!no_rmpupdate);
+	GUEST_ASSERT_EQ(rc, 0);
+}
+
+#define CONVERSION_TEST_VALUE_SHARED_1 0xab
+#define CONVERSION_TEST_VALUE_SHARED_2 0xcd
+#define CONVERSION_TEST_VALUE_PRIVATE 0xef
+#define CONVERSION_TEST_VALUE_SHARED_3 0xbc
+static void guest_code_conversion(u8 *test_shared_gva, u8 *test_private_gva, u64 test_gpa)
+{
+	snp_register_ghcb();
+
+	GUEST_ASSERT_EQ(READ_ONCE(*test_shared_gva), CONVERSION_TEST_VALUE_SHARED_1);
+	WRITE_ONCE(*test_shared_gva, CONVERSION_TEST_VALUE_SHARED_2);
+
+	snp_page_state_change(test_gpa, SNP_PAGE_STATE_PRIVATE);
+	pvalidate(test_private_gva, true);
+
+	WRITE_ONCE(*test_private_gva, CONVERSION_TEST_VALUE_PRIVATE);
+	GUEST_ASSERT_EQ(READ_ONCE(*test_private_gva), CONVERSION_TEST_VALUE_PRIVATE);
+
+	pvalidate(test_private_gva, false);
+	snp_page_state_change(test_gpa, SNP_PAGE_STATE_SHARED);
+
+	WRITE_ONCE(*test_shared_gva, CONVERSION_TEST_VALUE_SHARED_3);
+
+	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
+	vmgexit();
+}
+
+static void test_conversion(u64 policy)
+{
+	gva_t test_private_gva;
+	gva_t test_shared_gva;
+	struct kvm_vcpu *vcpu;
+	gva_t ghcb_gva;
+	gpa_t test_gpa;
+	struct kvm_vm *vm;
+	void *ghcb_hva;
+	void *test_hva;
+
+	vm = vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_code_conversion, &vcpu);
+
+	ghcb_gva = vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+				   MEM_REGION_TEST_DATA);
+	ghcb_hva = addr_gva2hva(vm, ghcb_gva);
+	ghcb_gpa = addr_gva2gpa(vm, ghcb_gva);
+	sync_global_to_guest(vm, ghcb_gpa);
+
+	test_shared_gva = vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
+					  MEM_REGION_TEST_DATA);
+	test_hva = addr_gva2hva(vm, test_shared_gva);
+	test_gpa = addr_gva2gpa(vm, test_shared_gva);
+
+	test_private_gva = vm_unused_gva_gap(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR);
+	___virt_pg_map(vm, &vm->mmu, test_private_gva, test_gpa, PG_SIZE_4K, true);
+
+	vcpu_args_set(vcpu, 3, test_shared_gva, test_private_gva, test_gpa);
+
+	vm_sev_launch(vm, policy, NULL);
+
+	WRITE_ONCE(*(u8 *)test_hva, CONVERSION_TEST_VALUE_SHARED_1);
+
+	fprintf(stderr, "ghcb_hva=%p ghcb_gpa=%lx ghcb_gva=%lx\n", ghcb_hva, ghcb_gpa, ghcb_gva);
+	fprintf(stderr, "test_hva=%p test_gpa=%lx test_private_gva=%lx test_shared_gva=%lx\n", test_hva, test_gpa, test_private_gva, test_shared_gva);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_HYPERCALL);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.nr, KVM_HC_MAP_GPA_RANGE);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[0], test_gpa);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[1], 1);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[2], KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
+
+	vm_mem_set_private(vm, test_gpa, PAGE_SIZE, KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_HYPERCALL);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.nr, KVM_HC_MAP_GPA_RANGE);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[0], test_gpa);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[1], 1);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[2], KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
+
+	vm_mem_set_shared(vm, test_gpa, PAGE_SIZE, KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
+	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
+
+	TEST_ASSERT_EQ(*(u8 *)test_hva, CONVERSION_TEST_VALUE_SHARED_3);
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
-	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+	// test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
 
-	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
-		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+	// if (kvm_cpu_has(X86_FEATURE_SEV_ES))
+	// 	test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
-	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
-		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
+		test_conversion(snp_default_policy());
+		// test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+	}
 
 	return 0;
 }
-- 
2.54.0.545.g6539524ca2-goog

