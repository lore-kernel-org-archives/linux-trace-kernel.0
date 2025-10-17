Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD73446BE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732019; cv=none; b=CLQwCx1HC22kTllPB9HqkvVS2Q6O7iH8LlF+sD19M+IyTRWPb01/6ioJP0rBywQftP2MhHKGFWc9NNRkpn0aksZFRy97FxzNwl7EoZKMxATswRgrOaE5QcYE6M6YKRkbC2EfBwXrSw0k2ZN4P3oxXnprqQJhV0BwXEnq+8DtljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732019; c=relaxed/simple;
	bh=qhndFbd/Csb/pEoEo8xEbgb9ANe1Rhwu0LFv+C2pbWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JMZTZ1x+6G+kj6GuLqbXb+0OQtdisUy9nRq7yNejSHtmNxNjEP2LLH2naHiKTtiE15eKJ7rtB9tffZjK9B3vYC5vsa1YgJMEPJB591d/d9bBkMefkuM9Qx+ZV2lm5oYDMaus5SaiMDSodpXQ+XGrUShlWaek/UWIMjFd3RmuBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKFJ/hTo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKFJ/hTo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eca7298d9so50022015ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732006; x=1761336806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpoVPQkxx65srwzLoEmvKd0scDAwEAjWt5gz2bwW38k=;
        b=HKFJ/hTo6F+wWNxAuovtVScjHMQJ/E70K6XsjdbJ0E7jWOt07UjZ/UTnfWdABcwCPr
         mkZpaXo2l7TuLydjAfaC+FPFAUdyifQB0y2ODo0GtM5yywN72+0lwuR9brhOcYYxrd05
         evoT2WQ/Avu240KGOMJCXGRPr+BJ7LL1QmVa622+mPgNV0u/nTJd1vlXIQ3qT1hWZogh
         zJsZHqM2N8XlqalL1JNQKXDroVeU6b5IeK376ofWT0gDyhU4tmCrDRO3cykconRKgv+y
         28aStQdINN1UK3r8LbvUEICmwGmQKJ9xHt+wBgwPxtbJbWbPEREJC94xHOAioCpxkWUq
         JQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732006; x=1761336806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpoVPQkxx65srwzLoEmvKd0scDAwEAjWt5gz2bwW38k=;
        b=JDxDvUNrJxtkgyf+RNamtQTCiHSK6W0aRS+BtKAn9KWsB3+7ttUMiwCire9s4cS4sy
         keaFGHCpyD+zay5ol8TKjnOJIz+KRTernFcMkMLhPqb+Yzzcgf9r+QsdaYavfi6R/b4K
         giePrJkaNWutLpWubnSE0YaqHlg9yHmXFxADi9CTH5LbwC+rs9J6YQbop/EqSjATHyPT
         xrLEGqLOw26o885mL97OL4zAdqy2UtmMdKMWF3HO3UK4NQK2o8DojT6mcRM7Vt8MhgHJ
         GTpt89eWIRvpoGr3veWJBxWvwR1VJWlYplKOpYE4XWe3M/8tbUhma5yFOAzw5CK8/D//
         8q4w==
X-Forwarded-Encrypted: i=1; AJvYcCVDpS47tPYm2phhoplTQQ4sfaArEVPFZN7nnxJwI+VW3kP84FxoGiDm5ky3ljX4ZWsiyX35yN+orT7Sjn9LbSJwCfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTppBf8BAlT0zArJXl8YUEfkP9loXTWlhbLnhQ29NAPPN3EqS
	6G4DEc5+MUDefxdubWVs0t24GW5y/mdl03mnZCpvnGJxy4xfcuyza4nUPbjUZK67xcf7v2zR9sh
	/vU49iNiT2qjnKJOr79UX8wGR9A==
X-Google-Smtp-Source: AGHT+IHMvWCbFk7zNWAcA3iBXitO6Giz/tz8VDGZaOcvvFaw8VizJhdk71JqmoT94RqN4E0zZSOTnwVxAhEK+wEYkA==
X-Received: from pldr21.prod.google.com ([2002:a17:903:4115:b0:290:a6e2:2006])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e543:b0:269:4741:6d33 with SMTP id d9443c01a7336-290c9d3740dmr58504095ad.23.1760732005539;
 Fri, 17 Oct 2025 13:13:25 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:15 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <4a1ad1015657e90db1e81c1b51dc07f62afe29ea.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 34/37] KVM: selftests: Update private_mem_conversions_test
 to mmap() guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Update the private memory conversions selftest to also test conversions
