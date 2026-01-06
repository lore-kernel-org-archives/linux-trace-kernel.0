Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83133E37C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731740; cv=none; b=OzvgewEO7srVjoL9PmqYdoIIvS2AfU76hsjbzCnUQGC9sg14I6LQOUy8mRBNoKIm9Sc5Pm9T0rwUYdq2H/gZRs0H7bQKjWJce/VRDDT2mwhvlCLA3b+uyaLN8+IapdkuZRweQ98WLW098oHt1Rj8rtqYFh8a671EIINPkJwkY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731740; c=relaxed/simple;
	bh=D9yQ2o5oNf3ScOdvwc+oEkWVYycM8zjIe/4vKH7dBiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1koQMXeQTMzcPQxR16TNrDHTS4JvCq07j7ikfBHA/bn56NS8zaXwv46F468eSEhB1wx0jgPUjcPeDMcA4nC6zXdA6WLc34Hrw9q6Qr/PRTYuBpuxCYkdJ3gL6O2TaP3WZMXSESXkiu4bElbpHw88R1zZzrblkr+jUzINKzG1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egowkKl1; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egowkKl1"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b04fb5c7a7so699782eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 12:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767731738; x=1768336538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5/rnn3ELMzpSfEF1jjvUjW3hY2TqsWtJHmr7YBzUjJw=;
        b=egowkKl1ALHnKVn97TVWXlm4u8d7KAXQhtnaxT0cSV9+qQaNdCj4a919f/zkHrVDDz
         Jjyv/p4M+rGFPspY0XhJ6DqIb5Ob21+77sS0MVYyqhRD3/PAesbb6lHRrfU79FQ8aNFu
         /8roEVzOupnfvO4kBjm8oZTR5qfOwHdj2ih+nSMeGFsClAwhMF+xZT7ZjZddgTGa+UpN
         fSuuqcZnhAanXE6hEENubxTrH7q/rMxoojEqwk4sfe+B55tLl1vCbqqmt5TNw0sO+Nni
         CXv+kmld11bwDA/yxfkR0TZ5CNkJL29gwYcyCxVIZnuEnO0H4prxbauL6UYLpeut7G4/
         Qw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767731738; x=1768336538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/rnn3ELMzpSfEF1jjvUjW3hY2TqsWtJHmr7YBzUjJw=;
        b=dTALlvkSeyR+x0gYuVwl8CGMw6/qoeJ5T54Em8FO5LcLDUv1vGG2ND8EIBG+3hdmBf
         n6spPWALw41C2HMRNl7T9waOZprYneKpQUvuMnHjsvCn3wZm19J7qsTvP9opiHYEIvPc
         v1zNC9roLlWdy3/PPc+l5diJUs3IIFBASBok3FDDaXBOT9IseGW2uM6YOekR4yDf4vC3
         mSPv9/D0pBb6O1VVIkZPMEq8Y+8f8BZWjc4owHonafQDthZdAUh/RnOmTbWNXY58O75m
         ubgUEtmFHPUPgonB9dMqaOts3XtTOfD/4OQFIulGyTcs9ak5Vr/+XsNhs4X4lSaRtFpY
         Yc9g==
X-Forwarded-Encrypted: i=1; AJvYcCVmJ5rq1OpmIbyWi7q40qu/pBK73f9Bgnvpu3W3f2IM4iEzYLykG7cNle48l1SPGGSwM58FCBv7kAcheLLcaOjmVZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tnAm2/HOTNKC+JyfS3Z70Rt3MBT90bILZAJBTZmMHQNEUnyv
	BF40EOX4WxQbD2WrWixpVsYSD7W8KNpTSwRijzG/MPHzg41O8zqSjeJl
