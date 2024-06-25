Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91E153506
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330312; cv=none; b=Gjg6oHhifvUxdckXcp0iu9g71UmmmsxyR9+BdU1pFy9JIohOh4dtRFpDaKSAk1clt9JWafBdHRsNmQ7CIOWO4lYaSirColELzS1Z5ngKHgHGmQXE2DTpbf2Gda6cElTIAHRjF8ZBMHfXdVp+DY0lmgPSEHAWc6UA2vUz91AmEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330312; c=relaxed/simple;
	bh=hf5eUmooJC7dWoChVFFPsyBXOKh1NM93BaxyD/i/B2Y=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=bpozkzHTOPgZ3TtFOTW2evjS7/UhLJJagiCJFpkSltnovK2DGO92/H8lqq6lBgDcjFL1exrTMuNXfUynrtW944z/Q0P5229z4rQ9jcm/UjOVVMO8nM/6lv9F9QWwYmVnk/pze4L998E0FWXtQO3pBj+4pxubA1SY8kgQkHGVMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=UxCp0fxH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="UxCp0fxH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6c53a315c6eso3933636a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1719330309; x=1719935109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tZOMKcRfzsOTLcaI6P+nurFJ1oFQE37Rn/GemYRQhk=;
        b=UxCp0fxHEqZmwtgUKLRf2Ye8esSEOv7F3/gtGn+v6gDJcBDBhN6DEjIA/7++GtfvLf
         GOSGRQ46Exm3dqhsdYG/wGpObpNob9D/aQGbtE0M2AplTHuHey9hbu65vxzthZ2B1CXS
         sw03VAbR9/SRYIz1Rj5Isv+LQGg/9CZvHZSroQoKd30LB+yS6SCOHjLaxK8Xl7umkNx1
         vuafFbmiZp9h/Qb6SGV55VAoXwuv/NXSDELdUFesP9Jv53DsW1ZzJU/fNK6CTvBRlGv8
         3jWwt26GWE3D56vbAyMqGc6+xzUyUR6tgWG9FwWo8qPMexGPPdJBa05x27vhtnqjS+1M
         gOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330309; x=1719935109;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tZOMKcRfzsOTLcaI6P+nurFJ1oFQE37Rn/GemYRQhk=;
        b=dkPgHvTUqpZP+8a1KxJAGCCnZl7fzLUZz2u0n332hU4/t291a+wFU1BRE23P/2YX0x
         5OvMq0znAR+a3YT3+jHblWt2svQjNjAnEGq0L6msraeIOJAfU568tMwnYK/sVA6X3CPJ
         UXZI++j40JxJwKU19uIc4g815vF2WAa8Vn6DQszx1xIL658bzsS8E+ShaUsckK15EYk3
         XH/rIhp6RbyFRH9SbobpoXqUszpQSK/L7cbRw6be80dR+CwnBAD49GOgz+MkBI0NYTzs
         akgCaXMM7Y3OmB6mhtokHwHt8eg0ZhRVz09wPAqh8bs9GPceLqUvl9vFNWXerjwLjd6E
         qEmw==
X-Forwarded-Encrypted: i=1; AJvYcCV0u//eP5sag7u4E+qJpUWK9nhNKKBGYWU34+buU8crefTjHmP/usWnL/QaWnzebSIwRSiJlPgtFs8s3xUmWCQGATGR+N+ODr2BpDnPA/BvFMgU
X-Gm-Message-State: AOJu0YzUqOgdBn9iQNZGz/r8ycCF4OYL/sk6JtNUQuh/yc2kELfXICau
	DbcPOnMVBH3zjDQuK5fuvLzvQQWRHB7ZOJ7GoUH7VjE/7r7yMrQYoWe5D1Pev/o=
X-Google-Smtp-Source: AGHT+IGSYCPwWhLTCA7tsdYi2n2YERYEuj0Bk7h22FlWi9B1mlJhhHz/QYqnR8FLA80DAw08tCIl9Q==
X-Received: by 2002:a05:6a20:b918:b0:1bc:ed85:3920 with SMTP id adf61e73a8af0-1bcee9893f4mr7574816637.52.1719330307012;
        Tue, 25 Jun 2024 08:45:07 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70677235b41sm4843347b3a.24.2024.06.25.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:45:06 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:45:06 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2024 08:45:05 PDT (-0700)
Subject:     Re: [PATCH 1/8] riscv: stacktrace: convert arch_stack_walk() to noinstr
In-Reply-To: <cb71a5e9-aafe-48af-9f16-baae407d467b@ghiti.fr>
CC: andy.chiu@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, alexghiti@rivosinc.com, zong.li@sifive.com, rostedt@goodmis.org,
  mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>, nathan@kernel.org,
  ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, puranjay@kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
  llvm@lists.linux.dev
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-37c10407-3c40-4045-9627-0b53f770cb4e@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 18 Jun 2024 02:55:32 PDT (-0700), alex@ghiti.fr wrote:
> Hi Andy,
>
> On 13/06/2024 09:11, Andy Chiu wrote:
>> arch_stack_walk() is called intensively in function_graph when the
>> kernel is compiled with CONFIG_TRACE_IRQFLAGS. As a result, the kernel
>> logs a lot of arch_stack_walk and its sub-functions into the ftrace
>> buffer. However, these functions should not appear on the trace log
>> because they are part of the ftrace itself. This patch references what
>> arm64 does for the smae function. So it further prevent the re-enter
>> kprobe issue, which is also possible on riscv.
>>
>> Related-to: commit 0fbcd8abf337 ("arm64: Prohibit instrumentation on arch_stack_walk()")
>> Fixes: 680341382da5 ("riscv: add CALLER_ADDRx support")
>> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
>> ---
>>   arch/riscv/kernel/stacktrace.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
>> index 528ec7cc9a62..0d3f00eb0bae 100644
>> --- a/arch/riscv/kernel/stacktrace.c
>> +++ b/arch/riscv/kernel/stacktrace.c
>> @@ -156,7 +156,7 @@ unsigned long __get_wchan(struct task_struct *task)
>>   	return pc;
>>   }
>>
>> -noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>> +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>>   		     struct task_struct *task, struct pt_regs *regs)
>>   {
>>   	walk_stackframe(task, regs, consume_entry, cookie);
>>
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> I'll try to make this go into -fixes, this is in my fixes branch at least.

Looks like there's some comments on the rest of the patch set.

Andy: aree you going to send a v2, or do you want me to just pick this 
one up onto fixes now and then handle the rest later?

>
> Thanks,
>
> Alex
