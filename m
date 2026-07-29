Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0F4D8DA8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338416; cv=none; b=bpvqNH5lla3WJwtJFc1OQRfIa8IL/0+mOfjEt96e3pPCBPOsP/dnXc9g/lQeFX7gHaGQN7RYpK382EvnFQj+WDoKlCa1I4m6mmweyBovvbd9+FJ8X93MMhLs2rYBgF8o7mpnPIyNrJPrDBVtarIlLXPbzIZondRBlms3KaR7qFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338416; c=relaxed/simple;
	bh=Q6sBthUihfALMVsGkLGR5ZzbAeYn7uW3Hj529CcHdig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHla8NJDyRwf7yWMdJTsKuT4Su7EO9y8J2ghnWqJk50vrDv4vbGfPl4ayd4WGLRbl5y7mMUcnrHi2Vt+eBgCmCvhXAHrS3lSEt0rxCeqkvmxjFrkOJqW5SHH8NTz4+9bh6NmyYlqiFjlkkPJAQHmwWHk7OLX4FaLxNgRcdHxBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhuV60IL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhuV60IL"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5218927884fso10533811cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785338414; x=1785943214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zcRpeRPBTfk7ClMYXLvexss7+DxkZQ7yLWlVxi0mrIE=;
        b=OhuV60IL+DAfqS++Aua2Z8vFvQ2oTYprYGT0iIEDBTMtZCybDIQZ0p0hHx0j8ShRAo
         dDmXoO3x+gT2QpoLb5HbVb5j5ShN8pjk9ZtNmW/DBU0D1hFdNesWewVTHV6+uAW8KTIk
         mYZOSfI5jj40eXm9mB1dgOZaVaAO8ZmMLwvA6lQLZ/z3pB3AjBX1Wf9pi3Lzt976TZSB
         a10boQ6VvSBkpukvBmyoWeQYPrG45sFQNXHZYYQ3/1kKwEsjG45XbpZZRuc7vkj/qSL2
         FajSt6nWj2PwvUN1DyBa69iVInbail31SrcmLfZilgaQNvuiF2z+4RJV03frip6PWo+j
         sobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338414; x=1785943214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zcRpeRPBTfk7ClMYXLvexss7+DxkZQ7yLWlVxi0mrIE=;
        b=ccpRorvEny5iJ78L8YchlmLWKXZ3icz95aV676re9HQDRYDjzukgNJ9jgJFlcdlJxv
         lO+gspf60aNeZYdjVvr9AiJmNXFqfu2P9iuWPgrO7a0KqFz5jgSBtNfZgzdBuRO5Qsaw
         a+Nn0UhWHSnBgLt7mqpJUhb5SAV21xEzn4/NDmOWJXJmE13VAOnzL2Dnpv7L+mFhdM0m
         4TVK9xYxY6Ouu0jmW7TmnnM5uHhWJKKolOefzWHUcGn5ewUJCxDnPWGvzZgkqowrf/fc
         DVGLudmBcZZUokS9RJ7d8BJAsGXypxatB7R8ip/Z76nXl4yyihEifg4jzx1enKP+aIzM
         jhuQ==
X-Forwarded-Encrypted: i=1; AHgh+RoukNS2YNM+hzPYjZVuV8PunrumnvCla/eC8zGRI3imJAyqvfFpGKwMPjwDSLsZLMsQN410BNVtkRUVOkgPBm5tk8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx461FcOwlSF+y5McOyjPpeP5kcsdYtKfyv8wfCb9AF0rT7cgDu
	P4nlrezkDkLrWnQLCxGqCEnD2IKwqVzzkKZkDc9zTLjtVF0Rm5BARiBbMmLlgXLDq3o=
X-Gm-Gg: AR+sD13F7F4JtQodml9N5ztJ4kXd9sxvaOf8eHEWDkNpRKLE2XPqaV+KmzxZ0z4biee
	RW9/5VXQFQ+KIJUZxZvKcH/cIf1rRFYrN9Z1aQUfo+f+XybHnvIvCt0BkE22gblglLoTCsVmh4Z
	epNAWElR8QaIM1NbPQ+OG8UuR+3++Sx23mwWFQZUMLdR4ChmK6pn+LNPjZ244cyfPo6Sx3Rao1S
	nesl4isci11EghtVCL8PYVrItH3//TgPJ6TeU5LOXhWMP4UFFyec1bV+Fpcx3WoZpnnrj7F0jmr
	JeRD+grMXHmc1GYgETLxiH+L7H2TKHHdD+VtT7SlhqjJv20G/DxKloF6Wr2l1ZfIgmyllru264i
	7RjVFUxpuh/bvoRkrKJL29WSnTuXbCYcoysp712FOdH6PpxcuxxjyFwo5HBVYzaiujUxmyBJ7rq
	6s8FSgLY0mYFoGYNuHwbGs9gLYaew6oYhXAXJkDShQYUpWgM6fCXe/jKXibkjDuBLrUy9/6drNA
	hTS
X-Received: by 2002:a05:622a:1f94:b0:527:69ec:9725 with SMTP id d75a77b69052e-529d717663fmr68563171cf.74.1785338413953;
        Wed, 29 Jul 2026 08:20:13 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc4286dsm26812166d6.7.2026.07.29.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:20:13 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] tracing/uprobes: Reject unregistering enabled trace_uprobe to prevent UAF
Date: Wed, 29 Jul 2026 23:19:59 +0800
Message-ID: <4ac73dd24e3123cdcdb3e938dc7bd74be66a3f77.1785227724.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785227724.git.rakukuip@gmail.com>
References: <cover.1785227724.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

When unregistering a trace_uprobe, if the probe has a sibling
(i.e. trace_probe_has_sibling() is true), unregister_trace_uprobe()
jumps directly to unreg, bypassing event busy checks and
unregister_uprobe_event().

However, if the trace_uprobe is currently enabled, freeing it without
disabling it allows uprobe callbacks (such as uprobe_dispatcher()) to
continue accessing the freed trace_uprobe structure. This leads to a
use-after-free (UAF) condition.

Fix this by checking trace_probe_is_enabled() at the entry of
unregister_trace_uprobe(). If the probe is enabled, return -EBUSY
immediately to prevent unregistering and freeing an active probe.

Fixes: 41af3cf587f4 ("tracing/uprobe: Add multi-probe per uprobe event support")
Cc: <stable@vger.kernel.org>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 kernel/trace/trace_uprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c274346853d1..a514a82c4ae0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -396,6 +396,9 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
 
+	if (trace_probe_is_enabled(&tu->tp))
+		return -EBUSY;
+
 	if (trace_probe_has_sibling(&tu->tp))
 		goto unreg;
 
-- 
2.43.0
