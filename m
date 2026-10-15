Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435438F248
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084813; cv=none; b=VEdeytyr5XCbFdrgukoOxVw7Wz17PhbOvOWmYElgsNYcGsYEZeMrVKrMKkMUARQcxXU8bt+am1Kq4Q+Qnw48m1RxIBKKJjHggEc+LgaqLUQbVbF8qrNhuIVnav0/I0zNRsvHLUvyvDJ4BM49pK3RFmOXfwbPpGR47tmMlOMT74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084813; c=relaxed/simple;
	bh=+YNGoEvoT+7t9XFuQTCUADWmROLSjBVUtEZx79g0MD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TVuJUdeB14PsR7pzPJPK6F27lfYxMSfr+wTgIKTfPQSfa8LI+eq8B6YhJuFXXemdck5o2bRPgDINi4FhG5Zx8WawPZGMYxtiFuVGBWssKDCsvYeijYN1LVbZVV8pi0jX4JkWT3/rHwB3u6O4s2uY5DebngQ/c9RULJ77YVVmU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (2048-bit key) header.d=theori.io header.i=@theori.io header.b=VfvwYmid; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theori.io header.i=@theori.io header.b="VfvwYmid"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab98332238so3201067a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google2026; t=1792084802; x=1792689602; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLJSbkac/ADVjbC5F8ZE5hi76mnNj+rQ2srCe4ROr+I=;
        b=VfvwYmidEsJNLCw7zUYJt+RkrmYJMM6pOn0WlciHwXgTPfceivPVWxQPlog8coYDOY
         CdEQuiidLwAsH3FUaze+0yAN552PAKu7h1pCN/ZOk3rM+1JVuTnZHq4zHBGHsdtwnpzN
         b7vIAEkhdT83VES1RVbqqMBRNjoxmjd6SE19ZFIO6TOqh6h97x9/XO/SzI6TW6Z4Drvs
         Eurcyzz0u97uGGO8oaFnu71cYexLqsqf2dxElppTcXXXs2SeKSulvGfwBdsxPNN3fYfZ
         i92Q6pI0bRAOXeUvsY/Rjd7Gk25yUiGKLmIS0Ie4Nux3U/KTS8MmVrnPbcuOiEG6Ii6H
         P7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084802; x=1792689602;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLJSbkac/ADVjbC5F8ZE5hi76mnNj+rQ2srCe4ROr+I=;
        b=KbRY3tem2LdULgJF0Lo/x0zSWSSdrGDNpIA2u64IkMGDaJ+czP2cP6D7tcs3GLSrTX
         dguQsJrVnkUWVQzdpw68JSwHGvrCm7SsY2L/TRGDq9d/leiD1q3IeRP8v2QDlOXEwX4+
         A1/7KjelbBNB+Pc/Q5aYu3p7oYMXnjZK2JZqvkJsllY18YimD99uhEU3gTGCy5CA+2qF
         UsNc+qge6bqnVZxr4We8VqZAaiSewvf8Z+jqEQUGV+d/sEOxIhBUGmZxV46MHOAjcyUj
         MqwIhzCQJBxiOqXCW0tQusRV9l5EXbodD0VB3UHUR+wQamgHZZaJ9rLuGZqB65howK8/
         KZKg==
X-Gm-Message-State: AFq9FYIMr981+6tfwwZBWTT7aO94DjrrJXO3EsTsNKEVRT/Sv4pneU/2
	PW/gSKo7qHkZYcUXz6yZ2784sZmq2JIszj5O49Nj5sjKVJVSiJailTmcoMRv9gk0dXNZbsFUSgG
	u79iO
X-Gm-Gg: AYBFou1JHZROksbiMez2/oG42bPviQEz/qpKYGwMcqrqs1vtuRw1zsyKnhsv2DGYBzk
	wvW6gzGeiIvL6ydOdH4TVZ3w2khIhY5E1EgwdzOwmEWWEkvukdIQ55mp6oCmvzpP4Z/10YDyVn4
	u8dFZ76fTwTjrcLHWTnf7GgTut2IVlho0/p0M5jqWhPnr5rYIuB36k5zUWUSztPnvtx0t+DJQAj
	kGZUWNeOhYpjTq5Ho3Kb7RNgNPxFy+5YCZD2+hY0fYy43cawRn+OI3UZcC5derKv5OkbOo+bRcL
	nlyOgP2PsmD9OB3QCo7/WE6nB5V5XcFu1ihGgowbkiZO+CUgsnHpLmvi33Ro20nl3sDszpf07QK
	77p2KLxj1Meu8wRazjPvsSgNEt8hWYcOnUM1sVREwGmGIc3UrEGmA4xN1bb8yTpgjdgAzGDmzDt
	hoac4BKzUJ7oZ3kvrpGYboBGVDccndGIqNFGLm9wCehrV128AHS5EEpAGin6jUmFGV0W7spUnxM
	loVOZEMrUq3AmzEfxJeBpbYbtuODO2aArJTh5xjUapntWNLYwNBUw==
X-Received: by 2002:a17:90b:2ccb:b0:3a4:6e84:e7d8 with SMTP id 98e67ed59e1d1-3ab3afd2c4cmr16751444a91.54.1792084801576;
        Thu, 15 Oct 2026 10:20:01 -0700 (PDT)
Received: from Taeyangs-MacBook-Pro.local ([59.6.107.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc496f4basm117003a91.14.2026.10.15.10.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:20:00 -0700 (PDT)
Date: Fri, 16 Oct 2026 02:19:55 +0900
From: Taeyang Lee <0wn@theori.io>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 2/2] tracing: Check operator stack capacity before pushing
Message-ID: <atELO9L0I9kg5CpC@Taeyangs-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

predicate_parse() uses the first operator stack entry before processing
any opening parentheses. A push then increments top before writing.
The existing check still permits that write when top already points to
the last allocated entry, which can access beyond the operator stack.

Reject the push when top reaches the last allocated entry.

Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Cc: stable@vger.kernel.org
Signed-off-by: Taeyang Lee <0wn@theori.io>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 781416ba6..127880ebe 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -511,7 +511,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 
 		switch (*next) {
 		case '(':					/* #2 */
-			if (top - op_stack > nr_parens) {
+			if (top - op_stack >= nr_parens - 1) {
 				ret = -EINVAL;
 				goto out_free;
 			}
-- 
2.51.0

