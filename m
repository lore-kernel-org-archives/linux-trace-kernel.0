Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3393CF4B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149124; cv=none; b=elajwLWhRcls2vrVyMC4bOEGD0fV9HBYM3hvDZK4EzK4OcEBlwpZbMK/q4/04qKVEjP0ZlcXstwknfx82NyIUF1sooldPS5jB6+eFUPwafmkipbT5Ym5TqhEtyIzzANd6TlcJWlfLTAKssyEV1sXqmhPI3te7JcCPxkStcwiuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149124; c=relaxed/simple;
	bh=nbsv/ESIHwJSh7QNZhf5AczCQ2fjogWmJ59hgx6/47g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvlDDHGZCFStJC/AAWolmk4qgHgaLUyAKeiT7rWHhRateAVQoJXJ88Nito4eeCHH/s0NFA3vo3LYi+iIDE9dQtog5Lbyy4KGniX3TILDRRqHbwI7pp7dszzRyvrpO1EIoihKZ/5TCyhRUuYVQwgffBMafIf5YeA9ewKbXxGmY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rt49wDvV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rt49wDvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707149121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/YDhdLXQmNxdWoNzbOTZZc0FZCB0nekr5D8YLQhiDIs=;
	b=Rt49wDvVjfzauyOWyakOdmth96ebgujtjXvVPnKvNrRiLEf/EPoWqW2Rnud2vZ+9VxLH14
	7JQBblzmreH+LguAngqbdOyI0q1+Qi5MBDOSQX52wIFIvJSoHVsJU4O7zHF6T+gWIDhhKS
	3QwLDNZMJR/VIyrwh1FS5qDaoLy6N/c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-xVIvjY0mMpmD3Drt04zfHw-1; Mon, 05 Feb 2024 11:05:20 -0500
X-MC-Unique: xVIvjY0mMpmD3Drt04zfHw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-680b7da38bcso71787016d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149118; x=1707753918;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YDhdLXQmNxdWoNzbOTZZc0FZCB0nekr5D8YLQhiDIs=;
        b=O3b/2b+IrewaLWsXg4PXQ5tQSGxKPmj+gGHo7HFLK2iMCQURACMfg+q6cCXp9Fabb1
         D+9gYYrDY/EksTvnPC+zbCR8Vp8fLCr0U1KQJ0lcVcDcqHq0G/WhGaidzdG0AW3kmFg0
         BeOW/LREAPCTjYoIDF/OznSq18Y6PiNU6wtPlMvcsyNk1oxZ4UmgSacjJddAIrMAJIt7
         3jdV71QUUFOgXk6b68S0J1/W6DZ70HRHJUvBaP3Af3s8QMyWPcoOG+zwSmS2sZK+uk05
         FHeOHJNUZqEa2TgA2hwvE7wrA6b7HsFDI+Fko1LEIO1wAbwMXOZ1r1udOSHHugGOFhNM
         OVfw==
X-Gm-Message-State: AOJu0YyKIf7HC80a7Bk92qjC4koehgBLze9N6K/3OiZdQ3GpQKiGfbOT
	BpIK0SPyJhF2vsi+IqLbDKjasmu7OggXp6AJRfsVcTkMh1GFDndx1YL/C+xMQxOaaLFOfPSAfAf
	26/401CAKJ5mz8ISV3Qr6P8TTWzl18x4P0IBUbepxgeTg3hDF7ruXivHQnrkVcZ52Z0z00A==
X-Received: by 2002:a05:6214:234c:b0:68c:a48b:1837 with SMTP id hu12-20020a056214234c00b0068ca48b1837mr4341665qvb.56.1707149118697;
        Mon, 05 Feb 2024 08:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEK5wyGMRf7y6ljyaUktOKqjtoG7O1AlU4Dzog+BlM4E7VbbrOpKjXLqEv/DTIi2DjcIw0sw==
X-Received: by 2002:a05:6214:234c:b0:68c:a48b:1837 with SMTP id hu12-20020a056214234c00b0068ca48b1837mr4341637qvb.56.1707149118410;
        Mon, 05 Feb 2024 08:05:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYwD3XfR1ZPE9TqWGg3RvY3sNwUSjHOdjGmXJ3/N5P5Ej0vSwBHvh2RUH0bVziZ5Y7T5cgd9ANVYBG5awCOONDk8xfJ1hlvOtHmS+ZlAwPeOYXDjLdeBPc8nv4Fauig/uy4GE5pQgn1ZuM44GvuDZHsHO++anq6ehVIYdL0BjYaZhc1nTgP4c3bXx3Yaq2DmFOBgSbsotNQtxU4+vBFgZfojkQLlZ9lqNyA82da4KSUp803akvbzP9zs495pgDe9743+yiXz7PKNs0T+iMQaNFdm0=
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id y14-20020a0ceace000000b0068c4aabcdb6sm103206qvp.29.2024.02.05.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:05:17 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: richard clark <richard.xnu.clark@gmail.com>, nico@fluxnic.net,
 mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about the ipi_raise filter usage and output
In-Reply-To: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N>
References: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N>
Date: Mon, 05 Feb 2024 17:05:14 +0100
Message-ID: <xhsmhmssehp6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 05/02/24 14:39, Mark Rutland wrote:
> [adding Valentin]
>

Thanks!

> On Mon, Feb 05, 2024 at 08:06:09AM -0500, Steven Rostedt wrote:
>> On Mon, 5 Feb 2024 10:28:57 +0000
>> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> > > I try to write below:
>> > > echo 'target_cpus == 11 && reason == "Function call interrupts"' >
>> > > events/ipi/ipi_raise/filter
>> >
>> > The '=' checks if the target_cpus bitmap *only* contains CPU 11. If the cpumask
>> > contains other CPUs, the filter will skip the call.
>> >
>> > I believe you can use '&' to check whether a cpumask contains a CPU, e.g.
>> >
>> >    'target_cpus & 11'
>>
>> 11 == 0xb = b1011
>>
>> So the above would only be true for CPUs 0,1 and 3 ;-)
>
> Sorry, I misunderstood the scalar logic and thought that we treated:
>
>       '$mask $OP $scalar', e.g. 'target_cpus & 11'
>
> .. as a special case meaning a cpumask with that scalar bit set, i.e.
>
>       '$mask $OP CPUS{$scalar}', e.g. 'target_cpus & CPUS{11}'
>
> .. but evidently I was wrong.
>
>> I think you meant: 'target_cpus & 0x800'
>>
>> I tried "1 << 11' but it appears to not allow shifts. I wonder if we should add that?
>
> Hmm... shouldn't we make 'CPUS{11}' work for that?
>

It /should/ already be the case, the user input with the curly braces is
parsed as a cpulist. So CPUS{11} really does mean CPU11, not a hex value to
be interpreted as a cpumask.

However...

> From a quick test (below), that doesn't seem to work, though I think it
> probably should?
> Have I completely misunderstood how this is supposed to work, or is that a bug?
>

The CPUS{} thingie only works with an event field that is either declared as a
cpumask (__cpumask) or a scalar. That's not the case for ipi_raise, the
target_cpus event field is saved as a "raw" bitmask.

There /should/ have been a warning about the event filter though, but I
think it's not happening because I'm allowing more than just FILTER_CPUMASK
in parse_pred() to make it work for scalars. I'll go poke around some more.

Generally for this sort of IPI investigation I'd recommend using the newer
trace_ipi_send_cpu() and trace_ipi_send_cpumask() (for which CPUS{}
filtering works).
If it's only the function call interrupts you're interesting in, have a
look at trace_csd_queue_cpu().

> Mark.

