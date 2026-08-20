Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF947ECC8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244352; cv=none; b=bZvQZ0TFPacWbg5NrZXJezuJcCP4McFUKPvOPVS3HfH7GCd8CAHDCZ/iSb+GkGmT63iNld+qgGP0Yjow0O2CBCkEkUd52ogwkgDdhsAZ2jdtdxsk/SDoFTmkv1RUhiTBr2Mr3B6NmA1L9atdvc7DqHdklgqGuJKa0MlIS99XUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244352; c=relaxed/simple;
	bh=WsmsBu+BIGCyiGy6htvq6kr9ZQcqixbUM6tJ5pEub7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XB4bzKsJKkiBf8so4xJGwLe3zv7A9NyAlDzAMppkwhORf94suLc8afrNBa8SoVgxQtdao3eGCPJNctv2mXwZuweeS6cRcNS4uobKAkV1z2q6A+8jDErTvaJazRppIzkke+p3H7Q5bjH6Romsgm6vH/XYIoKagUDHh/XUZum15T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qjz48aqD; arc=none smtp.client-ip=95.215.58.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qjz48aqD"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WsmsBu+BIGCyiGy6htvq6kr9ZQcqixbUM6tJ5pEub7I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244348; v=1; x=1787849148;
 b=qjz48aqD73x+6gtTfDZqVPTTZr90MHlPAwERk4uP/hK2tbXRmL4tyK5kB0KrjaoflZSpslOw
 Thka/zrA8U3R7tppy917BzaO9gJh5NBF2PUazoXRt67KFJ44NSndAOL9lW67WmDT3qayzf5IzKl
 umCkFYnmh8AnsMBSoFvjHQrY=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 4208490b75db7ca0;
	Thu, 20 Aug 2026 16:45:48 +0000
X-Mizu-Trace-ID: 4208490b75db7ca0
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 3/9] rv: Add tlob model DOT file
Date: Fri, 21 Aug 2026 00:45:12 +0800
Message-Id: <9e27f8af4520800fd1f19a2b9e9c0a0f2250920a.1787243842.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
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
 tools/verification/models/tlob.dot | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 tools/verification/models/tlob.dot

diff --git a/tools/verification/models/tlob.dot b/tools/verification/models/tlob.dot
new file mode 100644
index 000000000000..515695599cf0
--- /dev/null
+++ b/tools/verification/models/tlob.dot
@@ -0,0 +1,24 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_stopped"};
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

