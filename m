Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45F32BF5D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186083; cv=none; b=NmnqZ1MagDLxyOwnzf1OH2Kce3/+bakBlcpS3MfEhJqfcbwYgmFWn10rZ7xlD+aYs1Z9xey2kIGxSnIUwoBFYb6vTyLlxSPPwmi9k6KBtJcW37Z91CV3jPq6tSx/ToEgC9EoWqPxUUHqZuSry9Tb/w6K/hcO628O0vAbtcJ0gMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186083; c=relaxed/simple;
	bh=jZG/0FBlpQu4GQm6uEGJ6DPNXY8HyxzLrxN+MqpPshU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+bMmYCLs5tdQoL9NWwJr0EsmqxVXLDuLyr4IQlrmj98fX3uw+93/9mWXrAM6NfL1G5Z1kLGir2tBTpOK1kkfMCX9yAeq3B/U8rYeNoyZ30i2tJv6z8HQMdf/gl5GfPiDNu1edWnLmblJK7jpzveFFmubyrAYjuUPlfInnJIhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RP/U1/aZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RP/U1/aZ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so1999863b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778186079; x=1778790879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvz8VPqH3W+uwpeYUY0LX4HhcQuQ485hz2JT5vwb8Uc=;
        b=RP/U1/aZgZqAZr3iZ5DelPqmQJzg00jPp/XwbUtf9828azrupB7L4mkd1WLN+SIlXP
         hg6LBv8155KzfgbngD9+bFcQ3xilo7Go4nHSQJg/a70wGQMFwRrqxs+JhKXonqUsMtx0
         sJYlHy8L9HclYbU6T58UPqcOHCaZkwNAJI8rqFyYaebhi+k6G7lghFlrip29hhhnbHm8
         BAliWv1mL2jihqvE8EU8CbTeFhdTcHCM3dLvre1LVGieFEWjonFj4JqGs5MUBTZ9Y7ZD
         BtgK1aK2Izj/A7xI4n6Y7DvNJA/jcgO4Pd8Kde5HhgCIhxsweUWzo+ZEvkNs4SnjuI9U
         QHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186079; x=1778790879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvz8VPqH3W+uwpeYUY0LX4HhcQuQ485hz2JT5vwb8Uc=;
        b=ARcKUwy0+R20tlCUEivUzb2JaLfwFtG7UMt6m/lGa2Eg1J3gY0ZOCkateFwLdPkuMY
         FHluwJpm7eEXTNDDphn4iTiwSUOekMZawm0q2HOyrBhL17Ct2CsVDcF5+slJcghMrp7r
         NzYUArM99wK1u0aKywtSKsPrn2y7Eqzi4PZKmTfjJHX7A7ccx2hESY/3g6QwxCiVC1Lb
         zUB0TE9/fKT07a21onqRlTvx+P1FcbQtLBrjhj72P/fN9eb5IqdRYdWveZozEEZKUfKU
         u0SvzAiV7Mw50CnWYeJnYw6pWrh+01EtFzD7PmIT/atu1mMilIVn9+2+vfhK0TZseOnD
         7dpA==
X-Forwarded-Encrypted: i=1; AFNElJ+p2D8U8HxkFferJxzHFrH5NuRiJHefnQW7en7SdarTD/Lv95otsYasDYvbMgBZynH2+GBRC+fjHWbKze2DS2zejT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEO3gXxdZbPl1vZ8OXuRDRiGEew97xOtWxxwHsZdJFFdNHGF3A
	I6VmQIAPqD/9duP4FXTbXMpL+KF9Fqi9z1Zz2CvovAXui6y2KwqOxvhxLNf3KE7uD/ARaSomDel
	lJp9RdI6ldepEfbxM/BCX97dEbA==
X-Received: from pgam24.prod.google.com ([2002:a05:6a02:2b58:b0:c74:42:8984])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a08:b0:3a0:9052:c005 with SMTP id adf61e73a8af0-3aa8be1f13cmr3709197637.3.1778186078908;
 Thu, 07 May 2026 13:34:38 -0700 (PDT)
Date: Thu,  7 May 2026 13:34:26 -0700
In-Reply-To: <cover.1778185936.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <cover.1778185936.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <1edc2c94bf776c8ceee3b92208e6280ef5a50a23.1778185936.git.ackerleytng@google.com>
Subject: [POC PATCH 5/5] KVM: selftests: Test conversions for SNP
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

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 198 +++++++++++++++++-
 1 file changed, 193 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 8b859adf4cf6f..8869cca748879 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -253,17 +253,205 @@ static void test_sev_smoke(void *guest, u32 type, u64 policy)
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
+#define CONVERSION_TEST_VALUE_SHARED_4 0xde
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
+	GUEST_ASSERT_EQ(READ_ONCE(*test_shared_gva), CONVERSION_TEST_VALUE_SHARED_3);
+	WRITE_ONCE(*test_shared_gva, CONVERSION_TEST_VALUE_SHARED_4);
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
+	vm_mem_set_private(vm, test_gpa, PAGE_SIZE);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_HYPERCALL);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.nr, KVM_HC_MAP_GPA_RANGE);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[0], test_gpa);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[1], 1);
+	TEST_ASSERT_EQ(vcpu->run->hypercall.args[2], KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K);
+
+	vm_mem_set_shared(vm, test_gpa, PAGE_SIZE);
+
+	fprintf(stderr, "test_hva contents = %x\n", READ_ONCE(*(u8 *)test_hva));
+
+	WRITE_ONCE(*(u8 *)test_hva, CONVERSION_TEST_VALUE_SHARED_3);
+	TEST_ASSERT_EQ(*(u8 *)test_hva, CONVERSION_TEST_VALUE_SHARED_3);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
+	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
+
+	TEST_ASSERT_EQ(*(u8 *)test_hva, CONVERSION_TEST_VALUE_SHARED_4);
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
-	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+	// test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+
+	// if (kvm_cpu_has(X86_FEATURE_SEV_ES))
+	// 	test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
 
-	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
-		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
+		test_conversion(snp_default_policy());
 
-	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
-		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+		// test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+	}
 
 	return 0;
 }
-- 
2.54.0.563.g4f69b47b94-goog

