Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBC367F5A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200290; cv=none; b=Jtlmype/ybzzQTILLg5CzfOK/FLxS0geypUVFnXZJA5vr1SOS6Yd7XUqDl+5/ZbjhtoOu8rkuRn6r4hmBCFxR2ILtgZEmwvdSaevIvGZayWzRSGQMq/KITExSyA1dBCh3u5c1e2bOaaUhds4dtk8tkO8dQay8mY55pNUOW82uHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200290; c=relaxed/simple;
	bh=yNtJZs5d5ePFMAFZv0waPvs2Bazyv0Ry79rSa3Ozk70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qu3vCODkqK/04coZ/+eYz42riKcsQNva0MxVe5stG749vSSyZPSMsSjRviz8hZ+VDWE/nXEaUcwX6kHkFPQ59kBjfU8V8wlhQpjBzfdUu6JGulEc7fuyTHD1WxF92jx8bVqm3yPv2yS66FEbC3CTdXxOxAd4hFpN/V5m2Nh/k9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqV7VZzQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqV7VZzQ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so2048590e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775200287; x=1775805087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZWy68d3AGOGRAjP4M7lEnpsXP95G0ngPOaIoBrW2Sw=;
        b=eqV7VZzQAhuw/jBak2lfHjsJ/L9rCaxfPsOOGzE1ozl+tSOdyTlHFiv/54Q3FHN/fy
         ZtoVonR2FcSrfWSs6oYNkEkBR3PjhKLDNl9b+VIoiYLXjZG+Qta8/ZEEFyCV9IPXwozW
         nN55vtGWa+mlWSqyMMgP4tZt3353m9/1fRqOGnayGukcFRBjze/IAWHlDUiOkFIIKIfP
         KLa4jfEbYHiL3PNtb5xIHt5GQ9dNEYfvQWSR0KEON3yROpFgaS99CoQWAcpzz3Flbmy3
         30shZ8j/RGBfzNfAwMfxQSOwgbkxvLuY7t1UNA8C9+M45WwJRz/eHgDfaEfCIvU8NWi3
         njYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200287; x=1775805087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZWy68d3AGOGRAjP4M7lEnpsXP95G0ngPOaIoBrW2Sw=;
        b=LkGwuFjKqxa6YlK4XvOD3Kc8MY31GeYwhrojfo1Xpao2dz44ni5b5Alp695RNMrlUO
         bYnXvRefJ28d4JNwloyG4zaO1MoJfT9EJlN0YiYD7WBs3lZ3QhH4nZcIJtxVc/PLp6EA
         6taZ9cDLsfCioBfdRpmJyrdwl72yvi3XI3TnAgIQAoKhz4uAhF9yc2ZPwh34ciAaGXh1
         vtANdxZyB1SElQh0pTOdVZCWwV26Yl1DsQix2LTdV1dIGJlAnKL4Vgr63ocXF38wipTR
         PeUT0VdCxw/dEjJTvcahJdoSGAt9N8EaQutigNyKARC8ZKH0+89H/v/P3S/Mhwq57u3F
         3eRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4xz3qAcdOvYzeH+uQkJQCS2O51vR/00zQUI/ldzmJ08Owg7pfTpl2e41MH6Gazwlf0CWJZ495oMfrewXbkrZEy9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQAEjJ0raQA0AZLfmhxbvBAYbEKteY6WYIoj1xgqqmSWJK7CR
	95I0yc1oNMFzqJZYaXkDgW33jrzJY7cEXbT0jNJnuvgKxr2dI9TBCXJA
X-Gm-Gg: AeBDievqD4Jkra5OTDdvdBNRZGeOFBUw0O0km5Uv+ZG5fJ/LMG+1W/csZZ4gqrmQ9Jw
	TGOpLDbk58clK6CVUulEtx1qyCkpMvEwTdeitmpKW+mc83JzMN79cxu8voml9mnfnuJSlcfxTMI
	8anYeWIVIugdY6CGakLwjWOyBlsYE/aTUbWSkJODIz5sSR/bVov0nIsitq81QtRrmCgze6k+PMm
	TEnoiU0vn+ZPEssx0S3apAaCTGKG8saaC5S9Mb7p6m3n8iJiynUyjb554GDOUr617O+6KqiFZr8
	zkhvMU0hBS3r+tnzb+JbJ28Aa+vApBl8bSaCKqbFFZldMeRCHZLVvtImpkER+qx+suJk8Dhmg2y
	1FkZxoqjR29bEdKhG33WZU6TADm8zRNu+zOTwJzqc6OWysoJPD1GYhF9KWHsuMt/XB6cALvUkpp
	L6FiVhW3E4jvYjlQKTeVqMnthn+W9c1i6uj7Ax5296mfIrjs25PTdUIFuN/JIH9HCcmZwgav8ab
	qUdiZ9FIrZ+9ZkKDT6V4NOr9VIw5Uopg5L/4sknWhlsWQ==
X-Received: by 2002:a05:6512:ba7:b0:5a2:bc66:b4a1 with SMTP id 2adb3069b0e04-5a33755ccbcmr636368e87.5.1775200286843;
        Fri, 03 Apr 2026 00:11:26 -0700 (PDT)
Received: from devils-machine.lan (c-92-35-120-210.bbcust.telenor.se. [92.35.120.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c9810044sm948695e87.26.2026.04.03.00.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:11:26 -0700 (PDT)
From: abhijithsriram95@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Abhijith Sriram <abhijithsriram95@gmail.com>
Subject: [PATCH v2] kernel/trace: fixed static warnings
Date: Fri,  3 Apr 2026 09:11:08 +0200
Message-ID: <20260403071108.23422-2-abhijithsriram95@gmail.com>
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

Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..e632a8b77153 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *file,
 }
 EXPORT_SYMBOL_GPL(event_triggers_post_call);
 
-#define SHOW_AVAILABLE_TRIGGERS	(void *)(1UL)
+#define SHOW_AVAILABLE_TRIGGERS	((void *)(1UL))
 
 static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
 {
@@ -325,6 +325,7 @@ static const struct seq_operations event_triggers_seq_ops = {
 static int event_trigger_regex_open(struct inode *inode, struct file *file)
 {
 	int ret;
+	struct seq_file *m = NULL;
 
 	ret = security_locked_down(LOCKDOWN_TRACEFS);
 	if (ret)
@@ -351,7 +352,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 	if (file->f_mode & FMODE_READ) {
 		ret = seq_open(file, &event_triggers_seq_ops);
 		if (!ret) {
-			struct seq_file *m = file->private_data;
+			m = file->private_data;
 			m->private = file;
 		}
 	}
@@ -388,9 +389,9 @@ static ssize_t event_trigger_regex_write(struct file *file,
 					 const char __user *ubuf,
 					 size_t cnt, loff_t *ppos)
 {
+	char *buf __free(kfree) = NULL;
 	struct trace_event_file *event_file;
 	ssize_t ret;
-	char *buf __free(kfree) = NULL;
 
 	if (!cnt)
 		return 0;
@@ -633,6 +634,7 @@ clear_event_triggers(struct trace_array *tr)
 
 	list_for_each_entry(file, &tr->events, list) {
 		struct event_trigger_data *data, *n;
+
 		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
@@ -785,7 +787,7 @@ static void unregister_trigger(char *glob,
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

