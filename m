Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF0338936
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Jul 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872615; cv=none; b=it97F/siz58P5ldZHIVFcA3Krr3a+mrTCueRalwUH3ZgxepYkM5BNAmXZnMe/wWuOZDIIfWRNHZVOVWuyhObonGZqOJaqU5pwJVh3qkpxyGeUNln1vtmLs7r2MGsqeGiM1UcmeCZVeqVq2ls7VzD+n+NuqXVlq/NxeyZGdwJYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872615; c=relaxed/simple;
	bh=cmR63zo++/1JJh1mNXua3yo0W3Li3j8K3N2m7BoskS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDYS/kdhAEZP3hPvqNbXLkBOGVuF1L3zlJoKJ5GnY0AmIBysKDHfLDtJjlca2/kPuWlqAh4GnXCs/am5ad8MM05XXxJS2APytY+gBiJNRmvj0wZP53oyPbleuKMi+4k8hL29XrtYqw0hN1bYFA6PwClu7PfgTOHP20ZweSWUjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxp1mf9c; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxp1mf9c"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2050960f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Jul 2026 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783872612; x=1784477412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Dve8ecSIRmLBwhzI6AhAHAcMIIILWkYrU59Bey7/dI=;
        b=dxp1mf9c9cC4MOUk+KkorxVAnWyL8A2xyDo7GC2p9EJPRGGbominNjlwnT+gLxGqJd
         z+Bw8ZmNsffvWOuYsaW/ICtAPD35NxDtYM1/6dE4iaVhUidQZ6+iuElbU9fI3bj286T1
         0UJKDqgvKp7LbuEYDHLH/8W8hevJfkRyi0D6VP8UYc9G4JD7fcWUvpco6lUVTCc0V9Xh
         IfdbOcc7plhrMvaU31lgPV5fDWq3HmCWHInk2cYMSJYYsrA0/T8wKw1lfO00OCHz4z56
         X3EBHRcs4nfZN6EYYeLvQS/RXDO2/up0ebGcD3MHOejr7SoQn4HMhB0hWTyGOIjHrlYd
         Gocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872612; x=1784477412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Dve8ecSIRmLBwhzI6AhAHAcMIIILWkYrU59Bey7/dI=;
        b=NDp3InEOWYTqac2Kclhl+x29bWUYgxkF/VC8S+fPz3/LXobZGB1HBVQnsi1AQyksUF
         WrgJHvsUzMDEpESQhrU1S9k2c5DXtcP1QIsldDgGrBFl2T9bWaDOYd7jgk6r7lclVcYt
         2uqw5G8JWKRePAXZZzKhD6qBl8UeFNSxUg/y4W9eqDmKxa04NFqsW3fzNlhVLPsMq1hm
         CB9PbMX571QDqvVktnETlvFRhVtUIOAafE9zforuM6+6O4xj/aIZFpvAgAD6A39+Lybp
         tmvsPqflZWlEPgMEN0NG/985cUVo8hIShaHfp+y53ntJgg3T4lAQgZD79YZXSN0lUEEQ
         hzdA==
X-Forwarded-Encrypted: i=1; AHgh+RpIp64UApHZl5U3//evZmR40fRwVCq8k9htM8F5CYuEygYWJRzIlVU6TZE9gT2xMSIgBvOVLVDEYFyjb006CvLC2JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaQ+r4eHiNTDoBVLXxVC+av4HnB0dUF2tnxRgQPSTKtQNURvv
	funXPRNiIVFh0LqsodFnIJXpa/i/gj2XRxv1dOoTRijOe+WcQ3Nrmruz
X-Gm-Gg: AfdE7clus90WrjX3iaclusnrRky5N04QVBI3Dowp9+Mv+OFrSjx4vArIl8pnYESYWCy
	fy6VmWLIVeD+7XaWd4hRCd7d9r/7fjf5Jsazmsd9N6OOrBbAlaQ43nh7Bk62T/cMlo3cdhFVzqu
	RjxnT4oDiu+hC7tqwSu8e7dxl7nUdxCVI5bG6HWsDKxTb6/dNO8UILdBYkIN134GY4MFZns6VI9
	iI3Xc21KFl2I1+L+6vtOIlzYH2PsPATtRNJzCGjTguWF13gDw2pdM2EngYVFtXMr2Mcs1YOzOCm
	dzv38nBfuR3Z2c+bw0ya//5jDgIpCGThJv1UWObNmucB8EspHnBqXS2M3O3PQ2S+BmsAtKpbWIV
	aItxGZCwwsUWvJzoltIWsUjDSzL/3bZOgEcGnsvN6pRTcTxtbDfLigaSPBY1JNQ6llKHdUoHClX
	4ULW8RQ/W0L2iwUZM8B0zUJttW5ZaYRAzpNG7gslPLbRIU77HQrowZHuEEBV22AkY2cYaN2pwH
