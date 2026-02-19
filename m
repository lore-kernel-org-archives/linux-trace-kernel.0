Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5834B437
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518468; cv=none; b=JdO4/Mf/Yhm0PTaRc1AMJ2vMmebPdY3uHciM+zHoUtQkUyELv/5IhZf/MUwKhoWl7nJZAoaj6UvOpF96OgJN4L/yBtCO7iTlWTP1W00NO6uQ985h9CLzkTeR0/sddcpPjbyMvw+tTQiqEk6R/42Gwsis9gT4dq/UnFMbNZ0Ne4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518468; c=relaxed/simple;
	bh=oz+04hEQM4d1rwxHpRDrO4zzKJ7Z7kOfi68mc4rkKH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o22ioHPgy5SXIPHosU2tyDtainDG6xYFPJCdp2fuAFhwUfSYjdfzTxa+Mpgp/0VF/8GWshFmFmpug7EKDwNkokwQvw+S1oxUdFtz64lVg1/B0fouLggPpQmn/FwglGMPjoep3HvbGNjzeyrDxIroWXi5qFIbKlRyCh2XdX4L80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/Jv8VL/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B/Jv8VL/"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-436356740e6so1274253f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771518464; x=1772123264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3kvNkKdoYfEDJexUIfvxiiZkFHsP2vDeB3pQYKUtGQ=;
        b=B/Jv8VL/HRvLxYIh43pm/Rt3euxp/y2j7Xatvd8U2OKcwAg9RKBasONpq+8Vc/FK6s
         ZPDCu1KAho46njkvU6zc2D6xHR5+fFhSonoeP3MmFbVd1OGKbPVQMxmgKA2oEOmu48ZH
         48VDh1nIDYW1EEcroEYtIFH38dB/SpulkLWG77+oJJw48LGy5Kl7SLtfgB0d59CnqnKR
         z/9rRwoWcsKPjs8YV7yeIFiQLuEGZtJSbrBrYeV8mWGd98Zmjzpw854mteUGchWosPz8
         2SwtYxq3Mfi7wwfpavKxXZYiiNxqim9WGOFRWlaIK1uX7+j/bRaNyFeCt0R+vLwUEUCM
         QiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518464; x=1772123264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3kvNkKdoYfEDJexUIfvxiiZkFHsP2vDeB3pQYKUtGQ=;
        b=j4I4qgsNRtYkIQVQakBvcYFYbz+99moQKjjIUr9CfZBZO62CQoAFQ6Z7qsstEe0Hdx
         9Sq8gwDjV80YwFoIFvMrp3YXYXIIpPC46xezwZ2GKHWnXX9Xunqw+APk/Jk+7C7f9u+W
         BbG0TDS+tTGRLb8QCx84LECrnpZkVh40moqHMZrYSF+aghAZ0hM8i3bkqjpuWGyQDYK/
         NgQelBb/OPlcwZiOQY3dbTxQdDDFVtoSqtl9JRuXcHWcpo3foSmnFLU4Dc5gr8P1zo1Q
         sx3VqddLDi9A+BwWAe6dmd+X4vS0GW/0AceYyOFm+qM7qQARhmLoI9ikbir6XnvMcq+1
         R4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCViTxU20Gpkal5zyS0M0LjgkPH1k1DvAl+pkvvZUbboVl76JdQr4KXKdIAkFO2Okaua5UZ9mISmfxrABx98t0LB5SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDkxmsKJ0qP8KOroffkg2OQMvv665QZV4MmF48VsVvpqYyMpM
	sOA+EIcTciz8vVP//fHn0SPx57GkCM/8xL6DtuW9+hdLdg/XlWpB4AJAk3+s9Ai6yo8=
X-Gm-Gg: AZuq6aK2e2clnfQ7yPPweMKKxV4M8wwqcqftsZwYsep5ecFPVC+HAbSXZN8ImY87CA+
	hjcaq/tQ3dgUlNHj2RjruAc+mnQeabz/kYExu0CjKKf4ynvFz9K2yw24o0BiEL6es9Beg8x5utv
	NgeUDXrzWhHdJpnW/iO6ffJXN3lKi1H4+UGmDOgYB9kU7SL98WKlbKO94CvFKHshAv+iEzlNSLF
	1tAQLR4k2DU0Md951qvg/YwgNZ+ismcjvF4ueKDf3Gqsti4+wtIajqXCQGPYl7Qkw2MkK77DUx6
	Y0vATbMsvPB40LWpsqFWIEaMjDLPrZLZ6jwDExEs8d8G/zxhdFMfn9h/gwzrvHjHRMj6lHqrcDk
	T9eBMF2XnqWXb+IWnWrXzhOtaVQ7mNq3lxI9+Ba3Hu9CCt5KqQzZY70PbgnSJri8UWjjxftOZol
	THjRP2sBqa374zFyvpMKFBk6gKWKi0gEUDsCtbKWM1LHEsMZZe/VQ=
X-Received: by 2002:a05:6000:2f87:b0:435:a136:b8a2 with SMTP id ffacd0b85a97d-4379db7017cmr35432454f8f.28.1771518464029;
        Thu, 19 Feb 2026 08:27:44 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8075sm47324631f8f.29.2026.02.19.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:27:43 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 2/5] tracing: Wake up poll waiters for hist files when removing an event
Date: Thu, 19 Feb 2026 17:27:02 +0100
Message-ID: <20260219162737.314231-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219162737.314231-1-petr.pavlu@suse.com>
References: <20260219162737.314231-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event_hist_poll() function attempts to verify whether an event file is
being removed, but this check may not occur or could be unnecessarily
delayed. This happens because hist_poll_wakeup() is currently invoked only
from event_hist_trigger() when a hist command is triggered. If the event
file is being removed, no associated hist command will be triggered and a
waiter will be woken up only after an unrelated hist command is triggered.

Fix the issue by adding a call to hist_poll_wakeup() in
remove_event_file_dir() after setting the EVENT_FILE_FL_FREED flag. This
ensures that a task polling on a hist file is woken up and receives
EPOLLERR.

Fixes: 1bd13edbbed6 ("tracing/hist: Add poll(POLLIN) support on hist file")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_events.h | 5 +++++
 kernel/trace/trace_events.c  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0a2b8229b999..37eb2f0f3dd8 100644
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
index 61fe01dce7a6..b659653dc03a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1311,6 +1311,9 @@ static void remove_event_file_dir(struct trace_event_file *file)
 	free_event_filter(file->filter);
 	file->flags |= EVENT_FILE_FL_FREED;
 	event_file_put(file);
+
+	/* Wake up hist poll waiters to notice the EVENT_FILE_FL_FREED flag. */
+	hist_poll_wakeup();
 }
 
 /*
-- 
2.53.0

