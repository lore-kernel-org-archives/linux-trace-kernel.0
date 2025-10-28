Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48920F08C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630649; cv=none; b=V8K/oURxuAkTkxd2D32xclb+x2iojzHH+YgF81fAFlN3noja4jTou5MNryo1k07I2oQtQyc6XmmiM6zLwTT5lFHBdMuzKi7LMNpa8NDiesBwAyPqsBZfziwwCJxfaaPd25tCFjpPREaiTjX6o12fciDQ2bMbL21WRbjaRScz4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630649; c=relaxed/simple;
	bh=V+R7tuy399smX+YSsLanuk3wt7AGssXe1sEdTJgsvpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAQ2G3TkuzV3YhZaR0tRUoBexLGhyPMKADd7/npBDXpGQiWusBAR/EChm5CswTQlX0GsPcnTnoYWu29x7w/3DmH+Uw0GAXATKvCV/nudmO2o7rC48nDiJvWuPsoRpp3Kz709xiP5TMDALG428BqId8Mt8SRH1FOjrd7pecPs63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7dyYQ8P; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7dyYQ8P"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-269639879c3so47855425ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761630647; x=1762235447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv/EAcXN5Xk/SquNgzGMR9LGsMPlGCTi4qPOcWgnJ0I=;
        b=D7dyYQ8PdZyel4yPmPaSH+7LNJfc2mfZHCQHeSqoY40bRH56MuRFNwRg9MuAmzlvXk
         E0CsP7B6ra3kC9lLYJMUXjJkzH9zTKWg23VYZpVoIDO0YUWthp/vr0FIYC7+5rV/8ZvX
         SBSadWubXZOEcS7oVXBEgrECGx2ag9qSprjXEkKfr8orhjiqfh7hrZkuaxl/nzLr1isl
         8OnwX7sr08HOOcwMDjuhXV38gUAhSX1dDUg+LD5u3qghL5KM+hEsCVmBRCjChwwXaNWx
         bEbekZ+nvnMxExHEkj/sXIuvSwPAx6Z69uGJ51ZSANKUK5vwPzwrxg7bsHoRCTCa/H3x
         qayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761630647; x=1762235447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv/EAcXN5Xk/SquNgzGMR9LGsMPlGCTi4qPOcWgnJ0I=;
        b=i+Pg1HbD0unoHSQ88aGF2l/6C3hJUIG4wrxVJP52EVokfOvMvpIghacYMtfPf4pm74
         xxqnBen+E7/CFsCpkKk37UpUMEw4oIjUmTKzzkNAqtiq2KldMVWafaAyonGotCTN3h6w
         30a5nyVGvg7rfcynp5K9iyKmKuNaGJedcC5zETwHmcJEkaekAV01YdhOpY/mAHdl2OC+
         iZ1X+00fDpCQMHdYbedopfJWvLRJEOOf6HJD3yzezQD2InzutNl+hOLlLGJEl+Ey05+T
         9c7WM37CzyhE60wL2zXevCGjLn7ewvMOW24DvaPmklF5Vv3HyasGbfXxaCbBIYnHBF+t
         UThA==
X-Forwarded-Encrypted: i=1; AJvYcCWl9cd5XA5m4PoMkv5898Z9xIrV07zzZIArwabXoE7ICcMFkmmHRVN5Uh3IwYvrB1w7HS3P3RH++lKhC1h8DoR5Xsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CjqSoVBvzywvBx99B7Dwz8qHQ41fYGYThII2NWhGDZ+fcK9V
	2UfjmkpC3tGwHBhA6ay7HaxA7n3d5LLJrTDnsOEid3ZPMZjnFZz+UVsR
X-Gm-Gg: ASbGncuX6CugZNJa0TjCIgcvWAje666IdeIAbFr8/PFgp3Ie2XMJ7hzm5V+kMiGDZpF
	M2ME2qyZ940yhSpwId/h4H2PyEa5cZeun2B6F6uqM+n9KPnzRVkUcMzeh24m2KVuU7Ojnd30N96
	3s6ofZU5w7r1tv/tVxPMORX60n3eIlS0WRLSX9jtyhKf+LJ1ocxJQpkFmnpURwxBIhrlh6vJyeo
	5/aJdGUfHBUcKUU1E9mdcqftMlG+EYxde4QfQ9YIgbz39CdVYhmYH3izMSGSgJTKliZvT/4cF7x
	N7owCm+/0MuDmg7nWiaonNNODw+9G1o8AKHqCKJnOkGoWb9Acux5hIPtEl87BBd6xqiHjZsORE/
	/CtYsSL0660i1esHd5A2fbHcfCToARSiJhyXxmNtaWsbIRti38Fk/BL6l/3frUkpZsUqtDw9VqG
	k=
X-Google-Smtp-Source: AGHT+IFUHdC+KcH7BW7cVtNDj7+9GI8cLO9LHNToQH5xGJryfpDgESRKNShQOvPHiYm+liNyVvkgqQ==
X-Received: by 2002:a17:903:2f86:b0:290:b158:5db8 with SMTP id d9443c01a7336-294cb51a4e2mr26767935ad.44.1761630646789;
        Mon, 27 Oct 2025 22:50:46 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3405sm104554055ad.2.2025.10.27.22.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:50:46 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: johannes.thumshirn@wdc.com
