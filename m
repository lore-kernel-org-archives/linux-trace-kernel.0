Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150F3D905D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060527; cv=none; b=McepAPbzEu+rNragV8ZcaKoyO4rg96X34quvnNvKpp66MrBuOZNjPO6CXXIvxxSTAPKuU4Acil8UHhEoPB3MCCXPhpf5nucta/tOPon5I+nCFdlCWoid5Y3amorPKt2gaN8uHxN5FoVriBRq0sFwInz8vX19IXhyZc1M1dE2wPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060527; c=relaxed/simple;
	bh=Hg+SIX19oqvzp1xnbgSAkfk1zUKsaY8M5LRlQAzgZMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtaODWAVMHt5TLf+Z+gYpX6xbTY+EYAQFOXPOdbLkqF77pgZdjH+iq1FLaPTYCitFzejbJBm94pP/buj54RMyws0epDmRYnRw6MYYLIjc+zpauURryd2227ukd/+1GXA8tGUUC7VhQXWorAeVhziH9NbAYdmQyk0N8FfutVxzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZpkzYjla; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZpkzYjla"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0046078so54213015e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778060524; x=1778665324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68kE/kTM+aJeMH8hx0nsLFRRLp7aRIisp/tUk6XMa40=;
        b=ZpkzYjla+xW2dCo8W9lO3ZoWyRq7zfH93XQ9z39hTAJepQMRuMo4wevl03bdU4T0lA
         GmE89cKpwPmDbquzsHsCBj4aPr1VggdaT8cdnkTGcScfsjZzUZad2omkPR3EKTyc1Pmf
         cxDC2OhGyeJixmgywkyRm8/sLlCRxhV3HBxaGc5ycyGEvB+kFE10BsgAw8hRI8ZJH+6y
         Lop/E1GHPb7ZcK3wZE43epW9JPch2oMgKL3XvUwZKA7L3x7e1C5FPrjLiP6w+IijRdEu
         ubXHfIQDHmPg2hnSSSySBUCsf/c2MCnNAk5TyQwfGzCU19H6A79zzFkWTnnlLiuaIiPu
         7z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060524; x=1778665324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68kE/kTM+aJeMH8hx0nsLFRRLp7aRIisp/tUk6XMa40=;
        b=BtqEynEVeUC7VTKH70f9cyBLa7Axji9FJOQdaf178X0zmWUSJL1HY7GdZFra39JiEl
         l1KSyX2h+CKopwvfHL0CGiVhbVZ9X5PrKN50oxGSFtDKitmqoFl0/Uk6ka3CK5AJlVa1
         LiVC7bHqTHIJOig2ZV795KhuX2nc7RE8tzwSExnhJWFdzt60oHXu9FEsmJoGO2G/FTrQ
         ubjkrq4xbscGprYB11x6pAmqfzW6e3iEntKmFqhK3VS5WZy34ReeVDHn9J1Fg/hPWx27
         niq01aAkPSZFW+J2SmfmestCXaE9SYl3d0JddTYWY9t4/J8FwMd7JbP8lNngdLCtUQwS
         Zuuw==
X-Forwarded-Encrypted: i=1; AFNElJ9qGbFFCIXA4X/sEPR2VSmwXv/IhpK2lkvTktZKa+i2GPgtipKZX6Ng6YY/ydY5FSTkCf6UagI1aDd4nhkLia0+ny4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoHtJudjI7WdmKQtXJNGI4jlOC28Vo2qbRsz9BSiCZnx3kp/7
	L5Msz8DGO0MLAvKnEJgTtFGq148BhSGg8jgKEO9I0C344f3bjBJhDlD/5Hc8rrMaMBc=
X-Gm-Gg: AeBDietkgyTiahteoM6+NVAXCovHZ0B2jC1sIsfeJJ5geeAFOtGeW/VOlbGMFETHSpl
	neJw2u8g6Z1wC4OiJ6kMjptStMvhosP85lJc8b3jERriMxYrmPG5MfBwCOda/TDFucoh5vgU2i3
	6aHXAQ6W3yU61vtOj5GRiHJd2FcALLIACbi6+2/AtKgoGMuKEadQPUuklAn35ftmqiA3GoMyRLc
	j2W0IS7A/LAhzn27oJFbh463KsR/dtYtKf7Q9M/JYp0zkmFWC6aZ7ndVZs/a29R/jgAXvZYATSu
	cwyGu4r3uZNPFzNlJVE2tW16oy0XmZLMqPum3PPtAgEN3l8y4/UoOlEX52DuogEeaaXS8jvcGnZ
	8gM5+O/TUraV5wz2O05HLsamN329rWmo1onCOadS2m/wb52Eo0ZMejpnl/79Lus2Cm7VtYoPZap
	QGCsy+C1QMWGRdeHoENGJ+r+6usmoNwKrqaSFTnNtz4e9oxMnyAxHXZqA=
X-Received: by 2002:a05:600c:c094:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48e51f45a0dmr31127285e9.23.1778060523891;
        Wed, 06 May 2026 02:42:03 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53156c95sm15613255e9.33.2026.05.06.02.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:42:02 -0700 (PDT)
Message-ID: <a08d598b-8031-4882-a459-8a38c1e761ed@suse.com>
Date: Wed, 6 May 2026 11:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] module/kallsyms: sort function symbols and use
 binary search
