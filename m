Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B546EC81
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852258; cv=none; b=pJHP26mEjOo2jrMZf/RO/p1u6jqgfv/wqIOHLBeWqS6cFXjWhV2rNjV8Tsn5TE6Dv8QEON/WCJ0s/96Gkt4PMAS2OwnYAEaYDvjeI1bCZMzsSrzbnWNg5ayB+UZMZA4AOMtB3mIgOQz77CbUjAWI8JXuJA3hg76Rp71iZgERd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852258; c=relaxed/simple;
	bh=OSUij78+fhQKPWeDLYEuTvWN9rHZtcK6B+isPsGkf9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CAse13v+/DjPfRXq/n0aFSqQJRCsL8LLBEkRs3xfGrlsJ+W/QurBfOk6npk5nWbbdU/7+jK5LYjTx+uwhmOYfl/I8WxRraD05u3gPzLAVK8TtzzMT4lZVh6tn2RGpKcdygHqJ53B4okrahPy3hUjHvOBM9Pg/EGSr8dtiCjzu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHH/1pNN; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHH/1pNN"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b6f97676so36348435e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852254; x=1786457054; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tte9ma7wAYPi5bKotGF/KwdVECsBJ/R3KcTZGODT0EQ=;
        b=NHH/1pNN8vae+obE64UhRk275VGPruWPOKpnwHFe79+Y9FL40IzWmFBbVdT+ukG6Ao
         f/f99drAWR69iqmA0KjTP88MiVTjKONUsEaE/cynzf/d0Y5gyA8Dd0wRzXWt/wZgeSSX
         DiZ1A2bge95XNmQU9M5LjzFWblv+gmqm/YC8HuinZ5p20/Mcb9CGP387+87NY5tq4Sef
         7FFHHeN2/xpEzXW4VxJ1+Go5scdqojvwjGX8NpFfVLGMzRW3qaXmXqTf2qbNyVLtAq9r
         wp+e0ygZpb80p9YLawgM8eDe5G4wy4navs46srjrzo+C4xnomeLUoIDwne2HSRsHguK+
         GEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852254; x=1786457054;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tte9ma7wAYPi5bKotGF/KwdVECsBJ/R3KcTZGODT0EQ=;
        b=hPQKncz+bZRSGTZ3uiI3LPhoKMkEKyYN6dwi8BVbc5smKBOaie84PoWhyBHQX3Qa/0
         W5ej/dRyfnArR9zHBIfjCGMbpisxebtF1BiM5s5wgSsXfoTcXBnkhuqsLgXjNhmzSyyU
         p6oYnq12BomWUypgjytwgKIZtYNoB+HQQ93AHZqoMZ4r5ElSuMwL2EJR/Tz1jH+FGh5h
         BUDxYdDYaWa+ba5iy5Ck6JsIrDXK7H2OljE2VCUbg57e9O0pGHSeI2TaqBS7eh39RQzn
         deMpJhL0Jw6oR/PTuf+yHXslsHt+TtFbunhCa5V1V2gAz5IIbqKcYDWb2cx7tIhCpBI8
         fSmw==
X-Forwarded-Encrypted: i=1; AHgh+RruQ/NVxVjKJ2OFTE9AIyysiXCaACEzclUctZpKJ2njltIlIjwYkIm63RGtjtS9qw4V1aTZ/DRgdsCNQ33Xj0y1DFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrCY5VBVGrdM+9ZZfRwMQv50WJOcKzooDyK/Qo6L+oJtcH9LR
	gphmXgazPZH3TpJ4qxIxcQxQSisDiyFsVu2ypM5i3dFjajVlajqhTEmZjjhxUoSwyQhrVwR1jK4
	6ChkcUi++jiL1RaWj8/4EdQ==
X-Received: from wmqc7.prod.google.com ([2002:a05:600c:a47:b0:495:6902:b647])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c170:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-4980c673ca5mr397484575e9.14.1785852253561;
 Tue, 04 Aug 2026 07:04:13 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:33 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-19-vdonnefort@google.com>
Subject: [PATCH v4 18/18] Documentation/kernel-parameters: Add trace_remote
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
2.55.0.571.g244d577d93-goog