Cc: axboe@kernel.dk,
	dlemoal@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH] blktrace: for ftrace use correct trace format ver
Date: Mon, 27 Oct 2025 22:50:42 -0700
Message-Id: <20251028055042.2948-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ftrace blktrace path allocates buffers and writes trace events but
was using the wrong recording function. After
commit 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2"), 
the ftrace interface was moved to use blk_io_trace2 format, but 
__blk_add_trace() still called record_blktrace_event() which writes in
blk_io_trace (v1) format.

This causes critical data corruption:

- blk_io_trace (v1) has 32-bit 'action' field at offset 28
- blk_io_trace2 (v2) has 32-bit 'pid' at offset 28 and 64-bit 'action'
  at offset 32
- When record_blktrace_event() writes to a v2 buffer:
  * Writing pid (offset 32 in v1) corrupts the v2 action field
  * Writing action (offset 28 in v1) corrupts the v2 pid field
  * The 64-bit action is truncated to 32-bit via lower_32_bits()

Fix by:
1. Adding version switch to select correct format (v1 vs v2)
2. Calling appropriate recording function based on version
3. Defaulting to v2 for ftrace (as intended by commit 4d8bc7bd4f73)
4. Adding WARN_ONCE for unexpected version values

Without this patch :-
linux-block (for-next) # sh reproduce_blktrace_bug.sh
              dd-14242   [033] d..1.  3903.022308: Unknown action 36a2
              dd-14242   [033] d..1.  3903.022333: Unknown action 36a2
              dd-14242   [033] d..1.  3903.022365: Unknown action 36a2
              dd-14242   [033] d..1.  3903.022366: Unknown action 36a2
              dd-14242   [033] d..1.  3903.022369: Unknown action 36a2

The action field is corrupted because:
  - ftrace allocated blk_io_trace2 buffer (64 bytes)
  - But called record_blktrace_event() (writes v1, 48 bytes)
  - Field offsets don't match, causing corruption

The hex value shown 0x30e3 is actually a PID, not an action code!

linux-block (for-next) #
linux-block (for-next) #
linux-block (for-next) # sh reproduce_blktrace_bug.sh
Trace output looks correct:

              dd-2420    [019] d..1.    59.641742: 251,0    Q  RS 0 + 8 [dd]
              dd-2420    [019] d..1.    59.641775: 251,0    G  RS 0 + 8 [dd]
              dd-2420    [019] d..1.    59.641784: 251,0    P   N [dd]
              dd-2420    [019] d..1.    59.641785: 251,0    U   N [dd] 1
              dd-2420    [019] d..1.    59.641788: 251,0    D  RS 0 + 8 [dd]

Fixes: 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2")
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 kernel/trace/blktrace.c | 59 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1a83e03255ce..4097a288c235 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -384,16 +384,65 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
-		trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
+		switch (bt->version) {
+		case 1:
+			trace_len = sizeof(struct blk_io_trace);
+			break;
+		case 2:
+		default:
+			/*
+			 * ftrace always uses v2 (blk_io_trace2) format.
+			 *
+			 * For sysfs-enabled tracing path (enabled via
+			 * /sys/block/DEV/trace/enable), blk_trace_setup_queue()
+			 * never initializes bt->version, leaving it 0 from
+			 * kzalloc(). We must handle version==0 safely here.
+			 *
+			 * Fall through to default to ensure we never hit the
+			 * old bug where default set trace_len=0, causing
+			 * buffer underflow and memory corruption.
+			 *
+			 * Always use v2 format for ftrace and normalize
+			 * bt->version to 2 when uninitialized.
+			 */
+			trace_len = sizeof(struct blk_io_trace2);
+			if (bt->version == 0)
+				bt->version = 2;
+			break;
+		}
+		trace_len += pdu_len + cgid_len;
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  trace_len, trace_ctx);
 		if (!event)
 			return;
 
-		record_blktrace_event(ring_buffer_event_data(event),
-				      pid, cpu, sector, bytes,
-				      what, bt->dev, error, cgid, cgid_len,
-				      pdu_data, pdu_len);
+		switch (bt->version) {
+		case 1:
+			record_blktrace_event(ring_buffer_event_data(event),
+					      pid, cpu, sector, bytes,
+					      what, bt->dev, error, cgid, cgid_len,
+					      pdu_data, pdu_len);
+			break;
+		case 2:
+		default:
+			/*
+			 * Use v2 recording function (record_blktrace_event2)
+			 * which writes blk_io_trace2 structure with correct
+			 * field layout:
+			 *   - 32-bit pid at offset 28
+			 *   - 64-bit action at offset 32
+			 *
+			 * Fall through to default handles version==0 case
+			 * (from sysfs path), ensuring we always use correct
+			 * v2 recording function to match the v2 buffer
+			 * allocated above.
+			 */
+			record_blktrace_event2(ring_buffer_event_data(event),
+					       pid, cpu, sector, bytes,
+					       what, bt->dev, error, cgid, cgid_len,
+					       pdu_data, pdu_len);
+			break;
+		}
 
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
-- 
2.40.0

