Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC452BDC29;
	Fri, 29 Aug 2025 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462859; cv=none; b=As2EQLhJOk/IeD43lgtza6BgHOFhWzn1SkFh9N/GGDI+8lPQ2vsfCDV3FafxRy83mkGdWI7pBIsjTD5L5xyVrOXmSYFCkPUSfD0jfv+c8R0w3BLx5iPbzThILPcMCT6SfeZFObZm/IGWoRRPfk9ma1fb1Rl6Na5tNPK/AI9DjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462859; c=relaxed/simple;
	bh=rTuM4HyLXv0HkKhzB1HqfKGUw2X9cj0CbvmTtW6kJQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g92AMgpCp+1O1dC0xCY6kr4f5AvLYolwDdrReFAVDzYphV2eZxmb9tjLmEzLq2JqB1ltm/66FO98kxg4jmGEPuZiVnKL/+Gs57Mkcg+oPj1IrSQN6XvyQqZrks1/ZlqrnAugElP12x0RF2A7vvZk+uJ2xFUQCvORaG39ZHRBL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApglThvA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApglThvA"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109c58e29so30946631cf.3;
        Fri, 29 Aug 2025 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756462857; x=1757067657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjJb244je6yF5o7DG4HZYvptosAOCAiUrRmEuRTr5Ko=;
        b=ApglThvAFKJ4ROva9PtgzvquGlq8BmCwBcyBpTZY+d3T9XLZ0DMTSHG4Yd+FhKijrt
         mHNwauuiGQQIFrqAgqyqBEVma5HiPfZmztzLKqR28jJZAM6HhQWaQcLzDlcbARlfDGdN
         apYEQ+OjtUN4cZVi2ZXKFOLrr3d/HYcDEPHtoMyX4MW97iH+UG2OwkRkHebP9XYI85aD
         QGMCJg9LSp4eUV/wX5FhMcPhomvsx4/rYdjqsbbro6HUConMa2S5RE5zPJuVG9LIVebm
         8rFrmwrVaDEjhJW3G6zb2Y3K0nqIqz3SBH2Kf88WKENk9SKaQq+y6qO74wXfzbLOxSv+
         0H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756462857; x=1757067657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjJb244je6yF5o7DG4HZYvptosAOCAiUrRmEuRTr5Ko=;
        b=xN95hqTjmht4WUvF7/PVGQNg9CcpJ8neIG4cVX7ai89+ANy6+CxtW4sjEvFtpzIS6O
         Vv/ml5qcvBulIh2AtWKik4L8zsDDQN+UVjEISDfEkmNIsC0RTTej55jv9Qp9qXv/k7KY
         PstOM1qjCGvwLOhxjEkMLZXK2P/U+vSscMYBkI0y0z52IIzqRGZR535RkW2PP3eYuFrd
         IOibMtXsfSJsCTUlUmWUe2b9WgeQdE2bK7SQuGR3b3OLHLsN90FtJ+1f4MsjxMMgX8Lz
         GHMCAPRBcuofhTlk6fujpyioKyQTDKH9SNGkmznV8jI8XVPPVcklRq1DdUN3iThHVnor
         V7rg==
X-Forwarded-Encrypted: i=1; AJvYcCVzkZe0ikoxZdTX+weCAWVid2WSNKWWXo4InE8n0ceHeT+uV5E7rou8ZtvbI/LtBV4qSa6EcdNtdq1PWGo=@vger.kernel.org, AJvYcCXM4eLnZdb/6iFZfhCPRJyKqdY7q3RZIS+FzER+9F4tQnmL96UHU3kJwSKMpkl0lyHxPYZbN7Z8t37aODlSWazT9hvr@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNrYGn4r9v6TOARTbU6l9lhLpCg5TTezpWzAOhZcan482dq6U
	/rGooa8pA4S1GiTXp5ck4T4dYRhobz85VmXgBgSp4+XZW+wF0jzKRPPJ
X-Gm-Gg: ASbGnctD2uzBZVNl5r6w4ETmEWQiLH3r+GedQLGqo8xIBAXiCg9vJ8ua+0b+i2ziLl9
	5HKodDVcSBO6FIw3jtb1d4fyqj5sX9pDTBUfUybCsdmKYzia1kVDWiuqZh0wm0wERWFJmnOcTA9
	uC04XVYTMPrJgNnyQRWmszA2Cgv47XGs1CUPUY6dm0z3hP1DQ/XUaB0nvY0r450Jw8miPGUkR5v
	7JKiDxS0xGm4GBvjT7/g40Qc//g1lhE+dAf14uwtdgeSqXWgkagOdDER7KXnd0EXm7Q9HAkWs1S
	IsmYtz/v6YEYEGYLPl2UB/UU2xmmG5m7DBj6nc7UX3fwryVKQvnlpluZk8oOxZLBkKtKgeF6x1m
	Jk9mG0kEq2LlRKq0QD7lwD0ehswpYjlBQBkPXz3dMFhYYP6u/r1OCIbtcquO2jqUYCzfUp20V9V
	mkbw==
