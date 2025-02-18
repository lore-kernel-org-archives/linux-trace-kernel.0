Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73E22FF40;
	Tue, 18 Feb 2025 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881315; cv=none; b=gXH1Oz81Jp5lNrtD/GB/tvwdjYV/ogU3FAowYOWayC2Ahf15uRRCgFKCCOQylTG1dMnKNpY6rtIJVCqtEiSGzdYhgxxpILfpAszwMMKCkDRX8LrYHo+H5wSaUeA7QeaiyvTqk5YaJIp8Fnk+y+qMljcPCrpNu+e0St4sl6LgBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881315; c=relaxed/simple;
	bh=ptCScSd+4h1BoYlk7WM359v+rG83VRckDRqhzGXIR6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbUq3t5XPN5MYHjxOV43ocSuZjCdbfG7iOC1Jf3nAjdVPoGYrFGcMPFeDrT1Xp90OLUdCsDAv71uNL/m/e7cUE6tv6UawybGSFFdGT6AymUxLLq+G1IzZmD9uXqcnBL098UcBlI0vPNgRYZm/ELVhXFwuW1hooOPoY9rmYpnt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gSieVkef; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gSieVkef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Caj+i
	S4MCMJNnw0cvQpDvzauLB52HqMQBpoATbVMicA=; b=gSieVkefNMIzjP+/ukSin
	MyvhXXwrtxwlJGrO2CEVDRV9DFTQcbKdeoz+eQHS/3NQ/a0gtqMOoJkVmwk11R0E
	ys9y3qVGfuYRUS6caxgWoXBthMOQP39Q/BMWecSLwdQK/l3v3Fnt0tuZt80+Jd/P
	JVpcijI5xzwU4Wd5LZPGHg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3b1JAe7Rn+27cMQ--.47696S2;
	Tue, 18 Feb 2025 20:21:21 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
Subject: [PATCH v1] fgraph: Correct typo in ftrace_return_to_handler comment
Date: Tue, 18 Feb 2025 20:20:34 +0800
Message-ID: <20250218122052.58348-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b1JAe7Rn+27cMQ--.47696S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4DGr4UXr4xXF47Gr1rJFb_yoWxZwb_Xr
	ZFyF18ua48CFn2vF1fAFZ7ZFyxtr1FgFW8uw47tFZxC3WUKF43J3Z8X3ZIqFWDZrs2grsa
	9r15Wr1UGw13tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtSdgJUUUUU==
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYBj3a2e0BFtIBAABsl

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 5dddfc2149f6..8d925cbdce3a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -865,7 +865,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 }
 
 /*
- * After all architecures have selected HAVE_FUNCTION_GRAPH_FREGS, we can
+ * After all architectures have selected HAVE_FUNCTION_GRAPH_FREGS, we can
  * leave only ftrace_return_to_handler(fregs).
  */
 #ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
-- 
2.48.1

