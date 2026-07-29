Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725F264A9D;
	Wed, 29 Jul 2026 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285308; cv=none; b=jDbEe0o76w2MpxUIoOjgYKtxjwQRP/+e1WZcqrnMCo3LXZnzwROrIQrMD2pUXPXLN/R1UVPLDRdUh44T4A66AUtcyant6z9Y0Iy4JlB79N7bOf3HJkh9w9dx43jLe2oJ7ATks+8FnrDVBpJ1L0QMbMMq4EUUX/iNbBzLx6OWMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285308; c=relaxed/simple;
	bh=pkebOZkkp1inMkmJU+fGxppndabOnRmuc89kDI/A+gI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJyXV0OEwqubLiwFqxRJMaE4A4LJH9feK2YiJvefXZfd54lNKmYK6eL0YLDqfVxhtLgnAgaYg+erp+DwMm2t0F136emosCx0mORRT2wetj5uZ9h+UqYsT97GIaH8tDaWPLI24KwqVPvTLXEOi5HeafJCLczE/8RAOegCvHxgonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ6/hRyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ6/hRyK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40830C2BCFA;
	Wed, 29 Jul 2026 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785285308;
	bh=pkebOZkkp1inMkmJU+fGxppndabOnRmuc89kDI/A+gI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kJ6/hRyKnzAkhN3sMmX5f2bCtSUZ6UJ0FvKno3mN8/qh2zkxpLxOkBI3L1bjTBiGv
	 W7vOaxR6O59H8FoQPzY4MoJxnT09Z3wfrAwA+CG6s97D5H1fd9KAPtgwyMLTz5kNH4
	 V8cUj0hLaqZ6BkIeO0mJOxac6jfwsX23bTXpDZdeeHQFl46WcmOPvStI1ejqbkEQAw
	 W76yc8Nla3BydbiUuH6DVysnTdMYIbkfFT5XtneUjgk8HZZmV0fySvl81ljcEO96rO
	 JZI/X0O7NR7xCLoBASlwPdJR90IMn1n4kE+Wbd9Hhq4KCnf3k5/LWERuVg8XTqETja
	 CHl7tq+BRXvZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B6DC54F5B;
	Wed, 29 Jul 2026 00:35:08 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Jul 2026 17:35:05 -0700
Subject: [PATCH v9 06/41] KVM: guest_memfd: Introduce function to check GFN
 private/shared status
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-gmem-inplace-conversion-v9-6-35f9aec2aed2@google.com>
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
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785285305; l=2538;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=w5N/wcndekVM21bdtflL2Uv+KRH9Rza4/KimR3U9GW0=;
 b=KRpu5g7Egc77bQKPLGdQFySei03zL9Q3JY6eo7VhPE2IQyX3JurNC2rrtDIMxdeh55W725a3e
 cW4tdT5vGfXBgOCkgfDHrXvTqdGTgalhlYinHAo18pVON39h1xNEFP2
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Introduce a function for KVM to check the private/shared status of guest
memory at a given GFN.

This will be used in a later patch.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/guest_memfd.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 438567e3fa6a1..73f564b87a324 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2594,6 +2594,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #endif /* kvm_arch_has_private_mem */
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
+bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
+
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
 		     int *max_order);
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8c7709a352cc7..33c9830190e2e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -474,6 +474,38 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	struct inode *inode;
+
+	/*
+	 * guest_memfd is the only provider of private memory and
+	 * guest_memfd must be used with a memslot, hence if there's
+	 * no associated memslot, there's no chance of this gfn being
+	 * private.
+	 */
+	if (!slot)
+		return 0;
+
+	CLASS(gmem_get_file, file)(slot);
+	if (!file)
+		return 0;
+
+	inode = file_inode(file);
+
+	/*
+	 * Rely on the maple tree's internal RCU lock to ensure a
+	 * stable result. This result can become stale as soon as the
+	 * lock is dropped, so the caller _must_ still protect
+	 * consumption of private vs. shared by checking
+	 * mmu_invalidate_retry_gfn() under mmu_lock to serialize
+	 * against ongoing attribute updates.
+	 */
+	return kvm_gmem_is_private_mem(inode, kvm_gmem_get_index(slot, gfn));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,

-- 
2.55.0.508.g3f0d502094-goog


