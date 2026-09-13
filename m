Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC59E346E6D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331525; cv=none; b=sUZNVBEAt3SJk7TOU26oRkGlaO3Unt00CR0awarIrQAF9l0diXlkyIMVp+yd9NZwp+8D40XAMy+60u4dWFB3MwbuuiGnlxCDvFeZoCERZQvNAapa7BaSIbC98WJ+1y8psGPI76JN1OgLWdIIfCVtZhlpQOGFp1YlusY2qFC0pHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331525; c=relaxed/simple;
	bh=ApCamlXMOVyzH0/mujk4Lxs+Otw3ipeDNTnXXDvwW2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcc4LFBON6/dHBMFi9xUcZWRkaZ+MevIKUGRTDhs5Y3jkefqs3UKe2yNlpj65x2jVu+mG87c0pCLpiHKqnTM0LgM58Z6Yc5UqzIisgZJd6JsOC5HGIYdK8uwgEcpNKsRuVdlmXwl4qktkTi1EWsdSqjqAvr8ivXvk6+Dafifx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUnSOBd9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUnSOBd9"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so483716a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331523; x=1789936323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZU3Q23MVCxor1flyXhWl24CciEpY/YSKjCKIGZyGQ9Q=;
        b=KUnSOBd9Y34PemlauXFpBdfdXhmyQ7n2oaRf3YBDmHEHSu/OKTuolaJiQoAoGpcgf5
         yquVnamvKqN7OjNYkWFFq5yz3tvwGTuBfebkqwCw3FwJWNIegquKLMWcnr22Oey80sO+
         nvyrZ9E2y4iYEJC0q9a/KQ/92MsSl2zWdF/Jor1r2OXgk9rEHd3M7pHAEBq2SoHzUjrk
         kwXmywsH6tpyxIT8+TGVacYn7rHrnO/prC9FP4TjTMHCaNVRchGcYwNbXqSn4cYCawa+
         R3pqceV+G0PXr5xS4CUczkQiGtvhxNFZs30MTihlsAPaq5qGliBiyqRGoNQZFz8wykSj
         MAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331523; x=1789936323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZU3Q23MVCxor1flyXhWl24CciEpY/YSKjCKIGZyGQ9Q=;
        b=cEBVExxzi+xhO8XH1uwn7JXuzrHtvjChsHvg1W3gVw1jyFaZB8sBRRGJRkLgLc+szL
         VptBSl3S/qf1ejuJYynLR+vfE1HzWAFBpu4yBgieasg/rp4M+/sIXNtOAUkwbSwLMY1I
         0AUqAsIYYRlBW+cABRasyQpj4TtMnW5K+jO36k+d5gLykGCm3iuvG3CI0BKGj4R96+KK
         uqtDPePYCEV69t8L6aGnZSvvPFEdS9VVWXveZ63dCgMRaX6JZu0rSjqtS4y86mOs1NVL
         B5DMTXi7a8W57dJZ6oYURAJzMASOxqRTQbMjsWtwQPVr2BM2uI20tNor0qcGqNJYEi43
         YS5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxkzoPw4Zplgb/hey3iqYvPIIscQrmQhvbGkoaR/TQbvc7u6zkSPAB3eG7sTLXyxt5AR60tPMPgHWQqEJz4q/59m6w=@vger.kernel.org
X-Gm-Message-State: AFuF++mLvOPuvA1TVFJB1n51lWIkucsKYSOMrkvWc10wtO3edcVYGqe4
	szMLmetzSGicBhzMtPW2M83a2+KVSyoJGKak4Kp3SXObWk0jT1hYBPI=
