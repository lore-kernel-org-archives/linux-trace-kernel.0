Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5E4F4036
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852757; cv=none; b=ZkXkfRJvMEMtCRSWsCs6CONHvG2N8ulziJ/ehk1k6aznu7uEJ+dy3d16TLBdEqQxfgzLbH+nqHYHPrkc2x6eT0EPeKXNPWbYbq7s08LkpAl84tqdK0zMkDkFw65ET0e/EJwhJnAJDJ2By3ZSDK0rFTDASgv+FAfC2cjQnV3V6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852757; c=relaxed/simple;
	bh=x5ys3ou1s2SNqxZHNXG0kEAmte9nf0fwcDyiMeg6kbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N/04V6nhRAhdq6WHfOD1giqziWJnqtzqngxHCTQPRRTmS+dOY3jpl3JNlg11F5tu4nXmt7UDe4fz9Snf69JePKTY4i1ttBbhm0cktOYDWkSNyILTa+N9E7Zc+KdN58lRZNXvxSr6Rdx2yoc4q9avJv7vAYSFvMBZvoXix0B4l1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9QHu3Wf; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9QHu3Wf"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e65bee41aso26246155e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790852754; x=1791457554; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lq0jjzxKFZwxoQFxNcWNw0/FRt3Y9c+8HIkgfK5xmkU=;
        b=Y9QHu3WfS2HaFjqufTh1a4KYYRiKZta3xG0wOwsh8jWcj5ldHbx4/2rR8hecNk/Uzv
         BUEFZO/A5LRfBbyMl0QMsXNcbSFhmd0cacCio3wR/u65xkwkY6Tsf5rDmafCM1Wnv7G2
         0P+L2lg5RdL1D12rsT9Q60uhv6qvgGjNSySWe0NhSMtZvFZqBGJRa2CXlHyuX8b2YflP
         LDv29KEC5q8MAIALpGYjuiJw0rrqekikfLPV+rd0Az6+MvS/LHCkOslMnEuB+5wrBFAU
         G8FCPsS6khTQRnVDonKwiXGqVNX0XiOuW9xTaq4oM154IjjZXDgglAciuO3pvpD+zv2j
         ksWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852754; x=1791457554;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lq0jjzxKFZwxoQFxNcWNw0/FRt3Y9c+8HIkgfK5xmkU=;
        b=XsDBdVWbuhRO3PWFTT72ogDWXQhJ/Z+hfXwOhxRyUDJAKUHaRbZxDZ9wRfQTm5bXyl
         FZMFlpSd+pW7ajXlt9uvsxleNy1YuRn5NpQ8ZdlNJZmd45MpeMB6Kd4rGml1NEFxXsER
         v/umk2cFnXIOFu/2C+51uNw3UUt3mLX4KqJd9uc85TjWs4CQrPWJo1gL3OXmW2nKXQbj
         ioVkUl0gydjzcQzSqyorfpNNY5Khe1cQw5bC/h9VJtr3j4beC3KUR2OEujab3ZX9fR7P
         hxbVUaLZS2D9PLBnELBwy55w+SkQLjFum4GpSTee9bRucQAITt0dC5xHp8934e0CJFIf
         5jsg==
X-Forwarded-Encrypted: i=1; AKwUvBy2tV5ldhBmt9XBiKKE0GT7G/DPNvZKSVlLMF8/RNjaJfKQ/koNNOTUGOOFQqsWdJB5Fn3rwqabQOhGyO8FRy5aqlo=@vger.kernel.org
X-Gm-Message-State: AFuF++nCby4f66IIU/SFxRrmWMncI8J8kHz8YPRzRhjigW3+8+iW7dFs
	6RHq0okXQga9f/7vHUKmOvWSCq286FLC+nPH+oRX3gPW6jPbeSH1CCeryOuFB3txKI3kfcok7Ds
	dIGA/Xx1Qr+tgfv2LyA==
X-Received: from wmpc37.prod.google.com ([2002:a05:600c:4a25:b0:49e:65c1:6109])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83ca:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a01eaf59c6mr43333055e9.2.1790852753706;
 Thu, 01 Oct 2026 04:05:53 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:05:52 +0000
In-Reply-To: <20260930.185028.532667902450882259.tomo@flapping.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909120210.2488674-1-tomo@flapping.org> <20260930.185028.532667902450882259.tomo@flapping.org>
Message-ID: <ar4-kOdIs7z6zG6k@google.com>
Subject: Re: [PATCH v2] rust: add mark_used macro
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: rostedt@goodmis.org, gary@garyguo.net, ojeda@kernel.org, 
	a.hindborg@kernel.org, acourbot@nvidia.com, bjorn3_gh@protonmail.com, 
	boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com, 
	lossin@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	fujita.tomonori@gmail.com
Content-Type: text/plain; charset="utf-8"

On Wed, Sep 30, 2026 at 06:50:28PM +0900, FUJITA Tomonori wrote:
> > diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
> > index c6e80aa99e8e..29d2d2d0aca8 100644
> > --- a/rust/kernel/tracepoint.rs
> > +++ b/rust/kernel/tracepoint.rs
> > @@ -38,9 +38,7 @@ macro_rules! declare_trace {
> >  
> >              #[cfg(not(CONFIG_TRACEPOINTS))]
> >              {
> > -                // If tracepoints are disabled, insert a trivial use of each argument
> > -                // to avoid unused argument warnings.
> > -                $( let _unused = $argname; )*
> > +                $crate::mark_used!($($argname),*);
> >              }
> >          }
> >      )*}
> > 
> 
> Gentle ping. Could you take a look at the tracepoint.rs part? If it
> looks fine, I think it is easiest to take the patch through the Rust
> tree.

Why are we adding this macro?

I think it's better to prefer avoiding macros if we can. The current
code is familiar to people who know Rust idioms, and now you are
replacing it with a kernel-specific macro that such people will not be
familiar with.

Alice
