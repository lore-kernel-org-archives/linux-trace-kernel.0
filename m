Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAE286A9;
	Thu, 12 Jun 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732412; cv=none; b=aSjn9yrvuWSN0spWwECHG+BlacarKxyDlFL1Hvr/zmQl5XhHTfWmNb8Jb+FJIW5TOnkIGCoQykPTlcjU7icqO+UKwqrCCJ3C1w8iLLZtJvDteKoIEgjEFB1YwHNWdDLiVl9n3DIgAlp0e2mOb8hpXaTbtZU0DKysv7bcEPJwZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732412; c=relaxed/simple;
	bh=2ZQbCbtmHM4QbReq9nM0qKRZOiMuSdWdfPDKCGox5cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ao5jNj6ojDYm5pHHvXusqxy57Ocsr6jaqsg2i1JoxU1VHgTcO7RaIiiIW9Rx8Wo0pMerCYPE8EpMQeQBd3ov8Xi/9WZfgRK6eKDdvzXRy551eXpYupK2NtsoYPG6YQ4Ev66cryRrMvZZbuYeQd6IHaBMikvMVXXAkzyszPDY2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60581432A3;
	Thu, 12 Jun 2025 12:46:39 +0000 (UTC)
Message-ID: <df439eb4-4dbd-4f0f-bfd2-27c6b1534f39@ghiti.fr>
Date: Thu, 12 Jun 2025 14:46:39 +0200
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
 <c239ee1b-f201-4e7b-80f8-03a7fb02b666@ghiti.fr>
 <1338988468.1011577.1749045125350@privateemail.com>
 <191074362.1248877.1749238947947@privateemail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <191074362.1248877.1749238947947@privateemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduhedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepjeeiuedujeeikeevuedtgeeuhfekudeludegveehffefjedugeegudffgfeluefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmehfudgvsgemfhgulegrmegrugduugemiehfhegsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmehfudgvsgemfhgulegrmegrugduugemiehfhegspdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmehfudgvsgemfhgulegrmegrugduugemiehfhegsngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehmrghrtghosehmvggsvghimhdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhop
 ehtvghrrhgvlhhlnhesfhgsrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Marco,

On 6/6/25 21:42, Marco Bonelli wrote:
> I was able to also reproduce without ZSTD (i.e. both ZSTD_COMPRESS=n
> and ZSTD_DECOMPRESS=n) like this:
>
> 	export ARCH=riscv CROSS_COMPILE=riscv32-linux-
> 	make distclean
> 	make defconfig
> 	make 32-bit.config
> 	./scripts/config \
> 		-e FTRACE \
> 		-e CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 		-d RD_ZSTD \
> 		-d SECURITY_APPARMOR_INTROSPECT_POLICY \
> 		-d BTRFS_FS
> 	make olddefconfig
> 	make -j vmlinux
>
> Did another bisect run between v6.14 and v6.15 with the above commands
> in a bash script and got:
>
> 	494e7fe591bf834d57c6607cdc26ab8873708aa7 Merge tag 'bpf_res_spin_lock' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
>
> This leaves me more puzzled than before honestly. Not sure whether it is
> a real bug or a problem on my end at this point? The fact that I can repro
> in a Docker makes me think of the former, but the fact that I was able to
> bisect it down to two different commits depending on ZSTD vs no ZSTD is
> weird.
>
> Alex (or anyone else really): are you able to reproduce with my Dockerfile
> or config I provided in my last mail by any chance?

I'm able to reproduce your issue with your Dockerfile and locally too 
now using your last instructions, with the rv32 toolchain you provided 
and my regular rv64 toolchain (13.1.0).

So, that's weird, let's take the following failure:

ERROR: modpost: vmlinux: local symbol 'riscv_cached_mvendorid' was exported

When attaching with gdb, I get this:

Breakpoint 2, check_export_symbol (sym=0x7fffcfc5aca8, 
secname=0x7ffff7b7e3aa ".debug_str", faddr=72, elf=0x7fffffffdec0, 
mod=0x55555556b2a0) at ../scripts/mod/modpost.c:1087
1087            error("%s: local symbol '%s' was exported\n", mod->name,
1: mod->name = 0x55555556b334 "vmlinux"
2: label_name = 0x7fffdfcd965f "__export_symbol_riscv_cached_mvendorid"
(gdb) p/x sym->st_info
$1 = 0x0
(gdb) p/x *sym
$2 = {st_name = 0x321ded, st_value = 0x3d9111, st_size = 0x0, st_info = 
0x0,
   st_other = 0x0, st_shndx = 0xb6}

where st_info == 0 == STB_LOCAL.

On a working rv64 build with the same configs, I get:

Breakpoint 1, check_export_symbol (sym=0x7fffc56d94a8, 
secname=0x7ffff7ae9e54 ".text", faddr=120, elf=0x7fffffffded0, 
mod=0x55555556b2a0) at ../scripts/mod/modpost.c:1085
1085        if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
(gdb) p/x *sym
$1 = {st_name = 0xe6aa, st_info = 0x12, st_other = 0x0, st_shndx = 0x2,
   st_value = 0x11ba, st_size = 0x2c}

The difference is that the symbol is not in the same section.

I'm still looking into it, just wanted to let you know that I can 
reproduce and hoping someone who knows could jump in :)

Thanks,

Alex


>
> --
> Marco Bonelli
