Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590109;
	b=UhGOVABapKdc1QJSTIl8KhZ/PuJhO8ZhX9djbL+8C1OBX5BFPFqsIywISHCadGWixWwX
	 X/1JiiTZ9c6d2XaGar17EAPKorIcLMqqjci8gjgfYrO/hPN+kYatDDdQvY8HSG6IqusQO
	 t0LAUuXjUrpKJHmoVxQrEz+zF0TSLuDShiK5r1vJO+lZZHVqteZ2j9D8BxGpEv1pJDs5i
	 osiO77o5gWcVV3YY2x3FwKYWUH7nthc3KnVRbvrhSk3X+vGbaPUuIi8136t+W9c4Xzuoc
	 V1ANNMdEPo7QWEO6gJn7u9f11IZK7Qr1VbjXq/oPes/hRUnOpKiksz7PK1MRHkQ08XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TJaikHgxJ0Cfj902txSyNLryimhDtp9xIHKHj6RuZzg=;
	b=Ywqm7PRPI49s7uEnowUvxmSoQZO4TbeIx6qPmH9CciBLP0feY5toNEw6OhA4KX8KcI0m
	 eqOyaIj/p8m4nnOAvke5h1LcjG2GNRPPaUelaJoN2ecftN2YLuaAfCczr6u6YoYgISeEB
	 7TeCIrPHuD3X0L0GYOIE3BqHEShpuHumfEVOGHsUYgOnqLYOhUd7o7D0l4KwaWOe6vL7F
	 i1yPFgMwnl3DteUKZQYUseog9/NEh5BCllQpQ/mBIQlSPO6ycNK4fulVwbzUpESWBcyXk
	 7YFWsf5aHivLRtZgEgc3d874IXCCcB+cKUH8sP8IVP7q3N1klbTucbdfWqpk+XPx0Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlJa3P+V;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61D60A5BDC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 17:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B61D60A5BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlJa3P+V
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1050767c88.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590109; x=1795194909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJaikHgxJ0Cfj902txSyNLryimhDtp9xIHKHj6RuZzg=;
        b=XlJa3P+V1CGQ/cuiUm4lc7wiEge72cZrg28BycoQJVcJvnvxPuHOXs0s89ppNSq7cq
         KbGid7lOM8ooFynmwNbHbCk9/Y1beu/P89WtAjjGT/WRRpa3DtZKvM6Sbj8jQKK1lEXd
         kh1xG2bZYvyX1QcVjONz4lpxvMU3ue+JnfLJgiQ2Q2plcsqisiv3lUx57xaanJMnWRq7
         Lwp9FMbZfpv2I0hgBXDGZQD8oNGHOjUqkOz5U/0NkM+iy1M+K7517/r9J9EjuX5PezEr
         vG0MnadiHZI0wo+AxWtJ8GOxwBcr2FSBTz2rB+9kIIN/JoUtpjLClHYn7rchIR2h1Rko
         zT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590109; x=1795194909;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJaikHgxJ0Cfj902txSyNLryimhDtp9xIHKHj6RuZzg=;
        b=xz9oBVwz9e9EquvwbmKO4IGe+o3ird43SjeYHVVaTYFFLB88Hbex9EOE3HT+gbZDjq
         gQQO+vIQEL5i/gX/Pz67Nhpo5cNJ6Q0M36WiqdilUPRnkuakssv0bk6m4RYVFRoBkp81
         dpGWDXLxrXprUV+2k5hNXJWdEaPc50n5BER9GSMnnJMZAoPKx2EJvt7hmLG0dJULJtvf
         jxwtZTxe3+SLjZQ0KYuv00qOLC4aV4c1cXqNoG1kuEDx9p/aW6UwBXMTR0UZ0vNVjgrd
         lB4qUo3J+DJF/pnFGmzZ2BYjalSvBqSZRE9/L/4qO6n8lBKpr38bqvfDHE2He4X++STP
         ZjSg==
X-Forwarded-Encrypted: i=1; AL+hErGnxy6jDOcYkLTtW43ZmYkiT0tX/dp4H5Vk0tLocvafLvnlVGX/OuLFHbwLDsPABpZ7QekjzDxewx+/k9pErKwE1jY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YxE5uGXzHDpmcD/VD4RJ+/Ve6fQAAwj245ef8cqS+1Y0S8ZtN
	rpGvB7kaTOf+NW3p8KfgzNtQkV5MvewwVh/THOFPpbczDddIp251xtta
