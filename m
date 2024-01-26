Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB6219EB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293888; cv=none; b=hEJgw0vdDFGGGaJr5Rqh9kbWR6HlVRa1Eloa4Hv/Zz2HKhN9T+ej5ypdIj6UHlQZvTg299nhg4fB4QpBjp3qvvuUHTPCgI+LVXoli8o2K0zRUup9GDzK0Uk7X1YtSjTqr62nuZvvk1OPNTLaC9K5WT1uqKk1DaqWP6MOralqIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293888; c=relaxed/simple;
	bh=W7B76i3+B9hYS0jCDzE1qW/RvQJCSXTVBuxx+AfGDdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7OjNW48lUZeXjEym4Evqzo+VK8gS0fQyluaw05U5x97WwPvG3oBP+mjgmOJrBKYtIUTOJZUMj0rY7DWr643yiYPmWsA1u5qAZSG50v6MklDe5Le+Zq/6an5QhqQlIcdsmEVw/Y5X92YT/U3jrnQ2Dk5i1PiEObFNTqSWpA7z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wx2A9qie; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wx2A9qie"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so6841081fa.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706293885; x=1706898685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdy4NXmtqUV6APWQzUWxFYpWUDUY5MY8BJqI1nPSu7g=;
        b=Wx2A9qieYIbSrzzcEStmTkov8NiyT7165kKVH7ip7ciWsRocp0fzGNISspD3qf1NKH
         hQRA6hLnrrf8rdBpzJWu19hewRfRfOidN6aBT1RQxpj4xTLVZ/X0nTmUrqYwlPMU0XKj
         lY7eTZ+yH2qp5ZnSQCEAMCZ9Z8kzTW3SEFKlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293885; x=1706898685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdy4NXmtqUV6APWQzUWxFYpWUDUY5MY8BJqI1nPSu7g=;
        b=u0E6wUQGB2f7Mnd9vZZSo+e3ISov/fHoRmRu7quAeZYl8vB6EKslcKi4Wruf1/SvX4
         VTEhpXeCvkoZUJml+Bjby+rtrbAlUvFc2f8MjHPfSNHxQTlt8eaV/THLrN1B6JYruEYQ
         /Zr0kynAgp1xBCzSrr6pi7crZkqoLh+QpzmQNNr+MWR8GXBv3HkyojAzdU779+TD6Tn3
         Rk7rYkYOnJdpbbrx7G0jSY/kDoJw4OBee5pS3ODycM+7bpNefYFJ5N5H7soREmzrVd5n
         +rxpVp/eKaPc4YvVR3+s7s/MdOENUBWV8fdAu6JmQuVe5JpMZCLMEhCv45/IlaWKL82g
         tFmA==
X-Gm-Message-State: AOJu0YzYd89bFUDi5fNqOPvOdNTjB6Ce4CGyGT9Yce8lKKYHcGDl2Xbn
	4hHcgV6Ti4u+yDlvSqDuIxHvLrj3feeNiCgcx+zyJjBUFkx7uTWskKITfoEVaXuT/A2kAJLejLv
	dlvc=
X-Google-Smtp-Source: AGHT+IESrO45tT37UGTCMHl6WMQ+kxn6zdGJENUZjoNWeWJ/1ppmLYKx5nr3jTa+ZjHKRfarGuSi+w==
X-Received: by 2002:a2e:a4cd:0:b0:2cd:278b:fe5f with SMTP id p13-20020a2ea4cd000000b002cd278bfe5fmr88588ljm.99.1706293884795;
        Fri, 26 Jan 2024 10:31:24 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z4-20020ac24184000000b00510195037ccsm245126lfh.282.2024.01.26.10.31.24
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:31:24 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf2b218c62so6589691fa.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:31:24 -0800 (PST)
X-Received: by 2002:a2e:be8a:0:b0:2cf:12a2:c1fa with SMTP id
 a10-20020a2ebe8a000000b002cf12a2c1famr96305ljr.215.1706293883810; Fri, 26 Jan
 2024 10:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126131837.36dbecc8@gandalf.local.home>
In-Reply-To: <20240126131837.36dbecc8@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 10:31:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
Message-ID: <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 10:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> By following what sysfs does, and give files a default size of PAGE_SIZE,
> it allows the tar to work. No event file is greater than PAGE_SIZE.

No, please. Just don't.

Nobody has asked for this, and nobody sane should use 'tar' on tracefs anyway.

It hasn't worked before, so saying "now you can use tar" is just a
*bad* idea. There is no upside, only downsides, with tar either (a)
not working at all on older kernels or (b) complaining about how the
size isn't reliable on newer ones.

So please. You should *NOT* look at "this makes tar work, albeit badly".

You should look at whether it improves REAL LOADS. And it doesn't. All
it does is add a hack for a bad idea. Leave it alone.

                   Linus
