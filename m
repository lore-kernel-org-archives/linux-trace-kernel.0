Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13510352061;
	Tue, 26 Aug 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216106; cv=none; b=HpGVuf7RSUGshTlm9Y20H/uS5SYzMzGSleY/JzDl6yX+JpGkWBB1v9ppfOMpXfcLfXHNh1txyNyYeIXRUfiRmF4Av46yN99fEv9XCUE2u1A8X3Rfmzp/gahX8vTOJZdT9aA4IpgbESnKL4ZWcW8rdMSwzkLinLK+DOzHiLySDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216106; c=relaxed/simple;
	bh=E4ipHpr8pNgnxzWY7k6+aa5qVF3E++wRzdL05RWYsMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8ImMuNSG22tgmLAxtQ0dHIx/Mo1N0M2s2mutIElOFXw99kvLGZ9RCzgsMUbBg8tbJgF+BOvmw4iMvq2zWr236lmkLS7WbibkzW4+CjIjaopfM0BC2vdGv5UjwVqeYJ3uMykMv4JE8u2ux4NS9ZjfOUp0cLUn7s6BEG61JWTRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id EA234C0116;
	Tue, 26 Aug 2025 13:48:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 0630220011;
	Tue, 26 Aug 2025 13:48:14 +0000 (UTC)
Date: Tue, 26 Aug 2025 09:48:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] ftrace/samples: Fix function size computation
Message-ID: <20250826094830.29df8e62@gandalf.local.home>
In-Reply-To: <aK2I2IGKRwmkQuIR@vova-pc>
References: <aK2I2IGKRwmkQuIR@vova-pc>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0630220011
X-Stat-Signature: 1sukhm3gfsgjqyya5su7mshwpyoq6xxc
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188ZSJlApzxUpGoUKX9eNJ4rZ6Ov4IY9T8=
X-HE-Tag: 1756216094-40363
X-HE-Meta: U2FsdGVkX18xZKTODcEQVYL4mEQn1hzbh6po6THk+OH6jYJAWvmgKge/FFmacYved7ZmQOu1GI5KHaCV7ypBZ3yq72m9hVunf8tfAPPzXJfMd1QYsgIlGQA12S+j7fBtUl2vW/TyNTH7FuSD6R2LW9COacm4G4R/UwvT5H2mvIq3sLABp4mLIJ+t0yJHSCYyzUcwGoffezd92Iabs6B7ayfHfHABeccgSOlYjhI0prRHf40JopTxvxGqq3/pATEAuSRkCBKSECXjSXMYNOASqmpYfMFRGdsuWTFnIdfUMR15SMicSqYscHXxMcxqDPYGznEw9A7Pg0kXRJaFSaR+ODZUOuqyzntn

On Tue, 26 Aug 2025 12:13:44 +0200
Vladimir Riabchun <ferr.lambarginio@gmail.com> wrote:

> In my_tramp1 function ASM_RET instruction was placed below
> .size directive, leading to a wrong function size.

Looking at the Fixes commit, it appears that the .size directive was placed
above the ret instruction ;-)

-- Steve


> 
> Fixes: 9d907f1ae80b ("samples/ftrace: Fix asm function ELF annotations")
> Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
> ---
>  samples/ftrace/ftrace-direct-modify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index cfea7a38befb..da3a9f2091f5 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -75,8 +75,8 @@ asm (
>  	CALL_DEPTH_ACCOUNT
>  "	call my_direct_func1\n"
>  "	leave\n"
> -"	.size		my_tramp1, .-my_tramp1\n"
>  	ASM_RET
> +"	.size		my_tramp1, .-my_tramp1\n"
>  
>  "	.type		my_tramp2, @function\n"
>  "	.globl		my_tramp2\n"

