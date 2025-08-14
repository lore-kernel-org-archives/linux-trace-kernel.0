Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBC2D46BC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171326; cv=none; b=mf72/VuSjczFQnZZxc2xmUeVBGEYsVJDgW34mS4sBS/fM93XDKSkkRbXuscPOOKxdq9QLoxIxj8zmwS1eT5//ew7OmCQy4VWAZ3vVzVQPBgKGr870Yp8lpGvVv2OBb97OifBbPH80a/3gJOKa2SHWkEVnWGTnogVpP3QbwA45uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171326; c=relaxed/simple;
	bh=nDspi5PIcAYWdxA/EU332nj4Texe0LRHlFxJOAQtBaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/VfHO7IF+kcCmJCCCN7Wd0YVb4gGojA+dkOkPZHWqX8ewSHIo13Yn8AabzlWWYKr7OTYHVD5gw4fS5jNF7wyn6BfP1d95JmJO3/8YN5six0R4Q1ccP9RGfSD/kkhTJanwWFX2nKCm3dKyh5oDpMKuHWIKERD85slNWxzm8T6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ww+t6c8L; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ww+t6c8L"
Message-ID: <cfc4594a-7352-491a-b643-a87804f22322@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755171321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfMJrYIyAcG+mjlukJ3S8XF3yl49bz3YOmF0vqdDPhM=;
	b=Ww+t6c8LO+cT2C6CCvMsZjak3sh3oIAIeEkKVef7v+gq9DGBLSyaDEa3MivONWBzrxrXGt
	S9Tv3kp0hFKvfd3VczRd89j88yW1AuLwzK+DFXWd+DEVZ9EUOJLhBc26s22bt5x85n7Lhy
	F3nQDRxY0QaiZjvPKwkALypGRgnAJl8=
Date: Thu, 14 Aug 2025 19:35:07 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Remove migrate_disable in
 kprobe_multi_link_prog_run
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250805162732.1896687-1-chen.dylane@linux.dev>
 <CAEf4BzZduEdBCzm56zwgrHpzV=CsMbzfVi5oR9w3H4vUQL6FYw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzZduEdBCzm56zwgrHpzV=CsMbzfVi5oR9w3H4vUQL6FYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/13 06:05, Andrii Nakryiko 写道:
> On Tue, Aug 5, 2025 at 9:28 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> bpf program should run under migration disabled, kprobe_multi_link_prog_run
>> called all the way from graph tracer, which disables preemption in
>> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
>> need to use migrate_disable. As a result, some overhead maybe will be
>> reduced.
>>
>> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Change list:
>>   v1 -> v2:
>>    - s/called the way/called all the way/.(Jiri)
>>   v1: https://lore.kernel.org/bpf/f7acfd22-bcf3-4dff-9a87-7c1e6f84ce9c@linux.dev
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 3ae52978cae..5701791e3cb 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2734,14 +2734,19 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> 
> even though bpf_prog_run() eventually calls cant_migrate(), we should
> add it before that __this_cpu_inc_return() call as well, because that
> one is relying on that non-migration independently from bpf_prog_run()
> 

maybe cant_sleep() is better like trace_call_bpf, cant_sleep dose not 
check migration_disabled again, which is done in 
__this_cpu_preempt_check. I will add it in v3.

>>                  goto out;
>>          }
>>
>> -       migrate_disable();
>> +       /*
>> +        * bpf program should run under migration disabled, kprobe_multi_link_prog_run
>> +        * called all the way from graph tracer, which disables preemption in
>> +        * function_graph_enter_regs, so there is no need to use migrate_disable.
>> +        * Accessing the above percpu data bpf_prog_active is also safe for the same
>> +        * reason.
>> +        */
> 
> let's shorten this a bit to something like:
> 
> /* graph tracer framework ensures we won't migrate */
> cant_migrate();
> 
> all the other stuff in the comment can become outdated way too easily
> and/or is sort of general BPF implementation knowledge
> 
> pw-bot: cr
> 
> 
>>          rcu_read_lock();
>>          regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
>>          old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>>          err = bpf_prog_run(link->link.prog, regs);
>>          bpf_reset_run_ctx(old_run_ctx);
>>          rcu_read_unlock();
>> -       migrate_enable();
>>
>>    out:
>>          __this_cpu_dec(bpf_prog_active);
>> --
>> 2.48.1
>>

-- 
Best Regards
Tao Chen
