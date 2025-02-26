Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113924EF86;
	Wed, 26 Feb 2025 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541396; cv=none; b=pUkLKaxbgUwlxMamm6lsyA2P+Z/jAHsv1cGWWpM98r2fZhRFVA3mXlKW2VBpxTSjxKFQUFR1xN+xJrq3NDhW9RoMhYQrQK/JdhnOUtRI0365mz8Yd6qlzroUXCCYSat1lzzPxxoEJo5Y30qdIHBNwem0G7KGRsroYLJq3hUZOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541396; c=relaxed/simple;
	bh=CK3z3Dkb7MP4cqTYmLODrtTGMImGRsCJkDk0a6x8xsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lm64C7Sv6Wn3KK/M1dhG/38p19E1lVHB4vTuiTMesQevxIA8cPgNTokuahwBDV8CJVDu1WSa5qWrbs12Ebqn4WxQi7INwyMR4i3g3bO3Rh/IlDvxHxH+yqqAY+AO0dRNTKRyERpyEZ32ZM07lSwOmp+yrnRopjziWijwEsMB2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XzW6o9vd; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XzW6o9vd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=djarr
	SxnaQbMICwbJJIshb9xwjnsUGfAjAjHmHySZvo=; b=XzW6o9vdIxE6AG3r98V+W
	dZdjorF1Ls6zp4Yor52Ktw+ppcMooz7upfgW5SfdpwhIjpY4oNoQ7FaroGmhkgKh
	NRO+9xS10Og/Rzd1McIfFX5bVtQvx+DEoVLtFssSPHKpG78pJfCKGVyD3Fnc5IPn
	9DLyhKB+DK9ilMM1haxrdM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnj8y+jb5nNn+pOw--.51281S4;
	Wed, 26 Feb 2025 11:42:55 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	wang.yong12@zte.com.cn,
	yang.guang5@zte.com.cn
Subject: Re: [PATCH] tracing/osnoise: Fix possible recursive locking for cpus_read_lock()
Date: Wed, 26 Feb 2025 03:42:53 +0000
Message-Id: <20250226034253.2587709-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225113032.5e01922d@gandalf.local.home>
References: <20250225113032.5e01922d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj8y+jb5nNn+pOw--.51281S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4DGr4ktr18GFW5Xr13Jwb_yoW8Kr4Up3
	95tF9rGr45A34vv345Z3WrJw18tw4jgF4vkrykt3WrA3Z8Z3y3WFy5Kas8Xw15uw1xWFWj
	v3yDJFZxuw4DX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUIXHiUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0hMATGe+it9Y8QAAso

>On Tue, 25 Feb 2025 12:31:32 +0000
>Ran Xiaokai <ranxiaokai627@163.com> wrote:
>
>> @@ -2097,7 +2096,7 @@ static void osnoise_hotplug_workfn(struct
>> work_struct *dummy)
>>          return;
>>  
>>      guard(mutex)(&interface_lock);
>> -    guard(cpus_read_lock)();
>> +    cpus_read_lock();
>>  
>>      if (!cpu_online(cpu))
>>          return;
>
>This is buggy. You removed the guard, and right below we have an error exit
>that will leave this function without unlocking the cpus_read_lock().

Indeed.
I will run the LTP cpu-hotplug testcases before the next verion.

>> @@ -2105,7 +2104,12 @@ static void osnoise_hotplug_workfn(struct
>> work_struct *dummy)
>>      if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
>>          return;
>>  
>> -    start_kthread(cpu);
>> +    if (start_kthread(cpu)) {
>> +        cpus_read_unlock();
>> +        stop_per_cpu_kthreads();
>> +        return;
>
>If all you want to do is to unlock before calling stop_per_cpu_kthreads(),
>then this should simply be:
>
>   if (start_kthread(cpu)) {
>       cpus_read_unlock();
>       stop_per_cpu_kthreads();
>       cpus_read_lock(); // The guard() above will unlock this
>       return;
>   }

This is the deadlock senario:
start_per_cpu_kthreads()
  cpus_read_lock();                  // first lock call
  start_kthread(cpu)
    ... kthread_run_on_cpu() fails:
    if (IS_ERR(kthread)) {
      stop_per_cpu_kthreads(); {
        cpus_read_lock();      // second lock call. Cause the AA deadlock senario
      }
    }
  stop_per_cpu_kthreads();

Besides, stop_per_cpu_kthreads() is called both in start_per_cpu_kthreads() and
start_kthread() which is unnecessary.

So the fix should be inside start_kthread()?
How about this ?

--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2029,7 +2029,9 @@ static int start_kthread(unsigned int cpu)

        if (IS_ERR(kthread)) {
                pr_err(BANNER "could not start sampling thread\n");
+               cpus_read_unlock();
                stop_per_cpu_kthreads();
+               cpus_read_lock();
                return -ENOMEM;
        }

@@ -2076,7 +2078,6 @@ static int start_per_cpu_kthreads(void)
                retval = start_kthread(cpu);
                if (retval) {
                        cpus_read_unlock();
-                       stop_per_cpu_kthreads();
                        return retval;
                }
        }

>
>But I still have to verify that this is indeed the issue here.
>
>-- Steve
>
>
>> +    }
>> +    cpus_read_unlock();
>>  }
>>  
>>  static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);