X-Gm-Gg: AYBFou22RnDVFtf/mAjQWCNqLz19AjYLn4L2wjV99YwCMMTsD7RG+Kj/Ju4MdSiw2AG
	rcWDtO3jeDTq21gzBfCbTKDlQGKfyiQBTLFtEuJcwFHsp1/0aftfhAoMSTYyrR5yb0wWuLFgvmd
	TDtARhWKBBBWsthEQcqEOIrsn0lhG10DUJQS0EX7I00XdOmgzZSe1+yzOY8LZ2ckdhDrAlWhLY3
	QUxUYXxk/SrmR6rWJut94k3CVZRz464iMLfll6Soj6Pno/qbPhW+MLD6vGpB9tglrZ+/WwYTuV+
	0WuDvWp0jhiJMGJbD4ju6eGyE4WCooAl034IMj/+dvzxy8TxXBVVb57vt8NjU13NfqovjyInHNC
	ji1zjGwzEc4tXo47H6Ur4cH7VUcnW04Cu3TDQ5EF2+uMh8wrWm4/AcQ9uGM2WDPW5IusNhSVkcW
	0H0FSUGyizQj/UEyTtRCJyCUn/U5grsLJ8eLeLGVVu43yTcQ/nahLSIYDNLhF2cp4xGkoFEvMSn
	zLHkA7+Q8i0Czuodpez0nI6xQ==
X-Received: by 2002:a17:90b:2587:b0:398:c6e8:3fc2 with SMTP id 98e67ed59e1d1-39dd551129fmr4152542a91.4.1789331522752;
        Sun, 13 Sep 2026 13:32:02 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602d8sm16770028a91.3.2026.09.13.13.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:32:02 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH] tracing: Don't log an error for the speculative field variable lookup
Date: Mon, 14 Sep 2026 05:31:56 +0900
Message-ID: <20260913203156.941433-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hist trigger that installs and works leaves two errors behind:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' > \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int prio' > synthetic_events
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)' > \
      events/sched/sched_switch/trigger
  # cat error_log
  hist:sched:sched_switch: error: Couldn't find field
  hist:sched:sched_switch: error: Couldn't parse field variable

prio is a sched_waking field, so the trigger installs and my_synth
fires.

trace_action_create_field_var() tries the target event first -- "First
try to create a field var on the target event", as its own comment says
-- and falls back to the onmatch() event, which is how a parameter taken
from the matched event resolves. The failed first attempt logs through
hist_err() and nothing clears it.

Silence hist_err() while that attempt runs. A name on neither event
still reports, from the fallback, and the write still fails.

Fixes: c282a386a397 ("tracing: Add 'onmatch' hist trigger action support")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20260913122523.30f487d9@robin/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---

x86_64 under QEMU, CONFIG_KASAN=y, 4 CPUs, base 2f0c1cf72f46.  A histogram
on sched_waking keyed on pid, an onmatch() target on sched_switch keyed on
next_pid, my_synth($wakeup_lat,ARG).

  ARG         where it lives      unpatched          patched
  next_prio   target event        rc=0, 0 errors     rc=0, 0 errors
  prio        match event only    rc=0, 2 errors     rc=0, 0 errors
  nosuchfld   neither             rc=1, 4 errors     rc=1, 2 errors

 kernel/trace/trace_events_hist.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..4676dc6d9146 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -806,9 +806,12 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
 		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, HIST_PREFIX "%s:%s", system, name);
 }
 
+/* Set while a field lookup may fail silently; the parse path is serialized. */
+static bool hist_err_silent;
+
 static void hist_err(struct trace_array *tr, u8 err_type, u16 err_pos)
 {
-	if (!last_cmd)
+	if (!last_cmd || hist_err_silent)
 		return;
 
 	tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
@@ -4003,7 +4006,9 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 	 * unqualified fields on the target event, or if qualified,
 	 * target fields that have qualified names matching the target.
 	 */
+	hist_err_silent = true;
 	field_var = create_target_field_var(hist_data, system, event, var);
+	hist_err_silent = false;
 
 	if (field_var && !IS_ERR(field_var)) {
 		save_field_var(hist_data, field_var);
-- 
2.53.0

