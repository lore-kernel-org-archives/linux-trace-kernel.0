Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095E1EB29
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TXpigq1f"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-556c60c3f9aso1442327a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704320067; x=1704924867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9MZB2GKQQoVizz0Mae9gZ/uAOfWAVjDPrCIYZs+35rM=;
        b=TXpigq1fP06iV+K9Vz/jiCG8snCJB+ToJQy6mkZNLYt8SH+to9rdIa6UHpeQyYA0xL
         Of/1GWWsq9TcwpbvGyUJC/DDootYQzVqFaPqp7/QEQegurNXtkyc+uBgycRJTixATrrG
         VTEoWOu4KetX4yBFlgS5LJC9Rj7pkpnH4EMjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320067; x=1704924867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MZB2GKQQoVizz0Mae9gZ/uAOfWAVjDPrCIYZs+35rM=;
        b=c+tLH3+10hRa95dQlHWDY851rmizRbGrDh6gNchjAWCJwaQq1V4KfsdgPgs9s6LSL5
         fWQWLHPvgGKf3EI0jbwxmVN8ClLzeBuK4vybWN5aUcldIBk9wCfN6tHFxfjSZpwSH9nQ
         QYMCyIUCkebp+lRHvudFN+Ys/c1Uo6bGrE0VRt73/Onu7KquPGkY2YGg9O4gpGjEhMCQ
         R6daEN8OyXSCBMDKtv9krZnSbYJhGAegqaYMx8SpmAF0m/rcUy0KUumrQU9Y3w+wKNon
         D9m2NIjvdxT9DuEnOgAkgWjrTrM9Z6H5TwXChVXa9Ndjal/NVHiMt8SVNMgE1uiGnKS/
         nNtg==
X-Gm-Message-State: AOJu0YwGP0Y8V9xDdKHYZ1UU7ANh+te/hyfarCwUJ+8vx4EV6pMVRfmG
	kfWrcVv7+s+gwYfqyUvh+eQOku+OejvV8freyZFozlCe7nRyTXZ8
X-Google-Smtp-Source: AGHT+IHDc3qwE5idIvEoMLIUmHK3BcBCpAgBtO0CYGNhpeZBKdK2O06H8ZdF1pIviYtqhRY344UoDg==
X-Received: by 2002:a17:906:f6da:b0:a28:d154:3754 with SMTP id jo26-20020a170906f6da00b00a28d1543754mr65139ejb.130.1704320067252;
        Wed, 03 Jan 2024 14:14:27 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b00a26e490e3f2sm9947255ejp.181.2024.01.03.14.14.26
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:14:26 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-556fc91aba9so73795a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:14:26 -0800 (PST)
X-Received: by 2002:a17:906:6854:b0:a27:9029:4657 with SMTP id
 a20-20020a170906685400b00a2790294657mr3946525ejs.125.1704320065698; Wed, 03
 Jan 2024 14:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com> <20240103170556.28df7163@gandalf.local.home>
In-Reply-To: <20240103170556.28df7163@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:14:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWbqy-hd-Xo6dwx=6dH+gMyvf_wFtih7eEpBkHyigzJA@mail.gmail.com>
Message-ID: <CAHk-=wiWbqy-hd-Xo6dwx=6dH+gMyvf_wFtih7eEpBkHyigzJA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I actually have something almost working too. Here's the WIP. It only works
> for tracefs, and now eventfs needs to be updated as the "events" directory
> no longer has the right ownership. So I need a way to link the eventfs
> entries to use the tracefs default conditionally.

Ack. So the ->getattr() and ->permission() thing is a bit more
targeted to "look at modes", and is probably better just for that
reason.

Doing it in d_revalidate() is a bit hacky, and impacts path lookup a
bit even when not necessary. But it's still a lot less evil than
walking the dentry tree manually.

So that d_revalidate() patch was more of a "I think you can make it
smaller by just hooking in at this layer"). So d_revalidate ends up
with a smaller patch, I think, but it has the problem that now you
*have* to be able to deal with things in RCU context.

In contrast, doing it in ->getattr() and ->permission() ends up
meaning you can use sleeping locks etc if you need to serialize, for
example. So it's a bit more specific to the whole issue of "deal with
modes and owndership", but it is *also* a bit more flexible in how you
can then do it.

Anyway, your patch looks fine from a quick scan.

                  Linus
