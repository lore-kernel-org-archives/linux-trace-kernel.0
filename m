Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90E2E737D
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848878; cv=none; b=Nu+xaIMMyyeehVrViQ0tzx950AhqKvDX3zFfT48rEEBpkZYmxf2h0T3GoJAtNaySMNF+KmdVLwzq6eTZOqqYfq9iROu09SK/t6/00ZA4GLDZEyTvimyNzOl/AhrNo7tMFZVRg8M3T43d5Dxeaaf9MrYXSYWF8NaYaqBU6NuXxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848878; c=relaxed/simple;
	bh=Gec/J8NF049q4UCfJJkADmg4cg62P+dSzwym4JYkgXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVFDTWl+whW/yQXGxm/PmnaajEkb0kq5EX+WS37BH/2yVQTOiAbyRr37yLJA/GqYnBhInOPzWEzWdw32ZCvqP+leDg1/w6Vm1ToDIynbS/zD5Co8v8GjFKm3PHkBs5Y838RbMpfFkf6NayG0cPzr8Yn3mpWrZ+dN7FW1zwYjnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MblHZffM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MblHZffM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL6Vtq/7gRex0JJMJDCNdVNyXBAbLcVC4mwg/C9UCVA=;
	b=MblHZffMZfy1JI4yr/ebjrHRS3UkvUnO3MOMDBu1rC8DmKCDLbpxIQhEFlvl01Nl5Dk2UD
	iaWs5Fe9maADd3Ea7SeYKX762DRgBevxwiHa4HCUmBIPyeHFitQd7LtIGH1IzblY9rNAFD
	hgHhXOC9yj5cTSMM3LYHJ8b7TlQRBbk=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 3/9] rv/tlob: add tlob model DOT file
Date: Mon,  8 Jun 2026 00:13:51 +0800
Message-Id: <5303351c55468fddf98847512b47e633525a6d3c.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add tools/verification/models/tlob.dot, the Graphviz specification of
the tlob hybrid automaton.  The model has three states (running,
waiting, sleeping) connected by four transitions (switch_in, preempt,
wakeup, sleep) with a single clock invariant clk_elapsed < BUDGET_NS()
active in all states.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/verification/models/tlob.dot | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tools/verification/models/tlob.dot

diff --git a/tools/verification/models/tlob.dot b/tools/verification/models/tlob.dot
new file mode 100644
index 000000000000..a1834daff2ed
--- /dev/null
+++ b/tools/verification/models/tlob.dot
@@ -0,0 +1,22 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_running"};
+	{node [shape = ellipse] "running"};
+	{node [shape = plaintext] "running"};
+	{node [shape = plaintext] "waiting"};
+	{node [shape = plaintext] "sleeping"};
+	"__init_running" -> "running";
+	"running"  -> "running"  [ label = "start;reset(clk_elapsed)" ];
+	"running"  [label = "running\nclk_elapsed < BUDGET_NS()",  color = green3];
+	"waiting"  [label = "waiting\nclk_elapsed < BUDGET_NS()"];
+	"sleeping" [label = "sleeping\nclk_elapsed < BUDGET_NS()"];
+	"running"  -> "sleeping" [ label = "sleep" ];
+	"running"  -> "waiting"  [ label = "preempt" ];
+	"waiting"  -> "running"  [ label = "switch_in" ];
+	"sleeping" -> "waiting"  [ label = "wakeup" ];
+	{ rank = min ;
+		"__init_running";
+		"running";
+	}
+}
-- 
2.43.0

