Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590211;
	b=wNLG4y75etnu+V9Umf1DeXaom2i8W4O7EnReN4oQZPqOGOp/0YT5C7auumMrkjTQGPOR
	 nEIuKoFQoQZS76TSo0RYSXfG4BbRhhsh1eauCleiEGyM5NFCEewhxxJCGjIjQ3q/ku8Fn
	 p/MkEzkUubDTpHzjULgaAHiO1UL5Suf2D6cl3lsBGmia6z4gSChaxbhGkyz+Fp/EbfHLO
	 3x3HIXU0bCHyPIs0fOAo6Jw1Qo0xkn0GGnMlqg5A9nk+xRqwS0jp8WayR4Fbf7Aeqhdl5
	 QxR/9v0h/u9vHHoSLUAmMWSkANvPOoGuVo6diBnFpnzi6U1jVxyGikEPO1M8vTxcT4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1NnwoeqjhMRZA613FNn5ml0JxbTNE6hC+WRkyiGE1vE=;
	b=b8kfEtkG3I1MfkzJaSUt1d7cVKKJDkJVqX6GFdnMwKN5DMMjfX0lPQoxnyFxYsUw7Jmx
	 OgJXK5Vkb0y/x8n0QqvnW0+C3I70MOTBYyolYtQgHG3FMLUVk/Xj+b6k4QKB4UyBRcNOE
	 wH/p/3hIcIzQB876PZFI12vMEpoRjw8yu0EQFNKEGMd1ADSFQmwX3+lRaYKJgzQIk1tgF
	 gZ8GIFG5eOcscagEV8S4ks4C0WNIkUWaZ7q+qzds1SsExsQPg0mxqK0QLVvpQZF69p4Jo
	 G+yH/R9No4r3gkvTl9XiaykFj0vH2IcUdujskV2Bk2Gv33xDpNCxeW4kUxeYa+8VoPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smAQ9sJ9;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A8606A88F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 17:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6A8606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smAQ9sJ9
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so1196226c88.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 09:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590210; x=1795195010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1NnwoeqjhMRZA613FNn5ml0JxbTNE6hC+WRkyiGE1vE=;
        b=smAQ9sJ9ED1e8iN8XRJLVO5ZrCNIyjWAp7cVA/514X2FbnIKXxGzVIvvjYL9swD0c7
         IM8Hx4zvQiFcGWf5cjri06K4RgyFXDDspxmF+rbSEQ+zmUxHnlgd0a6hEked587iN+A2
         Sk3ztiLzIJ3JGPzUHSMgK0VNTsolGVU/3ANRTfp8Q22+yzizwMG6oEtPqaZPmFEzEkWA
         2rV65rmhuS0veszEllCWZYQUEshFDyL884+hvCtufoj9GeEoXPfM8e/SUp7g0dqtPHDG
         1kwdn5/mrsd5wJ+dXAZzoFVdIybtHrSxPpwyZfYr+lHnogfPbYRsHnQD7rgcCECJiyMi
         qniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590210; x=1795195010;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1NnwoeqjhMRZA613FNn5ml0JxbTNE6hC+WRkyiGE1vE=;
        b=Uq6DXgLSTODVfq6WTWFLNWWWHXvrpfOR13tEzVGqvWkGloXBE2LwlA7P/SnnsdSnGp
         anC6YVJP22g2qnnsfJ7vNRCRx4JpnGxk2DzfM1qVNyh/yh3saPooNUo0vOHmot87Y+n3
         jtHDsR4qoBEaTA5OKWPi73cKqHnsjN2CWVSjE2qTMzw9lqGi6tteR8oZQFXuMkF5QmCJ
         63jecrnLTX9OUMY1KS+gotmOZb0vkLYp7yG61eObYd6iNdiCDPlNUJMUnc/KwVIh6LmR
         g2zmsrHFe2KYu2m0ZK1cL+RaFHAvomXi/Vv4nV1hUJyR+xNi6TO2UsLVs2A+ABjr5cj0
         wyLA==
X-Forwarded-Encrypted: i=1; AL+hErHvX6j2T3zpzRf7FEcvvL3WIYJ3qx4xNjgoMsh6LLCpthfBm0fIGYU2gVjs4zey9M/GHi7FpnCfq+jnM8G+oZlK8Eo=@vger.kernel.org
X-Gm-Message-State: APuU4Z98+/P6qf7SKHtT5WzTv+/iKo+P2ilP11oVe6axOZv7Osz3pw6q
	Rdajzf2aEjUQmJVejnHFMcPJgjIbLwp3GS4loDVhZ8VsoznyJQ/BE35t
