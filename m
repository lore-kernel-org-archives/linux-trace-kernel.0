Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362925;
	b=N/+jE3cANgXnrpJi7lsvw7zi3ia4QwVc1Cryh0Inp5hiEs43tUkunCP5hOqoeGC73ISP
	 DFHFK8EXlMyanj7uAqEoL/uYF8yRBRaCH9HZWHCiDI5njTxXuaEggbsT+2/zOm+5WGXs9
	 N+rDnmhLAJcRdzum1X24ftsquL45SdxoqACigoWDSIil0B5vuA4EZZ38caqNv5PZreoFi
	 woAXWzWgwFC5tpsmWPEMWS2yc9+XYVgUVztPcC3vtfGzma+5IQpR/3djrKDFLfEqH0C4g
	 kw7NnmX4A3mq4QCbEx+KR+m71tFiS9OlwRULOwJTMD+2cPBPhzXme15rNB8KmAGVH1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IqRkQAWA6x79NK/foSAYp+LfNrOBVrF5NDpnzdsePVo=;
	b=4drRuQSjmjivkVui5bc47EHBaZZxy4r87EowDEJYmRgANwk3YYhL2kIEI5aS5CFJYO4U
	 DaQOb1iaSW9RR87CP8Zz6ib7a1YU7xBAlvzlxTKzHKOyY7D+emj4mQhTnJxv1g1C51daU
	 6y3IyDMPjwR855a94HkrbuRmvqBZub8zGneF6ocwNzduDyUgtEtVT7Ha8DLFR+SbMXfHm
	 63jy20S5t4XRCT5mWqVMcKf5RQuPG+KfSC+ARMwbSo0wMepcWvpkKICmCDQUAEB7b7fZx
	 h/LGwDJqao575WhNbnpq4vmF4JoJrCwbhX90aYdotSPtq6GZzKopTpPCG0oQaImbQKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Y/RzuCcz";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B746606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 02:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B746606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y/RzuCcz
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3719e3cb82bso7406eec.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 18:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362924; x=1794967724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IqRkQAWA6x79NK/foSAYp+LfNrOBVrF5NDpnzdsePVo=;
        b=Y/RzuCcz11gPiJ4voG226bkg8toO3K9UlJWCo6HoE5c4W9tW4fL1ED84UmKoUc8Zu7
         tBfUzu3oObPhDBJOUpY1HzB5owa8Tz9wFdmGoOo9aga8JPTAxoLQoMMNwtizl0iHD/dI
         L2UAyV6V3DV5OtOq1K9ZQRqdMUqphgZu5u850yXGYA4wUDn/ajyvB9ZbveC10Zp2pSve
         /eULW8xTqz3yWc4EQoVlhFXMbQQBVbjQKsvqnesPnHzzf8A5aUWG8keijou05OsplmCf
         2ckmmhCAIuU24zVnf6llkJcprGLCjdw3uPtvgjjQyK37KX9BqUNkNS6a7fJkHxr6iKzX
         A59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362924; x=1794967724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqRkQAWA6x79NK/foSAYp+LfNrOBVrF5NDpnzdsePVo=;
        b=q3Mc0zfTdImWwNW8Ts9HyxtRjJRK/tCp4YQtGMJb4uqxFk1Bu1jtm2Z4gK7xu7uF00
         yd/xhPaTUhRFCGrLjwXrBS2+dWgqiwpokZ+w7QVAzY4WW2S8cv+2BXBayBewCGZmzfS7
         VbzCMkkj6NhQ/tI4zIDvIRb5klAxAS+KlAqeqPJjM2cAP6Yf54FJU3xg9NXf/guzVKoZ
         UcYc3CpnIEAWaA3UPCb839lwEBdmRTHcjNCc+/yEgnfary5w72POxQL8PYL+r5gh0NK+
         ZMWMPSmGK7vQu1KbHoeOKF1iLdNPsxlFz26e59+BxGtOtY3ve/Ibo8r7vAFszkcDYIgN
         jA/g==
X-Gm-Message-State: APuU4Z8xD4bKj35OUtNtQ/Wt/ooLc8wb81cDQLNDXlCc7OuM5JCdTaj9
	j+4gUBNn5MUOJj4rjeR3lZV6xhmEHGeqPgP3iFqChMZamhiBWNKzrgfedID6boDxm24=
