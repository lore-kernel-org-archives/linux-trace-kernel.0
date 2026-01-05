Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70A2F999A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jan 2026 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630978; cv=none; b=YxI1rxMVY0DzKpJrQ7x9ANG1QGdc4CBtOeSdZL5CTW2uq4ks3NEiJnvGtMABgnNfjFbEcv3ZxdDyhOlsVOwXAx6058c1DtRqUUtAGfmvKTukq+oUXAnhKUIVzVX3wS6CzI3G3wEVcM69hrNTYqJLtn0MEjue/uWDqCfgOfzUgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630978; c=relaxed/simple;
	bh=Cne43cGOBFzbsHriSJTKpbMxofM1/GdzL1+MVAry/W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/Iaw2qW2HCqhZcAUY3yJLfGaEI1zzwvvW5i+zofU1Ckd1Pw39BgaH3v3tY6lHQLrznuvJK3eszXFu8kEFTjfV5izyUqRTMmt9cC/7mYj98ux73SXcSnDRFjmwjoSmmObQXjeGCTDDhqxy8OL9cp9NtanjHZYaMugcBsO1/TSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipjMY4/1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipjMY4/1"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fc520433aso1637087b3.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Jan 2026 08:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767630972; x=1768235772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmLroKiaaSIEDmiG3hNy96115cezpvbgC/O0Qw/mmcE=;
        b=ipjMY4/19KtfqRv0jJBNwzk99KWVbeD7mlC1CKhkX3LMa43NLmIOAXegcSUIWxhef2
         qNn/wV1C7mfUiqs67gUTOdQNDvqAZL74N0iz6/a6+T4G/qysNy/dRQsRPJfKDjEf06eN
         a1vi6sT5yHAN77fOeERlGW5gtUCiGQJkbPHcv5vvQJFGmNYY89aApFSJrSyau9tjw2QG
         5h5+Qq7Et/LX8XjN001SGTjFBB9Wu7OXl0GKpzV8fPDIPYdis5IUrNGL0jfm3oPb1Oz0
         CwiB5Gs6+oL9V6btK4L6YkmF1hvOuyojPJmOLqwrfLrOEoQe2v99FhFsOFUiqazQ+Cpp
         YnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630972; x=1768235772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmLroKiaaSIEDmiG3hNy96115cezpvbgC/O0Qw/mmcE=;
        b=vBsXx+oM9n4cl8+6cCEftT/PCY0zvLaaAx+STnBOTsVMI39XiTsA97/iohhR0K+uIX
         dJeuPpsY+SY961cDbWhcORBh4ES9hrbZcpMUjnk+lo7k4EMelpMkFyUDJRfT4laDjzHO
         hdSgwMu7Cf0DWMiW3Y6azki9xIg9FRQH1/xvdA7xDj0Rt2Cp2tVJE40lVr294MhL5Jhv
         dHSX9iYt8YB3Nraqe6m9HHCVODV8Ckv/eOSTh+oVYkRXl/y1jO/CkhwZ0q2+TMxD6p5n
         gAVQH1tg+uD1hQRdFUSyBL8NzFDdBwZQk7mBEDTzPaIBNdgRt8OBE3altXQTmms0HQa8
         Eu4A==
X-Forwarded-Encrypted: i=1; AJvYcCVAnxztVORbeTch8xwVanRVeJgOLyNzwsEPV7sdQeXzdFXWy8qzEICZaRscVG0Tf8Q8vW6wLP6DnC/4Ju5cWxYUPIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqOAWHbCPAmux6XhPWHRBpbUIuTPQsAX39sSgCB2hqtar8PiU
	hb/ZBhTXL0xcf/FXTDTrqU5VEq4IVJ7SkO3AkjQXV3zS2hLchSJytGv8
