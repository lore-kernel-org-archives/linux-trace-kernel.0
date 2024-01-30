Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE7762EE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645994; cv=none; b=Kb8/5bnXNqGJsRCztPMYEMVH6FSI/7aY5x+tOk+2mzK8xKg787sUdaaD0+iESk6ahNeHJb676WoZyi8owDesofkADlmtPtoRv20QK4JnZx1ehKff+T+iQ1jG7LV6r+v51BER2qVObsWGVsBe5cEcHVvzyg/W5or/pUEhmjNPn4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645994; c=relaxed/simple;
	bh=UdqvnuexMAm+G55J7+COkIYKBfcY+c/M1qBu+dF2yVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDYQ0fLYHKEYSmegiCViUTjimrC+nmA6k0s3GEo2C1hlOtMbs7EGKlgM6v082dzZA8/3sKaR8mx3pG0Lk1fqoSpKV8xe57pDm6UWsQo0KrA+n1hNaHLBOzaxZtPFIkzy3jD3fJxt/6aY49ahUQBJpPg+pSrGlagemz5Ced+BjJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=B5fpxlRe; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="B5fpxlRe"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51028acdcf0so5527083e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645991; x=1707250791; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SIuAP6PQUuGPqXCgFtQD+C1lmQsDIZ+6D81ojLLsb8o=;
        b=B5fpxlRe7Rfk9FmSaaQ9jF7fVFafnsI8qNEMrmEeeG5sGwCl+5h3bO4TlO7AovsAr/
         FlLxLffiWFyC/XntA5+XGO8YLIV5K4SWDb1zyuUeOib5vy7miNtsH1ptZBmy3DVnYnIR
         MvlmMcB/SkCboA8ezLJLJDDV8PwqUp4Wk6vp/Z2hPcGOjaagmSO0Y5z9x2FJtCBdm0dM
         6Sw09pW80WhLqe88tEli/bPyJBSaGZfaif9w+sC+D8m+VVYwalr3pGbSl/dPuKAeI54e
         gWoMjLtHDidQEhID7uVKEMTPu/Y8A0SDb2f/LjVvRGuI87fw3kH3DvrnE23dWZDbn13s
         ZY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645991; x=1707250791;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIuAP6PQUuGPqXCgFtQD+C1lmQsDIZ+6D81ojLLsb8o=;
        b=ZXh3LkV/SKSm5kxjq5bHsBDQLtr5cgI02Mxs98IRh1YLqGRGN3Ul9WACNyaPQh6go/
         Gdzfz4tqPPyhZ4l/42B+5ZCCn/qj83J5QmcULZOnf1wmL+6e0XGjiA4ico4+sWq4Ju4X
         /3IL67+MJhKW3wFTNHW09pSe5V678Fc+063nZCZRgyfAEGAn48iye60qjuvqEMMbgIIQ
         Fn6UGQ1iB0h3cJihCHkXffocbI9ENbtN4qbKY9rxz9/MoQkgmarLPLiCFecZkreFT3B+
         BsD3MsojERHiQJK39D4illmtq0QxB2KhtvWi2zT7VejTHN4RWXUKKZbdfw+UWoLwov31
         JUzQ==
X-Gm-Message-State: AOJu0YzhdX9pRBRykliFR6sLhGd5Nm6A6uyDBGHQjYOwBmLxEqjnjfIg
	R3QbTB0B7GzBeama8h31YAJrT3dS9TTDrYCU3uslrLgUG5KSspIRe+cgxBRbwogb5OVTsl88BaQ
	/
X-Google-Smtp-Source: AGHT+IFmAHANnc8lBuMLQU9Bl7IRpJYPUmp56zsYq4M0h8z7F4wob9ymtRBl4oy5k0AvQ5bTalzhDA==
X-Received: by 2002:a05:6512:3996:b0:510:67d:7251 with SMTP id j22-20020a056512399600b00510067d7251mr7082285lfu.47.1706645990624;
        Tue, 30 Jan 2024 12:19:50 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:49 -0800 (PST)
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
Subject: [PATCH v2 net-next 5/5] net: switchdev: Add tracepoints
Date: Tue, 30 Jan 2024 21:19:37 +0100
Message-Id: <20240130201937.1897766-6-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130201937.1897766-1-tobias@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
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
index 309e6d68b179..078a8c68e9e8 100644
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

