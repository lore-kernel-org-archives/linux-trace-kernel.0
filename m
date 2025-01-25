Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33604225D6
	for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Jan 2025 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768751; cv=none; b=JS6c3gNTXtwDxDLZlOC+eea5vX2cO3eUHWNyh/2jFjH3bM5sHNaQ1kjnh4fEQXn5FPJ1v9HIoeuepawc4ZU6gbx4IvxGa3NfP7qs25BNlcelwP8wbrg7d4VEpHBlPzlqvSUr6szvdA02ehT8I1WQrOs6+ua5gix70kndU5No59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768751; c=relaxed/simple;
	bh=V7mBH0zJXZMiBcNCDofsvjZ4JjQO1U/hqcyQs79rpD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPbLrIIQ3AZ1jQNo+FSvnFfu2Kf6jjK1XI2odibuujewe9FwgCUjmmpBBrKSHnLIVXyjHPGgkNj7aVYVBL6XNu+zsREQeHeimbIhtNDYiINdak5PLM2kcb3Qg0inVcpeAYOKb2g4v4V2ZKB4Zv72lJBmNK7CMFrXtXITm10GuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F69o3Ych; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F69o3Ych"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2165433e229so53168665ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jan 2025 17:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737768749; x=1738373549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfQLw6braW4NPzP7u1BdMZ/MqPhU6oi4TECCrySv6tY=;
        b=F69o3Ychn1uPhWtKoILwGAPqsJ2ZizKQbYlaYCHxiRhRXk7ohSptvk7wXS34hDg+y2
         gchJHZmG9P7VaDHm2yTjEzzWoxZanZ2rY0j1FJt0CssryUODj1ycBEkySWb4qKvMJ6hb
         9eGyYctYJXxqzFmXCaQMN+7JqAdTavehen1SKwvTSHpENeW7Qk4GQtzZbacbMwKh0Qrz
         8zQ3IdB7jHeGBqyoz04PFhPNRssuDkd1gY2PZmPg6beyq4x23xZzr8XdpNRtMCeesp7i
         VbwggE6/sN3c+7NIpz9I1JMtbeuCPAGPPn5Zkfmm7VOHx9BboU0QN5PxaI8Jga+QecFr
         uveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768749; x=1738373549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfQLw6braW4NPzP7u1BdMZ/MqPhU6oi4TECCrySv6tY=;
        b=TJbS9uv3CnwwOAkcay12WrhCBLLRT/HuUEawM3Athpl44svcf78lt0uIqWB0f/1Xu6
         Z+kif+g4n1crXqQtvZ8D5sx/61rSSCqRnhqaFgdz/z9Ur9CJD2F+sl90gqMtmfveD3MN
         AVY7li/IrVdSpPOyEy4cVRWQDI6pDkIzzaAHyLWftnl3Melfj6zSjcSD1i7yCgish+d1
         JPoP8tJoK4kyDfHgfAXQK4OWJ7nCv+dmKznNgBuPKcct40dfjZsp2H2esIMmm79sK4mH
         cCUTWwu1wv1+fGfGQeVcdTHAUcYlG3CanpSOtPSfh5FuTLcMh/gmKDdx+m8elNqVYgtk
         dtcw==
X-Forwarded-Encrypted: i=1; AJvYcCVPLJId7K3+1fnWFmDtpiB0W3ICQUOgCs5vHD+A42fE6STpkZvZ5eHMfcTSs3UAtHaWddc9c8sAGO7VFJ7gtkWBUT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdBrWgsU6AGC7FrowaxwQLjpWxap0VCmn7QoXJewwXUYwMH7Y
	wjtwLl19M1QeDoTcHjA6r00ZmtsyhTyrvvCERrvPYJyjEtZkYkJQcELp3CfWsiVx7oOuXQ==
X-Google-Smtp-Source: AGHT+IEwhj43ji4o+0SxJAKElNbTnJvGB8JU2Dt1FOH3ilcjaICPkucWw2Xnsu+q12dk5Vy9F3ksFGEO
X-Received: from pgbbk3.prod.google.com ([2002:a05:6a02:283:b0:7fd:55d9:1f1a])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8cca:b0:1eb:367f:7a48
 with SMTP id adf61e73a8af0-1eb367f7e2cmr51366488637.34.1737768749476; Fri, 24
 Jan 2025 17:32:29 -0800 (PST)
Date: Sat, 25 Jan 2025 09:31:45 +0800
In-Reply-To: <20250125012734.1661860-1-keyz@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250125012734.1661860-1-keyz@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250125013145.1664062-1-keyz@google.com>
Subject: [PATCH v3] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: aarontian@google.com, yimingtseng@google.com, 
	Keita Morisaki <keyz@google.com>
Content-Type: text/plain; charset="UTF-8"

The trace event cpu_idle provides insufficient information for debugging
PSCI requests due to lacking access to determined PSCI domain idle
states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
idle states the power domain has.

Add new trace events namely psci_domain_idle_enter and
psci_domain_idle_exit to trace enter and exit events with a determined
idle state.

These new trace events will help developers debug CPUidle issues on ARM
systems using PSCI by providing more detailed information about the
requested idle states.

Signed-off-by: Keita Morisaki <keyz@google.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
        and rephrase the commit message accordingly. Rebased onto the latest.
v2->v3: Add the Reviewed-by label

 drivers/cpuidle/cpuidle-psci.c |  3 +++
 include/trace/events/power.h   | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2562dc001fc1..dd8d776d6e39 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -25,6 +25,7 @@
 #include <linux/syscore_ops.h>

 #include <asm/cpuidle.h>
+#include <trace/events/power.h>

 #include "cpuidle-psci.h"
 #include "dt_idle_states.h"
@@ -74,7 +75,9 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	if (!state)
 		state = states[idx];

+	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
+	trace_psci_domain_idle_exit(dev->cpu, state, s2idle);

 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index d2349b6b531a..9253e83b9bb4 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -62,6 +62,43 @@ TRACE_EVENT(cpu_idle_miss,
 		(unsigned long)__entry->state, (__entry->below)?"below":"above")
 );

+DECLARE_EVENT_CLASS(psci_domain_idle,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
+
+	TP_ARGS(cpu_id, state, s2idle),
+
+	TP_STRUCT__entry(
+		__field(u32,		cpu_id)
+		__field(u32,		state)
+		__field(bool,		s2idle)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->state = state;
+		__entry->s2idle = s2idle;
+	),
+
+	TP_printk("cpu_id=%lu state=0x%lx is_s2idle=%s",
+		  (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
+		  (__entry->s2idle)?"yes":"no")
+);
+
+DEFINE_EVENT(psci_domain_idle, psci_domain_idle_enter,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
+
+	TP_ARGS(cpu_id, state, s2idle)
+);
+
+DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
+
+	TP_ARGS(cpu_id, state, s2idle)
+);
+
 TRACE_EVENT(powernv_throttle,

 	TP_PROTO(int chip_id, const char *reason, int pmax),

base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
--
2.48.1.262.g85cc9f2d1e-goog
