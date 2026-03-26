Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739637267C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563889; cv=none; b=KdSlMaeW7wmbeAeKOU6TWXsb1RqhVT9AdOrTc3UnVUt2TWXiIfvUaz74hIHUa/5ozU9ruW+l4m4573GiyeatzgAvN5k2xKxCaBapcUtk9tCemEJaM8t7J2dHEPRK2xP7qTAVATRMsHQfim9B9OxErhVOl6YstDx7DK7tPk2QbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563889; c=relaxed/simple;
	bh=ZJiMvoi/meyCAH/H680tKhOQBTf6lB9IuvXAsiQfyOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X/X01s+XLPnrOTAtR0qT+hyz2lLZeCEd76+9KE6Rhg5tiwtn5aemWHBFK8ngAlvG0NyQt3EOwEh3i0Ew2EeTxWToPWvB+60AI4vrFL7IJv096HW8fWdy8hkf9Syh7oRKQqqdLC/E6O6Thyq8Bsz4yyWF1/sSKazeK55bZ3H5V44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlW1WYtM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlW1WYtM"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a782029b7so1139492b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563887; x=1775168687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCgdcXsysKW/U1BkGMVZDbqNfZApi8yNye51/HQjjFw=;
        b=wlW1WYtMen+85IuzAwD6tJEeV3Vs1WkPAcGyMqY9OxMnX6obAabC7yLAe7qx+pNAvn
         cMMxpxYEaJ5onRU6LUUN1WB4CgovlfFDksbYllNPnlLU3+BjHajCHY2/3XySFgsI2K0N
         sWoIP/DvhKOzzqhGmQyk2Jr3YBHnmJnX24/eBT0++2y6u3Cem+AlJUc1nFx1UE53dXeO
         GXFgy2tQyXs4Xo8JUgmZuUKuvCIFOEGia2HX8M65qn1f6KC8TYI+PHuceozL5iOrcfed
         r9NWSmwxCSa4lrH/2SHunV9shQdCMmpgJHph6rlBlTXBKwSRpwf1CfUdpA4rR3dTt7jG
         0miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563887; x=1775168687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCgdcXsysKW/U1BkGMVZDbqNfZApi8yNye51/HQjjFw=;
        b=g5ia/so75o8CpJ8x66CzY4RhhbGBVNOk8lYPkTUeSfTzOWNEN3MJVpf7FPSEYrI6Kd
         rxbJvP9VqnjXtKEI9qOsEIL46I6z+eha+aA2MQg72y+0TrYSUYSyu9ipK7slIOcgls72
         ip8VGx2slbb8B39xHcswGhdr/1okEsBAPKAJm1RnFaKtnTtTr7SRx+CoFt80wN7bdD8i
         d5Wf/NZBImWgIjHOVAYTw8QRh+0AIYb3AMRJ3e/T0TDAvSwqvjirIZc/+9DFy9BkWxY5
         pXBOJ/h+LF1j5yly06bUDPAsIl2w/X1YzA2mMQIyMB1kAFEPf5TJBBHo3KbW52CaFP00
         3qXA==
X-Forwarded-Encrypted: i=1; AJvYcCXw4mm387KZa7l2qi5KFAYts7UVu52KNxKW9vkRzMUZ5DH3vK3+Y0B1I5kM76KrOJOTE8Kg1zl6o8cBIQukjGFA1Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/MzTA9+ihRvsgozbOxmMuaemoRPGUgh7PxaOH/JxfsVPb61A
	wdTjNV5dnX0mtBD8mIUj3s7mfNGrUhngQgj08OK+BqtjSPUNDh22KI5ym5v+4gdJhl/5KRM2d3o
	ZrLuKns1vV/63SLxwGhLxqmLViQ==
X-Received: from pfgt12.prod.google.com ([2002:a05:6a00:138c:b0:829:7493:545c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c96:b0:823:12cb:f5d1 with SMTP id d2e1a72fcca58-82c95d35b57mr160274b3a.6.1774563886617;
 Thu, 26 Mar 2026 15:24:46 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:20 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3273;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ZJiMvoi/meyCAH/H680tKhOQBTf6lB9IuvXAsiQfyOo=; b=WRe5ynfWZSuX+kx9jMY0JasXB4rIPKpI9ql6ibZPHFbe+yzbcDGcpqU1uX+402hGD156NdMiH
 L7DiNdokHKID+cbe2SXtvZ5GHdpaoaiPi/BbdGDX1VVbt0wzzcHVT/X
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-11-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 11/44] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
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

When checking if a guest_memfd folio is safe for conversion, its refcount
is examined. A folio may be present in a per-CPU lru_add fbatch, which
temporarily increases its refcount. This can lead to a false positive,
incorrectly indicating that the folio is in use and preventing the
conversion, even if it is otherwise safe. The conversion process might not
be on the same CPU that holds the folio in its fbatch, making a simple
per-CPU check insufficient.

To address this, drain all CPUs' lru_add fbatches if an unexpectedly high
refcount is encountered during the safety check. This is performed at most
once per conversion request. Draining only if the folio in question may be
lru cached.

guest_memfd folios are unevictable, so they can only reside in the lru_add
fbatch. If the folio's refcount is still unsafe after draining, then the
conversion is truly deemed unsafe.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/swap.c              |  2 ++
 virt/kvm/guest_memfd.c | 23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index bb19ccbece464..4861661c71fab 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/kvm_types.h>
 
 #include "internal.h"
 
@@ -898,6 +899,7 @@ void lru_add_drain_all(void)
 	lru_add_drain();
 }
 #endif /* CONFIG_SMP */
+EXPORT_SYMBOL_FOR_KVM(lru_add_drain_all);
 
 atomic_t lru_disable_count = ATOMIC_INIT(0);
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 0cff9a85a4c53..20a09d9bbcd2b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -8,6 +8,7 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 
 #include "kvm_mm.h"
 
@@ -571,25 +572,35 @@ static bool kvm_gmem_range_has_attributes(struct maple_tree *mt,
 	return true;
 }
 
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
+			} else if (folio_may_be_lru_cached(folio) &&
+				   !lru_drained) {
+				lru_add_drain_all();
+				lru_drained = true;
+			} else {
 				*err_index = folio->index;
 				break;
 			}

-- 
2.53.0.1018.g2bb0e51243-goog

