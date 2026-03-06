Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF913CE4BF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807788; cv=none; b=ABvCzlUgsvf1iQQ6yLwFGPReDWvEuBVlvH1b1GUDiyVmnlqUFNFnNw7Gqd7j92F11IkUhY401JV72Dw9K8f+J03qYORkKouoTkgiJVs4FlbXr8EUIoHU4PAaTvcHusF7XOECEmCU/5uFHIJYKYWk9+NkungpT34JT+L4Pa7HYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807788; c=relaxed/simple;
	bh=ObgOCDMC85s7Bm+uCQyKTE82mofMGHWimv4+K5Z7ga8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jp3CAzaltXfz3vmwObS+SkUs0gyfo+XqMhuCoaVnOUt+FTyQNBfB9IInKr/jr6DhOyGiVajWDXmSkbIqJWw+kllA17Vo5akG4iFp4gwh/jC6lOuJ+f9gAvf3dEg6+PCRjmgUoiaIUxPxppLIugwQfGWOSE9SlUTAOxLsT+W+ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcJOzHvs; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcJOzHvs"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so95684205e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807786; x=1773412586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fixqNHIgRdsXrQKd6GcjLA4m1QZ0grB448V81HUxHL8=;
        b=LcJOzHvsAtjvNSMufZ6xEQEuUJ7Ghzhq5v5NlbXaq6zoLAfiMcr3vagqp24OKokEZf
         vSAzKu1pY7h87S9qtqtBfugZ6Qhi3500Qkz4TwxSnPZSgRa8u5tP9AvxXjqRvoeM/YrN
         C40HFf0WP3ttrFudAIRYG1gV5de5AQ65UWFOa7NRi1GV60CSweABDDYxsZg1qMUgQr5q
         HSuXRbrd8SWSeMnxIp3m93ISYSPbzrw6eOQC+jeGcwVev9dmOaX8SboOwjbcuWkk/wTX
         jXP0Pc6qjexDLflmUSkPa9AtIoi69bgG0cwRmyOD+yUBA1wDuon4F9hDV8YJBWNEWxDT
         ceew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807786; x=1773412586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fixqNHIgRdsXrQKd6GcjLA4m1QZ0grB448V81HUxHL8=;
        b=wNUy4u1cjqfmA6FW/Dxutmcs+uq1kC1tUuuNWE7vQf9UiLLlSA/QUWw0e92YiCRZdj
         aNrgK8h9b7VCmgcWf/3Av/tEKwwbcHOwYH3CXVW2Lv1SbRbN48au3ItzG+i9V2a2f95i
         jMgsCKlY5Cx3FChNa27D9+W7OyycHEOKFa29WPeViGzIVA10oJ88h0mxEQFxB8xmzuZp
         jFC4iN4qzhRdxcep6YFJClj0z/CKAdf6fKFNpu0ohkpw1sZuypN8nG3NwQA0EtbSqeb+
         VCqs9usBrYOQprRi6zdWN2XS3HagOWqIdT3TX1wi4OdpS6H/ZA0EdWpOGloyr03G5nWh
         fjng==
X-Forwarded-Encrypted: i=1; AJvYcCXLciJuaYURcFznWKZV1NUPsDvGe4PqFXiTPnNwchipbKqVSbqnhfyuBMfM5HDQZKVS+jAQlsWJIO+Py829WDcj7yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWZh6vlycVUnxVjPClaozh+D8N1Bm/APwMCI+nhYsVCQ76D9e
	ZS5TG3iykUqe2nVFRSJh24haaBV3SrVsQ2sr6ICPqerw9dl/dTQWZHV9f2HqNuPrVbPkZyiuGbg
	XAt97xF0G6gVgCfv6Ny84KQ==
X-Received: from wmet19.prod.google.com ([2002:a05:600c:2ad3:b0:47f:c96e:8381])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1551:b0:483:43d8:8d68 with SMTP id 5b1f17b1804b1-48526967b79mr40105665e9.28.1772807785798;
 Fri, 06 Mar 2026 06:36:25 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:36 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-33-vdonnefort@google.com>
Subject: [PATCH v13 32/32] fixup! tracing: Add a trace remote module for testing
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"


diff --git a/kernel/trace/remote_test.c b/kernel/trace/remote_test.c
index 791128d7fd00..6c1b7701ddae 100644
--- a/kernel/trace/remote_test.c
+++ b/kernel/trace/remote_test.c
@@ -28,11 +28,11 @@ static int remote_test_load_simple_rb(int cpu, struct ring_buffer_desc *rb_desc)
 	struct simple_buffer_page *bpages;
 	int ret = -ENOMEM;
 
-	cpu_buffer = kzalloc_obj(*cpu_buffer);
+	cpu_buffer = kmalloc_obj(*cpu_buffer);
 	if (!cpu_buffer)
 		return ret;
 
-	bpages = kmalloc_array(rb_desc->nr_page_va, sizeof(*bpages), GFP_KERNEL);
+	bpages = kmalloc_objs(*bpages, rb_desc->nr_page_va);
 	if (!bpages)
 		goto err_free_cpu_buffer;
 
-- 
2.53.0.473.g4a7958ca14-goog

