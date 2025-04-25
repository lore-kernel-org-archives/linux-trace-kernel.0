Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304281E;
	Fri, 25 Apr 2025 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540688; cv=none; b=P5PMaVAqR4PEXCpWe5/tuxeEAcN0Ly8I+10QiZT9Z6VCWa0fFQrEUa6tOMYhqtpUmlKbmYjC7gw3DxwR6KVJ0+u5w32SvT56g/V3KnzJmaWiVyf1+GsIDlT7W1puUvVkdQE4Mrd2JzsQpvvSKH6pZof479YDBS5f3QAXzrvRwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540688; c=relaxed/simple;
	bh=SxWFahHw+Vbx44SM7gqevX+c0LZFs/cA/XXQd0SyOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDC78Ki15+43EAxZdpBuliu8Llwi1dQPWPdbsDGdlDdfm/pUHo/us+KZFCRdfw4daXnQPoL45Vqf0quv9wGw/CDpC8CI2HUPPIY/03utO3494ZWBRc1tnNxKYaZho+LbDrtq5EQdcgLbQvb6lbazjsNnaedkgJwA8+7bSM0g0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ+j9dTj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ+j9dTj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224191d92e4so18493615ad.3;
        Thu, 24 Apr 2025 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540687; x=1746145487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdDgie04YT94hofK4Se8gOgrrxDraTQTaQsWIulcSTc=;
        b=YZ+j9dTjaJLLSTSDskeW+L8FccnKGqXsT7HW3H+MZjmcMEYVVm1NA18h09DyFRENfX
         YqA8UBPR4g6YhJe8qCH4l+larRn1YAxSNpI616yG6N+ZRyoGN6xOUqdYQ9pqbuL73gm3
         EzgTbDuIcaw2epNWBJjtlbtNfL96yCRzTIFHUeVVMQovjjvOtONypuM95cOFM6yzzqav
         8tLE3ElUOD/zYRvzrTmQ+x6St7kRjbTm7ldCJNgXJyzwaHS7NETTE3n8k+x3xrV71Ueh
         JV8oKNxjfyxVMWL2Wndqme/4ChmurbfJuZ1s91TiUYkVF6KUXfdTX8yz0+prNEDZEu6b
         gLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540687; x=1746145487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdDgie04YT94hofK4Se8gOgrrxDraTQTaQsWIulcSTc=;
        b=WiI0gwbCgcqDuMdrc3j11w8V+DF63YUtcjMX1dvhnyP3aow3f9OB8NYjyAMrQOz1lA
         YPMnn4g5VJwMJjr6NgDzh66ivf3ImlfrIJBitpPId5SBrJxC+rH6advZ2tgYFQv2sMYg
         +u5gM8q49juAJnqqPtD5eWNDTIWfdVdb8J9rETwKhmXhcckAldjCvJ9G7TbXY6TYDjNu
         W/yw7W8gdIDxzf9n7FVH3wIis3z4QIxidiB8sfSLz5GV3pMCN4vbQm4d36nZVeqPQkX9
         MUQ5TbMdTIEZ1BesfptvXE3MvYfjZp7D3C07gVVFLf1qHiVdtRbScGDQwG6iF5oZbafw
         WfFA==
X-Forwarded-Encrypted: i=1; AJvYcCVObr38kHWFL8/iuqs/l8nIxJlJB+iH45YaspGlb4h3+fIzxk3JeH4P2nsk2vN4LS+ZLVQnp9zr2bZKqi7sjLnDY3m+@vger.kernel.org, AJvYcCXDdERTty6KBqgyaSMfXfEL7fKNj6Wb+771D6dC82DXtHj9TkX3XebqKue4/Wi+VdWA4ia+/DA/CAJ3COQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50QFVoNVxYdGJoqPccO+3v3aUD1XENakud6ttRbstSvDNPW+O
	0KgotxyBuL9ZQLESg0yg215t/8ZkLZ29eo+h/UDkBqmeuQzOPJOR
X-Gm-Gg: ASbGncvUcJYwSalPJqvbH67H6m2kjL+HNAknsMyRP+Ou1Ya1x/cK5C2qXK7wrW7Rbbw
	ksDU7kmRrX3SFqOlKij3KWtIeLCyQeB09ELRAJa8bTGAYNTl4F2gAvh259P0zV2A29fiw0WlDAc
	BDf5K/XZ4uK2JxXQp5L6qGadfj32OcJYaMClLFiK3kdtmU3cyenBMhTxtElcBoFYbVrYCFuvPee
	ona/uoGoub4KYY2EedP+Su2c6hzfB+A4tgmkgv7P6/A6reEYGd0NuvI6N2T/M4NmoV+vd/h4wFD
	FYRDLMGyjvMWbklfrI+/sQnoWC1vRdTZDTP6T6J/zXlwYZJ3CG9bIaiktA==
X-Google-Smtp-Source: AGHT+IEJkK+Pw3d14MEGnhCGVT09btAOCFjpnGjogjrrHSUjdVqw+z2nGhNMyX4vmlQgZ4kb+bl9Qw==
X-Received: by 2002:a17:902:e542:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22dbf4d1a47mr4718935ad.11.1745540686617;
        Thu, 24 Apr 2025 17:24:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51022f8sm19956165ad.174.2025.04.24.17.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 17:24:46 -0700 (PDT)
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
Subject: [PATCH v3] khugepaged: Pass folio instead of head page to trace events
Date: Thu, 24 Apr 2025 17:16:51 -0700
Message-ID: <20250425002425.533698-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

The trace functions trace_mm_collapse_huge_page_isolate() and
trace_mm_khugepaged_scan_pmd() each have a single user, which
always passes in the head page of a folio.
Refactor both functions to take a folio directly.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Nico Pache <npache@redhat.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
v3:
1) No functional change compared to v2;
2) Picked up tags;
3) Squashed the two patches in v2 into one based on Yang Shi and
David Hildenbrand's feedback;
4) Reword the commit log to reflect the squash.

v2:
https://lore.kernel.org/linux-mm/20250418183920.273154-1-nifan.cxl@gmail.com/
---
 include/trace/events/huge_memory.h | 12 ++++++------
 mm/khugepaged.c                    |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 9d5c00b0285c..2305df6cb485 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -55,10 +55,10 @@ SCAN_STATUS
 
 TRACE_EVENT(mm_khugepaged_scan_pmd,
 
-	TP_PROTO(struct mm_struct *mm, struct page *page, bool writable,
+	TP_PROTO(struct mm_struct *mm, struct folio *folio, bool writable,
 		 int referenced, int none_or_zero, int status, int unmapped),
 
-	TP_ARGS(mm, page, writable, referenced, none_or_zero, status, unmapped),
+	TP_ARGS(mm, folio, writable, referenced, none_or_zero, status, unmapped),
 
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
@@ -72,7 +72,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->pfn = page ? page_to_pfn(page) : -1;
+		__entry->pfn = folio ? folio_pfn(folio) : -1;
 		__entry->writable = writable;
 		__entry->referenced = referenced;
 		__entry->none_or_zero = none_or_zero;
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
index 5cf204ab6af0..b04b6a770afe 100644
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
@@ -1435,7 +1435,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 		*mmap_locked = false;
 	}
 out:
-	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
+	trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
 				     none_or_zero, result, unmapped);
 	return result;
 }
-- 
2.47.2

