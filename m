Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CB3F1659
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172975; cv=pass; b=aCudilfpxu88ACdB9x6P2ScmGutDuHnBrs30vz3LBfN1oMhFMqAKvb31g8cUN17/x9KEmL9zjHMT5Y2iYgGEwSGNu8CtjQ2kExXiSImEWDDD0ITBgiQnjWYcx5n292/i0HKycqFA1K1HxLLS8+zxxawvO893Oo1SOy0Slksx1Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172975; c=relaxed/simple;
	bh=yU58Xq2jlsKwRvWVzMF/35DqD9SuerVG6YnTfgrQsdg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ool9P567BMO76ck2XwJJ384V0dE5f0cR0PdtyB0gaahem0LQuGBp4dvorJ9xHcAsGNxYZ+BsJZ1O0KOTWq4tw5yPH+lzVSczbN9YHqdgz+EwBB75UKE/bQmEtdrqyTbzKrITUtRUPGe7xvivDPYVNQwn/j3RcHLXhMUk9GmmmWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+qM3eJX; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+qM3eJX"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso654625241.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 09:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172973; cv=none;
        d=google.com; s=arc-20240605;
        b=aGhaIsj9AJC5cao60v4Rr7MPBE+/Vk6+RPH/2Wn16d38Yr2ZwN6tPOi26vyR1FFX8W
         abDZH2cOcbpeeXcp6SfxzaAnrvEcihB59V6mR+FORNwS7w/fJnpMJWUzLRZrICWNIX6E
         ZwY7EwM4WJIJhC3SXYu6zJ5QflQOg9ndGA2Ss2H3nIA8SX4QPGbaAfd+EGpgbD+y4c9X
         KBPzA7M9Mp0J1f1C0WdYkqRTx2RZ3yk7oud9ge154fSHp76xlK2K2Fzaj5zz6ovaCZPS
         J/Fru2Xp/bb/qFGA/wdDpEh7vc7ezDIaHlYqhDHeDz89XS7sNO4pyW+K1LZ99E0rSv9o
         lA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fxKJNK3JYOXtq/6RpdHSxauIPnnYNnrQjQPiGKEVycA=;
        fh=SEvtRhJ2YkJZbE/j099gh7fCta+P1UWMsIJXvYUb59U=;
        b=TzThNj3yT+0/2skI6dLvEeuj4KhHOZqmtaXISOHIcFPxf7UQ00jfzGpIi1ZTw7hXLV
         zn1H6SvQJ7Ao5cvwOmOQsXyncm+HcuzXiqZFQOKopjQ9B5ST9b2ImUhS3c1KThqTZsCh
         eAM0VwkxbCLzoP3rbojOFPzfdQc7pBDhFxYUbx+tcA1WFWMyOC/euahdbGHqXIonKjmo
         183RW9rQ8eGBnU4xPe13U3pCYlA111PP1e409kcMfInx/lIqs2tSeqcwZz3qelmNUdUd
         z46BAzjEKF0U78zqQvLKc238fMBRVnbU2I2Gk6Fj3R8wC2qvg8gY1EoyJCVdIvHchWcL
         P/8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778172973; x=1778777773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxKJNK3JYOXtq/6RpdHSxauIPnnYNnrQjQPiGKEVycA=;
        b=X+qM3eJXNBkXxwX1JTjGOqY+SYIjD7OSQTTVvvH/d7Nt/MhXpv/9WeJL03HkywvFpu
         lDNyX+dclfgyAnhD+8YhHeNs5NOIBeliQTxtb8XsPAmy168xewtjrqpiDUODMgKv8j4G
         S4MFtygN/7tarwoktBPjP2v4hmJwm/cQhkSRO6F3xWWFtwvysExswW6eESe7LkSwF6ZA
         zTDl6THueBMTmPSkjEHcp50WYWxQefW/LSpbIvVkvqecKpIvnbleFhnWRg4wFwJnVCem
         rwB+sfNX0dtugfmtyQV7/a7IBs7+GPxCDbM5fVrClxK3C8X2tJ9hpm4tNg5S8jMzzLdC
         lIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172973; x=1778777773;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxKJNK3JYOXtq/6RpdHSxauIPnnYNnrQjQPiGKEVycA=;
        b=cNnqFGaPjeKvXhiQaT34B8K0SpLKqld001MDyDl3ZaNyd9EErXS+NkPLxTwYBv/FQu
         jZVsdsRLP/rmfOu6bzOuwBEe3zJp4xi0ScNq7HJsgB6i5qo4Isgoa9rTmmwyB365V4/V
         kuMNi89iegwHoV41R2T/iO4upX7quG64P2PASUAyHvRUPG5G4t5bLl9M5EUItD+EMrLI
         AwsAUZ6AeoRIv4/9077ZoQryaoD88dLgnAPpFtLSmn7TZ0Hzl3pS0NPZf1taDPJF8x47
         W7FflY38bPVm9EoaIwV6IZkZz0dkRRCLjj/3PcBzvpP5zHNm+TyynXfKZDjcRw+SsrZr
         U56Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ooYQSa7P7I4mb4Fe5ASgMR4Pm0WecYlkT4yX0D3z4g9cp00kq15N/KKoRiAgn5ipthY9GrQAKTpCEgLuCpOuI3xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaMpK8PWab4NNnsicoJnbhp34gKltBadJBd0Lx5GLrsPddqhQ
	fBaSpN5XG95pv26YXx74TwzN+vtzHVZ7l52lfgun4Zl78AonXLWayONNDc+rGyajgI5Cfped6kE
	FQBTyhSKDLdpheh2LxUP0wYusDX1o49TzwkQCXOzs
