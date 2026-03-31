Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA53A6B77;
	Tue, 31 Mar 2026 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953038; cv=none; b=O1TgbYY3TCrIP8sXqOOI9DtxJA4YVxqFPhLFBwTOJUKEOQMlodRIYQQO4m/Ur/4z6UJuQClYBNjG4A4vXF3+nSisiqLxC6vF7rzvv0G4ZTpj3IvUkJiVyf89xwG4MBl1cOLdgL07qFTTJT+z9CPnjAiZ9X/3esZF8oEAdOtImOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953038; c=relaxed/simple;
	bh=Epu3xRCRZu/pdTFE0Nu2bcU1YW5f+UvQ2r6cVP/sLBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zrv18b7Vq2tneZ4VB++l8ch721rxvxRWYo/ZSbODRnogMDwBzuk5mskyjcWV//zndBwMOwKpWRV2gnCmfoUW9SBNYRQV/LuB2KZ1av9/VtURjROjbDdSi28lEMJFtysJ0qxzkrzpGv2gPNiVlcbwnwd4Md7FNAhm9+v34qvMmkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSn8hFXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSn8hFXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407FFC19423;
	Tue, 31 Mar 2026 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774953037;
	bh=Epu3xRCRZu/pdTFE0Nu2bcU1YW5f+UvQ2r6cVP/sLBc=;
	h=From:To:Cc:Subject:Date:From;
	b=XSn8hFXeMeU2x06ytGG693IP0Yk0efe7pZCAGeS/vGNTYFoIO9lisKHW2vjlaJ16L
	 VTUQGueANmfo+hsBEaX+3l+/xo4xHvaWzCs2wiRFry9rCjtsra9STBolQ6dZRgVx/R
	 joG7WibBGQCEiOCe6tB/fG3Q64bDijP9+2iXLkWWPvHFLkP5GP67ndpjRgMXMV7gD4
	 8iFIApPTwBxyRJpZTEVtU4RrdxCYq/8cYou9fD2Dr2gBbZh4/XRgITXfbjHR4M9v+2
	 GLeWKgMc60Cj8JcHmUVI5ATbfAsYTcwV4RI4bvr7OXLfuTlxC4OdFAOk8D4X6K41zZ
	 34I3Bad6IJBpQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: remove duplicate  latency_fsnotify() stub
Date: Tue, 31 Mar 2026 12:30:21 +0200
Message-Id: <20260331103033.4054780-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

During the move, an extra copy of latency_fsnotify() crept in:

kernel/trace/trace_snapshot.c:395:20: error: redefinition of 'latency_fsnotify'
  395 | static inline void latency_fsnotify(struct trace_array *tr) { }
      |                    ^~~~~~~~~~~~~~~~
In file included from kernel/trace/trace_snapshot.c:6:
kernel/trace/trace.h:858:20: note: previous definition of 'latency_fsnotify' with type 'void(struct trace_array *)'
  858 | static inline void latency_fsnotify(struct trace_array *tr) { }
      |                    ^~~~~~~~~~~~~~~~

The function is still called from the hwlat and osnoise tracers, so the
copy in the header file is the one that has to stay.

Remove the extra one from trace_snapshot.c

Fixes: bade44fe5462 ("tracing: Move snapshot code out of trace.c and into trace_snapshot.c")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please fold into the commit that moves the code, if possible
---
 kernel/trace/trace_snapshot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
index 8865b2ef2264..a54e9533e79d 100644
--- a/kernel/trace/trace_snapshot.c
+++ b/kernel/trace/trace_snapshot.c
@@ -391,8 +391,6 @@ void latency_fsnotify(struct trace_array *tr)
 	 */
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
-#else
-static inline void latency_fsnotify(struct trace_array *tr) { }
 #endif /* LATENCY_FS_NOTIFY */
 static const struct file_operations tracing_max_lat_fops;
 
-- 
2.39.5

