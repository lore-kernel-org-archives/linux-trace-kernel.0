Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEEA3BB684
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199611; cv=none; b=gUebFAeqPS1glgAXu2qjUDRu/AdqA2m2SLAPCucAQEsc1Z2IUjUtMvghZNNo1yaaTJaziDI1QvGeQB05+3wwTRfhLMDg2T9pBcwdARlGbzBja3LkFHPvQXtomCklPWDJG48X840Q/TczYpaowILpX8Pz1WUjyPgsgSqA127lGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199611; c=relaxed/simple;
	bh=8VkazeSEIBkEWKYXfN3/pxdnfFUNnahf0WVmLIxhgIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dK34rTRYNHniDybuJPz2enDy9EvPGzn/S/xBEHEFElv7CaNP7NFDaidaHTaYppC4EZcGyCfoWGkbf5bDtWTRW7p3T1aCRSTcJjmd9hLfse53MzcAD97cgrSEy2lpCBtb9/qPrYt7kdKuqtXv1rmw2+65atERb8PpjQao3gE2v3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZdj8ZZe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZdj8ZZe"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8422f148dfcso2936434b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782199609; x=1782804409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av163n6vLeJcN4V8gx196RJyV5mYzpTIV4U25JqmgL0=;
        b=dZdj8ZZeo/JFJLtv+AkQRnViAQtCi3qFZfwirz8A5fNTiGI38NJR6JaXYb3orKXnPU
         yVxirDyBeMm/W9Wk/u3CgZTY0nQvyrO9Adbx86dhshHKWJizHtBzpbVovVeslh6018Xl
         6EpM7Ovx8I121fD8E+RtAoC0aV/piPp3epT0JX1MBzGPVARCYqCbstG8t+IVOdr1Pk2e
         MX7lldA/p/rtAR153iDAElKrZvfLowhZcS2Zm5HYqx9ZwWmtdV1ozR6Ze3b/Yc00z3MN
         ebH7sVEpoqR/ywkWuv94nMTCEjnDjvAYlTRK4yTyFZdtPyyIXBZuwhalnL6s63SxUwgP
         Z56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782199609; x=1782804409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=av163n6vLeJcN4V8gx196RJyV5mYzpTIV4U25JqmgL0=;
        b=TG1/5g9Bf67PtKbrBqJ1zyr197i0OwJhnbybM/wdnoriGY6loW3gnb2n6Nsdq9Ia/I
         3CD71cTloQXcKlFaitWfGAKLeW6zSMMcBcnqAycTYcE9Jz71RAfBHByCYOMw2mdol/Oq
         NWOrADrIcQqxJaW8cFfsc/o/rIQOXCFxDR3IuHF0wS3VCPE75dDo7ta/NLjuoxtUK7KL
         rMLHd0LJ/63IXrga7A3g4/cVhgNv7DJE2Jkj7GhWK92qi072vay/hniwynXZTX6dk8Js
         1VcJIRHXfPTtM3TTV9lp1hSplbMPUD8wgk1nL5uJaytly+VFxfgcmSFTaGqcTfJiyz1o
         urYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nKL5O1WV4RpCGPdvFjolBWyHSNHvQ3SzCx3CcA+2ACTlpTiv5KfqlDDlm53k6o7vNXc5JVUW5UqqdQRQPLCAVTe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuQ/aGi9eVFwHObiIccbRV2rbB1J9kGGPR7A8fVoexGXXiiRy
	QlnwQT0SaUsPtnVcS1w3gbGhEyMYtIGj9BFNYTGiDbsOcZZMjWlNFZAc
X-Gm-Gg: AfdE7clP0p237mN8Y7pqMNkFn7SxRcjltmyZcK2I90K1WbUTbCVX31oS0kOJRXW0r68
	KeidN6X3sFQ+dursVhH1pv1QymHodN2RTP1ACfbK9Vih3a3v6ZPADTo53SP8sJoPs5zNfUWcUAP
	oA4xvCjFsRlypQ+h9fE+kJ29gFJ3BTQg7sxZRoHllLBX0bksB+9/eLelTcx/cXXuH+xYnYLZ11k
	F5wt9yhAU8k3i10IGaFrVR+QDEJEMQxKp5BpGpaGjIacjUwtJ9i/PkZXUoXTEFNcFBys0isBqn2
	zad7Uo0ZF1nfbKFs6Xpv8X/zjhC8SndMlv+ReefeHWTAsoj1Vc9pDYLjJINKU6+t9jQZH9DwHLR
	AprH6oS08oel04BihzdY56iavpuLg7WxtRKklIrXM6JqbMy6J4fiTHR3+B5Mz5QhTxYuEFe4PNl
	W1VcmGD5jahcJZn3gZ5eDfu7M=
X-Received: by 2002:a05:6a00:1814:b0:845:4679:4a3 with SMTP id d2e1a72fcca58-845507ec58dmr19012459b3a.19.1782199609144;
        Tue, 23 Jun 2026 00:26:49 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8dddbsm9782523b3a.19.2026.06.23.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:26:48 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Daniel Lee <chullee@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] f2fs: don't drop the top folio order in the f2fs_iostat tracepoint
Date: Tue, 23 Jun 2026 15:26:41 +0800
Message-ID: <20260623072641.3547410-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69618bed-db94-4503-aa9b-c78fb51a945c@kernel.org>
References: <69618bed-db94-4503-aa9b-c78fb51a945c@kernel.org>
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
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2:
 - Move the BUILD_BUG_ON() from f2fs_update_read_folio_count() into
   f2fs_init_iostat() (Chao Yu)
 - Add Cc: stable (Chao Yu)

 fs/f2fs/iostat.c            |  6 ++++++
 include/trace/events/f2fs.h | 20 ++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index ae265e3e9b2c..12d4e18a6a50 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -332,6 +332,12 @@ void f2fs_destroy_iostat_processing(void)
 
 int f2fs_init_iostat(struct f2fs_sb_info *sbi)
 {
+	/*
+	 * The f2fs_iostat tracepoint emits a fixed number of read folio order
+	 * buckets; make sure every order fits so none is silently dropped.
+	 */
+	BUILD_BUG_ON(NR_PAGE_ORDERS > F2FS_IOSTAT_RD_FOLIO_ORDERS);
+
 	/* init iostat info */
 	spin_lock_init(&sbi->iostat_lock);
 	spin_lock_init(&sbi->iostat_lat_lock);
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

