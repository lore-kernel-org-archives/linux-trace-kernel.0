Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD07198A1D;
	Mon, 17 Jun 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630595; cv=none; b=glyRux7hdZQHhZ/Sh9V00Juow1mfHutLlr2+qItNFN4Hax8LD1pG8DUJ7vzV7ZYiK/5Bw+jlH/FADkKOXG7GyvAKTuMQiuatoHEthOpqz4HvNCbmnXvAuYmu/hgq55Cs02X1jqIgFCXxgfh0q59BgIFVrR08HTphpbygChzC89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630595; c=relaxed/simple;
	bh=Jm5ABuXa1QZ4dDdviCRqejeLxd1ZIb8/SJS6zHgv/UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXs2pArmh1zc68z4kpEScVKkQh0sSnpsDsG9iyEXjFvgxNbuhKPdqZq6ny0IB0h2xGGVwIvwVrmw7ybnu77vwressS5m0LMsCxYIsnKHM/tltgHTpGctTbJTvGmVguBCJ7btbG73WPXC0DB6s7vjW+wc729ZsdocKl9ErJXGR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C1BD2000B;
	Mon, 17 Jun 2024 13:23:04 +0000 (UTC)
Message-ID: <a396c024-f1a8-4636-85ee-e36950a2dca0@ghiti.fr>
Date: Mon, 17 Jun 2024 15:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
To: Conor Dooley <conor.dooley@microchip.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrea Parri <parri.andrea@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
 <20240613-lubricant-breath-061192a9489a@wendy>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240613-lubricant-breath-061192a9489a@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

Sorry for the delay here.

On 13/06/2024 09:48, Conor Dooley wrote:
> On Thu, May 23, 2024 at 01:51:34PM +0200, Alexandre Ghiti wrote:
>> Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
>> converted ftrace_make_nop() to use patch_insn_write() which does not
>> emit any icache flush relying entirely on __ftrace_modify_code() to do
>> that.
>>
>> But we missed that ftrace_make_nop() was called very early directly when
>> converting mcount calls into nops (actually on riscv it converts 2B nops
>> emitted by the compiler into 4B nops).
>>
>> This caused crashes on multiple HW as reported by Conor and Björn since
>> the booting core could have half-patched instructions in its icache
>> which would trigger an illegal instruction trap: fix this by emitting a
>> local flush icache when early patching nops.
>>
>> Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used")
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
>>   arch/riscv/kernel/ftrace.c          | 3 +++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
>> index dd8d07146116..ce79c558a4c8 100644
>> --- a/arch/riscv/include/asm/cacheflush.h
>> +++ b/arch/riscv/include/asm/cacheflush.h
>> @@ -13,6 +13,12 @@ static inline void local_flush_icache_all(void)
>>   	asm volatile ("fence.i" ::: "memory");
>>   }
>>   
>> +static inline void local_flush_icache_range(unsigned long start,
>> +					    unsigned long end)
>> +{
>> +	local_flush_icache_all();
>> +}
>> +
>>   #define PG_dcache_clean PG_arch_1
>>   
>>   static inline void flush_dcache_folio(struct folio *folio)
>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>> index 4f4987a6d83d..32e7c401dfb4 100644
>> --- a/arch/riscv/kernel/ftrace.c
>> +++ b/arch/riscv/kernel/ftrace.c
>> @@ -120,6 +120,9 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>>   	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>>   	mutex_unlock(&text_mutex);
> So, turns out that this patch is not sufficient. I've seen some more
> crashes, seemingly due to initialising nops on this mutex_unlock().
> Palmer suggested moving the if (!mod) ... into the lock, which fixed
> the problem for me.


Ok, it makes sense, I completely missed that. I'll send a fix for that 
shortly so that it can be merged in rc5.

Thanks,

Alex


>
>>   
>> +	if (!mod)
>> +		local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE);
>> +
>>   	return out;
>>   }
>>   
>> -- 
>> 2.39.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
