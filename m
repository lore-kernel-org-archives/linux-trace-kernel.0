Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89F3939BA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Apr 2026 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679965; cv=none; b=pGGzsSx1ibFFkk1h/3QvBWApNcuXGsEQfKsykg1+LifaciL8HX9M7ZCOPMQ6DcIXntV7IrbGNGme3REUiUwzi7eXRncscwiA1QfLngCvARL6r4Pj/Rsx0GYkaVBMlGeBy5QKW13nfRkMMb/Sai2KnVvz7ChUgphADZxY4ASYahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679965; c=relaxed/simple;
	bh=wA4pb5TYsZCbVGerj9AMDdSKH1HM3A5MXAwM35sraP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuLw8vNfbMWrQNqpvcti3zx4ZeWZuMDvuFZVCDc7hPDH9KPqXmf30EhAHuZcyTS3qbr2YNCCForwWU3i3uZg0SdVR6+NKyCrg4+4sgfI56M9Qe/zb/GJBufwGjAq+pQRO5g+s8GphXuDFxzqCPJJ6+Ia2PBXWEJoKzf0BdKmeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWKRb4lU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWKRb4lU"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso520488b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Apr 2026 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679963; x=1777284763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=triQtU58dGrA9pODEehX+8XkzYrOtE0BAdNOw387JIc=;
        b=bWKRb4lUL26HHA9zKOVh0KVcVr3cHzdSoxmQ9y1zGXSPm5gvljOQ+6IkniYk/oC/mV
         xyWyXeXhLl1tk1TC0zS5IAhUX0EfKJFwBZOYQcRVL9cZPQmy5hgeUd0aDHsitpgNIvzJ
         zwQoqaw5bBWzQ8I6TstqTAc1Wx3cqvnwxJrDj6FmYTyZ/FN8dPvl5Fq8QzbhkuCqq/Xp
         X+rhvfBnwOIZqBotAmSljtMEoocsCGwAhQL6zsYyRtLx0JkpoavHopED34w/xmKBKzQm
         35m7qm19UNjjqubDhgbsVI1wqZN0soAA9nuYqhdzwcpXg3XLnRxeIz6/Y8TDDJ/sEJz9
         Cfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679963; x=1777284763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=triQtU58dGrA9pODEehX+8XkzYrOtE0BAdNOw387JIc=;
        b=MUNQvNOtWHvLUFQHhZlxIGUoEYYsgojQ31u0Tss93m8LMDNs1hIhhB9OxkLiAZ2Ax9
         /F/lRPbkzS2l9BfO2Mk9wKGWK+MDB2CCEqVYV5uaU1DhweBCSXVgyhbfFx5CyjpLGgKZ
         +IS/TzCnxO0hfZITK5dNCeAcBikFU8d7OrXbGpyIv5TWjNoaipDnTSpno3JqNtZxMtos
         xGK3n7Gy5BO3Ps0v3MqeBw4zVtjDC7BbPWcQJIZQB5qW5utGZT6G5KGSkcmn/1aZUJp+
         cRDfgUeP6yDArVdSdaMA0mo6s5q6giGkCvLib4Aqr6F3Dv2nGZdSLRcXYJGplr3wborA
         uApQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fqwFwMYwtkuqAB9HjjVepRpBt6WNMR7Cm8trBrzsJ/ylw+LvjsbusRamD1oNkVWxTc1cN/Ztk1s9qlZCYynDcYFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dHg2sE591dudcPyEKShMr+jBd40xs3ChNpVANxILVN5IpfoB
	I0Eb33F31fcKxjrunToP1XKaez/1hRNeAaVmiRDG/m3b0an/WrsbRajU94zTpReG
X-Gm-Gg: AeBDiesdUD4v9lBcNEq37nIRhN6q2gipCKqfGWfKddl9w+7dsVn+wVSQMa7/Bd9l4y1
	MVmxnCFuvswyBVe17SCuRiUW/5HBKWyaUzs7NUhAJetQxIUEu9+qhxd5AnRZ57qp7xf+qk3iLrZ
	kDuxPRKsdjCfY/hMHdGeUOCUmbE2wFmsaBsL82CbNyHt5PrnSV7smlGDGWrgkEEbR5hXNPz6yg0
	J7nSX+yLvw2gKASH209mZVg0ja9+aLreNxnnZDvHr2PQIirZDQcG+RlsMH08qUwZJAzkcros2Pb
	uSizyKVCYz5fwxYPuA8RwEhEj4oSuOSzLAvGVyp/tY525+PevPefaqjBMrav5gM6fUramXlrNN2
	wwIeiVio7t/cDXejLUzvDsBrRA+NrzUAo4vsozSuraqDPp4NY9WBq3tUWfxD3aBHGY6KtWaBbbj
	fyFs0WBa3RXnD8GOGFoVbKP9KBBG14oE9i7/nHbYiZOaSqepy3N8dAtjs=
X-Received: by 2002:a05:6a00:4104:b0:82c:e9cc:f62f with SMTP id d2e1a72fcca58-82f8c82eab4mr12622215b3a.7.1776679963281;
        Mon, 20 Apr 2026 03:12:43 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3f31sm12509843b3a.37.2026.04.20.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:42 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] trace: remove the dead IS_ERR() check in trace_pipe_open()
Date: Mon, 20 Apr 2026 15:42:36 +0530
Message-ID: <20260420101236.223919-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in trace_pipe_open() already check the IS_ERR(iter) and
return early on error,so iter after will be valid and
it is safe to return 0 at end.

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 kernel/trace/trace_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index d6c3f94d67cd..2a6cc000ec98 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -602,7 +602,7 @@ static int trace_pipe_open(struct inode *inode, struct file *filp)
 
 	filp->private_data = iter;
 
-	return IS_ERR(iter) ? PTR_ERR(iter) : 0;
+	return 0;
 }
 
 static int trace_pipe_release(struct inode *inode, struct file *filp)
-- 
2.43.0

