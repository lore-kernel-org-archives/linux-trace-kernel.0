Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC773D566F;
	Thu, 10 Sep 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084541; cv=none; b=heBnO5ET9ZtrQ7o54HLay0fqeHrbs16zPlDWCoFVp84MA/sP3bL9C/d7RGHEnN8wMCfE97GlRomGfBwl14BngRPrE1lC0X3imilneCKkXS3Ud/DxEuQMJdy2qLp/0z2QVbLHq52lnq354QlxvaQNtZdF7RnvUvd1nW9PDQzAuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084541; c=relaxed/simple;
	bh=Zm8m17UNWN4NPB96skt6eznY+e6ivIIGv3vH+lbtkSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rek3oZqbM6vrBcSzMgoziJ/qEUk4J/IRa5bHm14MPOpGNoyQY7ROJFk/YcYr9LtxS9pqEDCbk+6Vb9tx3N2yKC/MHg8m6IexKYh0Xyy5vZS7AjeHk0XWeqQISd3HeLdQQ7bQ/FsZLQ7rsPdU+7bu83CSVuq9BeJnsCi45ZLxPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWysHD4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWysHD4/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF63FC2BD00;
	Thu, 10 Sep 2026 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789084540;
	bh=Zm8m17UNWN4NPB96skt6eznY+e6ivIIGv3vH+lbtkSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iWysHD4/+KWN7HUQStQ/+B+orlgSyxJk9JVAbHOK1s1PMzCjSxkDngWsOqkL9bk1l
	 ZI2vduIrNUzMuRFkREfcffoQ0bgsUCW8reXLmxpz+4IAOUcaCCihZ+wwkgZfhcAd+d
	 YEsjN/wsPzHKfHrv8vMM/wOpYdXmAJPVVYHIbKvPhjuarLz8D0RvUCmR2eC7Srwi7P
	 jhGUBTWOtv6s55IMQWlA5UCosUOgOS86LMJvgFWJ1GU9bUBe8DIrq8FXAiLbXGQpdB
	 +29dbJOvM9aKr5sAoPPkfh/QuVvw/TNp+cZQI0HTBOd7ITs68RuFJ/FYEWsH1VjJFc
	 eXF6LwaMI/CTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA749C88E4C;
	Thu, 10 Sep 2026 23:55:40 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 10 Sep 2026 16:56:08 -0700
Subject: [PATCH v13 42/44] KVM: selftests: Set up page size and alignment
 independently for guest_memfd
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-gmem-inplace-conversion-v13-42-dd6fbf94f4e1@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789084533; l=5652;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=4X2PaHnMnamjeHImpEBasyFu/253pOYvVZroEZMdQ6Y=;
 b=ZhDaDs120Ou7ZWAQavmPguVCp/RlOxS5vpc027gvhpbRxPNjGdd3TcRvOCYTcfA9FUovDs2F/
 FCVlgvLvq97AmSOXoTgfFGx+viRH9d8k4J9HfA0s69Mp+19FF/f5j9v
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

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
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
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
2.55.0.1007.g17ff1f9808-goog


