Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17D286419
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063453; cv=none; b=VkmOzEyQV4UJ9GfMrq5HfvMPYBNB90WAbOndLxnoc/Q2dT/Pd67T8LOLbcOOtv6pW8Fe9iHJz/UYV6bs2Dz2JH8OkBgGScZooOO9Pnl4VoANSgtUHwiIV55q26s7/MjgHgBVWUB6qicms26K5FoQK+pA5N3cEssi1MKkjn8cL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063453; c=relaxed/simple;
	bh=bnA5ox/O/mmmiQEy1E7E95sgYqDQgnA0GWdQw5e6aE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neJWt5ZA0SDCmewuTEoKjzMluj4dXm/jlJK7HLAe8syk1iJ8GLCa0XXxUTzhtg9QZ8pEsoDc2wVRAPWIspsC/jzQAQEwKLt+d2qZSNsd+QRx9AIg7F5vtnXcrcLGJaZbq4POyMTb4bYhYy18Yn5DkpoZbV6RgBTUwH5qvR4hxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B4rcocMm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B4rcocMm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso21238225e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063450; x=1757668250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qXDnbZXZ7ZGHEJeuNju+2jnsBVNxEVg6Jd0e4YiKfA=;
        b=B4rcocMm+6yZbBCd96SyWbtrOMosQNKdN0c+Ch8Nsa5OaFe/Ru20A4WmYb5MydiLhS
         pwGC41AODgjUtDdOho3B5O3f26DPrMLrcapfjWwUuwFho8utjLF6KUa45gZxP2VM9IC2
         t0H5mN+W3F5yG+jh1hQ5tEiDGCBZJSDtsKRvVzStKW4cXU7KtwopnafxLFJqbkHTesqb
         4duLCbmRel/JFiebJUGi0bcHPPcYzYiO1g66J5Sio5R+x9iM05YYvyTW15vutZwqq6nA
         eri2FN3Ms9Zi027gKbNXSXCyGcqQISQn/sX8JSjSnUHTJOtP3e9CM6tH5mbc1XhgjlQy
         ZX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063450; x=1757668250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qXDnbZXZ7ZGHEJeuNju+2jnsBVNxEVg6Jd0e4YiKfA=;
        b=jFZ+M7Z6O5Hz0EKGBTDCD4pTRkzaUf7SUBVb/8ngPY1Lw0Tx2JOEV7eg4kfJUArWiY
         1CuoyAWSX216EPx6rTgb8jtxGmh9lY5yKZOEqspNjt1ABqJ+MpY5pWplqIaRZyExTG+9
         r1ejbAEHusMXMR4fmk2V0mxrenSxO0O+2SSrVqn3/RgZevgdm2fY53berRCaIKUOFKcu
         1K0hhULDAia5T6doVd42dDsrQGiAMnp63i4OxIVwB6MT8dBdWGN2HOjYzUKb9LtObGBg
         m0lNkXzOQQVTu9HxK6TbjGOQ5iBPIk8CbeSNK3S/WyCkv+O1yc809XKqYl2RSvJIUwI8
         Zuww==
X-Forwarded-Encrypted: i=1; AJvYcCW+R/pWS5eOvBSGigaTHaqK03Hh8M3u91hd34R6igy8kczvMQJ3ZC1eos2PlCRbrY6vv+EXZ6jxQAQj3MurdBASMoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVyEIbiZaJFMpP4WRy0e3lN3HDZwE+jaNmTquttD4OTcjgnnI
	zZII2C0w7VmuDUKAIyeiubWwvnGCozqjcjj8WL4Krh9bc/DeWv3DGCxFLVNRjWoboug=
X-Gm-Gg: ASbGnctnIl+0JLAvVHJdfCwGeRjJsfmNpdXUnMPJGd1Efex0DwSu+/ljqoMfbm2eJRO
	KjAZPwAj3dMYJ+gcNFfDv493ctKqCw1509Tdq6y8caNTotu2PJAtuHo0wv3XO5WIP5vLD4+wFmn
	EGOkwgWH47X0J6mGVjNYdLqWbtRgwPmR3VqTbY3VbFEy69UExivai8KRNbbVcFn7wVE1PBhCkyB
	tzHTUblxMue45vXXBFR7PQK5f1vYr28PFE5/9zKvuVVh6XdoB7RpNgTs19a8jnz7Y16iA5NnXal
	hSZpL0HdPHckEBhyHTe39Uw9zPjadX+IaoIDzlpLU5s6NNUT/ibmTfjFMfz2kh58XTYTVi6atLE
	G/p6elg0Co8hE7Sg+DOELQhpaIpud4HsAVs7Jl83xmftp6r4hkDrLr/kWxA==
X-Google-Smtp-Source: AGHT+IGJKWfV6/Yh1Z/aQVrls/z/VbBEpNyOnSJSAtS1DRjFIfLVWd0Pz7fqNBaXooRuOl/rZxxyWg==
X-Received: by 2002:a05:6000:2211:b0:3e2:a287:2cf2 with SMTP id ffacd0b85a97d-3e30331bcebmr2465782f8f.23.1757063449746;
        Fri, 05 Sep 2025 02:10:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc3fasm30302590f8f.5.2025.09.05.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:10:49 -0700 (PDT)
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/1] tracing: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:10:40 +0200
Message-ID: <20250905091040.109772-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091040.109772-1-marco.crivellari@suse.com>
References: <20250905091040.109772-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index af42aaa3d172..3169182229ad 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -835,7 +835,7 @@ void user_event_mm_remove(struct task_struct *t)
 	 * so we use a work queue after call_rcu() to run within.
 	 */
 	INIT_RCU_WORK(&mm->put_rwork, delayed_user_event_mm_put);
-	queue_rcu_work(system_wq, &mm->put_rwork);
+	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
 }
 
 void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
-- 
2.51.0