X-Gm-Gg: AY/fxX6exPBH4M0dK1NkKluOssEZ8sqSzamjA9eNqUJ93GFmpImiiZq9dPdzQiM5QM2
	pY8Q6LSy7YpWN4/trWYsEm/SQa9oq8yVX4QeVEhew+QefR16MUmTYAUzHf+Q2QpnpfI+pPZ49F0
	2rosa6srQCMA5TxOBgh9+MOQE/pE3qygZpTZaC/a4vGAYCnGspx+1j1tp2ZzwtlVK2RElMIzlb0
	rV9xYUw2gG+VQxIltxUMyytskkqLSHngK281MxgFvSuFpXlK60hAaUZiq6lythil98BbzDRaw1y
	9eZ+PNPFgUFyFWTNq4ZQLx6sHZ55v8N3CyCPcnwKnAKKufBLWZUAbcQg7Xx6VrtPOH2il8zBhoz
	bHhIPwc5RWeDfFy09P2BMiOcSqQbeQtVkbJo8MOOaLItIWve2oFOEOBSF1tugK08q/hzG/ZP3Yr
	zhUk1Wnrk=
X-Google-Smtp-Source: AGHT+IHZnvqij0p2dsVEyUAqfbDQF6JM3zbwBqi4iRccM72+GqOmYwfEQER+7XbmOSanBy2kuKO6sw==
X-Received: by 2002:a05:690c:45ca:b0:78f:aa6d:48cd with SMTP id 00721157ae682-790a88f50b1mr1761297b3.0.1767630972421;
        Mon, 05 Jan 2026 08:36:12 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:830c:9f83:df41:3e7d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790a87dce60sm648267b3.13.2026.01.05.08.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:36:12 -0800 (PST)
Date: Mon, 5 Jan 2026 11:36:11 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aVvoe5fQN3EUtEAJ@yury>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2>
 <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <aVkmQ4EGIQgAddZQ@yury>
 <254c1096c3b892923dd12b07a8b80291b88c0e9b@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254c1096c3b892923dd12b07a8b80291b88c0e9b@intel.com>

On Mon, Jan 05, 2026 at 11:29:51AM +0200, Jani Nikula wrote:
> On Sat, 03 Jan 2026, Yury Norov <yury.norov@gmail.com> wrote:
> > On Sat, Jan 03, 2026 at 02:57:58PM +0200, Andy Shevchenko wrote:
> >> On Fri, Jan 02, 2026 at 07:50:59PM -0500, Joel Fernandes wrote:
> >> > On Mon, Dec 29, 2025 at 11:17:48AM -0500, Steven Rostedt wrote:
> >> 
> >> ...
> >> 
> >> > I use trace_printk() all the time for kernel, particularly RCU development.
> >> > One of the key usecases I have is dumping traces on panic (with panic on warn
> >> > and stop tracing on warn enabled). This is extremely useful since I can add
> >> > custom tracing and dump traces when rare conditions occur. I fixed several
> >> > bugs with this technique.
> >> > 
> >> > I also recommend keeping it convenient to use.
> >> 
> >> Okay, you know C, please share your opinion what header is the best to hold the
> >> trace_printk.h to be included.
> >
> > What if we include it on Makefile level, similarly to how W=1 works?
> >
> >         make D=1 // trace_printk() is available
> >         make D=0 // trace_printk() is not available
> >         make     // trace_printk() is not available
> >
> > Where D stands for debugging.
> >
> > D=1 may be a default setting if you prefer, but the most important is
> > that every compilation unit will have an access to debugging without
> > polluting core headers.
> 
> You do realize this means recompiling everything when adding D=1 for
> debugging?

Yes sir I do.

It would be as simple (or hard) as building another arch:

        make O=../build/linux-arm64
        make O=../build/linux-x86_64
        make D=1 W=1 O=../build/linux-x86_64-dev

If you're both developer and CI engineer in your company, you're likely
already doing something like that. If you're CI-only, there're no
changes for you. If you're a developer - yeah, you'd have to learn a
new flag.

The real problem of course is the status inflation. The fact that
defconfig enables CONFIG_EXPERT and CONFIG_DEBUG_KERNEL implies that
every random person who is able to do:

        git clone && make && sudo make install

now assumed an expert kernel user and active developer. It is not
correct, and it leads to bloating kernel with dev-only features.

What we discuss here is a new marker for those real experts and
developers, I think. (In an hope that it will inflate not very fast.)

Thanks,
Yury
