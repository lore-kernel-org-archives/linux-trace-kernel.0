Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032D39ACC;
	Fri, 28 Mar 2025 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193335; cv=none; b=aOhNg4ktA/u7Rn4UnxlVteb8MN98gVNC5XVF8HPgoc0Pc9XgRJj5yqekS53fDnJZFr/hqiG2wYgak473Z1ldUXEfRjfpGqjGzANAxH/6Y4LK0EMY0mS9BIwpDv9glS80SQfCx1y4XjsiPLmXbg4ViOkToTMd4blO1tvVyIE5Ga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193335; c=relaxed/simple;
	bh=ND7DohuVaenABgUhb5kSg8Bbw3R9i3By3sUvRi4i82E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DG0cxGiONqRJHuWT1OqqrteJ1fV9+jbritoePJrtzFi0trU6rkDZK2wEP7FjHPuuJn/f4DeTH42Tc/qRfR5Htl5kBAdEDMWjVLhkgxV/6UAUb+UfR/mzsvjXXEG+s8wT01kQv8sHmTQlebvUt6swdU9xYBkEbZgnDoGggrwhhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP0A1VhB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP0A1VhB"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499d2134e8so2944458e87.0;
        Fri, 28 Mar 2025 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743193332; x=1743798132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kU2L9SzC1ltwQ0K7N9pemKqCwVUvpPE6b7uD8pnOltI=;
        b=LP0A1VhBAfOY2TAJ3umZ4vDNR42gaZt6Tl/xDKHKoYTnfTDKIuTPc+pEAlWRecu5L8
         V+y4wJnCpgHsa74/bARjSTl1/MKgBF6ry9Y7NamKifrcwl59ox1LLEqEiJmZVd3VTv8g
         leQIbEjsf05JM++NzUyogW2SpfoO7yveXHQaq53P9+g/t+oWpjTWOVviSEuydxRt8uWc
         Dg6MfqE2UUTxFQMeZfNzluRaa5HEbvzi1yDlc7BDU30Xv/LZgHdvnamSrqFVAUT7ylBS
         TgH1YI+zekHUGs649ATyapCCUUhqtL9P15r6XbcCSnmsPmI9h5SEMDVuDwLqxUeEiZcf
         HquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743193332; x=1743798132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kU2L9SzC1ltwQ0K7N9pemKqCwVUvpPE6b7uD8pnOltI=;
        b=DNdqfP6i6xBIRmv0rUeIUElG2Uqftx6UStBqTW1gImMj+b+UUljPMrRSipYQSzhQc5
         CQOZXT5x081MfdBwSFD7ldnlsPtZB3kDJtLpZLB2TTy42RJSPidzj96Gj6VU8GWwnO/q
         OhxHl6ORTuoV7mloqE1TlHqmUIieyjGdwgG5U9VCSUHywQNUHvs7yz1kwJRLyJ+e8v4H
         g3Jmkg5sIh1OJXIBQMJaab2sUY7Yu88+XJrpcZQMRzX/2vozSVChdH0o41igtxaekdrq
         LcyirFgITA7i18kRnia5jjmBVKjk1nASqGC7S9ev2A0rnes24pSETaWOl4scRAq+L35j
         Cipw==
X-Forwarded-Encrypted: i=1; AJvYcCVk/2zdCeLobJwnN+hcwtcB8uKVKBUs/7SRVI3rOiPPsIDl3sI4HTriRPJ8gXFQtkArinozmHBuzM4s6eqO/+/eWZto@vger.kernel.org, AJvYcCXAegQtPrqhWOsC1fH97u1EWcTH3/fMa+uJc5s2tel3hxbqnMD3xLVDYWJoj59xLC0wMCHnlg5T8KijBDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgoX3cnlKidHkAbQM1OsOxMmhrVUUwaowWyTsCwNG3g+1o4q0
	G3CFnVQfp1ui7nH+kiEOrOvwh/KS8WSTqraHbqwtmybdqs4z2iIN
