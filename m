Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EF31F982
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775455276; cv=none; b=Zjux/NBeiKV6SXmRGLkHfGuCBU8XUHZPO58knORNBPJPDfrqpucGYdocU7GHvGSYfvqtyXAF/eeAxf0MrY7E1mfmhgvaRCp4KXCVFtSblwLifB4iLoG5fonsBVeRBWvDmZrfc06WkQCwz+MU+/QJgGFk2jVNM3Gg4kuv0IMstYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775455276; c=relaxed/simple;
	bh=Yz0OPnlzwfdFpjq91e5ZYdj6trL3rvnDgUqz/YMOAss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uoSiIG2PFUsqcW6py7uLcUEw102cV/cfeH0wf6yNsehkyXGYBYWO3uuRBt4V4VIPROFL2lIvkt9lkhM/HPxCKYG/zy5a7WwxoCuwSDfqbT7c2SzifkTV5alwfBRjGKLgCzy0lC5m572y1L6GjPoGJnAoLScuq6qbdP4fTpnKL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBuug9Cr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBuug9Cr"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2a70bb69eso3788943e87.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Apr 2026 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775455273; x=1776060073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xH7p2WB5wuREQelB1P9myYtO3qB4RvlouVRc2UtlXeY=;
        b=JBuug9Cri15REf0MgqwMAYpJPUGx4Z0KriVHiYjUJGwe6/ZbprKISrQSgkTrewwadP
         Qdi9YeqZZOZq57fB5VFsBdbOj3k3tU8vzCMSErH9jMlX94oehjoeYZIxMnrCzH2vN2Rm
         QgiCiBuQOySzcPHGSV506D1VrYHpVayjqAefOWrorBckTg1KGa5NaLop1eeHWgwerf+W
         Ae3FhKGdpnj3vVBuEmhZRnpuDqQF/Srj8V6ZyTWDVtuJaUCYQiha/oCEe424TTtE/1SW
         iLly5s6e3xt7TZHTX0r79f6MVieTLOJTh+eb7Q/wEIaDINd6HGJCLJvhZqTyR68fg/5u
         uDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775455273; x=1776060073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xH7p2WB5wuREQelB1P9myYtO3qB4RvlouVRc2UtlXeY=;
        b=HoGe3mVUiai3A3TYBrwes5RYZJA06T1AaB1coq0zwLR5duSbj2Sku9MYUvgkZNtO9d
         VbJlh77ytiHwyTCoHGVH/c9TMCHAzqPA0JnDrON/EK/8w3auZ2VtWwcQK9IyZR69LdcA
         8lkoSwKG247Ba0baQZNL1Nip24fJwqrtqnE8a6w5drVnAm9smdiJ2xGRQe0Vl9H4of4l
         Hc2KGBAUOOfYzjKedcFkpJpGZ0DkCeu1+NFmRRdA0Xo93A89naq1XCVDwZ1NWSb0kAsv
         IOVQ7XAzCGACLDxC31CT3gGnYZQNoepBKrMN11vhvD1ArvK1OAKz8fvsfwZiuwQABwvx
         EWeA==
X-Forwarded-Encrypted: i=1; AJvYcCW2m48f+TjJFfUBFx3RP6HkI0MLeyInxT4pmBXcDMlWudDa60OSyl8azQq6afg1VdOeI8a07bLkoOdPcY3KTHdoHoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJToqgYz4kj/Et8iB3bnF1sXZ4t3zQEVP+EFltQq68NdLlwkKq
	2yZgaUG04FewQjWKiEqHDOeoYh1HhwqE0OzWXUI7fU93jK/inVD1QaA774W7ZymM
X-Gm-Gg: AeBDievDGTk+jfiOCLNykH4nhlS9QO/Hc561XEDR89HzQuq+uhpB9XmZ+2oQ2JD04rA
	DgaPMG51xnLAY86y5g9XExGRRf4D3Me+EpCG/3VSOstahfJt0cYHlQacCqwqZ5R+HWhmuqzzfBK
	18W0BccZUro2+Ic9Fsy2o612jl9wp1DcREd2srLl5pn+sHLmpz/ZXGv/49LcmuA2jtBXkmnnv2N
	A32CBf6uOMtejGto/zZGLWB1cKpOmY9jfvtl92UdeEhpZuahas6WQHDmu1xOBe9RG3o8o531OLm
	bVeZsZp+m2en5fFXxiYOEDcpcv54OilDwcY+giBzY7jPCAzTphGiizhGF++polqsg8UxRNMbqfA
	C8X+FJeUi3NyYvJYT/5DhWLaU7TOLB/dS8q1ISIs2xUsZ0YJtvouoe2PDSzLpuGvTdIbBQMb8Nj
	o0FscEVK0iAlU7wV0J0djv50sVqbos3bS6+cLtev1zXssQDXkrt7kyH2XyqIsUIyXuM81I18Pky
	7jfQHnsfOPX864j4rlSZqxA3xZoy2yUX84=
X-Received: by 2002:a05:6512:3a84:b0:5a2:b884:153f with SMTP id 2adb3069b0e04-5a337552827mr2534651e87.1.1775455272589;
        Sun, 05 Apr 2026 23:01:12 -0700 (PDT)
Received: from devils-machine.lan (c-92-35-120-210.bbcust.telenor.se. [92.35.120.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ca32ccsm3174377e87.37.2026.04.05.23.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 23:01:11 -0700 (PDT)
From: abhijithsriram95@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Abhijith Sriram <abhijithsriram95@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v3] kernel/trace: fixed static warnings
Date: Mon,  6 Apr 2026 08:00:36 +0200
Message-ID: <20260406060046.223496-2-abhijithsriram95@gmail.com>
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

Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 8 +++++---
 new-changes                         | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)
 create mode 100644 new-changes

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..08adb593fcd9 100644
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
diff --git a/new-changes b/new-changes
new file mode 100644
index 000000000000..9e3a24de3033
--- /dev/null
+++ b/new-changes
@@ -0,0 +1,6 @@
+Line 25 -> adding const to the pointer address as well.
+
+linw 1193 -> removing else because there is a return statement in the if condition
+line 1727 -> adding new line after statement
+line 1800 -> reordering to solve missing a blank line warning
+line 12364 -> changed the function to kstrtoul
\ No newline at end of file
-- 
2.43.0

