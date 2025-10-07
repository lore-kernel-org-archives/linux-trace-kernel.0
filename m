Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6EC1AE877
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797358; cv=none; b=j0CkIrx9PsMR55xprwVOUpL+wMaHNW1HhVNCLoGcYvVZgdpeVVb6bhF1oUzzzMMcWnAQf4oQ5xmo6cT1xi4DwL22GjpQczekEF5FE3n7QqXlmRUFm4ssxEg72VCccxjnMlugZF8Np/Yl6vGY1F1KCbtFi8wH0VEdeJCdxtesA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797358; c=relaxed/simple;
	bh=eaYVbAhT4lR/ZZ5Jro1HbUESdMb7AvVKpDnCTSt+6g8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=se1fuvE+W32Ewua2EYuwZVaADnucS3DAfo6g8GZFfaTobZrh9O9v1svKDwQLqh1sf2Sj9UpK0LLZVfyafbcixjr7tv4TuZJCmuSiBZijq3TArH3mTZ8Yv4rM7Z0t+cc87BfJAfnGx8nJM1/FxCEplrtxNEJIOLzDGOjZQtLJSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--runpinglai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOO0yupP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--runpinglai.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOO0yupP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-277f0ea6ee6so71061075ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759797356; x=1760402156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y6HSIAmMJUhDqfzrB/fS5/kaQRYPRIDkYIlVlDXHnEY=;
        b=vOO0yupPgSf8x/G82WTBytGAtwDlFEcwxaMKzjZf+tykD1yE9LqICuSeXdoVUcp7bT
         lJLNHMSbS9S+KXY2jUqv3JmHPfqN/2qtD3TKMHwydv1yZaQzgiUVyZdC0z6pWGoAjNZC
         lzTrTKyNhUfDdHjKVeDgdKapx6TE8HqIL6PhfnvVTIOQqNyIpJIkzDWCWFoaWYwsmudV
         OTRvAV0kbNK7MXhrzRbNmHo0pLRnQbSA7dtRl/q7XtMoohqPGfkcCnNl4m4gxlsdlSAp
         BsFVUNYZcC/CywEb3iBvthTs5FFKzdmQAnURVcAth+PppETMegLEhMWR9iZ77uBsR2gN
         BRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759797356; x=1760402156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6HSIAmMJUhDqfzrB/fS5/kaQRYPRIDkYIlVlDXHnEY=;
        b=kvb+SNcmXstzufWKw9oU42b+8inNe4bOazhUY4PSVXp64Yg+67mMfi7RfOiS/YOifQ
         mGzIxwnAF6/d8QxMTRRrWCNuUOLGI0y3//skVf3dgej1hbAcHXBXGZDtQeSOkJfBaLuE
         JJqsqIELwS/Gvr2pzWsrc7xJqEJhrdynuJOp+tf66hYUDj18jVxEPXNxGISK5Tq2IvgB
         7BMwTGQ3AwUEvd4MO6bSRiR7XhICII+bn3s6kwAhhdurf6l4XVkx9mr8x8Inzxjqt8Sm
         t8PNzzG1h1hpi7fNAdE0ePymtDDUgzQTRC59prpW1i1s0yQ3+IWq7QM1O3JRYA49B/hJ
         ompg==
X-Forwarded-Encrypted: i=1; AJvYcCVuIFI5cIiAY+449pksy/AZxxL7I1ZuvgTHjdjaYH/7dA8I6Xzi5z6D5dQTnTGOrswYextrBbanGJtXXiIC43ebo10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhN9/y+38nrKi5cufgNbKDtIbqyku27ctWPp05UBR4MfMfcxSj
	nVcjExXXxiRl8NTx7tP4z/QfnEtbtoyTn3lju61qq8YbVf97fT7/8tnwGBx04EJSHtVLTsbJS0m
	fmiDJFlP7reqnBPRBAs+8oA==
X-Google-Smtp-Source: AGHT+IGrHmHhj30VeewmLKDwaHhCJ86g6aH0nKGtqdD2dWGpbW474Z1gxjM8uvB35pCImQIRal7TzTHgTluIfL0A
X-Received: from plhy5.prod.google.com ([2002:a17:902:d645:b0:264:d7d1:2748])
 (user=runpinglai job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b4f:b0:28e:8c3a:fb02 with SMTP id d9443c01a7336-28e9a566888mr176712275ad.14.1759797356148;
 Mon, 06 Oct 2025 17:35:56 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:34:17 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007003417.3470979-2-runpinglai@google.com>
Subject: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page fault
 during preempt_disable"
From: Runping Lai <runpinglai@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Runping Lai <runpinglai@google.com>, Wattson CI <wattson-external@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 3d62ab32df065e4a7797204a918f6489ddb8a237.

It's observed on Pixel 6 that this commit causes a severe functional
regression: all user-space writes to trace_marker now fail. The write
does not goes through at all. The error is observed in the shell as
'printf: write: Bad address'. This breaks a primary ftrace interface
for user-space debugging and profiling. In kernel trace file, it's
logged as 'tracing_mark_write: <faulted>'. After reverting this commit,
functionality is restored.

Signed-off-by: Runping Lai <runpinglai@google.com>
Reported-by: Wattson CI <wattson-external@google.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 156e7e0bf559..bb9a6284a629 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7213,7 +7213,7 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 
-	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
+	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
 	if (len) {
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
@@ -7310,7 +7310,7 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 
 	entry = ring_buffer_event_data(event);
 
-	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
+	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-- 
2.51.0.618.g983fd99d29-goog

