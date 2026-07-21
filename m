Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323424DB57E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630203; cv=none; b=X4Y8R9CeB8cQZYnk/LGpJ+I0T0QoPyIiRRQ8TwA4xbjVE83zVJ0Cr1Hgg9jTzv7LHOBxsNH8TgPrkHLixkcen7/JLZ/EpBamCPCYiyn7gyYGfv/X+ztab7+o9SfBq1JWwRwVHnG/+AcW22eRwnaMmHObHM0i9VTO9aXe4GBv6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630203; c=relaxed/simple;
	bh=eA6Qy+sdcdbt1yqsJmW3GqccU8sgZV8IhdCmsKPtqyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L8K7J7WrJoVEqlHF0nB31WQlbiBYSwD1GyL9W65wuOPkRrUNUnt+67Q2rtZ+5wBoSRA1fHlXQKr5hNmDlg/ypL8NHLJ1hrxdIAbGhi2ZsugBoaanP1P6iLZRYONU9JnfzyDeFx73NlQOQPh/l5GykrprD782cBBqRqYD0ox+yzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rwp97XSw; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rwp97XSw"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so22180325e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630200; x=1785235000; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FamuukPByn0t1SdhoLjs7EATo/wwbRBUgdZJ9f7MnOM=;
        b=Rwp97XSwY4AISfe4MGaaqhNQxJxDsxQw5MztRxiBhKab0muBWs3bfTUbtg4rQ7Kwb/
         cCFkCAd14bX/WyKqICOGjqA25FiUwtNWTe+/a2KAro67Ou63Z7f5+iyzt4HGC39v28iZ
         KcdBMoNDptZ+XAFmFr0x0rrHIm4aVMHQ5JXhLlN6vgnaZYAzZTcJ8Unm62HO8to2rtTM
         eXIijF///rlWSrI3xGF60XxudcFDraGaj097h8d0He9EnOPIyGxzf8IOoq3dWCHwyqok
         r+vMV/TkUV2fLFZ6wq4GGRZbrlKjagYJi7CHB1xdtoUDHYlXNiirNu2zSuDpYXQUdQq7
         dBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630200; x=1785235000;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FamuukPByn0t1SdhoLjs7EATo/wwbRBUgdZJ9f7MnOM=;
        b=YIekmng8XsxvcVoZh+t3LwzCOefv7GiBMgAEE3aJ5MQxfnBbRjPSDGFHETJzLk+Yj5
         z8QgnMCKHiu6uMgbsKdj4rc8UGLDpXLiH1WtvlDjxD+xTXFgYvoQFTOElBqt8RBA9yOw
         dklAMVo4SuB24mrbApy4iovCJwN1aIyGHlzaEF8HGrbeCbCUOdNSmwugCWfl9bk9F8JY
         ks2RvA+yrm59T3VDmL5Ed063RqpImt7BTcYrjXxA9DFn2xkdGnUNQfR5BEfDgcU5w6qb
         di1MIYnwu7UZUIAAq0XOG4TGArIRC0LefrUkwh0hXG3gBJeDElZ5en4KeJDIy1LCiv2Q
         bdtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrq4gcN8pa48XXp81I2Wgz10jAN/8IibsKuLQsv1bPMOwbtTxZAHku77wf1C/wX/ePVxLyV0f7DpVjqbvYRSzLF9pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDahcPn5zrxDfzlkl5qAyJEX4Lj5q5kt2gAy0vrss/dAvf69q
	Vkf4nHpCJDNQMO6AAOZtgsTdlekf+2bBMr8bbUpE+PC7CmeMKvhwvLUQ3jNB1Gljkv7Injnn2bh
	H+/5FSI3ZWWlUexyv8I5NBw==
X-Received: from wmbf14.prod.google.com ([2002:a05:600c:594e:b0:495:4837:275e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a42:b0:493:eed4:7210 with SMTP id 5b1f17b1804b1-4954a3ef700mr203825625e9.11.1784630200166;
 Tue, 21 Jul 2026 03:36:40 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:36:03 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-19-vdonnefort@google.com>
Subject: [PATCH v3 18/18] Documentation/kernel-parameters: Add trace_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The trace_remote parameter allows configuring e a trace remote on
registration. The syntax is similar to trace_instance.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..3c1cf3025925 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7787,6 +7787,25 @@ Kernel parameters
 			See also Documentation/trace/ftrace.rst "trace options"
 			section.
 
+	trace_remote=[remote-info]
+			[FTRACE] Configure a trace remote instance at boot.
+			Format: <name>[^option1[^option2...]][,event1[,event2...]]
+
+			Supported options:
+
+			dump_on_panic   - Enable dumping the trace buffer on
+					  panic.
+			dmesg           - Redirect tracing output to dmesg.
+			buf_size=<size> - Set the trace buffer size (e.g. 2M).
+			poll=<ms>       - Set the trace remote polling interval
+					  in milliseconds.
+
+			Events are a comma-separated list of events to enable.
+			If events are specified, tracing is automatically enabled.
+
+			Multiple remotes can be configured by specifying this
+			parameter multiple times.
+
 	trace_trigger=[trigger-list]
 			[FTRACE] Add an event trigger on specific events.
 			Set a trigger on top of a specific event, with an optional
-- 
2.55.0.229.g6434b31f56-goog

