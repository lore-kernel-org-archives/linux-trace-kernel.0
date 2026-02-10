Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DE31A56C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723292; cv=none; b=d1t43eCtbahjkpAkvu4DX9jTWoQgB7eCvcclbN1N93f70LtxPBgwEP1wnuPvqjf4NpFHdu6zv+YUIpAPykJi4/nxV0GorkBWYjzU+/60IJOavz6biBG4PvxrEghmheMm45fqBxoEMCG6X2HQKfxvM9iruf6hrooUCAi/j8AhGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723292; c=relaxed/simple;
	bh=/wNrpal0qtMMUTMGWc1/B9FLAgALtewvvMh2uxWSIxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgmneNpC0gcqCtwqICHrr4nB1t+3bpyb6AZUBxIiQoiGQzNVVzfHjUceLnkwmIIspYgxYMdQfgXI9VuOuARUEoIDMH9jwfUkKzYF/KG+Cks+RB632ARU1+XrqjJ1pS5HOBb98qP9S68eei3CAIDSU7/WXc0csa/Rq+/hkazvvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R4Lqt7eS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R4Lqt7eS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso46310065e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770723289; x=1771328089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czouTc/9gRTT7IgUdEbhXZCgCHvwee4zpUuFlhXPjB8=;
        b=R4Lqt7eSipGesNFPHaPM/9tJOtAV5DnBNR+nLFvhtQrMXhJhBimuRVwAduAsZOIKz4
         qEWeHfd393j+QKqQbdu6v80z4fceOFCNEEXjhSFEsGFyDFow+uTDm+kEqdheakpmY+1G
         rDMdEsis3VE7jb71F+gmXmaD8gLcddQu0iXLSS0eE/xb8+5vXrxfAOzWaefVdbgWL9VJ
         /lch/kSD4D9IQwrAfgm6pnd1zBheNeeYzRgILQuUD+/GJq2ET/T6VFmwIn1IG/eLiM4n
         w7ivsYDx6T2MgYPaVEwV0drgNN7eTuh0rDi1f85ITDRBHE6HO1xWjnOUb6dx46020QZa
         FIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770723289; x=1771328089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czouTc/9gRTT7IgUdEbhXZCgCHvwee4zpUuFlhXPjB8=;
        b=NkLXkUfAEBuj9uqEx6GgVumc+oXCj8h4zJNhhWOkotzfIQJXMYVqcl78y6Ylpk8DLX
         C3GNoPcMbWGi3ab+w+cMKYHi40JzbDwn7u89ho9TbIPzSKcBwxMIwNSVTI9McA07EZto
         D8GjvoXFjYybI/U/6GcJvfOkjjynCp0gwfRAjGZayhFC7lr8LgSwGYMwWTw8lAwHf/dN
         hRQFwGQT1gceFuB/MdpYpcPbxOtnCUeiRyOhbO7TzZG9VFXQj3d8jBSG83V9Rbm0imtJ
         KH48rdD6hvrcFHpe+oEbydE529GxgIT0IZDaC0+6wfhHmiRNPYlMDQg+pv+vbllCngHC
         oHqg==
X-Forwarded-Encrypted: i=1; AJvYcCXxWNySHdFGFdee03TA4uK2yDlESe1l33zwxsmJzCpnEp4YdJuIlvPS1c1jXwqvlcNmfqB3hT28cOknIe+eki0/SYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBD0oVfwIX66tJJ1g6qcFzMrGUmBwpMoaE1CnWjZVLSECbtpxz
	7bcmumA/1EMZztKiEBPcHOhDfF142zoMq1KJGUGaMUbhqsR8LdHxIjTP3VXz2D4a6Co=
X-Gm-Gg: AZuq6aJC/kptfZ/vZtijeeXA4zqgl9lPWqCM9E3EwK8tPuHHedDRclqTt2C7YimJ1bu
	ulrpygAjQyVtPIUh+ADSBDDiqXnn7IZC5tyW/OrtBvQwNQ0dOnxT94qLtAhNVhMmNivTGvlRIRB
	wCCa5dFQxB7isc8wTm/XzvCebQ2Ti5HWO0Ks2hYeyK3Vqix0snt/V3Rg+JUOMdked0Z3J57326b
	35ZcijiQj7ElAZ+vzIxgGdB7xJv8pL0x7UxHbpQK2hBBxjKX5cmvM08ihRJCgUqmgdkDzW0u9qe
	s1Y1fJcHyKVNHJNZRNdamIi5cE6K+bID73o9NLU7cFggwUluPK919MLlILbtkjEz1X4m/LtCLtH
	maHtW3Bq8FYCNAXRHmKIoqBkg+o490Ykd/trlQY1eEGa+4OfqEMxnN9XH8yR06P4779ewCQscjy
	/0OEOm6FTqCmusKW+u3tYJAE1lnrlsYOAvN/qqdB1XyhctVZfzYp3EbvSsFSOZtYw9DiHvuG/DC
	HqZ/PzaNnYQoE7YJeySPuTP
X-Received: by 2002:a05:600c:444f:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-48320181c15mr203558835e9.0.1770723288713;
        Tue, 10 Feb 2026 03:34:48 -0800 (PST)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm120182275e9.14.2026.02.10.03.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:34:48 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/5] tracing: Fix checking of freed trace_event_file for hist files
Date: Tue, 10 Feb 2026 12:28:16 +0100
Message-ID: <20260210113427.1068932-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210113427.1068932-1-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
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
---
 kernel/trace/trace_events.c      | 3 +++
 kernel/trace/trace_events_hist.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

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

