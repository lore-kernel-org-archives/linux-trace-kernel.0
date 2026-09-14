Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9143D4EA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382447; cv=none; b=MPcoxEj8J3BtLC4+DyTnHQppFALcjeMPKMa1QektBV1pDs6A8BItoOURxoo2gK4ZxglsiCGFAcLdR1mfYg8Z0KPp/Hc23U8OaIoMXX9twx763keqWZP1nLBC6qVKRzw3+FY3jfSwILnlG2je5Qz7u8Dw28JpO53D5p95HFChFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382447; c=relaxed/simple;
	bh=GoNTHpmWIseG1FgYRLB02Ui/Fmpaj1eRK8oQos1DfcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxJwH1vFj6MSRU7TsUB2XLMOnrExaO8Zf0r/D5UdXTNUTQz/1/BTXSq0JFOgFgPIHeKyBOVyPPhrCuroPRJZ4l9aQNZicL0N634YZJ3eQghwVu/2x12W6jffU1yA/srXsiwmln3SCneLokN3S6FUx87hyuOxQpk29Cb61M4bqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PImXslXg; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PImXslXg"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1236806a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789382445; x=1789987245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITP8YnoGoJGYNciFDsIfLG4MQrrfwApvPNq3/p06wBI=;
        b=PImXslXgcVTPsaQeH9zV4Oo7BpaJkQH3T2XdZ/Xi/OS+GbZbUxE3XUEjdvljZFwO5S
         7KoDdLlRS+0J4tiQpgVJL00ogkw1giGs0wY2uBsOampXR3JwGz0LQ/Opqd7yJmiBkHLu
         fqz7cAEC2u6i3xTkz4c/yisC13oSCXDpG6C7WKf2Es5Zem7Z04FfWQOONiHnrZ1PHvyT
         Odd7xWezxrJjD6kpRsSqJ8fm/bx0ofZJcvWLzwKTLFLS49PiujPKO1kokMMTYFrP1AJo
         DjW/oflK+oM3yjTaiMO58QbOizYU/r4cVbrTBpYSIRtPYXkX+h6auAQzTSc5YozJa1Fo
         mHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382445; x=1789987245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITP8YnoGoJGYNciFDsIfLG4MQrrfwApvPNq3/p06wBI=;
        b=PSqkVT68k3SNwwXxp3M9vsNfbjl0mR73CZma4ZI5DofAkvjGKfGiQpr1YWl+2ATAcy
         YD9jLcesEuThWdLRuRplT8J4JBzf3VT1M+f+MGvXZNCE21AJUBA91KbOY0dOUbIWiFCf
         L79CCWM3xRxXybdVG6PlpMed+i29/laH//qEA2Xo9+9EXTlXHhR6NUrCTEL5kkvrImeU
         1EfCHcE8YMY5xN4h/T9fAEBX+ImKfSzMjLxQgnTmpzPyzVT2mF4F4FlT81m7GFo+zw/P
         Sl6zDfakfktd2kP5/PoGhGA+65KIij0mlM35CV/vqYLfi6ERAF4O4NIXgE06qqViD4pb
         VDdA==
X-Forwarded-Encrypted: i=1; AKwUvBzAaLCGCrViYfTOnVospLb+htAKYQ4Z7Uz0quLS49MFiJBKV1qMnKF2E8fwmMq9+JtvpUzYOw0BbKN+Zm/lUrmgr/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lr7bNwdDxsCZrhmr/rku4wPjGswG7u+piqPUF/jKDf2yspDH9n
	3TPyWzn2D3oZ5TU8pIi0wPq1gYUsxou32lMXmtG5Wa/tl+d4QLWbPpg=
