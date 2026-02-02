Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A03644D1
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071441; cv=none; b=HBjcqatNeWsqAA2NOojP/2g8Wf7cYuOl74XxMAxyXw7r4dEe0rbXm5NBpRxsZHyxoo0QI+MjlZIZF2VxES/lKq9MfGr6tGoKDZ0UpvsQNhw9CpXoxDkO3UsG1ogRRaRU1JK6FX1rhMV3c81+pNeNP8Liah4uYMWakk19BMHjwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071441; c=relaxed/simple;
	bh=tFfY7VxjWkSUd6Jmad8JfAmMwCp6JndcHwBrKSgr1rY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oaxdyZYR/FIMosgmTdjua+2oRbhdi+LgMKDyIFigiN3tBSyuiBvQIm48/9LSSHVpLb3nvoQfZQwyfgZA1nMtzCaN+P+xS1LVEBZKx4gKQST+IrdEnt/rTo8J14S5JcE4wu07LCf0SN3T1aFmT8+enr3NuLtouZbDf4vvLuyBC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6nFw107; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6nFw107"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso4411821a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071439; x=1770676239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BE4daa5nHLf/W7WnPK3owx5g9H3yB7xbYigFlzRc16s=;
        b=X6nFw107mmQm5pGvWJBeTHCDEjgdXtIO2vG4oQHxzHYiUuNlF/Ur10dCIq7FtbA486
         IxDAx6IgxoNNCGXw2pm3AjvR3VM2U7iLJLNEreIK6umQoSCwrVoX8w/2kC3dV/Rsx4oI
         lsUKmhBBGJm4jDjtRmo99/hDvwOyXZeQ923G/iCRS/ts3Aaxg4GSLsCYfdM0YHoG3NTW
         e66yuu+v1GaPjzUgz+7jdVTgxD3Sc8EkJRyWIPOMkVEBAKPtdNWBrcerQ09QlkyG7ywl
         QdtcwbZJABlkfn6Fr5lUGiDQDH2a42hr7jtHMkthN9zEeMYFL6azCARlKPGUPsG8hXX/
         IEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071439; x=1770676239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BE4daa5nHLf/W7WnPK3owx5g9H3yB7xbYigFlzRc16s=;
        b=ICnh4rnpAx6ZdGkt+1GkhSxBrZyKMPSSYZ0nqsjGrO1yMTDbk12U5Mnv7d0eqKPRAV
         likWyhz0E0RAbstB8o3gvZTLExIu76FFWVlMTgjc2DzoIRNM/d29Y+pKjv1f6HoaWPo/
         P23i7OJidffGjHz9Qv4g1DMOvVt8vL8a/PkPfC9obBUDseFQjtQZM97YrAeaYniefEWi
         445QlHGdUui/PvhOa+LGdKSYj+CbEfgWj96dm6dJj7jCFq6voAe+EQ7ObOWENLLEEgSA
         bw6Tsfx1w5Z1micd5xZmuHKcYfVrgiDYXQblWXGzpXMnMTALiRfCSstiW9EL+hunwk1I
         yIzg==
X-Forwarded-Encrypted: i=1; AJvYcCVt9V3lhv/iA8KsTaqiftFdrOPy/C268BX4KwdKrNu4MH69vDWWHOmHS94wZeHpdtrxwdLC8tjbxoV+uU/Dcb9bGVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzU6o+E4jkmxlFO5PIn46K6sGmuE7UD3XYbBhsIPqMDD9XAPkm
	hTvwu68QkyRlxS4gDmKzggGq4OhZQrTqNMTKl7/d5uGMU/pr8kSkHnSCXHndGMJohu/sPbAUyAg
	iUIxz0FUdt5hkCIT/+RDRCAm5og==
X-Received: from pjqi3.prod.google.com ([2002:a17:90a:a903:b0:354:3742:4ba7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e41:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-3543b34fcbcmr12798795a91.15.1770071439110;
 Mon, 02 Feb 2026 14:30:39 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:48 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <3bf1fe4959858adfc2bd9138a2b850e9c837ab9c.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 10/37] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

When checking if a guest_memfd folio is safe for conversion, its refcount
is examined. A folio may be present in a per-CPU lru_add fbatch, which
temporarily increases its refcount. This can lead to a false positive,
incorrectly indicating that the folio is in use and preventing the
conversion, even if it is otherwise safe. The conversion process might not
be on the same CPU that holds the folio in its fbatch, making a simple
per-CPU check insufficient.

To address this, drain all CPUs' lru_add fbatches if an unexpectedly high
refcount is encountered during the safety check. This is performed at most
once per conversion request.

guest_memfd folios are unevictable, so they can only reside in the lru_add
fbatch. If the folio's refcount is still unsafe after draining, then the
conversion is truly deemed unsafe.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1cd8024cdb39..a9d12abfacb5 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -8,6 +8,7 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 
 #include "kvm_mm.h"
 
@@ -571,25 +572,34 @@ unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_memory_attributes);
 
-static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
-					    size_t nr_pages, pgoff_t *err_index)
+static bool kvm_gmem_is_safe_for_conversion(struct inode *inode,
+					    pgoff_t start, size_t nr_pages,
+					    pgoff_t *err_index)
 {
 	struct address_space *mapping = inode->i_mapping;
 	const int filemap_get_folios_refcount = 1;
 	pgoff_t last = start + nr_pages - 1;
 	struct folio_batch fbatch;
+	bool lru_drained = false;
 	bool safe = true;
 	int i;
 
 	folio_batch_init(&fbatch);
 	while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {
 
-		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+		for (i = 0; i < folio_batch_count(&fbatch);) {
 			struct folio *folio = fbatch.folios[i];
 
-			if (folio_ref_count(folio) !=
-			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
-				safe = false;
+			safe = (folio_ref_count(folio) ==
+				folio_nr_pages(folio) +
+				filemap_get_folios_refcount);
+
+			if (safe) {
+				++i;
+			} else if (!lru_drained) {
+				lru_add_drain_all();
+				lru_drained = true;
+			} else {
 				*err_index = folio->index;
 				break;
 			}
-- 
2.53.0.rc1.225.gd81095ad13-goog