X-Gm-Gg: AYBFou3Ly5k70bn3eL2U4qofAqgMkWSDYGzBnKzWkb764xP7e5S2sn7lBR7VyTIfITW
	ClDOehFFy1bFm2xO84zuLuQt0IIxbcjZMeWz1brjXiCldgFKWDoB/L7JiFusmBpMfAzisejKP9Q
	cJLIFDrdhDZXewiOKJvQg8q3n70vgaxCpJHYPeDdTDqA4eWBhukAQIz1LVYFVqFZTyBi2AuaQtS
	j+J4IUNpH0nKoWIkEFf/trKH0+TiV0YOcqNVyeceYmYL4r/eg3kG65INgjgpIfuMjkcf1r0b4BQ
	UAKfeCAk89Q+S+kx33VYkcmkWW6MfhXKtYUAMc5YjOF0Mk1wZ7HoWEpPnBJm6sQifP815i+bc3p
	DSaOafrCGDo/7rg6oOUAY7I1pjp4uPlgncHjKRuMwfXqnu8EuItQEKb2HaAZhMaqMMG8Dw/XkPO
	gT2eEdHxiFOxpGIcv3n2vIU/of8s03JGM2B0jqfn3HlJ4TWxrkTiWjq9AzmiYpDb4YnkSzC5rfO
	fGEGM7bABa3/uACA7jls+YrJW+ew60xihDacUvHspgU7eft6gdKGDdOnTo1BbrK6IOo0XoW
X-Received: by 2002:a05:701b:2202:b0:1b5:e9d:c641 with SMTP id a92af1059eb24-1b50e9dcabfmr765113c88.18.1794590209794;
        Fri, 13 Nov 2026 09:16:49 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm10299969c88.5.2026.11.13.09.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:16:49 -0800 (PST)
Message-ID: <3a931844-7b7f-4408-8d92-d0604ca7d51d@gmail.com>
Date: Fri, 13 Nov 2026 22:46:45 +0530
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil <sahilcdq0@gmail.com>
Subject: Re: [PATCH v3 4/4] openrisc: Add Kretprobes
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-5-sahilcdq0@gmail.com> <avArkiSOmUfSrmYF@antec>
Content-Language: en-US
In-Reply-To: <avArkiSOmUfSrmYF@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 1:28 PM, Stafford Horne wrote:
> On Tue, Oct 27, 2026 at 01:42:40AM +0530, Sahil Siddiq wrote:
>> Add Kretprobes support for OpenRISC. Kretprobes allow a probe to be
>> fired when a function returns. They are built on top of the generic
>> rethook framework and also require the KProbe mechanism introduced
>> in the previous commit. This work is primarily based on similar work
>> done for RISC-V.
>>
>> Kretprobes work by inserting a KProbe at a function's entry point.
>> When the function begins to execute, the KProbe is fired and its
>> pre-handler replaces the function's return address with that of the
>> rethook trampoline. The trampoline in turn calls the kretprobe handler.
>> Control is returned to the original caller following this.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>> ---
>> Changes v2 -> v3:
>> - arch/openrisc/kernel/rethook_trampoline.S:
>>    (save_all_base_regs): Save SR and SP registers
>>    (restore_all_base_regs): Restore SR register
>>
>> Changes v1 -> v2: New commit
>>
>> [...]
>> +#include <linux/kprobes.h>
>> +#include <linux/rethook.h>
>> +#include "rethook.h"
>> +
>> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
>> +{
>> +	return rethook_trampoline_handler(regs, regs->gpr2);
>> +}
>> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback)
>> +
>> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
>> +{
>> +	/* Store original return address and frame pointer */
>> +	rhn->ret_addr = regs->gpr9;
>> +	rhn->frame = regs->gpr2;
>> +
>> +	/* Set return address to trampoline */
>> +	regs->gpr9 = (unsigned long)arch_rethook_trampoline;
> 
> Though this will work, in the kernel code we prefer to regs->gpr[n] syntax
> for accessing gprs.  So to be consistent could you use that?  i.e. regs->gpr[9];

Sure, I'll change this.

>> +}
>> +NOKPROBE_SYMBOL(arch_rethook_prepare)
>> diff --git a/arch/openrisc/kernel/rethook.h b/arch/openrisc/kernel/rethook.h
>> new file mode 100644
>> index 000000000000..332306a5c380
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/rethook.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef __OPENRISC_RETHOOK_H
>> +#define __OPENRISC_RETHOOK_H
>> +
>> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
>> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
>> +
>> +#endif
>> diff --git a/arch/openrisc/kernel/rethook_trampoline.S b/arch/openrisc/kernel/rethook_trampoline.S
>> new file mode 100644
>> index 000000000000..5e8fd5a65222
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/rethook_trampoline.S
>> [...]
>> +SYM_CODE_START(arch_rethook_trampoline)
>> +	/* Allocate enough space on stack for pt_regs */
>> +	l.addi	r1,r1,-PT_SIZE
>> +	save_all_base_regs
>> +
>> +	l.addi	r3,r1,0	/* pt_regs */
>> +	l.jal	arch_rethook_trampoline_callback
>> +	l.nop
> 
> Could you indent the delay slot? For example:
> 
> 	l.jal	...
> 	 l.nop
> 
>> +
>> +	/* use the result as the return-address */
>> +	l.addi	r9,r11,0
>> +
>> +	restore_all_base_regs
>> +	l.addi	r1,r1,PT_SIZE
>> +
>> +	l.jr	r9
>> +	l.nop
> 
> Indent here too.

Sure, I'll format these as well.

>> +SYM_CODE_END(arch_rethook_trampoline)
> 
> Thanks,
> 
> -Stafford

Thanks,
Sahil
