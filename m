Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805581D9A66
	for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Apr 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081463; cv=none; b=Zg/8OXrKiUfsQl2J8EiSMKzpajmgd+vcfEeoVtAduQV1ULZX4zD9aNb2CKPk4RAZZxi7U+zWDBu6bCVom3IkBgZjSmmmlB/DtoY3t4cbZ6WRucgMDMyDzmFNVsemdrC+yVXzz8kGJw4UtHRgsR+p7uBrVFf20BvsRRjqHzu90Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081463; c=relaxed/simple;
	bh=WbM8aoFDL1xInf9fk989KxgvWM34KxbOYADLDMviZ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKTKhmL51QhNGF1paxcg8P859/+tJ7VUde/Wo8N/2f+BCojM6jWvkot8kTRwSWZ9n4r1kSCNMG+SuRTgjg7ikUQpGkkImmdsfwiJUKYWLiW/Iw7Z0N7ntTHUVE2U7xzjpQz/WYCVP2xEoBM+zXR62JhRsah/lYU0g/6k01wg0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHYl6JtV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHYl6JtV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad4d639db3so42689235ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Apr 2026 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777081461; x=1777686261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1KowH/KQePREcpPaMinSKl3adwCAV357FzMEtXwkvI=;
        b=pHYl6JtVgluhk/YnrjUZTxkVirDurvSI6PENKtrhUYncW0S9UA5EGQHeWJqjh8YP/o
         TW+Gklo3Vp4PpcB/0+PVk2A7tHJPEr8RPEG4prEWpSlwWY3fRaLFnshy5uPxZyPjvTHT
         fXAYc14c6DZF/QUc9Y3T2C6mlr8JcZY/cd2v5Hs0KfbzDQHDDE5TYjSGnydUISJS51DS
         82chxJGRMXIwcNtkpOAsY35PLmpC6ub+olGy8gYzI3JtytksaOSnfl8GM1leRxPnrL0V
         xWIaquYcra4AwK6cCIvU1vFjuKC1cdchkw3HOB2ZcPqMLv/uco5Foa57p7MeaWsu1X74
         bjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777081461; x=1777686261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1KowH/KQePREcpPaMinSKl3adwCAV357FzMEtXwkvI=;
        b=KyCa+NrxHea120bxe4HXJCjmTqX0tJEWa7m43F9alHVp3ywSEbxzKfT3vUc/v3mqNq
         +cseX1943LLe1dHPDJLWBa+ZQ3e4eDtxgIc97rekuya3VfDCw0WCMEnz7rZW1zemVyjw
         w1pL6/SOeJY7O1N8VKCrcQqUNcxOlopWPXCjRGllzKvSSMTw/hZ0Uw7z/c2bzM9igkdq
         TV/43bK9n2iqSz080udHaEBcDw/+DypLEDDpvNdvrbXX6z3/SaDyeFtc+fDL++OxyPXG
         sbU2AeOIEBP3lwTCEv2vAEn263TC8D+uMX52v1W8nuvMxUX9LASeWGqLwe0CjYvxCq5Q
         TiVA==
X-Gm-Message-State: AOJu0YzgB7FBQUFlHNb68gEU6vBOBe+lIzAmoZXkGSg5XBEVLVNnYY6l
	2DPqWJ6yzZD3+/DJN9R8e11w1Pw10vuTJfRu/ZScE7iEDW+lbUQ3SU0mmoYLOw==
X-Gm-Gg: AeBDievfgBl1koBGwn/5z04HuilJoVKhaHN/BObiUrUEoGd0j/WUxP/9n9/45c19dug
	b6dC/xN6uECPtynG/qIMbPwxgDXkbsvqpSHQ3t9mO+bpvIjhBcVljbb2NGuJ/PtubYvrm/vXveZ
	HW4cs5k8F0hNLNfyqV7vmGyQo8rfK/kA5YGWir0kMo0pdUMSMLSlR4ewyBJoSBC2iSG7FJchQGh
	ilUZod1xXwrkACOmGcmFXZnsBkuxD3q1mI60ptwEayrxZaj1vfbt1CLJ1tq3GRJVe/mBomIk3Dx
	QHLrMpqs2EdA757wuGOwmcrkjdOLNaUlNlTEKyw3rigrANwwoDqIeibV4EXVJ2mpBOSD41S9NLG
	5UEwkBon0KLSn6aOa+SUgZwtXw/yGCc3TlhRV0B8moFpDSFh9XBK7LjLC3JUEBZJVtnE6Wq7yrZ
	HbZ4KFK1Cl7RAiVo+iW1BQ9KpS9RteJkn7AkpYzze5W3p94XMVJIpmIND2JPgPPZlaGKe7jmFdQ
	Fb7inzZoZFhMlQWo75Y3jrwew==
