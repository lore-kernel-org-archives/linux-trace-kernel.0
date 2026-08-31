Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317842FCDB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183041; cv=none; b=qvTVySKXETLWtnsvxHjxQLjQQ92WYyhKdlAGGXftC6ZN3Xx8TNRjqRYnsK8wbDiin+QshAEWBgYCV8q0+pcqPDOrPYcyLWYbgpUyM3ig6FLDtJiCpyKe+lLxRhOTs9kk7mZjSGfYBq5FY1tId9+ol1F02vhMzPQ0vrxbbbwIPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183041; c=relaxed/simple;
	bh=eAs5v0X4DQXO5Yp0nfjTElZLxyJMKOOQvrmCKjejTMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp4uLDXIkqAWrmAF8viP8/vORCiYZYbbOcumeHpCaoVGNPxWaj6fYLdmdLr69oLHPub+Pk0qjmBuk8Y66fSeKAvjTsCUZ1luSFLFfkH3Cg0w7t/JjtV531fFYSCI9eYnP9/izhzm7yir71QoKVWx0o73EXEgISYdoQlR6Km2en0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QoJwjGk1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QoJwjGk1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1677c91969so330764066b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788183038; x=1788787838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bclo5dNXV+6Jy1wwsMfxD1j5QCeC9PLq5D/ZXM1ZV+o=;
        b=QoJwjGk1lJkZUVbaTJ12PYABKBy7QxMBcy39riN/BPMnm9TwZ3W7fhwvSIiUqMUTjQ
         F3ul1vDx99QAH0E1c7niSi9sf4Axf4kLy1EyeRVq6ynJwD+XzbA4tFWCXXp42SrtxMPG
         cnkF5+ftKmIKEsPdz0jaqkj28HTVMTPsYTQTPsKb/ZjoG8I684rCN9Z4YlLdIUX6MhbA
         5c9xE6j0XgI0nph/mpRxPBGbrZLtnFyIVmKdqMrKi1xM5sCxvWXE7H3H1b1Z+Pa7FvCj
         2Roh0gkWAWMlXcWyzC9BzGVYtefXxYbDDZPkplTe9Vmg2RPyaUe31hPtcTTRYd5rQQWe
         Eh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183038; x=1788787838;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bclo5dNXV+6Jy1wwsMfxD1j5QCeC9PLq5D/ZXM1ZV+o=;
        b=UqhO8COPj0g6ZIs31QmnFzdznGMf490l3U+Mmw8xlPAjpY8v7U9S70TcJs+/t+ib5W
         BeoWx59FKH04Oc9S3abwNL8LivMpEhhmBjGgtgf8fzrkw98c+vTau4PtDBMPIxAJ6DEL
         aCYDUUDQx7SYDXCcWmaT9OSn4GaWdKT6h/KIo/Eqojn63i9wrxg5hZlrAF+OWYuhT8HJ
         FgJbkAXM6EOk/WYZ2fPF1ww/QsdoRt9JZfwttS213Kt60PAwpCFCw3gbIubK5W/yBCbl
         sSzML9EicA+PWiMSLw493D+BUjguz+OimYtkbnWoY8Y7oJz1QXkS9YTpBzIaK7hvMuKG
         3zpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnCoLAw58K+LLIEuUomZhfY56tJcSvaQFUGd3UXz5H8Kmej/240GI6jhO1RKr6p4omMuUiRXN6q8JOM/YRoklOy2o=@vger.kernel.org
X-Gm-Message-State: AFuF++mHhKucDTV9t0tDjw91LPqSZDXMwxCQlT8Vb+5Et9f/EyP2Y+cX
	qdnGs94eWCpwmqv3hMMTWCuaUfm0pm9m0ESL+9PotwDbBTEaBuM4Qnu7D+zn78ue8x8=
