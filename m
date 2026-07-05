Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0253B23C4FF
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Jul 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783273102; cv=none; b=p+nhS1Ve/DMoZjX4ceU2fUBAOE0kt+iqlx64vTtRpunhQw9iwIJ4FXYzH2uN70NiyxxrZDZk9e0yaMRljG16QHzx3hPFEgQhebHh9lyXZkcSoY6ORGJNEyoo8x5FftsILOBaxfSAMt0fMvr/nSYS7R4mmj9LH3ZNHZ1PVwcl9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783273102; c=relaxed/simple;
	bh=bUAxN337asEqROYSt5/ltA/3sM2IZ9I1efJl5vApoOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mE/fgaM+Idq6LhgiadohQ0KkslsW6ZD9VXJv19ZrZ+tBK48HKL3cNGaABQRsb0MeM4pf1OwawJzLfsApbQdlRJpInATYeTgVFj3KnBTxo1M7VhVAfzO7Zk7zNYW+uCTp4JzMlfv9lgZXBRVHX/NnntzbqraKOxmSyGQ0dn/1EAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLiojjJ6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLiojjJ6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845e363246aso2447978b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Jul 2026 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783273100; x=1783877900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FF4uFVjFmTaLbmyK1pqTakaZLd5tlewGSrxGWtLcTfY=;
        b=tLiojjJ6VJBMSqComT0qLvpEO4g/99rU4fw2GVdf+DBitdU0sD0RiR+GSC/ZOeaF5S
         CEtfDyW9O37dUQ0Dv43uk5yKVUVe+BIki/SeqnZ3e6Rq1/gmRcWZBOBtnEKc15A2G7mk
         AVz+Ij5d1g5/E93nyJPsLKMbd0Ls4RpwyLe8CCXZGROVEfFCHchnYOKtk/F1RCPD+vQt
         TbcVGL95vwXeue5Qo7GHtY6Z0w5oZgypaJtVzpAm54x35zUvBozdiLKGvyNvHpAWYCU/
         M0ahJvn+KgdAoVfAqIO7WYkbEq+mACXqsE9IkUEhKYEZeaVrrXV8qLPbK0h8slRQ2h4d
         Lyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783273100; x=1783877900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF4uFVjFmTaLbmyK1pqTakaZLd5tlewGSrxGWtLcTfY=;
        b=Fw3FdxTSoWVs/ELmSRyCm+djq+EuIcdmv9lJQ47hiobIYhX1ZB5ZoXIOg1VgZxguvs
         7zW+vKWK2YvGAL6PgW3J7RFwt9iy4Q4YaviF2ls4ZWAe/YIVIXSgdXdcvfJO6eNQFrBq
         Vkwmozcf4nJrrMFvXAxoPGGbVZdFGKcsrdx6pLMDUPp0HoDqEdilt1OvSmVVQHE2Q5ll
         DfdwqiTw4Hcy9o84PjDJK9Zu42L2KcAR5vo444GMK6fxm/kW9aJZrYENUW4KI4RC9K43
         3c3yApFm00nI6bSlcEM2mq6rY/bQ3qfSFlwdX+ViTN1wSTLEZKLvgHPbWnfe3BzlKwcX
         symw==
X-Forwarded-Encrypted: i=1; AHgh+RrtcH3zqTJaQNCx1jkE6X44ehDYjVHuiBlevJgVTCKok8txXhspeua2qCh6FnrrbWPvPtrwV9JvX8uN9rhmbt8RnRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8kdszvg8PfCH76oBJzhGvxyM3Fqzzst+GMdP1+a+BqkFyQNH
	AhVRmu6TEar8XByKPD4FlxTO9PdThDxbfFKeov6n9FL6+ztmn2mNNH51
X-Gm-Gg: AfdE7cnzdmY4/tBrXKJoLoLjeIa7uxi+r0Mp8CHQIgm/naHX3jr0HKanL6xLyWJfY4r
	IV8qYo7hZNwHHHSnTxpMAAVWkfOK+Z9RMWYbtsHM6QbAqpT602M3WUUNWcLC1QGTTlJAKxQMVuT
	aDDJo11LmTT0txf7nWmkODgvbm66G1xZRD8ISZ6NBxJd7T42TzHrSm2psb53XQil34Q57feAFgY
	Fgl0EruQuUuszCyGdIfNW9Fl1X1vjPJX6edK/j6OpkvvcAJ5F/lS/2pht2Jwfrjr7d8NYPX0rev
	+N24CUFC2gM0SndZJfPjY/BUh0ahtYZF0KYTKryxk83ttFl/s4jSCJ2D7j8osXkLj/wh3oUfi2M
	YFhI3uJeJvS7HeEEmcaahJh/dzv4GFus4TcX+X1b1fFNxDlJvNwSaBs0Z7Zz/To0qWx4FPbAOvD
	WOKFOIecddYxa3kFhQUOaa11BzAnwEAZZAtZpMyEz4m+L2zWw6xmoiADiQ0JL1IaMOi/6ZJsA6p
	PGXP/Z0L6QptxKEYlweEws2Zp0TADAxROi6QTn0ZBIncSgvD7c=
X-Received: by 2002:a05:6a00:22d3:b0:82c:6aee:b21a with SMTP id d2e1a72fcca58-847f6f40487mr6823025b3a.45.1783273100364;
        Sun, 05 Jul 2026 10:38:20 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-3e93-79b7-c241-f8ca-5d9d.emome-ip6.hinet.net. [2001:b400:e282:3e93:79b7:c241:f8ca:5d9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dddf8bsm2493150b3a.61.2026.07.05.10.38.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 10:38:19 -0700 (PDT)
From: Po-Sheng Lin <posheng.lin.tw@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Po-Sheng Lin <posheng.lin.tw@gmail.com>
Subject: [PATCH] trace: use strscpy() instead of strcpy() in trace_sched_switch
Date: Mon,  6 Jul 2026 01:36:48 +0800
Message-Id: <20260705173648.5418-1-posheng.lin.tw@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in __trace_find_cmdline() for
consistency with the existing strscpy() call in the same function,
and to avoid potential buffer overflow as flagged by the Kernel
Self Protection Project.

Signed-off-by: Po-Sheng Lin <posheng.lin.tw@gmail.com>
---
 kernel/trace/trace_sched_switch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e9f0ff9626600..1bd351c1fbfb5 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -286,12 +286,12 @@ static void __trace_find_cmdline(int pid, char comm[])
 	int tpid;
 
 	if (!pid) {
-		strcpy(comm, "<idle>");
+		strscpy(comm, "<idle>", TASK_COMM_LEN);
 		return;
 	}
 
 	if (WARN_ON_ONCE(pid < 0)) {
-		strcpy(comm, "<XXX>");
+		strscpy(comm, "<XXX>", TASK_COMM_LEN);
 		return;
 	}
 
@@ -304,7 +304,7 @@ static void __trace_find_cmdline(int pid, char comm[])
 			return;
 		}
 	}
-	strcpy(comm, "<...>");
+	strscpy(comm, "<...>", TASK_COMM_LEN);
 }
 
 void trace_find_cmdline(int pid, char comm[])
-- 
2.40.1

