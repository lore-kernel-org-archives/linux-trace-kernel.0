Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAD381AF7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382432; cv=none; b=nrB6+wVYhj/Jw6e2Pxnn8t4CRB8IpV2HS0sYtbMSpzAy1WHT9TUS9I843HqplFvSVWC2Oxu0VHNMIg5xeQQzpT82I0BTbNBPpqwfBhQcgU3qGEir0LjXb8Fq9spDEdWuipYfsJo/fKlEIblljrkck/KIC0lWkO+lLdoWj4uQOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382432; c=relaxed/simple;
	bh=7baj+z7g9OZlOTGExGlQINWyEefRps7Kn+Swb89S7aE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lt+HNDVCXc12Vh8v7JvfD+YZlRzp8LkP6zxrGIlY7cBZ9cCQbZJu5f2QL5Y1RyoHd1xCBBS+pbWKIPWgn1gxT+ZY00c/pU01GOJPljenCw6V5ccdh+69j9PBPe6lbCJLiJaXrPnzTnqNbx5Z+3EGy4mo1VbjNT36yMyNMGUIyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rhj5lbVc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rhj5lbVc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so2075422a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382425; x=1773987225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBannU+WuhOvmz78TN99QSN8sfUoje21sNZst91foHc=;
        b=Rhj5lbVc1Lt9C1g3p+npgzQam1RLpvScCumbA2EaZw6Mtlo627Ywg7UV9J+TZKr7VN
         PvDM2luLmsM/1qN5h22zbc1Pl3lEzDCt6IunI5nSAwFNx0IEQYbp81sVgDQytfNTizMz
         j0TEaOuonwKzK0eDF9d5TpR8+jZjgFKjg8XppiPGmR3eehrDm9VpNuStZrcTO5HPTxhE
         IdHmNNE/mXSPg+nfEwm5p+lKqbvHbmvEQGHb7AdMF2/ErDElJIEq31XiAcH+QPwq+I/M
         CG3f1rvxbTTJ7PnKD3HCAH0yqL1OOJssS4l8f44dMTCW1hBEftzhPBGs771L/IfMGigG
         4rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382425; x=1773987225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBannU+WuhOvmz78TN99QSN8sfUoje21sNZst91foHc=;
        b=Yg41GouLOPWibahob4MVSyhdmgpNGKajZiDjo8yepRpyhfVkoT2JyGH5DZvsnwXjpW
         it/IYdjtd6FlWT2riesScVQCX+McPG+DP5iQTm1Xjk0qdFmxVf8P11FMKfIC75PkJtGO
         g6+22Rf+zzACrqy2tjE6HMpiAVpxld/JaLab3zQp2pKWm34RtWVhcudzec/nMtwXmb1X
         NcVUXC+6AuS+MCjqnz8oIZRctaiVL9hVcJpIkzaV1zGnJJcb/YTtal9CPNScbiB/8CEh
         rGooBcyHXhtu8fIR8VtpDm6lwj+3BoFzpogP399+h8/15QVqpMwTkE0aB1WycC0NK11H
         eH0g==
X-Forwarded-Encrypted: i=1; AJvYcCU5yVMLSMjPA6LF+5TDgDXYRn8BoM2QyN8EBQmroPfDgbLXKYpFUQSgPAq7gVrNr1MNGCWhxGkUGH/5CUhvx+Mvsec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+ntW7QSQnY7OKSWZmSor1e9HndvmZr7uHkWY6JEWAo2ULV/F
	qL9zr9DIBK2/gF38hSkkzT4ikr28ZxxfQrZYulNbHOI4tbvnPwHKKxkV5WdTArayp6OCGoivmPv
	/+nbQM4p757m5T2l+Ov6trQS0cA==
X-Received: from pjqo17.prod.google.com ([2002:a17:90a:ac11:b0:359:7b20:386f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b10:b0:359:8e59:16e6 with SMTP id 98e67ed59e1d1-35a22081199mr1710882a91.32.1773382424391;
 Thu, 12 Mar 2026 23:13:44 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:13 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=5167;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=7baj+z7g9OZlOTGExGlQINWyEefRps7Kn+Swb89S7aE=; b=kUhQoynFqKPsxAdmBjO/vTP0Gy6ZShpRNugkxoBtOFLE1mPImtF/bHOWuqO1aYQPPZODQc50C
 PvHBPWns7CyC8kOFG4C+hxn98epDAdLduKVxvmwDeFCoP3cZLygTbCL
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-34-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 34/43] KVM: selftests: Update private_mem_conversions_test
 to mmap() guest_memfd
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
 .../kvm/x86/private_mem_conversions_test.c         | 39 ++++++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 47f1eb9212591..f85717662a73b 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -307,8 +307,8 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
 	if (set_attributes)
-		vm_set_memory_attributes(vm, gpa, size,
-					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+		vm_mem_set_memory_attributes(vm, gpa, size,
+					     map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
 	run->hypercall.ret = 0;
 }
 
@@ -352,8 +352,20 @@ static void *__test_mem_conversions(void *__vcpu)
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
@@ -382,6 +394,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	const size_t slot_size = memfd_size / nr_memslots;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
+	uint64_t gmem_flags;
 	struct kvm_vm *vm;
 	int memfd, i;
 
@@ -397,12 +410,17 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 
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
@@ -452,17 +470,24 @@ static void usage(const char *cmd)
 
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
+			TEST_ASSERT(!kvm_has_gmem_attributes ||
+				    src_type == VM_MEM_SRC_SHMEM,
+				    "Testing in-place conversions, only %s mem_type supported\n",
+				    vm_mem_backing_src_alias(VM_MEM_SRC_SHMEM)->name);
 			break;
 		case 'n':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);

-- 
2.53.0.851.ga537e3e6e9-goog

