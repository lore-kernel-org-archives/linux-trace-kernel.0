Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871522E3F0
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758481; cv=none; b=PpToy1Z12M5/ZsazLuaDRT7U0G4aVbpsZknH0mLUmWLHVIQIj9rkp9x52rgCVZQ3g16vRm1nZdq+jUq2R8ZKkjw0uuQiuFDuM+YtW8KBOxm5kLDvZu/LWZrjRtZqHiE7/Go2P6jgalsUYjBthzCIl6OKMnlp9VYAPlbXGMTOsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758481; c=relaxed/simple;
	bh=fh8PztGUjZg6c0C+06deI5LFt174xeSTuIW2JZdN684=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgyXukmHc0gJ6XT24TjfbJW9angOZAMckQP69S8yWbdi3803uijudu64YifDgsZf1NqeotYBnsxgZ6TizSSDEQ0g917Y//HZft90wpSGFFtlCi773NwMZHP1m7pVQBlNlmmAD+NbNH8oVTsAKLrlTBxQG7SLfEXn/oRx8zXJdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+vVqGSP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+vVqGSP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so24170995ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 22:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788758479; x=1789363279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/IoHQKVOt1DZYCcuXfN71+bBk3opjHV1VqUujIL3kM=;
        b=e+vVqGSPZZgK7EJgKSy2p/fJsdxIt8fUMAURhPBnSyw66FxpTflOyFmyKy6ozBpYCW
         BjkD2QadyCoCRoCYdGZik0Qid3irqo+BUv2XtveXqTj+vyq0wBcHFD7sFCquSrbOCZsS
         T31ASWnTEUE2EvkK2GNyQ+wnEARILCqw9JFyvS2pnx9mjuBzSfALbjF8ifLlxmPNb+24
         Z8/U725zMiDJ2FaCPD3eGokG4zlZUr+bHbK7KaiR2ApFeZkFqg85mWT53xSKjPIzLPE+
         lRsHVkq0K+k1op3rPnroUgUzInkYzC4xxDL+TIIXW6rGi2IPNEFobIAopTGJ0ZPWMho/
         8OVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788758479; x=1789363279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/IoHQKVOt1DZYCcuXfN71+bBk3opjHV1VqUujIL3kM=;
        b=mAPHMjWY7HY7MF0gfUhkWnWlzTM0IRE9Dyx6yUb402NoEYdWP3Cq2brRAh/B7KrSr8
         sm0fudHZKfN6qN940UCPZNZUYDt31lCtfqYkZb09PeDRR4FNrc/FVQOf/mZYsSzP7g5f
         vYHRep5rtrW+14dAPZ22uKPpZhwHuj00MzZImJRwciSK9nvP0/RUyQUChujLu5JD1x2q
         sP96LSVRsG8DvE8KSLWdMVtO5CiHOiP6q0xB3JLCRyLoSd32w9iFVP8dvpwF7LDyueJK
         mCnxVQcLcBVYJWbOm0qlY2EfeKsAibc2xFzZ5eSUC0gmicoDKMiol794MA9cTfshNtIX
         k4oA==
X-Forwarded-Encrypted: i=1; AKwUvBy2RgMHiYUCZk0yUFUF+CacV0Sqq+d5Vh9CIVQvEWfs9calVJ3FqEZBgKbNhiIIQlZB9O8ZCZuy3akAcT8Z+ak0nmo=@vger.kernel.org
X-Gm-Message-State: AFuF++lmBNhYRWTWrGFJLSCCKMAN8oxuDfnJGp50dPI84uLjRDEtlTyH
	vuWfcA99+Ce7VHaRAGYFXhhL0d4963IkUi/MqvB4WX1jxQpDELoHciBD2C01mpTe3A==
