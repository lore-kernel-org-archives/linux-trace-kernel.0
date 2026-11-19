Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075303;
	b=VoA2Zzd0vA+MCnRRJa47L7++4+ELm1HFcMR7NPqmxxifQbwLXv7lrggCvtBoJSVjke5C
	 nhsjnlNqEFMeoifX71e2bn+xwxUhIFt0XY+BOhCFQ1q4uR4Bk1QTTUNeJ3BgazLsZJJxk
	 z+yFKpj3pH8DeoLiZyAqot7m42BA9KOvrch+9SEzanQzmXl7MnknSez4NJVzr5Aqe0vmg
	 FT7RPq0Mra6RKsr1b32dm8XjwMbaaw5eLvxMySZPSiotJV+qkh9XIR5hlXq9P45p/oqCa
	 dW1tLaz6HmXEiY2etqtyDrmgBUg9Po6Wr8+RgHe8DC24HdMOrnF7SuZFC4H0ma/9qWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BI3GiHZy5PM41ztBgWptxPosjP5yVUX7sfT56sMb9/k=;
	b=zNRav5vBH51tlG/ktoGMAZ3+btiuPjMbPNzP3s+abW1GAX5H3Lr/n+AgjLjaVdZmnv1/
	 y/6hPPIUZWg+U3agVSZicUdqt+tjU2Q5CNxGQMvIbGnM04DzFuYTBurqBECgQ6MXQ2StE
	 l8pQbOYo1POTfn4JfDqvgWaa63fkcBWhyhtfVwJue2xXyyESpu1b/m21UfYadTIMxhLGM
	 o+YPayJ8pYS73SHOLlIwtCgWLkFe8+MsScXn1SF3fAHl7Ys7flX/f03wA2CEED1rkH0VF
	 N8APftUChcv2Ku+fbdrIcTkFM5IKetxj+4KTIMwTBW1BgcdhT90ze4/w/xIUvVwJIWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bMu2ZlI2;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C37606A325
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C37606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bMu2ZlI2
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so16598015e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795075301; x=1795680101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BI3GiHZy5PM41ztBgWptxPosjP5yVUX7sfT56sMb9/k=;
        b=bMu2ZlI2o6HCtUAxMfEv1ledyJ03bapITiRAATkmdTsD09Vx/yhmG65NF47xEQyFYM
         yyUHFv/l3p9H9os8ztvdv5Y0xu28YstZXhjuJBo13XU6nqBkRVl4YzAehVMUsAfk+url
         wRi3jJszRTnEDG4/Zo5veRySKoTFPrhH/rByARHkF1AQKsJkrHSZRR5FW4O1AwClPeZ5
         rZoWQ7RwrOLHbxRYnc1bRyGj5fGgHJ4liIAbd3FkXKhVdjDdZFkLMn7bcbQGxNBr5Zqz
         z2DvuN7cJShasX6d2OmreaIpVZUSKLYyB8mKk0ACrEbp86SLBarcz32UGenx2mjGds38
         M/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795075301; x=1795680101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BI3GiHZy5PM41ztBgWptxPosjP5yVUX7sfT56sMb9/k=;
        b=m+7xjr3jzQyj+yGaln3NkCnm02aOhn0i52qVyCvJ/n/KBWhv6Jn+pmeZf72DBnOXqb
         U1pGyrws7bggKsZ73hZOTDHVgiyyd15eg2mLy/5IIV2/3Zf04KXG5JkgzdiyfsAyT784
         MekTdPzrxdQC8PkcgCt/4k5EVUzW+lFOcIspVS2XUoF6fu2C2a9Oe/37n9h/2w7AWZMI
         b6kcnHVH46pMQLGoL4Fzz0sYouCwleSKmGTtadgMz+6qlve+Fjybk7/mtGeSey2VZX1l
         CAzQSuMz7NaScK49aUPkNsFjfoo0q+6B/84kdcgO1TRRHtC0t2k1sETtAbw+bV8VStaw
         MCAg==
