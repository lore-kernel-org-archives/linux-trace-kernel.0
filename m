Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6B47FB03
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551248; cv=none; b=DTDVTubSJsR3DoAR2bVAGVPEeCScmcylghF2HVZ89Bf4EFhSugEDc96p62QKPpYmNqLQaZANu/zKt+dC3Q1TOxsHktolOY+/T7liuUmDx9ILR14tk6WpeYcCRkhILKNAbhkulJK0mXFgydbnTc3mHIF1VI0JvdT8XUqlalCzH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551248; c=relaxed/simple;
	bh=ogKVkojYhIgKo43aQZCA93Ay/iBAXTOBSm+XGGonPWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tyBuz//BgBLxRwwYOcGMGLJxJRGbjhUN+527wqVR33YGdGoBNCcAye+Ak/5J7UuyDLrU2dv3eULg/A09n23irlAWOOhTH1Ur6vBWiI1s9EqqjtbIG+KJK3qsKv2+qj/N+2jDisMQoulTn1PLRgz5RRHJctrUcEO0hcT6dOHvYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2nYXHPb; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2nYXHPb"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49955a9dbcdso7165285e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551245; x=1787156045; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJOSwOXHKUDqnuUug/nFET9BDR+g78Qi6YXpVdn7CdU=;
        b=l2nYXHPbrJ+Hnwi9udPWT9YBEG27j1YvLL3fuSclkYuUdBsxmnD0avI+Ak8123jtTi
         mbDKdV3JbiDXRKXFTGNyxBIyyVju9WgYPJo1y3c8NNdYih7fPDmDa4CLj2P5UOnxxVIS
         zr6xqqIn9W3JMm/F8eCc6Jbd5gPZYI9WRNJsVOkKLkDV2fbKZU6aAJRAbUZksnMzr0+B
         uQ6c/C+vnwUtp3sCpmnPTFHm4MYdVYeb89uiPUJ+RdaJSVRwm3VxmewpMM+Jq3ucdGPu
         5s+D6Ht+S+53gN0qgfj8NkiBm2+tAG7BBoCvJ8Vn0C0shH2UXjAuXer1BXYmeqWrBjQg
         nVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551245; x=1787156045;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJOSwOXHKUDqnuUug/nFET9BDR+g78Qi6YXpVdn7CdU=;
        b=BsSnWG9ZNPuGCtfys0kksb5jaFAG5KV867WLHDo9FkR62YrNg4BzeYKtusEin1I4z+
         G28NJLdwKG+ek3Bjd0kOFP9ev/NzuHyj5yBVTdrgi18RqCUVj81QKfHjCXIunH5I/uh3
         5seNxbUf6cps9oRgN0vA1pYzNN3rOhGo+ewKzAoO9NmgbVPKxiLZ5T9rDACw8fAocqiQ
         SM9M8A4AycQfe9hdJlQc/scO3o9t5DXGDXf2T37jtX+YC54XV0pwdFd+KXH3F+Avhk7e
         vJW30j7xjZWYwQKGP8mG7daIu8kn2s2ibrTBjQp5sd4teK0A3eR3yUeZt7mW2dLiA06W
         5Yvw==
X-Forwarded-Encrypted: i=1; AHgh+RryrZuikkCXY2t9I7qdGdsCg4WCvQxYxUuvVZ88CRSLS2llMZR0993lRz6NNFZEeJU7oSAdZjunfNQMKefChbCLITw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxWa43V0O1L2r2R/o25xL0wm8p+zDMnU81/jyN+rwoPz6x33S
	bBYf0s3n1/GD+wCm/qmJUxbnjVf/aQrAd6M42F21qnd1+4XitP5ei4xrezwx3puaAgyNY3LY114
	RKzjAlSNYNM9k+G8xxco+/A==
X-Received: from wmap7.prod.google.com ([2002:a7b:cc87:0:b0:495:443b:34da])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c490:b0:499:5b04:6920 with SMTP id 5b1f17b1804b1-4997c126712mr80031445e9.16.1786551244500;
 Wed, 12 Aug 2026 09:14:04 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:40 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-19-vdonnefort@google.com>
Subject: [PATCH v5 18/18] Documentation/kernel-parameters: Add trace_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The trace_remote parameter allows configuring a trace remote on
registration. The syntax is similar to trace_instance.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3d35270dddef..c8470050b285 100644
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
2.55.0.691.gc56d675ccc-goog

