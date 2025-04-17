Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DCB254847;
	Thu, 17 Apr 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910313; cv=none; b=QDBYn+fYK8ruizUABdc+tBCxHSevErU0RcEe6t4I2o9kqQCZhr6TjVCQAxP/Joj+vnliwhgMlAwuY56p3fuccF2sj2iA3CftlBectj5pY4gAa/N68x43CwtPK6IKgUAguhLLDu3eravETAlOrFwvED7Ek3QAHM73ikWResEJZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910313; c=relaxed/simple;
	bh=ZWGPCFLXwQmWCtMk21W3pPoAhQXWJzLQY0D+f4D3Frw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZCIQmyF+QMJ8Hbb5Z4mD0Hr1fXtMaJM2OaBX4M2/K6VrfPGZTMzWtphzB5VO2m8nigvUTGsZ55jU21VAmumdUxuKnXAgsEW0RG1PXfqkE33yNEjBIojY+l15XtKteAqha1GgqtxyZFRQSrdQ3l2UrITIBaYbMMSRi7htu002+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S64FhFOM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S64FhFOM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c336fcdaaso13501725ad.3;
        Thu, 17 Apr 2025 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744910310; x=1745515110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij1VYhkhfoRdpQc1o7qdcqhwt77zHhYQwyqkQvp1cKQ=;
        b=S64FhFOMuzFBJMcXGsfpBbrwXcm1/J6hyWgesfur9PH9DLNVzUoKrCOESBH3+WuVn4
         BdnkODPm00i2VhZ9m+lI05HEreB9AaGkTlNXOF5Oig0Zl1k+U7EQyK4sxWOkCvgxAwiu
         PP/QRiHFkzx8wr8J4nJPoH00hCPP/aDyvMgKbCkeAQa/twkUZ08H6PbBWC/SgrE1u7l3
         cL+IWAfD7uR19fuN+/BAtby0NS53Paj2rdi/fIPkF4NSliEKbE8xf4kzGaavJzBkCwV3
         fs53GfrtzmsbV1bkmvhaN0POpXa4PiPslqZYG/j3HVMonnBDdWeEAiOQ+ayrOKMoRjaC
         T3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910310; x=1745515110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ij1VYhkhfoRdpQc1o7qdcqhwt77zHhYQwyqkQvp1cKQ=;
        b=o77/u1NrnTWLPjcy/RqZ6luGTMZaS1sogrhRY5fLUYo/p0xnAHS/79ObeWQYeRN5S0
         t2luTnOSEpRmXlL/pJKifhDl4ZV7A45C/ffAr5Rad3jBqEsCzIzwO/VwmEXiEb1kONHI
         3l/B4gB+x6SMvjPQYZPGhoc5sAbPyz6kGlTCeynGd7V6MA8nM5pTwrEYeJouykqUxor1
         vU9Jdjxk5/fV6dkYu49qrawsgYKwDP5HFGS43jjPTqkf88SROOqt5xIr1gmxLVzbl0Ul
         bWgLHFyYGA8/uAT8wUn5CcvpfrrzSaXEj8lKi/s8a/Xjd52BOV/XvEzROks84+jDvUDd
         nGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWLhhbbX9g9ccwZ4OQ0eJxzXZUTTMxLFaiGVQxl/PmNaWd69stPqT8ra8DaqxcGUAR4vf9Y3FrxdfgvRBgfQhV37pg@vger.kernel.org, AJvYcCUt5A/16oXUcxm7hX7eb0DeRmLOxSKJ5yCpkVnq8GTCk5fw+Hn56BB7FRD09UepQFO31tTrWHB/2d/VwUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEblnqyLdcFT0Oj2kaCbfHAdKrGWZSXWw4C8xjk07fgZ9dN6K
	mTV8gsGSDNZ3oh6bi6Pa5ZPY1TG9bM5KOJAJTyCYToHg2ghZfedW
X-Gm-Gg: ASbGnctAhR2Isl9geToOLkdu6HXggHkJH3ljPqbCBNFvZwniKas7rknHg+ELSnQ7v2H
	sNMbCWMmAJjybGF988U9kNyrbQLkpFMHn4TI9//Tp66hCwuEuXTvXqqOXZUuyAnokO9+cgulrVb
	nE4zWtr6xavpy9kPiMJsn+ukxjaaRcsYBfZN48CLNPLV6hm/gEnqd8hCw+s8EZ2fPmoNpX7maha
	Avqi+WbE7M9WZAzFyc/lGgdAqxM1fQUVYz1FR6UYcjsNOmsnWX6aTOh3u1bEDELDjeEHz1M1QmG
	p2QNvF+uqF0LSxJxtMhKzJvz0XKNezCd9Fqw/l8JeiLYCl+TlWidkxZ7mA==
X-Google-Smtp-Source: AGHT+IHBxp0iLO5I1CTrBU923VZfaA0H2tWVL2x/5yftFykhou+NXEhiMf6ukkG7qWzsj3770MK+zw==
X-Received: by 2002:a17:903:298d:b0:215:acb3:3786 with SMTP id d9443c01a7336-22c358ddbd0mr96860635ad.19.1744910310391;
        Thu, 17 Apr 2025 10:18:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eceb74sm2338555ad.166.2025.04.17.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:18:29 -0700 (PDT)
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
	dave@stgolabs.net
Subject: [PATCH] khugepaged: Refactor trace_mm_collapse_huge_page_isolate() to take folio instead of page
Date: Thu, 17 Apr 2025 10:17:11 -0700
Message-ID: <20250417171758.142745-1-nifan.cxl@gmail.com>
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

