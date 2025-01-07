Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F441EE7AA;
	Tue,  7 Jan 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254768; cv=none; b=sGrn7sMRSUOvC57ZslciBjaMT/5XYjldPQRDyjf00r7EBfGjPtVnyU2q9NsMsdQ3D9icZr0Q26R9Wo+A5vMkAQkwwT8pj7CoeUCLbw7URNQwxkX1LmJXOnctJK8D+a0gvLwrgrDY1OlLQh43XtkYZnvAxSbbzQD1W95aV1QJ48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254768; c=relaxed/simple;
	bh=g/MTHpnEtGFuCAGLnLp3qY6LbuJhYqc5Q2c+vrs4+I8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IMLz1228w8N5WO3dVSTzhcXYxrZEXhdabgo+sHlnCI50Ye0705LCMnd1qPeaBesYAn6GJK8Byz6bESCtaJe6Pt/REKS9pcNGlTwC18Lpvpb+75TDGhRhy4fZnYgam0k4k84m01Zsk4iJLS7R70tvq+/jb5IE/pqkOCBaO/lOLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xl6r8d+D; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl6r8d+D"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso17379365a91.2;
        Tue, 07 Jan 2025 04:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736254765; x=1736859565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeaCcnQubfhf4GY5/MzvFuvb0cmeBzdNrnqwjMx3/cU=;
        b=Xl6r8d+D0+7VITU8RNeBXU03nqCppblE8Z0auklN0wkkPb+2joR9/RsqRD4FUhT0w6
         Qb+YLk8JPhbRlIoE4u4yAf+PmAUlSFX9FFDUnYugsGXmT/bcI9IQIwUXd+10cPi32psg
         9me6R/7+QkBanxTmRI5UBkeQVsQ5VR07JTFw/mSm+wxgRDHFWDgiUMnThCWw2FaQVccq
         s376PWUQLPdSnZGDAVSYKpHAxP/7Y0F0eRLDKY3nsyQXzpFRHYAxiXsMKdMowxdL36Rl
         b/q9Y7sUnJRR6meQndnMB/epyFVw7vA5E/6BKvRF1I8CssLMTiIHvLZEC1aoHWauJw1I
         qtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254765; x=1736859565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeaCcnQubfhf4GY5/MzvFuvb0cmeBzdNrnqwjMx3/cU=;
        b=vVS4QsTcKqo334KMvoGmZwHMg2ejMzEuV1qSNZ2dlRJNf5qLI6D+49wFyDtG2pQ92q
         DBxUkA14RxgVuuh+gNkDVT8wSFpqIdgeklIi2od3VIJmdSMgDAddD8NQ8+aLG95FeAm+
         tANi4/KAzsmdBn4c2hrSBJ3rP6q7AnOU+iLktLIIJ6Lpg3hoFps16BttyRCRsp/5Nf7n
         u4OghkJwRcp/FRckS7/xNmy9A0n5q5gufd2bDctSFi37e/Io+evIadrdgDomliTkzD+N
         WnGcApT0eoEtSDq4BdPINXNDciJeMwGL14rLvmG7BbkTGV/PNwoWuY3xRrPpPTMdLR6d
         9ZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2XOT8Dh0yjkDXfmKUp5QXq9uOTWLWiVShJtV7hdg0A+LJmalQNGspRhTeehu3zMJbUHxzDGTDsoN4fSE=@vger.kernel.org, AJvYcCXxRI2YJSuNbTgzsfxUJQ88+eIRBk2aOnw9Qf3aKkcOWJJPhbZyiQIVS3ZrlR85jzw+FHQwbXTAMwayzkWsX5R5BE66@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJdNUsVsd9a+lV8UaX77Qczgru4Y10zWJQTyRrILfxIfaNXeX
	M82a5MlvcyhLrg5S2ntFYS7rJCw5nN6iZpREQxiujcI+XfJbm0wM
X-Gm-Gg: ASbGnctygVnV7a/tNpSodd00lwkJoMpcz74gUQXF8jYVgOxt7LHqrFEczGb5rUQORAH
	FFEltKTVBffhoMXW1XQV61G2hwoO9M2lKdycN1an8PRa8U7zUfDlWt+bWkXBYahG5pBARXRhJTn
	Ky1E+50ZmmBDX3hc/fq/tLTlOGuouFXYmkF7aucRINUGDo8KPgOteSjWPYoUKFMyJupHsIsC3r/
	dr3mYXmjuH57/vVJInN0nfLa32vmr3yadJu4QEjWNBfhwj7sOp9qmEIcR6d
X-Google-Smtp-Source: AGHT+IEbe8Cub/lLjAyyLR9+MXyjS/4nmt8tvAodb8qI2COkRBa1nKk3jL2UDfncCpyh9QUvqNSiVA==
X-Received: by 2002:a17:90a:e18f:b0:2f2:a664:df19 with SMTP id 98e67ed59e1d1-2f452dea8e1mr93569392a91.7.1736254764900;
        Tue, 07 Jan 2025 04:59:24 -0800 (PST)
Received: from HOME-PC ([223.185.133.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447798934sm35989490a91.3.2025.01.07.04.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:59:24 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH kernel-next] tracing: Fix uninitialized variable in tracing_set_tracer()
Date: Tue,  7 Jan 2025 18:29:20 +0530
Message-Id: <20250107125920.45855-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue in the tracing_set_tracer() where the variable ret could
be used uninitialized under certain conditions. Specifically, when
t->use_max_tr is true but tr->cond_snapshot is false, the code would
check the value of ret without first initializing it.

Fixes: a35873a0993b ("tracing: Add conditional snapshot")
Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602786
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a04348ab7ccc..28f111c5b3a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6079,7 +6079,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	bool had_max_tr;
 #endif
-	int ret;
+	int ret = 0;
 
 	guard(mutex)(&trace_types_lock);
 
-- 
2.34.1

