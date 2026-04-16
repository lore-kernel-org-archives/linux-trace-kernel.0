Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C833C19E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315473; cv=none; b=apbhnxNZDazijd/Rlbi/QyEfE3hhvwcGLQw06acaGajVS0TzLexaqYZwmGPw6KOaFQf/NL/JIGss6lwlycrFCjpdiZfmA2gXZwa6AawXHpRBBRTs06ZyZqPerDmlbcCFUy/ePaRsMPCp1VAocmSJS9+cHT9HooqwmtHoCOZuDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315473; c=relaxed/simple;
	bh=yVYbxHeIoVJCctXTuuSgSApkORzkzhjnq4+3ov2IETM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1OUaZEQJgjiIKKiQ2D9TAvJsmwPoYySRTu8htfCXwkYtXgad//C6Kof/No6ZfPAZl64K+/nvOWLOqKX+9PsWawADLIYNQltVW1ne+z0RilPQLfTUZ6z4XWeM5hI4sFAHvY1Qt2l6Y+tzaBCJc3J6CCN4lDkA0uQkmOL6TMEkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuebZ76J; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuebZ76J"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so1744052a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Apr 2026 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315470; x=1776920270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiN0RfmkSs4otdyTHmyH7CDjyefKOusScNU8kWaZ/cg=;
        b=VuebZ76JL5hayI+hBo6vr0/5Ha2PgfhH1qkRGohgByn8EwQLW112LaWsNXfI5F07HC
         4sgEv9+R6jgsRYQ5Q+alc1l4zK/GJjF6rEqxpMRpZ0SzoFSLqNzYnqiz+kDkPm/kRqKn
         WDtk17uiGoRewiX0l6Ci8jaDphO59G2Cdn6dC2lTcD7ah561BleKYGqyxlbZ+DFF9+Zi
         VebP31WgfVZ+LaAPPmt3mwiOLKxyAB+bOs5MHx9PgOg4xFtu/WpMfYp3Gy6Wc8jAYZLu
         Ikc9y7+pc/hebwc3BQOtkZ16MfzCax+VCuEQluzPCRqcS0hMiUo5hSc+XVl3AdmbvGjM
         fCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315470; x=1776920270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiN0RfmkSs4otdyTHmyH7CDjyefKOusScNU8kWaZ/cg=;
        b=akB2E5FoUkLUL+wyH4Pg6eP9HbyCrQK0zXl6oUXW0jiXxe4wMCMd7/hu9oPgSD+Zkf
         317jOBynRuGTGZhlMA6w8rC3t6z6CsjOH6rHS9xstC4BAw9jP7t/sZeI4rgOPxMNSqIX
         pHtYx1GuNVOvYtRcQGpz3yqZPt/UoRbIaObNAizMnS7nNqvj5QSfuZ4ne2cWXNWsaNLk
         9vjNIt/KML6iY2ZGKOqMVOdzm9YIlu5uRGqs/+fEdEQGMeoIoV4GpJgPw3oS1p8ti28P
         SDhcbnibDxyZvRdgRckI7aAZiM7VCcVmR6zgyvknds5iihaop0Y3NDpiG0v0eJG2WCgm
         jFbw==
X-Forwarded-Encrypted: i=1; AFNElJ++X4wcChQmVBIslHpc90fkoxKOvx+hzzztnjVQw8gCWTSF07CXmbYS6qaiBlv62jAIq3KTgfNvQPJJFLgKJIg1e/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFtwT8q9d8s0jf0SwAH4w0+6kV4LO1ITcMFB2v5uO/tRZVK1P
	rr3NYHLRUsEMV9z+UOiyNLXkMdzrpN6faADse1umk32BjqbW/M5JCiJSzAsrZg==
X-Gm-Gg: AeBDies9+Ftsq0BjuZwxxtPGD/6IfxooMqfHuco05X8gQrJonfvjcsaf/WT+KWPHlIl
	TrhsqHXmmK/HKM5T6eAm30BZl2iwN/09s0AKSJZ+QbkxxHckcYTVJdrV4uxwA9j9EB0vip3YFfT
	ZjJvLQivvYDw6UaL8v28PsoWEx7ayB6KwZUpeRFk8XDPczQM4PfqW0TuqrM96UzeIhRkEzpAqO+
	8PA15/UcCxYpoEoNmJH9bIRvTom+78SJLAR4XdtX8OfqMEPxUvSwGeayF4IzlCgtibrf/WYlSgg
	KBOk4IEJF1g09kNFvqeKLtBCWVudQX1BpA/Bzgb+2JrzY7bA8BaMMCOVINRqjJV+gb8L7S9ojkF
	DaDYxWam6MiNDoP1ZSw7hltyqONMe0z8MlGwc1w5a6+RdgSWTrTibkJlFDY05qe4ZkGOfpVuKf4
	nAmqPRSeTD4Bu/Fhd1o2QbOLhSrzRWRF14spz4BPhgk+Zy2dGHOB4qi7hURl5M