X-Received: by 2002:a17:903:200d:b0:2b2:5597:bad4 with SMTP id d9443c01a7336-2b5f9ffa730mr262055295ad.30.1777081461529;
        Fri, 24 Apr 2026 18:44:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff918sm254121425ad.13.2026.04.24.18.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 18:44:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] tracing: simplify pages allocation
Date: Fri, 24 Apr 2026 18:44:03 -0700
Message-ID: <20260425014403.440786-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change to a flexible array member to allocate together with the array
struct.

Simplifies code slightly by removing no longer correct null checks for
pages and removing kfrees.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/trace/tracing_map.c | 32 +++++++++++---------------------
 kernel/trace/tracing_map.h |  2 +-
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index bf1a507695b6..627cc3fdf69e 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -288,9 +288,6 @@ static void tracing_map_array_clear(struct tracing_map_array *a)
 {
 	unsigned int i;
 
-	if (!a->pages)
-		return;
-
 	for (i = 0; i < a->n_pages; i++)
 		memset(a->pages[i], 0, PAGE_SIZE);
 }
@@ -302,44 +299,37 @@ static void tracing_map_array_free(struct tracing_map_array *a)
 	if (!a)
 		return;
 
-	if (!a->pages)
-		goto free;
-
 	for (i = 0; i < a->n_pages; i++) {
 		if (!a->pages[i])
 			break;
 		kmemleak_free(a->pages[i]);
 		free_page((unsigned long)a->pages[i]);
 	}
-
-	kfree(a->pages);
-
- free:
-	kfree(a);
 }
 
 static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 						  unsigned int entry_size)
 {
 	struct tracing_map_array *a;
+	unsigned int entry_size_shift;
+	unsigned int entries_per_page;
+	unsigned int n_pages;
 	unsigned int i;
 
-	a = kzalloc_obj(*a);
+	entry_size_shift = fls(roundup_pow_of_two(entry_size) - 1);
+	entries_per_page = PAGE_SIZE / (1 << entry_size_shift);
+	n_pages = max(1, n_elts / entries_per_page);
+
+	a = kzalloc_flex(*a, pages, n_pages);
 	if (!a)
 		return NULL;
 
-	a->entry_size_shift = fls(roundup_pow_of_two(entry_size) - 1);
-	a->entries_per_page = PAGE_SIZE / (1 << a->entry_size_shift);
-	a->n_pages = n_elts / a->entries_per_page;
-	if (!a->n_pages)
-		a->n_pages = 1;
+	a->entry_size_shift = entry_size_shift;
+	a->entries_per_page = entries_per_page;
+	a->n_pages = n_pages;
 	a->entry_shift = fls(a->entries_per_page) - 1;
 	a->entry_mask = (1 << a->entry_shift) - 1;
 
-	a->pages = kcalloc(a->n_pages, sizeof(void *), GFP_KERNEL);
-	if (!a->pages)
-		goto free;
-
 	for (i = 0; i < a->n_pages; i++) {
 		a->pages[i] = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!a->pages[i])
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 99c37eeebc16..18a02959d77b 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -167,7 +167,7 @@ struct tracing_map_array {
 	unsigned int entry_shift;
 	unsigned int entry_mask;
 	unsigned int n_pages;
-	void **pages;
+	void *pages[] __counted_by(n_pages);
 };
 
 #define TRACING_MAP_ARRAY_ELT(array, idx)				\
-- 
2.54.0

