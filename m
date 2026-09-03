Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4B3FDC18;
	Thu,  3 Sep 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419073; cv=none; b=nFSWBPco4VkybWHNQrJvYDX1ee2wYXWtojCs0i4/mZ/ZwHQ1hBNWj5WgtzOFUal0GY6ZslGoulWHpT3duZZGUEwr6aKDqDzlrrQxrGu5Iwn0SdrcFXONiFoi07C8B1iAmC5oND9N/gQAowh7ivlor8XyAMKvKXnLCr/hUR1A/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419073; c=relaxed/simple;
	bh=mwANxLS6bxYhyYMrT+1jzLYffebrt+HciyIfKItAAH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IC3FZccep55QMuGdf4THwQyGFrh9PAWEZJDWO6KxdRPm1XypqkYNl9JzlENiM63EGmeNE/6omNcFW/AS9a5ckET8Kod1A17PYxRpJDOV2SzGMj6cLFVuHEiZ0E2dpxJR9qWgYyudCFgtr8cWFMkLJHhO4Em/SZlsT1qasMsoFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=S05MFAq6; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=F5Xo+jZI; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S05MFAq6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F5Xo+jZI"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hb9ZL1F9VzKv7V;
	Thu, 03 Sep 2026 09:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788419066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EDszXM77rysWN3TrIUrTbiqTu09Lh/qkUY7ZyZhkYsI=;
	b=S05MFAq6DstWIPsRlUwep6wgGyqpVGUUxOlL1V4hL8VjKvRlMBphIB4kHdyNyGFSVBc2Xt
	D7I+EsW2FE/utdh1+sVU7L/LePfyj7wfX0z4Fv8IU5JWSlPFpW/9L2RczxkryUzKF5rhXw
	ZXw5u7Hx00hWd6YLyZUVhiMDh39clGPu1r64lgGVD3rv2oR8bf0eXNMrR7oDcilwCU53Wi
	0LC5e0oKgzjU/7pWnLuJs1OsRSPfhrcYFBpWCBHhku9jObNLmH9qpVB3d8dJOyP6fTS2ZJ
	55kAavX5iFqW70dpPifJshgo5UnxNS1KicF6K7Bpv28YCITJ2QRd+otasNPUVQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788419064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EDszXM77rysWN3TrIUrTbiqTu09Lh/qkUY7ZyZhkYsI=;
	b=F5Xo+jZISY4G+JpM2HK0KQ9ipszZrU59CmmDBlctCnZcASLSdivYzA81ZDEy5i3t0htql5
	eZLZyDhMjcakrYyHjqRubpBvuei9inTqBZiAI4FwfoshIeIrlcpLiHPRYg/OoMwTaidp5R
	ulIX15AMEBDMrzXQ8xDRV/I0ZGkNGHLSfjnmvYVWqG8R/oqShAWrAVYgA/8Pi6k5XW18+h
	BfSN3mIVBfOvam3LdUAveP71nwPXmMX7xr1VXktq0HR+A3uzPiDoiJAFttiL319aBSPM6O
	qRUxHyUKVSd4DVRocob4EhypI3QBD3y9CClbuH8Us+N1fBinddJScBeV50KHtQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] Documentation: trace: histogram-design: fix bracket, improve wording
Date: Thu,  3 Sep 2026 09:02:49 +0200
Message-ID: <20260903070249.713483-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xxnkpgn7a7hyy7ak3ebssxd34nea59fe
X-MBO-RS-ID: 2fe46c1e398b0076018

Add missing ')' and add note about the new way of triggering an event.

CC: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
@ Steven, I added this line, because else the references wouldn't make sense.
References: $wakeup_lat, next_pid

+ ... (which
+could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
 are implemented, the parameters specified to the trace handler must be
 variables.  In this case, $wakeup_lat is obviously a variable, but
 next_pid isn't, since it's just naming a field in the sched_switch
---
 Documentation/trace/histogram-design.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 41a726cd3..86c83b177 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -25,7 +25,7 @@ tracing_map.c.
 
 If the kernel is compiled with CONFIG_HIST_TRIGGERS_DEBUG set, an
 event file named 'hist_debug' will appear in each event's
-subdirectory.  This file can be read at any time and will display some
+
 of the hist trigger internals described in this document. Specific
 examples and output will be described in test cases below.
 
@@ -916,6 +916,13 @@ means it will be automatically converted into a field variable::
           onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid)' >>
 	  /sys/kernel/tracing/events/sched/sched_switch/trigger
 
+Note that the above is the old way to trigger a synthetic event, whereas the
+newer way is preferred, which uses the trace() action handler::
+
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
+          onmatch(sched.sched_waking).trace(wakeup_latency,$wakeup_lat,next_pid)' >>
+	  /sys/kernel/tracing/events/sched/sched_switch/trigger
+
 The diagram for the sched_switch event is similar to previous examples
 but shows the additional field_vars[] array for hist_data and shows
 the linkages between the field_vars and the variables and references
-- 
2.54.0

