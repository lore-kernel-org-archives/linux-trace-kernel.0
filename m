Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B63DE445
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230003; cv=none; b=U1RIJClOJ0Pgt75gI1zaKWabBpGpRvbD//O63hm/iv66M5FIGzQhxKRBYtwxYHUOsOhAU/9eSxCMs+hJxu2dKB17N1DE8DcY9zWltWJ4SjX/ewdG1Xyt//5uzd6lFBFg3ByEuT1XpD7rfy/b0/ouDHN5EWBV3M7xXTrblJP31Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230003; c=relaxed/simple;
	bh=HhxX14UkA4Md0FHrn0YoGqjjtgcFeX0wk8i706bX378=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ejh6bAvcNVDelLiuyyH1p/+JfxMA8qjTr+vpLfl+Hj3soe4rN5ynFaSdKTTckiU4Bnw/UzpMISeNHBkZHiYxZFDU+MMV57x3IlcR9yqNzyIAn6YD3UReppfYLwrwleBiAi82WybwMvBo37aWJ0xIvmWISNyBSuXhvbw1I/VSYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbSOKF5M; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbSOKF5M"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82980945556so2745341b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773230000; x=1773834800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XUaqMDdHb6xWSLB7LHHRKEGcmYQutagR+4ik5kvWaI=;
        b=CbSOKF5MrEPdoMCmt9kqnbnUc8KZEpXee2cAccJ/lcqSCwFkmY7+MFmyCFlxQo5QqT
         2g/hBCKYUQogSpxrAQXLmUSJHMo9LitdSaQ3j7GfVKwc7ADNZAKpeVRqR9+uwVxhx5bk
         o0GuMW/v7XfV+8suAiDPO83SpqYHiEpsUz17u2aLCNN+Xg8eRNT9CuQeQ44Upv2ZlAIO
         uvknmxvqNeLsT8+S7UrUbGZW4xjiT1pKjYjca0xuBSovtFe27z8S+KFdby5/0RNcs5wW
         3Z7KDMqB6fqwe1ViCtIDDLVi+NazBfY6GKccH180YxdSnswb1+3hNXgGVsANpD+UwlhZ
         NReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230000; x=1773834800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5XUaqMDdHb6xWSLB7LHHRKEGcmYQutagR+4ik5kvWaI=;
        b=U0wQwp+NnjWrHINmhCNLYFAtGC5q8lqFbAAp/Hha41wYFaIsRofsiNzqoIXK8p702s
         +wwQDO8YmZyTUQHcS4XtPMJNXP/+PRlQrGBdgDrxtuoAkzUIpqnKtr6+W4sQ1TzoWoTR
         /dgpWYJdDyhw9a7VOQ/YoHOxKEpgy0F1eYOqJbUDYO5kqA0xYOG9AzBJJdeA214EBdMV
         slkpoadCJFWXVyrFNkLum8tAR2V0e6UxfEYrb2c9eH5Me/f/UtbUwMJ1Po/VvodmOSEL
         8S4Ln906rf9SfXJEUYP+42GgAs1p5aRsBFZAGMaJ3q8sokJezSragc9cw5pbDDYLPDtI
         Gw3A==
X-Forwarded-Encrypted: i=1; AJvYcCVG2y9n7gttwO9ttNMpkHVPdBrXCdMBAwnPJ2luGVDLiyLHxfsr6tstJ4JukholerMaBNV2c4FQRcXnely8h4X/ZC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GNb+oXFtZAug9q8sezDwy2YRyi6VyqT+rzWUwWrgx0HOkKL2
	jfqiQNwCb9mqJUxwgMRhCJ8Rluh9dzSllds2vLfF8sSFWl6rFXZlHA3V
X-Gm-Gg: ATEYQzybxQLGwSRoES1zf/c2ERk/KOwQAW6Q2ncldRxSLKVMPChna8tksT649s5H6nf
	G+ewkAJgm3ON79MXdJ6wPxtjrV5pT72k7vX80O/71/VoKJ5WOEO9gHNz0OxR3u5sz4pz+eaZrmC
	o1EEQ8kOvhGC8bRK7wIWld3AGDsNnvHypCT3+7eoO/1vB0bh6Od5kF55GKOBSyz5zNMXBjnEHYK
	1Z5v5duQmqWeO9/fexuYra10w1FuFxbNgrrV5+0W1cYO1olmypD57HoUB5vy7HuwXBmL/PPrdb0
	MzY+iQVzGx/yXhBQAAVsKePiSBmaRPWOi81zKdtGc6dLLky4yxyj9Aews86mMJC6/DTjseTjsB3
	3RK8rtohC0TXgz0Z2L+SKeR0UVhgQrZust8aPzU+yuNP8feMCNJIJSfrbsdvcTngbcKbkNNB2Zt
	p0tT5rh/DWKlrew7yipNI5vhPdcq/o5caEYCcBjW2GQB2iolrgo+bHhuGG+ScadGAkLhry0rM5y
	g==
