Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBF282F29;
	Wed, 25 Mar 2026 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405557; cv=none; b=rCZtNL+2D9ZZtnMsTfQj9qpj3nnt+YjNic2HGklPcdmG34o2/77fhK01kYpWZps6xbgMPhj39W5QDwKvbb1oILFZYQ2tK+P7R/iVS6uOYEmVfqsUN63ft0z5m9Zl7MO3i7BnpsnjMsfZoH6irvDVNxjHXWP84yukbOLINvfpJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405557; c=relaxed/simple;
	bh=xG2xXzWq8rp51wUHvwWwm7GeB57Dfp6kZbScoQt1/Qo=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=rneTPUWV6Qj3bTnho/jqA01hoGdXWVZUS4Xfw13zWNN7euJ9QQRznA/qQ5dawLInf9R1Pm7vN5eT4hK0HrSV3T9+B74GjSuv7KcjufegZmb376YNCAEGa4zDlxSxe1k3Wvr6G/BQC5Nd2ktlXM0FqJ0Zl0tmSupnFPSyKFRCXok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fgW3f1xsxz51Sdb;
	Wed, 25 Mar 2026 10:25:50 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 62P2Pf6v062825;
	Wed, 25 Mar 2026 10:25:41 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 25 Mar 2026 10:25:42 +0800 (CST)
X-Zmail-TransId: 2afb69c347a6704-1282d
X-Mailer: Zmail v1.0
Message-ID: <20260325102542300G48VT-wLNp-dOgT_9Qi2f@zte.com.cn>
In-Reply-To: <20260324121918.454d6a7b@gandalf.local.home>
References: 20260324150616953rMo1BWtAZ1nXTNrEFP6hr@zte.com.cn,20260324121918.454d6a7b@gandalf.local.home
Date: Wed, 25 Mar 2026 10:25:42 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rostedt@goodmis.org>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <ran.xiaokai@zte.com.cn>, <luo.haiyang@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdHJhY2luZy9vc25vaXNlOiBmaXggcG90ZW50aWFsIGRlYWRsb2NrIGluIGNwdSBob3RwbHVn?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 62P2Pf6v062825
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 25 Mar 2026 10:25:50 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69C347AE.000/4fgW3f1xsxz51Sdb

>On Tue, 24 Mar 2026 15:06:16 +0800 (CST)
><hu.shengming@zte.com.cn> wrote:
>
>> From: luohaiyang10243395 <luo.haiyang@zte.com.cn>
>> 
>> The following sequence may leads deadlock in cpu hotplug:
>> 
>>   CPU0                        |  CPU1
>>                               |  schedule_work_on
>>                               |
>>   _cpu_down//set CPU1 offline |
>>   cpus_write_lock             |
>>                               |  osnoise_hotplug_workfn
>>                               |    mutex_lock(&interface_lock);
>>                               |    cpus_read_lock();  //wait cpu_hotplug_lock
>>                               |
>>                               |  cpuhp/1
>>                               |    osnoise_cpu_die
>>                               |      kthread_stop
>>                               |        wait_for_completion //wait osnoise/1 exit
>>                               |
>>                               |  osnoise/1
>>                               |    osnoise_sleep
>>                               |      mutex_lock(&interface_lock); //deadlock
>> 
>> Fix by swap the order of cpus_read_lock() and mutex_lock(&interface_lock).
>
>So the deadlock is due to the "wait_for_completion"?

The osnoise_cpu_init callback returns directly, which may allow another CPU offline task to run, 
the offline task holds the cpu_hotplug_lock while waiting for the osnoise task to exit. 
osnoise_hotplug_workfn may acquire interface_lock first, causing the offline task to be blocked. 
This is an ABBA deadlock.

>How did you find this bug? Inspection, AI, triggered?
>
>Thanks,
>
>-- Steve

