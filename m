Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1312DFF3F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Dec 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766593211; cv=none; b=j+ML+xIrwOlxYYVglRZi6po+GpIWvNdaptOf3thA+WlQ8ygL4OlX9jeBPDbV8G2UW1EVtFZtLo+a9rkBa/2reQLLyM1qZ7IfIvSC4sdTPz6oWNUjg/8KbZetKN826ERb7xnyBvBznjsK9PNmU8BJAcxXmTDf02kIXGgxH2fUxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766593211; c=relaxed/simple;
	bh=PaXjZfgQMpzdjZFMlJDaRC2tkB80KzVmt4Ci+gTEN1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgxyhsE8OiiZsdIpWwHsOBrxLIgpnT4Tkn77eVRBarhXCdjXiXtl6z3CBf5+Ir8QQTopCMAmPJ5+PM+mVTrGpaynldlB+orPd63xMZc2OiIcXZqsOBn18HtUlbn/U2psKS41JXTG6HIlDGTyBoTzApEKPjywJPncnrp+vck414E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EyrXqIPR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EyrXqIPR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so35339415e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Dec 2025 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766593206; x=1767198006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PhKyhj6a/64o16DzAvjd5u3QkA1cUgN/J7LVqg+fz+I=;
        b=EyrXqIPRO2FbnmX3qTvpxouvO1YM7kC2/Nzt5hGynPG9gBlLSepQsf7TyexDZN/JBk
         p/XcNn/nYAUv7krLRane5D211kBQwRJY9bIKgC6Hwnh17+8oDQAiDKW/oGwxHkpvo9WJ
         KcqNl0M68n5UfEHnaW3UcOoHTEwGqo79pznhJGVhx4RXgtt8E0Jo+ugG/dKZ/RkHgmzC
         5Gb/DTwNXsXJWg1fanJIIrmtpdpVpoPDFUC/v1fDPh2bA46POPbMqNeQl/VSmsiy/vIz
         cq+8LoyTK7olTrWwTYviNoa8GqACpeELcGoUYUvgrsMyo8LsexdJIfD/UKZnhlVW+e3J
         1ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766593206; x=1767198006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhKyhj6a/64o16DzAvjd5u3QkA1cUgN/J7LVqg+fz+I=;
        b=J4Ycg+IB6pQNFf9g46RfFZoDVyMjzCKGYJWlzTX92T5UVUeLtU6qmzgV/UcIRDcxr/
         HSsBd6TY44tohNWQh/8QKxG/LeH2UXjDmdah16SPoKXXovc92YCR3IXxK9vXTF2FuvrG
         o9cjZFaACen9iKk8pswHrpF9F3rRL6fMP/V91WVt8DpkLPbIO0BewfCoOo39O4NxHVJh
         Zp4xopwFnq0Xeu+TnCv/W82BNeSXU64P1TGYmuaTevYeCTD6QQaGWGAh5PoxLgMKPnjb
         fyx3tifvYda4e+T11Hm0LCx6FEriqavtrgUFXITHziutE4KoMBoLBGk5qWiCRQRVemAV
         CGfA==
X-Forwarded-Encrypted: i=1; AJvYcCXPFU8xQ6mPNVaSLcHA/0YlTi5h8zR6SAhOvmogtauDdwEBJL0SK2WklZxCIbX+z49bInwFKulQC8lToTctgVLMXsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFIspXBAk+wyLc9jcuuCHRVqmaeLM9UmsVNoFNsNVYYsJd8wy
	nS3z3FUccNhfvajNkufGGF8Z9WLViVpbacdhvpC45ATeJ7f5yGls4BpwVpTyF26T+qM=
X-Gm-Gg: AY/fxX40npt2/AwLKxjFfQ1QLmmKIZ1xfsgyYH+2CXcl23OcwClD0ApG4xfEowD7qfu
	rWKvggJtIuygF36V/LBXilvvsZRQZJfyw9glaTqFXavCH1Iji6cCKnl/RKn4xWgRIs/lDZlONlr
	SGMl8UBC9IzmwsXstf/6/bUekGXkQ7H+9TL1RZP4scuejm6j5wvsu5BRZ/9U5qQBYSyIO6HQPhx
	B4TRTTAvanGby7nhZlBcc3Sw1KrsXj3I4XYQiUPrvNWpFsjy7X3sS2QE6yQt10nM0v60kHGsP0v
	PubP+0MoTsTW6/ijjzvg/ssFTtIobb5yUNzift1PNF18GpbvurYSZQJeh2XMseqGrp5AHdpU/nd
	RUmvp16YFMFtXuAXncW3tvLHNQPEvgHpMAJTJb8bdN+ZnY8A0dR2KdC4Mmlqe6dXNk/5GcOo40o
	XWk2e9Mmry4lvOec3Ww5C95r4p3V0I+OZab7FLJQ8C1gcbgA==
X-Google-Smtp-Source: AGHT+IFfIXvcwc7HfAMvTUFfAK0A8io4h6Ck14aYx0BaIwshYr/Rpwhi3VdLZHyLSabha40nPOi+OA==
X-Received: by 2002:a05:600c:848c:b0:47b:d949:9b87 with SMTP id 5b1f17b1804b1-47d1954a485mr158801925e9.12.1766593206335;
        Wed, 24 Dec 2025 08:20:06 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d5372sm319160795e9.14.2025.12.24.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 08:20:06 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Replace use of system_wq with system_percpu_wq
Date: Wed, 24 Dec 2025 17:20:00 +0100
Message-ID: <20251224162000.141731-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen after a careful review and conversion of each individual
case, workqueue users must be converted to the better named new workqueues with
no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 385af8405392..bb6de1d38f78 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1375,7 +1375,7 @@ static void free_filter_list_tasks(struct rcu_head *rhp)
 	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
 
 	INIT_RCU_WORK(&filter_list->rwork, free_filter_list_work);
-	queue_rcu_work(system_wq, &filter_list->rwork);
+	queue_rcu_work(system_percpu_wq, &filter_list->rwork);
 }
 
 /*
-- 
2.52.0

