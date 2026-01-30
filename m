Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B041339861
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788353; cv=none; b=XkA4gsetSS/E34p9o4L5AAND2Olhu8STM7Zj+UO9AO2g9zZuKhEuL5geJahAENDe+5n+8zBTFjdjMEl5ST5JBGOVrPwfkYaR70AP+htpae7WZYsln1Tn5KViyDhMUC9LHg0q3IIric6+XD5Y4TgTWZbHj/8+0ZqYpAGLdA4zjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788353; c=relaxed/simple;
	bh=99wzWGEdkRTonWwyXfqI+HzlCRvjWtTR6ckwtLwSpZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsjOaSp+QX7aA6dJ08l66P+lLgLE50xs98ysmkapMvh34xheYnbWxtxjmPmiOShvJHxhrF4IrXBk78M9xuY6fDlxgiFufe1PAsNwwdjKrcs7GdQUcdRcxVusxENecqdyip1ZSqHLdEs/17uXklqrAA87vswcN2ECChpAoYRHXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8Bn451n; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8Bn451n"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so966213a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769788351; x=1770393151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TNU/MztZW32i/HH/UF4By8Q51XWEeYJgmftuLIHack=;
        b=P8Bn451n1IFYXccHD7659x305jT/KCV2+7lbOzFL+36KI5iUOc4KkDvQAZ4f9W7l+0
         Bbf2eXbyM2eUEGYw1MtxyrZBIThb7+7Y58QuNbxeycKwEHOnO2DaGSVaWcMkb8o8zLBv
         2k2xr6w7XLb7lPMauxNa+e8uZA/FfagAHSeOTYHowuvzCoSPYs5IpmRQS4HY6CxsphTC
         u1WzOBXwuToFpz+CucV1a79/hxr7ZntAPL7lNTaJuzIlxgrYN//wQtSNNxnyLz2PTdwL
         NOVm/hBwXnEaeeBe3AxNZh6GfZWzIW06V2X+ZVLDMWEqVOWM3NtRhGKh7m1q49dPkNWe
         tuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788351; x=1770393151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TNU/MztZW32i/HH/UF4By8Q51XWEeYJgmftuLIHack=;
        b=V4UlD59woTbBktXthXIpRbxxRZnUsMH3FzLz32ysjtLhXDMxWseEb/TyX82BWYCaVO
         xA/2Z6eejQeAhCx18kEB9h+5jkCLVMjkryc/Q6PrstNOdTIGjwAL6KWuAk+TdQBkfc6U
         3PuzRWsrXPOPIwbshe8aRgvGncqENhvSTVyLeXVHX+sa700vK4Af5X9yQywPfnEbRKXi
         QRMRPbP2LjOPlEGhiv1YXnk8O84hxvxfV44rB3dYDUxF7ukMJNw/rLPRZ+9aX82xnOf7
         VJJaZ7Ud/GoWrpWVqP+LLJhKV+8wv3U8b/gPmr9k8FQnK6ck4iD6261TAQNcFL5498Rb
         tRng==
X-Forwarded-Encrypted: i=1; AJvYcCUvFo/wkJs15sq7hjST19HJdEqH7F+b0/OnFLV1IkIO4eJ2fgh6p59pAVpH7GB0oz3XWZ155MzySqnrz2A7qxONPm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQclMFMHz9hmhYLlpLcemklyLi76qCmSQaPPclTmC3b039xTy
	ROZHYHlGrX6X4UP06Ia3iSRERMS/M4jWZZ8mkSLYo95SQktqs3aZvpXJ
X-Gm-Gg: AZuq6aKLBLbVNcN6beSB4vREg1f/tMfdmaJIHlDqrFtqUpCQV+FGB9sQf2dSw2lSu6+
	YDGnx1y6AGVr52iii7WwzPZ3Blghe9r5AobMX6uHM1/LNp7Va6Kldw6upjMzicnvKqaSxua+/5R
	stRbqMYIDlwkuNXJcAupHVW9QDBSyRIVHDIFRK7nU6i0Rx5ayNXTpQOQe/CIyu/rivBPgAGX0Rn
	Ep6WSKenoYm33QdU2WaHz5xq3ThFX3n9Zn16s9eo01eD79ZEiXCyOUwvo0wH0bf7mjMZRVNtYou
	8CSy9q+KQLiNQjzRNpxzgy1YegrX2+vXujBU5ZPvY4u7S/MlWof83A2sehYcBr5RJp59SmT6qZg
	npQ/hQXxqZQ+QF5c0PyMJyevhqwPRtGixDj4JXAbwGhNLQKPAQfpTFqsl6DKTOXXQm5V1e9zjt0
	ats4oA5YI2YXbSUkAuP5Vjpenmu8eKQOv9cBqpqP8fYiu4JvgZOyMdXwMZg1MfxiF+LHw=
X-Received: by 2002:a17:90b:28cb:b0:340:ac7c:6387 with SMTP id 98e67ed59e1d1-3543b2e045amr3884551a91.7.1769788351328;
        Fri, 30 Jan 2026 07:52:31 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:563d:698d:c7a6:6a1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f02aasm8449774a91.7.2026.01.30.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:52:30 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	ptesarik@suse.com
