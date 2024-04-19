Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008112F368
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537541; cv=none; b=QfRrMqyom+akvIEyprVwQZe3LBBN8oyeUzCG4ujGmb1zsJpUkhY1tiW1AsQJJNrkIUOIcz/JfMN/SsNVzQUy/pkpWD9CFC+rzkj/iX/iqXTKhDzUM4LP0YhdSxJFWWkhfxtm2DHkFjT0bXBtlHVFy6irxSdG935PhwvuafE+fp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537541; c=relaxed/simple;
	bh=JbkxTUzI0MK7B/zwyBvcZkez2ZhHFSTaCsygtsU+s4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cy7ug0WhyvDcKF7Ja9awOi76AEU8CT1mOaOjuk7bXiDtD2X15SgmVUPOOofHm2O5oDw7Q1ublugUvkCaZTGE5U/RkrjMsF80e5xCDu3o11Q2h/yN0+suWtSWhTfwGWoX0QIZBceuvNDypV4XS8tagjiLARlTIVrvnzp0PUR5UEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.XG1PHOD_1713537525;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XG1PHOD_1713537525)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 22:38:46 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc:  <mark.rutland@arm.com>,
   <mathieu.desnoyers@efficios.com>,
   <linux-trace-kernel@vger.kernel.org>,
   <libang.linux@gmail.com>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH] ftrace: Replace ftrace_disabled variable with ftrace_is_dead function
Date: Fri, 19 Apr 2024 22:38:44 +0800
Message-Id: <20240419143844.97847-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the existing function ftrace_is_dead to replace the variable to make
the code clearer.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 kernel/trace/ftrace.c | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 50ca4d4f8840..4a08c79db677 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2693,7 +2693,7 @@ void __weak ftrace_replace_code(int mod_flags)
 	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
 	int failed;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return;
 
 	do_for_each_ftrace_rec(pg, rec) {
@@ -2789,7 +2789,7 @@ ftrace_nop_initialize(struct module *mod, struct dyn_ftrace *rec)
 {
 	int ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return 0;
 
 	ret = ftrace_init_nop(mod, rec);
@@ -3014,7 +3014,7 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 {
 	int ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	ret = __register_ftrace_function(ops);
@@ -3054,7 +3054,7 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 	 * to prevent the NULL pointer, instead of totally rolling it back and
 	 * free trampoline, because those actions could cause further damage.
 	 */
-	if (unlikely(ftrace_disabled)) {
+	if (unlikely(ftrace_is_dead())) {
 		__unregister_ftrace_function(ops);
 		return -ENODEV;
 	}
@@ -3068,7 +3068,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 {
 	int ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	ret = __unregister_ftrace_function(ops);
@@ -3211,7 +3211,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 		for (i = 0; i < pg->index; i++) {
 
 			/* If something went wrong, bail without enabling anything */
-			if (unlikely(ftrace_disabled))
+			if (unlikely(ftrace_is_dead()))
 				return -1;
 
 			p = &pg->records[i];
@@ -3604,7 +3604,7 @@ t_next(struct seq_file *m, void *v, loff_t *pos)
 	loff_t l = *pos; /* t_probe_start() must use original pos */
 	void *ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return NULL;
 
 	if (iter->flags & FTRACE_ITER_PROBE)
@@ -3642,7 +3642,7 @@ static void *t_start(struct seq_file *m, loff_t *pos)
 
 	mutex_lock(&ftrace_lock);
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return NULL;
 
 	/*
@@ -3908,7 +3908,7 @@ ftrace_avail_open(struct inode *inode, struct file *file)
 	if (ret)
 		return ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
@@ -3981,7 +3981,7 @@ ftrace_avail_addrs_open(struct inode *inode, struct file *file)
 	if (ret)
 		return ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
@@ -4025,7 +4025,7 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 
 	ftrace_ops_init(ops);
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	if (tracing_check_open_get_tr(tr))
@@ -4310,7 +4310,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 
 	mutex_lock(&ftrace_lock);
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		goto out_unlock;
 
 	if (func_g.type == MATCH_INDEX) {
@@ -5181,7 +5181,7 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	} else
 		iter = file->private_data;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	/* iter->hash is a local copy, so we don't need regex_lock */
@@ -5267,7 +5267,7 @@ ftrace_set_hash(struct ftrace_ops *ops, unsigned char *buf, int len,
 	struct ftrace_hash *hash;
 	int ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	mutex_lock(&ops->func_hash->regex_lock);
@@ -6159,7 +6159,7 @@ ftrace_graph_open(struct inode *inode, struct file *file)
 	struct ftrace_graph_data *fgd;
 	int ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	fgd = kmalloc(sizeof(*fgd), GFP_KERNEL);
@@ -6187,7 +6187,7 @@ ftrace_graph_notrace_open(struct inode *inode, struct file *file)
 	struct ftrace_graph_data *fgd;
 	int ret;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return -ENODEV;
 
 	fgd = kmalloc(sizeof(*fgd), GFP_KERNEL);
@@ -6297,7 +6297,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 	mutex_lock(&ftrace_lock);
 
-	if (unlikely(ftrace_disabled)) {
+	if (unlikely(ftrace_is_dead())) {
 		mutex_unlock(&ftrace_lock);
 		return -ENODEV;
 	}
@@ -6767,7 +6767,7 @@ void ftrace_release_mod(struct module *mod)
 
 	mutex_lock(&ftrace_lock);
 
-	if (ftrace_disabled)
+	if (unlikely(ftrace_is_dead()))
 		goto out_unlock;
 
 	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
@@ -6830,7 +6830,7 @@ void ftrace_module_enable(struct module *mod)
 
 	mutex_lock(&ftrace_lock);
 
-	if (ftrace_disabled)
+	if (unlikely(ftrace_is_dead()))
 		goto out_unlock;
 
 	/*
@@ -6905,7 +6905,7 @@ void ftrace_module_init(struct module *mod)
 {
 	int ret;
 
-	if (ftrace_disabled || !mod->num_ftrace_callsites)
+	if (unlikely(ftrace_is_dead()) || !mod->num_ftrace_callsites)
 		return;
 
 	ret = ftrace_process_locs(mod, mod->ftrace_callsites,
@@ -8171,7 +8171,7 @@ static void ftrace_startup_sysctl(void)
 {
 	int command;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return;
 
 	/* Force update next time */
@@ -8189,7 +8189,7 @@ static void ftrace_shutdown_sysctl(void)
 {
 	int command;
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		return;
 
 	/* ftrace_start_up is true if ftrace is running */
@@ -8225,7 +8225,7 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 
 	mutex_lock(&ftrace_lock);
 
-	if (unlikely(ftrace_disabled))
+	if (unlikely(ftrace_is_dead()))
 		goto out;
 
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
-- 
2.19.1.6.gb485710b

