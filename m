Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F6364E96
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112544; cv=none; b=rVV1xKFlL3v4Vs+Gbi47NAPdQyNnsgf/vSQX7xFWtkNMsZl6TtjYBo39I0zGFkNStfClB4E7z9WwtGO9CGYx2i5vXUcEaoD7tLelLtWZPf+es3ZtKox90F0hinWlsoVxwbLKU/pD/USLh40Bg/dchW2Oif7Fn2nzziarCQPBXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112544; c=relaxed/simple;
	bh=Nv/9q0al+jBIuJ3Kj7e2+vKY0UY7Kq7BiNwGr7CPQUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3x2KBHGgOgjGmViDxO6AOP+glLq7tuwz39i24v0FiOeLcaPn7DF9n1wIqWRX0jIQKnO7SgnOBhzJrOhSUTfBu1/SsXwSj4bq36vgBBf7S5S4MJF9nAZAfoS6BRZTt/u4Kj6LRSV0Mx1Se1ibkQJqhFb4yfDlzhKvHU4lmxv77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQV8dO2B; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQV8dO2B"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8422871b42dso2401558b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782112541; x=1782717341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kco/C0+Wz0VenSQJVDKs4I52yLBmv7P1DBIwbiK0U8M=;
        b=DQV8dO2B2+hG0jCrnd2tOQ0cqsYZdRH2S1LPTens8mMPHfvZVeIPzZn1G6O9w7x5w6
         D2tjn9+vkEIJAOV/ZTKanxfJ55hyGXD/wkV05hVUhhUNgUdBskPIhjsOLSXCUg1+GQyj
         4DsMlOcX3gELdv45IrUqpUIz808IkiKh/GD+SFGsxkzh3ntrvws40f21nmPdQsafwfY2
         qwsZ9bd73N3qjTOcodSRdQDygJ7GxlfcA9xWTU39Y7sCwOS4AOY4AIxUIiByWoXeQmkq
         ORXPkjErpFlZE0Zh8YmhbBN8Jfn2jrbYRpAdtf4pwug7WQqgDnItskPf3/q5maS+6BO9
         Gn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782112541; x=1782717341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kco/C0+Wz0VenSQJVDKs4I52yLBmv7P1DBIwbiK0U8M=;
        b=DiFG/BM3WORZZo8t8OZc9RTstmN9DFbXGLEHnKcOiXxG3DoMJl1Nk7/DCg5DxkT1Te
         IdHRjGeIbmuCu8JkmhzoQyIy1LRdUq8Sw+F66P/OQil7xtRojD1ZiDLIbOIZ20/rklt6
         /prBj1vGhLh9J6/CsNMpvd7bmWKBeQ7kJN9Wx2+FkScBmaoaIomWPIVxgaRV1+YtdGq2
         oVsy7w8qlW2LtCIhj7aUfnMmpYXY1BcHvWm4a+0Ohyb5CNrpjUP5oNkLu66rDxC0bxp5
         aPOWYtox9nW8FvMwnpyhXhYHkTWMFiHvm9GZlMVPV+F47zUd2aqdFbZORGkxJKGI2T10
         JDxg==
X-Forwarded-Encrypted: i=1; AFNElJ9BFR1ANR4f4VJm2Eqr6UepBosC6GSUaocF089DqPH64ml0xaywdrgyeTqnGquZINQEXvfOAFR2whWe07EUdm/fAeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsk9jAiGnqFx55PVODReyw8wdXm0zZ5NugHxkZHp5dHZtsH4u1
	JvGmoD/N8rzq5dphv3zMl3RwTLlhryrL2veCTVvRjkca9AU33bJ+pc2l
X-Gm-Gg: AfdE7clKfPWJsollgRevhHcg1zVl3lwuMlxxVsrgUq4w8G6I+2gsl1ZXO36t+LL8VoB
	+S0GXy2AcAQzVBIj7isnmH96AcMTRJdvx4iosFwFedE+2o/05sW2OA6cLI3xGu8I887jiV8NSEV
	byZQg3FpHSX3mSihLkU28JQ1KiROoLq5+a6uEZz48HmvmRaVEIxqHq8bWDapYD2sj1nwizuj8VQ
	qT52qL3OX7PoH6tTq8emn9cMt4Sz/biRhXFNZWUvjQhGcie73yMGbvDchEbL/8+XT6NtDhasZNy
	Sqa28d8iFZbbxFgsQqybB77MUiTWMN83erTKjZOSn2rBTw8oAq/IX6vyWBIsoeUWg3lVxuWW1ml
	olCSInp/5krASDZ7IicPkdFcnZKTl+oMyiv782cvqZva/4OtZPYW9dsyyxtCQdjSB8OGHtD/0ug
	9A5jfgwLnRyINRdYizhQuK2mU=
X-Received: by 2002:a05:6a00:2294:b0:835:45bf:9660 with SMTP id d2e1a72fcca58-845561b605emr13664241b3a.42.1782112541020;
        Mon, 22 Jun 2026 00:15:41 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d89dd8sm6593794b3a.15.2026.06.22.00.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:15:40 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] f2fs: don't drop the top folio order in the f2fs_iostat tracepoint
Date: Mon, 22 Jun 2026 15:15:34 +0800
Message-ID: <20260622071534.2932054-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The f2fs_iostat tracepoint stores the per-order read folio counts in a
fixed-size array and prints a fixed number of buckets, both hardcoded to
11. The sysfs iostat accounting array is instead sized by NR_PAGE_ORDERS
(= MAX_PAGE_ORDER + 1), which is not always 11:

	arm64 16K pages -> MAX_PAGE_ORDER 11 -> NR_PAGE_ORDERS 12
	arm64 64K pages -> MAX_PAGE_ORDER 13 -> NR_PAGE_ORDERS 14

