Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE243F12C4;
	Thu,  3 Sep 2026 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419625; cv=none; b=Riw/yN49FawQEYv3jOd/mJovlFmCjm6yE4cuVG3Y5+EO3f5WX8aIfpu9d5wAhgi6xlAGH4tOEHhsMbbjMVu8E4iAVXz9Njk6X5ly7D4gWVGNMT9sb/r4kOZTpyDFFtjEj0XLwDKRBKclOVktqLS2Vsohe4HQInQTfUOvt35iDXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419625; c=relaxed/simple;
	bh=Lx4HaE9/zI4yZt20nbJr8PLbaPbxanYfNMyZ1nBAmxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERNvy8H3HwMJ2cU2nUgcLB5FxfsWmLQ6g/eId5ykhS9CrOwpnW4dC/25SNkdv9HPwGwIOrOFxF6rQu+aXNngw0JIEL+ZLguVgx1O/LaWQSJAdL6/vD7AFavy6H5iwLMLiNCrSK0B2Rj4Ra+kSpOGSIv9VC+8yfRyzOM0ixN74vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JpyWLiSV; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Si8KeBPB; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JpyWLiSV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Si8KeBPB"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hb9mx1KFjzKw2t;
	Thu, 03 Sep 2026 09:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788419617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhVzuNfs214pBfjxrEWTK1wGYLUc4myD0XNH0Nog408=;
	b=JpyWLiSVouzuNePf0RYJPJjfgm6hQi9u9bOkMSv2ZwuyEbqML4i7xB9Gnn/oMpBzBJi9Ly
	07wphsgMD0e6U0arggyIHd0J5fG8rfeNh8c6AMf9eA4T2tnlbqrDH1gOBV/cgRJyQ5Yw9G
	jhAUFJMqhaljxcm918ctjT87HsM++aANNnE2FXTMLNzRDCtgSgrQizC364XebW9jSVuOgJ
	/AoCf1iL0NuErsvhFeUW3vxhYBLibgz7gJdeK0layTAIBLx1c7HYkP98yp4e04odF6OjG0
	DtYD1cPQNSnDsGBknDkEvlWEK7Rw1n6fCdEdG2vaKboKaItP0/+aehubby28yg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Si8KeBPB;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788419616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhVzuNfs214pBfjxrEWTK1wGYLUc4myD0XNH0Nog408=;
	b=Si8KeBPBD7E1o6ad6JHPxy2+biBTjQuqPnVYELCCL2S6+O2jByvWpjJqtP1PVs9S32eELp
	sRYPdVSfQFUBlwWtO5gEEbmXGJsV1xRXqOS7SBJHfKeOO9vN8JOTu6QXQfyAhjpusNTzTx
	J+ILqpWmnOtTA6FvifNZsHMAT/8gUXAsh/vXl6lWPXtw3KJ162lu8By7pPtbIZ085if2L2
	swVe7XiHcrxZTxC5LSkPKE4vh6sv2S0q0jIgRvIeGIdNXgF5aJenuzlsvllTdB1bVneJc6
	7L2FS8hgRN1Zdjq/56/MyV79yp73ACu8CsfDndmhM52xd8PZi7ssbiax6ZTvmg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] Documentation: trace: histogram-design: fix bracket, improve wording
Date: Thu,  3 Sep 2026 09:11:05 +0200
Message-ID: <20260903071105.714325-3-manuelebnerli@mailbox.org>
In-Reply-To: <20260903070249.713483-2-manuelebnerli@mailbox.org>
References: <20260903070249.713483-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7r7bpx36cphoewr3uqb6817abkwecypd
X-MBO-RS-ID: 772a1b30ccd34e4c01f
X-Rspamd-Queue-Id: 4hb9mx1KFjzKw2t

Add missing ')' and add note about the new way of triggering an event.

CC: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
I sent the previous mail on accident, sorry.

@ Steven, I added this line to your suggestion because else the references
wouldn't make sense. References: $wakeup_lat, next_pid
Let me know what you think.

+ ... (which
+could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
 are implemented, the parameters specified to the trace handler must be
 variables.  In this case, $wakeup_lat is obviously a variable, but
 next_pid isn't, since it's just naming a field in the sched_switch
---
 Documentation/trace/histogram-design.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 41a726cd3..c0271463b 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -877,7 +877,7 @@ variables specified in the wakeup_latency() trace action, and use
 them to generate a new wakeup_latency event into the trace stream.
 
 Note that the way the trace handlers such as wakeup_latency() (which
-could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
+could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid))
 are implemented, the parameters specified to the trace handler must be
 variables.  In this case, $wakeup_lat is obviously a variable, but
 next_pid isn't, since it's just naming a field in the sched_switch
@@ -916,6 +916,13 @@ means it will be automatically converted into a field variable::
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
2.54.0

