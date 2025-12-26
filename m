Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA633195F8;
	Fri, 26 Dec 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766747162; cv=none; b=isi8cFIkwuTDnDzpemtao1z4UaLmOK8qZDoO+epl7mnCK1Spbsl8WNeeyUA3Wd+1UpMajSLobVlcRKe6SrtYrstwSgPktzFa/d4KsA36xUmucXjah0DGPvDGb/GZl1ja+SIZsbPDQm04fTj0uWJAPtEp753evCEiHisPaUjLM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766747162; c=relaxed/simple;
	bh=yhU3jjId44lSe/Pd5qeULoYaErLgaFQgQgEHdU+B6Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AxBJwn5FBXM92GwBY1L0Zwi9HqV9XWvIw/z6K7dEWG+Hqea8T1DwrBpiepTG0l5UsCDWuQDY/YhTq2V37tmr0aPDHaBfsbJp76R9+EJRAPBP24k522oIbCkVrfvMcShWMc0KGtXoLjx3nEW/gKVDrf7TIsAXkTmjq70en+OXIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=J1NpjQ1J; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="J1NpjQ1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MkbWufrSLN155drEYLw+EYsREebSy0IRgHefwoBBqIs=;
  b=J1NpjQ1JqicgQu0hkwSWAiONftRh98HLWfnM11qXbLmWdNtm5b+RyUF5
   FtSIceAtIK5aXZy30xwcQOAQEHlUOvFaV01jMEQ+6x7CkKyR4KzmNJ96c
   RCDmazohxnY4R1w2EQYEfmY3BDyvnpyAa9XsV/W6FwhI4OS7Xn0ZlUl8g
   I=;
X-CSE-ConnectionGUID: upmWl5PGS6+3gRHxAg77rQ==
X-CSE-MsgGUID: lNfwDtLcTfSBQ5UrYs5f+w==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,177,1763420400"; 
   d="scan'208";a="134569106"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 12:05:51 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	keisuke.nishimura@inria.fr
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: drop unneeded assignment to soft_mode
Date: Fri, 26 Dec 2025 12:05:31 +0100
Message-Id: <20251226110531.4129794-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

soft_mode is not read in the enable case, so drop the assignment.
Drop also the comment text that refers to the assignment and realign
the comment.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---

Since soft_more is not used, there is no direct line from the goal of
verification to finding this problem.

kernel/trace/trace_events.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 76067529db61..137b4d9bb116 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -826,16 +826,15 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		 * When soft_disable is set and enable is set, we want to
 		 * register the tracepoint for the event, but leave the event
 		 * as is. That means, if the event was already enabled, we do
-		 * nothing (but set soft_mode). If the event is disabled, we
-		 * set SOFT_DISABLED before enabling the event tracepoint, so
-		 * it still seems to be disabled.
+		 * nothing. If the event is disabled, we set SOFT_DISABLED
+		 * before enabling the event tracepoint, so it still seems
+		 * to be disabled.
 		 */
 		if (!soft_disable)
 			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 		else {
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
-			soft_mode = true;
 			/* Enable use of trace_buffered_event */
 			trace_buffered_event_enable();
 		}

