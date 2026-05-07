Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817AB33BBB1;
	Thu,  7 May 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185369; cv=none; b=HSI+noDU09fNB80POgmPhOhAOCr3rwy0GuFWy5GcuBf+64tdZbYxJxmkPADxWgHE32OY//M4DvQUpphYBkunpxrtmsKUw95dY01MuvaG/VvXHbZ2kTlRE3sd1BjJOtdBL+HTjGC9A+RluVX+chTxgSdh71TeUms/UyCavjNz8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185369; c=relaxed/simple;
	bh=KGw+g/GrqUHYRmudvCC0jgWydQGxm8wbnDPIEcWsmI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BA6isNtmAIWv8T8aSHWz09u8LbmEUZt9qrcqDFdlmK+XU6ZWtjNND13ThczgH1273mbfsspEbN3e7xIbph7zRcLLNSLiQHS4aiT2gFFQ3RbXpEX+A/LONjqMQazfJ8B/x54PKokPxStRs4Mx0JOV8Y4RNJhnpY6kjYuj1ZiYYL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUuYLPVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUuYLPVK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6354EC4AF0D;
	Thu,  7 May 2026 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185369;
	bh=KGw+g/GrqUHYRmudvCC0jgWydQGxm8wbnDPIEcWsmI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JUuYLPVK5FvcKkmx6Rx7d1vSSVbD2yARruGmy7AxSWRdqET/7fzWd4ELMXqFE7Llp
	 MGgCTbEyww2imcP5NMuaXpdCOMAf90Widfzfil6U2SgqNMlp6KSGmXIoDB12X/08gY
	 iOeTzmbBXygvudJ8PWeMiAZ3Wsi9xuNJ6afa7AyBn9TV2lNmthmWOmJ8b1Pabd0Vgn
	 YMcTczGXOmnzkEParo3HcMRtGX0EAtPqOayHCAsi4uz8AOJ3+8EydMjmaV5jbwf4fW
	 VkH/yqgK1rDQl+UyYmDOgzaVCR3ynSWNp8HJKfaYYMp+23xcjs/iIKzgm3r8aL2BvB
	 aLBR8tbvVV7KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C741CD3447;
	Thu,  7 May 2026 20:22:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 07 May 2026 13:22:27 -0700
Subject: [PATCH v6 08/43] KVM: guest_memfd: Only prepare folios for private
 pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-gmem-inplace-conversion-v6-8-91ab5a8b19a4@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778185365; l=2198;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=xtpmgcfndSxNcZVTwB04xXaV1WHVzjM0+b2CjPRcVbk=;
 b=fdwSxOUbKsCq2DngSVKKVn3uTyf4sOf2cWXOoJ+wAwTNq1cgHAjtaBGomllK+0A4FLZxFLN6m
 /APdBUfVVzNDCXAXbQ5KTqGzQmbi2QO+HapCi7/nE88imakiCsic+ap
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

All-shared guest_memfd used to be only supported for non-CoCo VMs where
preparation doesn't apply. INIT_SHARED is about to be supported for
non-CoCo VMs in a later patch in this series.

In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
guest_memfd in a later patch in this series.

This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
shared folio for a CoCo VM where preparation applies.

Add a check to make sure that preparation is only performed for private
folios.

Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
conversion to shared.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 9d025f518c025..4f7c4824c3a45 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -888,6 +888,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     int *max_order)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
+	struct inode *inode;
 	struct folio *folio;
 	int r = 0;
 
@@ -895,7 +896,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!file)
 		return -EFAULT;
 
-	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
+	inode = file_inode(file);
+	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
 	if (IS_ERR(folio)) {
@@ -908,7 +910,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_mark_uptodate(folio);
 	}
 
-	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
+	if (kvm_gmem_is_private_mem(inode, index))
+		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
 
 	folio_unlock(folio);
 
@@ -918,7 +921,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_put(folio);
 
 out:
-	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);

-- 
2.54.0.563.g4f69b47b94-goog


