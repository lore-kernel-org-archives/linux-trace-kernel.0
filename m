Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5A3A4F5B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728599; cv=none; b=KAgcExtLrpD09fGMjVsx1U9cl2uvmf5wokAKSEXSZw2UjUszhMrnDSirOmr1fYhPF2CPEaTb1+LH/eEMG8VesExm9pbuy0lMxPZQPW/a91j2Fba4IAC3It5pIpAXws13E5KGgFg8qnpQZTmf2eBc+bW88q6a/M0wcCJTvFzdd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728599; c=relaxed/simple;
	bh=v118AX4HgprhO+qT/qoHmaGVhCeIdzF+22JtJi09CxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdxY76rogw6082fuuHXfV8mudwHzjj6OBb5FeXUnylDoU2rYdJXiciYmEotgU1ldNlbtVIeHOk+2yIQrLl5sD7PVxbqQcny3gGYp4yudJaD5iGqyFFeyb8fy4VWNODOb5O91Dv2cKp7ldKEFDS+8qYukL+U7rD3EjX/AWPnyaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE183bDJ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE183bDJ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be27fa54feso4088124eec.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772728597; x=1773333397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+qaTlCrAMtHhaECSWz0WgyhgJNAs6je+1lHpGDkkHuY=;
        b=OE183bDJZ20bDKLvukZRLSuc/xq2ORZxvjYBP5d/k9IkXLxd/Tcb1l5v6LbVjODR4O
         yp+nxEwgxdIrfZHWz4+D8i12xVnD6yzMQOAmfB8bsWanp8i/V8ISGguCaQZgKLQreWLO
         b1TxantayTSdjwehSTfTk2mggYiq0Fy7Z+Cd7ivJN1EdHXoDpkeR0tIX9pU8VTgLBqAa
         q5LLcLvYR0TX0EOxR7RM79pDKEwQGSRWn6GWjSoeNt0kubrSCUiI0X3nFWqjpmSXJZ+x
         1nQ8GY66R/S4P17yj7O50I4KKHbbqEDwamFvl6XawOuJQQapU2RZYY1w5YR1IUtCfHm1
         w0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772728597; x=1773333397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qaTlCrAMtHhaECSWz0WgyhgJNAs6je+1lHpGDkkHuY=;
        b=gmPmGsveM3Pp1K84gHRLrutH7+RivVkU800jM6OQn+A1KhkbUF5a0NMi0E/wkO9AAH
         bbpviHP3YLQOhjENSw/TKrCt4s6U6GvMv2TIJ9cAFNbOfxRn40hkFlCnQfB90k2MaRUS
         WX5+NjJRHGP1SZHgJviYLWaDBLhHMTIsqJAizZYd2ufEt5u1e9t7nTBEx+cf/74C2woQ
         RWcxFX3FtkdDiuLX/x1f6RxVvKDzuZBEbEfvadSNZuwIhU92HjB3LENpD86KMVqXuAfI
         Nu0BkKAqCB3v/dVG+ryp28Y8qJvKK3bCSXCA4DAlXzfixHdFnagjEQj6CpYN+h8uC6o1
         b5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeyHEfbaTQJQtINgbASOdy6FAELVVbVtnaxpp8BT4Kp2ETu0KNw2yVXqj5YiV89xnddrccvLmaOzVqyjrk1R9N+Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lPPWVYK0dyfUEnePxHQiRGv4TD5eAUk3AwKGZWaJ7s5LBZ0F
	GYCFPGnkvASvYYE2YMtW1hqa1gdsAoWrPsljkYCQq8seB4qGvN2X2l66
X-Gm-Gg: ATEYQzxSqIv+EVEQBfVmFwn358M1ggDA2PX/ZcK9i1XcyNe7GtwD8N6q4iGntj8kp6/
	1Oh4+oT7Dj0TjEsRulo3J3PpkqXl1kp8vu7ZmDTjAuLCEf9lNczMnPaxeumywlKczJE9afkRWZe
	UHLMoSwFMboI83OHXZZK7pptOSgus8CU8mM5UoC14xzAOdNFFKdB8W+uJJoCJN6M9WtKfSNHCqc
	S4KpAcU4n9cvq3QQ9qu6WxtW0KZBKf7k8hgBgal3kYnhd3yJbddkIACVjT8A+VE0iIuxVGcHBl6
	TVnBIp4/0tTtdYTIC2MpYrum+OGFFQZLPlEQ4sk2pb5xHQzVxjr7eNPA/xCHUnUmovwWXsYdQoa
	AE4FPutuxoQC9aNL+QYFtcHkS1D2A80Vfe0WOI7U0sEVAfKIKxXaHiUj6gGTlKGEPWyE1WtAYCx
	NRpLRvOn3Xdg9fpdhTZN/mKzYWy6DK/YdxF56S
X-Received: by 2002:a05:7300:4307:b0:2ba:6fbb:5e7f with SMTP id 5a478bee46e88-2be311d3f6fmr2401154eec.35.1772728596864;
        Thu, 05 Mar 2026 08:36:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be220eb5e5sm5640736eec.17.2026.03.05.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:36:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH] tracing: Do not call trigger_data_free with NULL data pointer
Date: Thu,  5 Mar 2026 08:36:33 -0800
Message-ID: <20260305163633.2782210-1-linux@roeck-us.net>
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

Fix the problem by adding a new goto label and jumping to it if
trigger_data_alloc() returns NULL.

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Assisted-by: Gemini:gemini-3.1-pro
Cc: Miaoqian Lin <linmq006@gmail.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Fixes: 0550069cc25f ("tracing: Properly process error handling in event_hist_trigger_parse()")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..a2abdfe19281 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6874,7 +6874,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, hist_data);
 	if (!trigger_data) {
 		ret = -ENOMEM;
-		goto out_free;
+		goto out_destroy;
 	}
 
 	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
@@ -6942,7 +6942,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	remove_hist_vars(hist_data);
 
 	trigger_data_free(trigger_data);
-
+out_destroy:
 	destroy_hist_data(hist_data);
 	goto out;
 }
-- 
2.45.2

