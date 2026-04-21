Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3B397E91
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761725; cv=none; b=jriGO9MhA5j49Owx8ms+RjXEVPO8gvvwjBJIUvpT0S6bytY/8vitY8HwLQqIawuZpvF59ebKqlqaBeGG+Xyap2hMEu1od9aOoNg1MDYHfQ/y7CDXPImc2BDWRmZlQ7+nJ2byhLcENf6dcsvdAdTgptcOO6JVeT9YTI/jyCl62Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761725; c=relaxed/simple;
	bh=1D4wmwML28Gdk216ZBGZCjFPuBFFNvefSx3CUAO9YHU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnd4qKWl86yTfIyXtJKH49nmdCmJNOwmGnBVnw59fvqoCM6eHubH+Bfp6XqrjUzvSz3gPRJW0Akt28az/BECdOkrx0umfD/WFsspbXqm1VJAIv0EfzYxIMmPKAcEAuA6ll07x7l4ttZQrNNhYM/D592Lfdml5NHiFwiMKV+Okao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHSVhWKP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHSVhWKP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so27532025e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761722; x=1777366522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxBreWlPHPo3iYaW6fEd9W7BKIlXix7jjXchq/o+daI=;
        b=LHSVhWKPNlRuIrRJDE4SvY3awaQbfBYZKxuz0QWJVoAQKJD9y+jjGN+DVJwXGxJoqk
         2iFka2kCVzENmis05SHmllqe1GJNTTdgzwx7ArBvihDm1dFlBsfW2MDj3VuAcKFyTy1c
         sD4Fm0shdoFtJiv52Mgsb9Qh9tqVNMHt4mLANx4kLuIxJMbR8Kr36y0MLO/9+OLbhXJk
         oyJ6GfOSJ2MjTRouauHQv8OZb3gU0kx9/Y5ZxrFUZMAXmG7LmCTu+Fk1zwhRw66i/jCO
         sUcWlEEyHHB65r69ByRRs+zCrwR5NvsfuYok7YWonqZl4WE9waRXl6pPiiqQUla4+2Cm
         78lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761722; x=1777366522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxBreWlPHPo3iYaW6fEd9W7BKIlXix7jjXchq/o+daI=;
        b=AB+jH0BPSafdu6jLn3gJqPdy+BjyvFpd8+VoTIluF7wdyAS1EZnml5Ea+EXEttI/TZ
         2USSSWvShhDrB2NlZNQaP7hWi6jedQ9rzmu2KZffME0TvUSE7U7vatSeDfN9tWcCiXtj
         nYuLr9eyscKDKmTg4BwOOe8QsZvVDNwV5KRbTvvLcqWaaDc5wuvXgj8vbk2VQmwD1f8x
         HJXWOFy+O9hnchjw9tfukLNkNg1uqXJFD/tSWT5+nPm/b4nGajClGevUivqqonSy8Joq
         aqMm8YZu7G6NAORU4vdg+2h1EwDvZqjT2n6fOjD4lwoYz1xK3Ci6SEaOr+qaAfh+vR9j
         lKxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BpA9Df0a7knHXhTUY/9aoqLeN2wmNbX6lweqsJlxn7accdUFsIA3w6nHtTg3/2uM4LshPWPdyC30LWHCv/Sok+W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSiQyuvPgesZKk0Vm3V/bpwVsz/h40HxxXNjRJLsSK4YMeuC6
	H3ZM5yGiwc6MtN+bz7DK+BH9EkSh/bwelB0J5JLB4sYoTe4YiWxnBEu0
X-Gm-Gg: AeBDiesMDZxXu4dnnOmRm8bteOyYtfAjOYk9fo+deSYszqma/jguD6SID/5icuROMFO
	v1BbbRedEqNY1OES5kbjwdv1jAvOoHpm7ZC9OHL4Zbmnywvp3YT8FeQtqaP8wHLtwMll8tTummI
	G2HU/0AMnM49fj6twRwwJrup2qqWvFufdpTuIC4Or6yePSDgFALcWarK8ygwK7gFEZV7F3FpRU0
	2rOBZenFo/T4oQKaaenFdYa+mLunBZ288TUqrOBakNWndTaqN9LkZpATnIRnrideccsn8UAGB8g
	vKp8ijKNcAkB4VKuT+CbzQp50OFD2O7QhHzVXPkgA/ocv19fk5lISt2bzfxJgNiNgVlOPQhIDwx
	GosfjzJp4oHv9Z6il/KfERPj2qGlgiAJUg2imKvKeeE7FQPxG6f6RoQsfV+kiikpKJF40XrWfs8
	1wyvsR0IU=
X-Received: by 2002:a05:600c:a08c:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48a563cd176mr20770175e9.7.1776761722104;
        Tue, 21 Apr 2026 01:55:22 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm63317395e9.26.2026.04.21.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:19 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 06/28] bpf: Move trampoline image setup into
 bpf_trampoline_ops callbacks
Message-ID: <aec7d0Z70WKqC1b4@krava>
References: <20260417192502.194548-7-jolsa@kernel.org>
 <8a315de2e20505875006c4e32af33c0838000a79484f7a2e44b1081187a01379@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a315de2e20505875006c4e32af33c0838000a79484f7a2e44b1081187a01379@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:10:25PM +0000, bot+bpf-ci@kernel.org wrote:
> > There's slight functional change for the unregister path, where we
> > currently free the image unconditionally even if the detach fails.
> > The new code keeps the image in place, possibly preventing the crash.
> 
> This appears to be fixing a bug where the image was freed even when detach
> failed. The bug was introduced in commit e21aa341785c ("bpf: Fix fexit
> trampoline.") which unconditionally freed the trampoline image.
> 
> Should this commit include a Fixes tag? The suggested tag would be:
> 
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")

right, I think I'll send separate fix for current code,
to have this fixed earlier

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711