X-Received: by 2002:a05:6a00:ab89:b0:81e:d18a:489d with SMTP id d2e1a72fcca58-829f71da9e4mr2364945b3a.42.1773230000395;
        Wed, 11 Mar 2026 04:53:20 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b46:28af:1445:b4e2:b8bf:2d47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3aedsm2500588b3a.18.2026.03.11.04.53.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 04:53:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 3/3] ftrace: Disable optimistic spinning for ftrace_lock
Date: Wed, 11 Mar 2026 19:52:50 +0800
Message-ID: <20260311115250.78488-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311115250.78488-1-laoar.shao@gmail.com>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ftrace_lock may be held for a relatively long duration. For example,
reading the available_filter_functions file takes considerable time:

  $ time cat /sys/kernel/tracing/available_filter_functions &> /dev/null
  real 0m0.457s user 0m0.001s sys 0m0.455s

When the lock owner is continuously running, other tasks waiting for the
lock will spin repeatedly until they hit a cond_resched() point, wasting
CPU cycles.

ftrace_lock is currently used in the following scenarios:
- Debugging
- Live patching

Neither of these scenarios are in the application critical path.
Therefore, it is reasonable to make tasks sleep when they cannot acquire
the lock immediately, rather than spinning and consuming CPU resources.

Performance Comparison
======================

- Before this change

  - Single task reading available_filter_functions:

    real 0m0.457s user 0m0.001s sys 0m0.455s

  - Six concurrent processes:

    real 0m2.666s user 0m0.001s sys 0m2.557s
    real 0m2.718s user 0m0.000s sys 0m2.655s
    real 0m2.718s user 0m0.001s sys 0m2.600s
    real 0m2.733s user 0m0.001s sys 0m2.554s
    real 0m2.735s user 0m0.000s sys 0m2.573s
    real 0m2.738s user 0m0.000s sys 0m2.664s

- After this change

  - Single task:

    real 0m0.454s user 0m0.002s sys 0m0.453s

  - Six concurrent processes:

    real 0m2.691s user 0m0.001s sys 0m0.458s
    real 0m2.785s user 0m0.001s sys 0m0.467s
    real 0m2.787s user 0m0.000s sys 0m0.469s
    real 0m2.787s user 0m0.000s sys 0m0.466s
    real 0m2.788s user 0m0.001s sys 0m0.468s
    real 0m2.789s user 0m0.000s sys 0m0.471s

The system time significantly decreases in the concurrent case, as tasks
now sleep while waiting for the lock instead of busy-spinning.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/ftrace.c | 106 +++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 827fb9a0bf0d..00c195e280c5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1284,10 +1284,10 @@ static void clear_ftrace_mod_list(struct list_head *head)
 	if (!head)
 		return;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	list_for_each_entry_safe(p, n, head, list)
 		free_ftrace_mod(p);
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 }
 
 void free_ftrace_hash(struct ftrace_hash *hash)
@@ -4254,7 +4254,7 @@ static void *t_start(struct seq_file *m, loff_t *pos)
 	void *p = NULL;
 	loff_t l;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	if (unlikely(ftrace_disabled))
 		return NULL;
@@ -4305,7 +4305,7 @@ static void *t_start(struct seq_file *m, loff_t *pos)
 
 static void t_stop(struct seq_file *m, void *p)
 {
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 }
 
 void * __weak
@@ -4362,11 +4362,11 @@ static __init void ftrace_check_work_func(struct work_struct *work)
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	do_for_each_ftrace_rec(pg, rec) {
 		test_for_valid_rec(rec);
 	} while_for_each_ftrace_rec();
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 }
 
 static int __init ftrace_check_for_weak_functions(void)
