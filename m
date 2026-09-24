Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21064A1399
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261927; cv=none; b=gjRNOeFI2Vakfub4JUor1Fzn3AYHcrLwmRwN3A4E3Ldo8Y2r603tqR66HuwOxlmke9rh5INo++kW4S8NBTxQA76bdUJybwpY+o4OO0OAW1XkEto+3xWcKeHEGYVFLcQbbvsqjeIfKAQqQo2+r67f4RcgpO84DIHVGcxaoDf1mGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261927; c=relaxed/simple;
	bh=gyLVAF3tlmRS8yu7R0Sj0qry/ybOo5qjXc2qNQmb9wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hIc7YmkJzDMbkNXFx/o5CxtkDMl7FJP7bvHzGHpvEmxS6wWGKscfjvfwyQadUueMEI7kmM0cje9uQS1pODhGOqVIN3OY78bKJgYqEBqNXx+KvW99PRi2GSbEj/gy3ZCZd9Kzcm4wgCWreglSw8XFPCFR74Wjv2eQjEh+rK93nYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlLbPsRo; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlLbPsRo"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487041c4c82so786416f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261923; x=1790866723; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41Mral2Iew9L1eDAhCS002LBnxt3yzfpo/S93Hv8u3M=;
        b=KlLbPsRoArAkcoE/hIs7bSqdYJFb0CdFxlAtdUVJsRtbY/HIge4MtaVQEj/Dl+NLIC
         jaCWS4ySxaiPVQ0qd1QZTXyO95W/EGXrTQEKknHgUubcMhBjId4m4Zo8k6t5HVm97xSc
         dKkj5JzfKzLU//HfLaSh1jGny6zABRpX/3CzVE0eQphQt9mb+/SHHkcY4uEsiAsRZZdo
         fey/8UlVNf+hVjlgCPyytz/PvfaD3+2G+qR0QpVNkranizxLrp+nxr0hUhldlx5KKfs0
         BmHilDHuns5Bk0z8OYxsmENQflNrU7ZScFA7wbevWGDX7pRQ/uJ6xvg5P3sGc9Vly0fU
         8Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261923; x=1790866723;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41Mral2Iew9L1eDAhCS002LBnxt3yzfpo/S93Hv8u3M=;
        b=2VFbRolMi/WOZb8tM6XfGgUBZT5JwcwxUWtWrfYvGOyEiEYwXwSghWZXLZk1aOMXjH
         BJNZjJ187dIhk/HCAyM+9An1C3dHFUMWLTYit3oKR80OB//sE8V/Wefnd+Nnuzr5xwy5
         0VrphkBqjyhEbgrERQnAPG5BpKAwlFt71bhOPEs9sTooSCfKdPplC/e7SAxtwozflHoM
         Y2JCoTkKYiMaOIvEpMLHfGAGBClgCqi3WxGTAkHU+4JsLt9pEQbYMhpa3/pfMW+Kh2+u
         zTTV6ad4gG5RYqWxAsj72Unsdpg7/7tZ/yjXONu+01Jcvavyz5uAtIl9yYZkfqA9UrxI
         5aMg==
X-Forwarded-Encrypted: i=1; AKwUvBwr1AyoTgGrgU5JFOENCx3hY7BPg///9ve+ExsrrvutRk7yWuMxc/IdG/hnMBmJmh21AzCBdmzKqaIVF5/uln9y3Ok=@vger.kernel.org
X-Gm-Message-State: AFuF++khLEbRR5ftbRoFUnAaP1iSRLZDDSKB7fbpu4uvv3zfD76rqB8E
	nR0HcNJ++SKmOzd6HI0m5vXrzRRekVl3iVWdVeY8/3fw41lRVvQ+DTFpoh2PzNxIxsUYPMVvB7j
	Lq/xCdHuMnRi4JeYnWs33Vg==
X-Received: from wrck17.prod.google.com ([2002:a5d:5251:0:b0:488:658b:25a9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4703:b0:487:242a:c020 with SMTP id ffacd0b85a97d-48872a5cdb4mr4380837f8f.6.1790261922940;
 Thu, 24 Sep 2026 07:58:42 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:51 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-18-vdonnefort@google.com>
Subject: [PATCH v7 17/20] tracing/remotes: Add poll_ms tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a tracefs file to configure the trace remote polling period. Keep
the default value to 100ms.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 41 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0a360690b174..b2547eb117f8 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -427,7 +427,8 @@ static void trace_remote_do_poll(struct trace_remote *remote)
 
 	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
 	yield = trace_remote_do_dmesg(remote);
-	schedule_delayed_work(&remote->poll_work, yield ? 0 : msecs_to_jiffies(remote->poll_ms));
+	schedule_delayed_work(&remote->poll_work,
+			      yield ? 0 : msecs_to_jiffies(READ_ONCE(remote->poll_ms)));
 }
 
 static void __poll_remote(struct work_struct *work)
@@ -1138,6 +1139,40 @@ static int dump_on_panic_show(struct seq_file *s, void *unused)
 }
 DEFINE_TRACE_REMOTE_ATTRIBUTE(dump_on_panic);
 
+static ssize_t poll_ms_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct seq_file *seq = filp->private_data;
+	struct trace_remote *remote = seq->private;
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	if (!val)
+		return -EINVAL;
+
+	guard(mutex)(&remote->lock);
+
+	if (val < remote->poll_ms && remote->poll_cnt)
+		mod_delayed_work(system_percpu_wq, &remote->poll_work, msecs_to_jiffies(val));
+
+	WRITE_ONCE(remote->poll_ms, val);
+
+	return cnt;
+}
+
+static int poll_ms_show(struct seq_file *s, void *unused)
+{
+	struct trace_remote *remote = s->private;
+
+	seq_printf(s, "%u\n", READ_ONCE(remote->poll_ms));
+
+	return 0;
+}
+DEFINE_TRACE_REMOTE_ATTRIBUTE(poll_ms);
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1170,6 +1205,10 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	if (!d)
 		goto err;
 
+	d = trace_create_file("poll_ms", TRACEFS_MODE_WRITE, remote_d, remote, &poll_ms_fops);
+	if (!d)
+		goto err;
+
 	d = trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			      &buffer_size_kb_fops);
 	if (!d)
-- 
2.56.0.rc1.310.g51773c2048-goog

