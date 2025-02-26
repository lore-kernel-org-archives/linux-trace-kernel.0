Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E12222C0;
	Wed, 26 Feb 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580045; cv=none; b=h4Se4kTxV5+43fCyfElhzS4i9ksccIKSmlAh6wuPoqsaf2FPdTc3LWFlSgmPRIvXlnYr9z9+bumCGo3OKL50XmMF1uFKvXgFa5dZ+MdXLqEQ4ZqRgVt4EVXwt2nO4p8WGlEK7zfPT5udO7fSVub5/nkfdupkneQ5t/iTqWKj890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580045; c=relaxed/simple;
	bh=E20gb9sD+thFGdT/sXff/794s9zpyHXdhBKGllLOaCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnwFuDHoOyNTYsycv0+UOftTZtn7mv3NnymYc/4SF6B2bxsH2Vjp682gT0zlkZcXSTEMhpjjc9jjyWs7J/eXAs5OsRRKEdsdDDdfRQtcbLaB5FoFPyAohKm1NzQHMJkVwEtstm6qZtKAN4CUsrzauLvC3a+r4U+X76HaHYDMT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCA8A433C9;
	Wed, 26 Feb 2025 14:27:17 +0000 (UTC)
Message-ID: <83830ab7-e15c-476f-b583-0df8d614f7cf@ghiti.fr>
Date: Wed, 26 Feb 2025 15:27:17 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: ftrace: Add parentheses in macro definitions of
 make_call_t0 and make_call_ra
Content-Language: en-US
To: Juhan Jin <juhan.jin@foxmail.com>, guoren@kernel.org,
 guoren@linux.alibaba.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <tencent_AE90AA59903A628E87E9F80E563DA5BA5508@qq.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <tencent_AE90AA59903A628E87E9F80E563DA5BA5508@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepjhhuhhgrnhdrjhhinhesfhhogihmrghilhdrtghomhdprhgtphhtthhopehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhrvghnsehlihhnuhigrdgrlhhisggrsggrrdgtohhmp
 dhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Juhan,

On 06/02/2025 20:28, Juhan Jin wrote:
> This patch adds parentheses to parameters caller and callee of macros
> make_call_t0 and make_call_ra. Every existing invocation of these two
> macros uses a single variable for each argument, so the absence of the
> parentheses seems okay. However, future invocations might use more
> complex expressions as arguments. For example, a future invocation might
> look like this: make_call_t0(a - b, c, call). Without parentheses in the
> macro definition, the macro invocation expands to:
>
> ...
> unsigned int offset = (unsigned long) c - (unsigned long) a - b;
> ...
>
> which is clearly wrong.
>
> The use of parentheses ensures arguments are correctly evaluated and
> potentially saves future users of make_call_t0 and make_call_ra debugging
> trouble.
>
> Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half")
> Signed-off-by: Juhan Jin <juhan.jin@foxmail.com>
> ---
>   arch/riscv/include/asm/ftrace.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index c4721ce44ca4..2636ee00ccf0 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -92,7 +92,7 @@ struct dyn_arch_ftrace {
>   #define make_call_t0(caller, callee, call)				\
>   do {									\
>   	unsigned int offset =						\
> -		(unsigned long) callee - (unsigned long) caller;	\
> +		(unsigned long) (callee) - (unsigned long) (caller);	\
>   	call[0] = to_auipc_t0(offset);					\
>   	call[1] = to_jalr_t0(offset);					\
>   } while (0)
> @@ -108,7 +108,7 @@ do {									\
>   #define make_call_ra(caller, callee, call)				\
>   do {									\
>   	unsigned int offset =						\
> -		(unsigned long) callee - (unsigned long) caller;	\
> +		(unsigned long) (callee) - (unsigned long) (caller);	\
>   	call[0] = to_auipc_ra(offset);					\
>   	call[1] = to_jalr_ra(offset);					\
>   } while (0)
>
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b


Probably not worth going into fixes since the problem is not around for 
now, but that's still a good catch:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