X-Received: by 2002:a05:6000:26c8:b0:46f:558:a43f with SMTP id ffacd0b85a97d-47f2dcd1a60mr6872772f8f.4.1783872612237;
        Sun, 12 Jul 2026 09:10:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm72331539f8f.35.2026.07.12.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:10:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracing: Defer trigger private data frees past the grace period
Date: Sun, 12 Jul 2026 17:10:06 +0100
Message-ID: <20260712161006.242797-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 61d445af0a7c ("tracing: Add bulk garbage collection of freeing
event_trigger_data") made trigger_data_free() defer the kfree() of the
event_trigger_data to a kthread that runs tracepoint_synchronize_unregister()
before freeing. The .free callbacks that own satellite data kept freeing it
synchronously right after calling trigger_data_free(), relying on the
synchronize that used to run inline.

With that synchronize now deferred, event_hist_trigger_free(),
event_enable_trigger_free() and event_hist_trigger_named_free() free
hist_data, enable_data and cmd_ops while a concurrent tracepoint handler can
still dereference them through the list_del_rcu()'d trigger, causing a
use-after-free.

Add an optional free_private() callback to event_trigger_data, invoked by
the free kthread after the grace period, and move the satellite frees into
it. The event_mutex-requiring bookkeeping (remove_hist_vars(),
unregister_field_var_hists()) stays synchronous; only the handler-visible
memory free is deferred.

Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_events_hist.c    | 19 +++++++++++++------
 kernel/trace/trace_events_trigger.c | 18 +++++++++++++++---
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..f04598337060 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1941,6 +1941,7 @@ struct event_trigger_data {
 	struct list_head		named_list;
 	struct event_trigger_data	*named_data;
 	struct llist_node		llist;
+	void				(*free_private)(struct event_trigger_data *data);
 };
 
 /* Avoid typos */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82ce492ab268..bc696e4bd695 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6335,6 +6335,16 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	}
 }
 
+static void hist_trigger_free_private(struct event_trigger_data *data)
+{
+	destroy_hist_data(data->private_data);
+}
+
+static void hist_trigger_named_free_private(struct event_trigger_data *data)
+{
+	kfree(data->cmd_ops);
+}
+
 static void event_hist_trigger_free(struct event_trigger_data *data)
 {
 	struct hist_trigger_data *hist_data = data->private_data;
@@ -6347,13 +6357,12 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 		if (data->name)
 			del_named_trigger(data);
 
-		trigger_data_free(data);
-
 		remove_hist_vars(hist_data);
 
 		unregister_field_var_hists(hist_data);
 
-		destroy_hist_data(hist_data);
+		data->free_private = hist_trigger_free_private;
+		trigger_data_free(data);
 	}
 	free_hist_pad();
 }
@@ -6384,11 +6393,9 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
 	data->ref--;
 	if (!data->ref) {
-		struct event_command *cmd_ops = data->cmd_ops;
-
 		del_named_trigger(data);
+		data->free_private = hist_trigger_named_free_private;
 		trigger_data_free(data);
-		kfree(cmd_ops);
 	}
 }
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..27c54da041b7 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -38,6 +38,13 @@ static void trigger_create_kthread_locked(void)
 	}
 }
 
+static void trigger_data_free_one(struct event_trigger_data * data)
+{
+	if (data->free_private)
+		data->free_private(data);
+	kfree(data);
+}
+
 static void trigger_data_free_queued_locked(void)
 {
 	struct event_trigger_data *data, *tmp;
@@ -52,7 +59,7 @@ static void trigger_data_free_queued_locked(void)
 	tracepoint_synchronize_unregister();
 
 	llist_for_each_entry_safe(data, tmp, llnodes, llist)
-		kfree(data);
+		trigger_data_free_one(data);
 }
 
 /* Bulk garbage collection of event_trigger_data elements */
@@ -75,7 +82,7 @@ static int trigger_kthread_fn(void *ignore)
 		tracepoint_synchronize_unregister();
 
 		llist_for_each_entry_safe(data, tmp, llnodes, llist)
-			kfree(data);
+			trigger_data_free_one(data);
 	}
 
 	return 0;
@@ -1717,6 +1724,11 @@ int event_enable_trigger_print(struct seq_file *m,
 	return 0;
 }
 
+static void enable_trigger_free_private(struct event_trigger_data *data)
+{
+	kfree(data->private_data);
+}
+
 void event_enable_trigger_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1729,8 +1741,8 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 		/* Remove the SOFT_MODE flag */
 		trace_event_enable_disable(enable_data->file, 0, 1);
 		trace_event_put_ref(enable_data->file->event_call);
+		data->free_private = enable_trigger_free_private;
 		trigger_data_free(data);
-		kfree(enable_data);
 	}
 }
 
-- 
2.53.0

