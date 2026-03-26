Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2143C141B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568224; cv=none; b=NcCCdSPa8PYYqIbsg7SHMOzGQt0248TOAE6tppYh9epHaccl91KxNV1JJfl24Ksi3NECvgHt8OKbtt7AOBGI6MGf5ihddcQHSvNr9i2M7lYtvG6QdrZs/+B71I/xyoTLAl718kWG4J+g1Agn3yQNUzzaPPoI1JXjDRyBwMgkIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568224; c=relaxed/simple;
	bh=67PPqaBy//OQSBGV93iqgx/DKTPKDwts6fJzTCKk2zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b+ssDDNtD1cbjo5YY0jubjW5K7HXR//p1amrj/XjsAS2+ixEwcR+ZbfyG1SJtIz+PXOGHMu8W8dr470NmaN5/95WszpOVWWCJSoxtOTFlj2kqZdkTsU7cC/iyp1TS4vF/UqacK53yUDev1uUAFap6f11MJv/pDeY3qwpjBTQQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQIvjIcx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQIvjIcx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c38b85c25so2799793b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774568223; x=1775173023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=anFkcCozf8v6Cel8diSJv50ROa2IxgRDEcI6Q1pEpvA=;
        b=jQIvjIcx/3DSg5jootqahZIkhPsYoTiOzhhypNFZDQopjCoakStTsfXjmF6BGrMkNh
         BYGXD3N3EEI0EwaWNa437DGPFhZG/XLiBFR4ZqFGDp3FF4YnvK7LGVSG96U+0cgsRB+d
         w1A6En2q1IHf1yIqrUYvVOIwJ11OE//VI14UogN6CihCw0iilkr77EAXQsCRglvsVYkP
         vVk1PcbvL6ImfxMc9uvuVIMvyKXGlJfeEy3OeWoLRc4sl3aEkxfvzLgJjbqpTZ5ekURh
         1lTJ07JiAfI9aF8kuGZXekjD92CJ+x7R9z7kAF18MG+z2byw9nGYiu+EjU7bXnzceXzU
         Or/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568223; x=1775173023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anFkcCozf8v6Cel8diSJv50ROa2IxgRDEcI6Q1pEpvA=;
        b=m2qgzoAq03CNN5hawH7iXO8Hj0HYyOYmS3tZLRgi+moD5Isto4YFWx4/d2NPE+0nBL
         5mZJart8rwv2dz8fN4cgk+bH78mneUgRFptnZdLzvwMPOvtnyn5GUFhj9Wwqa/SoZcry
         RdfrJ59c0TnBm8B14IcSAJ6HsRLF7DCdq2dV6zYzkhyr4DSYg/YKatwzXnVxXw2tzjBf
         XT5QaJpV3zZIWrtsMLOz2L4/I3jo0IyLtLTq6nQFpOw3u8q/3pAUTRRnVLjmjP8PDNWk
         y1YvXLpLw379feEfeK/qBwbxgyu7qnXz7exX2vqc8zOsxYfUvd0qG8OHz9RMH03go3tA
         el8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhbfoCkGWj3rRxZESPiDi2//zkLjEG5odS00pNr3bGSQimJMO2JJ/+dVJ3IamY8SGgCJi/UnNxQdjoyBKnFV7lSoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIir8A9i9W0IlBNdXUU1+q4j9hkzn5GNDTLbp3pZott7QMQzw
	Ye/+1RhKyCNbeRDLO0G/N73XWga7KF3nCzsFHyt582WSWpkJEdUotEoVZg7XhaX7eYxgPG1Fzam
	YDpoo4KcOHgJzDN/zJdWeA9CI6A==
X-Received: from pfbbe3.prod.google.com ([2002:a05:6a00:1f03:b0:82c:70d1:f303])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d86:b0:823:1212:8e87 with SMTP id d2e1a72fcca58-82c95ebf212mr318666b3a.32.1774568222396;
 Thu, 26 Mar 2026 16:37:02 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:36:40 -0700
In-Reply-To: <cover.1774568083.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com> <cover.1774568083.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <a31bee8e57f464078672a95b638724e1cad423ba.1774568083.git.ackerleytng@google.com>
Subject: [POC PATCH 2/6] KVM: selftests: Call snp_launch_update_data()
 providing copy of memory
From: Ackerley Tng <ackerleytng@google.com>
To: ackerleytng@google.com
Cc: aik@amd.com, akpm@linux-foundation.org, andrew.jones@linux.dev, 
	aneesh.kumar@kernel.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, chrisl@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, forkloop@google.com, 
	hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, jmattson@google.com, 
	jroedel@suse.de, jthoughton@google.com, kasong@tencent.com, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, rostedt@goodmis.org, 
	seanjc@google.com, shikemeng@huaweicloud.com, shivankg@amd.com, 
	shuah@kernel.org, skhan@linuxfoundation.org, steven.price@arm.com, 
	suzuki.poulose@arm.com, tabba@google.com, tglx@kernel.org, 
	vannapurve@google.com, vbabka@kernel.org, weixugc@google.com, 
	willy@infradead.org, wyihan@google.com, x86@kernel.org, yan.y.zhao@intel.com, 
	yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Call snp_launch_update_data() providing a copy of the memory to be
loaded. KVM_SEV_SNP_LAUNCH_UPDATE populates memory into private memory by
first GUP-ing the source memory, then encrypting it into private memory.

The hva that was specified as the source is in this case also the
destination where the private memory will be placed after encryption.

KVM_SEV_SNP_LAUNCH_UPDATE requires the destination to be private memory,
but private memory cannot be accessed by the host and hence cannot be
GUP-ed. Hence, make a copy of the memory to be loaded, and use that as the
source, so that the source can be GUP-ed, and the destination is still
private.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 35 +++++++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index d3a7241e5fc13..1b937034a5c11 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <stdint.h>
 #include <stdbool.h>
+#include <sys/mman.h>
 
 #include "sev.h"
 
@@ -31,17 +32,39 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
 		const uint64_t size = (j - i + 1) * vm->page_size;
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
+		void *source;
+
+		/*
+		 * Is SNP the only place where private=true? If yes,
+		 * then we don't need the private parameter, we can
+		 * just check if the vm is SNP. Or maybe it depends on
+		 * whether TDX, etc use the private parameter.
+		 */
+		if (private) {
+			const void *hva = addr_gpa2hva(vm, gpa_base + offset);
+
+			source = kvm_mmap(size, PROT_READ | PROT_WRITE,
+					  MAP_ANONYMOUS | MAP_PRIVATE, -1);
+			/*
+			 * Make a copy before setting private, because
+			 * snp_launch_update_data() needs to GUP the
+			 * source, and private memory cannot be
+			 * GUP-ed.
+			 */
+			memcpy(source, hva, size);
 
-		if (private)
 			vm_mem_set_private(vm, gpa_base + offset, size, 0);
+		}
 
-		if (is_sev_snp_vm(vm))
+		if (is_sev_snp_vm(vm)) {
 			snp_launch_update_data(vm, gpa_base + offset,
-					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
-					       size, page_type);
-		else
-			sev_launch_update_data(vm, gpa_base + offset, size);
+					       (uint64_t)source, size,
+					       page_type);
 
+			kvm_munmap(source, size);
+		} else {
+			sev_launch_update_data(vm, gpa_base + offset, size);
+		}
 	}
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog

