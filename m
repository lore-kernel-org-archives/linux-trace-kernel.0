Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692F1494B3
	for <linux-trace-kernel@vger.kernel.org>; Sat,  1 Feb 2025 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738452974; cv=none; b=lf96n1xTbomB1u1IHUXq5XIKp/gh28Z1dEQtnnDIOTyZWgKvUYqIJKejqYvcPsLwqH4GAhjkjgc3ztXLWwh1HCRHhP8IdN2xlRlziCqHgoQIxjWPidocPOnSciLTifS5zaxwwhNovRGdW17lkRiJYtLrrUQWKvpgz3mb/v48RO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738452974; c=relaxed/simple;
	bh=hQwwtbzsmJHmXEHRTMgu1nJ554PuDLcjoSBNYNXXDUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyNspOXf55/0HVprRPCnEDmISxiIe321h4lVBdzAXOE+lNVmgZYtvYlQaaFIgA/aTJkiqiCS3blE20UpC3jnELGihrFl5/vK+3zLR8u2COtPYmjcMbe7wjCsjSWDklbvL9DyZQ495xYhyeVenWvwg1s1LIcN/lOpA0cOJ6+yHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ExzqjuBh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ExzqjuBh"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab70043cd05so396717566b.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 01 Feb 2025 15:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738452971; x=1739057771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zrQs40ypKKdRXf6GVxA0OdtSUwZLc77p2H2fv4z8Urw=;
        b=ExzqjuBh9PQ38U5v78vUIzum+Z6w6+fMq0skhpG6Wv0cx6QVqaR6cly4UsyakwcIGJ
         NgiaBFOenQo6ZXw0Us2uldpui2p9N6IPbt71MMXwRzgNLkdkPKvaDz2MkY4GA5FwOO6Q
         7bxQGei1nEzqrcy1KgrS7o9NV16F/6qRjbXWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738452971; x=1739057771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrQs40ypKKdRXf6GVxA0OdtSUwZLc77p2H2fv4z8Urw=;
        b=l+F9S3ZI3pMt2DfEDuKM5f8H1VFVck7NZhp11WLdmi4/i1V3mnWVuNv8SvmGxEiM0n
         E7Rh0zB7RLItuuMtHiHu8SqQoXNSCy1UvqEDaH9Q2t0M3nBOkFB7JxSDHEofM4rv+zUh
         6jV0N8c9rpO9wzlNDu4kUsne6HtDEvCfYThIYEso+J8foyGeTgUZfPBke36HNvJFT9RV
         sGNkfqDznyd016R8MoOOEqGolOna/12LO9r1ac4vjCnL/E32mtw4qmD07eIc21yrvSdl
         3ztBsPsLw31A241z6+3b9t2qF5HfhTKsPWuqpxDncnsZ1WYE3pXnZqqVlYeDNStSz0xN
         ZzFw==
X-Forwarded-Encrypted: i=1; AJvYcCWDjwE2JKPtDo7BWBVkOJv4lE41y3Vd+GYkH2LY1TQQh4pQrGCsooEAybYkHREiDvhW6m7yGNo2H66NWH0cUjZzy8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJOFPw0fF0GUg/smkkjljSOZ178+5HncLCmO7AylIB1gzoEUL
	vENgGbNU6ViQWWSQpBH8W66UBQqVN/klf1xLQW3ZB4N8cr8LwnnuoRmEL8vdlp1LEAKwYGhGE1v
	JRWM=
X-Gm-Gg: ASbGnculSdyBdkDRHWgHqMtnbqU6/6YpUqm9KdbGULoUNjpemQCRmSTfGGDxr35WvHr
	HXZpSDSUPXd5JZgCZPilCLIWgFBiLKZTbZs5w3UK/S3hvW/Kmj0KB4g5DN94CH9KJroR8jQTKK8
	LuKyNhQPax4T8YIy0/Rbkjd4YOx8gx/x4nILRcj7zTHGYH5vxJf3Q0unyTllAoSQqhM3+UIZcSM
	CLsoUz/w7LkAWr7FNAakmBspgyPo6e6uLaIfGcOfEdpuDN47qFpUKpa45sn4ZzeJZZbbNRbWexf
	Mv92OXa4o0CsO82TWbKYRSek/+t9OrvYKWZK83KZTGxMFUnSdPHmq6dOIuepQY3z1w==
X-Google-Smtp-Source: AGHT+IHPfxNlPSMIE79gQ3UpnwTm9xv2CyHiw0rWbjUU620VTAhPbth0or6/jtLU+mYJtAaHSfZt2w==
X-Received: by 2002:a17:907:96a5:b0:aa6:9198:75a2 with SMTP id a640c23a62f3a-ab6cfe12cbbmr1509097566b.44.1738452970777;
        Sat, 01 Feb 2025 15:36:10 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7b1asm495837166b.31.2025.02.01.15.36.09
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 15:36:09 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so4892552a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 01 Feb 2025 15:36:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk/I6SoNQ7nlDgqdoal8u6R/EC1vvOl+5FwApfS+OKhOLzYTX19dZ2LoemysHKF6DYGmoe3SICrE4pS1VT+3fKiK0=@vger.kernel.org
X-Received: by 2002:a05:6402:909:b0:5d9:f9b8:e7fb with SMTP id
 4fb4d7f45d1cf-5dc5efe74cdmr17656373a12.22.1738452969323; Sat, 01 Feb 2025
 15:36:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131225837.972218232@goodmis.org> <20250131225942.365475324@goodmis.org>
 <e83ce086-b55f-431a-a499-f83a434b70db@efficios.com> <20250201180810.1faf4906@batman.local.home>
 <CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Feb 2025 15:35:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVzwPwiQj5PdmZXA8G=9ZS2T-OUPm4VrM8TKTDQW3Dmw@mail.gmail.com>
X-Gm-Features: AWEUYZnL7HWDqqscez1fIJLpsSsGzS2Qj9VepL3JpazWidbVl6o5BaS06DFvaNM
Message-ID: <CAHk-=whVzwPwiQj5PdmZXA8G=9ZS2T-OUPm4VrM8TKTDQW3Dmw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org, 
	x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de, 
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de, 
	daniel.wagner@suse.com, joseph.salisbury@oracle.com, broonie@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 15:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But you *also* are literally telling the scheduler to put you at the
> back of the queue, despite the fact that maybe you are still in line
> to be run for *your* priority level. So now your performance will
> absolutely suck, because you just told the scheduler that you are not
> important, and other processes in your priority level should get
> priority.

Side note: we've messed with this before, exactly because people have
been confused about this before.

I have this dim memory of us having at one point decided to actively
ignore that "put me last" part of sched_yield because we had huge
performance problems with people misusing "sched_yield()".

I didn't actually check what current active schedulers do.  I would
not be in the least surprised if different schedulers end up having
very different behavior (particularly any RT scheduler).

But the moral of the story ends up being the same: don't use yield()
unless you are on some embedded platform and know exactly what the
scheduling pattern is - or if you really want to say "I don't want to
run now, do *anything* else, my performance doesn't matter".

A traditional (reasonable) situation might be "I started another task
or thread, I need for it to run first and initialized things, I'm
polling for that to be done but I don't want to busy-loop if there is
real work to be done".

Where it really is a complete hack: "my performance doesn't matter
because it's a one-time startup thing, and I couldn't be arsed to have
real locking".

In fact, the whole "I couldn't be arsed" is basically the tag-line for
"yield()". Maybe we should rename the system call.

             Linus