X-Gm-Gg: AY/fxX6LQITtdA4zidD0DcQeN3QfJiEAXQukJlw9IeqdZwpUHRkanifxdVf++IEnbRG
	AzgsRflgT51SmbojaoeaE0WXXiOK9CnLUb0rKH5PPfmAL78dYmgE3QYJdbpw/OHSTSaYVNXGn8I
	zr+7DXdBaBukVgsv517VBJt2zCFBap94VmMjEuCCP46RIRB1X15jKBwfj9RNDpkIRkdTTD8Fx6X
	GiiLTsUa6lBMkFo1FGcXXvjHwrSuFpgbilOVm3JSM+KOrelFFzhXlGwNHSFM3Ddg7XShyJE6M+e
	+Yy7J8OcnOO3J/mb4pIDx9kkYeFGCVSQ/MHitw6H3Q0WYnILCDKmL4g9NRl2AvRfedZMMaCTllx
	ioj9xtpsX3NTNuO3GE1bnlNmOFz8GOv4WIY2Is1reROWLbimmJGaj8Lfh/fDlPzyMeYJG2U/FP2
	aQztvHQTlxE6LtyltXaSf5qfh1
X-Google-Smtp-Source: AGHT+IFiJA+rdlCtKkoxFpOGnLicEwGAcgBp1ff416NZWS9VUF0qprC4FkRzIHCQFO3T97V7ug3zlw==
X-Received: by 2002:a05:7300:1829:b0:2b0:5834:44d2 with SMTP id 5a478bee46e88-2b17d34428amr142148eec.39.1767731737566;
        Tue, 06 Jan 2026 12:35:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a5d3dsm4674177eec.13.2026.01.06.12.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 12:35:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ftrace: Do not over-allocate ftrace memory
Date: Tue,  6 Jan 2026 12:35:33 -0800
Message-ID: <20260106203533.2896197-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pg_remaining calculation in ftrace_process_locs() assumes that
ENTRIES_PER_PAGE multiplied by 2^order equals the actual capacity of the
allocated page group. However, ENTRIES_PER_PAGE is PAGE_SIZE / ENTRY_SIZE
(integer division). When PAGE_SIZE is not a multiple of ENTRY_SIZE (e.g.
4096 / 24 = 170 with remainder 16), high-order allocations (like 256 pages)
have significantly more capacity than 256 * 170. This leads to pg_remaining
being underestimated, which in turn makes skip (derived from skipped -
pg_remaining) larger than expected, causing the WARN(skip != remaining)
to trigger.

Extra allocated pages for ftrace: 2 with 654 skipped
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7295 ftrace_process_locs+0x5bf/0x5e0

A similar problem in ftrace_allocate_records() can result in allocating
too many pages. This can trigger the second warning in
ftrace_process_locs().

Extra allocated pages for ftrace
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7276 ftrace_process_locs+0x548/0x580

Use the actual capacity of a page group to determine if too many pages
have been allocated to solve the problem. Also use the actual capacity
of a page group to determine the number of pages needed to avoid over-
allocations in ftrace_allocate_records().

Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/trace/ftrace.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ef2d5dca6f70..211ec7a04f7e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3844,7 +3844,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		return -EINVAL;
 
 	/* We want to fill as much as possible, with no empty pages */
-	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
+	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
 	order = fls(pages) - 1;
 
  again:
@@ -7308,24 +7308,33 @@ static int ftrace_process_locs(struct module *mod,
 		unsigned long skip;
 
 		/* Count the number of entries unused and compare it to skipped. */
-		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
+		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
 
 		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
+			unsigned long space = 0;
 
 			skip = skipped - pg_remaining;
 
-			for (pg = pg_unuse; pg; pg = pg->next)
+			for (pg = pg_unuse; pg; pg = pg->next) {
 				remaining += 1 << pg->order;
+				/*
+				 * The capacity of a page group is
+				 *     (PAGE_SIZE << order) / ENTRY_SIZE
+				 * Accumulate the total capacity of unused pages.
+				 */
+				space += (PAGE_SIZE << pg->order) / ENTRY_SIZE;
+			}
 
 			pages -= remaining;
 
-			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
-
 			/*
-			 * Check to see if the number of pages remaining would
-			 * just fit the number of entries skipped.
+			 * Check to see if extra pages have been allocated.
+			 * Only warn if the number of unused entries is larger
+			 * than the number of entries per page to avoid false
+			 * positives due to rounding.
 			 */
-			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
+			WARN(space - skip > ENTRIES_PER_PAGE,
+			     "Extra allocated pages for ftrace: %lu with %lu skipped",
 			     remaining, skipped);
 		}
 		/* Need to synchronize with ftrace_location_range() */
-- 
2.45.2

