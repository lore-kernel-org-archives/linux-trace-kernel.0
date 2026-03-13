Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BA347BA7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382388; cv=none; b=B/UlWmjCj3M7XX9/uUckb7wJuKDSJ1S1N0ZXV49Vwc3nPT9Tkukvc3sbNorzYV4owQ6/RVxqKZhbW3uWoT7G6FdtLFUorm1IO4SHofpouvKEqdgUFDydDUAhAW/eX4W/jBh3FGrm+cgGyafo5VfnsmSIC0VjJnBG4pgGJdyEWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382388; c=relaxed/simple;
	bh=mOJ8kGxeDUajA7ZMCrZoSsh4f2uVT7I/AV/dLdGVkmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hk5WIpq3U5ncPaKdsHdm93AcV76vfSB4edccwiqyjEFWZODTviT3O6YkmUxzEp8e6FsGWbVcmNlrqbbmdbmrUVbddJxAVnP4glOfsuhojLfaf1y8Lpddh2SbyHr4RQpCKS1wVbeZyZzkgAIX3lNT4NUXC7AlHZtV7mg/jjqnIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ra2wntBU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ra2wntBU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1327311a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382384; x=1773987184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Axi0INWC8775c3KWZdhtJweqpQD38EitbVRhvmpW8ao=;
        b=ra2wntBUa0WvAVXCBtC+xWiN5BvNR6Vv5ps/ltxa0RP7pW3nZyvfHFWEJ3yV9SyT7o
         8YyqAJFXwXk8oO8lSHtgI9qvX+hWjmlq0QmCELgOIZCSt49Lb8478oY9ajeybtKje52O
         TM+N9/bpg+A2floEdYloHurj7Zu5PLzudI9OXbaaDNczpiVKLErv8jFSTx4MKrRmO3ZK
         lka76hYtGuauhct40o25V+zrRmZjVA199qrqrGOAJnnJRd2690KjlU1nU4CwbrceTyfL
         r0bHUwI0xpV77HjYlzXcAp7UaUuXgY5JhXaWkGVG8goOP/U4isppPfBBhBicDx9Q69/y
         iuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382384; x=1773987184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Axi0INWC8775c3KWZdhtJweqpQD38EitbVRhvmpW8ao=;
        b=p3iqUOdx7krBDy5Ji9NYC9gyoLuaKbCezBu2w/pgxmA4L+nyHLEJMRINbpnZZvKKk1
         XD7VWTqQeQrg/RonNE3P0XtEAvQNfqQYWXRpHUx9pO7FgzpS5JOx1QXmKoOM4VoqYe8w
         t0SvZW9bJmpgzyEbvkr6Pu8gJtdyL8vOul0V3zO8eIeW3kvHriWRMzuRoDt2Eapah+Ts
         JjXbZ/4CQGlckRS9aOyoeVVdmfgx+wkCluP1yoInGPN4UiuCaByVCvsOeQU22/7pW8jC
         xapDS5+OqsDvLivpRmyw2yJQoPOZiXE1HiwZM2XVDmPvcJ0HgvgBI1fLxyxszyQJ/NUc
         QtqA==
X-Forwarded-Encrypted: i=1; AJvYcCVl+VfYVa63TfQ4CziYQuuFNB9ayedIHct4L9zMvmrJV9OY7cgBISXww3ImVfh80Jd39Q8ib1NoWt12IyRFPu1Ipmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWx9XxEMt0tQ41SMWDXeVpgHDYDs7vITSDoz2/EWQ5YAicinL
	/F+LsmIglbIaS11/48GpdfCZJiLiZMfr8RPZYc7NZMe17hATzvFY8T2RK8zYJneF3wE5FRbA2Nb
	3Y+w4A1vhGNbZJfzkLOMUham21Q==
X-Received: from pfbbk3.prod.google.com ([2002:aa7:8303:0:b0:829:8ed3:28ba])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8896:0:b0:827:2b00:4b21 with SMTP id d2e1a72fcca58-82a19928c63mr1524473b3a.66.1773382383877;
 Thu, 12 Mar 2026 23:13:03 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:49 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2649;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=mOJ8kGxeDUajA7ZMCrZoSsh4f2uVT7I/AV/dLdGVkmc=; b=wUIAgRpe7+Dc2qRlSZCPcaqsTtORZWK/ma9UgO/87UOqCWKJD0He/Y+AdDVBXawVSe/fkrz4x
 S2WgoE2yvXtDbY3e22MPOONlu8velunLn8nfuPhosOQ3omM/tX6pEAb
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-10-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 10/43] KVM: guest_memfd: Handle lru_add fbatch
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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
once per conversion request.

guest_memfd folios are unevictable, so they can only reside in the lru_add
fbatch. If the folio's refcount is still unsafe after draining, then the
conversion is truly deemed unsafe.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8e4866bb8145d..c4f6bdad6289e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -8,6 +8,7 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 
 #include "kvm_mm.h"
 
@@ -566,25 +567,34 @@ static bool kvm_gmem_range_has_attributes(struct maple_tree *mt,
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
+			} else if (!lru_drained) {
+				lru_add_drain_all();
+				lru_drained = true;
+			} else {
 				*err_index = folio->index;
 				break;
 			}

-- 
2.53.0.851.ga537e3e6e9-goog

