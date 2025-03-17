Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B613198A08;
	Mon, 17 Mar 2025 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214530; cv=none; b=IW29dtH2NdqXFeT7VlxSz2YtlkeBgw2SAUjkSH66a/aafBjmbpbGsWr4sVOBvpvQL8fL6VqP68Wyi7HwDWMzm9F1bFTDcNO8dLGEQy8v5FRqQNE4zcgiLjFvcTU6Ok3+1DVN5b9v1MNhxgMvEgv6DoSXWCgvXuXm8d9vp2L7JyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214530; c=relaxed/simple;
	bh=CrPzLq/qkn2x8eobDBnSrdDt4CtSzRhtPNop8WhJgNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ngsv0bsVMPUEpWYQrCIlmHTRvByWmV7C/wrj0i3NQ9ewLFsts28LxtKZ9bmqjVZcqJ7M6VIk1FDaytClYdnUgBI/0L5ixDO2ZS43tQmJQybHTq9gWSvn9Y/08MyGjbr5hJMjVy9JfNoBkCckGgSkTZyMD+gPIWwDY2aKxzMsi64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZIzryqdy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZIzryqdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RsduW
	5YS7NU/n/xiujUUnP3quZPCttoSoXqSM6H3cOM=; b=ZIzryqdyb8BV57GUImjn/
	vecVrazw6o3/XtnW8FbjMwNRYifaLW0gVYeItYNt4yRgOwVW38OEuFiYC4mGyKem
	mbuBhSg8wEGQxW2XKLrGzscUTG/H6wqOT+VU1iXIr/RJRZsLCBCcES7tWxkcCecS
	9uAlET6hW7EOg97gSeNQbY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD392FbFdhnMM0CAA--.940S4;
	Mon, 17 Mar 2025 20:28:12 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: Re: [PATCH] tracing/osnoise: Fix possible recursive locking for cpus_read_lock()
Date: Mon, 17 Mar 2025 12:28:10 +0000
Message-Id: <20250317122810.2720668-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226100526.3039102d@gandalf.local.home>
References: <20250226100526.3039102d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD392FbFdhnMM0CAA--.940S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryUJF1DKr45Aw1fWF45Wrg_yoW5Jr4Dpa
	yrtFy7Kr45A34kZw1av3Wrt340q3yjgF4vqryrtw1rA3Z0q39xXrWUKa90g345uwn7Xryj
	vFyDJFsxZ3yDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbjjDUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBkBwTTGfYEP5lMAAAsX

>On Wed, 26 Feb 2025 03:42:53 +0000
>Ran Xiaokai <ranxiaokai627@163.com> wrote:
>
>> >> @@ -2105,7 +2104,12 @@ static void osnoise_hotplug_workfn(struct
>> >> work_struct *dummy)
>> >>      if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
>> >>          return;
>> >>  
>> >> -    start_kthread(cpu);
>> >> +    if (start_kthread(cpu)) {
>> >> +        cpus_read_unlock();
>> >> +        stop_per_cpu_kthreads();
>> >> +        return;  
>> >
>> >If all you want to do is to unlock before calling stop_per_cpu_kthreads(),
>> >then this should simply be:
>> >
>> >   if (start_kthread(cpu)) {
>> >       cpus_read_unlock();
>> >       stop_per_cpu_kthreads();
>> >       cpus_read_lock(); // The guard() above will unlock this
>> >       return;
>> >   }  
>> 
>> This is the deadlock senario:
>> start_per_cpu_kthreads()
>>   cpus_read_lock();                  // first lock call
>>   start_kthread(cpu)
>>     ... kthread_run_on_cpu() fails:
>>     if (IS_ERR(kthread)) {
>>       stop_per_cpu_kthreads(); {
>>         cpus_read_lock();      // second lock call. Cause the AA deadlock senario
>>       }
>>     }
>>   stop_per_cpu_kthreads();
>> 
>> Besides, stop_per_cpu_kthreads() is called both in start_per_cpu_kthreads() and
>> start_kthread() which is unnecessary.
>> 
>> So the fix should be inside start_kthread()?
>> How about this ?
>
>No! You misunderstood what I wrote above.
>
>Instead of removing the guard, keep it!
>
>Do everything the same, but instead of having the error path of:
>
>[..]
>    if (start_kthread(cpu)) {
>        cpus_read_unlock();
>        stop_per_cpu_kthreads();
>        return;
>    }
>    cpus_read_unlock();
> }
>
>Which requires removing the guard. Just do:
>
>    if (start_kthread(cpu)) {
>        cpus_read_unlock();
>        stop_per_cpu_kthreads();
>        cpus_read_lock(); // The guard() will unlock this
>    }
> }

Hi, Steve
Sorry for the late response.
Yes, this will fix the deadlock issue.

What i mentioned before is that there is a redundant of stop_per_cpu_kthreads()
in start_per_cpu_kthreads().

start_per_cpu_kthreads()
  for_each_cpu(cpu, current_mask) {
    retval = start_kthread(cpu);
             {
                if (IS_ERR(kthread))
                 stop_per_cpu_kthreads();  // first cleanup call of stop_per_cpu_kthreads()
                 return -ENOMEM;
             }
    if (retval) {
      cpus_read_unlock();
      stop_per_cpu_kthreads();            // the redundant call of stop_per_cpu_kthreads()

But the second call will not cause any trouble, So i will send a v2
just according to your suggestion.

>I'm just saying to not replace the guard with open coded locking of
>cpus_read_lock().
>
>-- Steve

