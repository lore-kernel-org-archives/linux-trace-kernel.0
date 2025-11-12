Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD133B6C7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961149; cv=none; b=SFh+tzKj2auEhE0fBgFfolrpPfEPjxIKTHTFT856HlRBtWAT9KW7CoekLU2+dQFBQzGWLSJHgmCjqmDbXxWcvvSYooPcKwAd0Td28CpQeZWRx7nOIptIkwZjGhqlr0DUk/ysMs5H2FXml/YlUvIva3yWGwu1RVan7t+9MYvhoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961149; c=relaxed/simple;
	bh=JtKQWh0ClQhnCa6a9CttDFqReLVgSjJ1b2Sq6WnlD/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=F5TUYyvgdEG4a03Ok9ByBogDVEvkQ1nw77wNfiAiQll7b1usq+2niBqp7YtIukmJYmaojr3JOOJs8/U+A6VwsgiaZAgciZ1G8kQL2/ByvCvUQ1ohdx8MLTaQtyYNx2LpTozJVHLV0jDYH2oIoe/J9k4z7TVvOP0srvv4p5Pz+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3dWm44s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3dWm44s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762961146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBeXc/jUiS32bF6EMPDLq5luB2lQMpBneNEdYf3tY0o=;
	b=M3dWm44sX9ycq5NyC7lpKVpo2AdU9QdfUJOCrZCw1XZy1XAP24VDbf8CVMFFUh2Ap2Kh8g
	Pz7EMNpM87S2eouJqLYMHlfD6LCbc6vagPKrVIEOIK8A51NQitXGOY6fxQakh6cbxj/ZK6
	OhwRQht8QQreax+WioAE0Pv1NyaRZbw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-tlzjO1vUPKOg9QnycYLr9w-1; Wed, 12 Nov 2025 10:25:45 -0500
X-MC-Unique: tlzjO1vUPKOg9QnycYLr9w-1
X-Mimecast-MFC-AGG-ID: tlzjO1vUPKOg9QnycYLr9w_1762961144
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43335646758so9608555ab.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961144; x=1763565944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBeXc/jUiS32bF6EMPDLq5luB2lQMpBneNEdYf3tY0o=;
        b=J3236iSUrDKE8DrZW/LRrfkb/G4e6C8oM4WBj30VU/u/LcqGIBQOdvMjK0kbY/KyWI
         ElpELx9+2p1wdtbssEAsmuqnlbqBcTZ13bNG3nysdgy+8cGX/ZP4h4gLi3J51yj5G1IH
         2HPkhVJX8TUAJm9oD5BcYCHGzDMHQm6oAmJMmPZpbWrI1aG+MRpUjq+nZaDnQVgznzou
         ZxoZBW72VO8FpH+gOcgWmHWjlse+PISBimWQgtc5WsuqMVDpDcdqyLR5+RbfMnkhypWX
         1p2fd3ZUSwFOyfSx26cFh59//YVNZJEjKLISU66I8fDFSVRcmRhhwiUSTTPnagoquVMy
         9JBw==
X-Gm-Message-State: AOJu0YxsX6WJl9t9S4naLg/Mu+6gCBMWpQJesQEUQOg53iR4DAXCWXK+
	4ExVBZFsZKqZ1FZg0x1yRM0r9bOns41r8dOpYlskTodPSLIYptiWfrvWUfZhwun8HMCJG/G0EyQ
	aHuQyml3zjE0bdLu+aMwScMkdw2/WZITRH4eQgO501nkw7PYrJz/8/UlyltL7MCCb0W7giNFUyg
	==
X-Gm-Gg: ASbGncvsvtzFubGFtMg7KMoDWsiLBVqYOx0S1aIcexDxHetewtu2L7ikuRvL7bKkimN
	Q5pv5b6W8VC954RQ3l+wVpPb5LaGae1E7URKuspZa+zb46pNM1mtDVfKdR+CE7TkoBwbcnFL07B
	6E0f1x8sBzxZ8WlP+G3ketzrDQHTyr1QfluLbm/tFkhK2OV8VGCZeG5HgTjjFw1GE69JB83vE6u
	HsTJj2bQdnwlwgz713F3SNM7E0HtERQwdsUzN1/zR5orz59KbeDMonUW2lmn2IbjV7wmSfJRkC4
	AuOQay04HRpFZjuDr1/CPB0mvhwzMyJd7x3pVPrI9qfNqUaImTHMAj5jLOLcLOqxoDxxVECxwI0
	dwZGxqRcSHPyPkRvqQH8/Isu++3k2asA=
X-Received: by 2002:a05:6e02:214e:b0:433:2dbd:e93c with SMTP id e9e14a558f8ab-43473d3dde2mr43072655ab.4.1762961144094;
        Wed, 12 Nov 2025 07:25:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSBN0m/nTGPxpEnpq5RsCZkcfu3sXnkjF9/cO16SdhTUFdtRRWcXNyiXvh0rgmPb30RQSPTg==
X-Received: by 2002:a05:6e02:214e:b0:433:2dbd:e93c with SMTP id e9e14a558f8ab-43473d3dde2mr43072375ab.4.1762961143735;
        Wed, 12 Nov 2025 07:25:43 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347327f820sm11680325ab.0.2025.11.12.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:25:43 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 5/5] rtla: Set stop threshold after all instances are enabled
