Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD134C816
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714371; cv=none; b=ZS4vXg25XG9FPYO4l4St6rksDw3V+NpC+8JCrj8c0D9kV5R4huaL/FaqHXuBxpMDWFi3zX1JMs7a76/JnuM9e/r9EZxxfTCWlOrw/iQuqJB8j6Na1aKFVgJM5MoC+p+CK1U+CYn2iRVuGPxXp2RfGjXjH2+NGi4rJOFM3wF1Fm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714371; c=relaxed/simple;
	bh=dAi7RBBhF1hgxKa+hRL7HHi1/MQQPDt6gkhve2rSQW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKpMK3wZzFC6AyIi5ABFaIiYqt1FRT+I2KNKYVf5NE173NdGIsCkuBMXyxRt11jqanV4z2zctRZAwmmhNaJZbbNqXOM0a7m+v/8gYHRogv99dpiPdKnG0sqhxaO/1s/jDbK7q4N7W/aE9XXUSiqefdVJFFYXtdJ1RNrpESA8aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6e815310aso896779a34.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 07:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714368; x=1768319168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQTUy1kZhVd6QFKYgDUasG/BXOAj1nBI7IAdTwgQh4k=;
        b=a1W+8AgzNE74ITPevixFidA7s7qYA5Mh+imNRZWtf9az3NcRRiZYXXr+jwt/CTz6ak
         B1sO34zTGr+xcShdFyeyrnWRBMf44sWFGV7tqzCXSdG/9ttVUHdqimLl6cd6thD8K1y8
         4Ih5z2KN9iT930MmD6PenEZ+w9OXV+AkTaXiLdArFzD7AQ+cuA1bQzHIoi+2huJYNdEs
         0MngUov4RSF1SuQ7mgv6tm5qXlRNTQczHlZOtwV/8jctaqszzr3Be69G6lDmK9oXQQHt
         saQw701cucMaXMd6NtZi6/04LEoY4oN6g+2wnU5RAONYwCocU3FxpSguMhyMFraLt0CA
         w79w==
X-Forwarded-Encrypted: i=1; AJvYcCUV0CeqWl5Ok7w66Tr0G7IpHy+62saXTUakCqgWEccN6zboD0JS2QU16f6uGoUppBTeMu83FHLvKRtBeU51dEVb1cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFy9wMQTpaAZCA/QSDquBiCPxvzO8zkwUTGuMqfwbkjTnzUbA
	dX3B+n6XDRQo55I8ARjs7IOUvBhF3+InsHJ5d/8sTz6XHNZfSBaEdJNr
X-Gm-Gg: AY/fxX7pgzoiE3venHRF2c4KfQjTQSCcUprCwJVQQxgue8Ho3o6KiMwTULCNrV6sHdr
	UXzJVc0i99YG5h1KavKEORMIzSyrDZ8KUCwx/9UCgEDRTsvDb+h2KrcYBgLGrOyp/Uba/qAuiPu
	HfjxAiNRiVrazQqP1vU0Du4/HQZgfWbBqdxYjxXePJI8HuV9eUTOELs/PVsE+LKTQH1wnHXpB4X
	Zm4Q9hu3An3xRPgws3WGBFBc/ivoZRGF1xidyBLd96H2enTvT8VfMy5atfPp7fQDPAMVvBr8nc+
	L4jpWGPBSJM3Fa0VgJD1n3Wn15IYVvn6BYESuGagA8/MV8MKu+nKqRx7dwzHZE9f6GIlYPYHR6n
	+VBoU/4wvgdFeztSNcK6jV9v/pqElNyNpjvj3HbVQ9b5eHTFytBa9tHDK0NsOJfOosgC0KEUrv8
	1aIWibp97DOEcPREsSxfuP
X-Google-Smtp-Source: AGHT+IEDVtPF+jdII9GyQUl1ZSSEpCxWJpHOx5hPHx7PAH7getQJEBbENhpATdFTeDD/D3J2rXVxsQ==
X-Received: by 2002:a05:6830:668c:b0:7c7:1e8a:c9d8 with SMTP id 46e09a7af769-7ce46745fcamr2517821a34.36.1767714368554;
        Tue, 06 Jan 2026 07:46:08 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478029a6sm1603103a34.3.2026.01.06.07.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:46:08 -0800 (PST)
Date: Tue, 6 Jan 2026 07:46:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Laura Abbott <labbott@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, 
	puranjay@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <cllfyxsg4gkyg65j3bko2fncibwmr2wqzzs2255qp6l3vupev7@2ke5cv6iqpow>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
 <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
 <tj43kozcibuidfzoqzrvk6gsxylddfpyftkdiy7xb2zm7yncx5@z33xu7tavuts>
 <aV0qxGioAXxkh6QD@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV0qxGioAXxkh6QD@J2N7QTR9R3>

On Tue, Jan 06, 2026 at 03:31:16PM +0000, Mark Rutland wrote:
> On Tue, Jan 06, 2026 at 06:05:37AM -0800, Breno Leitao wrote:
> > On Tue, Jan 06, 2026 at 12:21:47PM +0000, Mark Rutland wrote:
> > > On Tue, Jan 06, 2026 at 02:16:35AM -0800, Breno Leitao wrote:
> > > > The arm64 kernel doesn't boot with annotated branches
> > > > (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> > > > 
> > > > Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> > > > solved the problem. Narrowing down a bit further, I found that
> > > > physaddr.c is the file that needs to have branch profiling disabled to
> > > > get the machine to boot.
> > > > 
> > > > I suspect that it might invoke some ftrace helper very early in the boot
> > > > process and ftrace is still not enabled(!?).
> > > > 
> > > > Rather than playing whack-a-mole with individual files, disable branch
> > > > profiling for the entire arch/arm64 tree, similar to what x86 already
> > > > does in arch/x86/Kbuild.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > 
> > > I don't think ec6d06efb0bac is to blame here, and CONFIG_DEBUG_VIRTUAL
> > > is unsound in a number of places, so I'd prefer to remove that Fixes tag
> > > and backport this for all stable trees.
> > 
> > That is fair, thanks for the review.
> > 
> > Should I submit a new version without the fixes tag, or, do you guys do
> > it while merging the patch?
> 
> I assume that Catalin or Will can handle that when applying (if they
> agree with me); no need to respin.

Thanks Mark.
