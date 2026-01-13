Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3753921DE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317770; cv=none; b=sHsvesokIadW2POABeEWlcCyhiWb3d8Xi0nT+Er8LX8ph97MbkT8Xg2Le3bsFF+no74OOkT7SJATT3KHK8Ev1NO6IdBL9ExB91zx4bcRvwwb8Gq1hRVLLoE3RRJgE1FyRRBxgN3Pbz5mSIsPUYw+jphJTNqW7AKQ/k5tQrFFj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317770; c=relaxed/simple;
	bh=aCnts71FT5KF8IXtHzvQDp9rdDq6BNBukRRmCwvjnB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cin6HaNispDWP34o/Ra8br0TC4Fc5PEd9Qtq3vPDK1XCMi1omJf3KCv+LSGX0matZHZPXhf8ruEQu3Qo4Gzol0dYZQl3UgmxsQXmZvZjkI+d8IG2KTCCa/Yn868PSENDUuUXF4xCtOlz0g/90jvhk6gpTh7T/opde3kL5llK5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxMWggb2; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxMWggb2"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ae38f81be1so8164407eec.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768317768; x=1768922568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrIkkZ5tNIWOJGt2qAo1/Ab4BOHGnPxQU0IVjlRL80Q=;
        b=kxMWggb24RD5cbJa34KC4b0dD9RAF7sgEnnDlWJM+DlzLwrCUnA/+mFEhJ8Nhi/ph/
         /aXBTH1aIiyTEOEuy+NtORmGDLJZAUmEYa8w+rzaYQ/6RcR+uBUoymeJDK8kxYrgwfJY
         CnxRX/6PMj8CeNb2HbzidqxR8tFgIeJWNoNdMKnriwKhzjntjv8uBOPm0dEUtekkuILR
         +AanKXvNWGntxtOPVZq+cIwPwHPW9Cnv2O8GRC7XLw2vX6d0NAhAYc9loCbwXV21Q52Z
         KNpJVRJo8DwC4sMulZp4cmuTylvZEraVpieYL2VU2TZ1ATwyJJ1/m8lcRZzbHyrYNtHQ
         +ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317768; x=1768922568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrIkkZ5tNIWOJGt2qAo1/Ab4BOHGnPxQU0IVjlRL80Q=;
        b=AS4L3bWzUhKJer+hWeqmUiUriIOWJTVsjlMIYKY1/K1QU9UpY5hlrPyGTGlMhIInub
         VcHzi+SK9D66KZiUTypSErnOciWR2rJbIS5j9InNTQ/RAVfSfKCCKnX9vn+Vb4F4NjNd
         D01TITXiKYq1tVM6dVFuKQ2GRWcVFJ+I9eGNnLs8ccxaZU9VWm3tb0Ft7wyHgW4zNcUz
         nidQIu33+MFl2kTxOMJ+oYtfVJ1xiteztGm+yQAnGlPsUPC3MxkF1MfZMNnBRzBk2kj1
         Qn1ErgbehihJ09ah+XvRJMijgeM/L4VNzDXaDKKbRBzVDxtTuT8U4pawPewrtFdPemFz
         uFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZtN3aFzoCTAYfrV+1sqIjCO0NmFzWm1P0jgYs9mHRm24xK+emC9/IEnX4vwiaQG5ipKhEpL5jQddupNPE+ykQTkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Qh1cH/PHNSq4cesTzBSbECXJ5jQ+8MpMR/L7sKP9jrlEdujL
	RX9o7qpqbW5zRUy8KX0HJ82cB7UpRykxxVDZIaq3eVtAnGOTWAfaZyZ6
X-Gm-Gg: AY/fxX6p5mGKP5RmNdHHaR+G5lxgWcEn+XO+bvP5e95a+D9v8Vi8EemxlQk+V/i5ZhF
	VyLY6s1jg8bwy+fztiLUriF6lkS/aV+Sk38v4mg4Rj3LdKTXfiqctmFcJ9Lw7uqmVUPCftFEvC4
	vN+DxA3L6eNUMHS2mZ5aWeNT3WWemBAsX60fWeFumzmxSKO8JHjqCf+U1gL1dgsuMiS2R/qJWEF
	AIRWuB1RdBtti3hv56OGLCVbXZlUr1XL+44BE0u2f/Ih/THEQT18o1vc4KG3zzX11DrgDoseIEQ
	kOfJ/lr01zcC4MVX0rSHkzSE5ZJ2n2PJBKQs6VheIRKvdSWL/fK+boqPZHNDcGhtsrr35ra3slN
	gRXEC6xZu2f+sXGgvVD1YzgLeIuiSQ7hmdH67D4Id52z/DccGppHV1cvqsXscT0jvq/MjTX7XIo
	HVNfx8xo2Cbj7tZON9w80wjdJk
X-Google-Smtp-Source: AGHT+IHuC52LBioIDucScULfOqeXIuVEBgovO3o2avIRU20jmMbJ+eNEz/OX+RL5s3waHIAoDEGw2A==
X-Received: by 2002:a05:7300:a149:b0:2ae:5297:4ce2 with SMTP id 5a478bee46e88-2b17d2c9a55mr15933165eec.34.1768317768124;
        Tue, 13 Jan 2026 07:22:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17067327csm17355463eec.7.2026.01.13.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:22:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 2/2] ftrace: Introduce and use ENTRIES_PER_PAGE_GROUP macro
Date: Tue, 13 Jan 2026 07:22:43 -0800
Message-ID: <20260113152243.3557219-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260113152243.3557219-1-linux@roeck-us.net>
References: <20260113152243.3557219-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENTRIES_PER_PAGE_GROUP() returns the number of dyn_ftrace entries in a page
group, identified by its order.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: New patch, optional. Squash, drop, or apply as separate patch.

 kernel/trace/ftrace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index aa758efc3731..df4ce244202e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1148,6 +1148,7 @@ struct ftrace_page {
 };
 
 #define ENTRY_SIZE sizeof(struct dyn_ftrace)
+#define ENTRIES_PER_PAGE_GROUP(order) ((PAGE_SIZE << (order)) / ENTRY_SIZE)
 
 static struct ftrace_page	*ftrace_pages_start;
 static struct ftrace_page	*ftrace_pages;
@@ -3862,7 +3863,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count,
 	*num_pages += 1 << order;
 	ftrace_number_of_groups++;
 
-	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
+	cnt = ENTRIES_PER_PAGE_GROUP(order);
 	pg->order = order;
 
 	if (cnt > count)
@@ -7309,7 +7310,7 @@ static int ftrace_process_locs(struct module *mod,
 		long skip;
 
 		/* Count the number of entries unused and compare it to skipped. */
-		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
+		pg_remaining = ENTRIES_PER_PAGE_GROUP(pg->order) - pg->index;
 
 		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
 
@@ -7317,7 +7318,7 @@ static int ftrace_process_locs(struct module *mod,
 
 			for (pg = pg_unuse; pg && skip > 0; pg = pg->next) {
 				remaining += 1 << pg->order;
-				skip -= (PAGE_SIZE << pg->order) / ENTRY_SIZE;
+				skip -= ENTRIES_PER_PAGE_GROUP(pg->order);
 			}
 
 			pages -= remaining;
-- 
2.45.2