X-Received: by 2002:a17:90a:d888:b0:35e:5a4c:9069 with SMTP id 98e67ed59e1d1-35e5a4c9205mr17262448a91.14.1776315470340;
        Wed, 15 Apr 2026 21:57:50 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c42:2fce:8c3f:5fe6:9cda:e56? ([2401:4900:1c42:2fce:8c3f:5fe6:9cda:e56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cd52adsm778419a91.11.2026.04.15.21.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 21:57:49 -0700 (PDT)
Message-ID: <eb751bc8-c6db-430a-9ba4-9218928c3a3a@gmail.com>
Date: Thu, 16 Apr 2026 10:27:41 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] openrisc: Add utilities and clean up simulation of
 instructions
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
 chenmiao.ku@gmail.com, johannes@sipsolutions.net, nsc@kernel.org,
 masahiroy@kernel.org, tytso@mit.edu, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
 <20260407185650.79816-2-sahilcdq0@gmail.com> <ad51SeeF2Gv06mgQ@antec>
 <20260415153912.f26b46a37a078f491836bd76@kernel.org>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <20260415153912.f26b46a37a078f491836bd76@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Masami,

Thank you for your review.

On 4/15/26 12:09 PM, Masami Hiramatsu (Google) wrote:
> On Tue, 14 Apr 2026 18:11:37 +0100
> Stafford Horne <shorne@gmail.com> wrote:
> 
>> Hello Sahil,
>>
>> Thanks for your patches.  I have a few questions. so this is not really a
>> technical review at the moment just some main items.
>>
>> On Wed, Apr 08, 2026 at 12:26:49AM +0530, Sahil Siddiq wrote:
>>> Introduce new instruction-related utilities and macros for OpenRISC.
>>> This is in preparation for patches that add tracing support such as
>>> KProbes.
>>>
>>> Simulate l.adrp. Fix bugs in simulation of l.jal and l.jalr. Earlier,
>>
>> Why emulate l.adrp?  We don't really use this yet in any OpenRISC code.  This
>> instruction is meant to be used to help -fpic code, see:
>>
>>    https://openrisc.io/proposals/ladrp
> 
> Maybe because l.adrp depends on InsnAddr (instruction address),
> if kprobe runs copied instruction on its trampoline buffer, it
> generates a wrong result. If it may not be used in the kernel,
> arch_prepare_kprobe() can detect it and return an error.
> 
> [...]
>>> +
>>> +#define OPENRISC_INSN_SIZE  (sizeof(union openrisc_instruction))
> 
> This should be defined within an architecture header file.

Sorry, I am a little confused here. OPENRISC_INSN_SIZE is in OpenRISC's
instruction definition file (arch/openrisc/include/asm/insn-def.h).

The instruction size for Arm has also been set in it's own insn-def.h
file [1].

>>> +
>>> +/* Helpers for working with l.trap */
>>> +static inline unsigned long __emit_trap(unsigned int code)
>>> +{
>>> +	return (code & 0xffff) | OPCODE_TRAP;
>>> +}
>>> +
>>> +static inline bool has_delay_slot(void)
>>> +{
>>> +	unsigned int cpucfgr = mfspr(SPR_CPUCFGR);
>>> +
>>> +	return !(cpucfgr & SPR_CPUCFGR_ND);
>>> +}
>>
>> This is for handling CPU's that do not have delay slots.  We didn't do this
>> before, why are you doing it now?  Should we mention this in the git commit
>> message?
>>
>> Also, since this is a static configuration for the CPU should we use static keys
>> for this?
>>
>>> +
>>> +void simulate_pc(struct pt_regs *regs, unsigned int jmp);
>>> +void simulate_branch(struct pt_regs *regs, unsigned int jmp, bool has_delay_slot);
> 
> Also, do not use the same name for a function name and a local variable.
> Please rename has_delay_slot() to machine_has_delay_slot() or rename
> the has_delay_slot parameter to 'delay_slot'.
> 
> [...]

Oh, good catch. I missed this. I'll change this and retest.

>>> +#include <linux/ptrace.h>
>>> +#include <asm/insn-def.h>
>>> +
>>> +void simulate_pc(struct pt_regs *regs, unsigned int jmp)
>>> +{
>>> +	int displacement;
>>> +	unsigned int rd, op;
>>> +
>>> +	displacement = sign_extend32(((jmp) & 0x7ffff) << 13, 31);
>>> +	rd = (jmp & 0x3ffffff) >> 21;
> 
> Please use GENMASK() macro instead of hex value.
> (Moreover, define meaningful named macro instead of the magic number.)

Understood, I'll fix this.

>>> +	op = jmp >> 26;
>>> +
>>> +	switch (op) {
>>> +	case l_adrp:
> 
> l_adrp seems have 2 modes. Is this OK only supporting 32-bit?
> 
> 32-bit Implementation:
> rD[31:0] ← exts(Immediate[18:0] << 13) + (InstAddr & -8192)
> 64-bit Implementation:
> rD[63:0] ← exts(Immediate[20:0] << 13) + (InstAddr & -8192)

I think supporting the 32-bit version should be good enough for the time
being, since OpenRISC's implemention in the kernel is 32-bit. Please see
the following comment from the patch series to support jump labels (published
last year) [2]:

> for us it's more correct to use u32.  I always thing unsigned long is
> OK in openrisc as we have no 64-bit implementations.  But might as well have it
> correct in case we ever add the 64-bit implementation.

I haven't found any OpenRISC patches in the past year that add the 64-bit
implementation.

>>> +		regs->gpr[rd] = displacement + (regs->pc & (-8192));
> 
> Please use nicely named macro instead of -8192.

Got it. I'll make this change too.

> Thanks,

Thanks,
Sahil

[1] https://github.com/torvalds/linux/blob/master/arch/arm64/include/asm/insn-def.h#L9
[2] https://lore.kernel.org/openrisc/20250805084114.4125333-2-chenmiao.ku@gmail.com/T/#mb4a939437351b705c30ec7f9e9195d519f9b586f

