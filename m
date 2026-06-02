Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D9C3FD973
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420337; cv=none; b=U0u/x3DPxbWqETrJk7JhoHjuJwmyz0D2PI4grEU4R0fX5xc1sBPQyrykU+MjDx42eGfy8DXiTfwyBCHWUfwh1MSu7h+mbskLyY/O90GK/P1VQ94dt9tOO7FkkkBGjXImII+RgOh0CyMudgqoc31a4zQAP9N8wwQcG2iuROx0/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420337; c=relaxed/simple;
	bh=9QG8dr6B5avX0mj1sNw/ep/RDIKs03Isj4Lju8RZrkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b3yWp/sPcCTOpyd1H8S262VUNFG1xE9yD8pw3MkoETBOQdyPrJZb29/iMtpxtfTvqHErQxXRtMZFZsLymopFylqBsdPggQak5DBWau8fwyoAD7LCuP8RYc41UcZKie6w16NYRmMUxLn09ousIURKTlq3pF1kXV6Qcd+wfLIRH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXRj9Xu0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXRj9Xu0"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490b56bf7bcso560845e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420334; x=1781025134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1Ny/hU9ozIm4PHWDrZFtxdpDjcv/iM2Anxrw8bO+6I=;
        b=EXRj9Xu0DiXsbGuNKPcLysYE73sAVUVBY/xs1txzFDXMKfNpkha4/UN1Z+QOz6uUYI
         i+cb0I9YCHHX0i1uA+cB7tUq4DDROVub+yencbfNCrWwaEv+yEK1i18G6HW2yO5ksUUj
         y8fPZChBj7Lo7gWmy2hFzLh1dNJpgZ4KLckoK4CnAXnljgd1hjvmjAY8TDpSU4cs2+qd
         JmUOrKEFeIT9WFi2sB+HP5PsVZFnzNfamPEJqSh5NQ8IS6ir22uy7kRaFX/QNq06ZRDf
         c9hhYCHzppygb0ywrF/KVHW2ZXO0cGOlcICv+nW+lBZfwwk2y+d3bZpSDDZxBlroSprb
         IyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420334; x=1781025134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1Ny/hU9ozIm4PHWDrZFtxdpDjcv/iM2Anxrw8bO+6I=;
        b=nM6b+aU2CAkIw/DQhFCoBj4tvD6bVn1URI35ALLQzc/SXO44pIhMzQs7I+AED5BzKT
         kmD+FAIcS3ukov895Mq20sqqmOs4d8u/bbLptY6F79M7G/vyHj+OSZY7FVZWZT3rS1zI
         lLkV/FBc7DOr+d4+pjmFySZgY8Qt5TzKBNzFkpIAovewcdp++lRZtSM0UNuIxRc4PqBU
         EIhqw+tGNt2aO6KD/F1u1jXyYaWyFpcHwoqpN/mm5uTVAzlhSxEzt+/ZO5ZgAOLFL/bh
         pVLSGdcYQjA+XXPLgkJVRGen8Eb/YUbgXYSKXnsu59vOlfdE6wJBtZbmEwlt70HouCyI
         9sUA==
X-Forwarded-Encrypted: i=1; AFNElJ8MDFFBd9HqYJOyTxrcfR9i2bPzK1VyC6Bbw9BGnpnsQ58SIEalPZbL0fLKw5ADeV/dCmR1++QLYKf0r57kOpjaUHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFroBC8p17cQDd5yvhTJNP2TS2xsFHzoFaW5zV+aSlCfOBoUG0
	qaw+nAQ80QhW6UgTBwpm7RS6tiot9VB0vXZ7/STZjawtReYe1ha7v8hHQWPG0ja8g2VdXmz4fuv
	xHQOu3OO5JYJyxobaZQ1jTw==
X-Received: from wmbhb6.prod.google.com ([2002:a05:600c:8686:b0:48f:f71f:26fa])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b19:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490b506cd39mr10452265e9.12.1780420333761;
 Tue, 02 Jun 2026 10:12:13 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:45 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-14-vdonnefort@google.com>
Subject: [PATCH 13/13] Documentation/kernel-parameters: Add trace_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The trace_remote parameter allows to configure a trace remote on
registration. The syntax is similar to trace_instance.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 97007f4f69d4..dec8fd1f5ff9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7792,6 +7792,22 @@ Kernel parameters
 			See also Documentation/trace/ftrace.rst "trace options"
 			section.
 
+	trace_remote=[remote-info]
+			[FTRACE] Configure a trace remote instance at boot.
+			Format: <name>[^option1[^option2...]][,event1[,event2...]]
+
+			Supported options:
+			  dump_on_oops - Enable panic load to dump the trace
+			                 buffer on oops/panic.
+			  printk       - Redirect tracing output to printk.
+			  buf_size=<size> - Set trace buffer size (e.g. 2M).
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
2.54.0.1032.g2f8565e1d1-goog

