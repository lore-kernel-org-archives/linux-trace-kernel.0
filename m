Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F73E9589
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783943985; cv=none; b=U2r36fSqfsU3WyV4R7MDKH79vUjPy4fCtYuDU7B9I53flAMv/16Jp1Pq/3fzmxZrWkrxP1aEpo/MNOHDsU1jT1+XmMg9fZ7yvhclghXUwxcOfNemXNYet6SZ7E7XkMwCLbXJr9LuuBnWAtn52FKFK91vhsLec50XVIOmlqjvU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783943985; c=relaxed/simple;
	bh=z0v/Ogt2JhCjQ23ygxt39RmZrIcMhnpDduElpxFs9tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEEaajalUhDioMwUlkwpNkdKWt/hs0ldis92jopciV/tg34M6ZvwOSRxSTW5YU2Kbxrx+6ffB2eYX5LtNu38hwUHrUIwX3rBtjh1UvGGnjcBJDFkr/BKY39zAYm45ZlZse7Dyk3aIaCxVfgmciGpxrff20YzbrejrbfmdInekCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=I5ISlnyy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="I5ISlnyy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso1998514f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783943981; x=1784548781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPq58yO8xMyfvTfCQgTcJqg0n8BZqIb/9rotAadu1kM=;
        b=I5ISlnyyqjNHsOGffH9E9rv7UP1OFimEgem+A3p5evCyryA9NuNv4eLe+bf9TY2E5d
         KSXJ9/kWzm70RzHUhE7XrjuPiCUTf9iUzOFBEeXPgD1YgIYXtbYj0oShqhgGy8QdjCiN
         o7C5K53S1BVdtI9NEHDQ+qXmH7qIxWaUJ9ADNZZnnoYCHUbg6T9sF4aLUXS6xKNVmNAN
         Md1F4QJURfzjHVcfPSqvmPxX7LZD/1bJ1eORqg2cnZ9XKDpP1O8aTLzT9hzN2w4UMJ1M
         HPkV+ANryJpt77EwVcIHj7KCH2QZKkW0otS1JquyOcYZgyTSVqHkdiMfu5/fRXNs73S+
         PcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783943981; x=1784548781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPq58yO8xMyfvTfCQgTcJqg0n8BZqIb/9rotAadu1kM=;
        b=FLvxdPwJANvZ4N1dIo0iSbTc/woR4QcgsfxXdQa5caKJcwjZ7daXcSwZ2CTcxmZUVl
         NCQlxRT1aq3Sn4qG9I1P8nxpMIz8eMKk9TvRGgk6/3GGlvAirUvaICcv5nk57XFpyJQZ
         uEI2F0W4VliQvNgeqrh85uZ5vRUA09QEtkjMaP+wxgjg5/R12mQwp1k0cIiSFG8EQH+L
         tIiCNMCTDjs0eJ/wFlPX6IstCItmQ99UOQ/L01/7l72rr0EtReX1OOqcXWCwGQGWNy5x
         ViZtvahSRUzbEbemm9n4OQ79aSl2DrNWPubl6boPdAoB1W5BXR2E/4QZyQXYD0yTpPNl
         +ZuA==
X-Forwarded-Encrypted: i=1; AHgh+RoAnmLOtD1reOeG00fzJqNR6TAlrKLC5hsxBL+wD7CvlowGvqtyLD4z6vOMCRQmIWfNV/3p+/rblg7BkVCY0aOYVlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxks5xrs994fFXdcIYvfpMCK+qRIJDJCRexILRl+fGDX7o3ZI5/
	XeTkekBY8lz3g8C2J2LSlpCEHurSewGRsFq+XyEfhimBbaLDHT2Sm0zZt8o6rMXgMuY=
X-Gm-Gg: AfdE7cl48B9mHfo/blMZKaHShryeoPK2EcnmEnSnrfVgXL/zP2tsZp4e41rUwD33lRV
	clEkN9/hb0sSE7iH8HYTpLne3lK49dUtIOG8l9RlGHsAYbeeZHYo6t138Yq1DrEQ88cl9p00ZAF
	FIC36Vx9d2p8e/kRNnEOS6eWnCQ4qvcZxBTkJxFuq99Y05m9kQoe1tUoLMKW7TZ+WlzSkCsU3Xb
	H+n/l2xdivhBE9oNJE3o0RBSsCXRQeAzJrw3km064QgQ8EPE0bgwtriy2FsbxB/Q4+DA6XsPyfL
	GhHN1DZoKaxY4qfiWljnDzfdM2CE/x8iH+UN6TsPk1JfAYVEgpJOqeaZQjv4K4AohFUFcfi8q/e
	HleKguB6Xp4qyRPajP1Fyd4LZ/lRroG4fpZTbxmxeg5zPPzOAzAfP+phoG4lLzeCaXFiJlQ80QQ
	JfFH3g86be3w==
X-Received: by 2002:a05:6000:184d:b0:46f:7d90:8121 with SMTP id ffacd0b85a97d-47f2dcbd321mr9996995f8f.14.1783943981451;
        Mon, 13 Jul 2026 04:59:41 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm87849433f8f.1.2026.07.13.04.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:59:40 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:59:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Pintu Kumar Agarwal <pintu.agarwal@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	surenb@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	peterz@infradead.org, mathieu.desnoyers@efficios.com,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, pintu.ping@gmail.com,
	nathan@kernel.org, ojeda@kernel.org, nsc@kernel.org,
	gary@garyguo.net, tglx@kernel.org, thomas.weissschuh@linutronix.de,
	aliceryhl@google.com, dianders@chromium.org, linux.amoon@gmail.com,
	rdunlap@infradead.org, akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC PATCH 0/1] psi: Introduce in-kernel PSI auto monitor feature
Message-ID: <20260713115936.GM276793@cmpxchg.org>
References: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>

On Thu, Jul 02, 2026 at 10:46:05PM +0530, Pintu Kumar Agarwal wrote:
> Hi all,
> 
> This RFC introduces an in-kernel PSI auto monitor aimed at improving
> root-cause visibility for resource pressure events in Linux systems.
> 
> Motivation:
> 
> PSI already provides an excellent mechanism to detect CPU, memory and
> I/O pressure and includes trigger-based notifications via pollable
> interfaces. However, it deliberately avoids attributing pressure to
> individual tasks.

Why is this necessary?

> In real-world systems, this creates a gap: when a PSI trigger fires,
> users still need to determine *which tasks caused the stall* by combining
> multiple tools (top, meminfo, vmstat, perf, tracing, etc.), often after
> the event has already passed.

I've never found myself needing to identify which specific task was
stalled. Tasks competing over a shared resource are interdependent.

Consider this scenario: Task A, B, C are allocating memory and
creating pressure together; B randomly becomes the sucker to hit
direct reclaim and making room for the other too as well. Why is it
meaningful to know that B stalled? It caused the resource contention
no more than the other two.

Then A and C refault: A is fast, but C happens to hit when the flash
drive is running garbage collection. Why is it meaningful to know C?
Again, C is no more the culprit in that situation than the others.

The meaningful thing you can say is that the domain as a whole is
under pressure. Who exactly becomes the lightning rod is noise.

That said, if you do need it, why not use delayacct? It already tracks
the reclaim, swap, thrashing time and events that also go into psi on
a per-task basis. It's not sampled, either.
