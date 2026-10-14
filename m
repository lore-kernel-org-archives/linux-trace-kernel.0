Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED22D7380
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965447; cv=none; b=EBgUV615/zdQGkynCOFmRdezCdRSXdSEznjnNoAvrg2EZmvE28J0lMd5J2yVl6rI+TtlxPjjmFrTj4bWj3jq7xedas23nBP5ROOYX8E8Zw449fwCYrKAH311dvnVAnMrl55iBWwm7ghcMXq4SYC7m1veevJPj6x1EF7cHdP+UYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965447; c=relaxed/simple;
	bh=g6hFtLVrE/UjzzVSQQOzbX4cj/oiFJZYtfo2+FNowfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3iJCfe+PRSfv5DyKUc4DF5jTk1YSCg4CV5bzhxrhJ4JVp4scRJc3fpIZ7C8w83I2Zcr40k7C2/h0hoiE49Z6QhoPeCtw0jJ7hAzEFZzXeiGZQModw4aEhPPTCGvx3bVpUKMWertwjkooWGZPx0XxuWrUTqftrJWU6DsFsM0qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYnEJZbO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYnEJZbO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dd76b1361dso4798755ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791965445; x=1792570245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9mA2qoZtggQ/j/8me9B77LmzqnDxoGP/VtqAIm/t1U=;
        b=kYnEJZbO5Gvr3rfc9dhuvUnEeU1bw1gJ/TBYCnOkAO+upF6gjIuJJzTmlXciGFRK5d
         1gTqUNfDbxFMP5xMT47gD4h4DJ6Msr63aKdMIvQKKR1WfuV6PoP7VN7obRsPBRvS2hBf
         ovAFT+zFdqGwAsnDe2eCLwk+3Z/4/8938FntPpiYvOzfn/l6FdOqcxUvnHD7N/iQSZw1
         uH9yr2eHTbpkMGGgDIMMB/LYYXMm90zd0shZy3ibF3iMZOQEmw2dCF/eKNZYX5ydbteL
         41c6aHDo0TFjZDvw6RuP9/VaP/boVcmOD+nIW4HQyVbSthSDK4wnjL+BUIO9blPiKicj
         CPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791965445; x=1792570245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9mA2qoZtggQ/j/8me9B77LmzqnDxoGP/VtqAIm/t1U=;
        b=QWAFeD2ViTd2xC4Ab7yaILo9rHA/spTUW7ovs0zaNhL6no8fkfoTU6hSp2xvBh2E/U
         17lkVYo+IAzcUiCqKETfh4o7X7FDfA9T7Ops4kQSp4NLq5QbALaAnyx7I+xTk7qIDFkn
         5UUaavaP/z+lHS/4PpohK4MAIPNatM+lAUl7FZqvAVlGUkUVtQPlNdr3PN/gLeCyOTA6
         WryWJR+TGnwCmZE0DSfD4JjgXbq7dFMwSrbQX7b4IFIflVM/xBQMYGi20XYegiCBnOcI
         Tkv1RjJiRiWT5fdAHnbsNL+vNUYpAEVarxk/KMELzlyPBo43VS/qC1+MA7rGvJ/uqGOW
         0kXg==
X-Forwarded-Encrypted: i=1; AKwUvBzfc+iawqTQlj6TcxW9kwMqr+6Llj/SChYohWoqzjWT+wtsxrQWUe7ou71xdn/KblbALVIv0e40OnRLvLay6EaUUnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJHZ9vYs35en85Xfj8F9TTjQfREgEskhNcc7lkbAQ2XPEdh6K4
	knQG/nNFGS3T6nuSdjbsrSJEdfd1UH178fJ2NBUHz7Ai7Hk2lw30XmR8