X-Gm-Gg: AeBDieseBRAVAB7Jg47stLI2nFukBeEIaYa5bMNT04Ns/JHRGkLDhRYohfyb14S06nn
	KmA9SovDuyPjyUhSaU3mhylDmraHpO6ZqYpJyp8qcUs9Y+tToMrKLa/mbpdMwDn1hF/aKk5PvSk
	948BRScG0XzVyt8LfLcmEuhkzV8bHLBpMLoe4TGM6LLv4Kh3bIehepFciAullnLxzpLxYPaKZAg
	/NRMzGq6gY7Jw8Ul/WQC8shiLTJYpu51tHtSY6BwWCwKUdGqilvSRAQX00ktAiAvVg3ckVv5rsx
	G/NMhDoiJujov4g88RDsbAkp6pEI46AVDkwZSvc82Rg+suLgnkbGMHwg5FplU4wj6pzE3y4HjH/
	LVPF6
X-Received: by 2002:a05:6102:3f52:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-630f8e78530mr5085650137.3.1778172972306; Thu, 07 May 2026
 09:56:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 09:56:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 09:56:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <n5ce32wumzeiqqyqutom4apy2kqfetbvusc6j4k2xarsska5mw@klp5bmy7qhfm>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
 <20260428-gmem-inplace-conversion-v5-10-d8608ccfca22@google.com> <n5ce32wumzeiqqyqutom4apy2kqfetbvusc6j4k2xarsska5mw@klp5bmy7qhfm>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 May 2026 09:56:11 -0700
X-Gm-Features: AVHnY4IiEmQejwyUzKbSGtsBzFH7WMpl699YC0dogi8imsP9-pFhPzVdvXeVDZc
Message-ID: <CAEvNRgF9+Gr7UVEq-E2SQEb_XOQQMOXy9F_A2tA=DbNV_fJ0EQ@mail.gmail.com>
Subject: Re: [PATCH RFC v5 10/53] KVM: guest_memfd: Add basic support for KVM_SET_MEMORY_ATTRIBUTES2
To: "Liam R. Howlett" <liam@infradead.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Liam R. Howlett" <liam@infradead.org> writes:

> On 26/04/28 04:25PM, Ackerley Tng via B4 Relay wrote:
>>
>> [...snip...]
>>
>> +/*
>> + * Preallocate memory for attributes to be stored on a maple tree, pointed to
>> + * by mas.  Adjacent ranges with attributes identical to the new attributes
>> + * will be merged.  Also sets mas's bounds up for storing attributes.
>> + *
>> + * This maintains the invariant that ranges with the same attributes will
>> + * always be merged.
>> + */
>> +static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
>> +				    pgoff_t start, size_t nr_pages)
>> +{
>> +	pgoff_t end = start + nr_pages;
>> +	pgoff_t last = end - 1;
>> +	void *entry;
>> +
>> +	/* Try extending range. entry is NULL on overflow/wrap-around. */
>> +	mas_set_range(mas, end, end);
>> +	entry = mas_find(mas, end);

Thank you for your reviews!

>
> Please read the documentation as I believe you have a bug here.  What
> happens if there is another range stored higher than end + 1?
>

The invariant in this maple tree is that contiguous ranges with the same
attribute are stored as a single range.

The goal of this first part is to get the entry at the index just after
the requested range, and see what the attribute there is. If that
attribute is what we're about to set, extend the requested range for
storing to the end of that range.

If there is another range higher than end + 1, with the invariant
maintained, that attribute has to be different than the attribute stored
at end. Hence, we only want to extend this requested range up till end.

> Do you have testing of these functions somewhere?
>

GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4) tests setting
attributes in ranges. If test_page is 2,

1. [0, 4) starts off shared (4 is the number of pages in the guest_memfd)
2. [2, 3) is converted to private
    => so the ranges should now be [0, 2), [2, 3), [3, 4)
3. [2, 3) is converted back to shared
    => so the ranges should now be [0, 4)

I verified this by inserting some trace_printk()s and inspecting manually.

>> +	if (entry && xa_to_value(entry) == attributes)
>> +		last = mas->last;
>> +
>> +	if (start > 0) {
>> +		mas_set_range(mas, start - 1, start - 1);
>> +		entry = mas_find(mas, start - 1);
>> +		if (entry && xa_to_value(entry) == attributes)
>> +			start = mas->index;
>> +	}
>> +
>> +	mas_set_range(mas, start, last);
>> +	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
>> +}
>> +
>>
>> [...snip...]
>>
