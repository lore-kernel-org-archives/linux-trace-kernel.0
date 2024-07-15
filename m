Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544B22EF0;
	Mon, 15 Jul 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069270; cv=none; b=t7VvGCZfN7Ad92ou85A84YiPnQoE/IF+gkbvxPiqLEMi6xBVLZdjbUUT2nAIDOy3YiWX6jff8u9cZjuZT6ZhEUzaUutMRsyXJQze18m15AzF+NouMSxWIRF0R4pCS8dKBhsFS6X855WiRtqihV6bWLkaRLqE8ISH7eg0zt03fr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069270; c=relaxed/simple;
	bh=h15kWJY170LAeuVz3f2p5QYCNVqSa2lCjIzW5LqLNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=abHIzL1LKf2+ASTzT/L/JBhhhymZNKPSbovi4Fo0RQwp9XP7Dj3x6pY5XxrkLgBRcpV0+0cFOYQ0rPvdlj+dx/YiVzvB7V0pOPiPUaXgdGydIbU3vvn1/g9H8M4yMrQyG/mLkV/oqMHozhkV8v7Gw/nne18OQD2zWiTWe9bDSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC48C4AF0A;
	Mon, 15 Jul 2024 18:47:47 +0000 (UTC)
Date: Mon, 15 Jul 2024 14:47:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Ingo
 Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Kate
 Stewart <kstewart@linuxfoundation.org>, Clark Williams
 <williams@redhat.com>, "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
 John Kacur <jkacur@redhat.com>
Subject: [PATCH] tracing: Update MAINTAINERS file
Message-ID: <20240715144745.51d887a9@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Gone but never forgotten.

[ Also moved Daniel's name to be consistent with the alphabetical order ]

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 CREDITS     | 10 +++++++---
 MAINTAINERS |  3 ---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/CREDITS b/CREDITS
index 88c4c08cb613..d7798910e99f 100644
--- a/CREDITS
+++ b/CREDITS
@@ -271,9 +271,6 @@ D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
 D: Various bugfixes and changes to sound drivers
 S: USA
 
-N: Daniel Bristot de Oliveira
-D: Scheduler contributions, notably: SCHED_DEADLINE
-
 N: Carlos Henrique Bauer
 E: chbauer@acm.org
 E: bauer@atlas.unisinos.br
@@ -534,6 +531,13 @@ S: Kopmansg 2
 S: 411 13  Goteborg
 S: Sweden
 
+N: Daniel Bristot de Oliveira
+D: Scheduler contributions, notably: SCHED_DEADLINE
+D: Real-time Linux Analysis
+D: Runtime Verification
+D: OS Noise and Latency Tracers
+S: Brazil and Italy
+
 N: Paul Bristow
 E: paul@paulbristow.net
 W: https://paulbristow.net/linux/idefloppy.html
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e1b8bbacb5e..0b7e4cd4ffd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18895,7 +18895,6 @@ F:	include/uapi/linux/rtc.h
 F:	tools/testing/selftests/rtc/
 
 Real-time Linux Analysis (RTLA) tools
-M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
@@ -19529,7 +19528,6 @@ S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
 
 RUNTIME VERIFICATION (RV)
-M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
@@ -22806,7 +22804,6 @@ F:	kernel/trace/trace_mmiotrace.c
 
 TRACING OS NOISE / LATENCY TRACERS
 M:	Steven Rostedt <rostedt@goodmis.org>
-M:	Daniel Bristot de Oliveira <bristot@kernel.org>
 S:	Maintained
 F:	Documentation/trace/hwlat_detector.rst
 F:	Documentation/trace/osnoise-tracer.rst
-- 
2.43.0

