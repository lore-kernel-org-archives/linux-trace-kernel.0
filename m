Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FD4A3F21
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000820; cv=none; b=gG1oJCwq/sCzsqJhH9zCZ2D6harXkPgvFoMszl+ru2PTJD88EOvN+LWFBXhbyE+VjkP/UsWYRlYuFuyFIX9YmEOul9Hffex3OMCAMWlTz4xs/HtaR4/vmr8YuL82vlVT8sdLqdFKJ80o9ggxIK78ZQWbW3izDxGgLmqJMIUF0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000820; c=relaxed/simple;
	bh=tl94ydNshNxi7aJ7mEw1U+VrV58ouK47MG9y//tgBqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpa3v76qVG0el+cykXA2aUHZvd7A3sPkKcXeTZDYTg7f1p9Of89fLZXdhvAlofEzH5Ll9yd1n8+Sgb1gOD0m84IzObfovauyGeD9zejCF6aWm3gjTYL3GCyxGh/k+GoCVa0v9cSrxmynXsoCgiB2XF19kizSoNYdANu092hxQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2IddSw/; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2IddSw/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so2404364f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790000817; x=1790605617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFAY4DIx3j9wCojliAf/PgSHhJnyLwniuh3x4CIKL0c=;
        b=j2IddSw/oh9bJavGtc1iuc9ahQ4Zwkx3rSLjzdo/x6MhhB3DpkFaNE3E3Gtk3HvrO+
         fGSJljsDKe6tkjIyARA1G1QwJZW5RAZKcIwwi56oEvubyxdyNkqCCti6HagQ97/ZCxWN
         ZB/wLCiXMPYSIk1Z9R35rSJOmI73OSq6k8i1nLhLYnyogvislHvVsdpQ2AN4PZBHT5AI
         CnJcAiYipTq6nLrtSnz1wfwvosq2sak1wm10TP/agznSIgA9mcZG7NDP+bp7QfBpqCmH
         JXZoj2VbwmsauCOCnaQ2zeVzn7wFODTALcXL++sxwsGruqLKqq0bgmNGQxMVd6asAk/h
         gpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000817; x=1790605617;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFAY4DIx3j9wCojliAf/PgSHhJnyLwniuh3x4CIKL0c=;
        b=0vKElNTVRIaPrVB2N5frPChTPhQvBdyaJtRI6761zFVFkUuM/CvOfPAPJwl38iX8Cg
         WntHTThSpl3ExKeI9Uv3G5tHDfEIL+MzYgA8rn5saAs181pgoPCoHiTsc1oMSf+u2B5y
         VpvW6rhuPFO2osXOhEW84N63r2I3bv0TVXYlYVGviVN8BXssb8+N2x3K6dxLu0flxqMD
         aHyzsJpHcVDDk+pE3E8CjKFQJCkqG8M+RCf98YMTA9bWcMj9phlKJCRrDCA1gX8gCu3V
         cnmVLbzUSW9Ts/hX6gYdZn7y+Eu3goGUzB6ltCEi0qUG3mKRyjz49tSScocxTId1HCIN
         0RTA==
X-Forwarded-Encrypted: i=1; AKwUvBwV7PKDC3DjdLy8F7JYDNfWPchsRpnfYGOvpLHkf/ENEnerfLp6fmxLcmjhs8T5RYVwYRLxcDBEnoiOFGF5Lu8HG+M=@vger.kernel.org
X-Gm-Message-State: AFuF++m8Z2FFO0mSmQVJ1WvBdSayVGM/w4eMTHS8rUW2XMAf2gIy3Le/
	nGVT+TM+WN1rAVwPPoazVDoBAwTPVmWCLmOEfvfaVm4VC/UMsZTnBaAX
X-Gm-Gg: AYBFou1YZcSKf5AC8UO1739YyOOt7FbXYt7fjyuk/60Y3yZBYziQdCY68d1TpRMaXkv
	DpFfmZPBXoxmgGr+4BUyQrZt5X0ADezPoXU5uFiOIvYiqtd1V//DwxbAj4Y16iH91rKlAK0HF9V
	cJbxcfPaN8CCCrWmO5onFFifAQPTrwJT061XsvnrWJkcddrN1lkwTD8cIPH365Diu6y0gtIECpL
	a4W7N3KDGqKpCwqw8FmNyQUsTz6oJWyugi5QREc5vLkALfFYdr9Hmq4Bl2OMmObffN0WfklDStG
	Vf3efSuJe3w9v5KopOlSXmmBidz32ZQouczzbrjgATySQoyqM8iRPTYKdrwtaAtL0DJtXmkFkjE
	21agtVEzobGH5zYsKXuzCuNAyGKuFW0/qaezsoqiahIA1kpLy+YaP9HjlGx96vEV17m8wsyy6Kz
	ZAnFlol48L0qbvkaUTBxO0JDdTzLCtitR5NupZAWFzyRp0BX8ZYgPZeCQeSanG6pE9/sa7EXw0h
	X4GwTPXeAzuGPO4cu7iyqIPm9Zpkl3ZP8zhYgrkYnUm4qoQ7+5C15JsO92bVqqlDLzr+lLP2PcH
	MD417U8lk2+7cknPs1v9tdhy2ze5/lV0Pz2mFjWPC3tmjIKyxT4iGo0s6EaW3bFff6iWIJIwhHe
	ydCcODgSXuTh5n0Dar5gBHzGccmL1mKYHeu3IEklM8Sk/yw==
