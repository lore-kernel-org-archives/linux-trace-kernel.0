Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7A30EF75
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957736; cv=none; b=ECLIqpavrk5xe3EfRL7ng3TCvSVHyksyN9ZtfVlO78crlCbC4BBxt+C7Wr0E15J38SA04rFUeVHW+UXRM0/DwY+wL23MrlykLNam/HS8XIs9DMZ6lDkCNJlLsG5IDUWVYFhNxbZhzfKcpCp8UAj41jAFtOC7RWUADgw/on7NGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957736; c=relaxed/simple;
	bh=zvb6iqVbhzqXquWgalsZpYnNJAtSitR0G0K1P4A+KvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4HslspB+EYw65ixTPRPwMfAD/WxxjlXUz5Zxu09xTU73RyHhMBLtwa2xA/S5IbwazpONJM5IXNCIcMfs1eeVhm/p/pWyQKzjZmxczo9cIV8qECTsLK2/hLdZ9p4klVKVzWid4M9pscRYigomCUJoRIE361jc5Qo/r2Zdl69lKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KilkDUWB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KilkDUWB"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68b73f1a8ebso144950a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779957733; x=1780562533; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqVycrQztzNHkBb79EnfZhgyZd7li/azBuhpH40fhX0=;
        b=KilkDUWB1iUG6xsEMCZmq+Rqo0ggT1uLYgQW/yGtafGNcZXluAz2vH/AqxJ+bWOjCf
         ytDLCbxxaFqLCFi1waE8uFbxsKw6oC17JFpZ6x3iDsqp6Mc5poDXdBFsLtGjnkdbK2K0
         uReL29CbV1EUyBRAK76YifdLhPpaSDwa50oBR8VfJajqpDxbPsEYZleKdoQzTanPKsjf
         IwATFybuftKGxgBAMD3DXWDybrmhFgOLtKhzltfbUqVaoDoEstEh13w3o7Zo9+Pe6UoL
         DcrJe05USM5lblhKZuzY2Cvoj832G9KlhP1hXFFF1xgxcDi8NqIHIQO8O5s6mANhwpgL
         gbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779957733; x=1780562533;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqVycrQztzNHkBb79EnfZhgyZd7li/azBuhpH40fhX0=;
        b=Z0h/rVlKZil4j7lsGrRYVegmspk8hFKTYwq4Eab4E/ol59m0FIbY3o+t3PoNUNv9EL
         z6YM+790m7Ya++MpAB7i9I7hxqmrJ+uE1EsyvnAD+skyudr+bXHHeepNhWddzNs30UGF
         IfVp5osfnmEQrBZbtBGcbHr2Xb8iCVROaoAbB8yecMeR0ynf7eXY9SVogqFY4FFeAhhr
         Kljsmb5somMLaf+iCIvhm+LebaXdvAnZxapHxgyUNjV6pVrdgrmJDXoV9gTJx0ezQXhW
         B1zk3M2HUGQmCuSKIRo5f+Vz7mHvw+L4fw9FzkJLMc8wMG8WtveJGDog7Gk1H6wkoqPa
         Fk5w==
X-Forwarded-Encrypted: i=1; AFNElJ8IYDstKYB5Xk1KoGBSCz90LaAOhQJN98f39/2ktaLe8uJgDCn3CXmXTY7L2+n3hKHvOzFGwvJ560fpqBlIUD7wg+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1Jhw4iGKN79O8u3DRs3SK391ACzw0PtBX5d2IeDtx+KJFVLn
	+Gc0Kr/+/YxsbEvsnQP8Oid6wMGaMMgn4iizNJZ45S2ADyy70w3BHZWICjZnR3KGLtQ=
