Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564940D590
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735971; cv=none; b=RfdM0uXwKZTQcQZJlOQiqDL+RRsTJJiPqwCzVeO8Gaee9XqxXYM/xAKsTzMizaPsLbth1n5HlXYqN6Hh+c+ISUbfcv5+WOpcHXQmoeLiysI6fDfWgpWEwRlsA8mxk3g94+n0rj23mv7Jxgw9Y/6D4NFdb1w/iLxx3r5POcF5L2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735971; c=relaxed/simple;
	bh=sPZHu6CIw+fRiMalmPEts6Uh4jsHKlHCx6VuhBaSH7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VjVlZPC1IK2OheqK6WZXIzydyX2bp1c8Nm80uPmIWiF9m0kwvTJuZarqGD82tSoDtOQX+qLsDjF/jEQXM+SFk5KA5w16S05DhQ+lVFsxao37ZXp91Q50Uy1NKq7wAuZfW+cBICQjeIM2nX21KthxnAEOfcNAndlUY3mBi5z9BH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tufxxKrQ; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tufxxKrQ"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so981426a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735963; x=1788340763; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jz7w3ahlJ2XXJ+zdKH+uz7IHVQmm2wlsntFHCBVHzEo=;
        b=tufxxKrQOTK6eS9XSEKIoVR0V1GOmYPXnim9uIvkRu5aS7HAt/ilPZy7sG/JlXG6RA
         gmi8xH9dbMtGU01AUffdkISLUMHAXZ44Pyn2QugUa0ucC3mMEwf6uNoTr8eM57ib2JYf
         YgNrWp7nNIXp844JTXyfm27wTlICKt0Urf3z0n7snBOLUatwQZ48oihPnNihdFNAOHEA
         7AY9uAsb85M8duCv+hCMoet4TY08ocflV1D19OUDmw/89Imev/QUb6NhzNws2iiMdLQc
         qdY+mTe0EV5oSIwRrL0EoImWYVrmIamuw0DE73ThSlpa8T4NOvOGOWbFH95kXWPrmUt5
         76YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735963; x=1788340763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jz7w3ahlJ2XXJ+zdKH+uz7IHVQmm2wlsntFHCBVHzEo=;
        b=p3WBbUmYlree7SivzEIwD7HJ74kUDfp4atdsCDdpZP0xocM13vhG9vZgVIADTbU0fS
         MiCtzEmksgFkbvQoWn5fSiQw+VKW9VBLpkMnuFspx7KpiPcAsGVD2VyhiBE87xILFjRn
         1207JxjPts5bHATLRpB9zhjKhoqOM29NhwXrwq/LUR5Q+9arCNaI7iceZlgvFWcj0iuO
         +2Mlws3v1dBgt22L7EnU00VgS5uDhS/85fQV0phVT6JIGdG3yVSJQyeZTA2wkFSEUYMA
         5sFgKK+VhuAdDb5RqyDDGMGxsobFcZjm7R4UyYTItMwh84YTn0xw0fhoHqhkDNVVbqBX
         08Ig==
X-Forwarded-Encrypted: i=1; AHgh+RqsQqrflXqFbPrhOsy1WEVO+xiIKAntAbP7Uwh98ol8GvHz8ASXpAJ2qsM0PS8rTdpVVuHoWUWj3sHDnk3LK2Zzf68=@vger.kernel.org
X-Gm-Message-State: AFuF++kUnb62fZBVNDlNSdt6KK1RyJQafWE9+uRhe7zc8RSUron6teG/
	AlMxZeqhpCb7NlcPzLsWsSekpBysDMS4OmCTSY8CQoIsfkrbgMobJni0MvC+sTsIhtXZroaqA9G
	3NodVhI//RIKCLqCVnVcOniGslA==
X-Received: from pgbcr9.prod.google.com ([2002:a05:6a02:4109:b0:cbe:e120:3788])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bb0e:b0:847:8acd:747c with SMTP id d2e1a72fcca58-85374ebe486mr8878186b3a.13.1787735962670;
 Wed, 26 Aug 2026 02:19:22 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:42 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=5603;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=sPZHu6CIw+fRiMalmPEts6Uh4jsHKlHCx6VuhBaSH7g=; b=bc/CQRB4ghM7RBxbU4UEgzRadqchF8JqcorHB5X+jTCT4Ow+7Y+I0O0F99fDiLd5s3UobJ854
 7jfsBkZtDy0AJ7cv9qPJR7hlIRFbgTbM0OIMWLsXAcqj1brU61YZrtq
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-44-0a15d8a799aa@google.com>
Subject: [PATCH v11 44/46] KVM: selftests: Set up page size and alignment
 independently for guest_memfd
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

Currently, vm_mem_add derives the backing source page size, alignment
padding, and mmap size from the backing source type upfront before checking
if guest_memfd is being mmapped.

