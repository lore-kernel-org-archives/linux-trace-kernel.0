Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84632E6B4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862330; cv=none; b=YeJicEHYuU/IGthWd9Si5RvCfqFq8Eq1SjYmV6BVj+9rh63jPV2/ZzyhhUo2c2OUhWGhHMP7YaPaGg5O1dGb5QQSLsfVuO5IuyxrCu4pTAs9ke28F+zDUn3Vs+jF19v8QTT5abghwjOvofxiS1sPOmtoG8+P5K4nWMYHiTPZsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862330; c=relaxed/simple;
	bh=gWtTBUfQ079blUxszBgnicGvuf0vMoPOa2nISSnwh4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7e/rxJuK9FwU7BFcilhrrB2aF8lLrrH9R1EHQ45WhsxANkZDi0sqqfNXf2Q1i2Fm9iLCWHj4ajMqFjCQlcSOHCU2mNQMyj+tR09Ocow+XDLpLUPqQ4240xOPG+YwmzizoeUvbckafDe/tScgrWFjMks1lYjOzTzXix1PbNi6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKGMppB1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKGMppB1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47db714766aso557943f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 20:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784862327; x=1785467127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/SNsZTXwCXf/3KWca6mZAHrbZy6nzp6GZVhlgsJbqGo=;
        b=sKGMppB1sz/IdANJKNLLJtFziiWHhPoKde8jinZts0knJuMn2cyle3OlOBTlgYM1n8
         N72+YJGBQVrGybRb9bwJZYQM/erUVO9dPh8SdDHJ2i62lJjWyG/g5y795yGSeW9ZKNtU
         ms/0cXN7sCoFrBkawIhKIR3kdlrtGieYIA0Ao/NearwfL2AAF04r0dk30aNJtb56VSA2
         fF7py42SH8eJLmOak2f7R5AhlxPKU/Ogh2I4L84jO5cz2mI4a8rvdursL/EPKc/sJw7x
         bJsuJ/RmHXYWyj/5prHCthZptKHZrs8XkYwhEPIh1pB3Qnvl26pN1udZp7yyiPus65bu
         TQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784862327; x=1785467127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/SNsZTXwCXf/3KWca6mZAHrbZy6nzp6GZVhlgsJbqGo=;
        b=Qw3IG0l4fC77PoAVWAp2TeFBYmeFYE95WcteUfyROSF761jfjreO7pfJqw7r6zDMYZ
         MSPeaZ9mnz2rP/GUYLRMQIfprnhGvJsYtaI+rUamo3OVlW8hNIbKtQuciQH50YxV6HWo
         db7kGRBv0uGfn+l9P93yayL50MINIhojatkbPQAatbOt8mD9Wg/LAnVWC0e06nxcl/yK
         rTjf4uOKOJI2ICKvwq81JCvFltpHh4TESsqUromMLSeFccrlLLpl2KUx1EtxqDgGD2qT
         gp4wiERrWHum/I5p7WE8s4xFGhPSFqcfgXCKpW1hEHwmb4s11K71bySq9oC6wsX2BCUx
         gVzw==
X-Forwarded-Encrypted: i=1; AHgh+RqxeedZOFZXHylQmOauAOtk5qg34Omyn5lx1dgAFSkfWu7wFeMGRwZ0UjvdaG6gMAhfZVQOqtuZ7tpqrSOjwvvI0B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZgc+AHSAd93GRMUVgzgJi8qNDLPTU5eR9gokE9kbkKrP0oyd
	YVf6N07rBkRJkfPOMz/LwqdhulvbCJYpreUfbzkNn7qcsEI5ZZBHHjgR
