Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7932377ED2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563891; cv=none; b=rnBgRHDVOTXpsdkuh6OVn9341x6Qu5n8wWzryyldwaMK6X8ttpq9SeUyMbdSKUA7muSxf/+G9UQACdwxKg2uOkKK+mkFN6iUI8qGTDtzQdp2ENC9PL6ywoYHH9nIwTWBS/WmSU9EM0WP2vI9cF6jEORHSp3W5Nh5THJZGncBop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563891; c=relaxed/simple;
	bh=9AbnVGj52dYRY1Gu1IOMz+RQizSjYS4bjrECQdvobIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t/MaETuteCIKU8CyZArfqmsBiCMWKYh/3fbUob90syQ/DKQS7/iDX+5QAnGngBVwuCekxmuY1k0rkZZQZUOQ0c54m94gT8cMgSZrlB2UGN4PcBNP7rBAbLI7hqDFV3SfQlYaHDP/82zlK99qmTayqkeOJsi+V9xQb2PGNk/dNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIAHQKRf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIAHQKRf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c646e980bso986330b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563889; x=1775168689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVWPwC6pxhgIAnF5094KQEX5dCEhr5KYAaDw4qPFZtk=;
        b=cIAHQKRfNDQtdbXGpHDm5qqt9wfdpNHMYCnkh4a3deocXIB7VBALvfS1V3OQk9hHxz
         bJI7d461rnIQMVZSMpFQhLtvvIBB+E3nkjcfSTg0Nh3xFr0Z1bWbX8+H5tYF+0cXLHz9
         TRX6fJHoQ9JOBc+wD0OYq5JNzznxDOtq4INimshi1SQzm93y2TO3r8/0ECoWGWyoUxFc
         Broc92fEDU2RM3DhW7Aa3quDFe3w6AymPip+eRJHsp9AwH8YzXbWHmDuFlqe3qo6+ohp
         jG9AQ3YPgp8ewkeay77Ffkfh9bAmqqP//R2jmD4LRO/raFob1KeCepGjIK+rQQHMZJ+X
         6HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563889; x=1775168689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVWPwC6pxhgIAnF5094KQEX5dCEhr5KYAaDw4qPFZtk=;
        b=tSW9Q8XCG6jP9/UfRJaQ0BDIILVOa20aX2XYsbPoURzVwLsW8q7JVs2mXbu+ZIbbFA
         sPAsVsK28Zzgffm2XtkJJ+gHDd+DrJxZK+52D+wZR6mGRRxAVTXQN6YnDQ0yxm3h4YMz
         XP9AX5lKj6vuORhmXI1MqZhZ/FeUQklG9zHduC0KNxZcnGWyif/Wj4FbA6uqWtAkDrm2
         kCLX69BWr5noMM8kvxnsZu+6T/dt+Tc87mKpvCYDAc17FNGpzLBENM6LGYcoMbY1ueiP
         fVCDpknCxQnIPFzSrJOEle3XxJ6hyRmDqD4iN/yiywadcOB0lObNuNBQd1pQTMLVgl4/
         XVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMXyfuFqaVBSs2EHgO5q5IiImyinvLBnoqW6fbaTgT2oOk37m2IYX8Zb386n7kXqmbZAQtS6xDa1QVNeG6dxpD3Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8kGmNfftWw71Bp2PYuB5zmeuzhFH7yYDB3m3M7+sfgxe/SIR
	/57W3cCm0EAwUy+E4HFj3nMSucdTpqvCdalsi0yEtimNneTGeIbqQKrtJWlNolcdLOqdRX3hzBF
	QuFHMLRbh73254hM8HC7gwLdkWA==
X-Received: from pfjg13.prod.google.com ([2002:a05:6a00:b8d:b0:829:884e:b688])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d0c:b0:81f:5ec1:8bcd with SMTP id d2e1a72fcca58-82c95ea94dcmr142656b3a.20.1774563888635;
 Thu, 26 Mar 2026 15:24:48 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:21 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3818;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=9AbnVGj52dYRY1Gu1IOMz+RQizSjYS4bjrECQdvobIg=; b=kc7IoC0mcSRd+pSE2vC9D3Uk9DcdVSJweK7d8NasersOpLBpqrsExouK2O75W2pgSl/5dLP7W
 +yGN4wGXJetCGmCWXjtwUwUvZiTUK4/T8FKHTTkq4UHanZPTfIU0TqT
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-12-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 12/44] KVM: guest_memfd: Introduce default handlers for
 content modes
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Currently, when setting memory attributes, KVM provides no guarantees about
the memory contents.

Introduce default handlers for applying memory content modes, which
different architectures should override.

These handlers will be used later to apply memory content modes during set
memory attributes requests.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 12 +++++++++
 virt/kvm/guest_memfd.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1ea14c66fc82e..4ba3c4b303f4a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -740,6 +740,18 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 
 	return flags;
 }
+
+u64 kvm_arch_gmem_supported_content_modes(struct kvm *kvm);
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
index 20a09d9bbcd2b..e270e54e030f0 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "asm-generic/errno.h"
+#include "linux/page-flags.h"
 #include <linux/anon_inodes.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
@@ -669,6 +671,71 @@ static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
 static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
 #endif
 
+u64 __weak kvm_arch_gmem_supported_content_modes(struct kvm *kvm)
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
2.53.0.1018.g2bb0e51243-goog

