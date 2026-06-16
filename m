Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23E3546CA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632545; cv=none; b=KBXu8pEV16dRZPqztzq7GctFulyFs4rEbA37fXRD3LMkVPPOR3LSQqdV0/QFkI/lBz03RtCLxO0BdX59mNmmq/QW6a1tKta+y15kAY0875Umu1xGWc4F0pw0sdhSpf6utKWN0Kxt14EZYxyewdvLne4sVJBRm9WLXFR7l+U/5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632545; c=relaxed/simple;
	bh=DXPjtg4/TviSEO7XmWxn/4hRPAUBoOP65dE/hyPsigQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVQAcPI/hkA2Tq6NcysER5TnEgSTZyo5nEVtUvb4wteCx35vwyag8AA1cw4Kix340b75Sa9OG7jLORYIrqWCrdTvzsPle5fZ9eqA5q/XlNJiOPqGua1X2qs3yCKZnv50Mb+6KaLnz6blR8TH1v46JouKKHZ6Jx4R6p4nWwmVlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBdKhjrB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBdKhjrB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b3637b90so37895965e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781632542; x=1782237342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpDfViAPLLPTathoex0SLhLjFbatGrByqWEhlJUdD5U=;
        b=EBdKhjrByYqdOQZVljckl1evlovJgEI4od9bYstvw/mVW+103FFMj5CUtEFAc/rfeE
         0IqhI4D7rO0Bbly4KWPrlAM9RjDkINtTVkOTITeKJFhN2jIZ+Scs3kLMAiL6D8UqYzQA
         9ofhRAi81QrRNCB+s5XgK2cC9dJpxsZ1OL1+W7UA4EaY/Fix1V13n6wltAwGycpYs6f/
         3KdJcXttUC3apyevWYyDtLZFj48xcxbZswoi8C4TC33L2lkuQkKhJo2H31yApy05Kkxn
         oqAikzRtlXo5mrHcJx9Fzc4NPOIat3J1QIRsoB4HUcRVBkYiBrRlxXbKU4myKeZt4IJa
         pV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781632542; x=1782237342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpDfViAPLLPTathoex0SLhLjFbatGrByqWEhlJUdD5U=;
        b=XudkpmuJaeMfenn9T7KvtB+vjC4F83NQR8t4+xlb0Y5n8snQ42Ah/SbAaTB3PCWqdL
         58u6DZlFXdckcAsBtr2Kyj9K4Da4OtAGIrHdGa+OTP0Uvp+JhyU//FgG7tQaij0Dsy66
         hsdwBDEPaiQbstFv0UtUHwLiBF1M/4rsbQoTmmp/z+Zhli3S6ttEb/p9iehSMOjDvswR
         9Zv+aNCYZkRbX4/kra9xYDpsOPzjfmiSSZUDQlDM6XgSWnRj3JS6ulybbHTS+3P8huB2
         qH2o1FN/iUq0NRP46KxnFIrxK/HwMfMHWS0yf1qkD4txUbapdD5FE2yC2Ye2nEomrufH
         0iqA==
X-Forwarded-Encrypted: i=1; AFNElJ+DLWnHtgdtp9S9AMXli6V1vGHas8MiIlVwYH+OKq+6mpQLvkZgu6dYbS5ea+hhIFxOn09d4PR5Gxzp5n48axMvkfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVLc7swOlqy3pa0rf1bHk2/zdYqCUzRC7nSUZSuURw2257EGj
	9CJq5uvU1DJXsKA9UAj/iZCEp6xegsscfyoM5RwD91Z88mBKnalq5BPd
X-Gm-Gg: Acq92OG4uSN7X12niGbh/dfsscAFkI1UNS9m5IcQo3SGXxAX4CBGAxz30h+PsWVpfmE
	aVAuuprDQpYwvwV+dStTRpwhX09PBhU+ux4mjOeel3LBCdbCzmiDPX53BmKfLP+zOBugYUCh/sN
	L4bicJQAn7hTzu23SdTaR9PDpFZ7FhaK58gwIGi1F6P/ag2cURyyvZUBMhtY9ulS8JKMThTgNRw
	0lm5EPJhqhq5bDxp/HartQiXJl/B8kBfO1XFmjkIEd+XYbdradb4PL9zt2eZehlzMuF10SrYzeo
	QMMXCxvgNhNXtXxHedDE/urEYkuDGvjqR1VWndZWGYvOsf3YVo4luPMjpUFYeBwmMHEYJd59MVr
	Tw4ZSL/qVYm0+dMx2Z5g1j7lrlBfpVE7KfiIXJcFoxGTs0um32G2Ar1bknuaaZkPovC6A4NqMs3
	e6d7MdQEpfXKUAZD1mh692VRzWYJqF4UFwOxReThwMzzzmnBvTrm0YFQgSyftUEcTXpbpZqBb8O
	lbleMyXBew=
X-Received: by 2002:a05:600c:4e15:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-492333a90d9mr9938625e9.14.1781632541682;
        Tue, 16 Jun 2026 10:55:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm47211622f8f.1.2026.06.16.10.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:55:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] ring-buffer: Fix ring_buffer_read_page() copying only one event per page
Date: Tue, 16 Jun 2026 18:55:38 +0100
Message-ID: <20260616175538.111628-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8928e4a3be34 ("ring-buffer: Show persistent buffer dropped events
in trace_pipe file") split the "commit" variable in
ring_buffer_read_page() into "commit" (raw) and "size" (masked page
size), but the inner copy loop's terminator was changed to compare rpos
against "event_size" instead of "size".

rpos is the cumulative read offset within the page; event_size is the
length of the single event just copied. The loop thus breaks after the
first event, so only one event is copied per call. This regresses the
per-event memcpy path (partial reads, the active commit page, and
mapped/remote buffers) used by splice/trace_pipe_raw and mmap consumers
into a one-event-at-a-time read.

Compare rpos against the page size as the original code did.

Fixes: 8928e4a3be34 ("ring-buffer: Show persistent buffer dropped events in trace_pipe file")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 06fb365bb86e..06155ab3366f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7181,7 +7181,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 			rpos = reader->read;
 			pos += event_size;
 
-			if (rpos >= event_size)
+			if (rpos >= size)
 				break;
 
 			event = rb_reader_event(cpu_buffer);
-- 
2.53.0

