Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AACC8EB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769753008; cv=none; b=ir19V5ruXKtobivDUkaNKywRrZrWGLrCGrFtfv/PZhTpPpHSCOI26vHOfw/RcWZkTyqFyw95Rxd8ZgeWvaMkbWukiBbZ7VxljEn5OCiqfM/SNy3eN7Cup5jRdDKZjykU2V73GWtTsf1PBf2fW3wq3KCmoTPt4iefLEy3EwNKqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769753008; c=relaxed/simple;
	bh=FDpUgpVlPFoTn178RChwSuN+C4S/NM+JSPAu9IDwR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmueTCEp5mi2OFADu9dlSDmFgxMGyZWvMZzq0nkTuyMJ3EHviWb7+67XmVCQA5V+5l/Z1hqqprVe1pOXg4FnwwYXeWIOespGPxtSMKn+uLgWKxXXLZuq4nT9hpY1XhN6o2FHRgaexGm/nBjRXjG7JAMvu2WCv7rbYGqNdOAdxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbR4DY7M; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbR4DY7M"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81db1530173so865210b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 22:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769753006; x=1770357806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxpWVUjA/Dk4DqI/BdoVtgZaX6ZoJNnGLpzCchKUxFs=;
        b=VbR4DY7MMni3MLq3DJ2k5lDUeXAqpD85u+XY3Jt/AIX9KSDMdQ+HhB2jokk3SUbmJZ
         Yf+PjKAJVl0o1Ka98UH1q3TVs6PmVYufFnzEIXvtkWsaPeYXE19MV00rPbgIM3v4/D57
         uMVG0HSCgytzkcK4fikrXBjRkEieUGFzUbAC7/T4Y71wjyZTTJbc3MqZnT9m8KT2baoK
         xeqN1GKbbz3tgsT6+k2xV+INI6y0EiZrN9ccTBu/8C5s6rVTMRmvcHxI9CeJJnEYbE6a
         97DqbILrluP82Mhroho67jJWSL3xij5rjaDJ/74f1vxrjU3CurDde+qUQg9bHAsHCiz6
         QrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769753006; x=1770357806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxpWVUjA/Dk4DqI/BdoVtgZaX6ZoJNnGLpzCchKUxFs=;
        b=NVWlFQfYXy7ZlPLv4nsGeFHvjG+K0xtSnUZ0VUpXkiMAj9ZeDtAwBAnha9ohlnya9+
         8a76iONuSLAQU+tiGhXxkeNjF7JV0Q/PkRazRreg/ufe+3GXf4ThSK7COilSCPvBx7zs
         EtfhLV1zu2LIAU3+xghLWIRoCTiAYNQPmrTh1/spOZN+Safutg6MAyKlxFYzv1VzfxES
         zkV/Cf6yltolvf4psb2cbmq+OShcDAClrib6rz1Hxr5Z/bWe22UD1PkboBkoz7a/JGcD
         GeH68av0hYZqIr2xxg59GnMIC3nte49E4OcblMyY1TCkXGv0lNMplL7i5CYJVLQlVNcl
         5fVA==
X-Forwarded-Encrypted: i=1; AJvYcCXImlV0u16eH4jNCw1y971+I2sH/vrRQ6V8eOHnm+d5xtzU5+EXs8WtMRa4uX5kOyhva+SZbGPSrLpvbq90XDEwhxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjOnRVpVEwoEkotIZ4SWKxpHxAmV28fSim8FLsDhqkgjqhfse
	cg+Eb0x87q0JdXS900AnSmLu1BUeed8g+a3oCcUTeQB4aRjaGBlGOEQ/oKAZEQ==
X-Gm-Gg: AZuq6aKRtdMrEt6owQTbA52MyZg02DppGsVZEUa+Zwzn+bIXL1GtU8vme0FZGQ3zImt
	AZVnscSXoAzEKehBKi1UDrtawTO10VjrIYmPkI4MLq+h9yNBkWS6RVPVN0oAjIWiHhJ5HB3Xekl
	4Fjf88j2otMMlHgJmOVIG4+8oEoWpvz5ZRHYPevwQEBB0HVeMrvNmr8qgILs3zffsEqeNUf2ubC
	rSIySkqs6lmeQhLDDp6c/T4S+hQU5MliuTLHvB0hr/LjrInJZEQYiGgJaw7AT5VfvaWNga0/K+5
	yAfb4NRiBaQzR6xskaxSUOKw16fz7SomWr81Rn7FhjRdCHJBDQO7jAjjcflO3NFOPOfac9ulEnf
	OyvBTaslEvBD5Mmpj2SqYk9qd0/K66CJno7MMA35HPSn3CLdiyUm4fHMdbxztfvp5XbTsfRcuJI
	dssNFoBtgzsdISYrq7+EfHfGQve8NLDwotRiUreU+GEX77hz3UTUeNSkWpAV6yFt4KXnkgR2A9F
	OCo
X-Received: by 2002:a05:6a00:bb84:b0:81f:4abd:f15b with SMTP id d2e1a72fcca58-823aab730e0mr1865736b3a.58.1769753006110;
        Thu, 29 Jan 2026 22:03:26 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:46b0:a00:42ac:8b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee2bsm7474508b3a.3.2026.01.29.22.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 22:03:25 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: m.szyprowski@samsung.com,
	leon@kernel.org,
	jgg@ziepe.ca,
	ptesarik@suse.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] tracing/dma: Cap dma_map_sg tracepoint arrays to prevent buffer overflow
Date: Fri, 30 Jan 2026 11:33:17 +0530
Message-ID: <20260130060317.54522-1-kartikey406@gmail.com>
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

Cap all three dynamic arrays at a fixed size of 128 entries. This limits
the total event size to approximately 2,760 bytes, safely under the 8KB
limit while still providing sufficient debugging information for typical
cases.

The tracepoint now records the full nents/ents counts and a truncated
flag so users can see when data has been capped.

Reported-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=28cea38c382fd15e751a
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 include/trace/events/dma.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index b3fef140ae15..c4e1a9f0c9c4 100644
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
+		__dynamic_array(u64, phys_addrs,  DMA_TRACE_MAX_ENTRIES)
+		__dynamic_array(u64, dma_addrs, DMA_TRACE_MAX_ENTRIES)
+		__dynamic_array(unsigned int, lengths, DMA_TRACE_MAX_ENTRIES)
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

