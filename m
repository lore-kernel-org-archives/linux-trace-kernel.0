Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745895915C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605948; cv=none; b=NcUXBjI3dL4c+nj4CrSDuAAGoVrx9pdSgEIN/iF7nfqLbaxd+K4UtROy1G/KSR4sAdh8+JC7SQH9V2JG+Jovf4fpgZhVg4fTqCGopF+4Vz91iRBRCVjgvbOXNtOcKNf/xYR17hMFeGurv3cYKDiOh5Tl6hgfHYwlEMhPnZBcqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605948; c=relaxed/simple;
	bh=2DIY+lL0JwPloAko6mVPmoNJ4C898Ios+yVnwFsSQws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMlb4aWGPUKaXXU8cDizE9gT+FeaTxI8RrLjveneey8evLD174LU9T5NNVL0AOvLsFPYq+JiiduzrpuMRQio/M/Qs8LvFG+XFKNt+JmVceyHN1yS4ZDoUPTBU2ZL/B6EGcHPACMcsjveE1THNe5KTmM3b70ez+Om80tPULTuHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QKOG1Tq9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QKOG1Tq9"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55ee9805da7so2647808a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706605944; x=1707210744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ62OXvXVngPLK5bvC/N3snsj6IMt9f3ZjXYsKK3MQk=;
        b=QKOG1Tq9+hXRzKv8cisDBTgJOZep5Kx4opUjVxcLN2EEyXXBkziOLDGl697wld3zAZ
         JINU6VShz0wuVKi8rC8pmEDMdMRUtpqN+lANGKtvcheXcpD6zEqgsGstUl7MMHuVHM0v
         L+I5yHEZn9oMvSRjTVkHFO0ANpqYEAWQTYcs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605944; x=1707210744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJ62OXvXVngPLK5bvC/N3snsj6IMt9f3ZjXYsKK3MQk=;
        b=tqOOV1carwRR3WE5Mw3euwZc84zEQ4AN9WsSXESbtc4vYARw/u6ujsRO20eoWw+dkU
         4Fxi4b4BJ01NaiIQXTL8XP8jQV/w0aMdk+Y/Oo/Ct8HuH3f+jgDl8rcEu9aEo551hcmZ
         +px+sYQOVqprU2tCp2ekGMZo53bV8ozQ1kFuwegeCGYvdX/8akkOR8uz16X1XHf1qEg+
         xHOrmO+dC2yQmXj2I60EM9TaJ+8cXR8q6gpyI1DDbHK/iXRI6H4zrsleIE9p881sX76C
         yZ/TzRevymACr/e1bjlDFdyVmIzbrvdXaLKBZw3gsxQr5N7wMYDQUAMUSneiXJUl+uXF
         FEmA==
X-Gm-Message-State: AOJu0YwZBdxjqDsHeWq/wsLmTyG7E9V8GrXroJvbl1GQyjCo5iV48U6H
	jDgSA3rvXNMdtrznUjqUTLnEQ1ktU4ZYyrnUP28FjIGHUtAH6RLOvgQhhbTBGR2qAWQtBVKFsQq
	vcagEcQ==
X-Google-Smtp-Source: AGHT+IHbEqfS3Epv5z+QsruHblsh0KkNS/VW/irQQqa2SomNO9ax3vibsnE/aP/aLwfzLtH6q+ai8w==
X-Received: by 2002:a17:906:f14f:b0:a35:f054:7589 with SMTP id gw15-20020a170906f14f00b00a35f0547589mr2454216ejb.10.1706605943738;
        Tue, 30 Jan 2024 01:12:23 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a355a34f1f3sm3414945ejn.225.2024.01.30.01.12.22
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:12:23 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so4704476a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:12:22 -0800 (PST)
X-Received: by 2002:a05:6402:1910:b0:55e:f740:4f39 with SMTP id
 e16-20020a056402191000b0055ef7404f39mr4388911edz.22.1706605941604; Tue, 30
 Jan 2024 01:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com> <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
In-Reply-To: <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 01:12:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
Message-ID: <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 00:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll go back to bed, but I think the fix is something trivial like this:

Almost.

>   +     result = ERR_PTR(ENOENT);

That needs a '-' in front of the ENOENT, otherwise you have a positive
error number and things go wrong very quickly.

And that does indeed fix the lookup problem, but you end up with the
same problem later when you do the eventfs_remove_dir(). Again the
eventfs data structure changes, but we don't have a reliable dentry
that we can invalidate.

The dentry cache is just very good at caching those old dentries, and
the interface for eventfs_create_dir() and eventfs_remove_dir() is
just not great.

If those did an actual path lookup (like eventfs_create_events_dir()
does), we'd have the dentry, and it's trivial to get from dentry to
eventfs_inode.

But going the other way is the broken thing because of how the
dentries are just temporary caches.

I suspect the solution is to make eventfs_create_dir() do the same as
the events directory case does, and actually pin the directory dentry
and save it off.

Oh well. At least I understand what the problem is. Now I'm going to
try to go back to sleep.

              Linus
