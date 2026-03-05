Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB813D891
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739226; cv=none; b=DdE+KLcBwYdhCaZZT2LPI3aBPB0IEuVfh/+f6tlnta1fcrWpwr4lqHhZ0epRXl0HQoSAfVSNkB+SIY69hE9ZolVV40n6lmz97fA/UNzzoi3t8lYWGy67GN68TZ7SwPG6NIPSvfeE8/otv+GbDPM50/XamHABF8vlWG6HJK+Ch5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739226; c=relaxed/simple;
	bh=hrLaGjKTbbL02GgZ6CDoFO4WKeKUJ837QtSBGwMR62o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXivjtNXCwUWUKCkonMR0KV+/9ccadiv5+Y+ZUpeX19LkmRTkINv7blG0u7u77UkaAJ3QasA5WTyRSMMRBWKPl8N4WX6o7cBFUkNQZhFks7fOjf5NYQa4N8S9O9C9IKaovIV6IBU3b2m/OYHR/KH/7UINpJ558kKB+TCKG4WMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4BHFmcX; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4BHFmcX"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so635534eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772739223; x=1773344023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fq7KIO0V4zx1zhH5qW6s86NIhGqp/50i/2Zf3Crez5U=;
        b=U4BHFmcXF9nwSL3/FVFI2Fj4+If/2THqyQ+fgrp20oSZYqO9a9CI1zojJ/mLBkr46u
         KrERh0KLCnj3/dAxPZ90BVMmnxayaT6QGFTbJ4XDyumohRFZz66/iY0Jc8NhpRatJV43
         fZqfAhKvfArDdDsXHOFxBsvMndTUq85lrTkztxVk2QFzx3DRMzJ0ikuB/PfbfrtsZbdq
         SlYioXhm4SvtfLvbGjwO9bycSbd/vYkcR7DyTxCwWdkFZQnUczfdhyIsm/ZvXZu3xaAJ
         mCtuty29bZQoFMBezL+W/4sxdFkzfYHR5cAPowdZQzBpPcdnH3IesV2W8HaiBGPhyIQC
         XHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739223; x=1773344023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq7KIO0V4zx1zhH5qW6s86NIhGqp/50i/2Zf3Crez5U=;
        b=aV7JTSD2tVQrMApwdJA1eLzo2IdGp8EAuErD7PyfohfinyPZaYCEfS0BUvWDp6dNcx
         XpC8y59Z19vBZoVTuygc2oXn1i69DGpTQKSViYkXgmP+OPlEtEb/KrAGpR/TiHl9q2At
         iai8M+pP1hcZoJz7ehxC1Nn6kSP0CcV/5KHk7ugLmx+aKvRVShdROxi9VARJBItVgOjU
         1fkBuIC4AnbRGkRSNqcgB6cFqJQq1JjKS8YUmJS5WEEu4ZmYZRN19/z+iLE4e+GyNyPn
         SxY18ndd6scwRCIN9veAdlt1SJ4fvbSBgf+TnWtHUFDAzBgr1sALkEIxHEoZRQm+Fi+U
         070g==
X-Forwarded-Encrypted: i=1; AJvYcCXE+gOskhzM367P+cWDeVeAXniH02h9PFRAoCmN80BJ76hoav3V5XAVQ7dOLAbCzpQGEgeiAAjVIwtU9JvrTFbHNQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOb7IFF/nRer/GokEHerPkqt5LCg9GsebNxawEzOVtKMq8s7VN
	UT2hSoBqhVbEyEAJiimMXonwEtaKVCtL2H1mDm/kvcRwmVYc3tXMrESh
X-Gm-Gg: ATEYQzxcU48Kz2SMZLsUWBVnwsa1N2E+6ScY/8+aBIJnU+5LDUIW4MJ3DCrRepz7HZ8
	lz3BkKwt6dDIgyHoR1JWCRRdgw6RjbD1I3vhY8jbo9PxP0ivdf42qY8HODffg8PwRkAZN60RfuO
	Ny36uxLyhtu4Box6OJ9yXz0Z/qPtjnT9KV28SmBmeJQWHwLJSuyv/tItE5NaVK0AV5nE7gQWLQY
	hdBHAOR88qhhUBdjIUheF7qeefveLS2Lv0Kv5In8y2tSjf2QggwAF9OAmp+xlPLACMDymCgMb49
	UurqX9LMkW96asfDEBXBELQntDdR4ZwboVOHo6PhaZ2AbtN95B5nq6zSMmFe2xxOPYAFQSdneGp
	BjxLevGYjcu73haDEMmrxe0pjlBhdZdU4APY2uZfHlnmgH2cYcHr/3vwSsFTWVa+D04YLpHziq+
	tiZEig06dfNUqhHWnUv8cmtVKW9WKktofkDRVX
X-Received: by 2002:a05:7300:6d07:b0:2ba:a098:ae64 with SMTP id 5a478bee46e88-2be4abadc62mr427346eec.34.1772739222765;
        Thu, 05 Mar 2026 11:33:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be09bc9ec4sm11081299eec.24.2026.03.05.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:33:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH v2] tracing: Add NULL pointer check to trigger_data_free()
Date: Thu,  5 Mar 2026 11:33:39 -0800
Message-ID: <20260305193339.2810953-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If trigger_data_alloc() fails and returns NULL, event_hist_trigger_parse()
jumps to the out_free error path. While kfree() safely handles a NULL
pointer, trigger_data_free() does not. This causes a NULL pointer
dereference in trigger_data_free() when evaluating
data->cmd_ops->set_filter.

Fix the problem by adding a NULL pointer check to trigger_data_free().

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Assisted-by: Gemini:gemini-3.1-pro
Cc: Miaoqian Lin <linmq006@gmail.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Fixes: 0550069cc25f ("tracing: Properly process error handling in event_hist_trigger_parse()")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add NULL pointer check to trigger_data_free() to make it more robust
    instead of changing the calling code.
    Note: Changed patch description to reflect new functionality.

 kernel/trace/trace_events_trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index fecbd679d432..d5230b759a2d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -50,6 +50,9 @@ static int trigger_kthread_fn(void *ignore)
 
 void trigger_data_free(struct event_trigger_data *data)
 {
+	if (!data)
+		return;
+
 	if (data->cmd_ops->set_filter)
 		data->cmd_ops->set_filter(NULL, data, NULL);
 
-- 
2.45.2

