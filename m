Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01F39ACC;
	Fri, 28 Mar 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193341; cv=none; b=U1AvU7TbHIiLndlUxF53M3CurXrlhHo0EyQz6XbAS87UTOcJiOGhJMXKo0mzwFad9vFKiQ/ZnCD+aPr8zFvB6LUwq1YOE3f03Ne+nyxkmfmBjqmzQ7ETBC3lkktWgwGrnyKupul9cUCLWrQDd7UTAoBs3xrPvjewoaPu9TFxNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193341; c=relaxed/simple;
	bh=/etE71/id3ceolRXKlzmXm3tnfpln2efZFUL8YBPH0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGVZVE/doBxZoNjTj7DDm/0ZS/8MH0WFOD4qFIGvHnKb1nbOBIiMgzTl4h0fNLtVsiKGGzIjDBXKNPcYi68lPobIdrKWtWAeH65gINR/BuGIVrBdZEZ3Lbs34nyZhoUScwTT6Y26JBF8ccY3oS9vft2k0yO4ZfRZO+qx05xKYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5XrPi+X; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5XrPi+X"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499659e669so2597212e87.3;
        Fri, 28 Mar 2025 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743193337; x=1743798137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wj+8bmV44ertfc1KXsCnlrp/qCwTX9DeMuvBdHVn6I=;
        b=W5XrPi+XbsrsiUV/5LKz8+p7UywMNbE0PpE/GJeHtAOTY2bButPkdqGgvB+ayvIQDU
         4jcJT7M93ljdRGFkaC0EKrNh7clA0Nq/q3ZhLIY7iPykdqPP4sjvzpnQrYRJ4eeDcID9
         z5V10ARbLfDVzu9o4HC/q7yse1TBF/Jucquztuk2CyeEhuGC4zxKEfRjjGI5zkOkKasG
         6R0u5HmjiDoq1EaDZzPgl8U1Rdm8Tc9f07JFvCU/FEK5GfzsLtejXyjshrVh7oPkDLQ1
         x/98CC1t5Q7IGu0VNI6i7hz67vAAiAcpNGBL+rmcpobolrGsO6ysJG1ft88Ho3ee5eBr
         c/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743193337; x=1743798137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wj+8bmV44ertfc1KXsCnlrp/qCwTX9DeMuvBdHVn6I=;
        b=eAFafWxEZCUMtNYtUMK23tmy6tLSb2C8vMxlOIZXW1lJjEDy/+poaHGAPIOYYBfd4r
         rYyWTzRVKahFHPZjFeD+288D4LxqIiGXqfTCeeS0+aEzGBER96ewXjxXVspdPpkLFLMn
         hk91yJsN4ZPH5w06fkjaGamp9NReLnbgIkiScDvkKuw/VFfavwmRg5pD5dh7IzzmmwCQ
         FHnepCjwq290EeSz6iGyuM6JzXpqb7NHA8sS4iy0TzPd4BFig3h2dw4IIj2O3ASM0pMp
         osadqSlvhBIZMB4Kge2vxU3zxSDrIUFwL9G6UV9rwohWUtwn5nSiNjELDYof8nembvM+
         CsSA==
X-Forwarded-Encrypted: i=1; AJvYcCVqK1mkWnl0XoMiA2jxSkcNwDcwSwqL2OBEK3U9MbtuHhEs535EPdun1PzHKvWan2eYy+av+IMBBtplLrKe9R7KO9gL@vger.kernel.org, AJvYcCXTOGvG/cNgGTiOhIVvd9AFJIHt/RgHhUEjRjyEEyld755Y3xONFIXLjfIpc6Eo0vo2ICd1e+ZIR0T9yL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPLjYgTRdKmFJjw8UByXjOEPit5Dm3BBfJW3pYu2eKZ9ms5kb
	bmNDcW2TQamWn0HGarsjApwh2WDnZCHcylZXAJ3P8kGMcIlKgkf+
