Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AFF1CF92
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Haitd8b8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28ab7ae504so75492566b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704311853; x=1704916653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHOZq6HPvj4dG+d7G6FK1Ss+OGlgrauAKkpyntxQ1Jk=;
        b=Haitd8b831Jfe2uySpovfluMz4EAlG4YY0ENDnWQ7zMBRnMcKwlyls4SlJxLpIOeWk
         fbuoJPanij6bhpksOSzlWLA8WATelOhq4LFxcmVbelsTqlIqQfDtjCbkgNoGCseMoP6i
         DBJul1V3U2i9bkzm2zYFDgM7xNhWsmn83LVo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311853; x=1704916653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHOZq6HPvj4dG+d7G6FK1Ss+OGlgrauAKkpyntxQ1Jk=;
        b=gDw5Xhy+TBaRQr70tbl9fe/r9l79IvjVbHgKxZ0mt5vmIJRztanWn1WTzEZUyE6VvP
         NRxPLwsmeTRg0v/T5Kb8t68eQjsvNG0JyqVm6rg1iOXXBzoS1+VKNSnwuFQse9XO36Ks
         1hyb6g0BHUcae0duQFlw070h5ynZETVA3hjWrHIur8CBnEj0+TEwZzBPkWsqlv7EanGr
         KE1+YRVxKlzv6lhmQ7wnqC1u9kAnxmCcPzwqc9o1jV8brSzWt2utqNRwtEj1g3ZVILbh
         Ak9gk+CU9tAwVG1qHLj+5IXR/X0Z5xPWf7ItCvfySOEkUZr/f17bX79zqhwV60r3XZLu
         GoEQ==
X-Gm-Message-State: AOJu0YyMg9+2SsvWanc3xHSer4N3EWrjXce+h5HLcvIz0hKzTblUpupW
	WV3dYnubxuNu24QX9qYCPDpvZChw8xeplyWbyP773muDfwR0CgOw
X-Google-Smtp-Source: AGHT+IE6Rz9p+doaJ8Y9osy3PxmsmL/1qkmZi8jJKpa1t7ff395QWhuJ6zRR+E83mwyHfr6wjDbQ8w==
X-Received: by 2002:a17:907:2cc9:b0:a28:a8dc:67a8 with SMTP id hg9-20020a1709072cc900b00a28a8dc67a8mr537776ejc.89.1704311853286;
        Wed, 03 Jan 2024 11:57:33 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id l2-20020a170907914200b00a269b4692a9sm13112314ejs.84.2024.01.03.11.57.31
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:57:31 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a27e323fdd3so298241466b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:57:31 -0800 (PST)
X-Received: by 2002:a17:906:df13:b0:a28:34e5:b60a with SMTP id
 ie19-20020a170906df1300b00a2834e5b60amr1188633ejc.14.1704311851332; Wed, 03
 Jan 2024 11:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com> <20240103145306.51f8a4cd@gandalf.local.home>
In-Reply-To: <20240103145306.51f8a4cd@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:57:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
Message-ID: <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 11:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This doesn't work because for tracefs (not eventfs) the dentries are
> created at boot up and before the file system is mounted. This means you
> can't even set a gid in /etc/fstab. This will cause a regression.

Which is why I suggested

   "I think the whole thing was triggered by commit 49d67e445742, and
    maybe the fix is to just revert that commit"

there was never any coherent reason for that commit, since the
permissions are dealt with at the mount point.

So this all was triggered by that original change that makes little
sense. The fact that you then apparently changed other things
afterwards too might need fixing.

Or, you know, you could do what I've told you to do at least TEN TIMES
already, which is to not mess with any of this, and just implement the
'->permission()' callback (and getattr() to just make 'ls' look sane
too, rather than silently saying "we'll act as if gid is set right,
but not show it").

Why do you keep bringing up things that I've told you solutions for many times?

                 Linus
