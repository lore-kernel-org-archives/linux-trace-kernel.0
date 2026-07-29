Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962E29DB6C;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285309; cv=none; b=AzteWNobtL75h+4RVchrkUQUMJnfmCWyuErHPLkwOOKz/Sm76FvkM1Ai2tqgrmke6pEbXMcYtcHHKyadT37Q9aNLgV0jxLkcOod0THWGL5pUBSaFxLfTxWNtT4YSU7b3X5X17ySpRC3eP/40P+RrugvzDmmWdcfzAB2Mjrtakow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285309; c=relaxed/simple;
	bh=VQp8VV/1HjrBbDW4b7xKHc9A6fUmeLHK+Zex8LeUIVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsGtJxX5rWEuT37iEhvmpk3WhScEPMxUnsbKJ+2/N6cyPXkJD/InRZbPatSb4ivl9gT1JmO7hoC1/dx/9IHH3r9icwdBYwOPgnHlgILmL5mf51PYWzr6KwjiOjjGlTScuTgvemRDMPN/5bt7cGok5rDs40Ta17QEuCm5j5v1uKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJTKylt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJTKylt0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8C06C4AF68;
	Wed, 29 Jul 2026 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785285308;
	bh=VQp8VV/1HjrBbDW4b7xKHc9A6fUmeLHK+Zex8LeUIVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HJTKylt03lwuH5+7v5RVmlBfup7e1wj6WuZd61cQatjmZHCmlQswUjFvbTmTaFKDT
	 NZfU3BfZnpUJoxjjagTKC8fmeRg23af3mTtmZn0awfXqeuxVaQgCZqOJrgZrnB0iXT
	 GU1TkIfXmt52Cv1I52hZYGGwjl5tTRWk5GfJPMgwZAkqS8PAPpuQ7HIRzmKS3t5n4R
	 HSwj7ogqTFjzhwTioF1xuscBdh2vW2ePa1eA7Ieezkrssk88GfQDKvDEchBH41yad9
	 qK6Q5RMqj35UgHxZ76rC2WVrPEYBlYbAYhQYkm6t9U5o7X1O+/VmL7Ybti6h7gqdz/
	 yAdR/tXxnD9VQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D15C54F5C;
	Wed, 29 Jul 2026 00:35:08 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Jul 2026 17:35:12 -0700
Subject: [PATCH v9 13/41] KVM: guest_memfd: Return early if range already
 has requested attributes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-gmem-inplace-conversion-v9-13-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, tabba@google.com, willy@infradead.org, 
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
 Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785285305; l=2782;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=VCw8XceJPrjTLah5c+6aK9kQo6IEla8VXHadDNB1FcI=;
 b=dcBMZOr0ZBpW+kNZxueejs5pg+E2UIMJT+1ewBhICvI6Vm083tE0K24FdLuoGexaDLE8ccRD+
 CED+onKhmkZCsGNLk6P9uXKblDRgo65C2kzAuAT5L5xLYT5Ht370hxA
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

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 612fcde4ae8ea..928fc7f4a01e4 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -94,6 +94,24 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
 	return !kvm_gmem_is_private_mem(inode, index);
 }
 
+static bool kvm_gmem_range_has_attributes(struct inode *inode,
+					  pgoff_t index, size_t nr_pages,
+					  u64 attributes)
+{
+	struct maple_tree *mt = &GMEM_I(inode)->attributes;
+	pgoff_t end = index + nr_pages - 1;
+	void *entry;
+
+	lockdep_assert(mt_lock_is_held(mt));
+
+	mt_for_each(mt, entry, index, end) {
+		if (kvm_gmem_interpret_entry(inode, entry) != attributes)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -611,12 +629,15 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 	pgoff_t end = start + nr_pages;
 	struct maple_tree *mt;
 	struct ma_state mas;
-	int r;
+	int r = 0;
 
 	mt = &gi->attributes;
 
 	filemap_invalidate_lock(mapping);
 
+	if (kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs))
+		goto out;
+
 	mas_init(&mas, mt, start);
 	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
 	if (r) {
@@ -1107,22 +1128,14 @@ static bool kvm_range_is_private(struct file *file, pgoff_t index,
 				 size_t nr_pages, struct kvm *kvm, gfn_t gfn)
 {
 	struct inode *inode = file_inode(file);
-	pgoff_t last = index + nr_pages - 1;
-	struct maple_tree *mt;
-	void *entry;
 
 	if (!gmem_in_place_conversion)
 		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
 							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
 							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
-	mt = &GMEM_I(inode)->attributes;
-	mt_for_each(mt, entry, index, last) {
-		if (kvm_gmem_interpret_entry(inode, entry) !=
-		    KVM_MEMORY_ATTRIBUTE_PRIVATE)
-			return false;
-	}
-	return true;
+	return kvm_gmem_range_has_attributes(inode, index, nr_pages,
+					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
 }
 
 static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,

-- 
2.55.0.508.g3f0d502094-goog


