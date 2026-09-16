Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E14F052C;
	Wed, 16 Sep 2026 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558059; cv=none; b=KasDEw+2AUCgLc9+KBCrHV6wHx31A1mbdbgKMwp1xRRmRNuG2k8AkJlvNciT0GsoTOJQ25zTEZT3JEQQaPPK86fGbTZcWkvu2iU5z4PJTu/MApWCR0gjuWfAVV2POnTzlr4GaIbZImV9M0G2fxcKdheOWlbszkXHZQKJvzOu8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558059; c=relaxed/simple;
	bh=8zjUgW6amnuN9dj9I5vdgo0AGdHmP/g55azg8hAMr50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJdLoe4VPU0hHuMMkXQx6yHPaM3CDLcFxzfOcRjVf7TKQ+tlR0N11ftXGSD7SJh9ql78FJeND0AqXCfn1VxnmUGqF1/9c2knvV+55vWAZK1eYyWlQDtjGWC9XhREKSlxJXVb1GuwAQsRjQk3MFEuno0AsFCrorFbztpwVPHsm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MczcNX24; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RSe9Pw/X; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MczcNX24";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RSe9Pw/X"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hlGnH67bSzMlMn;
	Wed, 16 Sep 2026 13:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789558019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7RWUaxk3vDTkcUr+LyAqRL8DC+7bpavVyHD0uMsLGI=;
	b=MczcNX24uETTWwnGFfjlTywRJ8nh9Ld+AEss/YIzm2S7HqpKEHB9dVNJf2XOeT9ZNDU9aH
	gBv54TrglxNao5twwqiXVD6jGgnj6cbD5BhWnyz9qtM8uz0qqkW7/nrJ7esqodsTfPTJkF
	8R6n+w/eNP1BKOpf3utGmVKDe0Komvsd+9nfk7fMEM3DLs+nVP0mwjFTlsGMp36p9xo95g
	5Wmn2j/kciy4emx4CVFDvUuERsmno7D5Q3nk9xTZRY0tg5vHZN9pFQXyFXUbo0OBVnaxqA
	NDxncMW3yG/Me6Oqvh3oiwDmVjevjEpm9sptXBLnq6s36xOKFkJlam/EUarFJg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789558017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7RWUaxk3vDTkcUr+LyAqRL8DC+7bpavVyHD0uMsLGI=;
	b=RSe9Pw/XsWNKdwO8korx6xuy8pueDxMvncOEXId2SvDbajFruX+RmLg/JX1jEZJPkNdx9n
	/eh4W7fu8cDnhmKk0SXewJ21w43Wf1r0c9AkvWlMTsI3q1xXFSEJm2TAU84XNRKkL9MIYV
	qAthYf4TzfJkD3/B0KUnnDnMmz4AmNKzqx5fNl/Qr2HORKYcScmVSImSY8MlD0hJtn+q++
	RYSREfSGIfcAG5lTTzx/1A4Mp9amyDNvvHytd3Od0890RttyXLsrwBjvLGUjQw9L+DEdgf
	/NS9OUrFhF3Or1nklfccNTQM5fJhjDEjII4uWA78fiwmIH03JlMmt6vRLKiUaQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3] Documentation: trace: histogram-design: fix bracket, improve wording
Date: Wed, 16 Sep 2026 13:24:30 +0200
Message-ID: <20260916112430.303874-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mqxkmzw6941courbaqarmb4fn1qruedx
X-MBO-RS-ID: f3e2aef2917eb87312a

Remove needless ')' and put replace line with code block.

CC: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
@ Steven, sorry, I coudn't figure out how to implement your suggestions from [v2]

[v3]
 remove line with similar content as code block.

[v2]
 add paragraph and code block.
 https://lore.kernel.org/all/20260903071105.714325-3-manuelebnerli@mailbox.org/

[v1]
 https://lore.kernel.org/all/20260902151032.706407-2-manuelebnerli@mailbox.org/
---
 Documentation/trace/histogram-design.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 41a726cd3..5c5748928 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -876,9 +876,8 @@ next_pid field on this sched_switch event, we retrieve the
 variables specified in the wakeup_latency() trace action, and use
 them to generate a new wakeup_latency event into the trace stream.
 
-Note that the way the trace handlers such as wakeup_latency() (which
-could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
-are implemented, the parameters specified to the trace handler must be
+Note that the way the trace handlers such as wakeup_latency() are
+implemented, the parameters specified to the trace handler must be
 variables.  In this case, $wakeup_lat is obviously a variable, but
 next_pid isn't, since it's just naming a field in the sched_switch
 trace event.  Since this is something that almost every trace() and
@@ -916,6 +915,13 @@ means it will be automatically converted into a field variable::
           onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid)' >>
 	  /sys/kernel/tracing/events/sched/sched_switch/trigger
 
+Note that the above is the old way to trigger a synthetic event, whereas the
+newer way is preferred, which uses the trace() action handler::
+
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
+          onmatch(sched.sched_waking).trace(wakeup_latency,$wakeup_lat,next_pid)' >>
+	  /sys/kernel/tracing/events/sched/sched_switch/trigger
+
 The diagram for the sched_switch event is similar to previous examples
 but shows the additional field_vars[] array for hist_data and shows
 the linkages between the field_vars and the variables and references
-- 
2.55.0