X-Gm-Gg: Acq92OH47ED7dMPXaNc0bw/CAGdYPpQd9cf5w0axKgbTpylw6DTIIxFd57C0Ympg50H
	wEeriN8MXQ5lcA4iyrumu8GRU513UMM2XdrW4BZKEj0fE1KcAnwh2EwByGTQcEWf9drMuEdud7A
	GZHEXZTIk3VcIqx91/AInx6aX+Riwpv/5ntSjiswO1nzG1iHTxnAr1BRvVIk03IzWw0STfXh2Vy
	ZW6GogtawH5nOYBtabpd2PZwXhYN/HLHWDr4uA+DwVFZfLM+PJHw8Acuq2nSoZwxAWV9InEMJEL
	8dAq6R95Nu50gnFWqC51YHw87nqUxbJtDVXewvDYmTWgftzu88qKlgV85A+xHMewaAEI4E4SQjP
	UQ0TILZjBOz1LdfXFwd/NdsJuMJ2GDDvPdPfJ7kWuHHd4mZv98HbJI3dVd8AnwRGYbmz1ZZjKP1
	zQo23GqZU/tAKJu/f2bvs7Sx8P5ByZJnun
X-Received: by 2002:a05:6402:4348:b0:67b:89f5:26c7 with SMTP id 4fb4d7f45d1cf-6889cc57bd9mr14041876a12.26.1779957732880;
        Thu, 28 May 2026 01:42:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68a6fac081esm1560944a12.8.2026.05.28.01.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2026 01:42:11 -0700 (PDT)
Date: Thu, 28 May 2026 08:42:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com,
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com,
	jack@suse.cz, jackmanb@google.com, jannh@google.com,
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org,
	lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org,
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com,
	pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
	rdunlap@infradead.org, rientjes@google.com, rostedt@goodmis.org,
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
	sunnanyong@huawei.com, surenb@google.com,
	thomas.hellstrom@linux.intel.com, tiwai@suse.de,
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Message-ID: <20260528084211.wsdrvbvxvkddokb5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-12-npache@redhat.com>
 <2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com>
 <20260525121041.2f2508a4f627c338cddd837a@linux-foundation.org>
 <20260526065708.oyyddmt2zgfwu2q7@master>
 <CAA1CXcDXyDhMyiVAb8XbusqMU10JXA8nOUw6b4_2i9H-kV2vwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcDXyDhMyiVAb8XbusqMU10JXA8nOUw6b4_2i9H-kV2vwQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, May 26, 2026 at 06:07:38AM -0600, Nico Pache wrote:
>On Tue, May 26, 2026 at 12:57 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>> On Mon, May 25, 2026 at 12:10:41PM -0700, Andrew Morton wrote:
>> >On Mon, 25 May 2026 08:15:53 -0600 Nico Pache <npache@redhat.com> wrote:
>> >
>> >> Can you please append the following fixup that reverts one of the
>> >> changes requested in V17. The issue with the change is described
>> >> below.
>> >
>> >OK.  fyi, what I received was badly mangled: wordwrapping, tabs messed
>> >up, etc.
>> >
>> >Here's my reconstruction:
>> >
>>
>> Hi, Nico
>>
>> I tried to reply your mail, but found it has some encoding problem, so reply
>> here.
>
>Yeah sorry I didnt properly configure my email client after getting a
>new laptop.
>
>>
>> >
>> >Author: Nico Pache <npache@redhat.com>
>> >Subject: fix potential use-after-free of vma in mthp_collapse()
>> >Date: Mon May 25 07:38:59 2026 -0600
>> >
>> >Between V17 and v18, one reviewer (Wei) brought up that we are not doing
>> >the uffd-armed check until deep in the collapse operation.  While not
>> >functionally incorrect, it can lead to unnecessary work.
>>
>> So we decide to tolerate the behavioral change?
>
>Yes, I believe it is ok for now. Either way we needed to remove the
>potential UAF. It only affects the behavior if mTHP is enabled, so the
>legacy behavior is kept. And the uffd case is limited.
>
>My future work involves further optimizing and cleaning up khugepaged.
>I'll make this part of the goal too. My first thought is to do the
>revalidation at every order (between the locks dropping); but that
>essentially pays the same penalty... I can't think of a clean solution
>at the moment.

One way come into my mind is add a @was_uffd_armed field in collapse_control
and updates it in hugepage_vma_revalidate() when latest vma is retrieved.

Still not elegant enough.

>
>Does that sound ok?
>

Not sure. I can't imagine the impact it would have.

>Cheers,
>-- Nico


-- 
Wei Yang
Help you, Help me
