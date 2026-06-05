Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606F7404BCE
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677597; cv=none; b=C2uMSKLT00S0XKXQsKxAVnJrwzZDQzoGypxJYvM5aY5+MLUvYchTMteVshpJ09kCfMaJnG7ZvpM9Sk0lRtnZrYmju3aOVfEfp6VTglR/zfgmlHhUxMrDdE9BCYeKBJMW0PkYT1fY+CD9jV5gk5bKlZUa7Dn+ZP25c94rih7ic1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677597; c=relaxed/simple;
	bh=eOrEumGjKMx0i3DgRPVeWJxlMsBV/yi1yTHcGsQzQiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ToJC52EZ+Grgu2d+SZnFch2X3Mv88amjhegTqRXYSSG2fmg5unFM1Yhn/dTt7ORaX94y9IrWLXg2B1OSq2FmvtFSbPmCYD/rkU5ZbgIihhIo7DFhhY8W0J2Kt1PNCayc+pR0jKD+HVG8sdR78er3jyAoIVSeOf459gMNY54ZWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brtvruYZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brtvruYZ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so18791085e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677595; x=1781282395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ynset6waxOl7nqhz3l7iWnZFIYkZ9Ed91P7Vdc5ORo=;
        b=brtvruYZIG4PS4yx1Pd+wcg9aIXkqn1dBq0NCeAE8junxMOZe5aAUMxLBOHViYbEUd
         4I3VHLqESbmD6+W2IkAb/VON2z8IbuxOvnU/eK+n3Ps6X1hQ+c+s08rX46PP5wqBF+XE
         ih3W5dftFcw+snCXn7fFRMsV52dS+4GTP4S/AF7Vb5EQ1dE3DVwXzLRHNaI5h2BiRB6a
         hMa4TygrKso18up+crU121E7OuHSbnp6kYIlHjxx2Q9FdVmIeSmaNq19q3GMy2hUOQLn
         alEm3J5oDsGk2FDKl7dY/Q2W1HFyPeHUIvenfojHVPh3F2ShVB6rftlQtobxpYl/Duxg
         +hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677595; x=1781282395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ynset6waxOl7nqhz3l7iWnZFIYkZ9Ed91P7Vdc5ORo=;
        b=F+8EycmiNZKWjhKJP1jmW62saY3BkkSoDsyr/fvuu/Wk2adJ4hNRgeEDkxaNwfzvTf
         uU3xzfDhD69way274nn7ugmXR2ayaHy6unFh3aPbMp2BpphHGtnierEJr9CapchmIH2I
         KSstREHcQ1O4OYj65UlaQKN3d7c8aHkzUv0ABnX+RaW0I1hDvuzxu0TtBglMiRW09c6Z
         F4r7UmvNPUpA8eBml/s7cWdHh5DKgYmqIJnmvkbC0q3ntpabsa6i4HfK0kZ0WE+lapdW
         I3VDdyJZZ5hpKz6DBkYtXa8jCfpLEKTR8XqcsBG5MsjrkMv91EgfKpnWabFP6v79hkLf
         NBkw==
X-Forwarded-Encrypted: i=1; AFNElJ8MFsaSGUdhB/3nqk6sC0Yv6fX/LO/Mqmuj/GOr+nB4vi/elbvgxxWlYyk9ijwVrSVmegq3A2P/G9VWBc+LZR1Z6Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdUa6Mbz6STK5IaUAG+QdbCD6SmvwmpzGr/APAHcmSgP89vft
	ZoJlF3xrt3OvFPhO4FG0TlFKc3ml2ek4zv+hyQIOc+YHWQZTbQ/JgYmmGlannc+GqZb7LXfqkKK
	Z5pNiD1bN3fdhW0xYqh36DA==
X-Received: from wmpi26.prod.google.com ([2002:a05:600c:4b1a:b0:48f:dc9f:6f1a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c5:b0:490:be9e:fd07 with SMTP id 5b1f17b1804b1-490c25ae3e8mr73573335e9.10.1780677594774;
 Fri, 05 Jun 2026 09:39:54 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:25 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-19-vdonnefort@google.com>
Subject: [PATCH v2 18/18] Documentation/kernel-parameters: Add trace_remote
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
index 97007f4f69d4..d379fec5e81c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7792,6 +7792,25 @@ Kernel parameters
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
2.54.0.1032.g2f8565e1d1-goog