X-Gm-Gg: AYBFou1K5+XvdlSUvVWQVxi31bmJqH7GhaEM1IShv4f27UH1spKjhUaRWgqUZbXhHWz
	MsyOz4ZsTgPeg/dNLk2AH196p/AztVOKManVod2C501R9KuUHEUTM38vuQbLJqGN46jHByJd0ov
	VOwBWGKVAEGjOZlUxHc4eERIodOvTKH9npr7vft5t6iCFTx7VajCAeVKlCc0YM4EtedtD8B66pW
	A3JrT0ZvOofbByGLvZ9ldgQJegBTA4+31mK0TNT8oTUSxNPntUy56o6QRq8Cp9zynZAGL6JMruQ
	SEGk88iJOvafNZDpQnS20nA5xk1OWj+WCvPDW9lz2PqFigdhacNdRYAo+XN8dqCgImws+4jfRsM
	9dH8v3Bl0Ooa6i87qFOvdaTWBzvOHdgr4uodRXy/lQpPCUmCVtLJzwtpCwS5vFnDTabQ8FWo1Q7
	BaSwOsf/yWVFuPVIlhjq9q0rWxsi8KP8MDSJ5LQL1Ygtrt+lCiTovRqW0mfYqJgAp2/mu25WuVe
	7QvLS9uF4SHiXma6A17Q2sZyryd3UHv6LHcPiP6R8NGm+g=
X-Received: by 2002:a17:903:120f:b0:2e8:e617:18 with SMTP id d9443c01a7336-2e8e617032emr63957225ad.48.1791965445086;
        Wed, 14 Oct 2026 01:10:45 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e2511sm65145085ad.76.2026.10.14.01.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 01:10:44 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/osnoise: Don't start a kthread in timerlat user-space mode
Date: Wed, 14 Oct 2026 16:10:34 +0800
Message-ID: <20261014081034.12702-1-chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In timerlat user-space mode (NO_OSNOISE_WORKLOAD) the workload is a user
task reading timerlat_fd, so there is no per-CPU kernel thread to run.
start_kthread() only checks for that in the osnoise branch:

	if (timerlat_enabled()) {
		snprintf(comm, 24, "timerlat/%d", cpu);
		main = timerlat_main;
	} else {
		/* if no workload, just return */
		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
			...
			return 0;
		}
		...
	}

start_per_cpu_kthreads() guards against this mode itself, but
osnoise_hotplug_workfn() calls start_kthread() directly. Bringing a CPU
online in user-space mode therefore starts a timerlat/N thread and sets
its bit in kthread_cpumask while OSN_WORKLOAD is clear.

stop_kthread() uses that bit to decide what the recorded task is:

	if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
	    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
		kthread_stop(kthread);
	} else if (!WARN_ON(test_bit(OSN_WORKLOAD, &osnoise_options))) {
		kill_pid(kthread->thread_pid, SIGKILL, 1);
		put_task_struct(kthread);
	}

The bit is set but OSN_WORKLOAD is not, so the first WARN_ON() fires and
the && short-circuits into the user-task branch. A running kernel thread
is SIGKILLed and its task_struct is put without ever being stopped, so it
keeps executing until it is freed underneath itself.

Any write to osnoise/options reaches this: osnoise_options_write() stops
the per-CPU threads before applying the new value, so stop_kthread()
still sees OSN_WORKLOAD clear. Re-writing the value that is already set
triggers it just as well as changing it.

  echo NO_OSNOISE_WORKLOAD > osnoise/options
  echo timerlat > current_tracer
  echo 0 > /sys/devices/system/cpu/cpu1/online
  echo 1 > /sys/devices/system/cpu/cpu1/online
  echo NO_OSNOISE_WORKLOAD > osnoise/options

The offline/online pair is required, otherwise no kthread is recorded and
no bit is set. Running this on 7.3-rc7 with KASAN gives a WARNING in
stop_kthread() followed by a slab-use-after-free in update_se(); leaving
out the hotplug step produces neither.

Keep the check in start_kthread(), where the related hotplug bug was
fixed in 0bb0a5c12ecf, instead of adding another copy to the callback.

Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
Cc: stable@vger.kernel.org
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 kernel/trace/trace_osnoise.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0e1265acd..9715462ee 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2038,6 +2038,14 @@ static int start_kthread(unsigned int cpu)
 		return 0;
 
 	if (timerlat_enabled()) {
+		/*
+		 * In timerlat user-space mode the workload is the user task
+		 * reading timerlat_fd, so there is no kernel thread to start.
+		 * One started here would set its kthread_cpumask bit, which
+		 * stop_kthread() reads as "osnoise workload kthread".
+		 */
+		if (!test_bit(OSN_WORKLOAD, &osnoise_options))
+			return 0;
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
-- 
2.43.0

