Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236DC39DBF4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735970; cv=none; b=emMwTkrB2idek1zSnbl9l60OsNmCjE7LhSY/fhfZYoVAHN7QhgEk0HaDiYOtp+eqw5jR9Jm8ClhobbPaQKqn2FWbNfoL+nee0AQGJfQH2bjJ80o8gNzshlYRKBllIaQgmXtqBMEf2fCtEby9r04RaBcNmaoNJQu5RVIVdpZvMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735970; c=relaxed/simple;
	bh=xH/AetAOiAVfkVCScjPegESZvTMnvecRQ5W1mdHVya8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKdNMDlRxFJp1Apga/RVdujed2+7robtV+dEUAbuft5iMnyQwIm0qDEXppzgYofMynYrX/WJ+cFN7lB27XXDaQc+r7KoHhWjElTvdn1PLJpS3Ov9FMQ3V6uB9yhxp2XKTBnii2V+JAbNoBKLaXKvv1QzM5GcO3VpwJ6otOBNwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQh8jYum; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQh8jYum"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6fb956002so11304065ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735965; x=1788340765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbRUvfXufo/53FByarAgnrpLej2qb+vPYL1z/tXSG2A=;
        b=MQh8jYume8kgOW0PmRHAAPtFvC3oywCIURzp1pX9JsM3QXIYEOrxEreHL6jYEdlK5U
         AgbkXCy7kEp404NBpZuFPpqvfx+LeXrhOeUil4PZlM899c2iY7gRhNZNIZiK/+KLKQnf
         uR1yFC5z2xRLIgd5FmjdjMFhYa7zIBlP7ak1fmOv5uOQKF3W8ldMk1EUQnyG2it9XUCU
         Ta78NZ7qxFufeXZqGBsYyZzclGiDGcErwVcwp0K/aI9chXxzplJsSrSyzvPN0FhtUvmT
         S3giB5/FxOZNtIqkJ9v5ho86W0S8gMCk+vXbW9VuzEWoFSN/j/KnkiJOHhR3A7ORGh8J
         tNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735965; x=1788340765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LbRUvfXufo/53FByarAgnrpLej2qb+vPYL1z/tXSG2A=;
        b=lGHUGc7lpFSmhmPYADkPsZHPmo2R+M4v35oOZuA8x1wGe9TSOja2ssuMoza7H6487W
         cRuUp4d3egNQ0xnNB1B3d0iQ2iCUBznK5FbsIdavkMJ8ciot/dS0wangRmdjHIXve/4k
         fAEUCbltwlgcWphUK/D0KpsRDygX0V2uQzyNd5Sga+XBOOfb1Bspa9HFvDpqs38eJYBr
         pDdxTa+MdPLhAFWR8GvOwfmBmkvvWkIorq1WrLfTx1Z51qGkd9OiOc9ceWIOpjhceb8d
         Uxw+zUBE7u+7sY/celtUjiE9lKy2P3tKlRNqpGbrHpQOicw2qKqfrj1VdP0ghGSbHn45
         xrXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rry5yqV9L0isuTUS0lSvU5QcURmqdagLbe9sDRnM8gmgm3G9bOidI5W0M5HPvhGiGJlRWkhRUsuxbuc1/ghToGw4vc=@vger.kernel.org
X-Gm-Message-State: AFuF++nnhVMuqGFpTAd0mAhyE+EDvUz3FS7I7Q0q51xsBDoHmW7IybEb
	pZXN0PrKjLBkjDSZ8XKBgdzSW+gJhiwqf5AQSc+kCXsd9dBDdmKDjxdZj+GB1F6h+/fmeOvo2CE
	wwoHUJQoG5ESs4ChejUrfQ+c6Uw==
