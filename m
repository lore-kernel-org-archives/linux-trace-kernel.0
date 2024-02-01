Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1B5FB9C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706768339; cv=none; b=tzuwljNImIzHfvUC79iafp7dQqroxfiM8WdH7Mn+mKxMajzIxdWEkPKsdvhP8uBNfs6Qqwrf/7tXStv8u5D/w0t+eCSJRyOZNeKe2GDeWhOiXbHpNjy+HpWL5fDEh+zLtWhUj32mY3N90MRZ0MrAlOGQZ5R3eVcEs5U7QzJxIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706768339; c=relaxed/simple;
	bh=rACT0THE0/qZkTYzpf7zXpoSSQ4cYbyZBe8maSv0JUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJQloDkylBNDDEVCuK85QbJ0bU9YgwJ6MKNK+jK+f3CWhf2Yzq8a+gs0DZfQm6yTNuDE/GeuFPRozVrMYvhAZzGHF9CyOOvZh52N6sp8eb+5+06+VEODiRKeYPHAhzF4HVSNVRN/I8ro4AoJYUz717w95hcOtugosqvPptjTm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=k+cGckRT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k+cGckRT"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so533045a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706768337; x=1707373137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1t9mlNVT/1Abn3mPF7KbdqE7LL3JnqA1y39c+02s8o=;
        b=k+cGckRTTd99bSTy1WIK9XseAYnxa/ayXBOuq7rn+3wrKEM0Kc0gfeNyLXRpwEZVC+
         fKGoj9ARa8+49WHvNNBpojYtcxHNXS5vaiWBo+yytl1JTKJ2XuP9Ary3snL0AtaBzySw
         T7/dPSJ+dwG2Wy95AHSucaeyf6p7TMt4cWTqY+7Vm2MpaECvqQyuKn+tASV8bVY8O5Jw
         3j5Nx9canmIzSvxFaTQWU/v8ETuVgSZ5e3gOgScjRLMD5NhRpqQlt/L7JAWqXpSOO/u4
         Ndx32KKB1ZRC2LlmRkGH83Z9eP8Gg26KDXh4uA1t6UN9uxxRqskMq4YndB2OCDv8laXP
         Mlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706768337; x=1707373137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1t9mlNVT/1Abn3mPF7KbdqE7LL3JnqA1y39c+02s8o=;
        b=a5WDtRZrUmW/RVpMAEXVr0231onyoqnDwwt3MvY29g0aMVXmXFJLFff4eg878gAHuo
         BtlH572RuX5Jt4ON62m4RuDzkAJIqk7vI/zgbXngng8IF17nUBAuNLQWjhZLqaoVvYd5
         JkrYb6sAnM1i41t/o8QKBOdcNcI4uGJndA0ip0IlxAZM76YEsXHZ9I5WXkObsRiKNKXU
         qiLbb5BAbpZDrtE854VHVHLA5KlGQub+QssDzXND5sMIx3Iyo9Uyv31XyZPToZcl9nWs
         WsVFOmB9EOjXlADFKWeQTy0AZgDFXIpKR9S8e5A1boxJgFuOoT33hETUXcQ8GPtT2HWY
         VoyQ==
X-Gm-Message-State: AOJu0YwvZxgmSQPWO6fqX+w4DC57d4Yj/x0szljhYOQKfI/nuNOfI5Qn
	UldjKoiwT9h022QD4uCFu4lfG67hQtZ9ckpBuJPJ1VU8GZ9RaR3YlxnXZbogIbE=
X-Google-Smtp-Source: AGHT+IEC+0hMzNEq9v/MTQW8DTnqftxI4u3V4utShvbPBPXAhVqyG+W9xPNDFi/rPiWsXRY5zJSqdg==
X-Received: by 2002:a05:6a20:e30b:b0:19e:4004:b6a3 with SMTP id nb11-20020a056a20e30b00b0019e4004b6a3mr1055806pzb.39.1706768337110;
        Wed, 31 Jan 2024 22:18:57 -0800 (PST)
Received: from archlinux.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b001d9004b68ddsm4629902plb.252.2024.01.31.22.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:18:56 -0800 (PST)
From: Andy Chiu <andy.chiu@sifive.com>
To: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org
Cc: bristot@kernel.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	Andy Chiu <andy.chiu@sifive.com>
Subject: [v1] trace/osnoise: prevent osnoise hotplog worker running in UNBOUND workqueue
Date: Thu,  1 Feb 2024 14:18:45 +0800
Message-ID: <20240201061845.3154289-1-andy.chiu@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smp_processor_id() should be called with migration disabled. This mean
we may safely call smp_processor_id() in percpu thread. However, this is
not the case if the work is (re-)queued into unbound workqueue, during
cpu-hotplog. So, detect and return early if this work happens to run on
an unbound wq.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 kernel/trace/trace_osnoise.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..cf7f716d3f35 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2068,7 +2068,12 @@ static int start_per_cpu_kthreads(void)
 #ifdef CONFIG_HOTPLUG_CPU
 static void osnoise_hotplug_workfn(struct work_struct *dummy)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	if (!is_percpu_thread())
+		return;
+
+	cpu = smp_processor_id();
 
 	mutex_lock(&trace_types_lock);
 
-- 
2.43.0

