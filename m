Received: from mta0.migadu.com (out-223.mta0.migadu.com [91.218.175.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82D495524
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163364; cv=none; b=A88FgPCybwug3BZoKN8Xs0jMsOOxTJ2O4ooIUNAHMZDDHiL8TXDcc00xQw+BJGDw0mdVZepHAIpXJVAwehCX1/bUseSEXP4aJyNfRu9RT350zF9vfHvWsU1w0H4MWMiCseo//IreFbTOJ7ZZUeIWB2fU9e2rr9wKJjE3e5U0vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163364; c=relaxed/simple;
	bh=TmU60pziJvP9jkj9FRe900aTtXpSjdcwaH8P271b+MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/hiwHTrR4bA8A5ntHs8lukXWJWiZ+o0EHZ8WHhzNs1VyaadreNta3aC8KD6n4ShMxVj3TWAXtEng2HLvUMDmlRcayk9xQVGRDkWNUugr+qh6yUlr531vKpgiQFvfWpZaTpa3IqU8bw70/UBjrh0sQs3xzqiWCL9MclmPj2QRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hA9SJpqG; arc=none smtp.client-ip=91.218.175.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hA9SJpqG"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TmU60pziJvP9jkj9FRe900aTtXpSjdcwaH8P271b+MU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163358; v=1; x=1787768158;
 b=hA9SJpqGNDv69FVb3FVLKbInfozob+uRtYz6Rh4pEadUzjv2GMR52SrEUdGONFM7UgAyV9VI
 GjU24EZ3/avHFwmhsvsH4jpEfMKfCoO/MCg61x7uZkQZK/k8KSQtQ7lTOnShcj6nYy6hll5LghL
 /z0AMl4MrjPalBbIhn6DtEkQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (180.165.15.98)
	by mta12.migadu.com with ESMTPS id 561250060a69f1ac;
	Wed, 19 Aug 2026 18:15:58 +0000
X-Mizu-Trace-ID: 561250060a69f1ac
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 3/9] rv: Add tlob model DOT file
Date: Thu, 20 Aug 2026 02:15:20 +0800
Message-Id: <306910ca9aa71384ad3bea479a009fd921dc0aae.1787161646.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add the Graphviz DOT specification of the tlob hybrid automaton to
tools/verification/models/.  The model has three states (running,
waiting, sleeping), five transitions (switch_in, preempt, wakeup,
sleep), and a single clock invariant clk_elapsed < BUDGET_NS() active
in all states.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/verification/models/tlob.dot | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/verification/models/tlob.dot

diff --git a/tools/verification/models/tlob.dot b/tools/verification/models/tlob.dot
new file mode 100644
index 000000000000..7f6f09c3d7cf
--- /dev/null
+++ b/tools/verification/models/tlob.dot
@@ -0,0 +1,25 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_stopped"};
+	{node [shape = ellipse] "running"};
+	{node [shape = plaintext] "running"};
+	{node [shape = plaintext] "waiting"};
+	{node [shape = plaintext] "sleeping"};
+	{node [shape = plaintext] "stopped"};
+	"__init_stopped" -> "stopped";
+	"running"  [label = "running\nclk_elapsed < BUDGET_NS()",  color = green3];
+	"waiting"  [label = "waiting\nclk_elapsed < BUDGET_NS()"];
+	"sleeping" [label = "sleeping\nclk_elapsed < BUDGET_NS()"];
+	"stopped"  [label = "stopped"];
+	"running"  -> "sleeping" [ label = "sleep" ];
+	"running"  -> "waiting"  [ label = "preempt" ];
+	"waiting"  -> "running"  [ label = "switch_in" ];
+	"sleeping" -> "waiting"  [ label = "wakeup" ];
+	"running"  -> "stopped"  [ label = "stop" ];
+	"stopped"  -> "running"  [ label = "start;reset(clk_elapsed)" ];
+	{ rank = min ;
+		"__init_stopped";
+		"stopped";
+	}
+}
-- 
2.25.1