X-Gm-Gg: AR+sD12rofmJNZnOffo/Ms1r4LSXzCUs8ipimsQ2m93IcTTNJ/wCw/LlsDC7B6Lf4hU
	Tp4QU61nC6D2zy0AhkMSyJA8gVy6xbEHKPKW/sze7uUwCiNh0Zv6IbSjhmbGWN+HRZAfYht8qh+
	AZjx5RVKEM2YJ2d9LPvTN4IKj3yEaKZ3DRRBJt9XGTHgh7g8Pc0x3Pbs+LzQLtCKNs0JIg1doq6
	sd9cGenKxmygWw8QgdkI58cO0iDMCCTsYXKmbwx9Hob7xbL/0kEbIVYflJjVnXkbU/yYEn/X80E
	UDcQ+U9e6QPatgmpVaF8kTWB5nqjyWBeOZduLK80DTRWIFHqMW6EztMtkW7x9L64HI6EwIxbbDc
	7StiO2vD3NsddQNNiMp5rYsw6bona4srtrokl9pH+ja/spXojlVRe1dnPux8l6qTMpGKfyWgKfg
	uTwe0mLA2A/dOOAHhu2/XDTqMHVvG/wBktfYTXF0UBVWN18pU1OO3kAlLegk9IKg==
X-Received: by 2002:a05:6000:220e:b0:47f:924a:655b with SMTP id ffacd0b85a97d-47f924a659dmr5140052f8f.26.1784862326858;
        Thu, 23 Jul 2026 20:05:26 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531basm20280576f8f.19.2026.07.23.20.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:05:26 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v4] tracing: Fix use-after-free freeing trigger private data
Date: Fri, 24 Jul 2026 04:05:17 +0100
Message-ID: <20260724030523.19081-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 61d445af0a7c ("tracing: Add bulk garbage collection of freeing
event_trigger_data") moved the kfree() of event_trigger_data to a kthread
that runs tracepoint_synchronize_unregister() before freeing. That removed
the synchronization the trigger .free callbacks used to get implicitly and
inline from trigger_data_free().

event_hist_trigger_free(), event_hist_trigger_named_free() and
event_enable_trigger_free() free their satellite data (hist_data, cmd_ops,
enable_data) right after trigger_data_free() returns. With the
synchronization now deferred to the kthread, a concurrent tracepoint
handler can still reach that data through the list_del_rcu()'d trigger,
causing a use-after-free.

The histogram teardown must stay synchronous: remove_hist_vars() and
unregister_field_var_hists() have to detach a synthetic event from the
histogram before the trigger-removal write returns, otherwise a following
command races in and the synthetic-event removal fails with -EBUSY, as the
trigger-synthetic-eprobe.tc selftest catches. Make those callbacks wait
with the correct barrier - tracepoint_synchronize_unregister(), matching
the free kthread - before freeing.

The enable trigger has no such synchronous requirement, and a blocking
synchronize there would re-serialize the path that commit deliberately
deferred. Give it an optional private_data_free() callback that the free
kthread runs after its grace period, and free enable_data from there.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_events_hist.c    |  2 ++
 kernel/trace/trace_events_trigger.c | 18 +++++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..bf77331f56a4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1941,6 +1941,7 @@ struct event_trigger_data {
 	struct list_head		named_list;
 	struct event_trigger_data	*named_data;
 	struct llist_node		llist;
+	void				(*private_data_free)(struct event_trigger_data *data);
 };
 
 /* Avoid typos */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82ce492ab268..58d28cd1afa3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6349,6 +6349,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 
 		trigger_data_free(data);
 
+		tracepoint_synchronize_unregister();
 		remove_hist_vars(hist_data);
 
 		unregister_field_var_hists(hist_data);
@@ -6388,6 +6389,7 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
 		del_named_trigger(data);
 		trigger_data_free(data);
+		tracepoint_synchronize_unregister();
 		kfree(cmd_ops);
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..46e60b70a4bb 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -38,6 +38,13 @@ static void trigger_create_kthread_locked(void)
 	}
 }
 
+static void trigger_data_free_one(struct event_trigger_data *data)
+{
+	if (data->private_data_free)
+		data->private_data_free(data);
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
 
+static void enable_trigger_private_data_free(struct event_trigger_data *data)
+{
+	kfree(data->private_data);
+}
+
 void event_enable_trigger_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1728,9 +1740,9 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 	if (!data->ref) {
 		/* Remove the SOFT_MODE flag */
 		trace_event_enable_disable(enable_data->file, 0, 1);
+		data->private_data_free = enable_trigger_private_data_free;
 		trace_event_put_ref(enable_data->file->event_call);
 		trigger_data_free(data);
-		kfree(enable_data);
 	}
 }
 
-- 
2.53.0

