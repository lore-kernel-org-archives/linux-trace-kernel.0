Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8652749ED
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Dec 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104913; cv=none; b=gCZjlSpLD0bhEuEfqaiHbR96HPowH0+CUsmmGVoTekCRdUV4HfAsDf3psN6yYRsgsll5LS9ZrcMkmgLUO0wfYJ9KJNIjWof8fc89J4N/FiW5+fstGOZlexKxMryvaf9EuLugcp8KLxVFvrlvIrc3h7mGvI0+yabhZn4iJL9t8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104913; c=relaxed/simple;
	bh=OirRkcFwixXHQheXa+KIz6k9MjZ8IOSl8p9VAcNBXEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLFSQf9HeIuBb9Pxssoaz4/dVzLPKZxHNJEkFa7UgJ3kTyATBWuGzweuYeq/m6N1aWyHDfFNIdsQRTEUzKUPslugw97mcJcJtoilm6VpV5SuUBTIWgF2qMz/y/uJkqgCPwI55Org5rkRYbkQlQ2VD5lwtVyWSbLFIoDOdwolo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WKg8GYoo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WKg8GYoo"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so105809245e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Dec 2025 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767104909; x=1767709709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIoLRQSUadNCrfIEsC1Z/ULO/MyzZkSggw1aeHrL8M8=;
        b=WKg8GYooeLJiDS5IDL9TdWtecSGnavk1IZ8MENy3XfCs2k2RFXAdGSHnFSKcw+sQ/k
         Zqz5W7WSoIxBIYCalmJtRN+fREhimjlMp64tkglZCBxeeYZCgq0dXpuGUzLmGVUCOwTA
         NAtStjLPXbalwh/Py3YH0txdmZYn+mUMNEaOvLbjioJw+8Xylqnc9+4+YvlRoVthzqOU
         dJaSdkvj4a/q4mORS6DZZ0Q16bGdcgT4WgslvF+x4LtPU3r5k48/qnpFOFb9ulQ3g1sv
         DMZq9tCcIyUW4SCgO/TmMHUXs4Qk3O0KSwqORFjQKvCfjT7GyU7hS5V9Jyrh2XtF9fhD
         qGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767104909; x=1767709709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIoLRQSUadNCrfIEsC1Z/ULO/MyzZkSggw1aeHrL8M8=;
        b=dNmsNo66+ClWatRG9gPAXySmcKgA4vm1rfYHVBHcPEcjHxS0ZeBT97Vly1FmZh+oTj
         VM7OW9RcS0is45Cu0wWcZe+Y1IdGfYWPAZfoT0UvWLRltS/ZvT6VsaEiiVumKcrufXJ6
         L8+1zmGXKobPea6HookYtikCzJJHMfkL3e0s1jjbQ3mAabfSGqmfBo9au4JIWsGTe3qG
         Q6oIjzpqr2F/i5v72he1rPnXTmESfX5DiYoSuISNNLgz9pvZKfea7xZLyLXN12G5ZkXz
         tnj1WkYp2OpwvUp1n7saph168DD4/KvN79utQY2tqSmgWYU5cwV5EoPGaYSvDLmLmgP4
         JpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+RAQcgWIyN/NXAWHxJVInieedYI99MGJUKMeV6L69lww0r+aNWty+vsMxMbffoP/25fUEw6z1ag+CrswhjKIyuPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeGJtzuhBFvGL2v6p9pgv0zBYzA5N1uZiGkIQ445w5RQvWawQ
	lI4NQ8ZLMAMaihnjOK1PkPZ4wsMqyMptx+skG65bLNFLDLR67HVxn80/kOKol+U3H+U=
X-Gm-Gg: AY/fxX6GkAzEsJvi5kauQRWq3vKL2tct+x4BLPzPw3bV6DyM00plPcJxQVTdaV2QkRe
	CGfIcVCKiqAaCmoXD9HbIxBJPBfwh8Md4j/rj69uahV5YWtv0UDKTZLfUvEVngLZq91PFqzK5vL
	zLX4HWSxP4GjNmYVGpPfXvnKcjLJv00WftXqGIrouCVKHERfgUIAM6Oe943OEFHU6VCNvvtCmdN
	ZtqUE4rEHajMKDIlreHuRNxyuybhVCbGTtav8fIvC5P8VUPLu91bNp1ALFfp6ft1BZsB7blE/5r
	hnwwkS2bPm1ImqgiiZFNgHrTUo9q0HLPZcapJNyMkxB8Z0GhtX1WlAZE/c0JBZQwH0ogfW8ZNzC
	XdN0tcsWua7akII2AzJsDQhpLjS/oUVg6LdeKxKC8pOAiDfEX01DBZk3R+waFKML9bW7orlseMI
	2479KkY4EEjSlMpzgE0u9aZ+jryw==
X-Google-Smtp-Source: AGHT+IF1wK1v9e8vTVByHUSQTDBMpAJSz79lYseUvik5ltt/ADvdBs6xpQtJKJvSBV4/GI6QWIKYkw==
X-Received: by 2002:a05:6000:1865:b0:42b:4185:e58a with SMTP id ffacd0b85a97d-4324e4cbca1mr41697027f8f.14.1767104908694;
        Tue, 30 Dec 2025 06:28:28 -0800 (PST)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm68145648f8f.3.2025.12.30.06.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:28:28 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Replace use of system_wq with system_dfl_wq
Date: Tue, 30 Dec 2025 15:28:20 +0100
Message-ID: <20251230142820.173712-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen after a careful review and conversion of each individual
case, workqueue users must be converted to the better named new workqueues with
no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This specific workflow has no benefits being per-cpu, so instead of
system_percpu_wq the new unbound workqueue has been used (system_dfl_wq).

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- use system_dfl_wq instead of system_percpu_wq because this workload has no
  benefits being per-cpu.

- rebase on v6.19-rc3.

 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 385af8405392..7001e34476ee 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1375,7 +1375,7 @@ static void free_filter_list_tasks(struct rcu_head *rhp)
 	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
 
 	INIT_RCU_WORK(&filter_list->rwork, free_filter_list_work);
-	queue_rcu_work(system_wq, &filter_list->rwork);
+	queue_rcu_work(system_dfl_wq, &filter_list->rwork);
 }
 
 /*
-- 
2.52.0

