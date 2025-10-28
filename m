Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D84345CDD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672735; cv=none; b=Bul4EW5HIQ/JSN9AqCb7Zb6KMAL8f8SQjU8UGneZ0nTaXrGsci4eqUoRJkONNFqgj0rm/RtWmDTEqWTuTGvhyrg1WM/9pksVhHQnuxE946nnP3XKle7uiGtbp2ykUailRsyMe4PU08BmqEfEn6Wpgxwvu6NwzM44hjGhL6X8i2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672735; c=relaxed/simple;
	bh=0vS3N7Soa4g7PYjFL0nKr3kXyVf5rWwjh7etBfTatEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CAnmxiZt4uoBMM0SP3Bok3v2sMLLRD3XW77UDPC6rkNBP+v5eUyVcBHXKipxl4HKFv80XzQlJLeh8zN8qAdN24oFoWrnNmM6MRbcfBNXwefl/fiMVkiYRVKzg6r5PEylmvMxjOcfxMoLDMfkzYZTY2yx1RiA1pksAGb7tyWVzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAQKpe0u; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAQKpe0u"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290d14e5c9aso87735185ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672733; x=1762277533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UrFn7k+xc8Pd2/cu+Nwj/xLezKCLVWGsy8x1XSrvek=;
        b=AAQKpe0u8G60wXSr2wWohpQEI0eAKngL9Y+sRLfYo9jwKa2uezejcJKwOUwwYiKEvt
         GljKggL948hpKDB9XQvMeIyUoPVr656PYvJNiJRyj7loYQthIl4aC90iwJIku7PoW9ct
         V6Lz/9znpz1D/HuWJjutoG1ZsJwjuQ6NdrvDVhzVGU8/7WqPnEUmlmHIsaJ32gAJO7aU
         vYz2q1ABTJcyBDeMylrQFRpDN3GZ/bxu+WnYK8vE+UO4DAhqYWLoKJHdjd9DE7p3l8Gi
         gwo2DxIeRccyn6SS8+8OugKhj3OaelOm/R2z4K/ioiZcngRmGy46OVIBqfqjq0W05rCd
         ktAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672733; x=1762277533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UrFn7k+xc8Pd2/cu+Nwj/xLezKCLVWGsy8x1XSrvek=;
        b=i/T42Ia/3UqcxNiJI3KbkxO1+r05F44muOlx7AkZYKRuXSb3fHjFJaTuIbTXTGVAtq
         9BLOo5QyADlMtpl/Lmst1hvRyNrogeAUlVLhccoUtvIdws5S9AYq9vW0dxyx7HLl7zeE
         gPIL8zAXUwaWAcP8K8xAZ10AX1/1h5iHhcJNhz7a9P7q4QSZyjnbxsv5DDoRsB27KkpU
         xwCdODWHs9/fay8AphQR0kuYy82zPuw9ImnMaS4vMnRGU6GX2I6lxikv6HofYM/TBLtz
         0vRWI5jslE1BOzhaluNFRNENQHiOcifPcDo6aWJmpiALZz9RLY2XmIL60g5I8M49rLQf
         qRIg==
X-Forwarded-Encrypted: i=1; AJvYcCVkAhDWgW1pptGhoKdXznsMAR2hqQKQO8AzmWWm9R1Px56XSQPB638GJpbmdXh2y69J3CdBJaiejSVgS/XuViYWHec=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBHnQGoBCmEQCLLZDIsCE5Yd/WJ9UOBRI4P76DIjfG8FSPjQw
	ppXBkRFLAhgqxayCIFvqjjNsCs1JF3OleUdgQQcE050JOFFs94V3gBzt
X-Gm-Gg: ASbGncuhMRWuDEisOlm7EKXpGGK1p2bUPPOXD/igSrs5ujZCRXc3g/CGC8BCq0JRYXt
	PsfMjmHby50y86Inpf1rdCxrSXymiPcg9wtW/gmgTGxFd39SibIvLHGGoYR1IAHjy/HXLwjjKXX
	QMuDrPy+yzxQUHLrs8VR/vKbf9sbT8TVJx0UxqSULGSJB3EGHnV4u24tr2hwagma+7KgSv9PZFu
	eGkeHvTISGNJyJyuRfLuDO8FNnbHLc5KP4rJ2LjXbdjcQMTjD87Df/oi2QMWvaQ5qeiKeh5Jol1
	6idUMKmDqDTcG3qZ4kG8AaVgupwYilTQ3NmKvv36Br7mGlFOooN0UBMDce4J1Gur2ohDaBVlE7o
	i7vTVY7Qvzseuvkjndw8rWVswYLSsFmz20yHR/9/vE2xCgwAQhIVynFY3CQ4uBf00wwHIuYnrRU
	U=
X-Google-Smtp-Source: AGHT+IG02RvLnefZ9o2mtq2zskpOd/g913+I6NAvbu60v9XPwQlWNOcuEyIaSYAeCem2GB0HXVJTeA==
X-Received: by 2002:a17:902:e746:b0:24c:d322:d587 with SMTP id d9443c01a7336-294cb3c8a2emr54671035ad.26.1761672732759;
        Tue, 28 Oct 2025 10:32:12 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf33f9sm121854025ad.22.2025.10.28.10.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:32:12 -0700 (PDT)
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
Subject: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Date: Tue, 28 Oct 2025 10:32:09 -0700
Message-Id: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add informational messages during blktrace setup when version 1 tools
are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
blktrace tools version 2 or later.

The warning is printed once during trace setup to inform users about
the limitation without spamming the logs during tracing operations.
Version 2 blktrace tools properly handle zone management operations
(zone reset, zone open, zone close, zone finish, zone append) that
were added for zoned block devices.

Example output:

blktests (master) # ./check blktrace
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  0.110s  ...  3.917s
blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
    runtime  0.333s  ...  0.608s
blktests (master) # dmesg -c
[   57.610592] blktrace: nullb0: blktrace events for REQ_OP_ZONE_XXX will be dropped
[   57.610603] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX

This helps users understand why zone operation traces may be missing
when using older blktrace tool versions with modern kernels that
support REQ_OP_ZONE_XXX in blktrace.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
v1->v2 :-

Remove the extra () around IS_ENABLED(CONFIG_BLK_DEV_ZONED). (Jens)
Add a space after device name in first pr_info(). (Jens)

---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e4f26ddb7ee2..4a37d9aa0481 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -739,6 +739,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	if (version == 1 && IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+		pr_info("%s: blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
+				name);
+		pr_info("use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX\n");
+	}
+
 	bt->version = version;
 	bt->act_mask = buts->act_mask;
 	if (!bt->act_mask)
-- 
2.40.0

