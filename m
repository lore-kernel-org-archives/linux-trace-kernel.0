Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081EE3358A9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708342; cv=none; b=RNl5xLdaH7NzfgcTF8jdub9KV7SyGiocOyUmUDPBQxcMgokwV5uruf0sc4Z8EOTZ8kzkfD4IGoi/GByLDTxpp0UjDafgb+vLYD/xxI6uIDlM+ICuq6JytMhsP+yFcD73WzTNWMt4njqeplfQD3sMBzH3H0vOiYa5qxnMfXTFgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708342; c=relaxed/simple;
	bh=jn+4SpWXKb7N3/U9AAui93xy+20kHsX2m1NThTyiOfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcD4e6WjKVrDRGkMSK1Q+08FpS7/+W1jTUS3qlt8rpiNJMrwEC+hS7At3quT57pxqfHAAx/boGEVyW+qr3hfNbkHJ6Mud8ZvWamJqnDwkO/5fiunG76eOZLZMLdd/1wao91egYn7YyVa3B2fGgPA/h79Jl6iMtVbD/wzrBNYM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6dbdaced8so800782a34.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 06:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767708340; x=1768313140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu154TMX/+mXm3su25sIKI5TQFzYMOjfJ7G1hsxByO0=;
        b=qUPNyW2cfeNluq8GyPNKggmi2wyPASiQ6Soz5r/00r8y1pNJo5iDjY6jP0aKK3TjVg
         N2mp7/OB35pVC7yXHnFw/nTtsw8Q+8+MJbtIcuSB+1Xw5QROIImCiwPYMheJ6191uDm7
         uTjFbnFtuj8dQ4gKj8J1QVpHT0jHra8kmU31VJse5OYR00syKBa3LjTfgQ5/evIa44zC
         8GonxsNBp5gqDWRc9uMWl7mKqwYwzLUI/C6ZBk8QscD2EAHbAp72uM7nbvy1ibTftVc1
         ekou0LfZmqRsxALpGJkX+1EtkNf84kH9L1fz5jtBEyuKdl+zXAfOgBdbyPHAhSU+zM1U
         JPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTznwKkVVsH/qND6g1HseSQDYxzwfx+uz4RVGVKiZC3uvQRaA2XxHxswrf3lsoCVSOOSDKsGOXvg8zOeU7uOux3+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFJM+4AhRoG6U3QvzfiYPnT1Y23jMwvfXwrf/bc0cu9FOXL/h
	2tm+b7u61c+U+eww38N1CCoE7NhXLkRwIV5fA3++n74dR1B7ssrEeu5W
X-Gm-Gg: AY/fxX5D2Rh3Ao5KxGNLpGhLSCXdvifTIxqs1WC5H2q3KgK4hB6F2Dzqk+6uWW3zJdk
	go4n1X8Zh9t2dwrAKWQQZL6kl5l4BhJPgudghkVrAOD7ixIdClMjIdqEYUZfnDHHSqMq8YYxKky
	Et8T2A9LazguUwyjxck/0p7i+78Gu1IsI7eGNUrsHbv4ZedCvAJvpwXffnc3t6pK2eiUc6t+70F
	twTNbX3Z3ZiH1OALQM/4OxacpWd/CRWQnzKP/95XFtDBDXHsYsPE2WD/zjqq/IrR+ZAmWo3ajG8
	4+EBCwVxkXY83fGyM2sBYkNfwTGhbd5XrMr34JpjRzQAAYvpz/TWbEYr5DwCSxpqjy4aQKNw8nh
	Wq84TS2f6M9UrgLTr8xkbalLswjFwp1u878N10swnGN3yCSxBqR766PrMAZX62b82tbY/Hl+N+i
	9yV++0hpcZ9L2GDw==
X-Google-Smtp-Source: AGHT+IFAyCOognsDglACCwRtgGmfQBOzfISqmFQxoBN8Ni16ip7RMf//hSvC9Q3nMRwn6KHPU/PCow==
X-Received: by 2002:a05:6830:439e:b0:7c7:827f:872b with SMTP id 46e09a7af769-7ce46767c8fmr2483407a34.37.1767708339811;
        Tue, 06 Jan 2026 06:05:39 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm1459846a34.12.2026.01.06.06.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:05:39 -0800 (PST)
Date: Tue, 6 Jan 2026 06:05:37 -0800
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Laura Abbott <labbott@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, 
	puranjay@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <tj43kozcibuidfzoqzrvk6gsxylddfpyftkdiy7xb2zm7yncx5@z33xu7tavuts>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
 <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>

On Tue, Jan 06, 2026 at 12:21:47PM +0000, Mark Rutland wrote:
> On Tue, Jan 06, 2026 at 02:16:35AM -0800, Breno Leitao wrote:
> > The arm64 kernel doesn't boot with annotated branches
> > (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> > 
> > Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> > solved the problem. Narrowing down a bit further, I found that
> > physaddr.c is the file that needs to have branch profiling disabled to
> > get the machine to boot.
> > 
> > I suspect that it might invoke some ftrace helper very early in the boot
> > process and ftrace is still not enabled(!?).
> > 
> > Rather than playing whack-a-mole with individual files, disable branch
> > profiling for the entire arch/arm64 tree, similar to what x86 already
> > does in arch/x86/Kbuild.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> I don't think ec6d06efb0bac is to blame here, and CONFIG_DEBUG_VIRTUAL
> is unsound in a number of places, so I'd prefer to remove that Fixes tag
> and backport this for all stable trees.

That is fair, thanks for the review.

Should I submit a new version without the fixes tag, or, do you guys do
it while merging the patch?

thanks
--breno