Date: Wed, 12 Nov 2025 09:25:29 -0600
Message-ID: <20251112152529.956778-6-crwood@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112152529.956778-1-crwood@redhat.com>
References: <20251112152529.956778-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U7JbWRou5GDH88P5ymQCSt3HhWr4vZL18Lj1S1A90wc_1762961144
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This avoids startup races where one of the instances hit a threshold
before all instances were enabled, and thus tracing stops without
the relevant event.  In particular, this is not uncommon with the
tests that set a very tight threshold and then complain if there's
no analysis.

This also ensures that we don't stop tracing during a warmup.

The downside is a small chance of having an event over the threshold
early in the output, without stopping on it, which could cause user
confusion.  This should be less likely if the warmup feature is used, but
that doesn't eliminate the race window, just the odds of an unusual spike
right at that moment.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/src/common.c   | 20 ++++++++++++++++++++
 tools/tracing/rtla/src/common.h   |  4 ++++
 tools/tracing/rtla/src/osnoise.c  | 17 ++++-------------
 tools/tracing/rtla/src/osnoise.h  |  5 -----
 tools/tracing/rtla/src/timerlat.c | 29 ++++++++++-------------------
 5 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index b197037fc58b..46e0263d6ae8 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -348,3 +348,23 @@ int hist_main_loop(struct osnoise_tool *tool)
 
 	return retval;
 }
+
+int osn_set_stop(struct osnoise_tool *tool)
+{
+	struct common_params *params = tool->params;
+	int retval;
+
+	retval = osnoise_set_stop_us(tool->context, params->stop_us);
+	if (retval) {
+		err_msg("Failed to set stop us\n");
+		return retval;
+	}
+
+	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+	if (retval) {
+		err_msg("Failed to set stop total us\n");
+		return retval;
+	}
+
+	return 0;
+}
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 355f113a14a3..64004a030a56 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -148,7 +148,11 @@ void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(const char *tracer);
 bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
+int osnoise_set_stop_us(struct osnoise_context *context, long long stop_us);
+int osnoise_set_stop_total_us(struct osnoise_context *context,
+			      long long stop_total_us);
 
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
 int hist_main_loop(struct osnoise_tool *tool);
+int osn_set_stop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 312c511fa004..945eb61efc46 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1128,18 +1128,6 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		goto out_err;
 	}
 
-	retval = osnoise_set_stop_us(tool->context, params->common.stop_us);
-	if (retval) {
-		err_msg("Failed to set stop us\n");
-		goto out_err;
-	}
-
-	retval = osnoise_set_stop_total_us(tool->context, params->common.stop_total_us);
-	if (retval) {
-		err_msg("Failed to set stop total us\n");
-		goto out_err;
-	}
-
 	retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
 	if (retval) {
 		err_msg("Failed to set tracing_thresh\n");
@@ -1184,9 +1172,12 @@ int osnoise_enable(struct osnoise_tool *tool)
 			debug_msg("Error cleaning up the buffer");
 			return retval;
 		}
-
 	}
 
+	retval = osn_set_stop(tool);
+	if (retval)
+		return retval;
+
 	return 0;
 }
 
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 895687030c0b..3c927c179b35 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -34,12 +34,7 @@ int osnoise_set_runtime_period(struct osnoise_context *context,
 			       unsigned long long period);
 void osnoise_restore_runtime_period(struct osnoise_context *context);
 
-int osnoise_set_stop_us(struct osnoise_context *context,
-			long long stop_us);
 void osnoise_restore_stop_us(struct osnoise_context *context);
-
-int osnoise_set_stop_total_us(struct osnoise_context *context,
-			      long long stop_total_us);
 void osnoise_restore_stop_total_us(struct osnoise_context *context);
 
 int osnoise_set_timerlat_period_us(struct osnoise_context *context,
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 19bab3d189f9..fe93cdc5354f 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -59,25 +59,6 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 			goto out_err;
 	}
 
-	if (params->mode != TRACING_MODE_BPF) {
-		/*
-		 * In tracefs and mixed mode, timerlat tracer handles stopping
-		 * on threshold
-		 */
-		retval = osnoise_set_stop_us(tool->context, params->common.stop_us);
-		if (retval) {
-			err_msg("Failed to set stop us\n");
-			goto out_err;
-		}
-
-		retval = osnoise_set_stop_total_us(tool->context, params->common.stop_total_us);
-		if (retval) {
-			err_msg("Failed to set stop total us\n");
-			goto out_err;
-		}
-	}
-
-
 	retval = osnoise_set_timerlat_period_us(tool->context,
 						params->timerlat_period_us ?
 						params->timerlat_period_us :
@@ -200,6 +181,16 @@ int timerlat_enable(struct osnoise_tool *tool)
 		}
 	}
 
+	/*
+	 * In tracefs and mixed mode, timerlat tracer handles stopping
+	 * on threshold
+	 */
+	if (params->mode != TRACING_MODE_BPF) {
+		retval = osn_set_stop(tool);
+		if (retval)
+			return retval;
+	}
+
 	return 0;
 }
 
-- 
2.48.1