X-Gm-Gg: AYBFou2A1w8wOkuczo2DRRm0A3dv0V4bjTiifgj8ew07VxEwCwphF25k/zqrBdlTQWh
	KwdRrfDVaKDbED24GTfylBzbcE6Sw39Ya7eZMZ7RW25srNWMstKCMqmWlzvoZyQWROgeqmimmkz
	8Eup13lNzwc46bh0rTXZBRUsZMbm0ij8gil+yQ4psJrQM6Y1yi9T2xir1KB/gFx3LGnVALvrOLu
	/FB5WQwgj5R+xueUXOFZnb/YrfM+rEl73zuKq2JH9+kGyQZwNP/1Syf9W93+HHz3CtvJsAkv66B
	jQOZxY/9hy18kStu6vWUEjBtY3JYMtSgPW9wlDLZGyIQt5zjdTnGAwWgSCGx0glG1T0zSPgdgAh
	ukG1X+MhDiOxPFIIjSNKZ7FrToCz+wz4L6BBAd8mWsITxOpUdl8/HLBMI+fkJPmA1iBfKiyjqig
	77SVMyYlHpi/7pCqDck+EVzhSrZAF+HWNZJPXn1ePwpaJMRDyiNqQMri+Ibzqzy5bPuBS6BAEWs
	usXYvwTDp+OeLlpPjRQy8AsYkI/2lJ19oi/6OGK9aGcFdKz99s9PRbFhr/ZuH79X1kD6xEk2qLX
	Wmmh7Wh7rQwbLe6ZqwGjJOX/X+GffH9mmFZahu0VIcCjhzUawLAjEEo=
X-Received: by 2002:a05:693c:20cd:20b0:375:f846:5b3f with SMTP id 5a478bee46e88-3767fe8f34bmr2355849eec.0.1794362924193;
        Tue, 10 Nov 2026 18:08:44 -0800 (PST)
Received: from mi-ThinkCentre-M760t.mioffice.cn ([43.224.245.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm12644625eec.14.2026.11.10.18.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:08:43 -0800 (PST)
From: Wenwu Hou <hwenwur@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	frederic@kernel.org,
	Wenwu Hou <hwenwur@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/hwlat: Bind the sampler kthread instead of setting its affinity
Date: Wed, 11 Nov 2026 10:07:55 +0800
Message-ID: <20261111020755.1422284-1-hwenwur@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

start_single_kthread() sets the affinity of the kthread it just created
before waking it up, but kthread_affine_node() overrides that mask on the
first wake-up. See commit 60ba9c38b931 ("kthread: Comment on the purpose
and placement of kthread_affine_node() call").

In round-robin mode, move_to_next_cpu() compares save_cpumask against
current->cpus_ptr, sees the replaced mask, and switches the tracer to
MODE_NONE on its very first iteration:

  hwlat_detector: cpumask changed while in round-robin mode,
  switching to mode none

So the tracer no longer migrates across tracing_cpumask. More importantly,
tracing_cpumask is not honoured at all, and with isolcpus=/nohz_full= the
thread cannot run on the isolated CPUs it is meant to sample.

Use kthread_bind_mask() instead. hwlat requires exactly the CPUs in
tracing_cpumask, isolated ones included, so a hard binding is the correct
semantics; the PF_NO_SETAFFINITY it sets is precisely what tells
kthread_affine_node() to leave the thread alone. The in-thread
set_cpus_allowed_ptr() in move_to_next_cpu() keeps working, since
PF_NO_SETAFFINITY only gates the user-facing SCA_CHECK path.

The mask is now computed and validated before kthread_create(), which also
avoids creating a thread when tracing_cpumask has no online CPU in common:
cpumask_first() returned nr_cpu_ids there and cpumask_set_cpu() then wrote
past the end of the mask.

Tested on a 4-vCPU KVM guest, bit 0 of the mask is CPU 0:

  mode        mask    before                    after
  none        0b0101  Cpus_allowed_list: 0-3    0,2
  round-robin 0b1111  mode -> none, no migrate  migrates 1 2 3 0
  round-robin 0b0101  mask 0-3, no migrate      migrates 0 2
  per-cpu     0b0110  2 threads, cpus 1,2      2 threads, cpus 1,2

Fixes: d1a89197589c4 ("kthread: Default affine kthread to its preferred NUMA node")
Cc: stable@vger.kernel.org
Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
---
 kernel/trace/trace_hwlat.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 3fe274b84f1c2..65e184d800ff1 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -423,15 +423,12 @@ static int start_single_kthread(struct trace_array *tr)
 	if (kdata->kthread)
 		goto out_put_cpus;
 
-	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
-	if (IS_ERR(kthread)) {
-		pr_err(BANNER "could not start sampling thread\n");
-		cpus_read_unlock();
-		return -ENOMEM;
-	}
-
 	/* Just pick the first CPU on first iteration */
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
+	if (cpumask_empty(current_mask)) {
+		cpus_read_unlock();
+		return -EINVAL;
+	}
 
 	if (hwlat_data.thread_mode == MODE_ROUND_ROBIN) {
 		next_cpu = cpumask_first(current_mask);
@@ -440,7 +437,14 @@ static int start_single_kthread(struct trace_array *tr)
 
 	}
 
-	set_cpus_allowed_ptr(kthread, current_mask);
+	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
+	if (IS_ERR(kthread)) {
+		pr_err(BANNER "could not start sampling thread\n");
+		cpus_read_unlock();
+		return -ENOMEM;
+	}
+
+	kthread_bind_mask(kthread, current_mask);
 
 	kdata->kthread = kthread;
 	wake_up_process(kthread);
-- 
2.43.0