X-Gm-Gg: ASbGncs0GnGeWrrwBACABqemXBNfBHo4q8IIzN/opCltSbh8Se75A96X6qIz4BbKnzp
	3M9sNMHijKOA2VfKL/l07BQoXhV/ZqUVy55i5q91sP1pTR9rKcbQkMmY8M8UibiM8y5xoBVOyJy
	1PtU0Z1LulR6PPaN5lWTKSVOVcXkH95TcT9TombHOf/XefuLR3DXtfZUceZBcY5i0dW6LWwVAnp
	Vm3H0Bxp8okGvICLfYtpPK3EFb2P1Ik5fJZ2ynQDMqWYrE4MzCCzw56I/RAmq62WXLQONXsWLHu
	MV4Y20EVL63kYdDZ5mOdwEU0Hhf8pIt+97LU+bdg5R78bVbCmFK1ORXmb4bCocNaohAPbFC+c7U
	qKvtuLCLFo7HvPz4BT0xJ3bMA+4rRIQ==
X-Google-Smtp-Source: AGHT+IE4u4FzN8OB5WtN6BsBdAIoYyWb07aOVKhGmzjbmccuBZV4PXNpyJk39F0lyANDcUCWp1u0sg==
X-Received: by 2002:a05:6512:a8c:b0:549:91db:c14b with SMTP id 2adb3069b0e04-54b10dbcc7cmr211591e87.8.1743193336898;
        Fri, 28 Mar 2025 13:22:16 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0957fa73sm411017e87.140.2025.03.28.13.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 13:22:16 -0700 (PDT)
Message-ID: <dfc8ee31-2f81-4895-a11d-413641daf8c0@gmail.com>
Date: Fri, 28 Mar 2025 21:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] riscv: Add runtime constant support
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Pasha Bouzarjomehri <pasha@rivosinc.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
 <20250319-runtime_const_riscv-v10-2-745b31a11d65@rivosinc.com>
 <cc8f3525-20b7-445b-877b-2add28a160a2@gmail.com> <Z-b9xGX7SaPgQq15@ghost>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <Z-b9xGX7SaPgQq15@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/25 20:51, Charlie Jenkins wrote:
> On Fri, Mar 28, 2025 at 04:42:42PM +0100, Klara Modin wrote:
>> Hi,
>>
>> On 3/19/25 19:35, Charlie Jenkins wrote:
>>> Implement the runtime constant infrastructure for riscv. Use this
>>> infrastructure to generate constants to be used by the d_hash()
>>> function.
>>>
>>> This is the riscv variant of commit 94a2bc0f611c ("arm64: add 'runtime
>>> constant' support") and commit e3c92e81711d ("runtime constants: add
>>> x86 architecture support").
>>
>> This patch causes the following build failure for me:
>>
>> fs/dcache.c: Assembler messages:
>> fs/dcache.c:157: Error: attempt to move .org backwards
>> fs/dcache.c:157: Error: attempt to move .org backwards
>> fs/dcache.c:157: Error: attempt to move .org backwards
>> fs/dcache.c:157: Error: attempt to move .org backwards
>> fs/dcache.c:157: Error: attempt to move .org backwards
>> make[3]: *** [scripts/Makefile.build:203: fs/dcache.o] Error 1
> 
> Thank you for the report, this seems like a binutils issue potentially.
> I will look into it. Here is a minimally reproducible example:
> 
> 886 :
> .option push
> .option norvc
> 	nop
> 	nop
> .option pop
> 887 :
> 888 :
> .option push
> .option norvc
> .option arch,+zba
> 	nop
> 	nop
> .option pop
> 889 :
> .org	. - (887b - 886b) + (889b - 888b)
> .org	. - (889b - 888b) + (887b - 886b)
> 
> Removing the ".option arch,+zba" fixes the issue but that shouldn't
> matter...

I tried again with GCC 14.2 and 12.4 (with the same binutils version) 
after Alex's answer and couldn't see the issue with these. I got the 
same result with your example. If I invoke `as` directly it doesn't 
happen either.

The issue might be with GCC 15 then?

Regards,
Klara Modin

> 
> - Charlie
> 
>>
>> The value of CONFIG_RISCV_ISA_ZBKB doesn't seem to have an impact. Reverting
>> the patch on top of next-20250328 resolved the issue for me. I attached the
>> generated fs/dcache.s.
>>
>> Please let me know if there's anything else you need.
>>
>> Regards,
>> Klara Modin
>>