X-Gm-Gg: ASbGncvNv2UYC9PsOnrROYgSNeCEVBH501d+Q26HO/Mkl/T4EsCz6vvB7pte1MBRYKo
	FHyB8y9hrtSd9Bt0LXk3P4OlIJ40s8kC4DRUG3ZdN4Um9kUPnCyGUXqRgouConUtP+mWFZs9qL1
	4gwzJjeg50maGPVB8fQlWuzZr2hFLuAWqW9rlF7qc3MQDDW6qNjUQLC7irEC8JLSghEf8gdhTMS
	FAsPBpZ0TNpYGU1F5C6X097xk7a3Svg5q5MfW6PODSbPj2i7i8iWlZNLe4NFrEzSsTUZYNo1Esz
	sHHhMQCv7o1iPyKpFHxuzSpH2C7ZH+MjB6NzTVW25VOnHiFP+yiKb0E6MU21rJwJOVFVfTJS0Fe
	cungwUbRZGDBiXD/K8sBJ921LBwSAyQ==
X-Google-Smtp-Source: AGHT+IHXFGdGrTwAKgRdytcexcERVQeUEpJlIwNp//11OnyIczXwqgBzbTHprdT1/60ZP4XyV9xORw==
X-Received: by 2002:a05:6512:1113:b0:54b:f04:59e8 with SMTP id 2adb3069b0e04-54b10ecb002mr264536e87.23.1743193331176;
        Fri, 28 Mar 2025 13:22:11 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0957fa73sm411017e87.140.2025.03.28.13.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 13:22:10 -0700 (PDT)
Message-ID: <112207cd-6823-44b5-9117-fb68a8b63368@gmail.com>
Date: Fri, 28 Mar 2025 21:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] riscv: Add runtime constant support
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Pasha Bouzarjomehri <pasha@rivosinc.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
 <20250319-runtime_const_riscv-v10-2-745b31a11d65@rivosinc.com>
 <cc8f3525-20b7-445b-877b-2add28a160a2@gmail.com>
 <CAHVXubjq901KYw+aRmYoNYUpCks87TB2QAu2U_fcx7Wmh_+9gg@mail.gmail.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <CAHVXubjq901KYw+aRmYoNYUpCks87TB2QAu2U_fcx7Wmh_+9gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

On 3/28/25 18:35, Alexandre Ghiti wrote:
> Hi Klara,
> 
> On Fri, Mar 28, 2025 at 4:42 PM Klara Modin <klarasmodin@gmail.com> wrote:
>>
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
>>
>> The value of CONFIG_RISCV_ISA_ZBKB doesn't seem to have an impact.
>> Reverting the patch on top of next-20250328 resolved the issue for me. I
>> attached the generated fs/dcache.s.
> 
> Thanks for your report!
> 
> Kernel test robot reported the following issue, do you have the same errors?
> 
>     fs/dcache.c: Assembler messages:
>>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
> --
>>> fs/dcache.c:145: Error: unrecognized opcode `add.uw s1,s1,a5'
>>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
> --
>>> fs/dcache.c:145: Error: unrecognized opcode `add.uw a4,a4,a5'
>>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
> --
>>> fs/dcache.c:145: Error: unrecognized opcode `add.uw s4,s4,a5'
>>> fs/dcache.c:143: Warning: Unrecognized .option directive: arch,+zba
> --
>>> fs/dcache.c:145: Error: unrecognized opcode `add.uw s1,s1,a5'
>>> fs/dcache.c:152: Error: attempt to move .org backwards
>>> fs/dcache.c:152: Error: attempt to move .org backwards
>>> fs/dcache.c:152: Error: attempt to move .org backwards
>>> fs/dcache.c:152: Error: attempt to move .org backwards
> 
>   If so, I sent a fix, don't hesitate to add your Tested-by:
> https://lore.kernel.org/linux-riscv/c0f425ec-6c76-45b2-b1bc-8d9be028a878@rivosinc.com/T/#me1469bfb2e6f69e1422a136014b753a6acaa3bc6

I only saw the attempt to move .org backwards error. I'm using binutils 
2.44 and a GCC 15 snapshot from 2025-03-23 so I don't think the 
toolchain support for zba should be the issue. The fix didn't make any 
difference for me.

However, it seems this could be something in GCC 15 as when I retried 
with GCC 14.2 and 12.4 I could no longer see the issue.

Regards,
Klara Modin

> 
> Thanks,
> 
> Alex
> 
> 
>>
>> Please let me know if there's anything else you need.
>>
>> Regards,
>> Klara Modin
>>
