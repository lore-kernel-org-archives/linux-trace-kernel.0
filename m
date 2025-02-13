Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B54212B39;
	Thu, 13 Feb 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442433; cv=none; b=sc/HqCd2m8HE1XfLpPYq68k1CtOpEl/ShHA+SZeznytusFjLmmrumKW8IHxC17hLvxw2b+FKCuXrM4VlAhHHE9XdG3XJnNL012BEJk26i3ogfq7baNoP/KQw5BdJYkP4+RESw6sIgzSKRKVEs36slF97CUtebpm9zXAdYe2PqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442433; c=relaxed/simple;
	bh=nwpqXQVyhO6GZ2xrPHnNPNVjGSMzqD1u8RhtSunxEoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKMZewUqNcMWGE1lEGxI9HzpeldVyTVdS4AS3hrG/nQ2cl2hQrPqXAd7JIzXAJCFOZFXBAZTs/HExdxO07303QmNln7hz/R36zhFR55JijpXZJUUzT+g5bMxAMeHDM9D2gYjzBgvtM7KNW60QHLzzA99M4s9hCFFvszDMT7WrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ir0CARLa; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ir0CARLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ql0eQWr6uOr6mQaaoOLE3DAdGC7Q86+kYpPoXRxyuKU=;
	b=ir0CARLa04boYJzarO7M8NbMp0OhsnIZP2QY9gp1uqD9N1We5802jn+eMQT36a
	n2e5hOqEjdXwIKTOAs011bA/Phq8ekOzNvrXZiA1ScWQERe+JGFYl3hGiCh6FbRM
	EMyGjVvJZdpqsVCZ2b3gpqKfqtxv9LSyAn4ouFl1UksMA=
Received: from [192.168.31.211] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v9KpyK1n9Jd7Lw--.30675S2;
	Thu, 13 Feb 2025 18:25:47 +0800 (CST)
Message-ID: <08422aab-f4a9-4f67-84ef-82ad3663b01f@163.com>
Date: Thu, 13 Feb 2025 18:25:41 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
To: Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Gabriel de Perthuis <g2p.code@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
 <20250207085959.b3e9d922eab33edf885368e3@kernel.org>
 <20250210173016.0ce79bc8@gandalf.local.home>
 <20250211100914.GA29593@noisy.programming.kicks-ass.net>
 <20250211105002.31b5a517@gandalf.local.home>
 <CABCJKudwf11wAbv9NdKh_FN-Z+pLaupMHJxNGtRKK1-1D94hCQ@mail.gmail.com>
 <20250213100836.GC28068@noisy.programming.kicks-ass.net>
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <20250213100836.GC28068@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v9KpyK1n9Jd7Lw--.30675S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4DXFWrCFWDAry8Cr17Jrb_yoW8uFyrpa
	s7CFn7Gan8urZ7twsIy34v9w15tws8C343WryqqryYyrZ29rnYqrs293Wakr9Fqa15Ga42
	gFW8GasIgrn8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIZXrUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYATya2etwwRzcgAAsx



On 2025/2/13 18:08, Peter Zijlstra wrote:
> On Wed, Feb 12, 2025 at 08:52:27AM -0800, Sami Tolvanen wrote:
>> On Tue, Feb 11, 2025 at 7:49 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> On Tue, 11 Feb 2025 11:09:14 +0100
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>>> I was aiming my patch for x86/core, but if there's a reason to expedite
>>>> them, I can stick it in x86/urgent I suppose.
>>>>
>>>> Just need a reason -- what's this compile error nonsense about, my
>>>> kernels build just fine?
>>>
>>> Masami,
>>>
>>> Do you have a config that fails to build without this fix? If so, can you
>>> please reply with it, and then this can go in as a quick fix.
>>
>> x86 builds with both CONFIG_GENDWARFKSYMS and CONFIG_FUNCTION_TRACER
>> are broken without this fix. Here's how to reproduce:
>>
>> $ make defconfig
>> $ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5 -e MODVERSIONS
>> -e GENDWARFKSYMS -e FUNCTION_TRACER
>> $ make olddefconfig && make -j
>> ...
>> In file included from ./arch/x86/include/asm/asm-prototypes.h:2,
>>                   from <stdin>:3:
>> ./arch/x86/include/asm/ftrace.h: In function ‘arch_ftrace_get_symaddr’:
>> ./arch/x86/include/asm/ftrace.h:46:21: error: implicit declaration of
>> function ‘get_kernel_nofault’ [-Wimplicit-function-declaration]
>>     46 |                 if (get_kernel_nofault(instr, (u32
>> *)(fentry_ip - ENDBR_INSN_SIZE)))
>> ...
> 
> It breaks much sooner, complaining about not having dwarf.h.. let me go
> figure out what package provides that :/
> 
> Anyway, thanks, I'll go see if my patch helps here.

It is header file include indirect :-)

https://lore.kernel.org/linux-trace-kernel/20250206131711.ea536f165d5b5980b3909acd@kernel.org/T/#t

File "asm-prototypes.h" is added to entry.S by 'scripts/Makefile.build',
adding the missed declaration header file can also fix the error:

  getasmexports =                                                        \
     { echo "\#include <linux/kernel.h>" ;                               \
       echo "\#include <linux/string.h>" ;                               \
+     echo "\#include <linux/uaccess.h>";                               \
       echo "\#include <asm/asm-prototypes.h>" ;                         \
       $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }




