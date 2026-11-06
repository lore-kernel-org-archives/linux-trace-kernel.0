Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988488;
	b=zxOp9K7W2AeJnAtJWjyqu2nqVHMCu0dhreEmAxnGc7ZG2bbsYCYsUspr0IqxpNLLkJ3c
	 NiEiAN8UUzny/kgeb0QZoCtPbKeHYgoI3xzfEekghiWGAiDnGZ0G07ph8zDTnT6ZKift8
	 5kzoe4DoNzQkynDAzquW/DTGAliODpcU8QUz5IUOCWKBi4hrEwbr3txkXQF/uWDlGhi+l
	 WzIFbY3fvXc3kC4Y9kWSNwbvGapEEbcUmAIoj8Q9vpbAeugUWORjNrVwVbvlB15FLC1/A
	 WTpKJMEwg2S17Ll3eTajOX1LHhHJwbnIcVlZObbBvRUPAPx5+LKX7POSRb8YXK4PHeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+jXf5VIa4S1Z0Gmb+6hGuDOo/rmHYpFX4asd+dpjPrg=;
	b=YYJOOtTYyx9zP5efJzF8lQncbbyusRrnxyEVIWhbz1/rchUKa74QAV0ioP9iN4WdEGwb
	 EPR7WpUYN3a0orgKO7TJiafHHmA9HPsATTNhSaZbOzWTKuQLPUb7xe8VeioQgdtbpSwS6
	 y3fnnsIQh91IDYwipOd74gXq+zpAfgY2QrRKLZlnM0yTBUG2SvUD06PejHXCPg+z0tvYE
	 +Et/YntH+U9nghVHwHnaiQn/Ytw+yVTHZiEHGPkDjIiMiTaqKEMY9yz6nXMco1JgplBpA
	 +XAgAN79njcmM8Xb2MbjNia8ezm++x+Rd6lDEyV5fZZ90faxzIo8dhydtrDZPGep6CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hS05jrxU;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40667608362F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40667608362F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hS05jrxU
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1fa972b4fso5679595e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988487; x=1794593287; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jXf5VIa4S1Z0Gmb+6hGuDOo/rmHYpFX4asd+dpjPrg=;
        b=hS05jrxUXFLiRzDNOI/TMO0g3gfX5G9+cfxkwZ2JTxjAkK7kIBu32H6lFiaglxhuVQ
         6tgWlfA++3Ko26Q2v2akxN2jUMgQ0JPtYPP+7u3AZuDr5w0KN4NFupNP0i48359I0Bnk
         heT0UHF8mdhq1dCv8l9oBygOJPwtBbuSKeXuxO9z4iuRvCldumeSeqrz9GlM338xdDjh
         KubnZc/yiD3cjkzeLLChXeQxwkrmd46PvUn5eNxjeSXfNM0hSU5KL0CsIPEiQuQkSoWp
         X9QEtok0AuQvJsB24rbifMPZslmWcQCPtelzskIBj40cZ7XIM5KHWGQoiXY6NE+9VyUt
         +xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988487; x=1794593287;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jXf5VIa4S1Z0Gmb+6hGuDOo/rmHYpFX4asd+dpjPrg=;
        b=dqBz/svhFSVGqeUVWkH+19X5BSLeBuLz80LTwVvC0ZzzLf3vxjJQ8OlXvDc+gyiRww
         sYMwM4u2ktQ3EypJqgxxyCzrB7/Ne9Kyxg2QPsNYsw1QaU2HukQwkwZgacku4mQYa+m4
         BcZt/DqUKSRZRIZM9cXlEg+VcZGA4Yr9EfnNw+zBsZ+4CfN/NX1qT5HHEftK9MLyJoC+
         mh0+Qc3QX5fx0fQRJ+eBva05MfKU5FEHUT0DIQn/pw8/TIKiKhhENuCtmGDlmE8NJ3Ob
         QboBZmiow9xEJQ5iVt5PRw2VcIEf0l1vNz4aHXntEzBUmvO1JaQ75mLbBaLUHrnXpT+V
         jDFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrjRL4kV4S8yFaSJbMP/U/rqgaK5PT8NMLG52XOOlADrfm7wTXnWNg1MzFCqeLghT1nYAPUq1wC/HitpioyKPn9lM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PmXhHPNuxp+CRgajmcmcgUxO+BvtSmYlNzmDpWDlX8TaLyJPB
	F+iA4Ad+pKXQFAzAcjI2BSp445ngcmBPEa8R9l/yy2oHc2EyTv75cq0UcgBf3tQTd5LmsTpHSsH
	W0vwrC9uTUJ+d3PGGf3dLdw==
X-Received: from wmbid1.prod.google.com ([2002:a05:600c:a181:b0:4a2:df9b:ef74])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c16b:b0:4ab:c447:49df with SMTP id 5b1f17b1804b1-4b6df3fd1damr52611335e9.23.1793988486780;
 Fri, 06 Nov 2026 10:08:06 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:57 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-22-vdonnefort@google.com>
Subject: [PATCH v8 21/21] Documentation/kernel-parameters: Add trace_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The trace_remote parameter allows configuring a trace remote on
registration. The syntax is similar to trace_instance.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../admin-guide/kernel-parameters.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..ac93402605d5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7855,6 +7855,25 @@ Kernel parameters
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
2.56.0.455.g6c5a503b38-goog

