Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE03CA4B2;
	Tue, 24 Mar 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336494; cv=none; b=bxuOIrUX6NgvXvAacQxcA3E3wYoa+x6ESXsvrXSnVaR2CAxlK13ls2Fnzsk4J11Ym5zFX/BLSn8P8OH1jQb0/FZwreKtbeu+w2Ttfx4Q3XU8n/gjfxmrpTw8nzZbDl3+JZT6H/nhKkXE+wtp0dIfctVvQS5Ng86uOH2uTtvhlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336494; c=relaxed/simple;
	bh=8oqpBKel//Dd5rkxzlif27vEJia2h18PaKeUPY5gxsM=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=EW0EH5Qqe5piTFS+qb73cUoGtYMJOyYyLbPik4sA+P5AkuCXsLU/zAofF6w6updzBiuNEVrWb5Z7V81H6zd+heNL1yusPkKugkmXay09mnI49OMq4TNJXrWt95MDi7LW24IjQwfBA6AIynPBPPd+D4msfqFcBY4DMSydIn4YJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fg1LK4KtCz57dR;
	Tue, 24 Mar 2026 15:06:49 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4fg1LC1jc6z5TCG4;
	Tue, 24 Mar 2026 15:06:43 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fg1L12v2hz8Xs6w;
	Tue, 24 Mar 2026 15:06:33 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fg1Kp1Q8Vz4xrS3;
	Tue, 24 Mar 2026 15:06:22 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 62O76EBY001131;
	Tue, 24 Mar 2026 15:06:14 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 24 Mar 2026 15:06:16 +0800 (CST)
X-Zmail-TransId: 2afa69c237e8079-0b6a4
X-Mailer: Zmail v1.0
Message-ID: <20260324150616953rMo1BWtAZ1nXTNrEFP6hr@zte.com.cn>
Date: Tue, 24 Mar 2026 15:06:16 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <ran.xiaokai@zte.com.cn>, <luo.haiyang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB0cmFjaW5nL29zbm9pc2U6IGZpeCBwb3RlbnRpYWwgZGVhZGxvY2sgaW4gY3B1IGhvdHBsdWc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 62O76EBY001131
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.165 unknown Tue, 24 Mar 2026 15:06:49 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69C23808.000/4fg1LK4KtCz57dR

From: luohaiyang10243395 <luo.haiyang@zte.com.cn>

The following sequence may leads deadlock in cpu hotplug:

  CPU0                        |  CPU1
                              |  schedule_work_on
                              |
  _cpu_down//set CPU1 offline |
  cpus_write_lock             |
                              |  osnoise_hotplug_workfn
                              |    mutex_lock(&interface_lock);
                              |    cpus_read_lock();  //wait cpu_hotplug_lock
                              |
                              |  cpuhp/1
                              |    osnoise_cpu_die
                              |      kthread_stop
                              |        wait_for_completion //wait osnoise/1 exit
                              |
                              |  osnoise/1
                              |    osnoise_sleep
                              |      mutex_lock(&interface_lock); //deadlock

Fix by swap the order of cpus_read_lock() and mutex_lock(&interface_lock).

Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index dee610e465b9..be6cf0bb3c03 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2073,8 +2073,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	if (!osnoise_has_registered_instances())
 		return;

-	guard(mutex)(&interface_lock);
 	guard(cpus_read_lock)();
+	guard(mutex)(&interface_lock);

 	if (!cpu_online(cpu))
 		return;
@@ -2237,11 +2237,11 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 	if (running)
 		stop_per_cpu_kthreads();

-	mutex_lock(&interface_lock);
 	/*
 	 * avoid CPU hotplug operations that might read options.
 	 */
 	cpus_read_lock();
+	mutex_lock(&interface_lock);

 	retval = cnt;

@@ -2257,8 +2257,8 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 			clear_bit(option, &osnoise_options);
 	}

-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();

 	if (running)
 		start_per_cpu_kthreads();
@@ -2345,16 +2345,16 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (running)
 		stop_per_cpu_kthreads();

-	mutex_lock(&interface_lock);
 	/*
 	 * osnoise_cpumask is read by CPU hotplug operations.
 	 */
 	cpus_read_lock();
+	mutex_lock(&interface_lock);

 	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);

-	cpus_read_unlock();
 	mutex_unlock(&interface_lock);
+	cpus_read_unlock();

 	if (running)
 		start_per_cpu_kthreads();
-- 
2.25.1
