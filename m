Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F537EFF4
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677582; cv=none; b=ICxtzqFdx6Dg51fNhfr29Z5YWqGhHk4++ZHVs1sHbKO7ovkevcBp/jvoV1luALLvWeKUhmt4/0Sg39mU4ghSaXYk8WneDao/u5OHf1Hx8HCp7S1bI51rSi7+276Aoe0kfrgFfRyCqC+9+s+OdVJkL6GtLYq+Go4LoZZ0um0jm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677582; c=relaxed/simple;
	bh=alcyeddgDUSJXarjbAWMjVjRqK48kZF8iw50ja7MJ2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ev5S8qPhtrdKNZNsFFul878uamQYubw/m1/nf+1H8/ao1aYuq3Wr292ZGVuM+XliDOJDUDTLL54j9q8WgdR6roiLpnxOGSD6P8pJPlCd9FEExhdKb6H+45Gtn5ucfPOKJIkarcmYSgBjDEYqrkjZK9nd8iHnbUSD8F9/m+L7a0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQb78ZFM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQb78ZFM"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so18789275e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677578; x=1781282378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqx0yAXprOKYJzlWkEgJQMAMSi5IOeP8Cp8BGVovhWs=;
        b=EQb78ZFMelu3MilRuZImUWmgld2KiKTMtrplEZhihS40q4pc3O3rqxAppoD83o9UvU
         ZS7fbW77TXCO/YDVH7y25nF4aAY20Z2Y1NEca1e4BKNuzZyUPEVYJ2CNsrjRql8vCQo3
         9Hnvie6N3fXr0deK4tF6ws/MCWlNucfeH3smpm9G3HWIi9GIjjfLvU1SE1JTVrPkm+gr
         5T8PaVZI/6oUmsk4jQ85nODzk2PMXJVyJg4+wcKYHoqUyy8+61C8ZWOCgta4tfIyrJSO
         cNuSlfDG5TLGkYjTyS2VLOINAprUWUrB9JWJwWKk3wQ1P6J+mrGq3YfJ40uWMu8X/g0b
         A3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677578; x=1781282378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqx0yAXprOKYJzlWkEgJQMAMSi5IOeP8Cp8BGVovhWs=;
        b=IxwRCIwojR9kPpApdZrOxVqTgfkR16YhOnzlivVZDnqIGH3h8wXX+Mhq+rpZoGusPb
         SnYtyEUJKeLBfae57mZhxZlqZyLbl9QnOCFOnDK5XDZt46Mi0nqm6FADkX/6di3iApj5
         jTz3CFWR9+evwBUuI7LGadAwDTA/Au3aHGnbdqWXfWxnFS/MOZs/TyyJn5hnqyuDNBvS
         1bQNLicggSQ1IHYFIs6m0gXvJJQ3R1zmmHn8CfcHl8WEvawrJ9w2O01yO+VLaRRWyb3+
         XLHagtBDNPKiQhtRRL9cIEgipTZml0kRrhaRGJv5rkpCB1ISDSIaoOInPTqpIvTlLh6P
         9Zeg==
X-Forwarded-Encrypted: i=1; AFNElJ/zOdVoRAwCbCSkJrOoGpQjbsY2tpKb+mkgqAffmabsG9MOTezFNYtIUq/BTjYur5+DzN/2cMvh6S8uuLilHXkGD+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuavhNkoWyTnHr11N0aspn0TECBJQDlwrKCcOrQWq1irmeHSuN
	ehIODpDnLpTILV7EiHvHyLLNU3PXaIDlVZ9cvF3yN9sobc1U9rqUBvc3fcpOgZJgJ6iPCDb8pmK
	/4FTOayEgy+1yeEGGWx01vg==
X-Received: from wmbdr18.prod.google.com ([2002:a05:600c:6092:b0:490:9d65:494e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:620f:b0:490:b3f1:e41b with SMTP id 5b1f17b1804b1-490c2612d83mr68089165e9.26.1780677577714;
 Fri, 05 Jun 2026 09:39:37 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:10 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-4-vdonnefort@google.com>
Subject: [PATCH v2 03/18] tracing/remotes: Use kstrtobool for boolean tracefs files
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Use kstrtobool in trace_remote.c where possible. This is more user-friendly
as it allows a better variety of input strings.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 9b27c7bd6040..71f6cda0fbd4 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -235,10 +235,10 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
 {
 	struct seq_file *seq = filp->private_data;
 	struct trace_remote *remote = seq->private;
-	unsigned long val;
+	bool val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtobool_from_user(ubuf, cnt, &val);
 	if (ret)
 		return ret;
 
@@ -1154,10 +1154,10 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
 	struct seq_file *seq = filp->private_data;
 	struct remote_event *evt = seq->private;
 	struct trace_remote *remote = evt->remote;
-	u8 enable;
+	bool enable;
 	int ret;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
@@ -1238,10 +1238,10 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
 					      size_t count, loff_t *ppos)
 {
 	struct trace_remote *remote = file_inode(filp)->i_private;
+	bool enable;
 	int i, ret;
-	u8 enable;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
-- 
2.54.0.1032.g2f8565e1d1-goog

