Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765521B9E7;
	Fri, 18 Apr 2025 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001589; cv=none; b=EZHe+E6oclBrbO12w09juaSZMVVx6bIFeLHMJoZoWBvPEbARrTjI0pbRPK3D3aOf+A/AzdXz3cyyN8T/QVRwl/1wj0Y8hjpAZyTzbMxyZcNVr01bGRpOvRt1ZuRtS+kDaglQOBY2WjCYh6MndgsByyPf3UxBsuLB34S4cuUxnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001589; c=relaxed/simple;
	bh=iVUaD1HmlHhqp5RNnB8H/wmafvbDegbiqzqranowsMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvCGwd/AO8sxgPRCrj0kB7MDqji0pIwXwxLVLvQnGV5o/wVaYb+QmdgqIShn4ZNI2+5VrzwvKVJ88VjvIfoCltSE4JKRg0QobhYr10fJ5H0K/TB6QAsE6s39/9N6NuPcUY2Gh+h81YSgkasmehLRpKDcoBnWjkuheCgeo1iMhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO/3e+XN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO/3e+XN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33e4fdb8so23711505ad.2;
        Fri, 18 Apr 2025 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745001587; x=1745606387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Goqo2j6Sp0E4BTDR+tbGqecfRzssVKsfJF5DD6KEUQU=;
        b=nO/3e+XNIMqcEjSDIo5qXAN1PbuMAMQO43DNpc2Z/+eu05YULuvdOHqTXiSTOWcIT9
         OEc3NdgLAw4bFcKv12LnEHtCrjZw5PHqg1rFDNpzNw46NUx7AtFjJUPt+XFayI2SOab5
         sNjZCfV3EHSHfRT5EJ3TbQCAFMrWVhFvJLstqBUEYJSUGWFuN7/7xvYZJYO3iRWdjQ8l
         KWPi6QaWL0t9M9nkPNB7rhsDt5cwfsy+tYxADTB6hpMFVfX9+GiBpx5pScw2UoGoOdQY
         NP/Vd0g52MLuHKIzflGu7H2bv+Spo1g3StANqIWl6leQO9MGevNTbV9WFD7j03SXfuJr
         KGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001587; x=1745606387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Goqo2j6Sp0E4BTDR+tbGqecfRzssVKsfJF5DD6KEUQU=;
        b=ZRqMdvOQ+z7Gy/aBagzFLSvcPboJWONn/8tqJSpL/MLFABbMnMJ6cF4didpqdsIDw1
         jkajJO/opb9iT524qEaAgAqbBUwG1ZfMglSQlSVeCMpFhk+EJnH6WGcTJi4pov7GnJOu
         QPJNuqSYrVpgqLhk2pZMCN+pywrHfJ8b7qHM8uPN2fXWA2K22Tcgh7T118b+HQgHuLB9
         JWzTFmJMZei84I6aNi0vxTnfmUDVe6+0649cf7nROcUKNtJvsG8u2p6ZpNztxqJBHVFp
         3yr2yBCXyXLLwvW+HgD7bPzf9izxamD+0g6pLWIGJ04HqqqfapG77Sj6thgokHBdO+iw
         GM3g==
X-Forwarded-Encrypted: i=1; AJvYcCXDyGxhKX86zU/lJ9+33IVe/cKehkprWGYbNZRsf9Thyq8sD/QHLQy2fyJMa8jS3eQxjN5d47X7Vw+tnIrci928s70N@vger.kernel.org, AJvYcCXKWWo7NYivvs1jJFfFv3jf9P74gXyOWah6zFd5V9lAo6WWRDygYRe3UNF63XsNsa3BeH1R9sgoqafZNtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1XVXtVAJOnGwliVt8XXUJZTeDzQIjYJlGa5nUTLy2Ohi9L2i
	bcD+nTHxzDLdL1crSfcLE3hwlTXTLLbS/GpdvQXLVw66a0gsPsN0
