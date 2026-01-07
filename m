Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479813B7A3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750749; cv=none; b=BVG252QErsSFnLwJ/+aesZYIdER73zLMDTszPlWa1zWj3wlPOkpPMd5Lunq6UT5Pfw4WxGfYN6O5g+tkWBIV/z5d7vFMQPqi4zzlLct1Kmbtz2Mi3tcFP/xAVMRt9qXCaqUbcUnRnnh7TldniG9963juq1bS40NSoZEkUzFs/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750749; c=relaxed/simple;
	bh=WNWjRZbC+yawsGyhGxzupZ2JlNneUImEGt3I22UCMVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4zZtEbR95L8yV++RFDgzSdP7Qri8UAzJhgvYgQFZlrvfPh0IBaiV5UMwlXII9vtLZE587FThVck2K9oevrjvDdYsqFuOF8DxfKO3KjjYMmSmS+KZL2TphLE0c6ailgdAHq46ChjIqUKnVJLueu8fSZIiFheYFgFx1G1CfXY8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C9uM6JFV; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C9uM6JFV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767750735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Iflu0FETmF+N+3Ihbe1LNGC98WYCJactyqJICsq2wtg=;
	b=C9uM6JFV1F9R1ydLvSQrN4a8je2IIMs6dQFllgXRJSyPMyY4VnZ79uECmmJlwHUa2IPSF0
	iujmqEWoJ/YLM9Ff9a0h60NuH5bObxiRCwbont8ZG1crKlJajiGU/1BggEShliVLxrANLv
	cXRH0Cm3aaKrOy60Z/Qe4AVis4/4j8g=
From: sunliming@linux.dev
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	sunliming <sunliming@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] fgraph: Make sure fregs is non-null when accessing
Date: Wed,  7 Jan 2026 09:51:25 +0800
Message-Id: <20260107015125.27659-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below smatch warnings:
kernel/trace/fgraph.c:834 __ftrace_return_to_handler() error: we previously
assumed 'fregs' could be null (see line 830)

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202512131657.JQUt5fXQ-lkp@intel.com/
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/fgraph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cc48d16be43e..0f50a55032c5 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -837,7 +837,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		goto out;
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
-	trace.retval = ftrace_regs_get_return_value(fregs);
+	if (fregs)
+		trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
 
 	bitmap = get_bitmap_bits(current, offset);
-- 
2.25.1