We run autotests on kernel-6.6, report following hung task warning, and we think the same issue exists
in linux-stable.
 [39401.476843] INFO: task cpuhp/7:47 blocked for more than 120 seconds.
 [39401.483196]       Tainted: G            E      6.6.102-5.2.1.an23.103.aarch64 #1
 [39401.490581] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 [39401.498398] task:cpuhp/7         state:D stack:0     pid:47    ppid:2      flags:0x00000208
 [39401.506739] Call trace:
 [39401.509175]  __switch_to+0x138/0x180
 [39401.512743]  __schedule+0x250/0x5e8
 [39401.516220]  schedule+0x60/0x100
 [39401.519437]  schedule_timeout+0x1a0/0x1c0
 [39401.523437]  wait_for_completion+0xbc/0x190
 [39401.527609]  kthread_stop+0x7c/0x268
 [39401.531175]  stop_kthread+0x8c/0x178
 [39401.534740]  osnoise_cpu_die+0xc/0x18
 [39401.538391]  cpuhp_invoke_callback+0x148/0x580
 [39401.542822]  cpuhp_thread_fun+0xc8/0x1a0
 [39401.546733]  smpboot_thread_fn+0x224/0x250
 [39401.550817]  kthread+0xf8/0x110
 [39401.553947]  ret_from_fork+0x10/0x20
 [39401.557545] INFO: task sh:28856 blocked for more than 120 seconds.
 [39401.563713]       Tainted: G            E      6.6.102-5.2.1.an23.103.aarch64 #1
 [39401.571095] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 [39401.578912] task:sh              state:D stack:0     pid:28856 ppid:1      flags:0x00800004
 [39401.587251] Call trace:
 [39401.589685]  __switch_to+0x138/0x180
 [39401.593250]  __schedule+0x250/0x5e8
 [39401.596725]  schedule+0x60/0x100
 [39401.599941]  schedule_timeout+0x1a0/0x1c0
 [39401.603940]  wait_for_completion+0xbc/0x190
 [39401.608113]  __flush_work+0x5c/0xa8
 [39401.611590]  work_on_cpu_key+0x88/0xc0
 [39401.615331]  cpu_down_maps_locked+0xd0/0xe8
 [39401.619503]  cpu_device_down+0x38/0x60
 [39401.623240]  cpu_subsys_offline+0x14/0x28
 [39401.627238]  device_offline+0xb8/0x130
 [39401.630976]  online_store+0x64/0xe0
 [39401.634453]  dev_attr_store+0x1c/0x38
 [39401.638104]  sysfs_kf_write+0x48/0x60
 [39401.641756]  kernfs_fop_write_iter+0x118/0x1e8
 [39401.646188]  vfs_write+0x1a4/0x2f8
 [39401.649580]  ksys_write+0x70/0x108
 [39401.652970]  __arm64_sys_write+0x20/0x30
 [39401.656880]  el0_svc_common.constprop.0+0x60/0x138
 [39401.661660]  do_el0_svc+0x20/0x30
 [39401.664964]  el0_svc+0x44/0x1f8
 [39401.668093]  el0t_64_sync_handler+0xf8/0x128
 [39401.672352]  el0t_64_sync+0x17c/0x180
 [39401.875086] INFO: task kworker/7:2:2314252 blocked for more than 121 seconds.
 [39401.882208]       Tainted: G            E      6.6.102-5.2.1.an23.103.aarch64 #1
 [39401.889590] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 [39401.897406] task:kworker/7:2     state:D stack:0     pid:2314252 ppid:2      flags:0x00000008
 [39401.905917] Workqueue: events osnoise_hotplug_workfn
 [39401.910871] Call trace:
 [39401.913306]  __switch_to+0x138/0x180
 [39401.916870]  __schedule+0x250/0x5e8
 [39401.920345]  schedule+0x60/0x100
 [39401.923561]  percpu_rwsem_wait+0xfc/0x128
 [39401.927559]  __percpu_down_read+0x60/0x198
 [39401.931644]  percpu_down_read.constprop.0+0xac/0xb8
 [39401.936510]  cpus_read_lock+0x14/0x20
 [39401.940160]  osnoise_hotplug_workfn+0x54/0xb0
 [39401.944506]  process_one_work+0x184/0x420
 [39401.948503]  worker_thread+0x2b4/0x3d8
 [39401.952241]  kthread+0xf8/0x110
 [39401.955370]  ret_from_fork+0x10/0x20
 [39402.125508] INFO: task osnoise/0:2356235 blocked for more than 121 seconds.
 [39402.132458]       Tainted: G            E      6.6.102-5.2.1.an23.103.aarch64 #1
 [39402.139840] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 [39402.147656] task:osnoise/0       state:D stack:0     pid:2356235 ppid:2      flags:0x00000008
 [39402.156168] Call trace:
 [39402.158602]  __switch_to+0x138/0x180
 [39402.162166]  __schedule+0x250/0x5e8
 [39402.165643]  schedule+0x60/0x100
 [39402.168860]  schedule_preempt_disabled+0x28/0x48
 [39402.173466]  __mutex_lock.constprop.0+0x324/0x5f8
 [39402.178158]  __mutex_lock_slowpath+0x18/0x28
 [39402.182416]  mutex_lock+0x64/0x78
 [39402.185720]  osnoise_sleep+0x30/0x130
 [39402.189371]  osnoise_main+0x164/0x190
 [39402.193021]  kthread+0xf8/0x110
 [39402.196149]  ret_from_fork+0x10/0x20
 [39402.199713] INFO: task osnoise/1:2356236 blocked for more than 121 seconds.
 [39402.206661]       Tainted: G            E      6.6.102-5.2.1.an23.103.aarch64 #1
 [39402.214044] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 [39402.221860] task:osnoise/1       state:D stack:0     pid:2356236 ppid:2      flags:0x00000008
 [39402.230372] Call trace:
 [39402.232804]  __switch_to+0x138/0x180
 [39402.236368]  __schedule+0x250/0x5e8
 [39402.239845]  schedule+0x60/0x100
 [39402.243061]  schedule_preempt_disabled+0x28/0x48
 [39402.247666]  __mutex_lock.constprop.0+0x324/0x5f8
 [39402.252359]  __mutex_lock_slowpath+0x18/0x28
 [39402.256618]  mutex_lock+0x64/0x78
 [39402.259921]  osnoise_sleep+0x30/0x130
 [39402.263572]  osnoise_main+0x164/0x190
 [39402.267223]  kthread+0xf8/0x110
 [39402.270352]  ret_from_fork+0x10/0x20
 [39402.273916] INFO: task osnoise/2:2356237 blocked for more than 121 seconds.
 [39402.280865]       Tainted: G            E      6.6.102-5.2.1.an23.103.aarch64 #1
 [39402.288247] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 [39402.296064] task:osnoise/2       state:D stack:0     pid:2356237 ppid:2      flags:0x00000008
 [39402.304575] Call trace:
 [39402.307010]  __switch_to+0x138/0x180
 [39402.310574]  __schedule+0x250/0x5e8
 [39402.314051]  schedule+0x60/0x100
 [39402.317268]  schedule_preempt_disabled+0x28/0x48
 [39402.321873]  __mutex_lock.constprop.0+0x324/0x5f8
 [39402.326566]  __mutex_lock_slowpath+0x18/0x28
 [39402.330824]  mutex_lock+0x64/0x78
 [39402.334128]  osnoise_sleep+0x30/0x130
 [39402.337778]  osnoise_main+0x164/0x190
 [39402.341429]  kthread+0xf8/0x110
 [39402.344556]  ret_from_fork+0x10/0x20
 [39402.348120] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
 [39402.356295] Kernel panic - not syncing: hung_task: blocked tasks 

