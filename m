Received: from mail-pz2-f13.google.com (mail-pz2-f13.google.com [74.125.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C414E2349
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565555; cv=none; b=cdQG9SBkitdieaUlSVaMsfzGvcnVdFoGsNEcUngtHoxpwPBVCB4LmihYdYEEVcXJN+t4C4eBem7p1WfQq904U7m9hmXBcEXJU7hvdmcdEKLTkPCVdyuVw0RzBIW82Mpva5MmDCSxALaFZ6l6MsXZfba42kcTUjUCOm5CFUf2qlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565555; c=relaxed/simple;
	bh=AHNud1t7y9KEUQSEI2EhiS2yWwmw7mgpPZeVDwHxHTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giHqXl/Rjgeua8mopX21qhjUHelU3j0+xo+8QTJUs9ckyPggvZRJyA7MzhlrfJOqlfz8O0touU6tUv6taPOUJeA5kGE997HYlcmq0MOiDM8Hpi/YA4yaRQ6jjmBSbBqRMev1oAXphv7BlslI918xwpuqwLrIv1tG8R66NifF/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9QQNGon; arc=none smtp.client-ip=74.125.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9QQNGon"
Received: by mail-pz2-f13.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so500556a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565550; x=1790170350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5qaZ1xpqL3arxXt8GeaT81uXAMbXLcleRKXKUHrmFgQ=;
        b=H9QQNGon27x3+mTcjd1PY03/6NNr2ax5gnJRT7AvoHrmjHob6oE7mJdK4T4a5Qv0jk
         IqRbMDBAVHczTQdgXxPC6HRclZf3uCHVl9Gr4yCGk2+5Eh5iDtSUzEvXm3Eo400bm2UE
         ZBW/hOQmGzLZ8+a9feQ6e7yfm3CjQTrn5CBZAqI60OhIXSkQavzuGCANV6TKDUcXAdxC
         3g3GzNvwiF/Kx1H6Gg50vlOFKNdA5FpZfsql4hrTpzilU3lTEYDz8hM94rJ5toO/AwL2
         pGjx7vj/wVzo0fjRyxiTKtXkXcUIg1uwg/0oO/6d4PrEeHD+doGQeZjcTNRvNDCB8Uqh
         Bo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565550; x=1790170350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5qaZ1xpqL3arxXt8GeaT81uXAMbXLcleRKXKUHrmFgQ=;
        b=H7FKATSS2OxiaT/He/yOlFlkRsG9JwjP30t062/3hjSh1sY4P7rOEx05StEWwRgtGJ
         9+RIF1DeKgJdRa+YAP9CbVXSzm7qnTVWq7QHNvrlxMNIkYNWRPY4sLlr/Mzx81c/KomT
         yt+2A8K5jGQk12oNoKnFJgcHRk3UO8ZT/rxwtVRh6ArFZIKl56P6KNJO/UgfEv+3gArm
         hcv3Erv4kxsINo6gaM6oOIfWbXjvyOmcSNEUdyaVF1ovOiEn8Ca81CF3VwVajuNEhqW6
         UV346z+OA8v6fbil1j8j8wIGYJi/HIUlNGBKtDBzENp4XFh9qBiZ9BHyuA7BEVQOOrOF
         xe6Q==
X-Forwarded-Encrypted: i=1; AKwUvByoHTFtlnsIMTp5nXp+SkTLTjOVDUiekwo0uOo2GN/kRSxUfY+2R+pNjI1MhbdGZlFMHBEMDvjG/JWoHGSP0qmf1lA=@vger.kernel.org
X-Gm-Message-State: AFuF++k8OyRojpdRPRfdoO2nJMMOZ+CdV2zXWPoCmt1M5+ool4fXLUB7
	P66gWgKxHGmqiY5DTYhc0IC8mPQT8r8W5NpxnJOyVNweEacN9w9D3hUV
X-Gm-Gg: AYBFou09LUWyhZTvJtXdwLYJXaRSZ0Nu7ytOzABbJTCy75O9+B3qywOsb7ALwwG8nzv
	38jXO4U2AyfilWy267jY9CxB5J7ozGvHJRaooJiGcUoDL4uOqybdo88gA1txNzlOb18Xmbs/pLC
	tF5vNfgRbrMM5Ec2Z2DD+s+GdLABqYsG5kOkJCQn75ITKdYqVLpQwNws7xBF4Ib+HV01GEiG4/H
	WXFXONRxbPz9DSrbJqnx57e4Wq4CBV+bNvraqOSn6F8apjzn7NhSZ5FhCZMTEjwngE0CUD/+7He
	ECdFSeqcdF3pcqHb+7y8XSDN68sVfZddTeDQc3Me+Vv88w/cJLkgUB8pbn1G/mqBkU60rIXfFsL
	eLlo1PALqZSSloWxHjHLpodEHPlLYBNcJPcu3bVQ1sc+qdm0HTrP1uc00YGljH7TJjydYbDMn4I
	fzv4xE5ChtM808K83J2KCw7Q2ARILonYuVM1k3zg97SRTeHhNKUJi27VyZeRfkRUY5xHyvkjjBc
	RUilzexWCbx8vY5l5WJjPcrwQ==
X-Received: by 2002:a05:6a21:a382:b0:3da:b089:dbaa with SMTP id adf61e73a8af0-3dd5f40b327mr7277725637.6.1789565549895;
        Wed, 16 Sep 2026 06:32:29 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm1651702a12.20.2026.09.16.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:32:28 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v6 2/4] ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled
Date: Wed, 16 Sep 2026 21:32:16 +0800
Message-Id: <20260916133218.1282590-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916133218.1282590-1-dolinux.peng@gmail.com>
References: <20260916133218.1282590-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The trace_btf.c file provides BTF helper functions used by the ftrace
subsystem. Make the compilation of trace_btf.c solely depend on
CONFIG_DEBUG_INFO_BTF, allowing features like funcgraph-retval to also
utilize these helpers.

Additionally, the redundant dependency on CONFIG_PROBE_EVENTS_BTF_ARGS
is removed, as CONFIG_DEBUG_INFO_BTF already depends on
CONFIG_BPF_SYSCALL.

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/Kconfig  | 2 +-
 kernel/trace/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0ab5916575a9..d8faeb659cfc 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -770,7 +770,7 @@ config FPROBE_EVENTS
 config PROBE_EVENTS_BTF_ARGS
 	depends on HAVE_FUNCTION_ARG_ACCESS_API
 	depends on FPROBE_EVENTS || KPROBE_EVENTS
-	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	depends on DEBUG_INFO_BTF
 	bool "Support BTF function arguments for probe events"
 	default y
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..28b08f31e7e5 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -119,7 +119,7 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
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

