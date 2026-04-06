Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5718AE2
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460531; cv=none; b=ADWWTbgDEbJD3taC5thngY+U+N2VVWuvqjuGVJD9QkbsnmLfBy2GoDkc9eNrbuMYkHuYcFopCwxxeN4rWo5J8du7NgW10am3gCMppabZQth3oKaXq5UCXUFbDEB0ov1e8KPAfmRs+fb1YCTTrcQJEEzkjsT1NQZTwcW3RP60SM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460531; c=relaxed/simple;
	bh=CCG73UkyGoTeBc2cOHNpATIFcE+3pXJSWjfoJhrSpys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViLmHgo+/AYCZS2RKW/tHA8ezptZ7pLDTDgeK0djiGgFdux6c5U1IIJUn3RygsyZbFpFbOOnfWcLMULV60iJT9ka5cG3HOr4Sn2dxORrVcitfshFhqLUer8DEDdz2IiiENCtnShd8+onW1Ene9wYf4Aiva73fC6hEASV/C1YaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhwcDzr3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhwcDzr3"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dea72099eso3864217e87.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775460528; x=1776065328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pFszUPcWhJtnEx1ReD1JGdsf3I0b4THQP105Lqalu4=;
        b=PhwcDzr3CjKoUJe6hVXT4QCcespuv1bkVp9V88+s6y7Rl8w6qX4Ig8fUsDwNcmVSio
         gxLjUDApx1hgKkBgpEicUx5EHQtzVaoMIbDOQYwUQeZJPztktw5rduGvEn/EJ9Df9v3q
         fBtoZok6dNikRKVH67t38fd6ZcDMKq74ONyPaRCsbcqy61Pb3kJen+Klo6JeAuQeJ8md
         Uy2h0UU5taUtcnZPTSXXfFEInbaWqAeyovzWqpS68JUz/sofMYvdKpEMkw6nSClZsRtq
         sbEV8MqcYteUcCgQGQL9GDitzRTS2GoKCMUIte/JTuJ9NKJ9gqHmOPJAgBdiApjto5ps
         xEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775460528; x=1776065328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pFszUPcWhJtnEx1ReD1JGdsf3I0b4THQP105Lqalu4=;
        b=o9p78oGlLl5hhWQTpWpUJyVdp6cd2mFFiXR58o5HeB2+VQHbGGU7txRi8R30FHdI0i
         uaubM8+7ozy1CLt1yibuqj+yVmJS1tHmJrjL6+ILStjpCYn67CKwVJLKh7+tgjxRj5e8
         Ewhtoo3IGkxZ7qhtVgXPoON4qzvEIz49Q04pZhRzkAYkFLi8hZ+h7PAw3pX2g+QOVdpv
         cjJs2siWaip+EqKKOnvdOAw/r43rdFcyS1CVi83AuGBFTmV4c04WFTo1fnbSPRfq0e9Q
         PRgwhwUUj4Df1/hiBN2GrNnjaLE6MkWYxk6WJDc0KBPMOGA/oDltNQB0JqTcxgKJhO2h
         8Bzw==
X-Forwarded-Encrypted: i=1; AJvYcCUMlw73z9vpQiY2775dLX69ccJf2i3xCbb4wMTlCP5yWmFUlmNYNnif6JygAeipJu86YN9g4eGUYsCHXEu6qWOzB1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAOex+26v3gP4VrHwHYhE3Jw1h3iqyKbLDn1V5SITp45wEn0Y
	4q4Dzgxuwb1NlvHzjoz1R1CgjjLo8QwGIgF6wkJ2Kof/lg9WfykUA/lT
X-Gm-Gg: AeBDieuN6LdK/ma9RVGFBV/phOfGbzRb8UYhlnlKJf+ih/k8YWfMr4e/p452ue6f/Lv
	zX8uiBwPUNegbLnJZM0nt4/FTAgDf57q5XVK6bR+JjCIN7VdSHxvvCpknqtn4wHkqaAox9eTvbw
	wPRhahqBPlyq4ECnkjuz33W1T2jbBSpcFTLfryZGK7rbxWLevUBgiyAKpZI9xzAND7FHtvfQr+O
	iJBDcHanttDfQtdXGBuWq8uY9yZbvIbJCjGSYYjxipfAhWn3B4KlQlOX3IXH+sY2bRPQLuNyYVd
	p4SUVDyUbsyDPcfc4LyeUn/SaDWyU1+bZVqEIOZ0EQbRHBIYthbIl376YyXy1Z9Mnrb1oEkf8CB
	W4FeMpPR8IF0Wr5IYlXQFgY9g06SBpB/FZVIbHZMpqzJw4xuZUqYeN4tz/BKoM+idpV2wTRpKMo
	8F6u1FjWd1xKfUJ0StpXVtI7jGT0kfeDA5A2UHUZGZyhf8nmwH/0aQwzEg3pDjaVQ3IHn9Sj8xw
	EMU941z3dQAfpKNvUcNy/CkF2IR3dO0rcQ=
X-Received: by 2002:a05:6512:3e18:b0:5a2:a70a:1774 with SMTP id 2adb3069b0e04-5a3375597efmr3223148e87.2.1775460527511;
        Mon, 06 Apr 2026 00:28:47 -0700 (PDT)
Received: from devils-machine.lan (c-92-35-120-210.bbcust.telenor.se. [92.35.120.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ca32c0sm3195425e87.36.2026.04.06.00.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 00:28:46 -0700 (PDT)
From: abhijithsriram95@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Abhijith Sriram <abhijithsriram95@gmail.com>
Subject: [PATCH v4] kernel/trace: fixed static warnings
Date: Mon,  6 Apr 2026 09:28:34 +0200
Message-ID: <20260406072834.243491-2-abhijithsriram95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhijith Sriram <abhijithsriram95@gmail.com>

The change in the function argument description
was due to the static code checker script reading
the word filter back to back

Changes in v2:
- corrected *m = file->private_data to m = file->private_data

Changes in v3:
- reverted the changes for struct seq_file *m and
  added a new empty line instead

Changes in v4:
- added a new empty line before char *buf ...
  previously this line was relocated to avoid the
  static check warning.

Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..664283bcd9ea 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *file,
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
 
-#define SHOW_AVAILABLE_TRIGGERS	(void *)(1UL)
+#define SHOW_AVAILABLE_TRIGGERS	((void *)(1UL))
 
 static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
 {
@@ -352,6 +352,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 		ret = seq_open(file, &event_triggers_seq_ops);
 		if (!ret) {
 			struct seq_file *m = file->private_data;
+
 			m->private = file;
 		}
 	}
@@ -390,6 +391,7 @@ static ssize_t event_trigger_regex_write(struct file *file,
 {
 	struct trace_event_file *event_file;
 	ssize_t ret;
+
 	char *buf __free(kfree) = NULL;
 
 	if (!cnt)
@@ -633,6 +635,7 @@ clear_event_triggers(struct trace_array *tr)
 
 	list_for_each_entry(file, &tr->events, list) {
 		struct event_trigger_data *data, *n;
+
 		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
@@ -785,7 +788,7 @@ static void unregister_trigger(char *glob,
  *   cmd               - the trigger command name
  *   glob              - the trigger command name optionally prefaced with '!'
  *   param_and_filter  - text following cmd and ':'
- *   param             - text following cmd and ':' and stripped of filter
+ *   param             - text following cmd and ':' and filter removed
  *   filter            - the optional filter text following (and including) 'if'
  *
  * To illustrate the use of these components, here are some concrete
-- 
2.43.0

