Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C412B75;
	Tue, 11 Jun 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117903; cv=none; b=hJbWXBfG4bfS+RIFdWwyspCINApRqiCq8R9kf45UAQrCnqOKjHKszJMh8E4SFi5pWQuzExEzy8qAEfmQTXzjL5sr5fiJFg1vK3haGi53MFemTS1D+d1Jbv9p6evCTVuGKOfINm6yNYM3stzujga/Ft0CCOGy3qTxXBsBLcwK/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117903; c=relaxed/simple;
	bh=w0lTTEL9S/t3CRyNcH3ajEkkKrl1z10KCvWum/RVML8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXcILn5wx2VMKU18Ju25V6e8QC8Y0XozF8SKkVIWgBc3mm9yGm4ifU7niD7kTeJcyr5H4QFS3B0CHBbP9NJ5bnVoFMEVDiboqNwZY07sRa02uo3D77wE7xRV46JFdBly+DPVyn4NAZKHjEHWLzSkgd6ikXwLRStrUhKlJjLRPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/dy9Tk7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/dy9Tk7"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6819d785528so3932765a12.3;
        Tue, 11 Jun 2024 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718117901; x=1718722701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=k1Uj1gDVRQBejZBAkMeXGHZ3JqvJXJF5YGLTBips13A=;
        b=V/dy9Tk74XE+sUItyTvaMKrIrWBpDkeI5eSZET1hJSdCjrgXvlEMNHBm/LV47WcCxj
         3bNiFo0iOiDR+rTwCh6liia0uYnaV5WIeZ7lDNbThSrfZt5IXknL78yXOct639PiVAGX
         mNxzzU0RgZDRA82C/yITSQbsTxMpt3C9d+p6XiHm/rKH4Ru2S8Jk1bzR/RHEDCN58wVB
         FsGxNNhf3iLYHuhgnYl/f/jwG+z36VQXlcJKgXQT0QWWuFWgpmZKwE4Qn7tUaDP4CS8u
         B+hMeRl7G2y3bsOofitkB+ikW6JRLwENqUXL9oVEzCkQpyv/ojzuIY3xSVcncCDwOmu6
         +tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718117901; x=1718722701;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Uj1gDVRQBejZBAkMeXGHZ3JqvJXJF5YGLTBips13A=;
        b=K89g+1hS+UXCV4zm7rLaCQXV+R1N9nR94sy/QaF4Pf+Do1GMDaPhdS4I/DQJUqjX3g
         cGqo8sMymKCNYnZZAfKr87Iopwut9i50/jmTAhTulVaRgcGU66vt89XKo+5+xYfX2uQu
         GP5GlERH03jf1RSuKGLN4G8NygTkjElKKGukUadrlOTEpUh0OdxYFdDSjk8C/crJRHOO
         AaMr6DBdtCtxqOuoaHbx1WzO39+g6n7guaC11kd5YgEEHQwGWK3srWqOTYcVdO2swbrW
         U1a8V0o10BJXE2T+tenmVX71QbnwK3CHbWZDc9dpzl+hnPUtGwPtudMLWece0zwjW9vR
         ZkQA==
X-Forwarded-Encrypted: i=1; AJvYcCWo6Jrqq56mPcnvlWKfKJpTs7Npdfx0I/BwV6Orne4DmGtlw/VU9B8ZgoqTstlPMpxN7ZVmvt9/D0bUZQPAiJNW+wkzudb9U7a+n88XG7ayc6o98Qn26KEp69bAgcnCFZIqrDvIxA3v1KqUYWZQdMeOv0lA
X-Gm-Message-State: AOJu0Ywy1G7pgdd3QqQy7mpBH+W0iANGxtRVktO8IPH7t44OhmAe+fSB
	18jZCS9S9RMxx+VsvoNm/KN7voXVoJtSa34GuaIkRwalT9Q/LmEI
X-Google-Smtp-Source: AGHT+IErHOR7AYOZyLOtOaSaquX6vdRRt85BGxCtCHTk59xPsXtVPOHdPwTB19M4+C5urrFh4jaOew==
X-Received: by 2002:a17:90a:cf16:b0:2c2:edc2:6021 with SMTP id 98e67ed59e1d1-2c2edc26151mr7151848a91.11.1718117901001;
        Tue, 11 Jun 2024 07:58:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31ed7133esm2934501a91.8.2024.06.11.07.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 07:58:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9011c405-eaa5-4001-9f36-cb9516c1bf18@roeck-us.net>
Date: Tue, 11 Jun 2024 07:58:17 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Wei Yang <richard.weiyang@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
References: <20240606150143.876469296@goodmis.org>
 <20240606150316.751642266@goodmis.org>
 <20240611144029.h7egl4aif5mjlrwf@master>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240611144029.h7egl4aif5mjlrwf@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 07:40, Wei Yang wrote:
[ ... ]

>> +/* Keep a table to reserve named memory */
>> +#define RESERVE_MEM_MAX_ENTRIES		8
>> +#define RESERVE_MEM_NAME_SIZE		16
>                                          ^
> Suggest to align with previous line.
> 
It _is_ aligned. It just looks unaligned because of the "+"
at the beginning of the patch.

Guenter

