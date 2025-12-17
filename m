Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECF8003D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940461; cv=none; b=bjhurlAlsgaxxJkqSNkJYeRuzPi68YSQQwsXWH6b4ldvR6RvoB3U5azO5fAb3b6PEtids0MUPAFbVX5jK7emUEYyNZH0VRdaV7plXs8HdnqrVfOE9TyeVocQAijgX58CqDr3xs/8DovWgtUEgpcbKmQBWukvuyNLRZoMpPPXvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940461; c=relaxed/simple;
	bh=LQCLlIDX7gKgIRHQ9Bd8E3tOEJizTVL/xMqpt0SQz6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQDdIh+voEl7jZuHKCTqlsyK5ZqByzmBsZmIJ/pZIfk0BvLBB7yB4JKJ6C5oyovK3Wqcb41UHh1DYqePoiXjl/SCcsH07QfBv6N4rUPt5Otpe4TyG/5MmA/DFGsCpV/WGbeDFYoLchwyf6TAnSRJUppI2xqCInHNNfM8PYWeydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIgxFl2B; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIgxFl2B"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d0788adaso29732705ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 19:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765940459; x=1766545259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjrKAQg/cSPHOSdJybxQoiovFeAReXkBtMU8WASN/p4=;
        b=iIgxFl2BHNW5DxQzPLtIluc7JrVamqoNodHEgkDLVDSAly3nt1YgPTZOefzA/qBcx0
         77N2fAJDc6OnnaNn8DHlT8AA4G9QFMsyKBNpwqAX9c9g5CCuan1/SEiOVMRQ6/Wgilg1
         0EU+ACURvIG+o8UToZwaWiTuxfzfvFKsOQyTAs1j7RGxofoH9MwllzuouRSybMRw0c6K
         5NyRzilRLqOOUHIYcPqvX8794iNBjFh+aLlDoCvulsLjjoQ1WTwcPY/W+wtQiY3nILLA
         5zBtaoibwHHVS/ihzFhE3j7erDoFr1PGvLV2m+PKuOdvyKTcKvem7GAVMXdbbzm6fIah
         /ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765940459; x=1766545259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjrKAQg/cSPHOSdJybxQoiovFeAReXkBtMU8WASN/p4=;
        b=lLhk6UiNXZsHhToEYwUGMmD5LKnlp3vbWVI4CajU+8uxXcd4lHiodzdnfaHEpwSDVm
         PL1lIZTSnliPJY5cnqJArvHumZWrl+3F0VSJd+qTndSV+bqYUKAqVWavLfj69Jk9Wn35
         FtoSqsJckVG/aL3gf7wD/VVWJTe2JNLDkFpBInrm97kqO+eZxsqEH2QTgYzFMDN4fepI
         4iDUYB9jy94QbUv/9jPy17CqPdXPOrdUkHUCzy0J6bZUU2kZL2epnnHIs3kfRO6Bd/1Q
         xPCQJslOOi7LGLm5MiJmybVPLXlH7O9HaIteLUsOCCCL4xkRmBvduAMQP1cPuZIwZvik
         B4WA==
X-Forwarded-Encrypted: i=1; AJvYcCXlgU0wlZbNx2CZG91kGRZOXp0CZIhCLPlblr3EMxN7kRY02DfJnHgf956KNrcQ+ASLusS/5LZAFV3E/vmRXihfR3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV08KuOGk6pQVH7rkWC4oNdqXC0gYFS4He6Rqr+TY9FQy9pBlR
	mCoQYGjlegFzCXN8crOL+zvT4H7pRkswOqT2pYcqAgwHzdypdXEoQdes
X-Gm-Gg: AY/fxX7DUuaOzUofHJnQ9gxylcnFj3SAtH8bu2DjYOOSors0HFAfGs8OiKj1Q6PEVtp
	ep0ICMhRyuh5kKiW3iGUmODM895BaZXGqTFATQwdVidsY+UbsuuHk/+CmLZkLKlEbIqvs+q1iV6
	03kioybYTWBOd/a3mRmwuk6clnr+1Mvip1Zz2SCkLsCOhXEvAznHhqWWzDuy64irCqV2xxcNZKd
	Alr7wDAOvn9m5YAfeR5HyxS1Nlpi44Z49uuj7OX4gaHdgcBYudW4DG4t3Uot4iJtMycagufhvnN
	tgiFR1qrVkuMazwdPJLNPJIrqQRu2UHnGgLA9tima9kRCDspbUfaHUmWQYAgpU4kf/2Nqb37HLT
	6jrKRPXmil5XkUyfwEZHZwkEnxd9S4POEW5HQHckNKNKa8uJPfhVzCpFgArPCvBSY724uk95cHd
	yfUxRBXeQ=
X-Google-Smtp-Source: AGHT+IGNH/jTXYKDAC+YI9WtXJ1/2cSW4Ne6lXIfZQEX4fuLtdmIptnZ2Lxq4k9U6S8/gglzLHB5YA==
X-Received: by 2002:a17:903:11c8:b0:2a1:388d:8ef3 with SMTP id d9443c01a7336-2a1388d8feemr52712705ad.18.1765940459031;
        Tue, 16 Dec 2025 19:00:59 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbb11ed19sm943972b3a.37.2025.12.16.19.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 19:00:58 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	menglong8.dong@gmail.com,
	ast@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: fix address for jmp mode in t_show
Date: Wed, 17 Dec 2025 11:00:53 +0800
Message-ID: <20251217030053.80343-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The address from ftrace_find_rec_direct() is printed directly in t_show().
This can mislead symbol offsets if it has the "jmp" bit in the last bit.

Fix this by printing the address that returned by ftrace_jmp_get().

Fixes: 25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- make the code a little more cleaner
---
 kernel/trace/ftrace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bbb37c0f8c6c..b6c5b0e899e0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4492,8 +4492,11 @@ static int t_show(struct seq_file *m, void *v)
 			unsigned long direct;
 
 			direct = ftrace_find_rec_direct(rec->ip);
-			if (direct)
-				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
+			if (direct) {
+				seq_printf(m, "\n\tdirect%s-->%pS",
+					   ftrace_is_jmp(direct) ? "(jmp)" : "",
+					   (void *)ftrace_jmp_get(direct));
+			}
 		}
 	}
 
-- 
2.52.0

