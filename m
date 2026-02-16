Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B930CDB0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249392; cv=none; b=E2n3ZnMgpD2JS7/IGkEMkWNLobqvqKQLp49pyBhV2dbZLL6UIVZXlHdomxmZbRd6nS7kYf0ZM2TKt4n++iqgQ5llq2jpTTMLd9rSQN5Mrwisk0QPrjC+LFfvyM42GMRur0vq0wuooLj8nU8cNQOQeU+evLsVj0jBZqORtG5Exyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249392; c=relaxed/simple;
	bh=mp3a0IiUHvP+CtGa3oJG1G5SNWHRamBAATH4Er8kLoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHGOKTxxB6aDcitTRJKZjkZHFgTA4nJ7Ki3IXozC+LL9Rat3s4SVUwMNt2uOwuQxwWSe9BKgH5J7oAJdZtjMMRr7zTBoFrlfRtCWnnwdfd7lXDhSEQwH0uMtPhWzBNliUj+7B7DmP3Uki7E/IbjffSAFJe2jFAFGeaGeDKUUxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CxxE7Huh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CxxE7Huh"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43767807cf3so2365074f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771249390; x=1771854190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o3MpI2zvqTEg6G302fPomtVC5PLXLlOoUgfy5gbT+w=;
        b=CxxE7Huh/wfBF6MnJzdVtN/fclu1b/sR5SEM/qQdVoZlAwAqeRqBSEBuD6ztK1mJgI
         ir8+vrrbMD7QWcX4058jvtXlqh32rgjzC4XOM0toe4ZoiykpBqNnH7aS8TcfsLGAVk3+
         uSQ5KyKznyoPic7t50R/e3tjhMyOjPQPu6976AA1UdpALrvGNw4IrVb8xf7kbO43Dub5
         LhrMeGX33sEVqO81Xo6gs4yML/qZn50D0WPAsdl089ihLvRqs1sjx00yqKVsffMRjfw+
         BgAk9lUHUZacRyBfE7eE/iuKs8SJB2OxOh7jo6RrtzjFbcuYRzahSP7UV7VAn2pXeAXW
         fWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771249390; x=1771854190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5o3MpI2zvqTEg6G302fPomtVC5PLXLlOoUgfy5gbT+w=;
        b=Ykb6UiiKvaaQ7+VKEApiwI91FlMcWkMqEPj7A2UfeVkMQo76ywjZRqUe4BbPDXj7fh
         sDqn4IwC+ueVGhS6/k9nYdwihaSis5HVb4NGcR7e7Y9oFexwsiRcQYkF5vUFH2s4PAma
         K2jT7KCh3dtINXhT0Jj8ugmVWxSR3O1yX1K5alFPdoaWfYkIFSYCVAA+WgkE1JPo3ijQ
         OxQS42U1xBXmQEe/EbpEQKPFrLTNXJ5w4ErETmN/ESXGdggKjDa+M8PpF6o3rqKZw5M2
         Cr9iwNThJxJUFrs4thIRPNMyXfBr1RHS3mBXeeXTmhuSiFi2AiG55HVaGElL1aQdh/Ku
         IFyA==
X-Forwarded-Encrypted: i=1; AJvYcCXD2tbgOcgllKPQ0NpHQEDCIRAGWGlBdmvIGiQCsz367TrcVznKKa4xC2I4m0LGurE3oMgwRPl508TerGn/Z2VEA0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGHQXcHP6jEOj5vXrjQ67keDSk4/lU/kLTPxVpkSQMigEck9U
	qxCcCq7fYEe4FPKZ9WncDzkm1JkFHmVCX1MAG0QBtFObVp8CQ8/0spQdce5sTp6X0to=
