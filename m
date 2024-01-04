Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71922C19E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C1xjz52e"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55590da560dso1039672a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704396099; x=1705000899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4MuqzTE/G+T5VrqGABwUELReNnh9TwctX30WQtzQOw=;
        b=C1xjz52eJhbjUixHm1865DYgZpRlA8H6zVoDLm32EH8jZBo/+TKu0gdqavuYYOhlFa
         paR7cB05JsJxOJyVIi+20LcihGezJ57KY0zwmxbJoGLWc2FFzBcfZ9JSXkjmdQ22sPCQ
         S02A2Izds5Pa8nXSRwun2lWJ2aOtAGMeNhshw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396099; x=1705000899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4MuqzTE/G+T5VrqGABwUELReNnh9TwctX30WQtzQOw=;
        b=hQyzaen1G6c7xGqfO9bN6d4jdKMHa9uxBkLfUKFqCNKH+90kcOzNmaLGERCXGyXibh
         6kOx8oxJWqnsSOzk1Jice8u3D+IMd4QHVVVIzZEzSSmiYUxFrHFdFfzsX2/Gw4yfjYPJ
         UgametqANR6I9+L104pzKd3SIO04wU2H22b83GaQVbuJ0hVRAEnPBuiuuxun5c2WNCZT
         wwl2TNnJPo3gBw1Hho6rHc/mkINVfrGpNCwou8In17UJ+gQntGDH/AMhbWs6aEoSQUWT
         9CaU57sbR1g29MlfQMZi1QtLf2xeeHSK92p6igXiiwCsgaWAwvgq3wwzpGBCbHdTfSa5
         h9Uw==
X-Gm-Message-State: AOJu0Yzn3h+BaR6OT31rgRQNyXTmPaHcS1tOKjYAi159QBpt77ni+Pdr
	0Ioa45YDUyRRP2LU1e/DZMYscdehadajJL9x47zB0P6dS4yyQ3HA
X-Google-Smtp-Source: AGHT+IEfD3kYwtKDldDRB1SZgsNWZPJ8XxeBJkMllZ29+lJaV5az1naVLsXH2cbjjeLZ3Gosc5CAsw==
X-Received: by 2002:a17:906:719:b0:a1b:714f:c59d with SMTP id y25-20020a170906071900b00a1b714fc59dmr416769ejb.30.1704396099110;
        Thu, 04 Jan 2024 11:21:39 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906164200b00a269e651abesm14388711ejd.176.2024.01.04.11.21.37
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:21:38 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a287be6dbc0so100327266b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:21:37 -0800 (PST)
X-Received: by 2002:a17:906:ee86:b0:a28:fb5:4389 with SMTP id
 wt6-20020a170906ee8600b00a280fb54389mr705009ejb.0.1704396097273; Thu, 04 Jan
 2024 11:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103203246.115732ec@gandalf.local.home> <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home> <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home> <20240104182502.GR1674809@ZenIV> <20240104141017.4cd8451f@gandalf.local.home>
In-Reply-To: <20240104141017.4cd8451f@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 11:21:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLTq-aj2bN_B7-0h2NYdkVxkbkmiOKKer=n0x6pPO77A@mail.gmail.com>
Message-ID: <CAHk-=wiLTq-aj2bN_B7-0h2NYdkVxkbkmiOKKer=n0x6pPO77A@mail.gmail.com>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> My mistake was thinking that the dentry was attached more to the path than
> the inode. But that doesn't seem to be the case. I wasn't sure if there was
> a way to get to a dentry from the inode.

Yeah, so dentry->inode and path->dentry are one-way translations,
because the other way can have multiple different cases.

IOW, a path will specify *one* dentry, and a dentry will specily *one*
inode, but one inode can be associated with multiple dentries, and
there may be other undiscovered dentries that *would* point to it but
aren't even cached right now.

And a single dentry can be part of multiple paths, thanks to bind mounts.

The "inode->i_dentry" list is *not* a way to look up all dentries,
because - as mentioned - there may be potential other paths (and thus
other dentries) that lead to the same inode that just haven't been
looked up yet (or that have already been aged out of the cache).

Of course any *particular* filesystem may not have hard links (so one
inode has only one possible dentry), and you may not have bind mounts,
and it might be one of the virtual filesystems where everything is
always in memory, so none of the above problems are guaranteed to be
the case in any *particular* situation.

But it's all part of why the dcache is actually really subtle. It's
not just the RCU lookup rules and the specialized locking (both
reflock and the rather complicated rules about d_lock ordering), it's
also that whole "yeah, the filesystem only sees a 'dentry', but
because of bind mounts the vfs layer actually does things internally
in terms of 'struct path' in order to be able to then show that single
fiolesystem in multiple places".

Etc etc.

There's a reason Al Viro ends up owning the dcache. Nobody else can
wrap their tiny little minds around it all.

               Linus