X-Google-Smtp-Source: AGHT+IEpiZCq5IpcaeDaADmwLkP+lAph4VKUk68Z76kgVzdnxSfiYvwF84kDgpFXT5A50iCWzlmDzQ==
X-Received: by 2002:a05:622a:254:b0:4b3:10f0:15d9 with SMTP id d75a77b69052e-4b310f0473bmr10494911cf.67.1756462856623;
        Fri, 29 Aug 2025 03:20:56 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:a7bc:32f2:59b0:ebe2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6de6absm12321771cf.45.2025.08.29.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 03:20:56 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: [PATCH v2] trace_fprobe.c: TODO: handle filter, nofilter or symbol list
Date: Fri, 29 Aug 2025 19:20:50 +0900
Message-ID: <20250829102050.232291-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v2 addresses the TODO in trace_fprobe to handle comma-separated
symbol lists and the '!' prefix. Tokens starting with '!' are collected
as "nofilter", and the others as "filter", then passed to
register_fprobe() accordingly. Empty tokens are rejected and errors are
reported with trace_probe_log_err().

Questions for maintainers (to confirm my understanding):
  * Parsing location: Masami suggested doing the parsing in the parse
    stage (e.g., via parse_symbol_and_return()). v2 keeps the logic in
    __register_trace_fprobe(), but I can move the call into the parsing
    path in v3 if that is the preferred place. Is that correct?
  * Documentation: I plan to update the user-facing docs for fprobe
    syntax. Is Documentation/trace/ the right place (e.g., 
    Documentation/trace/fprobetrace.rst)?

Link: https://lore.kernel.org/linux-trace-kernel/20250812162101.5981-1-seokwoo.chung130@gmail.com/
Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---

Changes in v2:
  * Classify '!' tokens as nofilter, others as filter; pass both to
    register_fprobe().
  * Reject empty tokens; log errors with trace_probe_log_*().
  * Use __free(kfree) for temporary buffers.
  * Keep subject and style per "Submitting patches" (tabs, wrapping).
  * No manual dedup (leave to ftrace).

 kernel/trace/trace_fprobe.c | 48 +++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b36ade43d4b3..d731d9754a39 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -815,6 +815,11 @@ static int trace_fprobe_verify_target(struct trace_fprobe *tf)
 static int __register_trace_fprobe(struct trace_fprobe *tf)
 {
 	int i, ret;
+	const char *p, *q;
+	size_t spec_len, flen = 0, nflen = 0, tlen;
+	bool have_f = false, have_nf = false;
+	char *filter __free(kfree) = NULL;
+	char *nofilter __free(kfree) = NULL;
 
 	/* Should we need new LOCKDOWN flag for fprobe? */
 	ret = security_locked_down(LOCKDOWN_KPROBES);
@@ -835,8 +840,47 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	if (trace_fprobe_is_tracepoint(tf))
 		return __regsiter_tracepoint_fprobe(tf);
 
-	/* TODO: handle filter, nofilter or symbol list */
-	return register_fprobe(&tf->fp, tf->symbol, NULL);
+	spec_len = strlen(tf->symbol);
+	filter = kzalloc(spec_len + 1, GFP_KERNEL);
+	nofilter = kzalloc(spec_len + 1, GFP_KERNEL);
+	if (!filter || !nofilter)
+		return -ENOMEM;
+
+	p = tf->symbol;
+	for (p = tf->symbol; p; p = q ? q + 1 : NULL) {
+		q = strchr(p, ',');
+		tlen = q ? (size_t)(q-p) : strlen(p);
+
+		/* reject empty token */
+		if (!tlen) {
+			trace_probe_log_set_index(1);
+			trace_probe_log_err(0, BAD_TP_NAME);
+			return -EINVAL;
+		}
+
+		if (*p == '!') {
+			if (tlen == 1) {
+				trace_probe_log_set_index(1);
+				trace_probe_log_err(0, BAD_TP_NAME);
+				return -EINVAL;
+			}
+			if (have_nf)
+				nofilter[nflen++] = ',';
+			memcpy(nofilter + nflen, p + 1, tlen - 1);
+			nflen += tlen - 1;
+			have_nf = true;
+		} else {
+			if (have_f)
+				filter[flen++] = ',';
+			memcpy(filter + flen, p, tlen);
+			flen += tlen;
+			have_f = true;
+		}
+	}
+
+	return register_fprobe(&tf->fp,
+			have_f ? filter : NULL,
+			have_nf ? nofilter : NULL);
 }
 
 /* Internal unregister function - just handle fprobe and flags */
-- 
2.43.0