To: Petr Mladek <pmladek@suse.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-modules@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Viktor Malik <vmalik@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>
References: <20260327110005.16499-1-stf_xl@wp.pl>
 <20260327110005.16499-2-stf_xl@wp.pl> <afnhidn7K7dZ_cPh@pathway.suse.cz>
 <28bb0f74-8721-4e53-ad89-87b2a78623b2@suse.com>
 <afsCpoGPasi-kBLb@pathway.suse.cz>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <afsCpoGPasi-kBLb@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/26 10:58 AM, Petr Mladek wrote:
> On Tue 2026-05-05 16:37:56, Petr Pavlu wrote:
>> On 5/5/26 2:24 PM, Petr Mladek wrote:
>>> On Fri 2026-03-27 12:00:05, Stanislaw Gruszka wrote:
>>>> Module symbol lookup via find_kallsyms_symbol() performs a linear scan
>>>> over the entire symtab when resolving an address. The number of symbols
>>>> in module symtabs has grown over the years, largely due to additional
>>>> metadata in non-standard sections, making this lookup very slow.
>>>>
>>>> Improve this by separating function symbols during module load, placing
>>>> them at the beginning of the symtab, sorting them by address, and using
>>>> binary search when resolving addresses in module text.
>>>>
>>>> This also should improve times for linear symbol name lookups, as valid
>>>> function symbols are now located at the beginning of the symtab.
>>>>
>>>> The cost of sorting is small relative to module load time. In repeated
>>>> module load tests [1], depending on .config options, this change
>>>> increases load time between 2% and 4%. With cold caches, the difference
>>>> is not measurable, as memory access latency dominates.
>>>>
>>>> The sorting theoretically could be done in compile time, but much more
>>>> complicated as we would have to simulate kernel addresses resolution
>>>> for symbols, and then correct relocation entries. That would be risky
>>>> if get out of sync.
>>>>
>>>> The improvement can be observed when listing ftrace filter functions.
>>>>
>>>> Before:
>>>>
>>>> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
>>>> 74908
>>>>
>>>> real	0m1.315s
>>>> user	0m0.000s
>>>> sys	0m1.312s
>>>>
>>>> After:
>>>>
>>>> root@nano:~# time cat /sys/kernel/tracing/available_filter_functions | wc -l
>>>> 74911
>>>>
>>>> real	0m0.167s
>>>> user	0m0.004s
>>>> sys	0m0.175s
>>>>
>>>> (there are three more symbols introduced by the patch)
>>>>
>>>> For livepatch modules, the symtab layout is preserved and the existing
>>>> linear search is used. For this case, it should be possible to keep
>>>> the original ELF symtab instead of copying it 1:1, but that is outside
>>>> the scope of this patch.
>>>
>>> What is the exact motivation for the special handling of livepatch modules,
>>> please?
>>>
>>> Honestly, I am always a bit lost in the various symbol tables. It is
>>> possile that I have got something wrong.
>>>
>>> Anyway, my understanding is that there are two aspects which are important
>>> for livepatches:
>>>
>>> 1. Livepatches need to preserve special symbols which are used to
>>>    relocate symbols which were local in the original code, see
>>>    Documentation/livepatch/module-elf-format.rst
>>>
>>>    IMHO, this is why layout_symtab() computes space for all core
>>>    symbols in livepatch modules and copies them in add_kallsyms().
>>>
>>>    The symtab is normally released when the module is loaded.
>>>    But livepatch modules make its own copy of the important
>>>    parts, see copy_module_elf().
>>>
>>>    IMHO, the sorting of function symbols vs other symbols does
>>>    not matter here. I believe that the special relocation
>>>    symbols are not affected by this.
>>
>> I'm not sure if I fully follow the conclusion in this point. My
>> understanding is that .klp.rela sections still refer to their special
>> symbols in the symbol table via Elf_Rela::r_info. If the symbol table is
>> filtered or reordered, these references will end up pointing to
>> incorrect symbols.
> 
> My understanding is that the relocations point to symbols which
> are found via the name of the entry. Let's take an example
> from Documentation/livepatch/module-elf-format.rst:
> 
>      73: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT OS [0xff20] .klp.sym.vmlinux.snprintf,0
> 
> This symbol points to snprintf() function in vmlinux object.
> The address of this function is found via kallsyms, see
> klp_find_object_symbol().
> 
> IMHO, it does not matter if we shuffle this entry in the livepatch
> module because the real address is found via kallsyms().
> 
> Even the ordering of the entries in vmlinux is not important in
> _this particular case_ because the "sympos" is zero "0" in this case.
> It means that "snprintf" symbol name is unique in vmlinux.
> 
> The ordering of the symbols in "vmlinux" becomes important
> if the livepatch needs to access a symbol and there are more
> symbols of the same name. This is what I tried to describe
> below.
> 
> I hope that it makes some sense. As I said, I am not familiar
> with the elf format...

Ah, I misunderstood your original point. I agree that reshuffling the
symbol table in a livepatch module will not cause any issues with
binding .klp.sym.<objname>.<symname>,<sympos> symbol references to their
actual definitions in <objname>.

The problem still exists with the .klp.rela sections. They are regular
RELA sections in the sense that each ELF_R_SYM(Elf_Rela::r_info) value
is an index identifying a symbol in the symbol table. If the module
loader reshuffles or filters the original symbol table in any way, the
indexes in Elf_Rela::r_info would need to be adjusted accordingly.

-- 
Thanks,
Petr
