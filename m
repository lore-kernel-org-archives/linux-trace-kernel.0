Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277A3F3281
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974949; cv=none; b=ptVeLl8s7PRyzqV9OyOo0pIhVYbpfvNpnVT4mHZ8pvjiNiY9Rdh3awF287/ycdnWX5/ByvEPmRp07zs+iSvcmancr0Tjw1ZPx9BYi1RA30BRYAf56EY7a67s5zSxPDzQMCS15TrYgcUUIJUE4DQoBA1VOnOznaBta9nOoajjYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974949; c=relaxed/simple;
	bh=qRA8zmYaD47eQfxzWvVHZZXrXmHYNbroYCaRKqItrro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqOV72iSfqhlSTzLri+yD7YSlFbB5O9dT0txnVoQUgjXGTqDpj42gfMr34YWlHBjCG2l1fdX7kyQ/wZLiiGAKjVN0P8N/cCjluOlTV4STDyB/PQQqkB+xsAcWjWE1JR30RwGdG4OizqufjbsM6qegwcyh8JHUZtAqfeF1db16R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wwfl0AiK; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wwfl0AiK"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so26895315e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974941; x=1787579741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLlrwtW3ITaTH9fWFnbelNvQ01NhM8yX9YpojpxbLSU=;
        b=Wwfl0AiKqLEth41eNAr0lnp/oZIyajmkc0qJQpAeGeDDfwnxUu8I3ITFJfLx06jY4P
         EaccgByv8ZgBPNKz9ph2cU/u9hJ2Buzw6k8Yyn0ohldlaKL//32EHZRXMCAF0kmNJ1LF
         hpnK6LIp0A0dupkRu2Jc6WbzpsXDNgH4juQigb2dj7/nvkSBxpvFgmFvvLVRpQhs1zxZ
         ayJvBvFNqZ4SUcnWeQyJBM3VVGevurFVYjf3W+mUv/WieIj26OG0QjFdcAGWfdXU4WjX
         i/JfDsk+nRPqPXAFyxNuIw9uZ2pClKdFb98j1RSCfs+GTxlJ+z1rgjkCt9Oazv5zzIjL
         Jrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974941; x=1787579741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLlrwtW3ITaTH9fWFnbelNvQ01NhM8yX9YpojpxbLSU=;
        b=NxIV+EUvoHsiQFP2lWRayqGs7ZGeHWTCOArwnRkZlkMTfwDFTX/IUm2j+tCiRpK7Au
         rsuSqSEi1QQHG82FZwuMH7ia6lVi9w6bjSFitIOzKX3dUdI+jy/IcbPX5ClO9bhBqoc6
         rpHFr7TqUvnn/6eVb4ATXUk8to7YjIZPVhJyFpaH/YJr8TObQkchNtG4b/7t+e/KwrAH
         gpBr5EDeqVpQGsftiSbKJMVNeEcvT6URrFudxocQXGzO6Uway4cUaLTckzUhhKDWcIdx
         Gff3myfD1JsmY6TbnEJv50w7GM7v9CDyaW6LsMsjoSo9Xz4gdJJZcJeXu5gW2B8v73td
         S7dQ==
X-Forwarded-Encrypted: i=1; AHgh+RosGrJDDy+zgo6GiT7Seb2rxfvEPBN09LE73j1d85HF+rY8sTaqzIvsFsnB5A2sRIk8ELOc3poukHlm1EBBM7D4JN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4tgEziWnb4+DxYWyeNww/M22pfv4+on19mxT94JOBn4epBwX
	XXOqVgpfJcIaFrljvGA+pJ+FNvg3W1I11zEH9SKBpsd+b+RGJAWjqnsCkL84g71OTlJWzhDgI9Z
	emX40zrYXLJimzQKV0KXzGw==
X-Received: from wmjf25.prod.google.com ([2002:a7b:cd19:0:b0:490:b475:af08])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c21:b0:499:90f3:13b8 with SMTP id 5b1f17b1804b1-49990f315e9mr209158915e9.12.1786974940603;
 Mon, 17 Aug 2026 06:55:40 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:17 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-19-vdonnefort@google.com>
Subject: [PATCH v6 18/18] Documentation/kernel-parameters: Add trace_remote
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
index e8ff36982d97..63bbefba5bca 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7791,6 +7791,25 @@ Kernel parameters
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

