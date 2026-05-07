Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C248C402;
	Thu,  7 May 2026 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185370; cv=none; b=iNUdyVOLB/DMTfQ6JUw1q+jo1FOhDpsVrQcdOQA8OYSfVOpZrDn4/rLlwehHHtNmFUsu0jmnI9xkOma/V5Q8tyeHU2fI1J+x8Zg8J8bA8BSygRbYGRyqPR0eZhRG4SELTmEj3X2fHG9mc9ULLaEkneg5pEz7r0M1VuyPTHMmtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185370; c=relaxed/simple;
	bh=N5R9oRhQJzT3W0fySZmS/tE/RBQSqt6xZpQf/jxTvVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=joDYIhyWf+EbAOR6nuZc5+f2xo78ErDAZ3zfD/XSzf/Gt9BROHmchiRyQt4QXFOO38Il0i8fmhe/iGnEBzK+EdatwdZuHeKEdwnNtS0kgwDMSzlx92VN9N5i/OSseeH/PduJnQLtD/rTtGDaRR04V0N2amEcClFrmW97S3o4wSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA71HU68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA71HU68"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06256C2BCB8;
	Thu,  7 May 2026 20:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185370;
	bh=N5R9oRhQJzT3W0fySZmS/tE/RBQSqt6xZpQf/jxTvVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mA71HU68Fqq043Dg3G3uzdUgSs9zZvLZh3+sEbK/2klQoFnTXmERKQKyQVi4kYpnp
	 FzBAJlY5hhFPmEANZN8gAaN1cm9D/PVdlCmJKaaWvoMLc0qb+sqTrz970mgWgiyaoz
	 6oHOfIeao1HbOUPcpB8b0malnCNXc7XV8AOXY4BuvAIb7rn2XxDRsuvLfrQRh2/VHa
	 r3LptC9AO4t3QR+xTjAo6UIVY47Bjkn5zWd1fe2hWbf4jNMLme2JamPFr5VouA22bK
	 TBEGUujvUPz1z44+k7g8qvApNY0AJuebvE1okJPlUZR72/DFT77qddkdeYTP1BtGPm
	 61nyCc4PLSoMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC558CD379F;
	Thu,  7 May 2026 20:22:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 07 May 2026 13:22:32 -0700
Subject: [PATCH v6 13/43] KVM: guest_memfd: Return early if range already
 has requested attributes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-gmem-inplace-conversion-v6-13-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, liam@infradead.org, 
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
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778185365; l=2558;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=b2U3rQZtoe13iK85Md2FTyXx66OuI05q1gqdIbbHlSQ=;
 b=UN/8Y1orfcMwyEZH0S6RExPannjH51GfhVxr5vzN7x9jmFkjvni9/PmzSMTOUzMaLZLxQCqVH
 lSEBC+HA0RABt69qVqqsoI+XK5xrvF6Ruy0bRDp9YiSgwEBHz9IOKpv
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Extract a helper out of kvm_gmem_range_is_private() that checks that a
range has given attributes.

Optimize setting memory attributes by returning early if all pages in the
requested range already has the requested attributes.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index baf4b88dead1f..034b72b4947fb 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -86,6 +86,23 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
 	return !kvm_gmem_is_private_mem(inode, index);
 }
 
+static bool kvm_gmem_range_has_attributes(struct maple_tree *mt,
+					  pgoff_t index, size_t nr_pages,
+					  u64 attributes)
+{
+	pgoff_t end = index + nr_pages - 1;
+	void *entry;
+
+	lockdep_assert(mt_lock_is_held(mt));
+
+	mt_for_each(mt, entry, index, end) {
+		if (xa_to_value(entry) != attributes)
+			return false;
+	}
+
+	return true;
+}
+
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
@@ -649,12 +666,15 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 	pgoff_t end = start + nr_pages;
 	struct maple_tree *mt;
 	struct ma_state mas;
-	int r;
+	int r = 0;
 
 	mt = &gi->attributes;
 
 	filemap_invalidate_lock(mapping);
 
+	if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs))
+		goto out;
+
 	mas_init(&mas, mt, start);
 	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
 	if (r) {
@@ -1140,20 +1160,13 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
 static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
 				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
 {
-	pgoff_t end = index + nr_pages - 1;
-	void *entry;
-
 	if (vm_memory_attributes)
 		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
 						       KVM_MEMORY_ATTRIBUTE_PRIVATE,
 						       KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
-	mt_for_each(&gi->attributes, entry, index, end) {
-		if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
-			return false;
-	}
-
-	return true;
+	return kvm_gmem_range_has_attributes(&gi->attributes, index, nr_pages,
+					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
 }
 
 static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,

-- 
2.54.0.563.g4f69b47b94-goog


