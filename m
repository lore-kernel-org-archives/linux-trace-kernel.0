Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BACA6519D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706768710; cv=none; b=qcyNyuudgD2jf3Pwiwm3hwvX+YlGKxV/je98fXVtC6u1dXgdRFL0EstTUiWCrg2T1b/ttg6KtbWR9qMXxKaKBI8qId1MtcgRBiHtyrhZGGjNIBFe/7SLVEa3LFsF0PIAs5CXAp2BIO5LTw7NvLGbQ2bCWRpcTYSEE6dJnGXotsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706768710; c=relaxed/simple;
	bh=QQsWlat4W0oQ99+TRdtWlxr0YYMOd3RT0qj35+Vk0vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHy0hCCXNgE72AClkMkDsHmYUhwAWpEZDhWoPyMOayZgXwTzNIka6Zp2yLv370d3qAzNX+iJDaqJ76N9+hNU5AOhM+gYz8TmNbZhqZ6LLJzjLT4jnLp+LBi9MjywB6cGOR+mVQrzTrSpV3Bvzyn4rVXsmpmRK0ED7NMzViFV8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bc6mFKSG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bc6mFKSG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7431e702dso5258615ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706768708; x=1707373508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHCM+0rvEETJ9CJL1wFjZvpRuOOW0WTxWE1cNekkKMM=;
        b=bc6mFKSG6nyWsei/H2OxxRsmP7u3KyWlFDiemTIscxktYBODdG+N732b3aug9Nv7Mb
         bbf5I9ss91/2klPrTi8qpnmmfe5qeimF0Pnw0nvwnFfM7WsheXcrlh5kudH2+713x4GM
         7BMiMZTs8aV3oHlX/8yQuJT+YPRbsNoApTWbQv5QOr3XIhujZgFpD96sRAs0UZaZNmuf
         W3CfITVxOSwIUGCCgtKHbD7KX620FMC3RydS6F8Z3WZoYlX/FHU/WgOS03mpYdbW2kc/
         l9iQCR60ZxVLpVZ/mxpZyij7XZwFjnTBejk5VkCdTMrI8CDVVW4lJICGpGnrjaeGHDjJ
         Gwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706768708; x=1707373508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHCM+0rvEETJ9CJL1wFjZvpRuOOW0WTxWE1cNekkKMM=;
        b=w3Ilb7lPZxX5yEOQCHf6AVa5/FCYGEwH3Zx/2yIosMOtjOoXtkHQY1Of7v6cd1W32p
         m7GZwNtxT6J27Ebiu/RETq4UKD2cS7dlHhl+RCeZ/ew60u3XASnmMkso7hXD0bAjQlpY
         pPwYjGwUF6tpo0QNlTWIk/6fLegCaRGGaP05XTl+pXEAEgQwFstjWQNdFChpz98Xi7GH
         VwU21WV9dkSUa+YZc6qmENfZNpFu1zkfw/tIBYAZr/8NxmyNP/pOYdaUVRGO42Fe554d
         2rk9rk2IxFnEmP6A4WkAeBSPMwOz94MU0niEYyl6Hb/GUfWLULFNSC7zQ/tuLH9hooxG
         91xQ==
X-Gm-Message-State: AOJu0YyUkdNVBD9EycHsTNday9I9hEnWtjGNTKVrdHxJ7i7e9xGAJ2De
	R72rnTSu1uzuanbLvoGBi7j2/IBcHkaAf12AXjWs0I588pXg8axQ/tGpmFCOEDI=
X-Google-Smtp-Source: AGHT+IFeefl1HF92/NbgbkhKS2PZbb2MAB98+uri4rs9WyF1nF8da3fBdsnFulUg2Xl+nE4otWRCuw==
X-Received: by 2002:a17:902:7844:b0:1d9:542c:ec01 with SMTP id e4-20020a170902784400b001d9542cec01mr401620pln.12.1706768708377;
        Wed, 31 Jan 2024 22:25:08 -0800 (PST)
Received: from archlinux.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001d92db44c9bsm2346896plg.17.2024.01.31.22.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:25:07 -0800 (PST)
From: Andy Chiu <andy.chiu@sifive.com>
To: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org
Cc: bristot@kernel.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	Andy Chiu <andy.chiu@sifive.com>
Subject: [v1] trace/hwlat: stop worker if !is_percpu_thread due to hotplug event
Date: Thu,  1 Feb 2024 14:24:55 +0800
Message-ID: <20240201062455.3154803-1-andy.chiu@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the task happens to run after cpu hot-plug offline, then it would not
be running in a percpu_thread. Instead, it would be re-queued into a
UNBOUND workqueue. This would trigger a warning if we enable kernel
preemption.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 kernel/trace/trace_hwlat.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..87258ddc2141 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -511,7 +511,16 @@ static int start_cpu_kthread(unsigned int cpu)
 static void hwlat_hotplug_workfn(struct work_struct *dummy)
 {
 	struct trace_array *tr = hwlat_trace;
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	/*
+	 * If the work is scheduled after CPU hotplug offline being invoked,
+	 * then it would be queued into UNBOUNDED workqueue
+	 */
+	if (!is_percpu_thread())
+		return;
+
+	cpu = smp_processor_id();
 
 	mutex_lock(&trace_types_lock);
 	mutex_lock(&hwlat_data.lock);
-- 
2.43.0

