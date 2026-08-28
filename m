Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155444519A8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922456; cv=none; b=ZDu5kRKOO/vGSwXnzRygiEISiNfa8c/5DE5PmzWR0w5M83jmJMZgFk+7e+qBdmpImXoNz/j/mbOV9vaimVZSvm2kjkTO/D75GH9UL3pzYwX3dgpYZ7q/iXZG74U1vlSpbpb9AbwtMJPJT+OL5623ob2ENUx6G4BGwNwPyZVfXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922456; c=relaxed/simple;
	bh=0cnu+ZMfunp2hV8JKB6qWjNszdBZaWg/W2o4AeU1fl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVi9cSaX1HBaE8M86XNilOhVacdCXonqoaR3tvmjksiymjnkWX5kPIuqdmUq6V+tmEOLIc1/gT2XYzEmf9b0zwy0ZO4PhZiWF9JzQ2d2NE1fsER2lQIhX8ebPVhTypRptRc5N0D2lxjSuWDYg1BghKl2+YJMy7RyuUd01lYoN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oq8lRnX2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oq8lRnX2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so6537325e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787922450; x=1788527250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7aHFohDYwXcOP7zZuVMn7W5BMSpOSC48205QwYsUq4=;
        b=Oq8lRnX24xrol4kS48RpIUhXNtIZv0u/1CARCB/DMkEYS4krwevKzHu6guZTC0uDU8
         M6qXaWJexEAnFNT62OMI1386qqWEX/KPvOiF/S3mE9GF0nVa12ewe/owSdqtY7klQTvf
         TY+W/i1dt+enUV0jiisoItGLVI62o+JcsjW42uSgUlc3bBQTwIQ3y2fNef88mre+YvSU
         6u6Y0mC0xTxpCUuZjh0nH6c4vkgjirY8fG+BdY5hW3zHbbdYqe0hqhpDjCN3E8uo81u0
         Zd5+hRznnEAa4uY7YdVlCKdQzZU5CpD0BvE5FORqIlR3XJfGtcQ8T4Phx4k+iF6c6KiD
         EciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922450; x=1788527250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7aHFohDYwXcOP7zZuVMn7W5BMSpOSC48205QwYsUq4=;
        b=i4bPua9mAIj5b5Czz6JuNjfPsffWwAO24jYZudz+FiXRawHzF9wTs+/5EGQdLWvXCW
         dNDG5BuSIxvdzNeklmP6zT7c9g7eKoouBi/ktlbdrO3BUuRkuIdrA0yk5Vl3Wywh5ajz
         fgZ00OAYkDvyf15qam/UxhI4oi9pWZFhE9w9bFwdnCXq2jFX2WwQMFuo5shmpaJtZ7ap
         Xp48fXRy7sf4Hte6Ww3xmfj8g3pGH7qy3Y99ELu12mPxqEpb1PKkRlw4H3syFrV+PG5Q
         MmCEwkVmew9T3jzS0cisE5Icsc99IIHFRk0AJB0iN4cQ2gd9vf50vEYoKy9b2aSP7pSQ
         83SQ==
X-Forwarded-Encrypted: i=1; AHgh+RpG+kNCJO8LHokmvTtWNJvNsXoXaddlgJpBNhe8j3JKyBP1GHUmOS1WFzKCpgV3I+3H1aV9KRR8Sd1G5zEwmnOhHiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lVd2G1Up6zlRZoHmiiAa3vuJHYnNUmFVHRrNfK0940zewIB30j
	5YgdLh+9oC2AkB8Hd6XtpoHX1lfdTJVt4AtxryUBhhThtlYvzme4qkVqQwXec16n9ag=
X-Gm-Gg: AR+sD11o2oBgZK6nS5J3FGtpLoX2TSUvnoO7grBJlxHynR2Q8rB+urhMemi5g3KmlCo
	T8WORzQZLVwV0k6WmLYK1V0uRQcGh1lHv0SUrIGzX6oTSiu8hcJ6Rlyr5D12u490ixwe0rD4Bxh
	cmJH0zF5sDIWtUQXCtm6+rTmwbVmxyruAGVPSMVSAhJ2cop+6IuTfY5OlivPUGfiPpggNIO/sA2
	v0nUBCH1mEjC8IcSKAFrxD4fP5DCHBdS2OGDPTW/1QAj/SEQ1TYpITfQp8iaitC932Pyuvrz7ZM
	jynkPAliUkdIAUMiF6HOek/gQhGQS05bIGYnUD47Qxngms9+RIrSeHV02iTDyNDvAhgRviB+ATC
	JuEu6s8YEA1I1BUZUs5h3ASXGjpV5TFpXniT9mNvO7ORXLZPLCEWFGt254QYGM6PwtyIPJy7kXY
	YsE5dqCoVBUn+BxfR6tG7pBDQYPmL6hn3DMs3MgJbAzvcrK5aZHxinCFhNXNwEDtHGYE0ejLnVl
	LX4O3HNl4ldIc2zrsI6hi8vJQ==
X-Received: by 2002:a05:600c:8885:b0:49b:909e:922e with SMTP id 5b1f17b1804b1-49b91c4884amr87957605e9.10.1787922450172;
        Fri, 28 Aug 2026 06:07:30 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm56272005e9.9.2026.08.28.06.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 06:07:29 -0700 (PDT)
Message-ID: <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
Date: Fri, 28 Aug 2026 15:07:28 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
To: Ard Biesheuvel <ardb+git@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20260822135323.795946-11-ardb+git@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 3:53 PM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The arm64 module loader has to deal with a couple of corner cases that
> may occur when .init.text is placed out of direct branch range of .text:
> 
> - ordinary direct branches from .init.text into .text may require the
>   use of a PLT entry (i.e., a trampoline aka veneer), which means not
>   only that additional PLT entries need to be allocated for
>   cross-section calls, but also that .init.text needs its own PLT
>   reservation, as the one in .text will be out of range as well;
> 
> - dynamic patching of the ftrace handler into .init.text code needs its
>   own dedicated trampoline as the one in .text may be too far away.
> 
> - recent compilers may omit BTI veneers for static functions that never
>   have their address taken, and so additional veneers will need to be
>   added to .text in case cross-section direct branches from .init.text 
>   require a PLT entry (and therefore a landing pad at the target end).
> 
> This is unfortunate, because it is actually somewhat unusual for .text
> and .init.text to be so far away from each other: only when allocating
> either of them (but not both) exhausts the 'near' (PLT-less) module
> region, the other will be allocated from the spillover region, which is
> not in direct branching range, and therefore requires PLT entries for
> cross-section calls.
> 
> This series addresses this wart by allocating both of them as a single
> chunk, and freeing the .init.text part along with the other init
> sections at the appropriate time. This ensures that the two regions will
> never require veneers for cross-section calls, allowing the arm64 module
> loader to be simplified.

It looks like this should also be useful for ppc64, which currently
merges .init.text and .text because keeping them separate would require
stubs between the two, and consequently .init.text is never released in
modules on this architecture.

-- 
Thanks,
Petr
