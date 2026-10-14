Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1DC46D097
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962440; cv=none; b=pPpJpLdOROjmgGYKzjj6x2mmpViaQBrCdvDAso74GjyBwHwDTmKWrMmpTZ/yULt4paNIrarM45NrQXUc+oWfqyVaRexIC60jsCq0AISgIhAwFz7s9ZtK9uraMHMSCffhoQAPemoQ/dpbYDX5sQMFsrvtUUoJ0Hytyy+QUpsyPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962440; c=relaxed/simple;
	bh=g6hFtLVrE/UjzzVSQQOzbX4cj/oiFJZYtfo2+FNowfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r97hv5iDKXaEgL6dMjdu0QtjM9xMyQz6UCXo63ygtDRSF53MQwNe5jiJA0Id8FMSgFS1vO9vNnNweDuVGO3yFWtcewtie/s7a0lmoJDH49xz5VWYPZ6hO3PjAcqFtE5pDnPXb3F1XlABrqXp/zesmrG163lSeA/XwtnAL/xOfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLGofGV2; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLGofGV2"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-354ba08cfd1so6449742eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962438; x=1792567238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9mA2qoZtggQ/j/8me9B77LmzqnDxoGP/VtqAIm/t1U=;
        b=eLGofGV22lAh7Oeak/ixXc9UNnueFHsqx74u4y3/lNauJF/lklVShsVb7Wnv8rrJOf
         NTJoD6iSFpflVhPyMXJW7ugQZiSyFbUvtEJQGVCT38hpyVnxJwFYNDd29Ih+CgFU1j/S
         mKIyQK2cNiESYEl+DjsBWazAHQVGgrjfS9e5L1qtfvhgA4bqa4uGTBwcPxZbPEJ90GL0
         FPyhOigURW0TqsIhtJ52gzsjXL7gisdb4CCGksU4lfHYT82Pt7t5vf6cuevHA8mnUFb2
         uioSroVQogYfzno6hR+CN0YbKBENPtRvNu9IJ4l1li7vgk6ICAQry/E/lJ8APFQLU1v0
         ICRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962438; x=1792567238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9mA2qoZtggQ/j/8me9B77LmzqnDxoGP/VtqAIm/t1U=;
        b=ky+ZTmlqoJoCC3WSsLli2wnaK4/H6ITq0HCVWCx0VY6jDPSqBHQ950rP82+076jmnA
         R3NV3xeOkksRCrmtp5hyYcO6cPemf9Sng6g6mmhdG2jp8N37zBg1mWXq16KZB/9Uixhx
         noidKbEjT6aLrcEcAgVfXAH6zm3oaEhtwfdD7NhEXtyJ1t6IvzTir7RlEFvZ4NXG5HWi
         tlDG3qclpPmElFtUiBSMdgBVduJhcJm44TxH6hst29esMfAvEfcMjXagdHaP4Sk0Stth
         jooTViK0IisCwPA9/u7fI/4KEdatrmBuZzWooiiYkZxVX0kvWxt8myX5MF2ro52p/N9p
         c23w==
X-Forwarded-Encrypted: i=1; AKwUvBy3v95mlOohnRJZL6Bcv4uewGVRxf8sL6TEfmXXGszi1wsdiEhDLUBZ/72IeJNvTv8bJBiFRMqr0OgeFZHX9XfHReA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhHDLMQHMSCmAPxcekj6ZzJc7W+buWQJczDxYsrwGERAsQFxTx
	39w7UFyfmduiHj+z30D1qBt0Y8S3PqFkqN0z2tMkPC5t+/u0ThCF5Zm9C2XZAESLBgk=
X-Gm-Gg: AYBFou3vtV9apnx7Fg9s7Z8kWxb8D/V62saVmFVzAzRPF5B7DPwfUPcnB9fR14XJ45d
	FObcBNtzh93se8M2j/RWoDCA3qpTUNCBqm7XFwQIGOBjUITYZChaxWSqOxAxbYkRu7gkq5C/zeM
	0BCziEiV3Xen7dNtHVcUxDnS5cDtWI+mPt+r49htMg6+t/ru4MG1+F9JoA3AfvD8McCSxmU1dlT
	gvnUuIIJtzWO+362VwWnYnnp1BK63qR12KjiMrOwJnD9W8qrn1v5yu1nLVCw3tsZMQGs7ihudXo
	jZur6thyFdZI8BBW589PevZnAot7aNXqL/OMfZ70Q970GLn/X7IxEK9XY5CsNTRdT1rJLKLKbMe
	OHtHEE3KOYfUOaXtcbX8tAGxdVHe76bSQRlbEqpuwRaAIUlFuVbmRmUtbB2NAl2kpAGW7125xmZ
	rDBTnXryanA0i0gLwhjIQo+0Pm/GEuW2b7E3P0yH4pVrIO8iLbR4uV5CVgVf9+QY5Bmcm4Wa1C9
	C/QT4WaJ1BPqU3OyaxwGwhphizPC8biN21EVw4reHCEKjpPJ1lih/EYPg==
X-Received: by 2002:a05:701b:280a:b0:14d:c7ae:85df with SMTP id a92af1059eb24-16a5adfc08emr22045113c88.12.1791962437979;
        Wed, 14 Oct 2026 00:20:37 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a32eb7ebsm52219852c88.12.2026.10.14.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:20:33 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Subject: [PATCH] tracing/osnoise: Don't start a kthread in timerlat user-space mode
Date: Wed, 14 Oct 2026 15:20:19 +0800
Message-ID: <20261014072019.276178-1-chaosheng.qu.linux@gmail.com>
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