X-Gm-Gg: AR+sD11YAWoci6JaN9vcvTq6yDLNTuMVt7/tcsj0diTcLrU/HVntdm+VYTDOS5XQHlg
	Im2kFlsAo4j+tsayQ+reiDzJtZHF04cSY5QwSNwNwDtCTFs1TTyV2PTtnz1yxWHcFxZk99SpK82
	q7vXAdOXWZt9TsZQXoKsyZu3INdK3wegDEuFqolcqeIeTd7Lf+e/FM2fV4ZY8zmYz1BER2o/VQi
	iKdIrtg4W3SVFcOXsE06IUX9rgNoagnX0IFe1FAfjnb/xlY8gyxDOnDe+gQ64MGy/GN4VmS6hzZ
	Wtv6Ao1ZVStRVCvwYEWW0ZTpz9ggrRLlfz7jThSGccN0Fyhy8g1jGIfjPW+YNoV7tJKySugWPS/
	Tc3a6OGLVxPjocepn2rzxsPsGEPUsGPSsdFkB/klkCvwvMe1l40nfFrEomdzl8D5BIjekm1moNj
	jfs9rFgZQq9kdTfdAMGhX7U32nu/lnfqnZiDhkMIhTLI4onnV1UaEXjvkbX2hovqG5f/zxWwiCT
	4Yc+FL7f06nl45Nv5Onf8zW
X-Received: by 2002:a17:907:3cc2:b0:c1c:5aa1:de57 with SMTP id a640c23a62f3a-c2557030696mr1575327866b.13.1788183038289;
        Mon, 31 Aug 2026 06:30:38 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee0b233sm435317266b.11.2026.08.31.06.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 06:30:37 -0700 (PDT)
Message-ID: <5e6231aa-10b9-4c41-b7ab-dee5e8f64bec@suse.com>
Date: Mon, 31 Aug 2026 15:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>,
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
 <524b5817-c097-47cb-b301-4a9c0f1d2947@suse.com>
 <cee89666-9de0-4012-b665-69da3846c5ef@app.fastmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <cee89666-9de0-4012-b665-69da3846c5ef@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 3:45 PM, Ard Biesheuvel wrote:
> On Fri, 28 Aug 2026, at 15:07, Petr Pavlu wrote:
>> On 8/22/26 3:53 PM, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> The arm64 module loader has to deal with a couple of corner cases that
>>> may occur when .init.text is placed out of direct branch range of .text:
>>>
>>> - ordinary direct branches from .init.text into .text may require the
>>>   use of a PLT entry (i.e., a trampoline aka veneer), which means not
>>>   only that additional PLT entries need to be allocated for
>>>   cross-section calls, but also that .init.text needs its own PLT
>>>   reservation, as the one in .text will be out of range as well;
>>>
>>> - dynamic patching of the ftrace handler into .init.text code needs its
>>>   own dedicated trampoline as the one in .text may be too far away.
>>>
>>> - recent compilers may omit BTI veneers for static functions that never
>>>   have their address taken, and so additional veneers will need to be
>>>   added to .text in case cross-section direct branches from .init.text 
>>>   require a PLT entry (and therefore a landing pad at the target end).
>>>
>>> This is unfortunate, because it is actually somewhat unusual for .text
>>> and .init.text to be so far away from each other: only when allocating
>>> either of them (but not both) exhausts the 'near' (PLT-less) module
>>> region, the other will be allocated from the spillover region, which is
>>> not in direct branching range, and therefore requires PLT entries for
>>> cross-section calls.
>>>
>>> This series addresses this wart by allocating both of them as a single
>>> chunk, and freeing the .init.text part along with the other init
>>> sections at the appropriate time. This ensures that the two regions will
>>> never require veneers for cross-section calls, allowing the arm64 module
>>> loader to be simplified.
>>
>> It looks like this should also be useful for ppc64, which currently
>> merges .init.text and .text because keeping them separate would require
>> stubs between the two, and consequently .init.text is never released in
>> modules on this architecture.
>>
> 
> Thanks for the data point - are those stubs needed when there is some
> distance between the placements of .text and .init.text?

Yes, my understanding is that these stubs are primarily needed because
the BL instruction on ppc64 can only reach a range of +-32 MB.

Another aspect on ppc64 is the use of the Table of Contents (TOC). In
theory, when splitting .text and .init.text, one would also want
separate TOCs, along with stubs to support switching between them.
However, I don't think this is particularly feasible. As far as I can
see, the ABI and GCC don't allow separate TOCs within a single
relocatable object file. In practice, it shouldn't be a large problem to
keep a single TOC, even if some data related only to .init.text remains
present after the module is loaded. Being able to free .init.text is the
important part. On newer Power10 with PCREL, the TOC is not used, so
this issue goes away.

-- 
Cheers,
Petr
