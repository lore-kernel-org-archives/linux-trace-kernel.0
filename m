Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602925;
	b=QoGOlJDX8xPzfuKpZvj3imR1fkxELdgiAbxR5vM8lNmoUGdajTpxgokRvPFwshwZIwjc
	 FUwm36tn+eR11hEYoc8F727epnOehA0kZ52zwu2FeBbLcR7SyaCGHTb3bp2+UR+TzrfP9
	 Bq7o6WExluVzHprkp65vi2kA6jQzHx5hw+oSI/8YhRuWPQszgUKIevw4Y4m3xxxVYP6zk
	 4pTkGUc22pgqbvBHBJZBO77kEBgteP2bIs8KfV4c54NGZhB9dHv26rTKiBLn5sydNTQTf
	 iyNKcnJtmG7uJXTsvVpdBVriIVkCSCncf2G1wbt67JL7/y9cWY/MDww5l1FBYzDh+ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602925;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=o3unYrqPCzOkBcZOxi4mzaJllESmWrBv+ToHLviEttE=;
	b=cWFd1G6qaYHs985r1Hep2EhjCwUffy5VMGVF3WZR0M6vPBnhp+99UKUBgQCWTR641SiJ
	 vGrDFkKgWZ5BNhV2HHndkvov7jIzYl2GEjDIKqz3zCq8JSY/GaOvn71+TEhiwhoJYXoi6
	 UPEpfVttpKtFHV8oo/HbRhryWyb+ERtNkVaSI6F0k4gMRN07H676yhzY1WdQaWao7bmBz
	 8eiumPrUFFJ1G3+9MDSA0Gm7fq4IANo89rxmTX4CFOfCYXVP55FSrDy9407qrNEnsE/Rc
	 b/UekEqusmRRU1fFSFFXjUzR63mob+gg4q1PI/lCavED/gs33udZqByteaNgoIl8YhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RV88SlN1;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4F606A32F;
	Mon,  2 Nov 2026 07:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C4F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RV88SlN1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=o3unYrqPCzOkBcZOxi4mzaJllESmWrBv+ToHLviEttE=;
	b=RV88SlN1JKsjaJSFcbAe7/KUJ8evmlhLyalceJg19oHR4+TowhGe0yCHFGFLdl
	E1scwJMluYHOt832sXTV63nROH41Oit71/HyZTfVimGVLu1c0jv3sH0HGuMH6kQM
	eoBsJBLrxk8mWMEnvAhB07sfQFaysskdmUDn/nMX+gYaU=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: test that events are rejected without --trace
Date: Mon, 02 Nov 2026 15:01:31 +0800
Message-ID: <179360289114.124676.17105773066185078008@163.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDH17BdNehq7sfwDQ--.60071S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr15Jw4kZr1rCF13tF48tFb_yoW5urWxpa
	90vr92yr1DGan0vw4rur18AFWDGrZ7WrW7KF1kGw1Yyry3Ar4fGF4xKFy7XrW3CrWfZ34a
	k3yv9w12qa4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMq2iUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5B45rmroNV562AAA3m

From: Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH] rtla: test that events are rejected without --trace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
    linux-trace-kernel@vger.kernel.org,
    linux-kernel@vger.kernel.org

-e, --filter and --trigger configure events of the trace instance that
--trace creates.  Before the previous patch they were silently dropped
when no --trace was given, and the tool still exited 0; the tests here
pin down the messages and exit codes for both the rejected and the
accepted cases.

hwnoise.t already covers the success path of -e with --trigger, so this
adds the failure paths only.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 214fd40..ce9ff3e 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -99,4 +99,20 @@ check_top_q_hist "with conditional continue" \
 check_top_hist "with trace output at end" \
 	"osnoise TOOL -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
 
+# -e, --filter and --trigger only take effect with --trace: they configure
+# events of the instance it creates.  Without it rtla used to drop them and
+# exit 0, so a typo in an event name went unnoticed.
+check "filter without a preceding -e" \
+	"osnoise top -q --filter 'prev_pid == 0' -d 1s" 129 "has no previous event to apply to"
+check "event without --trace" \
+	"osnoise top -q -e sched:sched_switch -d 1s" 1 "need --trace or --on-end trace"
+check "invalid event without --trace" \
+	"osnoise top -q -e nosuchsys:nosuchevent -d 1s" 1 "need --trace or --on-end trace"
+check "filter without --trace" \
+	"osnoise top -q -e sched:sched_switch --filter 'prev_pid == 0' -d 1s" 1 "need --trace or --on-end trace"
+check "invalid event with --trace" \
+	"osnoise top -q -e nosuchsys:nosuchevent -t -d 1s" 1 "Error enabling event"
+check "valid event with --trace" \
+	"osnoise top -q -e sched:sched_switch -t -d 1s" 0 ""
+
 test_end
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 5116857..18d7730 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -153,4 +153,20 @@ else
 fi
 done
 
+# -e, --filter and --trigger only take effect with --trace: they configure
+# events of the instance it creates.  Without it rtla used to drop them and
+# exit 0, so a typo in an event name went unnoticed.
+check "filter without a preceding -e" \
+	"timerlat top -q --filter 'prev_pid == 0' -d 1s" 129 "has no previous event to apply to"
+check "event without --trace" \
+	"timerlat top -q -e sched:sched_switch -d 1s" 1 "need --trace or --on-end trace"
+check "invalid event without --trace" \
+	"timerlat top -q -e nosuchsys:nosuchevent -d 1s" 1 "need --trace or --on-end trace"
+check "filter without --trace" \
+	"timerlat top -q -e sched:sched_switch --filter 'prev_pid == 0' -d 1s" 1 "need --trace or --on-end trace"
+check "invalid event with --trace" \
+	"timerlat top -q -e nosuchsys:nosuchevent -t -d 1s" 1 "Error enabling event"
+check "valid event with --trace" \
+	"timerlat top -q -e sched:sched_switch -t -d 1s" 0 ""
+
 test_end

