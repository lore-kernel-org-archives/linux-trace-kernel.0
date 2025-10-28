Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11F288B1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625974; cv=none; b=m3yhnG13mIM6LYUH56d2hR+kWsWaZ3et0n53OiQ9mX9j+ANC0Y5+lbKFsDT+gVdbK2CSCA0FZU6Nf6/U4iUoK9EX39vNcWj1UydhDEfq33Ws5XiVDMkBXDTs05sH+OwApneC4rxZiOzrpQDBwZzexkh1OR3q+VP2XkTnai8bm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625974; c=relaxed/simple;
	bh=S/lne8wybyE1gO5htDFPkrjiiUfBJTJUUGjSUp3mgWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q13BVs6HrfnPsN7+L7RT8isdMLIWDQT9Ulyd2Fm1bcG8iLvT+vIzzeIu1LbTrZShNZomQW7x8Mzk30RsqoNzqG/5mfjzikYYOD/ZswF2LkiFiY+xDjx2J4cZm+SM94Z7tJItiSNJirzfOuFhp007mzzjXnRKhtTKvpyOFS1ol8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMHnOLzP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMHnOLzP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso5347055a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761625972; x=1762230772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TXKHptYyH+Ht2HxkkCZQsOl8z28P1fxyA0/H0EwTQI=;
        b=LMHnOLzPeBtSvYILtN2gzRx1+T6YLxZTdP2FKIocIhpWpeMmKraoRkpZq8ooLt3ozn
         L+aCRVKnOM439xw+UojizqwEAKT5C9gUORI7CbsHWcnYuR5s1YDe8jHR4GSqJSoBtxQp
         gaD2pbZqTxxhVng0zaLPyqCuaIL8GsuD+/mCXbkksTviFN/ztTDW3dRVmdMVt23bmZai
         X0kPEFow516jCTu8OSRhKcaeAtLoUVYo0V9on8ombka2St/Bj6WbhsZ/2jMp6uCYM0IC
         7NDFoJF8fPJsO2TZ6d/063FI/PrXSPWMDH7RVKSCfxBsvjEFrmJCA4xNeI925JsB3c0U
         Rlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625972; x=1762230772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TXKHptYyH+Ht2HxkkCZQsOl8z28P1fxyA0/H0EwTQI=;
        b=wtiBZa1hQEnI806rxy8x7KJtb/1iF951gTgDgfOZTdvJbT9VxfQJ6L9XLr7ZQymPq3
         h0dvMBBFOIou8a1BmBELhb8wqfHlwug9O96ctVV0Q6iNUMgIIi0R6M6TkDIS1ygctaRL
         tMLZUZrL3W90G/66agRncrYkkB+dH01Th3+ts2+lU3WggxeOojeGYc1Uk0lPS556pS9o
         EkfCeFipTTeVTMntdiHPymuQQbPzJaVq5egnhp72jbqIxOyL4FNt2zURUi6YNHUuSByw
         YNz99Ph6VNXvx0ARt144Fene9xwiOlV0wPKX68Zm9Q3CNJH4kOoG60lnRGRwCbguDA6h
         lmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVstabGU/pDWF/uARBkAg7TX50l5qeyhBANlVhv0bJ/Z//i6oVWuoP84MTuP/L8Dv5RByFovVGc3tjTiBw77mGPKIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxeu+OxwxDFv98X+DKb0qmF/UPOevUo1FV/u8aZwa/DcH+IE0W
	UkI8v34DoQxjTv0XtUsVQLx+LAdw599YtiHThPflW3udi9H3LUh+d0hr
X-Gm-Gg: ASbGnctWtqMCEzN0IaPj5PnAZHd6wgR1WRT7R9A2cXEd8RUPdnK5KETN+luwcIi3i75
	pNZYd4Jcs4WOZyuz1pXwa5MJdzEIgllZWIPy8XJqZRJnd37nbl8F4MoY4J5qBQlf941af/nxX8R
	3pMz1IMQDPFdSf8jxuRpS7snYdxwKxra5yHythxK5LbuzieXEzfkqBFY8ByNBzh6NarmIegWnWF
	jCu2wyyFaaFLVJln+rFux/C8NLDj4bpoos6ubfGbqhgBR4CpoKqQYANUuCFohV3pBkH/kwv02z/
	fLIUAqhtH/UsOgAycPF41ztMM2x6PKN6NNepopghTtvITcDlYuw5LrzQaLzD/8kkEGVzZUH7h8e
	r7MY6JKstXF20YOurm2stPFXZ/f75udY9oPzCk4Iw8cgLetHbzL5UyWhh3E7oI8dB
X-Google-Smtp-Source: AGHT+IHO6nGqRH+A9osLM89yQ2mH2wz/2VUNsGYa2/Nw7fF8/pMHkXQuIu1wg0vyQuBPzr8zUy6OJw==
X-Received: by 2002:a17:903:38c5:b0:24c:da3b:7376 with SMTP id d9443c01a7336-294cb3a11dfmr27045135ad.26.1761625971756;
        Mon, 27 Oct 2025 21:32:51 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm99416565ad.107.2025.10.27.21.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 21:32:51 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: Johannes.Thumshirn@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	dlemoal@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	axboe@kernel.dk,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Date: Mon, 27 Oct 2025 21:32:48 -0700
Message-Id: <20251028043248.2873-1-ckulkarnilinux@gmail.com>
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
    runtime  3.882s  ...  3.866s
blktests (master) # dmesg -c
[   95.874361] blktrace: nullb0:blktrace events for REQ_OP_ZONE_XXX will be dropped
[   95.874372] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX
blktests (master) # 

This helps users understand why zone operation traces may be missing
when using older blktrace tool versions with modern kernels that
support REQ_OP_ZONE_XXX in blktrace.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 776ae4190f36..200d0deb6c90 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -690,6 +690,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	if (version == 1 && (IS_ENABLED(CONFIG_BLK_DEV_ZONED))) {
+		pr_info("%s:blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
+				name);
+		pr_info("use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX\n");
+	}
+
 	bt->version = version;
 	bt->act_mask = buts->act_mask;
 	if (!bt->act_mask)
-- 
2.40.0

