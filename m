Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD2155323;
	Tue, 11 Jun 2024 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145055; cv=none; b=DUGI5FfszJoKVJBwiJKr7D5lBFQfMhHnmWr25wN+vyr/6rspi05HVFNrc+RUMEh//+ffHvR8PlnAmMZbmoEROltJEPqiIAk8ZIGzlPn5QIQdeLyZEXwee6ZAHcMXwg7k6WmmeacLHp1A+fra5Ydz+l+sFGR2KzNaABZF8a8kXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145055; c=relaxed/simple;
	bh=v7Eu8b2RCHal5BXVjZ9R+lgux523O4WrZatSWiPWOUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lP2sqpJ6om8z7nDwvB45mcYA7rytK7KNmQLvBLFvFvb9KdlMPl4vrlAA1P4kYXYqxRgkJOhs+tFyvHzmgxSW1OJTOaRJWNhDIvkcAHcbsX4G4v0FbSKCNhVry9ALrXBo1jgPEmT/2UQusOJ4LCXcEGIr2ZdRDazl63n6np5/FZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFW4sFsl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFW4sFsl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7041ed475acso3365159b3a.2;
        Tue, 11 Jun 2024 15:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718145053; x=1718749853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ok2MKULO7j+R803Dv0pCyxD0Tsi34X/FMLE9fjFYjwM=;
        b=XFW4sFslK4ogTo+slAwX4LmXTk5wblJwqvzeClBN3pshDXDj8SzU75YFV5VvlYJR+L
         a3HtPiARaKEbH2zE5CZs1GtdMhiPkf1atSqkMZVT+bXX9zeyluKPO4cqbgMaC7G3XX/t
         7iwlUJ2xN1XISlrGbWfqBtUo7yoWym9xguODq57ABUoaASb8sl64MpCzw4ndlqTcZnvd
         rc2SeuTM+egEpxwbqd3IZ3E2PO6h+nLISY6frTA64kpcGkyX21NXA09aD8Cf3pp9j+Or
         4IdfFaF9itD18onaej5Q4Ey3YKZz5HmgVNKCMbs/F5n8qFggCMdryqCnTxivLpodHIap
         15mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718145053; x=1718749853;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok2MKULO7j+R803Dv0pCyxD0Tsi34X/FMLE9fjFYjwM=;
        b=YGzzoorH4Q7AmYQwLNS4ple2EG7H/X5d9O2gj7fAeg8CXmKPqQLKPfM3u27kmwfri+
         hE763cYYlydX5/SHUPjyIy/bfvCWy62rp/fMC+HzzzlbxoBp9ekBuyiSUHQrl1jl5DgL
         iB1v3pEOI1/MG73VjR56oUSQvoxG1etQttd74Cjwa75xzRg8ESQS+E5vqzP19VWu2nhY
         gEoIK0S++gXuuWKOkHMjamJLT0FigKrSx3wW/bbcsi+FEVkYNbcMBVPDbxVbfAX3fG2J
         PSF+e5rJ0k6E3rTMmXkhNA57rH9s7yoJhvO05qiPX/DZRz94Zb45GGe46usg7ZTcpOCS
         Qz8A==
X-Forwarded-Encrypted: i=1; AJvYcCXlyTa20QiEjvgXh1/VwzaPit1qdhnh4ULOJZdf7dXb7+ZWINDD3kO+T5SEcfmI1c8EyY9Z850xFiNnGJPwZReisyF0PKTG8CfhcnB/5OxphBQTVfI5QolxYzp26vOsaNIStQd1Fcx8NW4FKfw6L+t+velgAhT5myz8kXGBCPWie7No43zD30SSDSl9nOUaadZb
X-Gm-Message-State: AOJu0YzIF7WSSKyqPF7Qa7bMNjypY5swn1RjG41o5tbn8tR74PvVBzwd
	JenqgpUHexPfvwfT0XtB7z/wzo7ly4kboGAoxDJugPOPU4/6K0VU
X-Google-Smtp-Source: AGHT+IHEXBlZ79PKYy8sK1z+vORDpOZz6R2FmnaMQZvoti3CD0lMbv0xS6gtrzUZUzDm9+iySFK2WQ==
X-Received: by 2002:a05:6a20:8402:b0:1b5:8d94:907a with SMTP id adf61e73a8af0-1b8a9b9e15amr308855637.14.1718145053070;
        Tue, 11 Jun 2024 15:30:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042b71ef12sm6050678b3a.44.2024.06.11.15.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 15:30:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c237c185-dbf3-49dc-a849-058d9093570b@roeck-us.net>
Date: Tue, 11 Jun 2024 15:30:50 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] pstore/ramoops: Add ramoops.mem_name= command line
 option
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org,
 Ross Zwisler <zwisler@google.com>, wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
References: <20240611215610.548854415@goodmis.org>
 <20240611215801.605742243@goodmis.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240611215801.605742243@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 14:56, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a method to find a region specified by reserve_mem=nn:align:name for
> ramoops. Adding a kernel command line parameter:
> 
>    reserve_mem=12M:4096:oops ramoops.mem_name=oops
> 
> Will use the size and location defined by the memmap parameter where it
> finds the memory and labels it "oops". The "oops" in the ramoops option
> is used to search for it.
> 
> This allows for arbitrary RAM to be used for ramoops if it is known that
> the memory is not cleared on kernel crashes or soft reboots.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v3: https://lore.kernel.org/linux-trace-kernel/20240606150316.916395285@goodmis.org
> 
> - Change type of start and size to phys_addr_t
> 
>   fs/pstore/ram.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index b1a455f42e93..4311fcbc84f2 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -50,6 +50,10 @@ module_param_hw(mem_address, ullong, other, 0400);
>   MODULE_PARM_DESC(mem_address,
>   		"start of reserved RAM used to store oops/panic logs");
>   
> +static char *mem_name;
> +module_param_named(mem_name, mem_name, charp, 0400);
> +MODULE_PARM_DESC(mem_name, "name of kernel param that holds addr");
> +
>   static ulong mem_size;
>   module_param(mem_size, ulong, 0400);
>   MODULE_PARM_DESC(mem_size,
> @@ -914,6 +918,16 @@ static void __init ramoops_register_dummy(void)
>   {
>   	struct ramoops_platform_data pdata;
>   
> +	if (mem_name) {
> +		phys_addr_t start;
> +		phys_addr_t size;
> +
> +		if (reserve_mem_find_by_name(mem_name, &start, &size)) {
> +			mem_address = start;
> +			mem_size = size;
> +		}
> +	}
> +
>   	/*
>   	 * Prepare a dummy platform data structure to carry the module
>   	 * parameters. If mem_size isn't set, then there are no module