X-Gm-Gg: AYBFou2eSS+1PUD+50ysFp4PIkKNUuqegnwqoIi7bPiiYcExXlXXdW4H/YLM4OdR9z2
	DxFUxfXpvX4DUHYSMeWgYMv55CC7iBneWJRPudaR/nPXnsukADFbrSj4nkUJYgMExhLfINRVR4y
	HyO8R4ir2k+PWtr7wbG0SSJUgV70mScGbOcIeVsVGFu9NAkorjzZjlCMZ3rEiEqdI3xW1VMvuMA
	ur+hrZ4a6vNet0Euu5pAh0cwUsktT93+C2cKDKIKspOmRz2kv90G4oQgYdlDNDwiKDJs3mPJHmE
	eU92zP6kQPGiiI40RQLStZUjkMLkMJDrLq3H4zJZE5T4gNd3JD0QFBk/DWAY+OgXR8eyRRyvyL6
	jE26qp/lMOMNeeYAqq3bh66nexj5poBMCz0M1lT634KGefdqPfeqM8jrP12BbK6mS4BWwNMahHH
	Vm1q290VC6LmGcojMjWE1TP47WQQ/Rqhk4u/m2bobjGxLdU4r26W8t73EIIS8JDg1foHXbhlDwL
	kWS7exNQIBNABCxbb76gwhUe5d8wsOtVaLWgAPr+M+mHYnfGULdzANabWCrQsGwHCJEfuc=
X-Received: by 2002:a05:7022:b886:b0:1b3:b67e:9fcf with SMTP id a92af1059eb24-1b5030f29damr2891641c88.17.1794590108316;
        Fri, 13 Nov 2026 09:15:08 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm8468380c88.12.2026.11.13.09.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:15:08 -0800 (PST)
Message-ID: <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com>
Date: Fri, 13 Nov 2026 22:45:03 +0530
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
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com> <avAsy43KVO-7Nm9z@antec>
Content-Language: en-US
In-Reply-To: <avAsy43KVO-7Nm9z@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 1:33 PM, Stafford Horne wrote:
> On Tue, Oct 27, 2026 at 01:42:39AM +0530, Sahil Siddiq wrote:
>> Tests already exist lib/tests to verify the generic functionality of
>> KProbes. Add unit tests to verify that KProbes work on instructions
>> that require simulation in the OpenRISC ISA, and that the corresponding
>> delay slots are handled correctly.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>> ---
>> Changes v2 -> v3:
>> - arch/openrisc/kernel/tests/test_kprobes_asm.S:
>>    - (test_kprobes_*): Set value in r11 register to 0 prior to running tests
>>    - (test_kprobes_adrp):
>>      Place function at page-aligned address
>>      Use PAGE_SIZE macro instead of magic number
>>      Move value in r13 to r11 before exiting
>>
>> Changes v1 -> v2: New commit
>>
>>   arch/openrisc/Kconfig.debug                   |  30 +++-
>>   arch/openrisc/kernel/Makefile                 |   1 +
>>   arch/openrisc/kernel/tests/Makefile           |   3 +
>>   arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++++++
>>   arch/openrisc/kernel/tests/test_kprobes.h     |  24 +++
>>   arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 ++++++++++++++++++
>>   6 files changed, 273 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/openrisc/kernel/tests/Makefile
>>   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
>>   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
>>   create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S
>>
>> [...]
>> diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openrisc/kernel/tests/test_kprobes_asm.S
>> new file mode 100644
>> index 000000000000..bc87a5fb00d5
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
>> @@ -0,0 +1,157 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * KProbes unit tests for OpenRISC
>> + *
>> + * Unit tests borrowed liberally from similar work of RISC-V. All
>> + * original copyrights apply as per the original source declaration.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm.h>
>> +#include <asm/page.h>
>> +
>> +#include "test_kprobes.h"
>> +
>> +SYM_FUNC_START(test_kprobes_j)
>> +test_kprobes_j_addr1:
>> +	l.addi	r11,r0,0
>> +	l.j	2f
>> +	l.nop
> 
> Just a tiny comment here about indenting the delay slots.

Got it, I'll indent this.

> You could also use the delayslots here, for example:
> 
> 	l.j	2f
> 	 l.addi	r11,r0,0

I initially thought of that too. But then I thought by keeping l.addi
before l.j, I would also be able to test this for the case when
there are no delay slots. I can reshuffle the instructions if that
test isn't required. Please let me know what your thoughts are.

>> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
>> +	l.addi	r11,r13,0
>> +	l.jr	r9
>> +	l.nop
>> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
>> +test_kprobes_j_addr2:
>> +	l.j	1b
>> +	l.nop
>> +SYM_FUNC_END(test_kprobes_j)
>> [...]
>> -- 
>> 2.55.0
>>

Regards,
Sahil
