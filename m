Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1043ECBDC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299943; cv=none; b=dvn73nPwkIU9sj2xx6bZcp5whUcSiLtRtwhQl4kfQj6IIlyjl271OApBTSx3yUn2CBXJnyD6+2B47r6j3/L4UNEw+QAzAuBI/qz1VAw9VagBjY9thF0/A60Nmzqh5cRkVPKytaXHRVdX4M5VvMfmwaYF/VaEa70zKB4NBqRbqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299943; c=relaxed/simple;
	bh=hFDnQ6dA5v4LIpZGLVcYSapTXIgZOljUMnp90oGqvWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgKkP2CRjP4k5iwHUo8KChiLemxwSSsQsX2Bzb5KUrOOUvSyRIPEs24GN44ykt1qRSYZIdiAiSbFWJv7tccBieZK3ZlbFYVchzyC4MpOw02eGzI87mM7RYeHwDlgCTFPPX1vI/EjrVoaNAQC9rjyuRmx+Ya71mYJwQZl2/yiReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmp1WrBT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmp1WrBT"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c52f15c5b3so84639185a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 05:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770299942; x=1770904742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKV19EGGSuPx0CSDuaZFnNmV/tMAAbV9MIqJCR7Q2JI=;
        b=bmp1WrBTME6W/7U7Y7cWEjTejFvWrKIRMlKYrfv1qWOKtfSE4OI5sS+iTXgNb8Wfpv
         fq7OAS8awIUxlAgCyMGsRNurQ7zzyR4HWcvHVHjfJf3djRck4kQ5JBCjfu7FDdg7VsrN
         tnGrHNtf5aIoCQbVRkNmBeQwqQNvYKdh/uNrlStLgCHIaOVyn7/y2TpQEp6NhPbu4SGa
         eah7PVYvFHC6/t5aDNXcw6GnHvw45UttG+VJTftZWkB4r5CGtE/Om7Ef5D+IHz7X4jVc
         4Ce3x5AKFPHz2eNJN25J0+AWnfq8Ya4c3Wrmf0my9vi4Nqu5Ge6psbVh78wpx5ZbhZbQ
         hQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299942; x=1770904742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKV19EGGSuPx0CSDuaZFnNmV/tMAAbV9MIqJCR7Q2JI=;
        b=ZpxQkrIw7x9hSLRX4L+rA470UsWyS79lpKRYRQlzUnGKpUfxBSzVvJMy8ayz6EdB2X
         apW0O5qC6I23satFV98J3KIxbYfJA14M1vHZCuQRKnn79KcJLMxFinku2uh7Sf3JUu9z
         sSkuIj9K4DpBXYpFtadPO6qMfHYvPr+AErBsNGSO7dh6XBMs7c9ASzRC5zR0JaBRxEUZ
         hjCLwG4L5rEOaEhOddkl6aQOyTJ+kwsoYad49GhJ5o+yPJ705pzBkxUUHuB2CRx8ClQw
         ykbhigzJQxIV79M5pEFkedSWpGSF9E65UsdC4GSyS0F9kv9KrCyPTWVVVEHSxNbM438q
         MD7g==
X-Forwarded-Encrypted: i=1; AJvYcCViLkBVyB6Wuz3l2VnOT7TgmLsbSWYT2J97e5ijkKkmwnQK0rpBUOeT4dR64Yo1H3KK/kmIWi98XOOXgJEOl2d3vrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADSNjCzzJm9VPdtTbeHokmyopHxGIpo8NVz5+AAAHsKJMP68O
	Tz0QpmKO+BMVEYusrTDvl/1n7HH4cNgr4QOJq3xdlsxa0V/cR/JgU3s0
X-Gm-Gg: AZuq6aJufebhorFoDj5/quE87kYG5RMed0WSdTao42nSNMpXQWJPLiRcUxzxq4UP+UP
	+CKIi3XhftFD2q2VUXofF/Dy/H+XotnBFOLEratX+Z0RaHwMxE2pJERnrQfs2fOlPkLr+hVZPTx
	m70TnyRdt0GRUAQLKd6S7PZKFUJXjeCYYxkXskqGAS3KXSUN6VYdFN8actYFIwkAqVTI7DmWjvj
	X9NGfxTGxf++Ff2wY9mlAOwWp0O7fPGQJIHl4xDIkVynt/ktB0YvR6gGxP5axSWKvBlxg2IMIUx
	DfsDVp0VmXFr5wbo/ycAa4pqOpTIjSqmlsvNQIGmpVu6Etl42wXO8iQTmORVjhmCijAGZlkjIJS
	w1vTc+vmJtX96T0dzG9TDauzrv9zdNLAIZ0wNZXJnMn8EnQoYd9mKSltgg7/Q6sYoBiHhBGcBIk
	kxobNE3FxM33Dt3IDlJih0T0CnSwjLX+3zF3pNxGbomSR2rd6PqbxRmTY2tKwbW1y7AQcHzC4=
X-Received: by 2002:a05:620a:c4a:b0:8b2:7536:bd2c with SMTP id af79cd13be357-8ca2fa08fbbmr876603685a.78.1770299942602;
        Thu, 05 Feb 2026 05:59:02 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:87a6:ecbb:44f:b3c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd40f9asm404975985a.41.2026.02.05.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:59:02 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	corbet@lwn.net,
	shuah@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v6 2/4] fprobe: Support comma-separated filters in register_fprobe()
Date: Thu,  5 Feb 2026 08:58:40 -0500
Message-ID: <20260205135842.20517-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
References: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_fprobe() passes its filter and notfilter strings directly to
glob_match(), which only understands shell-style globs (*, ?, [...]).
Comma-separated symbol lists such as "vfs_read,vfs_open" never match
any symbol because no kernel symbol contains a comma.

Add glob_match_comma_list() that splits the filter on commas and
checks each entry individually with glob_match().  The existing
single-pattern fast path is preserved (no commas means the loop
executes exactly once).

This is required by the comma-separated fprobe list syntax introduced
in the preceding patch; without it, enabling a list-mode fprobe event
fails with "Could not enable event".

Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
---
 kernel/trace/fprobe.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1188eefef07c..2acd24b80d04 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -672,12 +672,38 @@ struct filter_match_data {
 	struct module **mods;
 };
 
+/*
+ * Check if @name matches any comma-separated glob pattern in @list.
+ * If @list contains no commas, this is equivalent to glob_match().
+ */
+static bool glob_match_comma_list(const char *list, const char *name)
+{
+	const char *cur = list;
+
+	while (*cur) {
+		const char *sep = strchr(cur, ',');
+		int len = sep ? sep - cur : strlen(cur);
+		char pat[KSYM_NAME_LEN];
+
+		if (len > 0 && len < KSYM_NAME_LEN) {
+			memcpy(pat, cur, len);
+			pat[len] = '\0';
+			if (glob_match(pat, name))
+				return true;
+		}
+		if (!sep)
+			break;
+		cur = sep + 1;
+	}
+	return false;
+}
+
 static int filter_match_callback(void *data, const char *name, unsigned long addr)
 {
 	struct filter_match_data *match = data;
 
-	if (!glob_match(match->filter, name) ||
-	    (match->notfilter && glob_match(match->notfilter, name)))
+	if (!glob_match_comma_list(match->filter, name) ||
+	    (match->notfilter && glob_match_comma_list(match->notfilter, name)))
 		return 0;
 
 	if (!ftrace_location(addr))
-- 
2.43.0