X-Gm-Gg: AYBFou0didLeu44dASz4B3vJcYqaCzDluE/rAd67tIhFYfrnOglXZS8puanDIkgOgb5
	GQvuxir7d4/CP5MCNECL+UDRO39nDgQTgywGaVs4RPF1bjL4By1L97IElaV/qchcu0e9ihhQuzJ
	WfpDm5hht+Ib40a1iQk67Y//buK0lPvL+n+cXYp/QsZVQqg4ijptKdW1UQ4rc2dYuyqfmY/TuS4
	QbLEGSp8Hcg4/SrqV57IVZiJauRV0JWKnTfXdU9OeyCmJXUsWXgovrzgxGIG6TgsKZ2oavlD3RF
	aQMwZCtTur8ZHY4oRuw5PnqqORHqz7BFiuYg/+ucFWu3kojiOqTUB6ytdhQL1EVWkGrGkjhBiuB
	n7F8HvilEJbstjeLmsvsTNEOlHgJ50uoSTZknPq4K0spfM6hBQIs+dGdU4CeAk+The4xFtdxm5J
	5ZJyRXDdtFOZv+AgqmLnXukJe3p5YNYOZu7biZ5ys8daNkrOl+kdgOGISxvrdwLHswUOkL2InHA
	6LNKZw3MIJ46lZK
X-Received: by 2002:a17:90a:d644:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39b26245cfcmr32715392a91.20.1788758479088;
        Sun, 06 Sep 2026 22:21:19 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae60a8e61sm8933987a91.0.2026.09.06.22.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 22:21:18 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] tracing: hist: let values keep the percent and graph modifiers
Date: Mon,  7 Sep 2026 14:21:13 +0900
Message-ID: <20260907052113.430818-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .percent and .graph modifiers exist only for histogram values, but a
value carrying either of them has been rejected since v6.3. The example
in Documentation/trace/histogram.rst,

  # echo 'hist:keys=prev_comm:vals=hitcount.percent:nohitcount' > \
	 events/sched/sched_switch/trigger

returns -EINVAL.

parse_field() sets the two flags only when the field is neither a key nor
a variable, that is, only on a value:

	} else if (strncmp(modifier, "percent", 7) == 0) {
		if (*flags & (HIST_FIELD_FL_VAR | HIST_FIELD_FL_KEY))
			goto error;
		*flags |= HIST_FIELD_FL_PERCENT;

__create_val_field() then rejects a value for carrying them, so no field
can reach hist_trigger_print_val(), where both are implemented.

commit e0213434fe3e ("tracing: Do not let histogram values have some
modifiers") added the check after a value with .buckets oopsed in
hist_field_name(). That happens because .buckets and .log2 make
create_hist_field() build a nested field in operands[0] which
hist_field_name() then walks into. The percent and graph flags do not
create an operand and are not read by hist_field_name(); they are only
used when printing a value.

Stop rejecting the two flags on a value. The check for variables is left
alone, where they are unreachable anyway because parse_field() rejects a
variable carrying them first.

With the two flags removed, the trigger above installs and prints as
documented:

  { prev_comm: rcu_preempt  }  hitcount (%):   0.00
  { prev_comm: init         }  hitcount (%):  99.98
  Totals:
      Hits: 237896

Fixes: e0213434fe3e ("tracing: Do not let histogram values have some modifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Tested under QEMU x86_64 on 1fc5a74b108f. Before the change all three of

  vals=hitcount.percent
  vals=hitcount.graph
  vals=hitcount.percent:nohitcount

are rejected with -EINVAL; after it they install and print. A plain
'keys=prev_comm' trigger works on both, as a check that the test itself is
sound. tools/testing/selftests/ftrace trigger tests are unchanged, all 45
items identical before and after: 32 pass, 3 fail, 2 unresolved, 8
unsupported, with the failures also present on an unpatched kernel.

Nothing covers these two modifiers in selftests today, which is why the
regression stood since v6.3. I can follow up with a test case.

 kernel/trace/trace_events_hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..faaff7b315f6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4313,8 +4313,7 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 			goto err;
 	} else {
 		/* Value */
-		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
-					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+		if (hist_field->flags & (HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
 					 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
 					 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE))
 			goto err;
-- 
2.53.0

