Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD533A254A;
	Tue, 28 Apr 2026 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418719; cv=none; b=EGELi6ppE4XAF7+yqNEJuRlE51FKh7ZPAi7Nk3MTTL/tZH5jilVNCB8/JccPCQnJ9kSiC9dBVy1aEU3p4GE7E3zhgXf8ghtSnEd7jG16VNRYNnNWjAleovkIfmmfEIJmzuIZvRfAgjKg+i84CeACQKAmKyJwxuHEK+yslp3gpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418719; c=relaxed/simple;
	bh=McDOUCm+isas7jiICyN0E5ubUDEjWu5iEe+R8RHc0CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/uBCO4cF4omzM8GEcFOHlXhbG+08E/q7FiAI4p8ZVnx0yN96URGnTkvfsjfdqmZg0uzzUL26J2N8ueqfT86W2zA8XjLe7lXFaSPzdxrnqnefdeLpUX/Ejt/7Oxkkfmqum7RUJZJLRenfGSD8LKp4ZH0VH4oBdwcR/N3yRsB/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUUp5bbb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUUp5bbb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3F15C2BCB9;
	Tue, 28 Apr 2026 23:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418718;
	bh=McDOUCm+isas7jiICyN0E5ubUDEjWu5iEe+R8RHc0CE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XUUp5bbbwTk2B138t2zteGlhdTVnCO7z4WnQMsOvSvPNYJhYjOm7WkxlIjPEOzujA
	 v0uYPn9kIsSc7AQkAQHsYfxsOODeuYeEBaEUwdy+1dSJTlI5P/ixTltxPoQDOAGgEo
	 EiCYob/sMLtZavC1mXkFco1QgXUaOFUVPJlpiWPWo/z//Y6VkkT32KKvdgtq/O5D3U
	 gPmuqbqAzi+IXO3PipnC96m4dfAIUygWkgyoU6E1CVJsnWHTOoi/8bV27iALynfHHK
	 FaYsw4TuJ6Z6OBpttpqpP0RXdmM2tFQU3LNG4g915jKHlGy5dyVuvShgnipAsMXBYH
	 sjV8EW9l2QGTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E1BFF887E;
	Tue, 28 Apr 2026 23:25:18 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Apr 2026 16:25:16 -0700
Subject: [PATCH RFC v5 21/53] KVM: guest_memfd: Introduce default handlers
 for content modes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-gmem-inplace-conversion-v5-21-d8608ccfca22@google.com>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
In-Reply-To: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777418714; l=3682;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=bExntzDH4eJvOXiKEEI4Mzgx/0x0zxgpmzImhSYoC1o=;
 b=PNbqwo9hcIQwsAQRGjQHX21H24S4wh3bsXFlO6MkquX+OHrZREiPkkpErhDiU7/NBi84pETDV
 vHMROayf7h/AC/UbqBdSyOejE+v/B0mVu0oQwwqp5Kacfunrp/JDX78
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Currently, when setting memory attributes, KVM provides no guarantees about
the memory contents.

Introduce default handlers for applying memory content modes, which
different architectures should override.

These handlers will be used later to apply memory content modes during set
memory attributes requests.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 12 +++++++++
 virt/kvm/guest_memfd.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f9ea95e33d050..458bad0083c37 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -741,6 +741,18 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 
 	return flags;
 }
+
+u64 kvm_arch_gmem_supported_content_modes(struct kvm *kvm, bool to_private);
+int kvm_gmem_apply_content_mode_zero(struct inode *inode, pgoff_t start,
+				     pgoff_t end);
+int kvm_arch_gmem_apply_content_mode_zero(struct kvm *kvm, struct inode *inode,
+					  pgoff_t start, pgoff_t end);
+int kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
+					      struct inode *inode,
+					      pgoff_t start, pgoff_t end);
+int kvm_arch_gmem_apply_content_mode_unspecified(struct kvm *kvm,
+						 struct inode *inode,
+						 pgoff_t start, pgoff_t end);
 #endif
 
 #ifndef kvm_arch_has_readonly_mem
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 85e8b3a981307..b0e4bb554cdf3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -693,6 +693,72 @@ static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
 static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
 #endif
 
+u64 __weak kvm_arch_gmem_supported_content_modes(struct kvm *kvm, bool to_private)
+{
+	/* Architectures must override with supported modes. */
+	return 0;
+}
+
+int kvm_gmem_apply_content_mode_zero(struct inode *inode, pgoff_t start,
+				     pgoff_t end)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio_batch fbatch;
+	int ret = 0;
+	int i;
+
+	folio_batch_init(&fbatch);
+	while (!ret && filemap_get_folios(mapping, &start, end - 1, &fbatch)) {
+		for (i = 0; !ret && i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
+
+			folio_lock(folio);
+
+			if (folio_test_hwpoison(folio)) {
+				ret = -EHWPOISON;
+			} else {
+				/*
+				 * Hard-coding zeroed range since
+				 * guest_memfd only supports PAGE_SIZE
+				 * folios and start and end have been
+				 * checked to be PAGE_SIZE aligned.
+				 */
+				WARN_ON_ONCE(folio_test_large(folio));
+				folio_zero_segment(folio, 0, PAGE_SIZE);
+			}
+
+			folio_unlock(folio);
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+
+	return ret;
+}
+
+int __weak kvm_arch_gmem_apply_content_mode_unspecified(struct kvm *kvm,
+							struct inode *inode,
+							pgoff_t start,
+							pgoff_t end)
+{
+	return 0;
+}
+
+int __weak kvm_arch_gmem_apply_content_mode_zero(struct kvm *kvm,
+						 struct inode *inode,
+						 pgoff_t start, pgoff_t end)
+{
+	return kvm_gmem_apply_content_mode_zero(inode, start, end);
+}
+
+int __weak kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
+						     struct inode *inode,
+						     pgoff_t start, pgoff_t end)
+{
+	return -EOPNOTSUPP;
+}
+
 static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 				     size_t nr_pages, uint64_t attrs,
 				     pgoff_t *err_index)

-- 
2.54.0.545.g6539524ca2-goog


