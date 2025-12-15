Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA122BE643
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770166; cv=none; b=Qax76rvT1SsKy8d4dcUnbAuqusqcm5vvsfURqKYBiIpmW/B3oeHH5IF5uT39m0sCjZaE2i6Ju5MiymlMS29k1GKZvQMF0Pbuiwus19OQAjwXVUvwAYYvvh/wsrUG/BL/UUSE1voTJ2so4InIIvYtu754VSAYjohvaQIgGJs/usw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770166; c=relaxed/simple;
	bh=yGNIMta8W5fCJfVCRLduvS9JRYsFtLAV7Z8MNBPkCso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGN5OzCbiUrvtqdbuCD9v2zaPDVZledcr1R5SaEIMDSACSAHnAjDwrtt9t3S31EhiUqmpd/fPJvUljG1cRQtHUQim5Frd1xvy84U9juldIZeVOMU0aE2qFKLpexRrKKVKiyEqki4wRe0LZER6bipEfvYqPfYccCDqfJHcNA/Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAHQGox8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAHQGox8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f30233d8aso27445545ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 14 Dec 2025 19:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770164; x=1766374964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5UBV2dmchl80Cv5GOle8EKJ8orIpqARGfyikGjXPIY=;
        b=EAHQGox8fuOksrR6LDr9tAsS1HTRn0yac52jvD7dN/HO7278i4eSlh2uoXpRPuaacy
         c4pNPIEZ+wR4x/L5LP6tnKvnyQPHbyZx5jBg3n/AH/Tk5wuZtZ6K5UZXuH3F+6NOMj6Q
         5/lKLCxaeUiKlo5bnBFAz06vDbQKMQzWs27j+IVsKzlwQgUG4i/P8mYomk0Ah6LipwnG
         o03fSshtnJnJ8VIJ4UWb9Aas6T6OpLvG+NODO/lZShdGPIV87uzaBGYueJ+BbWUSi2mA
         0EcFz0xCUvHtBGYdw290qZPVxAuOTe0b3E7HoF9D1Pl5cltIt4dYPPfpJav/ReMugX7n
         PDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770164; x=1766374964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5UBV2dmchl80Cv5GOle8EKJ8orIpqARGfyikGjXPIY=;
        b=mFyGqQdVC+lXNowfL/eIO5qj3C2Ht1ufd+JWKyg9o4FKDNgYD3BzsmjjiuH71j898D
         xoahWVjS8HA+9wmIsflOGWx85hPSnr4RedTW+OR7zgKNwpvMjZie17nk837A1nVHH+Rw
         XJtYH53sjCpp5FIIpiaiXhI7BLonQG1OeudKALfCKRBWPh2PWgbtnUnD+TcdR7OiHMTk
         Qz6G6jecdiNDJ/Q/hv4A/R07CuztgImEdAdBDu9DpdIgBw++GIC9gR+RZdfIuFcy+fTM
         LYe1jzC/0hECJpvkNLGQMawAseE0xrqeVPpBqMXA0YuufFaJ8Q94NY236yOACgTovYpx
         2xDw==
X-Forwarded-Encrypted: i=1; AJvYcCV1fFTR9ETIrhxgoi+P8aKBdG6OBQXVOBE2Z8JcTi4bZld9NdglWV4RfhzSlIPJo0Yz6yGS6SVHFhZ/F3+nNMsikdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygLtT0CKiHjiNYZnI+JTVf/riLZUGvke+z6ueJFj6doYdLuzPy
	J+0uLyjCQc0O0kfJyWAD9xb5mKDgkXXeQc6LEsdgW4fKZ8a861cwjSgxTuJzfj+lcxA=
X-Gm-Gg: AY/fxX6XJ8OuZBttB4oslMgyocwbML/ijssF0ca6Sxn8CCXkpIJ0XYaxY6xjA+EUXPt
	xTvtN0aRpn09fZEuUxzLyFxTz0AyWHsVdTkCaAg+WMl7ZS7Eq5JL4rpF0SVLacum1MeEnHw/EJd
	oAPaUjXkdzE6qbynqPPZzKrrq7LVHz12WQj+lT6rFff/TkEsCV9cGQMXlI7ANX7UY6RtBM3TOpf
	ScL92/KUgz3Uyx35pn92bKtscF5Q9TbLUEpN1r5e4BzqUchJ2HNY3DM7D7S/4hyEYiM25PvxJtF
	RC34G3m8ThbLJiODfe/iShC5VHferLsZy8XjQSVQToereoKr4hSFrqSUpWkSp0Z3GOW3oIFnoR0
	viJd6EqB4uiKKGknwixw3kKfScSsW6awKjfr+CCD24B+rj7jDB/oTtXCoCo8VQ3VWzcH+wtALeE
	0hMIb9UoKxoNzyvHSCeH6bFdPD0ME=
X-Google-Smtp-Source: AGHT+IEv/SYjvRWH1owJzIiSvcEbD/HWRjgkyxil80rYRGJmI57RoXZa6jI2N8QcNELLK7oHytfmhw==
X-Received: by 2002:a17:902:d2c7:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a0e94e5ebemr19780285ad.50.1765770164019;
        Sun, 14 Dec 2025 19:42:44 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe23a207sm3420562a91.1.2025.12.14.19.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:42:42 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v4 1/3] ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled
Date: Mon, 15 Dec 2025 11:41:51 +0800
Message-Id: <20251215034153.2367756-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215034153.2367756-1-dolinux.peng@gmail.com>
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The trace_btf.c file provides BTF helper functions used by the ftrace
subsystem. This change makes its compilation solely dependent on
CONFIG_DEBUG_INFO_BTF, allowing features like funcgraph-retval to also
utilize these helpers.

Additionally, the redundant dependency on CONFIG_PROBE_EVENTS_BTF_ARGS
is removed, as CONFIG_DEBUG_INFO_BTF already depends on
CONFIG_BPF_SYSCALL.

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/Kconfig  | 2 +-
 kernel/trace/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e1214b9dc990..653c1fcefa4c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -755,7 +755,7 @@ config FPROBE_EVENTS
 config PROBE_EVENTS_BTF_ARGS
 	depends on HAVE_FUNCTION_ARG_ACCESS_API
 	depends on FPROBE_EVENTS || KPROBE_EVENTS
-	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	depends on DEBUG_INFO_BTF
 	bool "Support BTF function arguments for probe events"
 	default y
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index fc5dcc888e13..6c4bf5a6c4f3 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -116,7 +116,7 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
-obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
+obj-$(CONFIG_DEBUG_INFO_BTF) += trace_btf.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
-- 
2.34.1