@@ -5123,7 +5123,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	if (!new_hash)
 		goto out; /* warn? */
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	list_for_each_entry_safe(ftrace_mod, n, head, list) {
 
@@ -5145,7 +5145,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 		ftrace_mod->func = func;
 	}
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	list_for_each_entry_safe(ftrace_mod, n, &process_mods, list) {
 
@@ -5159,11 +5159,11 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	if (enable && list_empty(head))
 		new_hash->flags &= ~FTRACE_HASH_FL_MOD;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	ftrace_hash_move_and_update_ops(ops, orig_hash,
 					      new_hash, enable);
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
  out:
 	mutex_unlock(&ops->func_hash->regex_lock);
@@ -5465,7 +5465,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 		return -EINVAL;
 
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
 	list_for_each_entry(iter, &tr->func_probes, list) {
 		if (iter->probe_ops == probe_ops) {
@@ -5476,7 +5476,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 	if (!probe) {
 		probe = kzalloc_obj(*probe);
 		if (!probe) {
-			mutex_unlock(&ftrace_lock);
+			slow_mutex_unlock(&ftrace_lock);
 			return -ENOMEM;
 		}
 		probe->probe_ops = probe_ops;
@@ -5488,7 +5488,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 
 	acquire_probe_locked(probe);
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	/*
 	 * Note, there's a small window here that the func_hash->filter_hash
@@ -5540,7 +5540,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 		}
 	}
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	if (!count) {
 		/* Nothing was added? */
@@ -5560,7 +5560,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 		ret = ftrace_startup(&probe->ops, 0);
 
  out_unlock:
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	if (!ret)
 		ret = count;
@@ -5619,7 +5619,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 			return -EINVAL;
 	}
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
 	list_for_each_entry(iter, &tr->func_probes, list) {
 		if (iter->probe_ops == probe_ops) {
@@ -5636,7 +5636,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 
 	acquire_probe_locked(probe);
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	mutex_lock(&probe->ops.func_hash->regex_lock);
 
@@ -5679,7 +5679,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 		goto out_unlock;
 	}
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	WARN_ON(probe->ref < count);
 
@@ -5703,7 +5703,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 			probe_ops->free(probe_ops, tr, entry->ip, probe->data);
 		kfree(entry);
 	}
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
  out_unlock:
 	mutex_unlock(&probe->ops.func_hash->regex_lock);
@@ -5714,7 +5714,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 	return ret;
 
  err_unlock_ftrace:
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 	return ret;
 }
 
@@ -5943,9 +5943,9 @@ ftrace_set_hash(struct ftrace_ops *ops, unsigned char *buf, int len,
 			goto out_regex_unlock;
 	}
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	ret = ftrace_hash_move_and_update_ops(ops, orig_hash, hash, enable);
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
  out_regex_unlock:
 	mutex_unlock(&ops->func_hash->regex_lock);
@@ -6205,7 +6205,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	 * Now the ftrace_ops_list_func() is called to do the direct callers.
 	 * We can safely change the direct functions attached to each entry.
 	 */
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6219,7 +6219,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	/* Prevent store tearing if a trampoline concurrently accesses the value */
 	WRITE_ONCE(ops->direct_call, addr);
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 out:
 	/* Removing the tmp_ops will add the updated direct callers to the functions */
@@ -6625,7 +6625,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	 * Now the ftrace_ops_list_func() is called to do the direct callers.
 	 * We can safely change the direct functions attached to each entry.
 	 */
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6637,7 +6637,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 		}
 	}
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 out:
 	/* Removing the tmp_ops will add the updated direct callers to the functions */
@@ -6980,10 +6980,10 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		} else
 			orig_hash = &iter->ops->func_hash->notrace_hash;
 
