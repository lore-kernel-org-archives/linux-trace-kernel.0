Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28807273D67;
	Tue, 15 Jul 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569976; cv=none; b=cDvZQBOyqd7+RJKJhvp1GlQ8iK0ja1TI1zKWnqPmuJ/lHQXINOqlYQMW+U0DaRCb2qb9CZWzQanNdyBRSotCsgJE/NlEYC/IIM9sYDOBLPLRpytJo6a+eOlS8QIAcEK8c3z5w07Lz1aTvGJGRhLpaZDCNu3yVHv8oDAAyB8Zyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569976; c=relaxed/simple;
	bh=DyQNjAPJJ8zgqmHLlgf82NXLYI682DSnE5Lg07ezSPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8AE4u5cgIxGlLx7qlLmzP6DBOzzSi5bHpF0vHk6ZEhsz3mineGh3bslFZjE+MvqqgiyD4+HIo8Bwk1IAIiB0a+IcCekPYDadGvd44pM59z3q+wkns3emSfa06VOlqqBtuNfXxhllRkKkyAt8XnHEHVR2CJhLRnMtmoRjcwpAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D02E433B4;
	Tue, 15 Jul 2025 08:59:25 +0000 (UTC)
Message-ID: <6de8a8ed-f932-4b74-a0f7-6a117c36f1af@ghiti.fr>
Date: Tue, 15 Jul 2025 10:59:24 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE
 selection
To: Miao Chen <chenmiao.ku@gmail.com>
Cc: kernel test robot <lkp@intel.com>,
 Linux RISCV <linux-riscv@lists.infradead.org>,
 oe-kbuild-all@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Heiko Carstens <hca@linux.ibm.com>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <aG3A8Jirg+TxNza/@rli9-mobl>
 <f5b1fc77-d180-4df7-b8f6-0cb0ca4a187a@ghiti.fr>
 <CAKxVwge4=cagaVDesKWe0BE88U0YmNn5LLDJvJG=F7EEP2=-LQ@mail.gmail.com>
 <7204f633-5b35-41ce-b847-7dfbaedbac47@ghiti.fr>
 <CAKxVwgdoK6wSt-1LNZ8Tn3MPaETR58RThbcdydijrKPbfpE68g@mail.gmail.com>
 <b6dbdcbc-08b5-4de0-9955-cf2b048dbb38@ghiti.fr>
 <CAKxVwgdMBfzfU04WMOALsi7sqPdj1vsv_kt+ZK=32aWASF1XXw@mail.gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAKxVwgdMBfzfU04WMOALsi7sqPdj1vsv_kt+ZK=32aWASF1XXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepfeeujedtgeekvdehhfduhfegfeeiveehueegheegvdfgjefhteejieduledvfeetnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudeljehfmedufeehtgemjegurghfmegsfhgujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudeljehfmedufeehtgemjegurghfmegsfhgujedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudeljehfmedufeehtgemjegurghfmegsfhgujegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheptghhvghnmhhirghordhkuhesghhmrghilhdrtghomhdprhgtphhtthhopehlkhhpsehin
 hhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi,

On 7/11/25 10:24, Miao Chen wrote:
> Hi,
>
> I rechecked the .config file. I configured it using
>
> make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__ -fmax-errors=unlimited
> -fmax-warnings=unlimited' O=build_dir olddefconfig,
>
> and obtained the following configuration. If NONPORTABLE is disabled,
> the MMU will be enabled. I did not find any other settings that would
> affect the enabling of NONPORTABLE—it is set to 'y' by default.


NONPORTABLE being set does not prevent MMU to be enabled. I see that in 
your config MMU is disabled and then HAVE_DYNAMIC_FTRACE is disabled, I 
don't see anything wrong with this configuration so there is no need to 
try to enable MMU.

This configuration shows that we need to check that HAVE_DYNAMIC_FTRACE 
is set to enable DYNAMIC_FTRACE, otherwise we encounter the build errors 
reported by kernel test robot.

Can you send a v3 with this change?