With shared memory also mmap()-ed from guest_memfd, the alignment of the
mmap-ed address needs to respect guest_memfd's backing page size.

Refactor the backing store setup to configure the backing source page
size, alignment, mmap flags, and mmap offset directly for guest_memfd
when it is mmapped, ignoring the backing source type.

Skip hugepage validation and anonymous memory madvise calls when mmapping
from guest_memfd, since those are not applicable when mmapping guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 74 ++++++++++++++++++------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cac5624e99774..3f559f207408f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1034,11 +1034,12 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 {
 	int ret;
 	struct userspace_mem_region *region;
-	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
-	int mmap_flags = vm_mem_backing_src_alias(src_type)->flag;
 	size_t mem_size = npages * vm->page_size;
-	off_t mmap_offset = 0;
-	size_t alignment = 1;
+	size_t backing_src_pagesz;
+	off_t mmap_offset;
+	bool is_gmem_mmap;
+	size_t alignment;
+	int mmap_flags;
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
 
@@ -1090,19 +1091,31 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	/* Allocate and initialize new mem region structure. */
 	region = calloc(1, sizeof(*region));
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
-	region->mmap_size = mem_size;
 
-	/*
-	 * When using THP mmap is not guaranteed to returned a hugepage aligned
-	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
-	 * because mmap will always return an address aligned to the HugeTLB
-	 * page size.
-	 */
-	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		alignment = max(backing_src_pagesz, alignment);
+	is_gmem_mmap = (flags & KVM_MEM_GUEST_MEMFD) &&
+		       (gmem_flags & GUEST_MEMFD_FLAG_MMAP);
+
+	if (is_gmem_mmap) {
+		backing_src_pagesz = getpagesize();
+		alignment = 1;
+		mmap_flags = MAP_SHARED;
+		mmap_offset = gmem_offset;
+	} else {
+		backing_src_pagesz = get_backing_src_pagesz(src_type);
+		/*
+		 * When using THP mmap is not guaranteed to returned a hugepage aligned
+		 * address so we have to pad the mmap. Padding is not needed for HugeTLB
+		 * because mmap will always return an address aligned to the HugeTLB
+		 * page size.
+		 */
+		alignment = src_type == VM_MEM_SRC_ANONYMOUS_THP ? backing_src_pagesz : 1;
+		mmap_flags = vm_mem_backing_src_alias(src_type)->flag;
+		mmap_offset = 0;
+	}
 
 	TEST_ASSERT_EQ(gpa, align_up(gpa, backing_src_pagesz));
 
+	region->mmap_size = mem_size;
 	/* Add enough memory to align up if necessary */
 	if (alignment > 1)
 		region->mmap_size += alignment;
@@ -1129,10 +1142,8 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	}
 
 	region->fd = -1;
-	if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP) {
+	if (is_gmem_mmap) {
 		region->fd = kvm_dup(gmem_fd);
-		mmap_flags = MAP_SHARED;
-		mmap_offset = gmem_offset;
 	} else if (backing_src_is_shared(src_type)) {
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
@@ -1141,22 +1152,27 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
 					mmap_flags, region->fd, mmap_offset);
 
-	TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
-		    region->mmap_start == align_ptr_up(region->mmap_start, backing_src_pagesz),
-		    "mmap_start %p is not aligned to HugeTLB page size 0x%lx",
-		    region->mmap_start, backing_src_pagesz);
-
 	/* Align host address */
 	region->host_mem = align_ptr_up(region->mmap_start, alignment);
 
-	/* As needed perform madvise */
-	if ((src_type == VM_MEM_SRC_ANONYMOUS ||
-	     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
-		ret = madvise(region->host_mem, mem_size,
-			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
-		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
-			    region->host_mem, mem_size,
-			    vm_mem_backing_src_alias(src_type)->name);
+	if (!is_gmem_mmap) {
+		TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
+			    region->mmap_start ==
+			    align_ptr_up(region->mmap_start, backing_src_pagesz),
+			    "mmap_start %p is not aligned to HugeTLB page size 0x%lx",
+			    region->mmap_start, backing_src_pagesz);
+
+		/* As needed perform madvise */
+		if ((src_type == VM_MEM_SRC_ANONYMOUS ||
+		     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
+			int advice = src_type == VM_MEM_SRC_ANONYMOUS ?
+				     MADV_NOHUGEPAGE : MADV_HUGEPAGE;
+
+			ret = madvise(region->host_mem, mem_size, advice);
+			TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
+				    region->host_mem, mem_size,
+				    vm_mem_backing_src_alias(src_type)->name);
+		}
 	}
 
 	region->backing_src_type = src_type;

-- 
2.55.0.887.g758fc8c411-goog

