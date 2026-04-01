Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E746295DA6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051379; cv=none; b=d4AYuDmIzuWlJQ5OfUIMzOxGBeGeqoRN9gp3tJudYUcFW68nzHP5+AP0S/2CfooN3JLYNKlWDQKcI8wTMvA9Dp3caGTBoaJ90H6l4tLqbVn/NuVtw+35ZLaMVGSeg9BQ3A8zLXqjDkVsF1rnLMD4CKNpSsc2X7Ns/pKIhSg5X60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051379; c=relaxed/simple;
	bh=hgeoXRZ5cSNPAxt3Egkd+p+yTdwDhoSYzz++GWpOuak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c22sk64oMKwq+OYsU+gH6TTzzFxHVtm/TM/1Ka4MXVQ8LefNgeLq2MVXY5IrICaNv2DOhwfSQyHLSZr6O0eQ+6SJ9znwDRye7c9pW5RwrJt/o0wbuhBDFYKA+tCHqMOv8E06+9+LXYDRjGxeVysfjkT3zGKUMxxkAdA8mhkeegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiCAwXSW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiCAwXSW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso24680345ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051378; x=1775656178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUEKhgyUH+EnaEpKP6HMgut1APyt2IvzBtqO/UudEAg=;
        b=ZiCAwXSWzm8uZjGm4DcVhn1D718hghhJvMWaYWSnGOtiTHKMeVSRqb31f+njMiRYFT
         27GxXzKLYc9IivVBowY9QwXd4MV0Kx9zHB0vH/DyPU6ACbgFx2f8dEVYehBOMxLLkKwT
         VPSeCepbVd/0P6LQ7j8RCvAS+B8n2Z8s+gii32wkD9FBkILJX3rnAG5B66ngBICx5Cp6
         z/yRJ+LVPSeaSnoIDld/NZXBp90XF3v41fpz1ITw7LQbTeY2VSF1VSa/hOJ7j6HI9QVv
         AKariArmV27z7rCPd9TNBJGRytPOZAXzzdPFiGK+HqNta4hAyEGzOm5Ixv4trZbHfd9j
         OT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051378; x=1775656178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUEKhgyUH+EnaEpKP6HMgut1APyt2IvzBtqO/UudEAg=;
        b=rTFarGi1R6VihE+DYVXmh/bNcvoN9+V9QtUgEtvSkiW5yZkNuALW6h3iSjF6uA5E3I
         8vuIb3wzv9qOEcaOs03evyuqu53t/cGo/bSF2fjK4WrEPT84rLfrhJqRV+eLNOcUX07b
         613iEt4L9k6tVd9eRsrHJCgvvZo1+Y62yRcqjuo4T9hyoxdUFJAUgYfSPVXcEwWqAWh9
         p7MrQgYn3OWkKQG3yI7Z1use7HJPeX4E4XJIJL2E2mWcuA2SW2+yU2BRQRnUrQIxAa8L
         AW+CqHB1ygz+ikHL53UdJMlNJuIWBnInkYyvii9VGdV9IjWxRToj/rly2Awq6O4O4U7i
         slgA==
X-Forwarded-Encrypted: i=1; AJvYcCVqy5D82pi1Vue3aUuFYl3EhWj7vqFDCmPhkUkPqjpc+mDDpg82sBQNDi5suz5JY2ykvAE0liCBZ1J7furdBx5ca/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+AyRnnDM+y/ZJoMFzIXDtCN+LIPi4Zp8xhJO0V3iaPaPFvDU
	SP/o/OytkawVf9k/bD3BRW9e55CDoVtj5EkYyVrbT454kdzwxEafu7z3
X-Gm-Gg: ATEYQzyQSWIr0DI81DW9dx8vkFPwEopPYgq3vOg2EOEWtVDkm35g6xLVEjb2fU+cQf7
	KcbUxMGZtAJNfdSP/5jnKbcQqejrOzPb8qg1HWmjn01AxAxx5o+qvoCfYOpOISfHJcctMJdauTS
	NUnRI6tvSdrzfZtyn5qx5VQxbWJBb2prOpfEHGV5z5ZGMj/mQO5aOrODVhqGZhXTC+Jv2TmcMbd
	uQJeHaS/y11f8TsO56SXUX6m/T2tumn+aaEyqITEZX1Hvejb8xJRWeds1L2zxQtAaI/6jKmN8CP
	HIx0DtWoJsHtGwOwyGLRZn7Tmkl+Wy/q7aeHYcNyoTkoJa/JmvM+HeZaAJqXic6IO7sSjzBE+YN
	AN/ZfuJFZUlFDtlDp/s/aDqDDZ0Y6GrdCURl0ypSSkcKPWTP9GLZyAhcRbzy57e8gwzi9GUDSZ1
	whwF1yygNh4t3SaZgetTixQPiUi7H7Btg2KlCl/cPXnXXhqDm69IDJ8EJlxtAE+dhbwSMUYAQ74
	vPxlQ==
X-Received: by 2002:a17:902:f54f:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b269977a8cmr33888775ad.0.1775051377662;
        Wed, 01 Apr 2026 06:49:37 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b267ec1615sm36300935ad.57.2026.04.01.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:49:37 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: varunrmallya@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	memxor@gmail.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Wed,  1 Apr 2026 19:19:21 +0530
Message-ID: <20260401134921.362148-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ac0hLyMuPHiZfnVc@computer>
References: <ac0hLyMuPHiZfnVc@computer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Fixes: 0dcac272540613d41c05e89679e4ddb978b612f1 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	/* Writing to context is not allowed for kprobes. */
 	if (prog->aux->kprobe_write_ctx)
 		return -EINVAL;
-- 
2.53.0