Thanks,
Haiyang

>> 
>> Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
>> ---
>>  kernel/trace/trace_osnoise.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index dee610e465b9..be6cf0bb3c03 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -2073,8 +2073,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
>>      if (!osnoise_has_registered_instances())
>>          return;
>> 
>> -    guard(mutex)(&interface_lock);
>>      guard(cpus_read_lock)();
>> +    guard(mutex)(&interface_lock);
>> 
>>      if (!cpu_online(cpu))
>>          return;
>> @@ -2237,11 +2237,11 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
>>      if (running)
>>          stop_per_cpu_kthreads();
>> 
>> -    mutex_lock(&interface_lock);
>>      /*
>>       * avoid CPU hotplug operations that might read options.
>>       */
>>      cpus_read_lock();
>> +    mutex_lock(&interface_lock);
>> 
>>      retval = cnt;
>> 
>> @@ -2257,8 +2257,8 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
>>              clear_bit(option, &osnoise_options);
>>      }
>> 
>> -    cpus_read_unlock();
>>      mutex_unlock(&interface_lock);
>> +    cpus_read_unlock();
>> 
>>      if (running)
>>          start_per_cpu_kthreads();
>> @@ -2345,16 +2345,16 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>>      if (running)
>>          stop_per_cpu_kthreads();
>> 
>> -    mutex_lock(&interface_lock);
>>      /*
>>       * osnoise_cpumask is read by CPU hotplug operations.
>>       */
>>      cpus_read_lock();
>> +    mutex_lock(&interface_lock);
>> 
>>      cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
>> 
>> -    cpus_read_unlock();
>>      mutex_unlock(&interface_lock);
>> +    cpus_read_unlock();
>> 
>>      if (running)
>>          start_per_cpu_kthreads();
