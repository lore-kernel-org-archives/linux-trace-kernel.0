Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF4241136
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893015; cv=none; b=MEseL7QUteMqbWuDzFA1pkLk/owXBxX6SxYZi7KLCYr5JaSpprQYhzxCyHbGRARkEYg6FtA4Chw+bJrHWBSEw4MzVRgwP5fDyZLOn9cr2SxLZCoPjVndLMPM7EiqNZOIAHrm09EA+oEK2/QEu7MwJLRd/ba1gwRPIdl16OsRw+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893015; c=relaxed/simple;
	bh=nY0rq5mas9QDGLGuiBxaKLim9Mix5whLIwBPkgEx7rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDxyH4vMG8i7EZU+tqbAfwZ8mjmnGaIh04/T0iJGl75Ec94pg8uHiCvSYS5dj9OrIXyaht+Nc82VPSCJSM9HxwkCn7sZYJ9nTa8raAXy6E1vLikmkaTGqTiNZX4FrZrI339i9fHnV8fIJjsTQNbuRg5EsTu+3sPyvv9pn37VH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lq6Wc3pd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lq6Wc3pd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744893012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhMyX45oy8j7OuPZBUX0GxcKvnTqCUj4i4UmRZNxPfY=;
	b=Lq6Wc3pdUs+OD515yfFw2XXcUNEfBNX3V3Ea4YosJ75XQELTyK6g6APyCXr71MiGZqtUmz
	f+e/Q0EouMnBEXcD3D0bxJNcB3chQNpqbOETW0Z4f7PbrWQSfCi5fSlkONheWWrsZ2GTyO
	JvnWrmKI1gDzIUmbh7XMg8gWfAA+J9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-pMjgVr5iPMe-irhSI6-BlA-1; Thu, 17 Apr 2025 08:30:10 -0400
X-MC-Unique: pMjgVr5iPMe-irhSI6-BlA-1
X-Mimecast-MFC-AGG-ID: pMjgVr5iPMe-irhSI6-BlA_1744893010
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so400492f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 05:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893010; x=1745497810;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhMyX45oy8j7OuPZBUX0GxcKvnTqCUj4i4UmRZNxPfY=;
        b=E1PP5mJdYL55gaIF2P8t5RGNj+JkIhAhlw6RzrxUPLKvQhQLnlilGhwbkZnXTuokwm
         gssymE1u6AJQGzyNn0cZJn/B0ip5bfQ5IJ/+A0IQ93u0V2ATjpeqBx0ASW6prgGos0Vm
         ZQ0ZQBPZ1Sk4GMsOWh/VQekCInh7Pl0kFl74NTTi51U0DuEZtC4sdT7pWUWZVl6U2B/S
         EayE4FZgS7m8u3+N+SRabVBRGmshlqRKtr0Q6BrHpZ2hHj/yCOi8jT5FW3fXUVxP8gXx
         ErOw9FzJIFwZ+X5ci7DbucwJl7+1AibUPRT5hN5iX/LXdLH4RN7KUTGXSShGTvoMe5M8
         hoOw==
X-Gm-Message-State: AOJu0YwAJaRp/09k1sGnibmW1cmoc6m1DYyPrjXgtSjt5zDGfosNBS3C
	LlOYZ8cgYmbbx9VGCRyByxm2OP/4xqrZnHDMsKzm7deXA7PQvWjtfEqqViLXynFb5SnsWaf5Ax/
	ho526/Cmkjga8JA5jgL0351xgmEmB7Jw3wrOyuZpWukWpTT7U16pS/qCfN6k55az8QYcS
X-Gm-Gg: ASbGncsf63qBaN2KfDcJTkukLBeOWuU0SS0xUlsffeYxt5QaWi378tPJybrgGoz+wLI
	h6Dvg2Z/0T4tRjnjTycJjb6II+t1t4vnDbG/pIFTCVTirs6GML1/uImyhbscKERUFPkVvkN76/d
	LXkMie265CVQ4X5iMRygwjXC2whIoYPU+ZkzfrzgCprFQYUFjMBbeA/RWPIREy3YBy0oay86Jrf
	HH2UQZREMMDOSg1HZtPkV/a1AHd5I2Chwtakfz2e7Hkh6WZ7AWHuwn8J/Z15E4l9/SbcFUD1rLD
	fdvKtCiVbWxMx++sSYEvqUzZHWYVaj8=