Cc: m.szyprowski@samsung.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	kbusch@kernel.org,
	sean.anderson@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH v2] tracing/dma: Cap dma_map_sg tracepoint arrays to prevent buffer overflow
Date: Fri, 30 Jan 2026 21:22:15 +0530
Message-ID: <20260130155215.69737-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_map_sg tracepoint can trigger a perf buffer overflow when
tracing large scatter-gather lists. With devices like virtio-gpu
creating large DRM buffers, nents can exceed 1000 entries, resulting
in:

  phys_addrs: 1000 * 8 bytes = 8,000 bytes
  dma_addrs:  1000 * 8 bytes = 8,000 bytes
  lengths:    1000 * 4 bytes = 4,000 bytes
  Total: ~20,000 bytes

This exceeds PERF_MAX_TRACE_SIZE (8192 bytes), causing:

  WARNING: CPU: 0 PID: 5497 at kernel/trace/trace_event_perf.c:405
  perf buffer not large enough, wanted 24620, have 8192

Cap all three dynamic arrays at 128 entries using min() in the array
size calculation. This ensures arrays are only as large as needed
(up to the cap), avoiding unnecessary memory allocation for small
operations while preventing overflow for large ones.

The tracepoint now records the full nents/ents counts and a truncated
flag so users can see when data has been capped.

Changes in v2:
- Use min(nents, DMA_TRACE_MAX_ENTRIES) for dynamic array sizing
  instead of fixed DMA_TRACE_MAX_ENTRIES allocation (feedback from
  Steven Rostedt)
- This allocates only what's needed up to the cap, avoiding waste
  for small operations

Reported-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=28cea38c382fd15e751a
Tested-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 include/trace/events/dma.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index b3fef140ae15..33e99e792f1a 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -275,6 +275,8 @@ TRACE_EVENT(dma_free_sgt,
 				sizeof(u64), sizeof(u64)))
 );
 
+#define DMA_TRACE_MAX_ENTRIES 128
+
 TRACE_EVENT(dma_map_sg,
 	TP_PROTO(struct device *dev, struct scatterlist *sgl, int nents,
 		 int ents, enum dma_data_direction dir, unsigned long attrs),
@@ -282,9 +284,12 @@ TRACE_EVENT(dma_map_sg,
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(dev))
-		__dynamic_array(u64, phys_addrs, nents)
-		__dynamic_array(u64, dma_addrs, ents)
-		__dynamic_array(unsigned int, lengths, ents)
+		__field(int, full_nents)
+		__field(int, full_ents)
+		__field(bool, truncated)
+		__dynamic_array(u64, phys_addrs,  min(nents, DMA_TRACE_MAX_ENTRIES))
+		__dynamic_array(u64, dma_addrs, min(ents, DMA_TRACE_MAX_ENTRIES))
+		__dynamic_array(unsigned int, lengths, min(ents, DMA_TRACE_MAX_ENTRIES))
 		__field(enum dma_data_direction, dir)
 		__field(unsigned long, attrs)
 	),
@@ -292,11 +297,16 @@ TRACE_EVENT(dma_map_sg,
 	TP_fast_assign(
 		struct scatterlist *sg;
 		int i;
+		int traced_nents = min_t(int, nents, DMA_TRACE_MAX_ENTRIES);
+		int traced_ents = min_t(int, ents, DMA_TRACE_MAX_ENTRIES);
 
 		__assign_str(device);
-		for_each_sg(sgl, sg, nents, i)
+		__entry->full_nents = nents;
+		__entry->full_ents = ents;
+		__entry->truncated = (nents > DMA_TRACE_MAX_ENTRIES) || (ents > DMA_TRACE_MAX_ENTRIES);
+		for_each_sg(sgl, sg, traced_nents, i)
 			((u64 *)__get_dynamic_array(phys_addrs))[i] = sg_phys(sg);
-		for_each_sg(sgl, sg, ents, i) {
+		for_each_sg(sgl, sg, traced_ents, i) {
 			((u64 *)__get_dynamic_array(dma_addrs))[i] =
 				sg_dma_address(sg);
 			((unsigned int *)__get_dynamic_array(lengths))[i] =
@@ -306,9 +316,12 @@ TRACE_EVENT(dma_map_sg,
 		__entry->attrs = attrs;
 	),
 
-	TP_printk("%s dir=%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
+	TP_printk("%s dir=%s nents=%d/%d ents=%d/%d%s dma_addrs=%s sizes=%s phys_addrs=%s attrs=%s",
 		__get_str(device),
 		decode_dma_data_direction(__entry->dir),
+		min_t(int, __entry->full_nents, DMA_TRACE_MAX_ENTRIES), __entry->full_nents,
+		min_t(int, __entry->full_ents, DMA_TRACE_MAX_ENTRIES), __entry->full_ents,
+		__entry->truncated ? " [TRUNCATED]" : "",
 		__print_array(__get_dynamic_array(dma_addrs),
 			      __get_dynamic_array_len(dma_addrs) /
 				sizeof(u64), sizeof(u64)),
-- 
2.43.0