that are done "in-place" via per-guest_memfd memory attributes. In-place
conversions require the host to be able to mmap() the guest_memfd so that
the host and guest can share the same backing physical memory.

This includes several updates, that are conditioned on the system
supporting per-guest_memfd attributes (kvm_has_gmem_attributes):

1. Set up guest_memfd requesting MMAP and INIT_SHARED.

2. With in-place conversions, the host's mapping points directly to the
   guest's memory. When the guest converts a region to private, host access
   to that region is blocked. Update the test to expect a SIGBUS when
   attempting to access the host virtual address (HVA) of private memory.

3. Use vm_mem_set_memory_attributes(), which chooses how to set memory
   attributes based on whether kvm_has_gmem_attributes.

Restrict the test to using VM_MEM_SRC_SHMEM because guest_memfd's required
mmap() flags and page sizes happens to align with those of
VM_MEM_SRC_SHMEM. As long as VM_MEM_SRC_SHMEM is used for src_type,
vm_mem_add() works as intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/private_mem_conversions_test.c    | 44 ++++++++++++++++---
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 814187d06fcca..6730923af830c 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -309,8 +309,8 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
 	if (set_attributes)
-		vm_set_memory_attributes(vm, gpa, size,
-					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+		vm_mem_set_memory_attributes(vm, gpa, size,
+					     map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
 	run->hypercall.ret = 0;
 }
 
@@ -354,8 +354,20 @@ static void *__test_mem_conversions(void *__vcpu)
 				size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
 				uint8_t *hva = addr_gpa2hva(vm, gpa + i);
 
-				/* In all cases, the host should observe the shared data. */
-				memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				/*
+				 * When using per-guest_memfd memory attributes,
+				 * i.e. in-place conversion, host accesses will
+				 * point at guest memory and should SIGBUS when
+				 * guest memory is private.  When using per-VM
+				 * attributes, i.e. separate backing for shared
+				 * vs. private, the host should always observe
+				 * the shared data.
+				 */
+				if (kvm_has_gmem_attributes &&
+				    uc.args[0] == SYNC_PRIVATE)
+					TEST_EXPECT_SIGBUS(READ_ONCE(*hva));
+				else
+					memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
 
 				/* For shared, write the new pattern to guest memory. */
 				if (uc.args[0] == SYNC_SHARED)
@@ -384,6 +396,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	const size_t slot_size = memfd_size / nr_memslots;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
+	uint64_t gmem_flags;
 	struct kvm_vm *vm;
 	int memfd, i;
 
@@ -399,12 +412,17 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
-	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+	if (kvm_has_gmem_attributes)
+		gmem_flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+	else
+		gmem_flags = 0;
+
+	memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
 
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
 			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, 0);
+			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, gmem_flags);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		uint64_t gpa =  BASE_DATA_GPA + i * per_cpu_size;
@@ -454,17 +472,29 @@ static void usage(const char *cmd)
 
 int main(int argc, char *argv[])
 {
-	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
+	enum vm_mem_backing_src_type src_type;
 	uint32_t nr_memslots = 1;
 	uint32_t nr_vcpus = 1;
 	int opt;
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
 
+	src_type = kvm_has_gmem_attributes ? VM_MEM_SRC_SHMEM :
+					     DEFAULT_VM_MEM_SRC;
+
 	while ((opt = getopt(argc, argv, "hm:s:n:")) != -1) {
 		switch (opt) {
 		case 's':
 			src_type = parse_backing_src_type(optarg);
+			if (kvm_has_gmem_attributes && src_type != VM_MEM_SRC_SHMEM) {
+				printf("Overriding mem_type to %s to test in-place conversions\n",
+				       vm_mem_backing_src_alias(VM_MEM_SRC_SHMEM)->name);
+				/*
+				 * Use VM_MEM_SRC_SHMEM, whose size and mmap flags
+				 * align with those of guest_memfd.
+				 */
+				src_type = VM_MEM_SRC_SHMEM;
+			}
 			break;
 		case 'n':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);
-- 
2.51.0.858.gf9c4a03a3a-goog

