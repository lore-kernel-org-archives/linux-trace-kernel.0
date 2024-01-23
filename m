Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF6612EB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024256; cv=none; b=dDwLYCw86PXPaBsv+efyw2jPW1pJp7uDe3OVxN5Yau6V5ag1l0Ug/mYjfp9Q/2fhbGqHjbYT3CdTS7IP6sEu30HPjecfd38tbUzgMgHJEoUVAnGtPFaUZimIW54ohZ6LKlRqYCINH/Rsn5HUkJ/yNSnOnSSbt3u0WuOPq8MkhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024256; c=relaxed/simple;
	bh=wyizF49U6tvokpvLf/lsprRLkEW1vFMA16uQzuKNOdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8j05JMPZPdvvmMhrG/m1+qXi8lIplfvWrHcGJkaT9eY7ibJuRdSqwDJR9qzi7b2ff7L46iDhkMacP8fh6/0EUDucxeTVJklPuTg+Ew6Ge9o2l3QqrB72wEH3v1POrUGh9GhJLrM1xdHH2ypvRAhC+beXU+0k9DQcaB0x1HkrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=d9fj9ngZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="d9fj9ngZ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so485725e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024253; x=1706629053; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IgEY3zw7gCnp7Jd7W+bim14DEHc/z3jVzwr5Ze0i4MA=;
        b=d9fj9ngZEth/43NKon4xcxTroD7v94kZwSZqpCkbacuJBlisctznvfls3UywNOrkfK
         s5mistU6EpJKQh5Qqxn0Fy1dCQvXwwZtWXszvvOQqnfLsYWgBijJayjuPjxai7hoDOjY
         TBPesEdpL6LZikP8ANeeKkvraLuNhkBRDBltDV98HgKJA8zKB4kawZO+3wGp+fDKbKJj
         9sN2VmfqFnZhcLyx9Dhc3WbLuwGB9hrcBhqudC1E2/rG+9zkeAdW9NuxkCoc5QOMYYWN
         PaNaD79j1HtSUDAlRXlWaTDktPaOLI2ij2+pkgOf6oLS7RtUzwmrs0/6rzik+qqqaNle
         Q9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024253; x=1706629053;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgEY3zw7gCnp7Jd7W+bim14DEHc/z3jVzwr5Ze0i4MA=;
        b=tTGWxWiCgl/sALEjjRduUHp0aGtFazretBN9dpYeIwi2C6ZyiNtYJtjvRniuFCztPT
         ClGcem6NYPS8ylS4dzH6S53AEWTLkyKUzRvXSM+u+e4ERDgZBXy60QqJXDvKfUhATfL0
         kj1zvLAPqW/riq3LdZiIPtUPBGXiq5NVmWkCvzDhFO8AsvVS9qWbOwBqoQ/7EJPILEcG
         wy8KIYkbrz/ebzAZ1R8pUZk+q4o893WeTRuY1tKXi9qBn2LlsNwL1S99IyueysvKiJc1
         ZMRq6ivkB1KtP6sOm/WI2e1Nys1c+5dkgmtyMY+56viWqYepeLrdINY4VqSIjaRdiOI6
         BXpA==
X-Gm-Message-State: AOJu0Yw8Z1Q5PHYSXc7//dqd2jaeZHmzvCE6ypTcIVPhq9HvqIc1yejt
	fgJBxO1AFK8HLIHjWbXcrJ9oK6nUpmMVqnU/sBDpGl+AYX3dsHVkpDQWoq2oKHA=
X-Google-Smtp-Source: AGHT+IETyN+7Poxhx/NY+J4jPZqQz/BpB9oTqL8PQHr1eatRG4ns8rNuqYk1DpfedCgkPIb7Y66llA==
X-Received: by 2002:ac2:4a8b:0:b0:50e:7be1:f0e3 with SMTP id l11-20020ac24a8b000000b0050e7be1f0e3mr2768394lfp.83.1706024253274;
        Tue, 23 Jan 2024 07:37:33 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:32 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] net: switchdev: Add tracepoints