Also, can you change the patch title and patch log to something like this:

     riscv: Stop supporting static ftrace

     Now that DYNAMIC_FTRACE was introduced, there is no need to support
     static ftrace as it is way less performant. This simplifies the 
code and
     prevents build failures as reported by kernel test robot when
     !DYNAMIC_FTRACE.

Thanks,

Alex


>
>
> --------- CONFIG ---------------------
>
> config NONPORTABLE
> bool "Allow configurations that result in non-portable kernels"
>
> Symbol: HAVE_DYNAMIC_FTRACE [=n]
> Type  : bool
> Defined at kernel/trace/Kconfig:42
> Selected by [n]:
>      - RISCV [=y] && !XIP_KERNEL [=n] && MMU [=n] &&
> (CLANG_SUPPORTS_DYNAMIC_FTRACE [=n] || GCC_SUPPORTS_DYNAMIC_FTRACE
> [=y])
>
> Symbol: MMU [=n]
> Type  : bool
> Defined at arch/riscv/Kconfig:298
> Prompt: MMU-based Paged Memory Management Support
> Location:
>    (1) -> MMU-based Paged Memory Management Support (MMU [=n])
>    Selected by [n]:
>        - PORTABLE [=n]
>
> Symbol: PORTABLE [=n]
>      Type  : bool
>      Defined at arch/riscv/Kconfig:1344
>      Selects: EFI [=n] && MMU [=n] && OF [=y]
>
> Symbol: NONPORTABLE [=y]
>    │ Type  : bool
>    │ Defined at arch/riscv/Kconfig:389
>    │   Prompt: Allow configurations that result in non-portable kernels
>    │   Location:
>    │     -> Platform type
>    │ (1)   -> Allow configurations that result in non-portable kernels
> (NONPORTABLE [=y])
>
> Thanks,
>
> Chen Miao
>
> Alexandre Ghiti <alex@ghiti.fr> 于2025年7月11日周五 15:55写道：
>> Hi,
>>
>> On 7/10/25 17:56, Miao Chen wrote:
>>> Hello Alex,
>>>
>>> I found where the error is, but there's a problem here:
>>>
>>> config PORTABLE
>>>     bool
>>>     default !NONPORTABLE
>>>     select EFI
>>>     select MMU
>>>     select OF
>>>
>>> select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU &&
>>> (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
>>>
>>> Because HAVE_DYNAMIC_FTRACE depends on the MMU—of course, it's
>>> reasonable for DYNAMIC_FTRACE to depend on the MMU—*but since
>>> NONPORTABLE is enabled by default, this causes PORTABLE to default to
>>> n, thereby preventing the MMU from being enabled*. So, should I change
>>> NONPORTABLE to default to n?
>>
>> NONPORTABLE is not enabled by default and PORTABLE=n does not prevent
>> MMU from being enabled.
>>
>> IIUC, it seems like you don't have HAVE_DYNAMIC_FTRACE enabled but
>> that's probably because of your toolchain, not !MMU, can you check that
>> in your .config?
>>
>> Thanks,
>>
>> Alex
>>
>>
>>> Thanks,
>>>
>>> Alex
>>>
>>> Alexandre Ghiti <alex@ghiti.fr> 于2025年7月10日周四 22:33写道：
>>>> On 7/10/25 14:34, Miao Chen wrote:
>>>>> Hello Alex,
>>>>>
>>>>> Sure, I'll checkout it. Btw, this is my first commit, so can u tell
>>>>> how to reproduce failed case? Using the reproduce and .config.gz gived
>>>>> by build-bot?
>>>> Yes exactly!
>>>>
>>>>
>>>>> Thanks,
>>>>>
>>>>> Chen Miao
>>>>>
>>>>> Alexandre Ghiti <alex@ghiti.fr> 于2025年7月10日周四 19:53写道：
>>>>>> Hi ChenMiao,
>>>>>>
>>>>>> On 7/9/25 03:08, kernel test robot wrote:
>>>>>>> Hi ChenMiao,
>>>>>>>
>>>>>>> kernel test robot noticed the following build errors:
>>>>>>>
>>>>>>> [auto build test ERROR on fda589c286040d9ba2d72a0eaf0a13945fc48026]
>>>>>>>
>>>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/ChenMiao/riscv-ftrace-Fix-the-logic-issue-in-DYNAMIC_FTRACE-selection/20250706-231907
>>>>>>> base:   fda589c286040d9ba2d72a0eaf0a13945fc48026
>>>>>>> patch link:    https://lore.kernel.org/r/20250706151830.25091-1-chenmiao.ku%40gmail.com
>>>>>>> patch subject: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE selection
>>>>>>> :::::: branch date: 2 days ago
>>>>>>> :::::: commit date: 2 days ago
>>>>>>> config: riscv-randconfig-r112-20250708 (attached as .config)
>>>>>>> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
>>>>>>> reproduce: (attached as reproduce)
>>>>>>>
>>>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>>>> the same patch/commit), kindly add following tags
>>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202507090650.YGY56SIA-lkp@intel.com/
>>>>>>>
>>>>>>> All errors (new ones prefixed by >>):
>>>>>>>
>>>>>>>>> <instantiation>:1:14: error: operand must be a symbol with %lo/%pcrel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
>>>>>>>        addi sp, sp, -FREGS_SIZE_ON_STACK
>>>>>>>                     ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>>> <instantiation>:2:18: error: unexpected token
>>>>>>>         sw t0, FREGS_EPC(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:3:17: error: unexpected token
>>>>>>>         sw x1, FREGS_RA(sp)
>>>>>>>                        ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:7:17: error: unexpected token
>>>>>>>         sw x6, FREGS_T1(sp)
>>>>>>>                        ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:9:17: error: unexpected token
>>>>>>>         sw x7, FREGS_T2(sp)
>>>>>>>                        ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:10:18: error: unexpected token
>>>>>>>         sw x28, FREGS_T3(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:11:18: error: unexpected token
>>>>>>>         sw x29, FREGS_T4(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:12:18: error: unexpected token
>>>>>>>         sw x30, FREGS_T5(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:13:18: error: unexpected token
>>>>>>>         sw x31, FREGS_T6(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:16:18: error: unexpected token
>>>>>>>         sw x10, FREGS_A0(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:17:18: error: unexpected token
>>>>>>>         sw x11, FREGS_A1(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:18:18: error: unexpected token
>>>>>>>         sw x12, FREGS_A2(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:19:18: error: unexpected token
>>>>>>>         sw x13, FREGS_A3(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:20:18: error: unexpected token
>>>>>>>         sw x14, FREGS_A4(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:21:18: error: unexpected token
>>>>>>>         sw x15, FREGS_A5(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:22:18: error: unexpected token
>>>>>>>         sw x16, FREGS_A6(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:23:18: error: unexpected token
>>>>>>>         sw x17, FREGS_A7(sp)
>>>>>>>                         ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>         ^
>>>>>>>        <instantiation>:25:15: error: operand must be a symbol with %lo/%pcrel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
>>>>>>>         addi a0, a0, FREGS_SIZE_ON_STACK
>>>>>>>                      ^
>>>>>>>        arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>>>>>>>         SAVE_ABI_REGS
>>>>>>>
>>>>>>> Kconfig warnings: (for reference only)
>>>>>>>        WARNING: unmet direct dependencies detected for DYNAMIC_FTRACE
>>>>>>>        Depends on [n]: FTRACE [=y] && FUNCTION_TRACER [=y] && HAVE_DYNAMIC_FTRACE [=n]
>>>>>>>        Selected by [y]:
>>>>>>>        - RISCV [=y] && FUNCTION_TRACER [=y]
>>>>>> To avoid that, we should check HAVE_DYNAMIC_FTRACE too:
>>>>>>
>>>>>> select DYNAMIC_FTRACE if FUNCTION_TRACER && HAVE_DYNAMIC_FTRACE
>>>>>>
>>>>>> That fixes the build error for me. Can you send a v3 with this change?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>
>>>>> _______________________________________________
>>>>> linux-riscv mailing list
>>>>> linux-riscv@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