X-Gm-Gg: AYBFou1tNxV7nwPGUSnGHJPVeL46GyLrLjI98LL19vUvtALtuXx4hhw2sSUGvU9waXb
	OW+SmkeQ7VDH5SyFnp+zmAxidRNXC8HrQ83Ca1MxCoC1Fi/yqOhbvvKm5DmFwwdEtBW5uGGZNpY
	GHBO0GKgQ6GJCVZMDXDSF5zDWJZzeUH3MHyOMSdsiFP23iJxgsvSX8JccntKt1IBJCtd7kJdGtc
	JZLTO5tzukLZVWvds1xq2EwlTYIfDep2HTm9pN8Lo7h//Q8IP9+bb4cffMmpKwsxbZksfqde53Z
	Veo+ohD6SVa3F5Q0GIR3JM4lOo1JAQyTXXDixeoQQrUhBJj9AfUmEdOlZzJn2uogGmkrMJWsVKU
	ITRWZlB2Sb6wobIgER/bPIo/tfVdVtAg0iRvAAl04rqfXXJeGUZ6AqNKKxr4Yo5gLtretS+bALz
	wzTFNQQL25Y/uLHx7m1i6WkHB+5Z5Rvtn0akbzSqW11Qx+3K33ciAraNbwbtyCawn8UyQvW+s0D
	r2me9JjUcr9fibIt6Kn8hQBqRM=
X-Received: by 2002:a05:6a21:d83:b0:3cc:c7cf:5a44 with SMTP id adf61e73a8af0-3db4037ccfcmr4309572637.2.1789382443334;
        Mon, 14 Sep 2026 03:40:43 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c652aa9asm4632560a12.9.2026.09.14.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:40:42 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	zanussi@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH] tracing: Unregister field variable histograms when the command fails
Date: Mon, 14 Sep 2026 19:40:36 +0900
Message-ID: <20260914104036.1768529-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An action that names a field on another event needs that field as a
variable, so create_field_var_hist() registers a second hist trigger on
that event to provide it, and records it in
target_hist_data->field_var_hists[].

If a later part of the same command fails, create_actions() returns an
error and event_hist_trigger_parse() jumps to out_free. The write fails
with -EINVAL and sched_switch gets no trigger, but:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int a; int b' >> synthetic_events
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio,nosuchfld)'\
      >> events/sched/sched_switch/trigger
  # cat events/sched/sched_waking/trigger
  hist:keys=pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global [active]
  hist:keys=pid:vals=hitcount:synthetic_prio=prio:sort=hitcount:size=2048 [active]

The second histogram is the one created for 'prio'. It is still active and
still counting.

out_free reaches destroy_field_var_hists(), which frees the
field_var_hists[] entries, but never unregister_field_var_hists(), which is
what removes the triggers and runs only from event_hist_trigger_free(). The
entry is freed and the trigger is left with nothing tracking it.

Unregister the field variable histograms in out_free as well, and record
each one as soon as its trigger is registered rather than after the lookup
that follows it, so no exit can leave a registered trigger untracked. The
entry then belongs to field_var_hists[] and is released by
destroy_field_var_hists(), so freeing it on that exit would be a double
free.

Cc: stable@vger.kernel.org
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260913204302.DB2551F000FF@smtp.kernel.org/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Tested under QEMU on 704340f1cd0d, x86_64, KASAN + PROVE_LOCKING, 2 vCPU,
unfixed arm first.

  command                                      before     after
  valid onmatch on another event's field       works      works
  removing that trigger                        works      works
  onmatch with a trailing bad field            orphan     clean
  the same bad command, five more times        orphan     clean
  two field variables, then a bad field        2 orphans  clean
  '!hist' that matches nothing                 clean      clean

orphan = an extra [active] histogram left on the matched event.

ftracetest test.d/trigger: identical per-test verdicts on both arms.
trigger-synthetic-event-dynstring.tc fails on both because busybox execs
its ping applet as /proc/self/exe, so the test's grep cannot match.

The exit that reports a missing synthetic variable is not reachable
through onmatch, so no run covers it.

 kernel/trace/trace_events_hist.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..90e6e3990c25 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3134,20 +3134,18 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 
 	kfree(cmd);
 
+	n = target_hist_data->n_field_var_hists;
+	target_hist_data->field_var_hists[n] = var_hist;
+	target_hist_data->n_field_var_hists++;
+
 	/* If we can't find the variable, something went wrong */
 	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
 					     event_name, field_name);
 	if (IS_ERR_OR_NULL(event_var)) {
-		kfree(var_hist->cmd);
-		kfree(var_hist);
 		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
-	n = target_hist_data->n_field_var_hists;
-	target_hist_data->field_var_hists[n] = var_hist;
-	target_hist_data->n_field_var_hists++;
-
 	return event_var;
 }
 
@@ -6980,6 +6978,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	trigger_data_free(trigger_data);
 
+	unregister_field_var_hists(hist_data);
+
 	destroy_hist_data(hist_data);
 	goto out;
 }
-- 
2.53.0

