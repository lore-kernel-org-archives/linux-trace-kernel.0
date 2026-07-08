Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612D372B32
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525160; cv=none; b=pLMxFOJYt0TJKMOBhDfjvHi9Bvd5UrSequPDiXkhBlViyBFTKzK+X0hqikUEd+maEHZWn8P/npIoYQLYH6aLGVIQhCTU0XwVBxfEj/fz5YeY+NEMnTX9dTQoukNChoI4S1kRVBEYnOoDAq1mSTZG3SyKHNjxL65IKXQaGhnzax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525160; c=relaxed/simple;
	bh=b8J4EWS0MTPJLZeOj6syvuNLuuEaTuiDf1EU1w94kcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHpVLHvaEhG9+miYLKMBIIVWbBxPvlE3V0NzuXm2b7Jht82RwbIZ4naqiYCsVRd5P2sgL38rS4JbZ1V/G1Kb4tVUaPaqN0XrzmuuuN0UrHDQZjgMb8deuYEe6rZ/6QQHXfNMmEOeMgXZhrXIfOb3mfhL5aJY8qZPkIIZONUmwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ArQg6296; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArQg6296"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CA/mdAhuW+oHrSF/luPt/Kua0sHUMzh/xl4cARWqze4=;
	b=ArQg6296nLnMoh9a1BJHFCMTxmPQGvVWK03oJdHmfkAWc0ExovNyr/gAJ4wavhrK+rF/Oe
	kOseUOONmVC0Zwm9z0VqDdFFBLnQ2DCQEoadKAJpTNNKn4yYjPIYQJ3BQwie0dDU+1jbqd
	nN9X+4SXw7mjeEnYJQF0M78m/VQ0K08=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 3/8] rv/tlob: add tlob model DOT file
Date: Wed,  8 Jul 2026 23:38:29 +0800
Message-Id: <9a76007a92dfbcb46ff15f0bfde50222ec3fe19c.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add the Graphviz DOT specification of the tlob hybrid automaton to
tools/verification/models/.  The model has three states (running,
waiting, sleeping), four transitions (switch_in, preempt, wakeup,
sleep), and a single clock invariant clk_elapsed < BUDGET_NS() active
in all states.

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
2.25.1