Date: Tue, 23 Jan 2024 16:37:07 +0100
Message-Id: <20240123153707.550795-6-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123153707.550795-1-tobias@waldekranz.com>
References: <20240123153707.550795-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Add a basic set of tracepoints:

- switchdev_defer: Triggers whenever an operation is enqueued to the
  switchdev workqueue.

- switchdev_call_atomic/switchdev_call_blocking: Triggers whenever a
  notification is sent on the corresponding notifier block.

- switchdev_call_replay: Triggers whenever a notification is sent back
  to a driver's own notifier block, in response to a replay request.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/trace/events/switchdev.h | 89 ++++++++++++++++++++++++++++++++
 net/switchdev/switchdev.c        | 24 +++++++--
 2 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/switchdev.h

diff --git a/include/trace/events/switchdev.h b/include/trace/events/switchdev.h
new file mode 100644
index 000000000000..b587965da2f6
--- /dev/null
+++ b/include/trace/events/switchdev.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	switchdev
+
+#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SWITCHDEV_H
+
+#include <linux/tracepoint.h>
+#include <net/switchdev.h>
+
+#define SWITCHDEV_TRACE_MSG_MAX 128
+
+TRACE_EVENT(switchdev_defer,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info),
+
+	TP_ARGS(val, info),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, val)
+		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
+		__field(const struct switchdev_notifier_info *, info)
+		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
+	),
+
+	TP_fast_assign(
+		__entry->val = val;
+		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
+		__entry->info = info;
+		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);
+	),
+
+	TP_printk("dev %s %s", __get_str(dev), __entry->msg)
+);
+
+DECLARE_EVENT_CLASS(switchdev_call,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, val)
+		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
+		__field(const struct switchdev_notifier_info *, info)
+		__field(int, err)
+		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
+	),
+
+	TP_fast_assign(
+		__entry->val = val;
+		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
+		__entry->info = info;
+		__entry->err = err;
+		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);
+	),
+
+	TP_printk("dev %s %s -> %d", __get_str(dev), __entry->msg, __entry->err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_atomic,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_blocking,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+DEFINE_EVENT(switchdev_call, switchdev_call_replay,
+	TP_PROTO(unsigned long val,
+		 const struct switchdev_notifier_info *info,
+		 int err),
+
+	TP_ARGS(val, info, err)
+);
+
+#endif /* _TRACE_SWITCHDEV_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 6612f8bc79c9..dfd9cf75f397 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -19,6 +19,9 @@
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/switchdev.h>
+
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
@@ -171,6 +174,7 @@ static int switchdev_deferred_enqueue(struct switchdev_deferred_item *dfitem)
 	spin_lock_bh(&deferred_lock);
 	list_add_tail(&dfitem->list, &deferred);
 	spin_unlock_bh(&deferred_lock);
+	trace_switchdev_defer(dfitem->nt, &dfitem->info);
 	schedule_work(&deferred_process_work);
 	return 0;
 }
@@ -325,7 +329,11 @@ EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
 			  struct switchdev_notifier_info *info)
 {
-	return nb->notifier_call(nb, type, info);
+	int ret;
+
+	ret = nb->notifier_call(nb, type, info);
+	trace_switchdev_call_replay(type, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(switchdev_call_replay);
 
@@ -368,9 +376,13 @@ int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
 			     struct switchdev_notifier_info *info,
 			     struct netlink_ext_ack *extack)
 {
+	int ret;
+
 	info->dev = dev;
 	info->extack = extack;
-	return atomic_notifier_call_chain(&switchdev_notif_chain, val, info);
+	ret = atomic_notifier_call_chain(&switchdev_notif_chain, val, info);
+	trace_switchdev_call_atomic(val, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(call_switchdev_notifiers);
 
@@ -394,10 +406,14 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				      struct switchdev_notifier_info *info,
 				      struct netlink_ext_ack *extack)
 {
+	int ret;
+
 	info->dev = dev;
 	info->extack = extack;
-	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
-					    val, info);
+	ret = blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
+					   val, info);
+	trace_switchdev_call_blocking(val, info, notifier_to_errno(ret));
+	return ret;
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
-- 
2.34.1

