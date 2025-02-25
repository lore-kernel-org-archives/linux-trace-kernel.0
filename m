Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD71A7044;
	Tue, 25 Feb 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472575; cv=none; b=rZMikxfPUmWg8jnRdfXCIZC1CX87DnJNxk+rz3s99CkiQrpwljMD6A4IBx0g1V6pCpruR4lzcDcL7LZRNFFsG3OHLms1dj6fzwshI9ZqlxGMzO2scp4Kh7RgFOQ0ZA6EmPjNh5yRQpyrl5SV+Zo/tRBUNHYNyBmnMMIUkE/L0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472575; c=relaxed/simple;
	bh=ut+ohpyFjQA9YTJLw4f5nyEpmeEh/c1UwnP5CbBLeAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfDo1Lu/OUoIEtdpM2rHfeUyDZHA2PrC++4JrhTk1uRFRa+CbV/ugXylVeIcBzxjccBqwxi84U7RnMp2wjXtuKxh8Ztd4rwasHGnG+HnXg+QfXER6zz1PQQ4loW+0HQSQNsovfMe/Vbug43X4d14XEVa1zcxA9474bv4kIT2eR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1454944286;
	Tue, 25 Feb 2025 08:36:05 +0000 (UTC)
Message-ID: <b449aacb-f981-4907-af37-1ca5aea83bb4@ghiti.fr>
Date: Tue, 25 Feb 2025 09:36:04 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: tracing: Fix __write_overflow_field in
 ftrace_partial_regs()
To: Charlie Jenkins <charlie@rivosinc.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvrgdtgeemtggvtgdtmeduuddtvgemrgeggegsmegrjeelieemsgekrghfmeeisgekieemfhelrggsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtdegmegtvggttdemuddutdgvmegrgeegsgemrgejleeimegskegrfhemiegskeeimehflegrsgdphhgvlhhopeglkffrggeimedvrgdtgeemtggvtgdtmeduuddtvgemrgeggegsmegrjeelieemsgekrghfmeeisgekieemfhelrggsngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepohhlvghgsehrvgguhhgrthdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 25/02/2025 03:42, Charlie Jenkins wrote:
> The size of &regs->a0 is unknown, causing the error:
>
> ../include/linux/fortify-string.h:571:25: warning: call to
> '__write_overflow_field' declared with attribute warning: detected write
> beyond size of field (1st parameter); maybe use struct_group()?
> [-Wattribute-warning]


I can't reproduce this warning with gcc and llvm, even when setting by 
hand -Wattribute-warning when compiling bpf_trace.c (which is the user 
of ftrace_partial_regs()).

Which toolchain did you use?

Thanks,

Alex


>
> Fix this by wrapping the required registers in pt_regs with
> struct_group() and reference the group when doing the offending
> memcpy().
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/riscv/include/asm/ftrace.h |  2 +-
>   arch/riscv/include/asm/ptrace.h | 18 ++++++++++--------
>   2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..ec6db1162021fbf4fa48fc87e7984266040aa7d9 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -207,7 +207,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>   {
>   	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
>   
> -	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
> +	memcpy(&regs->a_regs, afregs->args, sizeof(afregs->args));
>   	regs->epc = afregs->epc;
>   	regs->ra = afregs->ra;
>   	regs->sp = afregs->sp;
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index b5b0adcc85c18e15c156de11172a5d7f03ada037..2910231977cb71dac3cc42f2dc32590284204057 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -23,14 +23,16 @@ struct pt_regs {
>   	unsigned long t2;
>   	unsigned long s0;
>   	unsigned long s1;
> -	unsigned long a0;
> -	unsigned long a1;
> -	unsigned long a2;
> -	unsigned long a3;
> -	unsigned long a4;
> -	unsigned long a5;
> -	unsigned long a6;
> -	unsigned long a7;
> +	struct_group(a_regs,
> +		unsigned long a0;
> +		unsigned long a1;
> +		unsigned long a2;
> +		unsigned long a3;
> +		unsigned long a4;
> +		unsigned long a5;
> +		unsigned long a6;
> +		unsigned long a7;
> +	);
>   	unsigned long s2;
>   	unsigned long s3;
>   	unsigned long s4;
>
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed
