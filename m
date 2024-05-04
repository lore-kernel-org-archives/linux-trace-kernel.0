Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944338394;
	Sat,  4 May 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714829009; cv=none; b=OoJFYiUlEJ6PzIUk9TMOBBcIDOF1fUUPk9qXN2LCodFIlBYsRbhlsIFjH3kGjtFgfj7PrmPGRfQ3COTY+VKFQZBJIaAXJTWDCOSTmCwaSvpyNyARIl/UEUJ5Mb+cRlz3yhGyR5srlPShajxTDLS53g7rbxotQtVjhzFYo2c+HHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714829009; c=relaxed/simple;
	bh=j1r1jilx6lGom9Gnv3zuJNzqKo9xq3dNbo1zLxLuV2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZBpZnIN9ADSI6AUlpozLV32Hp/DP98KMWnHwfdzm6gX+xwErrSdNVnZfjtI5IyFxPCRpJ9nNJr72ZjQGWDjxqMSYLe7WVHC11JqsNpDuaaHtGFsWyutUMxpqwSQcJvzZmIgazQRimTf1gEm7YAkYqMA2nCQFoiOaj164OksKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YA1Y0DPK; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YA1Y0DPK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=OZa4/AI0KRmeOPBifgCo9CMRnurRIOGqDfHkqHbaCoY=; b=YA1Y0DPKmf9ibdD7
	TiJwjHTkWpvigshrq3pt4PdX+8cERDwazd6I4WpUIqO4DwSnN8qOQXFvTdgpU78BwcLL94m1uZ1lp
	aMS1753cUa/DDhN8zUUh6eT0JkB2XDsSHIo/d5ZaguElKO0fyimIK9NR/MktwG0R9K+p60FKe/AXt
	jZyGhtjgQ8JiA/I2wF6rjItnohJgCGEABhWPt7T5R/pA7nwsHyE96HuBbhLoKpE43eo6WYVxgbJ8K
	J6ligwwnXzDW9gfZEbq9b+TlcxffDoIrtGdcHC/Z4ATOgBmpxV6cfmsKCX+bKxnpEWBQ30zS2TViC
	VsO1QIaE7RszQpcjfw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3FM1-004hMp-15;
	Sat, 04 May 2024 13:23:05 +0000
From: linux@treblig.org
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ftrace: Remove unused list 'ftrace_direct_funcs'
Date: Sat,  4 May 2024 14:23:03 +0100
Message-ID: <20240504132303.67538-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit 8788ca164eb4b ("ftrace: Remove the legacy _ftrace_direct API")
stopped using 'ftrace_direct_funcs' (and the associated
struct ftrace_direct_func).  Remove them.

Build tested only (on x86-64 with FTRACE and DYNAMIC_FTRACE
enabled)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/ftrace.h | 1 -
 kernel/trace/ftrace.c  | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d149..b01cca36147ff 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -83,7 +83,6 @@ static inline void early_trace_init(void) { }
 
 struct module;
 struct ftrace_hash;
-struct ftrace_direct_func;
 
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
 	defined(CONFIG_DYNAMIC_FTRACE)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698b..b18b4ece3d7c9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5318,14 +5318,6 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long *ips, unsigned int cnt,
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
-struct ftrace_direct_func {
-	struct list_head	next;
-	unsigned long		addr;
-	int			count;
-};
-
-static LIST_HEAD(ftrace_direct_funcs);
-
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
 /*
-- 
2.45.0

