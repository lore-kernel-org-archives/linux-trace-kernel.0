Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBE13A3E1;
	Tue, 18 Jun 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712171; cv=none; b=Z6AR56NsUDTFYuCysiT2BVWr/jhVR2sib39ML0TL4jiUz9CE0y7ePMH91wV0U+M/tHOkhX6F3yrLhkCALwlKrADwwnxx0aAYQbPFAe++gDxsgfc235D69NVe3EkaB2+QEovO4YrtUTFZUFMdkLO7XrVs7/wDzNs2OfaDkEZhkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712171; c=relaxed/simple;
	bh=cbzF01ahKtAAGn0TxOe2bawlyssofdtkzjYQzurcqGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T7pTJGwugl276ySH+t/NTBxBaAa17cqeWfBTSPtbIjQTEpMiaMaMYaQd7Og88OQNuzbnSrjfGG2xzSxkrRMSTPU4zcLgxlbBZgVoX15kGGEAEWfEm/e9CX+teqwCx0R+bWN432ziAIgVLqGw/noYen7tChlHYTA4KAHqRuTQ3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61AE81C0006;
	Tue, 18 Jun 2024 12:02:37 +0000 (UTC)
Message-ID: <b603c8b5-3100-4ccf-b014-9274f980358d@ghiti.fr>
Date: Tue, 18 Jun 2024 14:02:37 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
To: Conor Dooley <conor.dooley@microchip.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrea Parri <parri.andrea@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 puranjay Mohan <puranjay12@gmail.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
 <20240613-lubricant-breath-061192a9489a@wendy>
 <a396c024-f1a8-4636-85ee-e36950a2dca0@ghiti.fr>
In-Reply-To: <a396c024-f1a8-4636-85ee-e36950a2dca0@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

On 17/06/2024 15:23, Alexandre Ghiti wrote:
> Hi Conor,
>
> Sorry for the delay here.
>
> On 13/06/2024 09:48, Conor Dooley wrote:
>> On Thu, May 23, 2024 at 01:51:34PM +0200, Alexandre Ghiti wrote:
>>> Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
>>> converted ftrace_make_nop() to use patch_insn_write() which does not
>>> emit any icache flush relying entirely on __ftrace_modify_code() to do
>>> that.
>>>
>>> But we missed that ftrace_make_nop() was called very early directly 
>>> when
>>> converting mcount calls into nops (actually on riscv it converts 2B 
>>> nops
>>> emitted by the compiler into 4B nops).
>>>
>>> This caused crashes on multiple HW as reported by Conor and Björn since
>>> the booting core could have half-patched instructions in its icache
>>> which would trigger an illegal instruction trap: fix this by emitting a
>>> local flush icache when early patching nops.
>>>
>>> Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used")
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>   arch/riscv/include/asm/cacheflush.h | 6 ++++++
>>>   arch/riscv/kernel/ftrace.c          | 3 +++
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/cacheflush.h 
>>> b/arch/riscv/include/asm/cacheflush.h
>>> index dd8d07146116..ce79c558a4c8 100644
>>> --- a/arch/riscv/include/asm/cacheflush.h
>>> +++ b/arch/riscv/include/asm/cacheflush.h
>>> @@ -13,6 +13,12 @@ static inline void local_flush_icache_all(void)
>>>       asm volatile ("fence.i" ::: "memory");
>>>   }
>>>   +static inline void local_flush_icache_range(unsigned long start,
>>> +                        unsigned long end)
>>> +{
>>> +    local_flush_icache_all();
>>> +}
>>> +
>>>   #define PG_dcache_clean PG_arch_1
>>>     static inline void flush_dcache_folio(struct folio *folio)
>>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>>> index 4f4987a6d83d..32e7c401dfb4 100644
>>> --- a/arch/riscv/kernel/ftrace.c
>>> +++ b/arch/riscv/kernel/ftrace.c
>>> @@ -120,6 +120,9 @@ int ftrace_init_nop(struct module *mod, struct 
>>> dyn_ftrace *rec)
>>>       out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>>>       mutex_unlock(&text_mutex);
>> So, turns out that this patch is not sufficient. I've seen some more
>> crashes, seemingly due to initialising nops on this mutex_unlock().
>> Palmer suggested moving the if (!mod) ... into the lock, which fixed
>> the problem for me.
>
>
> Ok, it makes sense, I completely missed that. I'll send a fix for that 
> shortly so that it can be merged in rc5.
>
> Thanks,
>
> Alex


So I digged a bit more and I'm afraid that the only way to make sure 
this issue does not happen elsewhere is to flush the icache right after 
the patching. We actually can't wait to batch the icache flush since 
along the way, we may call a function that has just been patched (the 
issue that you encountered here).

I don't know how much it will impact the performance but I guess it will.

Unless someone has a better idea (I added Andy and Puranjay in cc), here 
is the patch that implements this, can you give it a try? Thanks

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 87cbd86576b2..4b95c574fd04 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct 
dyn_ftrace *rec)
         out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
         mutex_unlock(&text_mutex);

-       if (!mod)
-               local_flush_icache_range(rec->ip, rec->ip + 
MCOUNT_INSN_SIZE);
-
         return out;
  }

@@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
         } else {
                 while (atomic_read(&param->cpu_count) <= num_online_cpus())
                         cpu_relax();
-       }

-       local_flush_icache_all();
+               local_flush_icache_all();
+       }

         return 0;
  }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 4007563fb607..ab03732d06c4 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t len)

         memset(waddr, c, len);

+       /*
+        * We could have just patched a function that is about to be
+        * called so make sure we don't execute partially patched
+        * instructions by flushing the icache as soon as possible.
+        */
+       local_flush_icache_range((unsigned long)waddr,
+                                (unsigned long)waddr + len);
+
         patch_unmap(FIX_TEXT_POKE0);

         if (across_pages)
@@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const 
void *insn, size_t len)

         ret = copy_to_kernel_nofault(waddr, insn, len);

+       /*
+        * We could have just patched a function that is about to be
+        * called so make sure we don't execute partially patched
+        * instructions by flushing the icache as soon as possible.
+        */
+       local_flush_icache_range((unsigned long)waddr,
+                                (unsigned long)waddr + len);
+
         patch_unmap(FIX_TEXT_POKE0);

         if (across_pages)
@@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)

         ret = patch_insn_set(tp, c, len);

-       if (!ret)
-               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
-
         return ret;
  }
  NOKPROBE_SYMBOL(patch_text_set_nosync);
@@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns, 
size_t len)

         ret = patch_insn_write(tp, insns, len);

-       if (!ret)
-               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
-
         return ret;
  }
  NOKPROBE_SYMBOL(patch_text_nosync);
@@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
         } else {
                 while (atomic_read(&patch->cpu_count) <= num_online_cpus())
                         cpu_relax();
-       }

-       local_flush_icache_all();
+               local_flush_icache_all();
+       }

         return ret;
  }


>
>
>>
>>>   +    if (!mod)
>>> +        local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE);
>>> +
>>>       return out;
>>>   }
>>>   --
>>> 2.39.2
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
