Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E43E1CED
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563951; cv=none; b=bHRAkyoP0By+vAj3LOss+bVhiMJ85jMYsKEUGvzl86qJYI5vAbzueQgZ0Lduwq+Uge4t30jtQU3x1GLbEJX/MTkIzuxOqmrJ08Rc5piANhWT3qyE1VNgIVgCtSsyNDZlUgSapuUyZFiScxGVx+luazor3LBd3uUv78uBCun0bWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563951; c=relaxed/simple;
	bh=atM67lZrb3L/4FSuzE/lIWzYT7CU6pwH5U1B0OOVyHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UPTYoHlLMZJNaKNwONl9n77Eiy4k+CnT2HlIbYCaIm/2STZRWjogaEFmk69Fujocch0q9y/7wIsrP55hVltZY8OeQ3dCIMEmUrqH+X9RDtnwvNP/COjhxRsRiFpp3TVwUZruPgpdbdWNg5ZT9cxUmcxtqH+QNRiwpZT8eMewwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyvdk4GD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyvdk4GD"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741f038f7cso1005841a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563949; x=1775168749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YsFx8S2ZIsHTA7mxdUPwMmhoKs9OpIzRTtvg/d03faw=;
        b=vyvdk4GDEpoTi5tqF13UIRCC6EVzVP5ZrEGvShOwfUs1WNUCmwC0LRtzqDu5sDCYWQ
         JxfgbpfyRWJz4xlye5x+zSNYxOGQYUx2i0CDMpgVqSBxQjfULyPFwCcfNW8dlTJa80CR
         JbMRI62iov3MW6Q+1a9BUbIiBv7p4XUP9ngoADhXBh784bpv81Ei8LQOIETDXexz2qC7
         rU02g3qIDRlo/wEkldx1MPWCz0Cm/CaN8sszYIATdzV7wCRWz/tt2hTABeAvhsLyTgRk
         QJkVh9L5OfN+AxzYPKXstArdCy9g+ZIybpHbp4dv2XFyj/DJfQfrxAK2wIcZ608D+fP7
         hBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563949; x=1775168749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsFx8S2ZIsHTA7mxdUPwMmhoKs9OpIzRTtvg/d03faw=;
        b=bMBbVksyziCKDJpYTxsIFoZg6rZZMeRp8sFxz8CFSfXZfSqUE4gOjL7Egss/aOFJMh
         SxDwt13SUjOe281ES6H4rUkjh0/5We55SutWzL7KZeCzc6ddSoDFSyFpag5yc0QJz/rb
         23jYFWU4XPeKWwZQpTPvYkNMbDRAF6bYUQGo4D3u6oFeIrpBc0tqjFA+3vOqTdB6EGtH
         MibvUhjj2Ku042VG5YJdcdXpvYUHVX5s6UfqzT+ZsNpioS4UUeE4DskEExUxL9A3sVdQ
         TXZJWqGmLjkwqlSobZ2mXNbU17uGw/Fi+a0kj7FGZRLd2V5cBR3i8vAeEzQSzIHvvkoS
         DWTg==
X-Forwarded-Encrypted: i=1; AJvYcCUCehl9frP47beOLz3SS1dYmB7Fp6AqNWpbbgIpYrkQGPETw5yAH9VOKRrWHOLAaX83YokJn35TVTTM0jahIAqcoLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04YYO4wD3XYo40yqu6SEL7bZLTRt3gisLHqD5bp5G8S2c6Lmz
	NbcIl9eBTV/YxZYfRP0ZmGsyRqzAvP+s2tMU3aoEq7yusk/uVp3Q64RIOaLS4up0cc9OCo8UfX7
	xCBKRc6RGtZi47DBPTZ1UT6XQJQ==
X-Received: from pfwy16.prod.google.com ([2002:a05:6a00:1c90:b0:82c:6e7c:ac6d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b488:b0:82a:60ad:874 with SMTP id d2e1a72fcca58-82c95e9ec0amr174041b3a.19.1774563948768;
 Thu, 26 Mar 2026 15:25:48 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:50 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=5336;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=atM67lZrb3L/4FSuzE/lIWzYT7CU6pwH5U1B0OOVyHY=; b=5MuqTkb5deqhYAPqYmfVeS6JWQaZBgzlViovjh0d6q6SQRu7C3TxjQOxMfoLP3N43SByS4Jw5
 ZnxOUmxggc7B4jsUWt0qDmE7eGPO++o93Lfuw6k6XZIImuFyIUiBC0X
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-41-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 41/44] KVM: selftests: Update private_mem_conversions_test
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
 .../kvm/x86/private_mem_conversions_test.c         | 46 ++++++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 47f1eb9212591..29c3c5b2f538e 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -306,9 +306,14 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	if (do_fallocate)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
-	if (set_attributes)
-		vm_set_memory_attributes(vm, gpa, size,
-					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	if (set_attributes) {
+		u64 attrs = map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+		u64 flags = kvm_has_gmem_attributes ?
+			    KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE : 0;
+
+		vm_mem_set_memory_attributes(vm, gpa, size, attrs, flags);
+	}
+
 	run->hypercall.ret = 0;
 }
 
@@ -352,8 +357,20 @@ static void *__test_mem_conversions(void *__vcpu)
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
@@ -382,6 +399,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	const size_t slot_size = memfd_size / nr_memslots;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
+	uint64_t gmem_flags;
 	struct kvm_vm *vm;
 	int memfd, i;
 
@@ -397,12 +415,17 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 
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
@@ -452,17 +475,24 @@ static void usage(const char *cmd)
 
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
2.53.0.1018.g2bb0e51243-goog

