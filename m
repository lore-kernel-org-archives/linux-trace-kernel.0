Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D04B5AE;
	Wed, 23 Oct 2024 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655651; cv=none; b=AFf6TAwNq6vIE92DmM7atuQXY856k2sNq/jHWz5pN3vCdZfMxeohU4KnnkrIYFSAncLx4YnXdzEhAVXtZ3WJocG2MTIMgUc1zXoyt0N+HaoPFxtVED+B7L2rEdZDOqTGyyDHR3SZdV9Oq0/Fn/s9t9OxV2gx/eKTCRycWzqZcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655651; c=relaxed/simple;
	bh=wIYPFd1ECFqYcBpUUBUDNuBZLsQHxVKxItc1oZ/BPq0=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BQpm64UeWzbJS5jdZw3jEwYDrU4IbGoSMzsHmShrQwZLp9vYtvwoj7YkJzBDrEtLTu5lx0MhBOiN1JiLvuHRH57DCI+4alYiP0Tu7IaUPhG0h86oPjz9KcWJ9lKyx1mwLJ0KsTYhvm9KSLqYJtf7NaxefPIFyuoq5//B1SoMcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmedK4xn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmedK4xn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-207115e3056so53486175ad.2;
        Tue, 22 Oct 2024 20:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729655650; x=1730260450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47KfYWZzbJlPbzsig/V/+47dXkCR0XBbErKjie4MZZc=;
        b=NmedK4xnZdw4F8ywKhIy8oVHWE0pZsLepTcMbRKIeWsBErkuRsQUBYhOQe8TXMUPIV
         RF8qA66VSjALzciBzasozoGY8kiWXMMtnEXIAHD/fcyERIxpqdKWbOMHJ53731223rIW
         PDk37AviXtW+wI/5Ss7qx6kPivaVaUuoeM8k14HvO7KYSO1YeVGa2WDSYiUkxeavFDjG
         3mNL46z6n9/0/xVOOrtb2J1gwchclreOgK+05dc/B65Wtxs63c5Bs1WsWyZhQn0yKWx8
         fexq3T/4uD/P4zgqHdxHaejX+7Ymxw65HlBN9XeR2BvOVbcUiSiVczxzWrO3995koTw0
         dU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729655650; x=1730260450;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47KfYWZzbJlPbzsig/V/+47dXkCR0XBbErKjie4MZZc=;
        b=HZmKlPNnV9rcUIqal5J7ScvHuwQ1Ga+5ngQCsx68pZRyJdzfwnU0fBmj7NGAqpWwWj
         Y/m/4shndWVaby5ePXBXGJcrnKzO74sIDJ8+NvMLX3gxTexfu2yxdRM+QxsKnRQwIQsb
         YU+Yd+b7ZWz2Ir8FANL+GLqrpUKneD4/u3MX7sHqVWqzJpjuPjT2h6UdeeJ2NC3J2f6H
         c/Ea1eQUgGzklM8RfMiW0NbOdB+FNjmSXWbWvXmuHyI97ePsVyKc+i5pVKpBNzvKgrjy
         mHrov5TXZ4CA3TyA3MO8MnnkUBtDfcQb6xkDmXCf81uAdCsibIA8yPgMxp8TH4jkhg3E
         IvtA==
X-Forwarded-Encrypted: i=1; AJvYcCUBMSJQNxQwP34WttKl+OvONphgAniUUSAiPk4yAkTiV6ZGT0aUua8gkg+g4M9tH5URp0BZKn1uqqMpUBo=@vger.kernel.org, AJvYcCX5s0Q97TJPmy1SeB+hcyizuFMAuLENdJEixf8o1iZXXF/bh/fOPF/Zf/wlJGpDlNYvQa4ew1o4sRhkkMYh6yMckg2y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5FweIEjvvC2qlFnK4c6ecJ29j8+LXCHMa/si9ilFSul4EygK
	k4+4ndsXA2J173rc7l292552Z55cmlVbsYdGulpskUpHwehOsrLATqrxCg==
X-Google-Smtp-Source: AGHT+IGUdfCfM3QYCu6suXxsF586R6Gdy9CD3PBp1aBTBnfp+rRc4cVRKvMmcFpQ4p0Hgi9KZL3jFQ==
X-Received: by 2002:a17:902:c951:b0:20c:d04a:a53f with SMTP id d9443c01a7336-20fab2dbbf9mr19307115ad.58.1729655649555;
        Tue, 22 Oct 2024 20:54:09 -0700 (PDT)
Received: from [10.1.1.24] (125-238-248-82-fibre.sparkbb.co.nz. [125.238.248.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6408sm49390995ad.37.2024.10.22.20.54.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 20:54:09 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <4ab85330-5a50-bde1-f014-99a8e7cb28cc@gmail.com>
Date: Wed, 23 Oct 2024 16:53:58 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Jean-Michel,

thanks for your patches!

Am 21.10.2024 um 22:44 schrieb Jean-Michel Hautbois:
> The TRACE_IRQFLAGS_SUPPORT requires the architecture to call
> trace_hardirqs_off() when interrupts are disabled and
> trace_hardirqs_on() when they are enabled.
> Add those calls to do_IRQ function.

You will also have to add these calls to the three sites in 
arch/m68k/coldfire/head.S where interrupts are enabled or disabled.

Here:
> ENTRY(system_call)
>         SAVE_ALL_SYS
>         move    #0x2000,%sr             /* enable intrs again */
>         GET_CURRENT(%d2)

and here:
> ret_from_exception:
>         move    #0x2700,%sr             /* disable intrs */
>         btst    #5,%sp@(PT_OFF_SR)      /* check if returning to kernel */
>         jeq     Luser_return            /* if so, skip resched, signals */

and here:
> Lwork_to_do:
>         movel   %a0@(TINFO_FLAGS),%d1   /* get thread_info->flags */
>         move    #0x2000,%sr             /* enable intrs again */
>         btst    #TIF_NEED_RESCHED,%d1
>         jne     reschedule

There's one similar site in arch/m68k/kernel/head.S (ret_from_exception) 
where interrupts are enabled that would need a similar change, if you 
want to enable this for all m68k.

Registers %d0-%d5 and %a0-%a2 are saved on the stack at this point and 
can be clobbered if need be.

Cheers,

	Michael


>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  arch/m68k/Kconfig      | 1 +
>  arch/m68k/kernel/irq.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index cc26df907bfe3c8143a931d259eceabb16af7411..ab3375475721fa63418c40d4ba6ac76679ebc77d 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -39,6 +39,7 @@ config M68K
>  	select OLD_SIGSUSPEND3
>  	select UACCESS_MEMCPY if !MMU
>  	select ZONE_DMA
> +	select TRACE_IRQFLAGS_SUPPORT
>
>  config CPU_BIG_ENDIAN
>  	def_bool y
> diff --git a/arch/m68k/kernel/irq.c b/arch/m68k/kernel/irq.c
> index 9ab4f550342e5de11c528f55781432675ffd66bf..74cf60ebbc4bca51f3caa4046dbd2bdb02355711 100644
> --- a/arch/m68k/kernel/irq.c
> +++ b/arch/m68k/kernel/irq.c
> @@ -21,9 +21,11 @@ asmlinkage void do_IRQ(int irq, struct pt_regs *regs)
>  {
>  	struct pt_regs *oldregs = set_irq_regs(regs);
>
> +	trace_hardirqs_off();
>  	irq_enter();
>  	generic_handle_irq(irq);
>  	irq_exit();
> +	trace_hardirqs_on();
>
>  	set_irq_regs(oldregs);
>  }
>
