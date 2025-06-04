Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C428F922;
	Wed,  4 Jun 2025 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041103; cv=none; b=tJBBtJQcG7uMEmcpQlKcqBLDFu5tdWxH+KVH6VDZ3I/pGzgV9eACWdx/VnkAVZXFFH3KMCsDxhVPrkGPqJEHn/GxDoKL+cDlLZTyTXFV1GKwDPWfKIJwAmkH2tDuO0AFCwsKp0YFpKrII2hK1q7jDdwOSg575TbbvwsfWbejl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041103; c=relaxed/simple;
	bh=8RrE2NkvATIdxMorjU1REsdBWsFeOBZlNKTl1wu5q4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjsOw44aMHci2f0daGXU6L1aWGxxIb1j/pdaYgIR/1RkWsBz/O/vyGAQUc29GPU0yoCe3XcXp9cFgIlHnuwxoc6hokQhtBEttXAq+ysRkXFqgwYS/CkivMzylbAIxAfn9U2rYr7Mq9dfezbb9nSvaBe6GdAXEr3jMRX50vBUIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B189A439BC;
	Wed,  4 Jun 2025 12:44:54 +0000 (UTC)
Message-ID: <c239ee1b-f201-4e7b-80f8-03a7fb02b666@ghiti.fr>
Date: Wed, 4 Jun 2025 14:44:54 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Broken 32-bit riscv debug build with ZSTD and FTRACE
To: Marco Bonelli <marco@mebeim.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "terrelln@fb.com" <terrelln@fb.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <960240908.630790.1748641210849@privateemail.com>
 <1552795452.650306.1748692371190@privateemail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <1552795452.650306.1748692371190@privateemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeetieeitefghfeuvddvjeeiudehheeiffffgeeviedtleehgeffgfdtveekteehudenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvuddrvdeingdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehmrghrtghosehmvggsvghimhdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtvghrrhgvlhhlnhesfhgsrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepm
 hgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Marco,

On 5/31/25 13:52, Marco Bonelli wrote:
>> Steps to reproduce:
>>
>>      export ARCH=riscv CROSS_COMPILE=riscv32-linux-
>>      make distclean
>>      make defconfig
>>      make 32-bit.config
>>      ./scripts/config \
>>          -e DEBUG_KERNEL \
>>          -e DEBUG_INFO \
>>          -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
>>          -d DEBUG_INFO_NONE \
>>          -d DEBUG_INFO_REDUCED
>>      make olddefconfig
>>      make -j vmlinux
> Sorry, forgot to add "-e FTRACE" to the steps above. Here it is:
>
> 	export ARCH=riscv CROSS_COMPILE=riscv32-linux-
> 	make distclean
> 	make defconfig
> 	make 32-bit.config
> 	./scripts/config \
> 		-e DEBUG_KERNEL \
> 		-e DEBUG_INFO \
> 		-e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 		-d DEBUG_INFO_NONE \
> 		-d DEBUG_INFO_REDUCED \
> 		-e FTRACE
> 	make olddefconfig
> 	make -j vmlinux
>
> Everything else still applies.
>
> --
> Marco Bonelli
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


First, thanks for the report!

I unfortunately cannot reproduce this issue locally, I tried on both 
v6.15 and latest linus master, with gcc 13.1.0 and gcc 14.2.0 . I made 
sure that I have FTRACE, ZSTD_COMPRESS and DEBUG_INFO enabled.

Can you attach your full config?

Thanks,

Alex


