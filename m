Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606E223714;
	Fri, 18 Apr 2025 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001591; cv=none; b=ok2b8ev7jat2Y1AeJpw96KTJq75mYq5gfwDKugqJg1rSVZSNhe9LwkHtZ6ZVlXcThDIFY8wxuJAPr8eaL01aEt3LFxt/NLIT76GxMYdc9lqr9w7k5/6eJkeISZmXLsFiLxkIC0NjucoOHo25i+tnvBVlldy5QXjlmoKjgZXjvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001591; c=relaxed/simple;
	bh=6juepKFv4RywNtwgcmI/f75Aklx8+K5bnw4Dj+/y12s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXYf8vRhXAwkBw3PnFi8EvB7mKjTfHUXWCgyVmTaOL2vlAQHDvEopGIjt/Skvbt9vpbwHiMfhFsCUA+5MSJMf4Tyrf0afcg6KM+DQUKhh7zlPrckr/+Orj09LHbAzghdAU1WLoE5/EPy9Qeu7Is1wsiNvaEjUBWAV5bvyrzrcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4SpVdkR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4SpVdkR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33677183so25851985ad.2;
        Fri, 18 Apr 2025 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745001589; x=1745606389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBweR4rTJ8xooFIdJ7YeYYJqxBwE2nrrXL4nmE835PA=;
        b=I4SpVdkRiLd3zOd45eQYVFFSoiLm8SzSBvJL1OS80djGUiVAkn/l61IdiH9zJIs2G+
         gMKxQgvUVuFa+E9k2+4Ra0vHhyqt1bN0psJ9/f/tXudKCsiAaykXi76of679WW+ffhZY
         xslnGd9EILdOc6cquopJ1NhCg4nSxJ2t3OgB0vr3ewet7CEOOF6bgwWbZ1GObLQZGL6X
         xnp30PEJcUYZkxRsi83kvZfuujEyyU3sJc/9hs95v6cqVLugi2L69SoY1ptB+JpP9P49
         n+FrBhf9LuOUXrPpxC1DsROa2UuyQeVGD5WhCDgADsoBPvJ1dnejp48hQn8FBkgGvKyF
         JJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745001589; x=1745606389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBweR4rTJ8xooFIdJ7YeYYJqxBwE2nrrXL4nmE835PA=;
        b=o0MSLMd6DdOMFp8dXwEqV1yHI6L0WCZjfeRedu+JGxizHk3fE0gbgP8HKgMKWaUIKD
         QQjPyVJ1642iimDY53nQVpeKM4ClvG++nEMZhc2isoT6eGoeeL3SghLge/Er+aUB6Wxg
         S6asDQ/5/dnyfJD4+f8Ed27HAk83IQZ3aJvaVIfEP3/4PFZ0D2hsxpyYNa6/4kjMA6Lo
         qX+1jAHAxt0bOYfapqZdRqPMKo7x/kTjshTN77tcqv1x1q/Jc4pAzjYujG3jqaoBAJHP
         06gjG/g2bZxja02tTxkVc/5te59HDNC+SIZblfU5B821rtez/kiwYt19FocnmLLeCCRn
         vY/A==
X-Forwarded-Encrypted: i=1; AJvYcCUmKzr9ICr7IUvB2+kMxLZhkcRFtq0aeZleFKLKQ9lZf1uNoMtk2O4pkmXJHukrqwJ4OkbwOMYx0WsFOTY=@vger.kernel.org, AJvYcCVy6dJrzwfZvVe8FeSZoh1LjJg4VcBz168bJJE4j8c6xh4C2VBBWEN40RPoBcckLKinXW/d+WloN0Zx6bOMMkQkifu1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9Ro0M+Zs7WDp70Zson65EFxglvT2YXCsZC+x6RFHv9tganXe
	pfyqvWMy1NLTSY08uNEMcX49Zi20uRh7STJlEyt0fHioq3uHe9xT
X-Gm-Gg: ASbGncs8tQwAUvm7P7Du9A3/M6dHqSOtBzmlwxa+mi8u2AJwH3ukrOLEx+os2qCF2ex
	pymPJM7O4bTB5VMX/r8GMg2k2lH6qZEL6roK2s7cR6EeD4IcZcZ8qR8wqoAmfwiR1bsCyhHo6QI
	4D8GXDNn0rXSY0LkHDI9QKbzhS5j7QiXiPyiHWxHRmYk7QJS9umGAIZ/4dUFKMPnh3EGJJx9TqI
	CUlrYnQ29pBL/e064j2Evt/dK3DbY6Cth+ZkMSSffaXoYCg9IkUVfMAAvvd4gzBX1f4cRVaMTPI
	8A6Xi1URTrRE5GlHErKD09qY3nap+ngPqJUkkoyWsRQR/MTxwYnIvxZusw==
X-Google-Smtp-Source: AGHT+IH0QQVSCe093WxypD9TiHYn5zBw641C72UPhrYsVbLtBpDzuseR11jm6ZCrap9yZUzE4ken2w==
X-Received: by 2002:a17:902:da91:b0:21f:85d0:828 with SMTP id d9443c01a7336-22c5360df09mr55964225ad.41.1745001588878;
        Fri, 18 Apr 2025 11:39:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb463asm19865975ad.141.2025.04.18.11.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:39:48 -0700 (PDT)
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
	nifan.cxl@gmail.com
Subject: [PATCH v2 2/2] khugepaged: Refactor trace_mm_khugepaged_scan_pmd() to take folio instead of page
Date: Fri, 18 Apr 2025 11:34:21 -0700
Message-ID: <20250418183920.273154-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250418183920.273154-1-nifan.cxl@gmail.com>
References: <20250418183920.273154-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

trace_mm_khugepaged_scan_pmd() is only called in
hpage_collapse_scan_pmd(), where the head page of a folio is passed in,
so refactor it to take folio directly.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
This is a new patch added to the series.
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index a73699f000de..2305df6cb485 100644
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
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 950d147cd95e..bf5583dca1cb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
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

