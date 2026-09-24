Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9764A2A47
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261932; cv=none; b=LFguCIaUkRRFutBclNgxtTseQadcxFNAvj7T+H/KBC5tFRkvCMP67Om/wGshGWRX6Xib6X8UfzkVS20Qq717e3tSHoUR5RlB64fccZ1qGky/zdXGZ+3fWFdRJQgWkdzF3L7O0GgFR+T2VR1NsPRKIlgn6Oy1c07QVDQtouOsiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261932; c=relaxed/simple;
	bh=sMZVeVn0ZsaC75Ss0oixACQGBD0RScWRyElS7yqU6Fo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3sSCF9kH/ArzgGqyEoqfn348SJqCNadYv0Y7XH8vuzIj00tYVirHm0FCjW6cOI3Jv9jkP7GUlluofxLCM5O2eLJHCI6gHOgfdqs3/+oj5wHeQJmdFH+90W28b9GL5ti87jNtXlSrn1iFbARVqci29IUrozHZ3VixLLvFkZb9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bGxw2E+C; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGxw2E+C"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd55ee2f7so17074825e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261927; x=1790866727; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOlgtvFIgZLsG8Gc5kS/gNU5ZmWQiSJ6dcHFxVQsvJs=;
        b=bGxw2E+CfGIiKO3zgfZIG16nUukAxIN2Wx21doGPSfuwABoYC5jz4HMoxe8dUCnWN7
         vZxxDyHHxnN8PallVtHow9i8mLynUiBndpU7PGlLCYSYjYa4I+Ozq0A17nT8AwyprSPc
         SSdFBYngRttz8kfTxQ+MwM3SRaopVAqUiei4Z9gbzA3ylwQtkSeSun9uu2GeX4wNLUyp
         QjJGu+4EOovpCysElPnl/0P/wxJHEeb3EZxLlnIjShmc6R0715nNMRu8AhXieyGbwuJ1
         onoqY3uiQH0ikD+1nH2B5HGt1OZ2t8p3gimMt02T5hZegSFONgx9tId+EwzRKxwxCMe2
         5Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261927; x=1790866727;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOlgtvFIgZLsG8Gc5kS/gNU5ZmWQiSJ6dcHFxVQsvJs=;
        b=EeNWlOIDkGuDWNhNDRDFYPN0aXMfQGrhEZyl4LC2ArwBZs6RTqWshTbsFjcr/Kfq44
         ORL58cFVAd0WwOFt6Csrt8pcqxz5klZqzcFl8OpccPkRPiZuyiZmNaTkEoDUjVNXe8/h
         b0aacj5KigLcTNyrdrd1od4434AU62YzVL/R/0rjg2wXqPcplZpA0WyVwwM4FwImqmn8
         wlQ5sa2hNLxte8hTg3KFmBxttw9LOaCKoRJtApYj7N63LOvD5Cfy2fGykrj0JdyiS9a9
         pWPLPXNiHd9kVsPEcDvNyZLZpdZC0eyYc+BfAH0dHBmpBHzo1XLYATvvzyj0IJDPWJuw
         DlAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhWMCPfMJjrRDfvNfljZslprmHNbyNpcZN4fzlm8somorIgvaVhGKBCxkBLYtKbpr0KnwIgxYW2GG2PGwVT8tcBmQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ll9z8uD2jeC9Vs7TaRXD3rFCjE+Sik3V7te01RGErWGg1pQwyp
	HjpzRzNJH83Jz/WOZqClDoATsDO6i2a/10bG6Ax3nZDshceNKvY9b6eBobemPkcSAMspap+UnPo
	eAyloPe8NC/b1HTvEkm4yRw==
X-Received: from wmpb24.prod.google.com ([2002:a05:600c:4a98:b0:49f:e303:ee0c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154f:b0:49c:fa21:1c86 with SMTP id 5b1f17b1804b1-49fe7bbaf51mr38477895e9.27.1790261926538;
 Thu, 24 Sep 2026 07:58:46 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:54 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-21-vdonnefort@google.com>
Subject: [PATCH v7 20/20] Documentation/kernel-parameters: Add trace_remote
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
index 33cd30996e47..613941ea31c9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7824,6 +7824,25 @@ Kernel parameters
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
2.56.0.rc1.310.g51773c2048-goog

