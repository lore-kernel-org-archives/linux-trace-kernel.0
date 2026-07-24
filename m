Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095637F337
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784875348; cv=none; b=I/Es4Z8oPlFQkMZ8NlBK8xgqQS1VNhbYoZtCrEcDisfKQtOl1D6jma6kTCbl5k2wYjWDirrW4YJXIbYH7dRazqdSec19v+x4GdNoGaFrNr/tzMRjZtBTAnFgftU9Hbcid/uaEKg68jz6YqRwyFZrTNnZoRPDwWCPUriXI53gqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784875348; c=relaxed/simple;
	bh=UYfnAVkJYqrCgRSzVomRRD9UqZf21Lsk6dNux6uNhHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flYInVPZ7hBLbw7v+AyB254jF4vLWxcFixlQWL6vfsYD7JJ5P+UcvUBuiK44OuE+og43+0jdjb6x1VHYraLJTtiHwJ68+8xHgP5tS3abJfL2ABywtD9ixaW0OWr14UnRAKZfd8Z5O0WOA0uylznWO7vKK2VSTFxeFS441u1EZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGESawy5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGESawy5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so55001b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784875346; x=1785480146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3jI/otvSm+1a57vqHZ9bhuvtuCSbIaM8PvVKGIua6t8=;
        b=GGESawy5hAJ+3Xcl6UzYqF2Z52pmqvAQe6obk7kR9j7TDLwBqT4Q2BzyqfxoBG8nVS
         uvP5SM5SRzuPlf1RvT8UJC8poJisgbu8qTqYPIxgQGXq0Vjs+rDrw+bVVFIAActZcUcP
         WB/rS4BhtZmQ+Av21i62/4QZ2ZHLdJ76yV9/HQFVl43BbJ0irRQjkP9/M643Dxcv0Mhc
         PexzvqjSr7LxBvap91qpNw48z8MMhaER8cbjmOAymS5RVdFXhXwERVekWAVzANQgFR8B
         LcNUDMqMW98PJKvKXK0s6eOopqmTMGJmm7LFqX57pG8208Ko9tCmTmhJ7180qJRCBIdC
         sRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784875346; x=1785480146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jI/otvSm+1a57vqHZ9bhuvtuCSbIaM8PvVKGIua6t8=;
        b=OryQ3gdD/yMSAVElFtHeoNb15rda93WuclrxG9xB20XzWwKV83StCCj1lXlxbHhm+/
         uDDtv4hJxZqS73wMxgXSCRjcopzSe7+1chrmAgHyoWZoBl9O9YSUiZJB5tVipG1/r1i9
         b6zpER9eMP2pm7jfg8se6aQovXmrRvHfOUpjrhFhEq2/+fOuBEqLuiUEX+g4AJAOK0+H
         GK/jATth/nm88L/B/xOJxpVenuVZW9xhU/EVY6CQfqvMWO3CQUoFtb8/cm/1PrpvNGH7
         7WyOWRDCRuFSHT2yi0GWeEOjZ7/6pTpSR4n4etRQw8a66ZpGZ9zO5SmOgOYhuJreO0tn
         kclg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0or87PJTsrnzyt0XmWpiRvY3L8SI6CpVzoqfM51DXE91OPwz7v2+CL+gsqteVtlg2jPpjbcZ9kXZJS0tWMe3RVsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+UCHnWv2XF1w1Ap80ORHl3F+88A37XkW/MWysrTn6rnWv+nks
	KnVI9liN8UpXdYg3qx1FX2ADx0oKF8/hAuiva7CeCVUaRNotkknukVGi
X-Gm-Gg: AR+sD13l/OikkPx4Z++5MQzrJ+j1GUx0wN9EEiNhlz5ERdp8gtAHuQaUs5uUqy+Jvcq
	qvGfsvUzfNLd8HHnVkfayQKCJ1e54HQKEzAGhfU+Qpd8QScsRcWPRpcKjTVX4VWKzyVNYS7jS1K
	NzLTMDQAwzHvXxZCS7NX21T/HQb4Ue0/0lMFBhCPQz7zi9YA9jAuKy0f6MuMXseEeexyVAdQ1va
	c8SvPomCBzavbPpnbdMFwHfTr8mnJz4V0YT2xsF9d5gyBbBo3VxYvpZMUPXqHvbhN2P939LvkVc
	W4srl69O7qgW73DmC73WFD1k+5UnCkn8oxQxwtjYUzqfawrTArlL0Go7xpyoJSvceCyBqu1MmdZ
	YKM1Z/5m7Z0Zkjx/J25SkrFMofDC1ACazTi0aYJSUg69PDvEZxa9WmSGx3QiHGDeUbiohK049QP
	MJL7fLX4/yfPmBuQ==
X-Received: by 2002:a05:6a20:a126:b0:3c2:dcdd:a85a with SMTP id adf61e73a8af0-3c44afcd25emr7057739637.13.1784875346272;
        Thu, 23 Jul 2026 23:42:26 -0700 (PDT)
Received: from lenovo-thinkbook.lan ([1.22.231.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e081985sm27783326eec.23.2026.07.23.23.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:42:25 -0700 (PDT)
From: Raushan Patel <raushan.jhon@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raushan Patel <raushan.jhon@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/fprobe: Roll back on enable_trace_fprobe() failure
Date: Fri, 24 Jul 2026 12:12:08 +0530
Message-ID: <20260724064208.480030-1-raushan.jhon@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

enable_trace_fprobe() sets the file link or the TP_FLAG_PROFILE flag and
then registers each trace_fprobe in the probe list. If
__register_trace_fprobe() fails partway through, the function returns
immediately without unregistering the trace_fprobes it already registered
or undoing the file link / flag it set, leaving the event half-enabled and
leaking the registered fprobe(s).

enable_trace_kprobe() already handles this with a rollback path. Do the
same for fprobe: on failure, unregister all probes and clear the file link
or profile flag.

Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Cc: stable@vger.kernel.org
Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
---
 kernel/trace/trace_fprobe.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9f5f08c0e7c2..3120403a5b60 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1481,11 +1481,21 @@ static int enable_trace_fprobe(struct trace_event_call *call,
 		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
 			ret = __register_trace_fprobe(tf);
 			if (ret < 0)
-				return ret;
+				goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	/* Failed to enable one of them. Roll back all */
+	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list)
+		__unregister_trace_fprobe(tf);
+	if (file)
+		trace_probe_remove_file(tp, file);
+	else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	return ret;
 }
 
 /*
-- 
2.53.0

