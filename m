Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8423E226;
	Thu, 10 Jul 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148449; cv=none; b=PvxNrT2hiLOF0bM+o2sjRHSiHGj6T8fXxKCwpeRRUxHpV3sQHuupnHdsstmpssINtIgKpa68tAufjFLI8i24++olB07Qt3axVWXPWkkBxKNtv8EiPHdI8c7KfG8iMhtR7AezJriVUnjuTo3RZ9z8Pw0hfBHmrpP15ZWJ2Fa2wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148449; c=relaxed/simple;
	bh=MVHqixVBLg0H9xE1bSL31ysVRFUE+Oyp0iIqhY4ebuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgIIZOkpZrBR5hqAGNcSjJ3BrPBai2x8iijbosFq5gtqfS9J46IzjtlbVUviJRg3hdQI8xUEzkQHrOLPwvnYntopM+MVopN953pC6cglf9fXAmX4zWkU9ga5Gd8RjOa+w5TB00Cv/kq1bIuo2JZ/tkFeBqABbMe2TynE6WVChqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 670B8449CD;
	Thu, 10 Jul 2025 11:53:54 +0000 (UTC)
Message-ID: <f5b1fc77-d180-4df7-b8f6-0cb0ca4a187a@ghiti.fr>
Date: Thu, 10 Jul 2025 13:53:53 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE
 selection
To: kernel test robot <lkp@intel.com>, ChenMiao <chenmiao.ku@gmail.com>,
 Linux RISCV <linux-riscv@lists.infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Heiko Carstens <hca@linux.ibm.com>, Pu Lehui <pulehui@huawei.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <aG3A8Jirg+TxNza/@rli9-mobl>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <aG3A8Jirg+TxNza/@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepueekjeefieeikeevvefhtddtteevgefgtdffheegieegkeffueeujefhjefftdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemsgeffhdumeejtgeirgemsgehudelmegrfhgstdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemsgeffhdumeejtgeirgemsgehudelmegrfhgstddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemsgeffhdumeejtgeirgemsgehudelmegrfhgstdgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopegthhgvnhhmihgrohdrkhhusehgmhgrihhlrdgtohhmpdhrtghpthhto
 heplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg

Hi ChenMiao,

On 7/9/25 03:08, kernel test robot wrote:
> Hi ChenMiao,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on fda589c286040d9ba2d72a0eaf0a13945fc48026]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/ChenMiao/riscv-ftrace-Fix-the-logic-issue-in-DYNAMIC_FTRACE-selection/20250706-231907
> base:   fda589c286040d9ba2d72a0eaf0a13945fc48026
> patch link:    https://lore.kernel.org/r/20250706151830.25091-1-chenmiao.ku%40gmail.com
> patch subject: [PATCH V2] riscv: ftrace: Fix the logic issue in DYNAMIC_FTRACE selection
> :::::: branch date: 2 days ago
> :::::: commit date: 2 days ago
> config: riscv-randconfig-r112-20250708 (attached as .config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce: (attached as reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507090650.YGY56SIA-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> <instantiation>:1:14: error: operand must be a symbol with %lo/%pcrel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
>     addi sp, sp, -FREGS_SIZE_ON_STACK
>                  ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>>> <instantiation>:2:18: error: unexpected token
>      sw t0, FREGS_EPC(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:3:17: error: unexpected token
>      sw x1, FREGS_RA(sp)
>                     ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:7:17: error: unexpected token
>      sw x6, FREGS_T1(sp)
>                     ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:9:17: error: unexpected token
>      sw x7, FREGS_T2(sp)
>                     ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:10:18: error: unexpected token
>      sw x28, FREGS_T3(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:11:18: error: unexpected token
>      sw x29, FREGS_T4(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:12:18: error: unexpected token
>      sw x30, FREGS_T5(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:13:18: error: unexpected token
>      sw x31, FREGS_T6(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:16:18: error: unexpected token
>      sw x10, FREGS_A0(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:17:18: error: unexpected token
>      sw x11, FREGS_A1(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:18:18: error: unexpected token
>      sw x12, FREGS_A2(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:19:18: error: unexpected token
>      sw x13, FREGS_A3(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:20:18: error: unexpected token
>      sw x14, FREGS_A4(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:21:18: error: unexpected token
>      sw x15, FREGS_A5(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:22:18: error: unexpected token
>      sw x16, FREGS_A6(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:23:18: error: unexpected token
>      sw x17, FREGS_A7(sp)
>                      ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>      ^
>     <instantiation>:25:15: error: operand must be a symbol with %lo/%pcrel_lo/%tprel_lo modifier or an integer in the range [-2048, 2047]
>      addi a0, a0, FREGS_SIZE_ON_STACK
>                   ^
>     arch/riscv/kernel/mcount-dyn.S:185:2: note: while in macro instantiation
>      SAVE_ABI_REGS
>
> Kconfig warnings: (for reference only)
>     WARNING: unmet direct dependencies detected for DYNAMIC_FTRACE
>     Depends on [n]: FTRACE [=y] && FUNCTION_TRACER [=y] && HAVE_DYNAMIC_FTRACE [=n]
>     Selected by [y]:
>     - RISCV [=y] && FUNCTION_TRACER [=y]

To avoid that, we should check HAVE_DYNAMIC_FTRACE too:

select DYNAMIC_FTRACE if FUNCTION_TRACER && HAVE_DYNAMIC_FTRACE

That fixes the build error for me. Can you send a v3 with this change?

Thanks,

Alex


>
