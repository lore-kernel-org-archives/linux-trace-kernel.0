Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C493D75C2;
	Thu, 10 Sep 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084541; cv=none; b=VjwymUsGrD82vpXsA6fmvNgiR3x1fYjBldkZkgVuNqU2tkoR5V7TPBVa+nHdUOKiM63hAjMCA3DlFC1HY6WBZRTMop1xmSkfFecfvk0usYujuJqtCN8r4w7ZoganirsNKBYdhj5+Du5ZviAEiyaPDGxu8vOYdNhrlK/J6b1enFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084541; c=relaxed/simple;
	bh=Usdkixf5ZXbmJXWcgS8yG+6vF/nHWR20SmPH+Hst/D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSP5n5M33luzgmuzR3kt9KueKn+4kwLYQyFhbsiK/TVn2bGlgGV2cW0knqaT2fwLPeYBhS5g5ZVQe8S7I45KYXb+FxGYF/6Tc/JjzjRJb0LBVtqZD0+m9JKSki+XfgPYYMyVgoXCVEB6VDEytHd2EIkL9uobPW6ko18AQ3UxTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwhB2EEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwhB2EEc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03787C2BD05;
	Thu, 10 Sep 2026 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789084541;
	bh=Usdkixf5ZXbmJXWcgS8yG+6vF/nHWR20SmPH+Hst/D8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BwhB2EEc10Iorm/WNZPAZR0I4ZHX1EBfsClUoUaYMcotfH7ovlxlKxrP0lPxG5pzO
	 ZRiflM2W15HksMVSlEvaY5IwZb19NiQylbZ8ocylDh22atQk0ZTvO3jz2InCWPVdiv
	 N10a0o6TcpBfB3EwJsGu++HFj3bq1Flcx0C2ASvQeBQv89E+g7SGmrRI4C7+vYQwcV
	 KGbLywxDz/u7UB/U0JMWHV9z9FBb9bOEvbjJmWzNmSyzeN8V8k1cATPR0Cyi7ALMRI
	 A3pGfCHZxesneid89EcX1WzqnIw6/GdfFnJwrG5SKJdSAB4oNhSMgRjXFD9uUgpWXd
	 bVGuC4MvkpsQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E135FC88E4D;
	Thu, 10 Sep 2026 23:55:40 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 10 Sep 2026 16:56:09 -0700
Subject: [PATCH v13 43/44] KVM: selftests: Update
 private_mem_conversions_test for in-place conversions
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-gmem-inplace-conversion-v13-43-dd6fbf94f4e1@google.com>
References: <20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com>
In-Reply-To: <20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
 Fuad Tabba <fuad.tabba@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789084533; l=5729;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=NIpyFLdhCTVD97IHzJc7q0klAWZs6At1EhrFH3ni46M=;
 b=VdkuzOao3BXPsEz6g+Bl53pxZxRFm5vINe9XiaPBHRvNB/A8PTD8M79905aFZgzQOxpka8JkH
 Z4N/YRlKClmBCr44GLftPdOdKhXGHHxvJilv3JeShqHo47T7ay9+H3Z
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Update private_mem_conversions_test for in-place conversions. In-place
conversions support is detected in selftests with kvm_has_gmem_attributes.

With in-place conversions, specifying userspace_addr from some other memory
provider that is not the guest_memfd associated with the memslot is a user
error, since KVM will only use both shared and private memory from the
guest_memfd.

Hence, when kvm_has_gmem_attributes, only test in-place conversions with
single backing, where guest_memfd provides both shared and private memory.

For single backing, guest_memfd must be created with
GUEST_MEMFD_FLAG_MMAP. Initialize the guest_memfd as shared to align with
how memory would default to shared when shared/private state was tracked at
the VM level (the test expects this, it was written for
non-in-place-conversions).

When handling a hypercall to set attributes, use
vm_mem_set_memory_attributes() to send the ioctl to the guest_memfd instead
of the VM.

When testing in-place conversions (single-backing), don't allow the user to
configure src_type, since src_type will be ignored. Don't use src_type to
determine alignment for rounding up per-cpu test memory size, since
guest_memfd's backing page size is always the system PAGE_SIZE.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 .../kvm/x86/private_mem_conversions_test.c         | 57 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index cf50e9a332c5b..33b610383693b 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -306,9 +306,12 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	if (do_fallocate)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
-	if (set_attributes)
-		vm_set_memory_attributes(vm, gpa, size,
-					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	if (set_attributes) {
+		u64 attrs = map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+		vm_mem_set_memory_attributes(vm, gpa, size, attrs);
+	}
+
 	run->hypercall.ret = 0;
 }
 
@@ -352,8 +355,21 @@ static void *__test_mem_conversions(void *__vcpu)
 				size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
 				u8 *hva = addr_gpa2hva(vm, gpa + i);
 
-				/* In all cases, the host should observe the shared data. */
-				memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				if (kvm_has_gmem_attributes &&
+				    uc.args[0] == SYNC_PRIVATE) {
+					TEST_EXPECT_SIGBUS(READ_ONCE(*hva));
+				} else {
+					/*
+					 * If not testing in-place conversion
+					 * (dual backing), the host should
+					 * always observe shared data, since the
+					 * shared memory is a separate page.
+					 *
+					 * For SYNC_SHARED, test that the host
+					 * can see shared memory.
+					 */
+					memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				}
 
 				/* For shared, write the new pattern to guest memory. */
 				if (uc.args[0] == SYNC_SHARED)
@@ -369,20 +385,29 @@ static void *__test_mem_conversions(void *__vcpu)
 	}
 }
 
+/* Align each vCPU's chunk of memory naturally to the size of the backing store. */
+static size_t compute_per_cpu_size(enum vm_mem_backing_src_type src_type)
+{
+	size_t alignment;
+
+	if (kvm_has_gmem_attributes)
+		alignment = getpagesize();
+	else
+		alignment = get_backing_src_pagesz(src_type);
+
+	return align_up(PER_CPU_DATA_SIZE, max_t(size_t, SZ_2M, alignment));
+}
+
 static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_vcpus,
 				 u32 nr_memslots)
 {
-	/*
-	 * Allocate enough memory so that each vCPU's chunk of memory can be
-	 * naturally aligned with respect to the size of the backing store.
-	 */
-	const size_t alignment = max_t(size_t, SZ_2M, get_backing_src_pagesz(src_type));
-	const size_t per_cpu_size = align_up(PER_CPU_DATA_SIZE, alignment);
+	const size_t per_cpu_size = compute_per_cpu_size(src_type);
 	const size_t memfd_size = per_cpu_size * nr_vcpus;
 	const size_t slot_size = memfd_size / nr_memslots;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
 	struct kvm_vm *vm;
+	u64 gmem_flags;
 	int memfd, i;
 
 	const struct vm_shape shape = {
@@ -397,12 +422,16 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
 
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
-	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+	gmem_flags = 0;
+	if (kvm_has_gmem_attributes)
+		gmem_flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+
+	memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
 
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
 			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, 0);
+			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, gmem_flags);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		gpa_t gpa =  BASE_DATA_GPA + i * per_cpu_size;
@@ -462,6 +491,8 @@ int main(int argc, char *argv[])
 	while ((opt = getopt(argc, argv, "hm:s:n:")) != -1) {
 		switch (opt) {
 		case 's':
+			TEST_ASSERT(!kvm_has_gmem_attributes,
+				    "src_type is only configurable when testing without in-place conversion");
 			src_type = parse_backing_src_type(optarg);
 			break;
 		case 'n':

-- 
2.55.0.1007.g17ff1f9808-goog


