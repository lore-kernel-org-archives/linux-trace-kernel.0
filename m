Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30813273D8D
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798530; cv=none; b=LmKZ9fByK330ou4VlA1HL4c2cFTgIdm8TxihNBg7vUUBkBTy9CieSBbN3EIZtzw89LQld8Osx1gPzBG/8c6rdUIuwwP1KSq22jxMho6sozTH6qqCNCX/kg32EJM90Gl5I6un6gv7WG5z8fMOhlmzAaXCCsRvvFtjw/9EHlQkYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798530; c=relaxed/simple;
	bh=xuQ8QFf8jmlibQWJn+fCCUbp7U1NGtUiH1EfFJywqXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kr4Un9hXB9jzlF546X9E9/KYlbrvwGo5YPdkU/lSXtu75RKyedj+du5rIlMiDNxQQmdoyluY5Ij2l0EgwEOgZqRjwjbeIdVi9HQlXspKOKj/AgkZGcxBLPwze0Rdz1z5TGUY9xyY67TFs+D1jlewrayAk/LVzn7VazmCz/4RbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dprKYGDL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dprKYGDL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83659d38e38so42680b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 May 2026 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777798528; x=1778403328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGAmO//KzqMjyS22/4dzu7gfEipkR6dPnAvU019iFJg=;
        b=dprKYGDLzZq+j1JfsA6HBGrFHDpFiEv+qXWwwJizIz/YMzBTDNRXWj3NtPKZgQCFzQ
         vyMGOMPhB9j62TVOI4Hwl8EhK3PsakzwLceadB+s19bdp6ewd4yOjlD1ySqBcv0YOz7Y
         SmQeZI3/kDKNwUAnG18/V9oUIH9WLU12MRXCkBiAlQ2s1xDV0T830yam3nC0Bl40JEKh
         igDSWiPUrxpTZTmnPqmb0yaSg1F9vlu4Tp/0CJFIuQs699zP0oeUHhyo8XmcIsMfpH7W
         VMFpHQX+q2pBCzsRZcbYKYyUEiEIxHlBpB/BgyD+LmL/xiWRq24Zok6EmsyfRQkXlvkc
         W76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777798528; x=1778403328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGAmO//KzqMjyS22/4dzu7gfEipkR6dPnAvU019iFJg=;
        b=oyhA8yHWwHrsTtPAiBR1TB+nxoG5/ILbzt9J78K/l8EewCilsRulp0rLlOxAZnoa+q
         yKlqY5bVeZFxkUXv0mjU/vsH9nPtRLyXMe/68PUwk3Qm5TpSdOyrFq9oyOgqvdNOBaZd
         Z2z75CUehbaxKKE3jVqC81h1kPaKpIXCJwWpRom/OqsKR9rEXuIJw2+xqspu8w0Ew5aZ
         /tKONJxc/PzV8IUT4zU+QPNwtUab3O5lnuKjIptRltJsYEEWSQFsTdDXt9Jk6wzPxcCA
         B6k6HwM09F4uutae4aENtTshzVWsdkq4U64qVFRdd8i9ZEAilV5yYCRIHN0UxC1bkwA1
         C/Zg==
X-Forwarded-Encrypted: i=1; AFNElJ+EvbL7YlnkTaz7PoN1v7xPPz1KZjKYu0wES4Jr9Gfn7JBqAp7l562oGG1910S8MRUoPM6A3vde/T8E87l6LUUhjBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpsGEyw30YIOx78JE6mZh1YN8VNZYPIjFqpQlMFC5K553ZoUO
	pZFs2BnzhXiqReFMQtvWP6wDkZzT6lgEsLVtapI+EB04HHRaga2mfPWL
X-Gm-Gg: AeBDies4yeWPKyKMXgt/+ZYe7f9kaQ7N8orsMz9XuPNmxOoJssmmyJqKkhp9eOEbtQF
	NVM0BL1paqGZxNf5av+Gvgh2rzO/OI4nXoMRBG1dtAKFdhjv75fr3WB9gbujvG4rWMnuKLVihor
	VLpwgvihHRokaFLTscUS15s7iviAsrG69te96Wsyidee68sTnRsXgaIi54wvHLRpjHkJhnbYYn+
	FtrI4TX006H3jXLx5CKexyd3Ge1FrbtgxeFJKhcCwMQqNV4nwCLHqM88NHsqS3vH4Xt3ICJVlAZ
	bUnLJfCFIysihxogedcSKChM7VHkuiX1qWHpiKRVHInLLyelmG8TNqOHlEGo0BK1eX9sahEVn4l
	I5gtocjPSwO6PHZVjGwveD0aYh5sjkyYyOO0dQTsDAiyeb+3nC5ayFAXXlAMGjKlG0H7cwAj56Q
	I6WYGVJh/D0NKhiFildjg+HRvx+0Cqm5MQoFnuxGdae/t7BQY/Kl6Zybgk4rXc5YVbAIPFTcSVH
	rxB6gECNCzq5C8CDw==
X-Received: by 2002:a05:6a00:8506:b0:835:6388:655d with SMTP id d2e1a72fcca58-83563886e73mr790073b3a.14.1777798528430;
        Sun, 03 May 2026 01:55:28 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ede7:7091:90bf:e569])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837081abadfsm363489b3a.42.2026.05.03.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 01:55:27 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bvanassche@acm.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH v2] blktrace: reject buf_size smaller than blk_io_trace2
Date: Sun,  3 May 2026 14:25:19 +0530
Message-ID: <20260503085519.138360-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_trace_setup() accepts any non-zero buf_size from
userspace and passes it directly to relay_open(). If
buf_size is smaller than sizeof(struct blk_io_trace2),
relay_reserve() always returns NULL and all trace
events are silently dropped.

Reject such values early with -EINVAL.

Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
Changes in v2:
  - Use sizeof(struct blk_io_trace2) instead of
    sizeof(struct blk_io_trace) as it is the larger
    of the two structs
  - Remove incorrect syzbot link from commit message
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..20f941495151 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (ret)
 		return -EFAULT;
 
-	if (!buts.buf_size || !buts.buf_nr)
+	if (buts.buf_size < sizeof(struct blk_io_trace2) || !buts.buf_nr)
 		return -EINVAL;
 
 	buts2 = (struct blk_user_trace_setup2) {
-- 
2.43.0

