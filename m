Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD03C7E1D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327943; cv=none; b=Au84X07I/VNwPK3YfgIlzHN99EagIYTF9NShhVICU1zfObFdv0rOGqob7avzV37K5ZEdBkO1O6pRvtPQyCZzGr6wYvoxo9r5nE62LX4c/28xONMoj28lzDZbTCwV0TwwAtJSt4J3HbBfAQC7RQkO+mbvD2SDlaDdQMTssDV0kpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327943; c=relaxed/simple;
	bh=LHlCK8WX2SxUwu0IBm7h+sLVoNJDi8rAGsY/Rwlju2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQAD0hQBeQYuMhAhwUCLRSGuU6aAllG3hBarfubKjLaGelTILc6by4iwTSThSdkbULRtnkOkvJufEeiIPJxW1JF0Gda3rVvJo/wTEI4stslcNA7jX6ynKVTNW9a+p74iXDhhEwmRGN2nmkmwuA31fgL9l3oJ7K0XJuhpuWEaz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=c2b3YTzZ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="c2b3YTzZ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d73d6976adso1012377a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327941; x=1773932741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVRHq7jWveTIXgOH1q2N9YJBNsnY5HcmT1rYL5VJ2Fo=;
        b=c2b3YTzZ0CWbP3Sjw+aROtQKWjSNMQhj7KhzD5v9+IPuYzwQdBddu9AcuyOtBbXjG0
         UO69nBlC0IHJgexklT2GL7fM3T3i3gh9Jh/tB7W4qfGiXD8gY/Yp5drewshE8L/ahq2e
         l70k9O/P5ZHpH3YL5PVtlfPqK7zRCoK808hXUOdvDY2uYLIR7kkvW/AZQk1X2zzB4y3Z
         VICU1OFBYX8R8vFeNQqZFhqMJsZ+Baq9hRxBG0tYTq2Jc5/+J0cUMarLBAESvyZesw3M
         d3xrbqtLpsJDgIacO2kwwH/jNjZm6RPUFwGNrwJxiORgAtI81TgR3OdQ89P9+XaUQO9b
         8B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327941; x=1773932741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KVRHq7jWveTIXgOH1q2N9YJBNsnY5HcmT1rYL5VJ2Fo=;
        b=bNz80fpA5Jnj9SaG2dLm6sVbcQQVQq7mabG7Rklc5v3MCk38RdPLZFCgSmj9+9coy3
         T55lGOjSvfqbfnCG5PHooWeLZQhY2SAC8aL6EFnQ8S+ol4BhOmzUzq+DDxUlXASWS3E7
         mVpx12XBvgTO3Yk8fV181XX4HuhniqI5IkQAP1H4dZaiXT1xqnymDucWdnAnEzPPYcF8
         e+Dm2YhZtcWHI5QRm6gvPegL2Xdc4BAtLdzFp8i9JcU65XPh6/wUwB/Ehks+6zDU+rq9
         AXHol/+TcTgIX7FQWkhbz7+NZRzy2vHuzTmQrY2YMidyjYXf33jhwpUVA1+WCMEpxBrx
         vA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhpqClrrMuPuYA6NZidoGbxQy3DjHHvYfnjCUgi0LrgRMpC7E3nvLwGaKP9X50hxDb9m7DNlP99uEkh5JFtKxLrnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyapGNpqmBiqOOK/jLgHcAolq7H+gusun+SlhzPnZhmUbhpvyXA
	YjmrAmZUIlg5Kzf4JIspfwnlQoyazpCKdrwaFRygEaTnVKkbneOX9cQEsk/kRKfsEOQ=
X-Gm-Gg: ATEYQzxTqsr8hEcWbEYyHiQVs0Mf5wqass2IlBJ4nLrowO0x6DTmHe9fkoUQIIp8TrP
	4/CJT5K+Xq9vf+prrM1SYRe3cE8N4olN5eHDGlf+CkqWqp7Ap5M+NgH8tZDEMYg1viiqJQRFrQ4
	/2nIbaKWlDn8Fw+qtFmsQfkrd/lDLD/pz4UiFukYI1PY1D8du/syX3n+Ovt0/bV2s8gu2n3hbz0
	/GagmJAfEhiFGVbOU0RYkocmNo9Tr4ap4+xpod09MqKahGzk3YGXRnf28C2jlIRjmuzuk7NxjTu
	2zDOSdgxToZbnJw9xFfrOdlDZ1473PB7/sfmWJ7IZEepOcf16YG2g9zKJNdUWBkJSz7QQNngn9w
	3ipREFAVEvWOjpq31pcQIJdUPWhn8g2QiEiEzXBltyCDHTAb8vw/m2pZhn7QdK0W11EJIcdGfKy
	xnZFF08P+fn3otPoVz7/CkTm6B1wMUzF1Qgv1mh+/YArSoH/paininZpaxeNn7oxN3XQ==
X-Received: by 2002:a05:6830:6d09:b0:7d7:496f:c001 with SMTP id 46e09a7af769-7d76a7d8c0amr3733806a34.29.1773327941086;
        Thu, 12 Mar 2026 08:05:41 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:40 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rik van Riel <riel@surriel.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 02/15] kernel: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:04:57 -0400
Message-ID: <20260312150523.2054552-3-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 kernel/irq_work.c  | 2 +-
 kernel/sched/ext.c | 2 +-
 kernel/smp.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 73f7e1fd4ab4d..74e71b6434841 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -79,7 +79,7 @@ void __weak arch_irq_work_raise(void)
 static __always_inline void irq_work_raise(struct irq_work *work)
 {
 	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())
-		trace_ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
+		trace_invoke_ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
 
 	arch_irq_work_raise();
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b0..93b03d5a8d5b8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4494,7 +4494,7 @@ static __printf(2, 3) void dump_line(struct seq_buf *s, const char *fmt, ...)
 		vscnprintf(line_buf, sizeof(line_buf), fmt, args);
 		va_end(args);
 
-		trace_sched_ext_dump(line_buf);
+		trace_invoke_sched_ext_dump(line_buf);
 	}
 #endif
 	/* @s may be zero sized and seq_buf triggers WARN if so */
diff --git a/kernel/smp.c b/kernel/smp.c
index f349960f79cad..da779fd78ffe7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -394,7 +394,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
 
-		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
+		trace_invoke_csd_queue_cpu(cpu, _RET_IP_, func, csd);
 	}
 
 	/*
-- 
2.53.0