X-Gm-Gg: AZuq6aICBV2WiNPyDZO9OPmI6T0M+shSgRGaCDDzGYu6dhRBal152YsJSukoQyuxD62
	QXgGz2PJM5es6fbK0M4vQmGubA3apsw3JDefem4VbPWDlOgmxS3JhgqVmxqtOPkXN7Q10nThs79
	rkolaDi1qjXxTEh5+Pl41Xw7Vmhziru60YtlChTN9Dke23qhtzMuzU1lNImrazcE0ZiUNOwxaG4
	sQkra4zr2TJqrDq0Ua8AdQcS1t5l+RDEMacizTTLx91I74I/ot/QWaRzpzWMEjzkTlZIe5k+wfv
	6eWf3I5by68+k28O3h+VYVToCjBJfrK8KCMEdiFYXHICz10P8qLrQecKzoTVdMSCnSO2/ci4yfK
	dCFSTni91Ehy7h64Guq0/rhEqAkahsRkg20t/KYklJp/iIegnJ82Hu7AlFSpUuHboc78JeKmmpU
	+pLhHYNO/jq4n5mkH3Ua1YPoVIZ3ICPPsneJL6ijDc
X-Received: by 2002:a05:6000:2406:b0:425:769e:515a with SMTP id ffacd0b85a97d-4379db98589mr16674501f8f.42.1771249389801;
        Mon, 16 Feb 2026 05:43:09 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm22103738f8f.15.2026.02.16.05.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:43:09 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 1/4] tracing: Fix checking of freed trace_event_file for hist files
Date: Mon, 16 Feb 2026 14:41:57 +0100
Message-ID: <20260216134247.1311631-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216134247.1311631-1-petr.pavlu@suse.com>
References: <20260216134247.1311631-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event_hist_open() and event_hist_poll() functions currently retrieve
a trace_event_file pointer from a file struct by invoking
event_file_data(), which simply returns file->f_inode->i_private. The
functions then check if the pointer is NULL to determine whether the event
is still valid. This approach is flawed because i_private is assigned when
an eventfs inode is allocated and remains set throughout its lifetime.
Instead, the code should call event_file_file(), which checks for
EVENT_FILE_FL_FREED. Using the incorrect access function may result in the
code potentially opening a hist file for an event that is being removed or
becoming stuck while polling on this file.

A related issue is that although event_hist_poll() attempts to verify
whether an event file is being removed, this check may not occur or could
be unnecessarily delayed. This happens because hist_poll_wakeup() is
currently invoked only from event_hist_trigger() when a hist command is
triggered. If the event file is being removed, no associated hist command
will be triggered and a waiter will be woken up only after an unrelated
hist command is triggered.

Fix these issues by changing the access method to event_file_file() and
adding a call to hist_poll_wakeup() in remove_event_file_dir() after
setting the EVENT_FILE_FL_FREED flag. This ensures that a task polling on
a hist file is woken up and receives EPOLLERR.

Fixes: 1bd13edbbed6 ("tracing/hist: Add poll(POLLIN) support on hist file")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_events.h     | 5 +++++
 kernel/trace/trace_events.c      | 3 +++
 kernel/trace/trace_events_hist.c | 4 ++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3690221ba3d8..f925034e402d 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -683,6 +683,11 @@ static inline void hist_poll_wakeup(void)
 
 #define hist_poll_wait(file, wait)	\
 	poll_wait(file, &hist_poll_wq, wait)
+
+#else
+static inline void hist_poll_wakeup(void)
+{
+}
 #endif
 
 #define __TRACE_EVENT_FLAGS(name, value)				\
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 137b4d9bb116..e8ed6ba155cf 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1295,6 +1295,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
 	free_event_filter(file->filter);
 	file->flags |= EVENT_FILE_FL_FREED;
 	event_file_put(file);
+
+	/* Wake up hist poll waiters to notice the EVENT_FILE_FL_FREED flag. */
+	hist_poll_wakeup();
 }
 
 /*
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c97bb2fda5c0..744c2aa3d668 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5778,7 +5778,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 
 	guard(mutex)(&event_mutex);
 
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (!event_file)
 		return EPOLLERR;
 
@@ -5816,7 +5816,7 @@ static int event_hist_open(struct inode *inode, struct file *file)
 
 	guard(mutex)(&event_mutex);
 
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (!event_file) {
 		ret = -ENODEV;
 		goto err;
-- 
2.52.0

