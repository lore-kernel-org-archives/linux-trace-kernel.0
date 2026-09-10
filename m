Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2F3B47CC;
	Thu, 10 Sep 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084538; cv=none; b=eenJTuYraJkYSDcrtJi2UR+5CUaW0NqBwzvnC+GWFjtNmhK6RRKGLj/JZqyRl5b0n26pTQkGKO/dU4DXUTOu9SSWMmsjEeNiM1KR+NGCGmRM3Q54kQFMVWCrjBud3Xyv/OQ3QGKPe8/IoPn8ZyP9aS81rdWqtRun7Zs0SYol5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084538; c=relaxed/simple;
	bh=AKnq3mfGG77mv+gq3PNJT06gkFvH6br0vIP3tfVxk8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkquM9I4uLDpivekeVA8e6TLWv/dFQGXARmi4e+FrSLYIItpOe/z+3luLxrhvpMx8dM+PG3sEuS+6JX7vqvXa+SxkpPapUBIibBb55fTBcsifaP6uWWvG4KX6r9Pq9LsOaFAZWm+QTMJNMQY/4Hyo+pgpLUNKQTmjUPiwDVWbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAWqa6HN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAWqa6HN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C22C2BCFC;
	Thu, 10 Sep 2026 23:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789084538;
	bh=AKnq3mfGG77mv+gq3PNJT06gkFvH6br0vIP3tfVxk8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mAWqa6HNhQOZLMGnaET8GvLt/RbWXdF5Rp97p5omjedV9D1vBxgLAY2ibAsD5P904
	 /akbgtQxHzHYhOVjluMU+HFYTHNnCVNI51UczcWhIsODyxrmhV8aP3itMsD4B4m/04
	 ZG8nXaBbdMY5XFDDGC8GCiaO7Jb/YJjIscEsDA1z8Qt1TbFoMr/KOfc8ym/tuTWkY3
	 6HiPenLL6XjSSopKfuZNAvcBu7x1rMKj6xxKiR/a40gVOycb4tvs7yVKMkTIpuXvWu
	 2JYGHZjW0fblBFKmfbdNOSiTN6hW+6SVSolbEnQfm37570nK2LHC4CkebJbHzaM6Mt
	 YDJb3QuvrxP0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53ABC88E46;
	Thu, 10 Sep 2026 23:55:37 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 10 Sep 2026 16:55:39 -0700
Subject: [PATCH v13 13/44] KVM: guest_memfd: Pass mapping type filter to
 invalidation helper
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-gmem-inplace-conversion-v13-13-dd6fbf94f4e1@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789084533; l=3075;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=olcJqZe/kIoxozaeU+OrcoTgHksLE0XmCcjni2I7E2I=;
 b=PuzcQplh7gT51UloHv+ksBnamz11cj9OVdlBS5Uv6zl9EQj3TJbbaqQLWZ/soHHP9gmqJhceI
 hjoYykTAE84BkNyY+4TA4mZ6z4mYfa48tiQc0dA3c5wb0giaT/aBERH
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Accept the mapping type filter as a parameter in the invalidation start
helper instead of querying it internally. This allows callers to specify
which mappings (shared, private, or both) should be invalidated.

In the next patch, the conversion process will use this new parameter to
invalidate mappings only when they're different from the target state of
the conversion, i.e. invalidate only shared mappings on a shared to private
conversion and not both.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
---
 virt/kvm/guest_memfd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e41802944756b..e19de803149c2 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -192,13 +192,13 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 }
 
 static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
-				      pgoff_t end)
+				      pgoff_t end,
+				      enum kvm_gfn_range_filter filter)
 {
-	enum kvm_gfn_range_filter attr_filter = kvm_gmem_get_all_gfns_filter(inode);
 	struct gmem_file *f;
 
 	kvm_gmem_for_each_file(f, inode)
-		__kvm_gmem_invalidate_start(f, start, end, attr_filter);
+		__kvm_gmem_invalidate_start(f, start, end, filter);
 }
 
 static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
@@ -224,6 +224,7 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
+	enum kvm_gfn_range_filter filter = kvm_gmem_get_all_gfns_filter(inode);
 	pgoff_t start = offset >> PAGE_SHIFT;
 	pgoff_t end = (offset + len) >> PAGE_SHIFT;
 
@@ -233,7 +234,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	 */
 	filemap_invalidate_lock(inode->i_mapping);
 
-	kvm_gmem_invalidate_start(inode, start, end);
+	kvm_gmem_invalidate_start(inode, start, end, filter);
 
 	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
 
@@ -522,6 +523,8 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
 
 static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
 {
+	struct inode *inode = mapping->host;
+	enum kvm_gfn_range_filter filter;
 	pgoff_t start, end;
 
 	filemap_invalidate_lock_shared(mapping);
@@ -529,7 +532,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	start = folio->index;
 	end = start + folio_nr_pages(folio);
 
-	kvm_gmem_invalidate_start(mapping->host, start, end);
+	filter = kvm_gmem_get_all_gfns_filter(inode);
+	kvm_gmem_invalidate_start(inode, start, end, filter);
 
 	/*
 	 * Do not truncate the range, what action is taken in response to the

-- 
2.55.0.1007.g17ff1f9808-goog