X-Received: by 2002:a05:600c:3492:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49fc574ef31mr134634405e9.31.1790000816493;
        Mon, 21 Sep 2026 07:26:56 -0700 (PDT)
Received: from [192.168.100.51] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd103325sm272935465e9.9.2026.09.21.07.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 07:26:56 -0700 (PDT)
Message-ID: <5191e6a3-0392-4ead-93a8-3ecb5bd60520@gmail.com>
Date: Mon, 21 Sep 2026 16:26:54 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Fix false warning in
 ring_buffer_map_get_reader()
To: Vincent Donnefort <vdonnefort@google.com>, syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, syzbot@lists.linux.dev
References: <15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org>
 <arDm2LvdlWVe9JC1@google.com>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <arDm2LvdlWVe9JC1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/2026 10:12 AM, Vincent Donnefort wrote:
> On Fri, Sep 18, 2026 at 02:34:25PM +0000, syzbot wrote:
>> From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
>>
>> In ring_buffer_map_get_reader(), an unconditional WARN_ON(!reader) is
>> triggered when rb_get_reader_page() returns NULL:
>>
>> WARNING: CPU: 1 PID: 5906 at kernel/trace/ring_buffer.c:7998
>> ring_buffer_map_get_reader+0x940/0x9d0
>> CPU: 1 UID: 0 PID: 5906 Comm: task Not tainted
>> RIP: 0010:ring_buffer_map_get_reader+0x940/0x9d0
>> kernel/trace/ring_buffer.c:7998
>> Call Trace:
>>   <TASK>
>>   tracing_buffers_ioctl+0x258/0x300 kernel/trace/trace.c:7381
>>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>>   do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>   </TASK>
>>
>> This warning is triggered due to a race between a writer committing events
>> and a reader mapping the ring buffer via TRACE_MMAP_IOCTL_GET_READER. When
>> a writer commits an event in rb_set_commit_to_write(), it advances
>> cpu_buffer->commit_page to cpu_buffer->tail_page in its first loop before
>> updating the commit counter (commit_page->page->commit) in the second loop.
>> If a reader invokes ring_buffer_map_get_reader() at this moment, the
>> initial check cpu_buffer->reader_page == cpu_buffer->commit_page is false,
>> and it calls rb_get_reader_page(). Inside __rb_get_reader_page(), the
>> reader swaps reader_page with the head page (which is the new commit_page).
>> Because the writer has not yet updated the commit count on the new page,
>> rb_page_size() is zero and reader_page->read < rb_page_size() evaluates to
>> false. __rb_get_reader_page() then checks if cpu_buffer->commit_page ==
>> cpu_buffer->reader_page. Since both now point to the swapped page, the
>> condition evaluates to true and rb_get_reader_page() legitimately returns
>> NULL to indicate the reader caught up to the writer.
> 
> This seems to make the check above reader_page == commit_page redundant. Doesn't
> it?
> 
>>
>> Furthermore, rb_get_reader_page() can legitimately return NULL when there
>> is no data to read. Re-checking mutable writer state such as
> 
> We are checking rb_per_cpu_empty() with the reader_lock held few lines above. I
> don't believe we expect NULL here for that reason.
> 
>> cpu_buffer->reader_page != cpu_buffer->commit_page is insufficient because
>> a writer on another CPU can advance commit_page before the check is
>> evaluated without being stopped by reader_lock.
>>
>> Because WARN_ON must not be used for conditions that can legitimately
>> happen, and pr_err should be used instead if necessary, remove the
>> WARN_ON() entirely since returning NULL here is an expected condition.
>>
>> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
>> Assisted-by: Gemini:gemini-3.8-flash syzbot
>> Reported-by: syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=de3d7f9bcc9212f3fae1
>> Link: https://syzkaller.appspot.com/ai_job?id=488adc18-a10e-42d2-a205-25327c38837f
>> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
>>
>> ---
>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>> index 9c03a555a..1a4da3d47 100644
>> --- a/kernel/trace/ring_buffer.c
>> +++ b/kernel/trace/ring_buffer.c
>> @@ -7995,7 +7995,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
>>   		goto out;
>>   
>>   	reader = rb_get_reader_page(cpu_buffer);
>> -	if (WARN_ON(!reader))
>> +	if (!reader)
>>   		goto out;
>>   
>>   	/* Check if any events were dropped */
>>
>>
>> base-commit: df2908090cda368b01ff43709f51890076c56157
>> -- 
>> See https://goo.gle/syzbot-ai-patches for information about AI-generated patches.
>> The person who has signed off on the patch is responsible for
>> addressing comments.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 

Thanks for taking a look into my patch!

 >
 > This seems to make the check above reader_page == commit_page 
redundant. Doesn't
 > it?
 >

Yes, it is no longer needed for correctness once a NULL result is 
handled without a warning. It remains a fast path when the reader has 
already caught up, avoiding a call to rb_get_reader_page(). I can remove 
it if you prefer in v2 patch.

 >>
 >> Furthermore, rb_get_reader_page() can legitimately return NULL when 
there
 >> is no data to read. Re-checking mutable writer state such as
 >
 > We are checking rb_per_cpu_empty() with the reader_lock held few 
lines above. I
 > don't believe we expect NULL here for that reason.
 >

Yes, you are right, an empty result exits before the helper. But 
reader_lock does not stop the writer and a nonempty entry count does not 
guarantee a committed page. After swapping the reader page, the helper 
can catch up to commit_page and return NULL. I can clarify the commit 
message as part of v2 patch if needed.
