Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2847F2CD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270379; cv=none; b=gvycr2w/yZuITuSd2YJlLBK840pTU6mBaXU4SqNzVonPJ3ummD6py2nGno7w90STVsPREKIQ2eq0+il8/4OnGEJpXF77i+mbfPxuchnSVoALeC5GJx85BtvX1fkJ3DjpQgXqLMR601T0zViq17LifmbwAMe8NkEvJUK4JmnwKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270379; c=relaxed/simple;
	bh=vTuXdHjoahpfvREK3vR0JpIpWmDjOwvXZYApg71J5w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pY1X7Cadj67wDplQtBYe+3YN7O12V43JkEsRBXc7LpJXnRwf4GIB5oYF3h2DA8e4eSlTa+oI8ww1lnyAnd3SqvawtMPtB+ogHbixw8rXBsfyYZ4lnoY+nw3T5An13GFJF+HxpHUW3+Yho4AfC5rFVZZQoHwfFqMyDoh349bV0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQubPDbH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQubPDbH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso4867852b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270377; x=1788875177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VVcj/Jgo+entMeAtqsoiHxTBvbTk7zVsLySF0C5WcdM=;
        b=mQubPDbHp2C4r0ur3ETgpaE3iTvn5Q2owz3zGfUibQrN99R2igaGfQpmfnNHcvH+85
         p7pX6URJbq3XijPUATSZbnvL+CovUQTu+uWYBjffuvp8Q7FrvBbGaAyMUZaSDnOgmE8V
         e3rUlOJWBM2MBI9Vdime67UDhyTC4qKa1FZWzZ+SuE7ifAQjw9mRBN6L1ilTBZKbCfqD
         o2O576aQxFOFlnqFEuc+Rpwv1HlI02BmGB8v16OGfUKRiyQvH7zV+qaPn4Mkb1NqdbyI
         BLxuGX+W0pUnp692Md5Eya6mZocWdrO1FHUpyxRXERf7ow4lVFX8Db+bYP6da3ODzBT+
         UOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270377; x=1788875177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VVcj/Jgo+entMeAtqsoiHxTBvbTk7zVsLySF0C5WcdM=;
        b=PxruD/5j0aghJa+ojYvjNeBn2WIaiBJYbG2B/NYCsulsGchzSGJ5I+aShOx0upEz+7
         JYPVIrD8jho/QGszAXXW/bMiEO/qNoUl40rWoMfo/RWRtqkzr99+TZzq+haaVmaM8Rhp
         Jle5aqe8yQBm6vQA5PuawWcgYjmEZUPfKUwLzbm+AwusJ06cCVCfikmHa2rtaSHblv+h
         SV2g4ZH8WO2N+AsrqttnTjgYUJiTmqt9Upi9wEHMs1cOJnNbg/rIUeF5SNk9PaFQcsA0
         t3pABFeDwExCdhLsDxyVx8st1sWrR72fi0tyjy8Rry46tSa2t4o02isc0ZFJsXbcEy7T
         EhcQ==
X-Forwarded-Encrypted: i=1; AHgh+RpepqtEWNxINN8H7x++XW2mXK0UXd/GgPyhMkhDeGKM7OXa9jwNjhd9BbDmYa/PPHK1WN5T/b8lTHo76GLALuvscog=@vger.kernel.org
X-Gm-Message-State: AFuF++kcvuzYqJOrV6ysYRmzfcGkroKJBo66VdS+fLcsW3Ha5Ha1J1dL
	4GeG7JWCM10du5WdpcNSCH1mR9oK1AUyDCATVEZySBYx+CCncOC33+i6
X-Gm-Gg: AR+sD13gXkAw/2KmEfXLiwENxxwSD451d0OBjPhWHTwfWX3faAydGwYQ/zH5He8drvV
	h3Iu06U+cLKPXzW+2WRNnFqOoJKlFgTe2Pgv06PVSdCLcfccCl71VZcwdFgUQrgWDQz0RCsxVKf
	aRt6v76CJisu6LW1TakDqNL8tHoZo2fV782IAIoHVu7Ez36gMcEK5HrExzIjGyAcfog48Ogh8tC
	3NdliLwUDVNWC/Un/nk/ScVX2QqMmutktoGMpee8gmcTQl6kjR8rGM5A0kNZ1luVSmNWJTeHBzP
	wD6DEOln4weIKpABLDKQp0N8U1iBZh4/LOMRUqOg1tcY+JmfzUih87Y8X+BP0PB+bAS5BBz/3nG
	1M2sPd1b3sdjhmcCRuhsW8NjMIGqTwXg1J83X4BntegP42wJtm7GuzfXu/HPBkmoxpqtfkvQ5Nl
	dKSlrM2a0JLdag57r4/NeNJZfw8li4RWdtHmxMx510HWGAm5iBc6hub2b6esA6vRixBKHa0X/cq
	/2M
X-Received: by 2002:a05:6a00:a221:b0:857:7337:5db9 with SMTP id d2e1a72fcca58-85773375f9cmr32559402b3a.23.1788270377256;
        Tue, 01 Sep 2026 06:46:17 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be8f52cb4sm1132502b3a.39.2026.09.01.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:46:16 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v5 1/3] ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled
Date: Tue,  1 Sep 2026 21:46:02 +0800
Message-Id: <20260901134604.4052265-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901134604.4052265-1-dolinux.peng@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
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

