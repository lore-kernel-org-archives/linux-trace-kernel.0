Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534181;
	b=RzZYJK7YuKA1MvxjJUsP2kGpPlZMWVNeky+yMWG1cpvYguLZxxHhUqiWnSRbpKCugh/7
	 m0670ddQ9rpiJhVxzL1J/7kilRTCF95BHgb9mavIpdSQ4p/we3YCX07akWxXvnWfrVuVT
	 k/WL2HDlhliyjLAfvgbTaShlJXGUNay0Cc4iHEwSVTRKjnFDyQn5+skLCZ2yPPLoF/Qjl
	 GWDaUoOAukrVfF5cH74yRC1qng7uYP0a5gcOfDJXSDQezIrp7XUn4WjQ2JAFFJbOGH0v4
	 VzWYxitv9mccmk6J9fGaanhn7tVbmw/qMkGsZkVtlo50W8yESTfwxvHORzmzbS7SMFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4shb1Ndfu8EixOk7dCitq9WilHiHcXcrJsI5cwhdyGE=;
	b=5rh0qeHDsr1Fo84tE83aJfQUFKGud9a3nqqSc4Zohjbg2PuF5opFk6qu2cGZMPoPaxBI
	 wQIwGQdwp6pii4spTt5V6Drbf6RAYWvdlDartRNUFeZf2FVOW8mlDlE9w/n7PpexzwMd+
	 OJN0fv+QlvHV5Cz6uJo3HIXlz9TSp1AlRKGi2yWiTenJAp5gze9Q0YmAWTIA6mZnTIpVI
	 U2+3x7lHR6mGNcwZBA1HYTc9BGjIxDSzvMsYeCk9I/Fh3RlQdxRdgOQwiunk8yVvguXek
	 cdG5zSHYk2fKx3NMHFDHqBCASR8IkpPko9RGop+N/+0cb2BteYR+xBMyc8YYb+SwdLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ADyFfeEz;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D7606A6A1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 672D7606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ADyFfeEz
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso33210425e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534180; x=1796138980; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4shb1Ndfu8EixOk7dCitq9WilHiHcXcrJsI5cwhdyGE=;
        b=ADyFfeEzpBTPX9ZcPWVKZC3BWC/xoeP3c4HnIhmlUX0BAY7umvak/dLtuCR5f7B0bB
         nhtpWz0KkfDyV3cEYUsve7fnWdEsqnznLVNsFAZk7PxVWMWXH0rpQilDQSlgtK7tKf7r
         cr0NqZ5opGvquxWpHVbEdAOzVNbV8RsAqbYaMFFh65AblBRZQVS4Ux6YjeKJj96dfF9H
         Fyje/zCg2H1HCqIBu1OR6pAySBHyD4pdLLrMytaiCzPn6lLyFsFBXxBiOpZF4qHBDl1A
         ggfxLJAxFtLBIsj+7r5npfYjLGXGBisTu1SxGcSInPcUFPkXIGgqu86jx7G6MSYFGb4x
         fzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534180; x=1796138980;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4shb1Ndfu8EixOk7dCitq9WilHiHcXcrJsI5cwhdyGE=;
        b=LT/2jsuj4KHghzYEeFYsftcZvuKqI09mmsLTKYoS/9KxscyDLuk6xeK56li7TIbX5e
         5jo2LGKtbUIEeTSxOsNfGeE6eGUkSLAi4m6t6SWvwAmfsIoxix1BvhpgZyaKx/3eSTCm
         EjDfghdZQxDmpEGlM1oP2Jo+k+0jmKhE1WHpo17resufRhSLHOEnGcSR262lJ4ipsXex
         DDn293F39Gb5X+G+mtEUtPoAumryF6kjD//59uXzFKCQ2gagecdLL35wyr9+qtqNz9+4
         IvvBPqvkt8xApwkS0h/SHan0xZUtyzIjNnOuvJgVN9pLVPUDwebbj9dYTrSbJGo72hv5
         6Z9Q==
X-Forwarded-Encrypted: i=1; AL+hErF2AOuVXwjhEFP1Kxde3mbtBMLF60EGk5g0V9dGEllcV33SXOYPN6HmvFiVk8Ndr9mE3poiZis1fz1YGElrfuZNzLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EbH3yxRH0Rz9KQiPBl7YJmvyr9gbKxxFUSY07Cof227S757Y6
	FJ/uJ/x1l9tAaiW8QT5WRRPoFNx1G9eblCLgJOE+g7B+xQ+WhseffadGKRwIrkkzbErGYhSpjMR
	n957gqoXfYlBJLEskGvuNPw==
X-Received: from wmbh27.prod.google.com ([2002:a05:600c:a11b:b0:4bb:6a03:8800])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6092:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4bb8892bb67mr285734815e9.19.1795534179788;
 Tue, 24 Nov 2026 07:29:39 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:45 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-22-vdonnefort@google.com>
Subject: [PATCH v9 21/21] Documentation/kernel-parameters: Add trace_remote
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
index 176648941aec..d000bd5ed61f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7848,6 +7848,25 @@ Kernel parameters
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
2.56.1.809.ga0b61035b5-goog