X-Forwarded-Encrypted: i=1; AL+hErEmGUKY5Uwo3VLTp1UzuMX14O3wHTKDZdy79uPGR/zbbd/3uxqx9MbTd3h8Rkqoc6VvcWfyni+1lAy0ddmXvYI8Mco=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eFOrM1hb8qM+CT4UL2Ts2okjCGWoXW2tFHo83ub9DCiB5cN8k
	Ou90BMT+OAHuhfyG6hdCXHnNvTDw9oa3q+7fbiUC8+u04aMVuLYrnxSj
X-Gm-Gg: AYBFou3igLdPKwDWD1nyOnnTyGvJxLRpliNLfWCk+OcEl5JAUSavOZmg8phUg8zSEh3
	GJinDI8nxI4OrP6fsJcQUCbgG46UFeGcGUSLUOBx4nJl4qxE4IIsK66NqoWRREo1A7AnEjSnbHf
	qHBpqSstaNGMnEjnysuVPRk6rQUMtAUNvtN+5Gau2iugXcVGrKTDAT0nvVghZpv41uwGyhupNiw
	trn5Ah79MIe5nk4j5i2A8Xrqo0gnhGlMgL5kdb0niYfaQg8sYcQoDDqUcjsKVWm5/Oo0iuI7OJX
	Ajx4JwZYlMYE3+2ku10SWL0CY/JGc5x47Ry1Q108ARh0fopFf5wUjv2RpzYJXBFZMhEaznpi27f
	THMGDTX0upzThTw0a+yJ27XGrpdOg/ozHcI7dZSByPI/xeLr75MgR++CTAd8Lp5xjReAWCaXnyv
	LFoiDtOAV0Cj9qOEZs5wR7eWyPk4w6wKOJLmN4eLyy59LTbXJ2opMPhRSe8/FDzF1Qu/vGY4bpl
	RLt+m5vFcsK1Foi5FbhNr7m2kHviSsXaZjKZw8FxlPUjqSSR/Fu75BjWfhFfTULJxIuP8xGwnB7
	/P84g5jnZ7aGFbxLa5zqFn9G/LUPt+PZgdeBdYYxg3KI9hmzukrn+twiRhYI6y8PzViGVbWfQvC
	wRnqsPsyCZrTjQw==
X-Received: by 2002:a05:600c:1396:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4bb7da21b76mr103724785e9.24.1795075301248;
        Thu, 19 Nov 2026 00:01:41 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e50512sm11628805e9.3.2026.11.19.00.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:01:40 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Wade <danjwade95@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing: Ignore .function on the function trace event
Date: Thu, 19 Nov 2026 08:01:39 +0000
Message-ID: <20261119080139.131834-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the function event, parse_pred() handles the .function suffix
before the ftrace_event_is_function() case, so "ip.function == schedule"
builds a predicate with no regex. Setting it through perf then
dereferences the NULL pred->regex in ftrace_function_set_filter_pred().

The "ip" field of that event already takes a function name, so ignore
the suffix there and let the function event case handle it.

Fixes: cfb58e278c6a ("tracing/filters: Dynamically allocate filter_pred.regex")
Cc: stable@vger.kernel.org
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v2:
- Ignore the suffix instead of rejecting it (Steven)
- Fixes: points at the commit that made regex a pointer (Daniel Wade)
- v1: https://lore.kernel.org/linux-trace-kernel/20261114195914.2678414-1-devnexen@gmail.com/

 kernel/trace/trace_events_filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951bcfc5f..2bbcc2abe794 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1708,7 +1708,9 @@ static int parse_pred(const char *str, void *data,
 
 	/* See if the field is a kernel function name */
 	if ((len = str_has_prefix(str + i, ".function"))) {
-		function = true;
+		/* Ignore if event is already a function */
+		if (!ftrace_event_is_function(call))
+			function = true;
 		i += len;
 	}
 
-- 
2.55.0

