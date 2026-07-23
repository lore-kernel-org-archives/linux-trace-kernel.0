Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C347D94B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826144; cv=none; b=Ax92zW2yhMTNgldytYW7+YKrGGIDRPe/m5h5x1HGAiTSDhcgppJkSVscuPWiymiIfwMxVvAmHbTG6xVpJ26iRVsEHvYWa4i0VLp9N6/JkAuMzhW3Oe4VqsvVic945nWxCdW3/usWr6jb7aMFHf6Tot5OLdOmc9ddtAs+N7FCVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826144; c=relaxed/simple;
	bh=lgWbQSIGkHaJFwMKa3Qo3IyryVCaHEn196sDZXc4Qeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYnWgfnreVt9/yn3Ymn+j3uuyxAXFhyAulwtDK0El6Tta7IVnQGZN+H9CvTq1qUz4gcFPxTEWtIozvzAqI3Sz5DQmgbMRma1Gi+ZyRfvOZH6J1spN9I+Pqxj4MvsLIeu9WagSGAZ9PlY+GGtKi5dXvn3MVHJ0es9E481Q1nmx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGF859Go; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGF859Go"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47de008b020so626822f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826137; x=1785430937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+Lh2HBFQ2XSCdRLC61s0Zob5sybpFnoGkpl5bqbPZU=;
        b=dGF859Gobzy6oul6+QWEY2fiAukQb5REdpyKM5dIn4xs3qfGxl+u6MGvHOoLzHv2Ly
         Q/XGIJUAlX85Z6+28vNecc5bxOfFuWqMZnxL6M2Ai+YwgbVjgThNYnrP86Fg7EJlEdkF
         jJDzPyQngOGhJB0XvN6ehkbdcqhtHHuo+Go85so2ZTuN1yqaId6cgynAOOXEjOok5HEq
         qDZMGN3wb02pHnqzZhHtns1if0j7Z3Vf3PwV/wq/ExrQzAOeWZ97dUlSnP6P7+g4KHwp
         cdBqmkZpmm0F7l641kDzPm/ZsBhALSbezxrVC1Yu8Lc8KsYx+J+ahMZoeEH8kRCE/e3q
         kARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826137; x=1785430937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+Lh2HBFQ2XSCdRLC61s0Zob5sybpFnoGkpl5bqbPZU=;
        b=cr7A62GVAd2hY7Gi3idhfYmBWCga/uubXxaC/ghYSXiKPSdU4UFOPNBHIB1iaDAfzD
         4tgjZZPGmR8YIqIXDPPpK/umwSvYBcE+t1XF1PmQArts1NsBiH7MMGduIge7kuFvH9Af
         hrPC5j+tz6Z3war5ZIax2qHm+2zlAaGz8tHRT1c0x+uR2aGGkNzkGSZcJES92dd14Rh8
         j8rxITC7s3vPwhd615rmxNL/4jlDzEnGHbd+OK7Ce6ZmrB9iANrxhV6cr7RUruFtRFlw
         JFIpb+yI+sQXOTOR+wN+Ua1UC5xrBc3Q4HjVBLzDi5HdlYCMOwi84FpwaCAgmY9SWOpu
         PlpA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6mE1P4lCm0xQIu/6UlTtiD712oqeCk7OPTV0CI6GLv6RaCWHojB3ewpiUbrbaar+SeBO2uxGq9L5daxLW76gm9do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+R2Xji3K1IuevdfwaP91EVdUm0vIzdJjKddYCnNWIGtCOi+g
	pk8hHQ9bdIOmtgEctmaVPjfB8Q89p8vr0p2ZXQnjzRLKTSQoCH16w238E3wotQ==
X-Gm-Gg: AR+sD12iLadqWF5HglVA0wTIoXqxpqEyaI8s6/I8A5QJpRa2tplMeaIDNZcMHyKmjwa
	Ce0/ZHUYpgufIHm5gDk196kM+Wos2vNvmiVCYRZuRQ7j5RQlxmqnlngFQYH7sTYK04wvdFQMmos
	ysWETjEu9F7JHCYFsBm/YBPhYXKR625NmGGvSNlKJx72QpiZ65frTKMzadvYtYrowllage3Qw39
	D3qMtZVo1/8+PzGVp0LhkQY29Pl7vnMWvk36x4yeiMdgkXnHDo/ZVMmJTNwUOf4S1i6wAxeK88U
	lD4rj91wlCS84/b0UVtYjlnKv0RTCjh+ws2Cb6537GWZUE7nvEONUvqme5mqdGkjFM2Wf+AITJo
	KD129/WUlEhTiaXYH0pJ+Xv3OayC1gpIX66r39V72ZD+L0/GHJWIEKuPCidKO/Fd0mdb+Hjk8IA
	TG0vPmSpE5ysaHa5jDsrjc4frK4N0b+e0NMwbzR36ZhjvdXwjfCTqec9fXDi5H3utUDU8CV075
X-Received: by 2002:a05:6000:4285:b0:47f:6d2a:7c9f with SMTP id ffacd0b85a97d-47f90261057mr4801585f8f.17.1784826136510;
        Thu, 23 Jul 2026 10:02:16 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63bd3sm16065216f8f.27.2026.07.23.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:02:15 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] tracing: Restore synchronize_rcu() before freeing trigger private data
Date: Thu, 23 Jul 2026 18:02:12 +0100
Message-ID: <20260723170212.55325-1-devnexen@gmail.com>
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
the synchronize_rcu() the trigger .free callbacks used to get implicitly and
inline from trigger_data_free().

event_hist_trigger_free(), event_hist_trigger_named_free() and
event_enable_trigger_free() free their satellite data (hist_data, cmd_ops,
enable_data) right after trigger_data_free() returns. With the synchronize
now deferred to the kthread, a concurrent tracepoint handler can still reach
that data through the list_del_rcu()'d trigger, causing a use-after-free.

The teardown must also stay synchronous for correctness: the histogram
cleanup (remove_hist_vars(), unregister_field_var_hists()) has to detach a
synthetic event from the histogram before the trigger-removal write returns.
Deferring it lets a following command race in and fail the synthetic-event
removal with -EBUSY, as caught by
tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc.

Call synchronize_rcu() directly before freeing the satellite data instead.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events_hist.c    | 3 +++
 kernel/trace/trace_events_trigger.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82ce492ab268..ddd2f70dac4f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6349,6 +6349,8 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 
 		trigger_data_free(data);
 
+		synchronize_rcu();
+
 		remove_hist_vars(hist_data);
 
 		unregister_field_var_hists(hist_data);
@@ -6388,6 +6390,7 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
 		del_named_trigger(data);
 		trigger_data_free(data);
+		synchronize_rcu();
 		kfree(cmd_ops);
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..c3f54f2540b6 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1730,6 +1730,7 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 		trace_event_enable_disable(enable_data->file, 0, 1);
 		trace_event_put_ref(enable_data->file->event_call);
 		trigger_data_free(data);
+		synchronize_rcu();
 		kfree(enable_data);
 	}
 }
-- 
2.53.0

