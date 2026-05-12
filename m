Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7093A71B6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594618; cv=none; b=VucFaNBtHh+ZvTBO6gREwo4nrWByDzwC5YfU1P21JVT3T7xruG2DGb/1ijJhCnGERXjSFalX19/IsZ0MLC7vKFvHCCQownhp8v+gIwhYZnPlZhmqlRE1OuCfaDwj9JrFTUpHAy91rBve6aLkiHz2U1KsJRenubFmNd6aPNYWQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594618; c=relaxed/simple;
	bh=MGsCy6a/03Tru/K86yGXtlI7rW3UZ+q9/pItj6ioCRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=U5z6NM5PBbs3E/2ZUIzKE0MrP6/KVYJdo1IZh5PaCgTkfla1N4YhSOVKL2ehBssh1r9+lnGQEFKnDu2DaEMD6arSq2OYqgQJDJM10WIjdYu/K165O93b2hc6SSBaZhhWHydEO+IKt/a72iC1fGrP/GiGok7JF91qmAFbJBshIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMoPAgM7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMoPAgM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34iVkgyuSbdZIlP4LocXZUjRKrJSBP3FogRNdoHZkhI=;
	b=XMoPAgM7dJ0/ry8gjXEP1IIZ4cjyUCSzuLNyDxN3xcOXQLUw2lvX+XFD16BvGK3hEL97Vh
	JFzgTFpaRo+6zs/VTgQkdlklwwW17gNpQObquOh9O8tYKMtoMe9eozIOGBpRYLrfu9aXKa
	6WC9tURv4uW7vdH1knzauTH//N56Cic=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-6U-3kSpCOMeKNOesZbgryw-1; Tue,
 12 May 2026 10:03:30 -0400
X-MC-Unique: 6U-3kSpCOMeKNOesZbgryw-1
X-Mimecast-MFC-AGG-ID: 6U-3kSpCOMeKNOesZbgryw_1778594608
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72EDC1956062;
	Tue, 12 May 2026 14:03:28 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8D341800465;
	Tue, 12 May 2026 14:03:25 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 9/9] rv: Mandate deallocation for per-obj monitors
Date: Tue, 12 May 2026 16:02:50 +0200
Message-ID: <20260512140250.262190-10-gmonaco@redhat.com>
In-Reply-To: <20260512140250.262190-1-gmonaco@redhat.com>
References: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: jA-6cDZocOaTIfXvucXVNHjKpQlDQMkoJFQ68Ft4Lec_1778594608
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The per-object monitors use a hash tables and dynamic allocation of the
monitor storage, functions to clean a monitor that is no longer needed
are provided but nothing ensures the monitor actually uses them.

Remove the inline specifier on the deallocation function to let the
compiler warn in case it isn't referenced. If the monitor really doesn't
need one (for instance because instances will never cease to exist
before disabling the monitor), the da_skip_deallocation() helper macro
can be used to silence the warning.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h                      | 14 +++++++++++++-
 kernel/trace/rv/monitors/deadline/deadline.h |  5 ++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 402d3b935c08..378d23ab7dfb 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -489,8 +489,11 @@ static inline monitor_target da_get_target_by_id(da_id_type id)
  * locks.
  * This function includes an RCU read-side critical section to synchronise
  * against da_monitor_destroy().
+ * NOTE: inline is omitted on purpose to let the compiler warn if this function
+ * is never referenced. For monitors that don't require a deallocation hook,
+ * da_skip_deallocation() can be used.
  */
-static inline void da_destroy_storage(da_id_type id)
+static void da_destroy_storage(da_id_type id)
 {
 	struct da_monitor_storage *mon_storage;
 
@@ -504,6 +507,15 @@ static inline void da_destroy_storage(da_id_type id)
 	kfree_rcu(mon_storage, rcu);
 }
 
+/*
+ * da_skip_deallocation - explicitly mark a deallocation function as not required
+ *
+ * Only use when you are absolutely sure the monitor doesn't require a
+ * deallocation hook (i.e. it's not possible for an object to finish existing
+ * when the monitor is still running).
+ */
+#define da_skip_deallocation(hook) ((void)hook)
+
 static void da_monitor_reset_all(void)
 {
 	struct da_monitor_storage *mon_storage;
diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
index 78fca873d61e..c39fd79148c2 100644
--- a/kernel/trace/rv/monitors/deadline/deadline.h
+++ b/kernel/trace/rv/monitors/deadline/deadline.h
@@ -194,7 +194,10 @@ static void __maybe_unused handle_newtask(void *data, struct task_struct *task,
 		da_create_storage(EXPAND_ID_TASK(task), NULL);
 }
 
-static void __maybe_unused handle_exit(void *data, struct task_struct *p, bool group_dead)
+/*
+ * Deallocation hook, use da_skip_deallocation() when not necessary
+ */
+static void handle_exit(void *data, struct task_struct *p, bool group_dead)
 {
 	if (p->policy == SCHED_DEADLINE)
 		da_destroy_storage(get_entity_id(&p->dl, DL_TASK, DL_TASK));
-- 
2.54.0