X-Received: from plbmo15.prod.google.com ([2002:a17:903:a8f:b0:2cf:bf3e:41f0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e54f:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2d707a2f08bmr89613835ad.2.1787735964425;
 Wed, 26 Aug 2026 02:19:24 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:43 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=5438;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=xH/AetAOiAVfkVCScjPegESZvTMnvecRQ5W1mdHVya8=; b=rBjdK8/qbBIySb4GV8EG74eZYYgnmFDHuYJd/UqCRYD0UNnjEq1/oCm1vlkEqhjZzxSbXcN7L
 +83jZ96iK2MDTs6i5y0XZawZfieoRqtZqJPahiBUo5v1PNUnNYnk+8w
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-45-0a15d8a799aa@google.com>
Subject: [PATCH v11 45/46] KVM: selftests: Test in-place conversions in private_mem_conversions_test
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Test in-place conversions by setting up the guest with a single backing,
using the same guest_memfd for both private and shared memory.

Make testing single backing the default when per-guest_memfd memory
attributes are supported (kvm_has_gmem_attributes). Continue to support
testing of double-backing by accepting a -2 flag.

When testing single-backing, don't use src_type to determine alignment for
rounding up per-cpu test memory size, since guest_memfd's backing page size
is always the system PAGE_SIZE.

To test in-place conversions, set up guest_memfd with
GUEST_MEMFD_FLAG_MMAP and GUEST_MEMFD_FLAG_INIT_SHARED so that both host
and guest access the same backing physical memory.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86/private_mem_conversions_test.c         | 55 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 0c94e36575a5e..8f03eea9e2fb6 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -26,6 +26,8 @@
 #define BASE_DATA_GPA		((u64)(1ull << 32))
 #define PER_CPU_DATA_SIZE	((u64)(SZ_2M + PAGE_SIZE))
 
+static bool use_double_backing;
+
 /* Horrific macro so that the line info is captured accurately :-( */
 #define memcmp_g(gpa, pattern,  size)								\
 do {												\
@@ -355,8 +357,15 @@ static void *__test_mem_conversions(void *__vcpu)
 				size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
 				u8 *hva = addr_gpa2hva(vm, gpa + i);
 
-				/* In all cases, the host should observe the shared data. */
-				memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				/*
+				 * When using double backing, the host should
+				 * always observe shared data, since the shared
+				 * memory is a separate page.
+				 */
+				if (use_double_backing)
+					memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				else if (uc.args[0] == SYNC_PRIVATE)
+					TEST_EXPECT_SIGBUS(READ_ONCE(*hva));
 
 				/* For shared, write the new pattern to guest memory. */
 				if (uc.args[0] == SYNC_SHARED)
@@ -372,15 +381,23 @@ static void *__test_mem_conversions(void *__vcpu)
 	}
 }
 
+/* Align each vCPU's chunk of memory naturally to the size of the backing store. */
+static size_t compute_per_cpu_size(enum vm_mem_backing_src_type src_type)
+{
+	size_t alignment;
+
+	if (use_double_backing)
+		alignment = get_backing_src_pagesz(src_type);
+	else
+		alignment = getpagesize();
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
@@ -404,6 +421,8 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
 	gmem_flags = 0;
 	if (kvm_has_gmem_attributes)
 		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
+	if (!use_double_backing)
+		gmem_flags |= GUEST_MEMFD_FLAG_MMAP;
 
 	memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
 
@@ -448,7 +467,9 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
 static void usage(const char *cmd)
 {
 	puts("");
-	printf("usage: %s [-h] [-m nr_memslots] [-s mem_type] [-n nr_vcpus]\n", cmd);
+	printf("usage: %s [-2] [-h] [-m nr_memslots] [-s mem_type] [-n nr_vcpus]\n", cmd);
+	puts("");
+	puts(" -2: use double backing (guest_memfd for private, src_type for shared)");
 	puts("");
 	backing_src_help("-s");
 	puts("");
@@ -461,16 +482,22 @@ static void usage(const char *cmd)
 int main(int argc, char *argv[])
 {
 	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
+	const char *backing_src_str = NULL;
 	u32 nr_memslots = 1;
 	u32 nr_vcpus = 1;
 	int opt;
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
 
-	while ((opt = getopt(argc, argv, "hm:s:n:")) != -1) {
+	use_double_backing = !kvm_has_gmem_attributes;
+
+	while ((opt = getopt(argc, argv, "2hm:s:n:")) != -1) {
 		switch (opt) {
+		case '2':
+			use_double_backing = true;
+			break;
 		case 's':
-			src_type = parse_backing_src_type(optarg);
+			backing_src_str = optarg;
 			break;
 		case 'n':
 			nr_vcpus = atoi_positive("nr_vcpus", optarg);
@@ -485,6 +512,12 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (backing_src_str) {
+		TEST_ASSERT(use_double_backing,
+			    "src_type is only configurable when testing using double backing.");
+		src_type = parse_backing_src_type(backing_src_str);
+	}
+
 	test_mem_conversions(src_type, nr_vcpus, nr_memslots);
 
 	return 0;

-- 
2.55.0.887.g758fc8c411-goog

