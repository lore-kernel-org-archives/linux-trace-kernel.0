Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE336265606;
	Fri, 19 Jun 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829109; cv=none; b=QvQp20DeFFDr1n8rjgr4rUNO+DxFZ+vh8DzUP4WbB3SVSrVu/RnuBu9k730amUKvE94YuxSTpchJATxmMzIuYhqRDaiJTNtLBW0qYe5mndZrMfrNXyBHM3kdoIKM2oPVa0/lwoVW0ahoT1hYbOhiyt8rEYLpOSAXeyWNxL8NzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829109; c=relaxed/simple;
	bh=evWNadeDhazc6f/ZM29RD4T7kjpvn8rDxzt9AVZdSsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NL9Ze+GrG61ieu+J3NJpQRbZ9Idw9Gut4reYfpyhwkKeP1TGWMpdPotEZa/yMFsjsl0nmS39FIDlwvEbw7U+l1LwnNiwjn+MZg5pY1GaSC0rkXuvLFFxzZgKKtMjhKGHHZaIEXit1Yn1EP0JA2Bz4pErsUfbU3FRngsfLUrvNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3SanR0Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3SanR0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBB1AC2BCC9;
	Fri, 19 Jun 2026 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781829108;
	bh=evWNadeDhazc6f/ZM29RD4T7kjpvn8rDxzt9AVZdSsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s3SanR0Q8LMaIkXKGMwNZJ1Mms3kk75IOnz+mkjFDzXcJ11uflQhvFJ3jEPH8SfzA
	 xtbSigirDWIiyVZEex5ZCQhSu4ltLiE1yVQXVTc+a3wYKEUsEbN+fthU8dSwgGQhF/
	 iBVErY47d5S9UqKceBn8y+QapQz6/Yg8fqzh9h7pA+KtnEKcwKQy4Fk65YsPHFNCtZ
	 Nm+UNfxLdm8u3ROI55gfp32M9aB9ZwD/AnXtEy7Sczjyt8CDkJJehEWvZBUzi3zMsK
	 L+axCL6ZC+EQr0MzmaXd1V0EF3fMAxBgVn43CQrqfyzGYy4P5hPMnxd2EH46XnBF7q
	 JY8NB3pmg/FZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBAECD98FA;
	Fri, 19 Jun 2026 00:31:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 18 Jun 2026 17:31:57 -0700
Subject: [PATCH v8 20/46] KVM: guest_memfd: Determine invalidation filter
 from memory attributes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-gmem-inplace-conversion-v8-20-9d2959357853@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781829104; l=3547;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=JFkMjbYYCjSDV01aUNFW6wbludDPAnrpthRKdegpfv0=;
 b=OO4uXerpwNkGX3lnED+sA8fbddORaRefcBZq+K5H30vPr37IqGGBiflXfk8zkfYYDva7oT3VB
 V1K1UrXO5s7D20uK+h5EDSnG88asfABca4vnzhbP39lxOPh6nQaUoHn
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Before conversion, the range filter doesn't really matter:

+ For non-CoCo VMs that use guest_memfd, they have no mirrored tdp, so
  KVM_DIRECT_ROOTS would have been invalidated anyway.
+ CoCo VMs could not use INIT_SHARED, and there's no conversion support, so
  always using KVM_FILTER_PRIVATE would have worked.

Now with conversion support, update kvm_gmem_get_invalidate_filter to
inspect the memory attributes maple tree for a given range.

Instead of determining the invalidation filter based on static inode
flags, iterate through the attributes maple tree for the specific range
being invalidated. This allows KVM to identify if the range contains
private pages, shared pages, or both, and set the filter bits
accordingly.

Update kvm_gmem_invalidate_begin and kvm_gmem_release to pass the range
parameters to the filter helper to ensure invalidation accurately
targets the memory types present in the affected range.

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d72ecbfcc3144..90bc1a26512b6 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -193,12 +193,24 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	return folio;
 }
 
-static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
+static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(
+		struct inode *inode, pgoff_t start, pgoff_t end)
 {
-	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
-		return KVM_FILTER_SHARED;
+	struct gmem_inode *gi = GMEM_I(inode);
+	enum kvm_gfn_range_filter filter = 0;
+	void *entry;
+
+	lockdep_assert(mt_lock_is_held(&gi->attributes));
+
+	mt_for_each(&gi->attributes, entry, start, end - 1) {
+		filter |= (xa_to_value(entry) & KVM_MEMORY_ATTRIBUTE_PRIVATE) ?
+			  KVM_FILTER_PRIVATE : KVM_FILTER_SHARED;
+
+		if (filter == (KVM_FILTER_PRIVATE | KVM_FILTER_SHARED))
+			break;
+	}
 
-	return KVM_FILTER_PRIVATE;
+	return filter;
 }
 
 static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
@@ -244,7 +256,7 @@ static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
 	enum kvm_gfn_range_filter attr_filter;
 	struct gmem_file *f;
 
-	attr_filter = kvm_gmem_get_invalidate_filter(inode);
+	attr_filter = kvm_gmem_get_invalidate_filter(inode, start, end);
 
 	kvm_gmem_for_each_file(f, inode)
 		__kvm_gmem_invalidate_start(f, start, end, attr_filter);
@@ -368,6 +380,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 {
 	pgoff_t end = i_size_read(inode) >> PAGE_SHIFT;
 	struct gmem_file *f = file->private_data;
+	enum kvm_gfn_range_filter filter;
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = f->kvm;
 	unsigned long index;
@@ -397,8 +410,8 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * Zap all SPTEs pointed at by this file.  Do not free the backing
 	 * memory, as its lifetime is associated with the inode, not the file.
 	 */
-	__kvm_gmem_invalidate_start(f, 0, end,
-				    kvm_gmem_get_invalidate_filter(inode));
+	filter = kvm_gmem_get_invalidate_filter(inode, 0, end);
+	__kvm_gmem_invalidate_start(f, 0, end, filter);
 	__kvm_gmem_invalidate_end(f, 0, end);
 
 	list_del(&f->entry);

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