f2fs enables large folios for immutable, non-compressed files, and the
read folio order is bounded by MAX_PAGECACHE_ORDER, i.e.
min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER). With THP enabled this
reaches order 11 on 16K/64K base-page kernels (MAX_XAS_ORDER caps it at
11). So an order-11 read folio is possible there and is accounted into
index 11 of the array.

On those configurations the sysfs file reports the order-11 count
correctly, but the tracepoint silently drops it: the memcpy is capped at
min(NR_PAGE_ORDERS, 11), so index 11 is never copied and the trace
disagrees with sysfs. There is no memory-safety issue, only the order-11
bucket missing from the trace; 4K-page kernels (NR_PAGE_ORDERS == 11,
max order <= 9) are unaffected.

Size the array and the printed buckets by a ceiling that covers the
largest possible NR_PAGE_ORDERS (14) with headroom, and add a
BUILD_BUG_ON() so any future growth of NR_PAGE_ORDERS fails the build
loudly instead of silently truncating again. The human-readable
"order=count" output is preserved.

Fixes: cb8ff3ead9a3 ("f2fs: add page-order information for large folio reads in iostat")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/f2fs/iostat.c            |  6 ++++++
 include/trace/events/f2fs.h | 20 ++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index ae265e3e9b2c..cd801bd0b910 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -188,6 +188,12 @@ void f2fs_update_read_folio_count(struct f2fs_sb_info *sbi, struct folio *folio)
 	unsigned int order = folio_order(folio);
 	unsigned long flags;
 
+	/*
+	 * The f2fs_iostat tracepoint emits a fixed number of read folio order
+	 * buckets. Make sure every order fits so none is silently dropped.
+	 */
+	BUILD_BUG_ON(NR_PAGE_ORDERS > F2FS_IOSTAT_RD_FOLIO_ORDERS);
+
 	if (!sbi->iostat_enable)
 		return;
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index b5188d2671d7..3e810690d9de 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2114,6 +2114,14 @@ DEFINE_EVENT(f2fs_zip_end, f2fs_decompress_pages_end,
 );
 
 #ifdef CONFIG_F2FS_IOSTAT
+/*
+ * Number of read folio order buckets emitted by the f2fs_iostat tracepoint.
+ * TP_printk() cannot loop, so the field count is fixed here and must be >=
+ * the largest possible NR_PAGE_ORDERS (14 on arm64 with 64K pages). The
+ * BUILD_BUG_ON() in f2fs_update_read_folio_count() enforces this.
+ */
+#define F2FS_IOSTAT_RD_FOLIO_ORDERS	16
+
 TRACE_EVENT(f2fs_iostat,
 
 	TP_PROTO(struct f2fs_sb_info *sbi, unsigned long long *iostat,
@@ -2151,7 +2159,7 @@ TRACE_EVENT(f2fs_iostat,
 		__field(unsigned long long,	fs_mrio)
 		__field(unsigned long long,	fs_discard)
 		__field(unsigned long long,	fs_reset_zone)
-		__array(unsigned long long,	read_folio_count, 11)
+		__array(unsigned long long,	read_folio_count, F2FS_IOSTAT_RD_FOLIO_ORDERS)
 	),
 
 	TP_fast_assign(
@@ -2186,7 +2194,8 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->fs_reset_zone	= iostat[FS_ZONE_RESET_IO];
 		memset(__entry->read_folio_count, 0, sizeof(__entry->read_folio_count));
 		memcpy(__entry->read_folio_count, read_folio_count,
-				sizeof(unsigned long long) * min_t(int, NR_PAGE_ORDERS, 11));
+				sizeof(unsigned long long) *
+				min_t(int, NR_PAGE_ORDERS, F2FS_IOSTAT_RD_FOLIO_ORDERS));
 	),
 
 	TP_printk("dev = (%d,%d), "
@@ -2201,7 +2210,8 @@ TRACE_EVENT(f2fs_iostat,
 		"fs [data=%llu, (gc_data=%llu, cdata=%llu), "
 		"node=%llu, meta=%llu], "
 		"read_folio_count [0=%llu, 1=%llu, 2=%llu, 3=%llu, 4=%llu, "
-		"5=%llu, 6=%llu, 7=%llu, 8=%llu, 9=%llu, 10=%llu]",
+		"5=%llu, 6=%llu, 7=%llu, 8=%llu, 9=%llu, 10=%llu, 11=%llu, "
+		"12=%llu, 13=%llu, 14=%llu, 15=%llu]",
 		show_dev(__entry->dev), __entry->app_wio, __entry->app_dio,
 		__entry->app_bio, __entry->app_mio, __entry->app_bcdio,
 		__entry->app_mcdio, __entry->fs_dio, __entry->fs_cdio,
@@ -2218,7 +2228,9 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->read_folio_count[4], __entry->read_folio_count[5],
 		__entry->read_folio_count[6], __entry->read_folio_count[7],
 		__entry->read_folio_count[8], __entry->read_folio_count[9],
-		__entry->read_folio_count[10])
+		__entry->read_folio_count[10], __entry->read_folio_count[11],
+		__entry->read_folio_count[12], __entry->read_folio_count[13],
+		__entry->read_folio_count[14], __entry->read_folio_count[15])
 );
 
 #ifndef __F2FS_IOSTAT_LATENCY_TYPE
-- 
2.43.0

