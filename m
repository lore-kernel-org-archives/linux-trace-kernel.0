Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382723BCEE;
	Fri, 19 Jun 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829108; cv=none; b=bqpgDdZH0lHVZN+nOutRFVzlZ1/IbMFqKhDY1RoUz51fp5qyI/n8f9NYDXpANULDm5Aci8fMyn9C7F2IcCgNpUmUjJzTZZiSq/15YaT9nkg9FEFKTE0Onm63/+MwgDOeQut9F7ugdTOJEIBCMOfGZVFgcBYN+g07tQSVuK4b15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829108; c=relaxed/simple;
	bh=77tno+1BEzOBJ5VyiPmvluDUJLKSOaYf+ccqqrV2opE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XU6+GJJg6Z0fcGTTxPV1W9FeTAIlruATnTbpXRuriosXsVHZUlIy1g13nGmSKwcjhYtuh2BKGnQdmYGj4ELsUCfa3QC8kYJUa+bjebc4TjOi8u5ncMmGZ0io0BWSwFHLcausuje1+88m5BlXdhrUUI5ge9YiBp2GEFMYDo5xb4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiXcLSdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiXcLSdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FFFEC4AF63;
	Fri, 19 Jun 2026 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781829108;
	bh=77tno+1BEzOBJ5VyiPmvluDUJLKSOaYf+ccqqrV2opE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jiXcLSdQVJ5yO4ecfWTvDsnDGky5JHVZcLf3y5slRlbHhD2/VGTRFoT8hPXhodcwM
	 fYPLFIF72Y6W7m37/DQiD4xR+Kj/VIGnp08F9Awxk+oN/T7WS6irTQv84K4Ngn9y7L
	 DZp0aDz1fBzQ8Xi2phYIhUN6YzuGfFvcj5j8eO8znmoJcAR6FGMM6FQ9ALCKnoQfe1
	 y3oUws0G8Smc5A9hX3iFwhbl+fspjJRmoOgkFzfzeQdfZ58ks/K9Y283WILEJtmIjs
	 VzbcYzy0+EZ9/5k6IrepB+w1FbZtebPMMfbaiBe/xJ3Fx2zpnKofg6WPX8QnLNk2ec
	 zJ+mOk3sk3gcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410CDCD98FA;
	Fri, 19 Jun 2026 00:31:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 18 Jun 2026 17:31:53 -0700
Subject: [PATCH v8 16/46] KVM: guest_memfd: Return early if range already
 has requested attributes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-gmem-inplace-conversion-v8-16-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781829104; l=2581;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=XtB3xaNYZoGgLjv/gUxy02ochDW78D95+vPEFAYFilQ=;
 b=8DN2flcUdZvH8IsUjtTwKQwrPHe3JRoPhgMeWB3OXFnqBo/oCJQj5p5x5PXtVI47Jk7xP3NoS
 AvdvXpAVzJeBJFJ3PPfPlZOPbVNtUoRPW7WV6NpG4Zt7fl73nxNK7BC
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
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 3c94442bc8131..cec8fa26ece17 100644
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
@@ -653,12 +670,15 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
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
@@ -1148,19 +1168,14 @@ static bool kvm_gmem_range_is_private(struct file *file, pgoff_t index,
 				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
 {
 	struct maple_tree *mt = &GMEM_I(file_inode(file))->attributes;
-	pgoff_t end = index + nr_pages - 1;
-	void *entry;
 
 	if (!gmem_in_place_conversion)
 		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
 							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
 							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
-	mt_for_each(mt, entry, index, end) {
-		if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
-			return false;
-	}
-	return true;
+	return kvm_gmem_range_has_attributes(mt, index, nr_pages,
+					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
 }
 
 static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