X-Gm-Gg: ASbGncu4tsmqzKqwY/k/oLHEd2M+ry9lv87p1J6eqptdFMZs+itizOqzXfNUsC1tKvH
	MroxH2ePz2/xd089Qv5haBmM/wXkUoAUTMFYY569fj/JGtxPGxcadpkTopd8RtBk19UZQgDHyHL
	Hg/Ne3q+KIVPdfLHeCFTbMv6jS8uP559uWiYbQ8Cjk5NM+WZj7bIoD+O5dyaRsBWWhKgDkVzML3
	nmwnmncenllSl0kpJZe1FpeDoVgNaE8W1Y0qHs3GksaF5bGoNlWCT3ZVEt8+X/MkNJIe1UQjJ/X
	pw+QMRMtNRnSiveSA+XQqe0gl+wvRp37AMGNMZ6M9WNwHBRPKSo7t2kgZw==
X-Google-Smtp-Source: AGHT+IHRJWWaKfQtg/yMVMqCi+pENNAPIR5/EfTc8Fd4qzR2x2UpCcVE/69Mn2/dX/6szddjaNNghQ==
X-Received: by 2002:a17:902:ecc7:b0:220:d79f:60f1 with SMTP id d9443c01a7336-22c536151f7mr54362385ad.42.1745001587053;
        Fri, 18 Apr 2025 11:39:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb463asm19865975ad.141.2025.04.18.11.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:39:46 -0700 (PDT)
From: nifan.cxl@gmail.com
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	willy@infradead.org
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	fan.ni@samsung.com,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	npache@redhat.com,
	mcgrof@kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nifan.cxl@gmail.com,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v2 1/2] khugepaged: Refactor trace_mm_collapse_huge_page_isolate() to take folio instead of page
Date: Fri, 18 Apr 2025 11:34:20 -0700
Message-ID: <20250418183920.273154-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

trace_mm_collapse_huge_page_isolate() is only used in
__collapse_huge_page_isolate(), which passes in the head page of a
folio, so refactor it to take folio directly.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Nico Pache <npache@redhat.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
v2: 
Picked up Reviewed-by tags;
v1:
https://lore.kernel.org/linux-mm/CAA1CXcB06JD9Fp4c7GGU3NHEm4W-aV7TS7JW7eWxshJEM4t2_w@mail.gmail.com/T/
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 9d5c00b0285c..a73699f000de 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -116,10 +116,10 @@ TRACE_EVENT(mm_collapse_huge_page,
 
 TRACE_EVENT(mm_collapse_huge_page_isolate,
 
-	TP_PROTO(struct page *page, int none_or_zero,
+	TP_PROTO(struct folio *folio, int none_or_zero,
 		 int referenced, bool  writable, int status),
 
-	TP_ARGS(page, none_or_zero, referenced, writable, status),
+	TP_ARGS(folio, none_or_zero, referenced, writable, status),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pfn)
@@ -130,7 +130,7 @@ TRACE_EVENT(mm_collapse_huge_page_isolate,
 	),
 
 	TP_fast_assign(
-		__entry->pfn = page ? page_to_pfn(page) : -1;
+		__entry->pfn = folio ? folio_pfn(folio) : -1;
 		__entry->none_or_zero = none_or_zero;
 		__entry->referenced = referenced;
 		__entry->writable = writable;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b8838ba8207a..950d147cd95e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -696,13 +696,13 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		result = SCAN_LACK_REFERENCED_PAGE;
 	} else {
 		result = SCAN_SUCCEED;
-		trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
+		trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
 						    referenced, writable, result);
 		return result;
 	}
 out:
 	release_pte_pages(pte, _pte, compound_pagelist);
-	trace_mm_collapse_huge_page_isolate(&folio->page, none_or_zero,
+	trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
 					    referenced, writable, result);
 	return result;
 }
-- 
2.47.2

