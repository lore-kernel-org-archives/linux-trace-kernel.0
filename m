Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE32478865
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196931; cv=none; b=oajI4M6VF7IZagtL/CoqaB6ZsXM0TfC+/VnafxopM/hyb1AP8cs7La6NFxl7SsyreN/sU/AJpWRXpuL95wRsFAg8XRNLbQTQ1kZZ9CEwKOZo6FPYBEu8xcmthT2AHRS2X4tPa160YEOOLrr3Q6TZzJbtFtoskMSUfuxIZMyFXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196931; c=relaxed/simple;
	bh=LSQXwuc/91Jq9M2oRXvArzk4lKHdqB6VXTG9KYDgn78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gzWdHjRHT9yio2rIis9ql5bmsodZpO1AIk8Eyty1DKhT8Jc13OxeG5VvT6HnWqqfQTtwnngU+P1cONHHWX2qVJDiSGmt14VD6tQ1U7yBawuj2aDQMnMfs9vkrH2mrlUuKE+WxuU7KO0yeG28K8JQSDu+xcnHGmNKoaWb9VQ/Fec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXC80dVc; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXC80dVc"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c66ba0b762so377171b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Oct 2026 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791196929; x=1791801729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mDdAj0bmi+Z2cA6z27B4wh5CNS9OF0FfOrosmrqHfMk=;
        b=fXC80dVcvbBTTORmO0O9BQojnt/8S/femV9i3h1Ul7aFMq9XIx1QPtWPoHM0PRMbsN
         ohJ+M6Xj6MhDuwnN7LUwb4xHdhDnBPeO+tkMfKm6+axULJ19rtGU6WbSDve1MIpEeIN3
         c+IO/6GuJayrSEomQEgXr6+8Z0ItydOaD2SPAZCVCeWLxGMmUdnShXNgV4YsP869213j
         bTnevSuXA+4Golo/Bf+wfrAo2UnHgwwrM9Ib5vcinY79Rhrjc5py0lv5hso5+ARXXCNy
         4/PHfvl/UjvMKWdxxej6REKaau2ao8N5JOkYQD/FWK5lXGQ/Q4igR66bW7ea7/i44ajW
         BtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791196929; x=1791801729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDdAj0bmi+Z2cA6z27B4wh5CNS9OF0FfOrosmrqHfMk=;
        b=oVV5FsLlncFwyKQ4V8GTiriEHFRcqO3Qpxe3yyDjBwDtbqBvHcA4vaXTOgzwF32wCZ
         ZYAVcCWEiTujn2v/z9cXE/xqOpl6WQiRKjPJI7kGN1uWZ8WfWD9Fw4j3q8WRruxroCc+
         1AB0OmJsDI+jtmfNneKRZqM6L+aCrl+SrwQVnXV60u2Q0fhozQ8LD5nPp/i0fqHLgCF2
         NkX8VaYmG79QkGA9H1yqB18VpktKq3HYlalr+sPaYKWvmQEQgTf7t7XHC4K4PY7Jk4+B
         gAGGHaku5mxI11tJJLFye2hoaLyUyxZ0pIiZQmST8n/HIyJbJRZZBdHtp0ePQQBCWJVk
         Ro/g==
X-Gm-Message-State: AFuF++mkHxlbUFG029/fQHjYZdTnStzOlp67Vto8rVunPX79/hOGfdWf
	4yB/PJj5T6sCOvPohT2r6vinHqUeS0amItB5JO3jRFpn2I9/XVFpgM6Y
X-Gm-Gg: AYBFou0rOz45wXLGpsqtBZKYzX5H0tNsapfiVy5RZ90WyCjGhzMlD6XUiURAHc+T6NS
	6bHHi5enTebcNwGaNrFZokzn2366tuSRxw6+0CuOnQxgZBSKY11vcWnQUPtc7AN4JnW4C41ZHDx
	2i0+xeHB6kmysfAhbh2Bacqp1KT5WaIeObzyjUtiAGSfWDE7YY4wkv0P5mfMErCyli+OuBGz1yn
	BKBreO/MD8GLJkyV+N0rc5x02CfqC88f0hwbkOAwa2KRVybIkfuzA1myxvYp+PmmEkLnBhBzJlk
	j7e14ltBolgAFcfdYiOpePrzAFH3L0LTtG04e5ZNiSmU+3FaSsAvGEs/7yshQi76oTkqejYIv3l
	AtbcDgkXTYei2DTwbXpOF9TXBvca/8BgS0+Z9Th00yUx94PveMVHpD10ujPp9ZozsgHYcP9C+3p
	n+Lv8unapae5susCJF5fcUODLi70e7+If4nMxS5sVC2Y7RFs4i+vsgbeYII34OIHHY5QiKQDpmI
	lwofkxJQdn7
X-Received: by 2002:a05:6808:14cd:b0:4a4:c95a:38d1 with SMTP id 5614622812f47-4f52694526amr5863845b6e.4.1791196928891;
        Mon, 05 Oct 2026 03:42:08 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5249d7c75sm9588989b6e.12.2026.10.05.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:42:08 -0700 (PDT)
From: lzhan011 <lzsx618@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracepoint-update: do not reuse section pointers from a previous file
Date: Mon,  5 Oct 2026 05:41:59 -0500
Message-Id: <20261005104200.1787946-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lzhan011 <zhangleizhen645@gmail.com>

check_data_sec and tracepoint_data_sec are static and set while scanning
the section headers in process_tracepoints(), but are never reset. When
tracepoint-update is given several files and a later file lacks these
sections, the pointers from the previous, already unmapped file are
used, which crashes:

  $ scripts/tracepoint-update --module a.o c.o
  AddressSanitizer: SEGV ...

Reset both pointers at the start of process_tracepoints().

Kbuild currently passes a single file per invocation, so this does not
affect normal builds.

Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
Assisted-by: Claude:claude-opus-5-5 ASan UBSan
Signed-off-by: lzhan011 <zhangleizhen645@gmail.com>
---
 scripts/tracepoint-update.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 5cf43c0aa..4c4b66901 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -163,6 +163,10 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
 	int idx;
 	int done = 2;
 
+	/* Do not use the sections of a previously processed file */
+	check_data_sec = NULL;
+	tracepoint_data_sec = NULL;
+
 	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
 	shentsize = ehdr_shentsize(ehdr);
 
-- 
2.34.1