X-Received: by 2002:a5d:64ae:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-39ee5b10eb7mr5582941f8f.2.1744893009615;
        Thu, 17 Apr 2025 05:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM+EJsa6GxQG1p+PKq+EFBpaq5Cqq9HZNJaYx3ETePAwU12QpiixwVwkoc85pVDuylnTVdww==
X-Received: by 2002:a5d:64ae:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-39ee5b10eb7mr5582912f8f.2.1744893009131;
        Thu, 17 Apr 2025 05:30:09 -0700 (PDT)
Received: from [172.20.10.3] (37-48-9-64.nat.epc.tmcz.cz. [37.48.9.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce3bsm20457233f8f.66.2025.04.17.05.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 05:30:08 -0700 (PDT)
Message-ID: <0a3e442f-339a-44ad-aad8-c21ec342c5a8@redhat.com>
Date: Thu, 17 Apr 2025 14:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc64/ftrace: fix clobbered r15 during livepatching
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-trace-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
References: <20250416191227.201146-1-hbathini@linux.ibm.com>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <20250416191227.201146-1-hbathini@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _1hFeUILkWsxEXM_1837zwJIMCRkueZHYxp91g5NqBI_1744893010
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 21:12, Hari Bathini wrote:
> While r15 is clobbered always with PPC_FTRACE_OUT_OF_LINE, it is
> not restored in livepatch sequence leading to not so obvious fails
> like below:
> 
>   BUG: Unable to handle kernel data access on write at 0xc0000000000f9078
>   Faulting instruction address: 0xc0000000018ff958
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   ...
>   NIP:  c0000000018ff958 LR: c0000000018ff930 CTR: c0000000009c0790
>   REGS: c00000005f2e7790 TRAP: 0300   Tainted: G              K      (6.14.0+)
>   MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2822880b  XER: 20040000
>   CFAR: c0000000008addc0 DAR: c0000000000f9078 DSISR: 0a000000 IRQMASK: 1
>   GPR00: c0000000018f2584 c00000005f2e7a30 c00000000280a900 c000000017ffa488
>   GPR04: 0000000000000008 0000000000000000 c0000000018f24fc 000000000000000d
>   GPR08: fffffffffffe0000 000000000000000d 0000000000000000 0000000000008000
>   GPR12: c0000000009c0790 c000000017ffa480 c00000005f2e7c78 c0000000000f9070
>   GPR16: c00000005f2e7c90 0000000000000000 0000000000000000 0000000000000000
>   GPR20: 0000000000000000 c00000005f3efa80 c00000005f2e7c60 c00000005f2e7c88
>   GPR24: c00000005f2e7c60 0000000000000001 c0000000000f9078 0000000000000000
>   GPR28: 00007fff97960000 c000000017ffa480 0000000000000000 c0000000000f9078
>   ...
>   Call Trace:
>     check_heap_object+0x34/0x390 (unreliable)
>   __mutex_unlock_slowpath.isra.0+0xe4/0x230
>   seq_read_iter+0x430/0xa90
>   proc_reg_read_iter+0xa4/0x200
>   vfs_read+0x41c/0x510
>   ksys_read+0xa4/0x190
>   system_call_exception+0x1d0/0x440
>   system_call_vectored_common+0x15c/0x2ec
> 
> Fix it by restoring r15 always.
> 
> Fixes: eec37961a56a ("powerpc64/ftrace: Move ftrace sequence out of line")
> Reported-by: Viktor Malik <vmalik@redhat.com>
> Closes: https://lore.kernel.org/lkml/1aec4a9a-a30b-43fd-b303-7a351caeccb7@redhat.com
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

After applying the patch, the panic doesn't happen anymore and livepatch
works as expected.

Thanks!

Tested-by: Viktor Malik <vmalik@redhat.com>

> ---
>  arch/powerpc/kernel/trace/ftrace_entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
> index 2c1b24100eca..3565c67fc638 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -212,10 +212,10 @@
>  	bne-	1f
>  
>  	mr	r3, r15
> +1:	mtlr	r3
>  	.if \allregs == 0
>  	REST_GPR(15, r1)
>  	.endif
> -1:	mtlr	r3
>  #endif
>  
>  	/* Restore gprs */

