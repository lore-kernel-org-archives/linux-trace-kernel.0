Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F33128BC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729632; cv=none; b=MUG9Ol57X+gSiy1ZJ+pPjLBkaWIFEDiRA3KNDptRYdLiDOZawIcAYSA3QIlau54fvCoFGbTD7Qa7qs0Z2Bl7FHd3E5zSlVBwiz17LUNviHIASaOo0cQ/eo/iwccMbWooDXHVSHQMPuDCyVs2Gyt6kzKXevt/smo/5h1CfERA/OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729632; c=relaxed/simple;
	bh=jEEjzmNz+gmk5ZgeibUNddmKR2RxdfJxzRrshLcdK0s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iex8rOdQr1Pm+VguGJeByHYbpIROCAhtSr1Mccwu3rtIDMbEE3uglL4N6VnqMsnXLCwcnufoUCu7JDi64aTzVzjGCz/4F7I7pAaoAibCmSUvtXGP1izBfKgl13gXMJO3YTGmNp8oZ4BCRib1+mTNHv6w/s7z7tzyPSXqNaz6KIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJxutCxs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJxutCxs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so43179325e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729629; x=1759334429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=750rYEAHSQ0UWuveAndSH+YLhrYLDuMy4II+d7YdJQE=;
        b=lJxutCxs3RZMFeCOOS2VTbsDXy7S9D/5OVh2iuo0bwAN3PJRKHX9n7hVerFj11aX3s
         96KTehdHee/QXiBSGdzxgkdEAGsXVUyoGCjqjPmhdPsgnRAkD9NJ8FTuNhThGx4St3Wp
         239cC1fzNJi9dWsrYcB+P8OKPOuxVfx9STNs6bOx2hrn5jlqvDVBJjhqiTt6SkEOjCbY
         LiiYxml+zSh8kXr9uzJ3vk0ZlHzbcW5hJwlPfMONE7XDz8ACoiN0KhUes4o5yttog3oV
         QkNNlNT/p0zo14xF3L8xD7CIW4yqlRHxNwqEjcNwZhS0L7QFLhmF0P9HGXX8IdLHmveB
         ZPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729629; x=1759334429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=750rYEAHSQ0UWuveAndSH+YLhrYLDuMy4II+d7YdJQE=;
        b=w3DLs39xVWJGd8xawy/WYhMAS01yER9/mOWpuHsNMY6gmxsb3OQ2mavvrqOmpF4DPC
         XVhEhfroBxm2sUxoxzzkALOAz0Fo88emOYVdlWCVs3OWebkGn3UM61qoV80T034VZ1Tc
         WpPHDlaHVihdRDycuD4mO/EF8dzmbVFA7KkV+gt7pcyVr9Y4YVCxir/kV/OteCpEFHmG
         DX/FogA2e+RKF+H9P+p54fTukhmy43shvqvyu9pHLRJuMA51X6dDPANOesZHUUIo2veo
         Ch6kKfvfaW9LLAbO53OV+6nZtwyBfZUp8FH8mMxoKPrLiSs5aefmhLw20dLhu7dLBTf5
         Dq7A==
X-Forwarded-Encrypted: i=1; AJvYcCX6SHZqH+oWVK/BwH298j0d75dwzAvtKUngXWrMdvLm3y4PH9o2al+Mlpn2AzvGeRTQIIIGAL+xxg1IjfHqtZZpzRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNcqz/ica9KvR0Ot+qTnSIfbBpcUYCGsN8iByMqfMSSho+2jU
	0WdIruGg7Wf1nq04Wat3eQu64J92b2PH33azSCeFcw2m3E9zVtzqeWH6HUYyCwRH8pE=
X-Gm-Gg: ASbGncvhutH0+qe8ed3eT58nFtakdcpnrl7FULpJmIbwVjsZ3Eu2GwNFcUTSsosXO1B
	kiLeUtScW5o7yIQt5H55DLptoblj78bznKMGowavecF9g7j4aBqXPlJY6GWj73X7WE8GyTEQJKU
	aoiJBpVxooSkuSRT6xL1yU0SigaDO5he2ldxEjqA9F70tFXHfGyhgKgtb1myC/RG4OChIkeqfXd
	LpayGAkyHbpeoscNS+MymcpdYMpQNkGins8VCBktcU+5krHOFCr7afAHHMY6pkzNkzYazU78fHy
	xmdID8Ax9S5JDQZB23LtPKpFufrCwBZMdqLhBLlVuo7GBvnRNaORO0jPCins1492juEbcA53
X-Google-Smtp-Source: AGHT+IGS1uVQdvHmWTJ9aInOCYB0BEj+cPbPcp0L0eplHLPsYT5p2wId+q3+D0Z2kfEz6FOGX5pf3g==
X-Received: by 2002:a05:600c:1d16:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-46e329bca25mr3761415e9.13.1758729629203;
        Wed, 24 Sep 2025 09:00:29 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm28837786f8f.18.2025.09.24.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:00:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 18:00:26 +0200
To: Steven Rostedt <rostedt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH 2/9] ftrace: Add register_ftrace_direct_hash function
Message-ID: <aNQVmrGCW08zF9Kp@krava>
References: <20250923215147.1571952-1-jolsa@kernel.org>
 <20250923215147.1571952-3-jolsa@kernel.org>
 <20250924050415.4aefcb91@batman.local.home>
 <aNQCDwYcG0Qo00Vg@krava>
 <20250924110703.2a0ced1b@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924110703.2a0ced1b@batman.local.home>

On Wed, Sep 24, 2025 at 11:07:03AM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 16:37:03 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > I have bpf changes using this that I did not post yet, but even with that
> > there's probably no reason to export this.. will remove
> 
> I'm interested in seeing these patches, as the ftrace hashes were
> supposed to be opaque from other parts of the kernel.

branch:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=bpf/tracing_multi

used in this commit:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/tracing_multi&id=8814108949537edaae84fbeee1cbc28280590b7f

background.. it's poc code for bpf tracing-multi attachment. Most likely we will
go with Menglong change instead [1], but it could use this direct interface in a
same way for speeding up the attachment

jirka


[1] https://lore.kernel.org/bpf/20250528034712.138701-1-dongml2@chinatelecom.cn/
