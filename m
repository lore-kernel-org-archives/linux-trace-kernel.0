Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901041;
	b=Z3UNvzWGatLHZGt+1ss9wW5/JH9zyBjbqxcgZIZPZwFfPJoAUGnZZV2W5Av+XPDFMHTF
	 +Hcy2jAhFuyYZ+FNYbWjzxC7OcOS75BgWOlLcOYOP1LEhs5AC0dyi+v6LCVU76mZAnGk9
	 fFL8mVnpugt5OQv/wWeqFZc7X00ycSGfTuPo66JWOVtnTUpOFUvXRZOH/Kp6ay1UceIHn
	 kGNiS97Ji+5voGyAroSObifyySB7JNwMykrf9UYUoo63INGhFBIfZUqu0XLYV1nGyu0HG
	 QELyw/3G+XW2tJfbhF+IU25DQOxDqaB5Q6EreIXkKEW4TJm4VrjPe2IJr8VQvxrfuaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901041;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kfri5xV9wlanZGjO8cNWzQ4yzQwShWrO5m2zeFlY9ek=;
	b=D4ULISvYvgyVMWqKGTCoXA1tWJh5lKlV+7df3mNKnGwKJEFxUdqLWysZGfKfsj+9lK55
	 8tfs7EmE0GwdLEUAsSeADo4N61rkoSSILx6l9fbjxfSQKXRqY0Sv3cQ/OEkVf6JgdjDTv
	 kMcZkvTxw7R6XxBtxC0BEFqfmeY7kBLxd0OAQtwN5KfsoDS2C03GKjCMj/VNltwEa6OUR
	 MtDD4/IZvp8S3Ng0+8OzAqH+N0xfvrBbl9LZCcg+neamdVG8hn0ZTRPLw6BxWeAVjB171
	 5c8BcV8GMr/8AOehXKYAP9vxHY8fxILYGnvy1b7OT5x5goQ2iS6DnMqKDfHip3+tiiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hikRLBJI;
	arc=none smtp.remote-ip=91.218.175.103
Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5B606A328
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D5B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hikRLBJI
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X8Jh5EH8xL3BV+TF+inqe7PXc7xM9UMIAqG2HCny/8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901039; v=1; x=1794505839;
 b=hikRLBJIeXTOmiXBgU6MiyxPuEBze70t6o9EQ09JOyMdI7mVbs6Mfe3DkWUczyjxQORscn+8
 4/tFed2q756MXrHZvxZeXLPcBg3Vj3gRZouTHg+QnZ1oYKo0mbbj4eybgxJnDfVNyHq5ny7JhtN
 h7lJnYasJHmcdQXG7Oa52hlw=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 1a99e983495ad7b3;
	Thu, 05 Nov 2026 17:50:39 +0000
X-Mizu-Trace-ID: 1a99e983495ad7b3
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 10/14] rv: Add tlob model DOT file
Date: Fri,  6 Nov 2026 01:49:10 +0800
Message-Id: <915c21a8b25b42306f95fb8dfcaeee283d993c49.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add the Graphviz DOT specification of the tlob hybrid automaton to
tools/verification/models/.

The model has four states (stopped, running, waiting, sleeping) and six
events (start, stop, sleep, preempt, wakeup, switch_in).  A single clock
invariant, clk_elapsed < BUDGET_NS(), holds in running, waiting and
sleeping; stopped has no invariant, hence no timer.

wakeup is a self-loop on running and waiting: a task that is already
queued can still be the target of a traced wakeup, either by waking
itself or through ttwu_runnable() while preempted, and neither case ends
the budget window.  stopped takes every scheduler event as a self-loop,
so a task keeps going through the scheduler between windows.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/verification/models/tlob.dot | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tools/verification/models/tlob.dot

diff --git a/tools/verification/models/tlob.dot b/tools/verification/models/tlob.dot
new file mode 100644
index 000000000000..021a4d823548
--- /dev/null
+++ b/tools/verification/models/tlob.dot
@@ -0,0 +1,27 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_stopped"};
+	{node [shape = plaintext] "running"};
+	{node [shape = plaintext] "waiting"};
+	{node [shape = plaintext] "sleeping"};
+	{node [shape = ellipse] "stopped"};
+	"__init_stopped" -> "stopped";
+	"running"  [label = "running\nclk_elapsed <= BUDGET_NS()"];
+	"waiting"  [label = "waiting\nclk_elapsed <= BUDGET_NS()"];
+	"sleeping" [label = "sleeping\nclk_elapsed <= BUDGET_NS()"];
+	"stopped"  [label = "stopped", color = green3];
+	"running"  -> "sleeping" [ label = "sleep" ];
+	"running"  -> "waiting"  [ label = "preempt" ];
+	"running"  -> "running"  [ label = "wakeup" ];
+	"waiting"  -> "running"  [ label = "switch_in" ];
+	"waiting"  -> "waiting"  [ label = "wakeup" ];
+	"sleeping" -> "waiting"  [ label = "wakeup" ];
+	"running"  -> "stopped"  [ label = "stop" ];
+	"stopped"  -> "running"  [ label = "start;reset(clk_elapsed)" ];
+	"stopped"  -> "stopped"  [ label = "preempt\nsleep\nswitch_in\nwakeup" ];
+	{ rank = min ;
+		"__init_stopped";
+		"stopped";
+	}
+}
-- 
2.25.1

