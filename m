Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6E3164AA
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159713; cv=none; b=V3DWiv3N/NNOEtAVdh1CpGxPxk2aTVjyoTEFCcQDKvtLqofBzYLAQSG5Xy6fkY0ylbYdJiX18a/1nX5RUhk/9Dr8KVp4bXhPLT0f6hpjERfpbpATZEsPo8jK/qOqaZDR9HbaQNLXo75UKSq9WxIilaBuv9aAwOuGhe0lkvasjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159713; c=relaxed/simple;
	bh=0XNehKbvHBesmbu4vhB32dtdOb9MkPs8Jn0F4Yy9KGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPIViwxz/u+Bt99ZVIDm/TEPik1TqLyRS3k/oTEl2VmSgfkaqTlAmsT1OJQ6kQFE4wmme1UDpKI+wgsvwfh+BaoZam/h95wj4g57IBWPvy8MfV7BXonkDtsNiybbbAz+EO6Xwd2h1HGaALRF+A00Naq8zxx0mGy6V2wjkB5KZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFqjtLLZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFqjtLLZ"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38704f70ea3so11572421fa.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775159709; x=1775764509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTgIjstfkWge23q+AqME5QaRZ90kv3vl1gpGFjgakGc=;
        b=GFqjtLLZDpavhqz/BlVhmnAVaKpbCMW0DC8ijcb4wZ+1ts+KqTG70eaIphfnvJkQE5
         VvZKbPAnN1qC+KhJEbxwVXBbmidLVBvGiyKxemJb7FmL5MXt/u4dxYsOyWeki8Q46ldw
         OHftE4xfdRoS2xERcEPKuGWT3LyA2K2eCsScF6JeoZ1xR5P5bhOcApIbopXIg4WOr5NB
         BvGt4OeQdJ8HjBItAs6PowgYwR7f7QZakhiTPcfXjzeOZPN4SCjfXUIzS9V3xs0v5T2c
         32qkKXAZMfkWQCnlU3Qr0zzapQYG8gq1HAYxgNxjUPwSiD10hTO9LBPjhbbSSk28mzi7
         m6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159709; x=1775764509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTgIjstfkWge23q+AqME5QaRZ90kv3vl1gpGFjgakGc=;
        b=fV31oF71Stx00RFXEUkmmJxSfFIvPaxaOAObJQuv7AsEdhlsDj7TUCyraJ7opbKy3U
         so/VDDlMk9N0AFyFhE9wmasmfy5+6GNrNdPs2M7Kf5NVy7EwcmEPPZv5xI+p869+ADCD
         U+Ea/mPCckub4qZjzSWJ0dLoPdKV4s65swYXF6LISrfWmQwvYQ6KutrIHPfWn2lMf8yr
         h0fj8b4pLrRx+tU3WxnBce6M3vzl6F7IvGOONxDKNP9ImCpWKO5DwFiMRUuFb682np2o
         blt7Nskc2WJ4dFHhxzaFoW3B19b8BmYUxCRNzDlC2skrFxXccfujErReliN+D+Bk1A0S
         yYXw==
X-Forwarded-Encrypted: i=1; AJvYcCWgZzmQZNUN1MU1AdSKKmY9wxSBjB1RFdFQkYPy2hQVg/IN/iPa4gTB6EwHyTeo21zRNjMKNL65AcAFRjPcId4hR4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67rWeKuoTVPcHT1RDybz0uIrLHKz060An2Q+gazLjK298IcKR
	LUn7puNOPeeUKfIwF+tDGlf9MlbxfCFg/xf8affgbDjvn3tFXC2mn8sX
X-Gm-Gg: AeBDiesOrpgxY824QR85RUnfWbaYO4Q8gH+Ojz/EZBJVSM7qSIMUYWmzM/lnMoruSmS
	FQJEo7xhQvj9K39wsV4pXIW/4KZxi8omvVzmzCYYonwhD8C+CmLR5UwW/J5IV+Z5k+3TsjGMurg
	LfG9fJ4ih9pJIrY+gafb+EeffOs5Mybt9F/9O5b42vfxXiGmKXLNgrkSH1YG8K7NEGjfWGg67yl
	9qUd2bXSbNwQm3vc1QLAM2xF9utE9H4Cd+K7XD8qG71fYsc4lfLuoT2eTzqH+PK+39eaJNx9ku8
	KkJLfykdBMQ/gTYq5HkwvInhhh8SVVKhjUg5I0jpsMHRWPhKis8PQD5Y4UyMnHN4k9L2EnrHb+B
	l3Uy7X0R6B8RR25oha9ScCq/17uEG/ZcTGsF3D0ufwoV+eXYk2TqdT/Vf1V7id6faSOcqTYO0qo
	LyCKmNpc9u7jliTvxpORcFISxpF4JMxwuC8ADVQrkfYYIlIMyFoUDhG7R380obX89chVNM/V8LJ
	VJJmNTJlzuXj4Q7DYcufwMjYhWHG9TYluPaC9pMsyNn2w==
X-Received: by 2002:a2e:bd04:0:b0:38c:65a8:a5bd with SMTP id 38308e7fff4ca-38d91c2df0fmr495601fa.22.1775159708846;
        Thu, 02 Apr 2026 12:55:08 -0700 (PDT)
Received: from devils-machine.lan (c-92-35-120-210.bbcust.telenor.se. [92.35.120.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd1fdff47sm8129571fa.13.2026.04.02.12.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:55:07 -0700 (PDT)
From: abhijithsriram95@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Abhijith Sriram <abhijithsriram95@gmail.com>
Subject: [PATCH] kernel/trace: fixed static warnings
Date: Thu,  2 Apr 2026 21:54:04 +0200
Message-ID: <20260402195405.21316-1-abhijithsriram95@gmail.com>
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

Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..477d8dee3362 100644
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
+			*m = file->private_data;
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

