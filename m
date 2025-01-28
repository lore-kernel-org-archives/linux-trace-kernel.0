Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BE19D083
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jan 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060302; cv=none; b=RmqPeGeDnFUWN6aZNyu1e+yqEDktYLwcwJDtZMsDmCCwEZ40Yqtg0Y3JFTOr2iO8F3VG4wFcwRD97WQTZmNzLWF2aplLInHjlYCEuAY/FhS4AyOFc3vXGPuO6rzTpRVzb7R5fmY+GIxKPcF3Swo8g9ggz/FwBZ2LVVrG32LgbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060302; c=relaxed/simple;
	bh=NagYAn2TrqtC5b5RwfDanYg+3MCbHeG3S0GDa3m3CQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5y9g5LcAu1UOC4mG20AQEmo6jI/w4okDUjpaHF2IKiMiIWeNkanMNmhocB6KDi2+rXFVByojZ+EFtBK9An94HT0brBEhnKAKMcUB+PeGkK3WfwYAeGQ2EexAB6ZCuj2th/edqLjiFtsoYsNvEs8OaAoy2EemQXMrucqPjZ935g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U4paw1zD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U4paw1zD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4362f61757fso57651445e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jan 2025 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738060298; x=1738665098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XyAQrOTcI19ilumWSMw1hLrZQh31wPEOX9kHRV/Kjk=;
        b=U4paw1zD7zZ0EQCavCRc+K4qb1TkN59e/bubDOIcft/E9ttjtgYKhfOvOvV4VAMzuh
         fYhqXIs+Ula0utsFTmsAs/54YNeZKJ+ik4WteQ9mhJUZU3hNJgPzkhscdspu0Ci1gZWw
         qm74QuMeUTn1BKz3sppaNQHaA2kiZi9E1X8CNwUHLB1+wnPUCRGYvXO0lBas438yxvtl
         SuUcoyTZ89rKq0yhAsD9SZy3E8/ic64RHuNJCj5SX8ZKlgYMSDjxXEOu6os5RNd5IYSY
         bmhIHPFNUQCUZozfqk9+mYANoUoO7xn8gQ91h4KTqb2NgcxuHpX0eHNuBXRIunYvWERn
         dJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738060298; x=1738665098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XyAQrOTcI19ilumWSMw1hLrZQh31wPEOX9kHRV/Kjk=;
        b=Auwzs16UuzVNaeukIvR28+OnYiJwbH736d16f1hA2Xc7dpcyn7sH4r+tj3/kW0Ok96
         GhaRY3E7NDm/qrVFh8EDC2TJ2QQJcymA28VwN/yPZcYnrmaPO8pqemvZwZEOexM6egNC
         2bMbR5LExpTIUbOY6Ws/6WdIUwhZw0D+g7MApw0XWkDRw0niqL9JqFsV9TSGFvfi0dDR
         wWTGZsLCbsNr6zR7eWeWriVr0psTlC7Q+3mdT5wp3CK1rtvvXssjFoodOottwZILaC6m
         pFQQ0cJm/CbHGOTkwRgxDW/NfjPtsBhNHZkV49WyQsnNn1pLo84W7OY7HMkWMtdDOIXe
         nNZg==
X-Forwarded-Encrypted: i=1; AJvYcCVqxl4+35hWyyeI8+YxjyssLoEaysiiTz0qKJAL7sM3O5CnJgUywx8Op5Lz0G+qfzAzqfkYlJT/VCke/Ba8yzpjEFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJdaLr87/U9bM5m4qWTexVPxKObgskVQMrFAIWtt9/y4uUoabN
	U5mDVwupYWTgb+IJoFjHYOtcNW6VDwuWW0Kj7F7AHinaRBrOOmrUhpEXWO3n6l0=
X-Gm-Gg: ASbGncvnOVZRUIT8q2GxcumzujsyPBhzqVMH6G96YAq3VhA1/yC7tkAujEhdqhJ/u2D
	ggHbGBLhv8gi2UetkDkl0UVJpwgUSN5Soc9tvLlkxf7cgyj7eNNWp/0otDyDEI0n9rOfbUALbfy
	uviiu1aAiohs5MUY56QieKtLFOSnoyDu/TBlPCpjV/Cq6IaN+kqNRPsSzQ3r8p8x0I1h8sQajGT
	C9oX2lC9n6RVr+r80IFY5eorkZif8C1fPucl9O9N5IFWlJTlr/ED99O8QqorBlQue9WqxO7chqB
	fyw5wCVe4EQg79PtGbU=
X-Google-Smtp-Source: AGHT+IF66ZZk/rhZtGcWoNDXw91fpPKUDEMFBtm8dpseiNoX9eGm2cyqqMp6iJGiup5xykF6TH0wXg==
X-Received: by 2002:a05:6000:1788:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-38bf56633damr43631218f8f.16.1738060298374;
        Tue, 28 Jan 2025 02:31:38 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188d5dsm14110246f8f.55.2025.01.28.02.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 02:31:38 -0800 (PST)
Message-ID: <099b8e0b-2c64-482f-8c22-32afc5b21beb@suse.com>
Date: Tue, 28 Jan 2025 11:31:36 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] module: switch to execmem API for remapping as RW
 and restoring ROX
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Borislav Petkov <bp@alien8.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Gomez <da.gomez@samsung.com>, Daniel Thompson <danielt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Gow <davidgow@google.com>,
 Douglas Anderson <dianders@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 Jason Wessel <jason.wessel@windriver.com>, Jiri Kosina <jikos@kernel.org>,
 Joe Lawrence <joe.lawrence@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>, Rae Moar <rmoar@google.com>,
 Richard Weinberger <richard@nod.at>, Sami Tolvanen
 <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, kgdb-bugreport@lists.sourceforge.net,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org
References: <20250126074733.1384926-1-rppt@kernel.org>
 <20250126074733.1384926-7-rppt@kernel.org>
 <021665c5-b017-415f-ad2b-0131dcc81068@suse.com> <Z5iq2GJKIdlB9APM@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Z5iq2GJKIdlB9APM@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/25 11:00, Mike Rapoport wrote:
> On Mon, Jan 27, 2025 at 01:50:31PM +0100, Petr Pavlu wrote:
>> On 1/26/25 08:47, Mike Rapoport wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> Instead of using writable copy for module text sections, temporarily remap
>>> the memory allocated from execmem's ROX cache as writable and restore its
>>> ROX permissions after the module is formed.
>>>
>>> This will allow removing nasty games with writable copy in alternatives
>>> patching on x86.
>>>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>
>> [...]
>>
>>> +static void module_memory_restore_rox(struct module *mod)
>>> +{
>>> +	for_class_mod_mem_type(type, text) {
>>> +		struct module_memory *mem = &mod->mem[type];
>>> +
>>> +		if (mem->is_rox)
>>> +			execmem_restore_rox(mem->base, mem->size);
>>> +	}
>>> +}
>>> +
>>
>> Can the execmem_restore_rox() call here fail? I realize that there isn't
>> much that the module loader can do if that happens, but should it be
>> perhaps logged as a warning?
> 
> It won't fail at this point. set_memory APIs may fail if they need to split
> a large page and could not allocate a new page table, but here all the
> splits were already done at module_memory_alloc() time.

Ok, thanks for the explanation.

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
