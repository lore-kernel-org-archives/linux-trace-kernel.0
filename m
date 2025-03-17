Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784EF23C392;
	Mon, 17 Mar 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215990; cv=none; b=Hqro18nnAcAcyuLuEsyI+3/gATrYnx4I63zNAJ3bbdFqpoQ/Dsk4cQjcLS3VoMHwxBdaJ1awcotkFL2ZBXLz88BHYtiAj9w9iWSTqw8aOe17LqCoR0UpOnryWh29s8lfJhVAnHhX8NEBniZdIzVYAbP1Bh8t2vYqGMgM3yheyUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215990; c=relaxed/simple;
	bh=SnG8t4ZHTw/mTzkb8/QHpGoz+pEORF9Ygx+G+xb2i8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZngTg9b7LF/Zki2OXSjYmKD53k79pUCKK4fkjkKW9pG0AHc+qPJKkMVfTAYhAN1VWHgXgmgJYh9Natt6qwqDTBHTZL96niFjO3Y1Dzgd3latfqMfNvEx/3eT7Qod5EQCV5ZZYUXJG3T1Z90NAcl3pM9LuNoFnn2ZdyDuhL56q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jB0mvXCk; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jB0mvXCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oBnaM
	2tQUy/4jIsYzZe7U/N1BbRaO8mY/ZrPYIqr0qs=; b=jB0mvXCkXpHIE5tE3vO2p
	paWselfgmfLmJ3raT5tdDgNab4somZOjoYQMXHOfcg3nWy470eD/2JrV17kmKIE9
	xd9Jthrz5gIQmJBn9vEnfe4qKl3h9eZXaxbHKSP/BpK/bYdrNMzxrlWOb+Z3vFNd
	+1G8AXf6mcEnpmEUxXXCVY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXas0LG9hnSGoGAA--.1153S4;
	Mon, 17 Mar 2025 20:52:28 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: vishalc@linux.ibm.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	rostedt@goodmis.org
Subject: Re: [PATCH] tracing/osnoise: Fix possible recursive locking for cpus_read_lock()
Date: Mon, 17 Mar 2025 12:52:26 +0000
Message-Id: <20250317125226.2720728-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Z8AW2Ny1NrKNh_dZ@linux.ibm.com>
References: <Z8AW2Ny1NrKNh_dZ@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXas0LG9hnSGoGAA--.1153S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF47Cr1DAF48uw17CrykKrg_yoWrWw13pr
	Z3KFy7Jw4jkryvv34UZ3W5A340q3yjqF48tryktw1rA3Z8uw4aqr1Yga4Fq345ury8urW2
	v3WqyFZxuw4DXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUemhrUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0gkTTGfYF4AkXwABsW

>On Tue, Feb 25, 2025 at 12:31:32PM +0000, Ran Xiaokai wrote:
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> Lockdep reports this deadlock log:
>> ============================================
>> WARNING: possible recursive locking detected
>> --------------------------------------------
>> sh/31444 is trying to acquire lock:
>> ffffffff82c51af0 (cpu_hotplug_lock){++++}-{0:0}, at:
>> stop_per_cpu_kthreads+0x7/0x60
>> 
>> but task is already holding lock:
>> ffffffff82c51af0 (cpu_hotplug_lock){++++}-{0:0}, at:
>> start_per_cpu_kthreads+0x28/0x140
>> 
>> other info that might help us debug this:
>>  Possible unsafe locking scenario:
>> 
>>        CPU0
>>        ----
>>   lock(cpu_hotplug_lock);
>>   lock(cpu_hotplug_lock);
>> 
>> Call Trace:
>>  <TASK>
>>  __lock_acquire+0x1612/0x29b0
>>  lock_acquire+0xd0/0x2e0
>>  cpus_read_lock+0x49/0x120
>>  stop_per_cpu_kthreads+0x7/0x60
>>  start_kthread+0x105/0x120
>>  start_per_cpu_kthreads+0xdd/0x140
>>  osnoise_workload_start+0x261/0x2f0
>>  osnoise_tracer_start+0x18/0x4
>> 
>> In start_kthread(), when kthread_run_on_cpu() fails,
>> cpus_read_unlock() should be called before stop_per_cpu_kthreads(),
>> but both start_per_cpu_kthreads() and start_kthread() call the error
>> handling routine stop_per_cpu_kthreads(),
>> which is redundant. Only one call is necessary.
>> To fix this, move stop_per_cpu_kthreads() outside of start_kthread(),
>> use the return value of start_kthread() to determine kthread creation
>> error.
>> The same issue exists in osnoise_hotplug_workfn() too.
>> 
>> Reviewed-by: Yang Guang <yang.guang5@zte.com.cn>
>> Reviewed-by: Wang Yong <wang.yong12@zte.com.cn>
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>  kernel/trace/trace_osnoise.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index 92e16f03fa4e..38fb0c655f5b 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -2029,7 +2029,6 @@ static int start_kthread(unsigned int cpu)
>>  
>>  	if (IS_ERR(kthread)) {
>>  		pr_err(BANNER "could not start sampling thread\n");
>> -		stop_per_cpu_kthreads();
>>  		return -ENOMEM;
>>  	}
>>  
>> @@ -2097,7 +2096,7 @@ static void osnoise_hotplug_workfn(struct
>> work_struct *dummy)
>>  		return;
>>  
>>  	guard(mutex)(&interface_lock);
>> -	guard(cpus_read_lock)();
>> +	cpus_read_lock();
>>  
>>  	if (!cpu_online(cpu))
>>  		return;
>> @@ -2105,7 +2104,12 @@ static void osnoise_hotplug_workfn(struct
>> work_struct *dummy)
>>  	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
>>  		return;
>>  
>> -	start_kthread(cpu);
>> +	if (start_kthread(cpu)) {
>> +		cpus_read_unlock();
>> +		stop_per_cpu_kthreads();
>
>Is it right to call stop_per_cpu_kthreads() which stops osnoise kthread
>for every other CPUs in the system if a failure occurs during hotplug of a
>CPU?

I also suspect that this is not a rational behavior.

>On another note, since stop_per_cpu_kthreads() invokes stop_kthread()
>for every online CPU. It's better to remove stop_per_cpu_kthreads() from
>start_kthread() and handle the error in `osnoise_hotplug_workfn` 

Hi, Vishal
I did this in my first versin, something like this:

@@ -2097,7 +2096,7 @@ static void osnoise_hotplug_workfn(struct
work_struct *dummy)
 		return;
 
 	guard(mutex)(&interface_lock);
-	guard(cpus_read_lock)();
+	cpus_read_lock();
 
 	if (!cpu_online(cpu)) {
+		cpus_read_unlock();
 		return;
	}

 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask)) {
+		cpus_read_unlock();
 		return;
	}
-	start_kthread(cpu);
+	if (start_kthread(cpu)) {
+		cpus_read_unlock();
+		stop_per_cpu_kthreads();
+		return;
+	}
+	cpus_read_unlock();
 }

We have to drop the guard() and call unlock() manually,
this somewhat makes the code redundant.

>	Vishal
>> +		return;
>> +	}
>> +	cpus_read_unlock();
>>  }
>>  
>>  static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
>> -- 
>> 2.15.2
>> 