-		mutex_lock(&ftrace_lock);
+		slow_mutex_lock(&ftrace_lock);
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
-		mutex_unlock(&ftrace_lock);
+		slow_mutex_unlock(&ftrace_lock);
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
@@ -7464,12 +7464,12 @@ void ftrace_create_filter_files(struct ftrace_ops *ops,
  */
 void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 {
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |= FTRACE_OPS_FL_DELETED;
 	ftrace_free_filter(ops);
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 }
 
 static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
@@ -7571,7 +7571,7 @@ static int ftrace_process_locs(struct module *mod,
 	if (!start_pg)
 		return -ENOMEM;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	/*
 	 * Core and each module needs their own pages, as
@@ -7661,7 +7661,7 @@ static int ftrace_process_locs(struct module *mod,
 		local_irq_restore(flags);
 	ret = 0;
  out:
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
@@ -7868,7 +7868,7 @@ void ftrace_release_mod(struct module *mod)
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	/*
 	 * To avoid the UAF problem after the module is unloaded, the
@@ -7913,7 +7913,7 @@ void ftrace_release_mod(struct module *mod)
 			last_pg = &pg->next;
 	}
  out_unlock:
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	/* Need to synchronize with ftrace_location_range() */
 	if (tmp_page)
@@ -7938,7 +7938,7 @@ void ftrace_module_enable(struct module *mod)
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	if (ftrace_disabled)
 		goto out_unlock;
@@ -8008,7 +8008,7 @@ void ftrace_module_enable(struct module *mod)
 		ftrace_arch_code_modify_post_process();
 
  out_unlock:
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	process_cached_mods(mod->name);
 }
@@ -8267,7 +8267,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	/*
 	 * If we are freeing module init memory, then check if
@@ -8310,7 +8310,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		/* More than one function may be in this block */
 		goto again;
 	}
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	list_for_each_entry_safe(func, func_next, &clear_hash, list) {
 		clear_func_from_hashes(func);
@@ -8686,22 +8686,22 @@ static void clear_ftrace_pids(struct trace_array *tr, int type)
 
 void ftrace_clear_pids(struct trace_array *tr)
 {
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	clear_ftrace_pids(tr, TRACE_PIDS | TRACE_NO_PIDS);
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 }
 
 static void ftrace_pid_reset(struct trace_array *tr, int type)
 {
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	clear_ftrace_pids(tr, type);
 
 	ftrace_update_pid_func();
 	ftrace_startup_all(0);
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 }
 
 /* Greater than any max PID */
@@ -8713,7 +8713,7 @@ static void *fpid_start(struct seq_file *m, loff_t *pos)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = m->private;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	rcu_read_lock_sched();
 
 	pid_list = rcu_dereference_sched(tr->function_pids);
@@ -8740,7 +8740,7 @@ static void fpid_stop(struct seq_file *m, void *p)
 	__releases(RCU)
 {
 	rcu_read_unlock_sched();
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 }
 
 static int fpid_show(struct seq_file *m, void *v)
@@ -8766,7 +8766,7 @@ static void *fnpid_start(struct seq_file *m, loff_t *pos)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = m->private;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	rcu_read_lock_sched();
 
 	pid_list = rcu_dereference_sched(tr->function_no_pids);
@@ -9057,7 +9057,7 @@ static int prepare_direct_functions_for_ipmodify(struct ftrace_ops *ops)
 			unsigned long ip = entry->ip;
 			bool found_op = false;
 
-			mutex_lock(&ftrace_lock);
+			slow_mutex_lock(&ftrace_lock);
 			do_for_each_ftrace_op(op, ftrace_ops_list) {
 				if (!(op->flags & FTRACE_OPS_FL_DIRECT))
 					continue;
@@ -9066,7 +9066,7 @@ static int prepare_direct_functions_for_ipmodify(struct ftrace_ops *ops)
 					break;
 				}
 			} while_for_each_ftrace_op(op);
-			mutex_unlock(&ftrace_lock);
+			slow_mutex_unlock(&ftrace_lock);
 
 			if (found_op) {
 				if (!op->ops_func)
@@ -9106,7 +9106,7 @@ static void cleanup_direct_functions_after_ipmodify(struct ftrace_ops *ops)
 			unsigned long ip = entry->ip;
 			bool found_op = false;
 
-			mutex_lock(&ftrace_lock);
+			slow_mutex_lock(&ftrace_lock);
 			do_for_each_ftrace_op(op, ftrace_ops_list) {
 				if (!(op->flags & FTRACE_OPS_FL_DIRECT))
 					continue;
@@ -9115,7 +9115,7 @@ static void cleanup_direct_functions_after_ipmodify(struct ftrace_ops *ops)
 					break;
 				}
 			} while_for_each_ftrace_op(op);
-			mutex_unlock(&ftrace_lock);
+			slow_mutex_unlock(&ftrace_lock);
 
 			/* The cleanup is optional, ignore any errors */
 			if (found_op && op->ops_func)
@@ -9153,11 +9153,11 @@ static int register_ftrace_function_nolock(struct ftrace_ops *ops)
 
 	ftrace_ops_init(ops);
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 
 	ret = ftrace_startup(ops, 0);
 
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	return ret;
 }
@@ -9200,9 +9200,9 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
 {
 	int ret;
 
-	mutex_lock(&ftrace_lock);
+	slow_mutex_lock(&ftrace_lock);
 	ret = ftrace_shutdown(ops, 0);
-	mutex_unlock(&ftrace_lock);
+	slow_mutex_unlock(&ftrace_lock);
 
 	cleanup_direct_functions_after_ipmodify(ops);
 	return ret;
-- 
2.47.3

