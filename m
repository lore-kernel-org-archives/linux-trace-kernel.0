Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49F388394
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675938; cv=pass; b=TVRIMsqca6m4URBGgTqI5RRoPP6hJb0ExVM2wKMnW6ZMbugDzBUICifd5uwML7Ew5roJ2dhMftoCf3w4/3Md33mBmNI5IdWomqDqW3K8fMh/8/JNtRE6ft/LBZBg2lhoOiK9H2DHmfrP3Pn7a1FyqcA8hD+PIXQnG+FH480FmDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675938; c=relaxed/simple;
	bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTknDs0Dt+Y/7E1MPQO9QqaSO5izFRuOBDKBsFRs1aRIU88Nfeh1vyTdIeePe7HEX4ZzsbIbSdFQNOPPcXPZjI/v7NNL2ib92537d+JHk8uKJsFdXFvPaIsU/Q73feoCac//RjhMMETqKpFyfYo7Dx0rhUSj3wGe3mld5EUhcI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrMf+8Ql; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrMf+8Ql"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc16c6dcae2so4616440a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787675936; cv=none;
        d=google.com; s=arc-20260327;
        b=LLsQixCDogITiy+ABM9SDxrPg8gxOfqh4jX1gBju9b2FMB+vJapE6m/SDex71oPc1X
         G+aWTpPuXVcYjbKW4ufNlef8PDlwWQFFyD7C80hJcGLVMItWEeF6BT4NFH++vhcIK/hW
         FD6s8Wjm5SZvdqHMMQXKgyXXioTHqWFIOZM2MQgCh99+OU+Vzl7EKNkbcnrE493H6mH+
         Zuc3if3v+6ME8m1kv0FNkQjmgpKuISt72a/ERtrgvspsQH+o8Zmb1g1f2N2dCaI1OZj4
         BWu3VHdb0iwGUs79R/UivA1NYbR7TfHMDUMqPSos4IPqzv1l0vJ0jCHodSY+Zr360Imi
         jHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
        fh=HQicOyL44LCqB9RBKPPQTh2hg7Pvc0gcnNJxne06yEw=;
        b=JptM8sGShOikaFskF0ZpAgLWNL9xk1/2whBjZ/U2gqwRjjWRA+omIEcaosCVxy+j0K
         r95IVWAK1Wlpj7dP3/7J4ROZWMKkqaZprn2t4Xr47nRip11V0+EOhHLb8mzsAuitkZEq
         49D4vhc/Ydq210cayEppPEp+XVkV38SsYvNzZujAnX8EzaqFr6Su58PWnyOJcB1+psBQ
         Wu6coWJ7Pzs+dXBb1rwxIzNZhNLrU6DDgRcjFC4TQ2YrXaRgJeGouGBfAJ/ZcejDOQws
         n1Y+0FvZNXBvP0c+Z77LlK2djqWoS6q2nAcMEeh7xJ7X+fXDAxs0K7cXKZ4ABS1zeMzB
         9yQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787675936; x=1788280736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
        b=VrMf+8Qlta+IekxL+624dtrWIpBWdagykY1PdndSNl/tbEsJbJkmWcOum5uUNZV/0L
         YrpEbYYuiXz7c0RXKdw61ybsWtqfJhC7xEpaULvnhTjC7iXTIblm/6B3s0CxVaVFnPIb
         eVoPvfw6RnfRcDtwbu10nkXvJcifBvSEaDjloLpwEgtukSWWuDXazK2cuXkN4HMFsoag
         wBA5A3EniZtN4PIVKAS0b0v9t6w7cbk5lpRK6q/64TcCF4o/bCVt7Ehcynnh+5tEQN9D
         dBceOzZSDoC52tA3GAz+xpxSh+DREu8rDag8eZ80uT6zM3QUt29NuZ0SaexTd0Ja7n+l
         QjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787675936; x=1788280736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
        b=QImnkdk+K+/BtZf29W/nvm6cUKWjcK4OnMKQJv2MZQpOGSLH4aB71mbZNKHY2aT4lQ
         y2MvRSrTtPBS1Z/uCw89A7DhHDXYaNnyoshiS/RIx8C41RM5osKn2Vfps/TICzkoE8Xn
         9Dbfhy3xYUlNqLIZRgW4rAR9plh71kDVdT3f56qwpknIL8dWcqKJJKOB/xvREKwvnf+p
         HEoVpgETZz0X6g8fhfLaDbeyUKRDZCVEnOGAmbd4sphhQNwg+PCa3vIKDAw+M3ZGK0VJ
         tCu5b9zq0ftNG/Uf0kuh0G4SYvla9YMFPz19pWh4+2ETwJKn47DnBAGnIvpu6xM65j6X
         7EMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQB8jglweG4Yf9JvoZG5dmUXoHK0OqjnNGec5eXLpHiQVTyTWgYm/O1W+GbBRPbzuHui9F6GbP6fdTnTeQgxRPdx4=@vger.kernel.org
X-Gm-Message-State: AFuF++lg6ZVf6804PIS6Prh4HjE+Ye9WPYWV3lLZ+1PvI67czZr95GFy
	HQIeT7361yVFB9IQoaLONydI8fxB0rtL7tgQgNPtr4sEimCJqZ0DczWy+96Y5wY5SAoCSSTNkon
	ZJnC5ennGvAFIXDK+kkdXObc1vXyz4WE=
X-Gm-Gg: AR+sD10E4h+lJHjAGYKXda4HMq0L/d+n0/rjZ9BUM4CjBQE7b8RbS4iI1+a8HEZ1Je+
	+nInIG0oaLDGoQAhC6g41ZeDk4FCXOo3gXjbtQPCs+DL4TfDx1TXK/+7V4ucNddGHgV42I/TxIt
	52EUgDYeVxVGC2+394Q3McHNQnqR0LOMX5WiOaSIDj1xnI7s5N8aBvt5YkOdZxb5A8wPWK7sCmD
	ugN/Vn6ndFRCxlfMuK+mk+eFdY46J9OEFkIFgsNyplyzNRhZFXeI/de353BK8arWtG8g7Hw3uqZ
	TBNTk6Y1Qo3x9Rs4x1uiq/NOcr+oGU0Rd3xiGdMYzLVoqwTatnPQLu/RY87XYlzoL3Qb3fakIQr
	i4xP8hu6bBKLdugySd5hKHOwyZKWGAmirDkqqaLa+2g==
X-Received: by 2002:a05:6a20:7288:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3cd3008a6f1mr59176985637.11.1787675935767; Tue, 25 Aug 2026
 09:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com> <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com> <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
 <ao2KDQuBMNtONu0K@redhat.com>
In-Reply-To: <ao2KDQuBMNtONu0K@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 09:38:40 -0700
X-Gm-Features: AcwNN1V0hdtX9Y28fQcJy3eV8oSlMMr7Yb44xedm3cg9kk5uXBgObg30_PxA8NM
Message-ID: <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:27=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/24, Andrii Nakryiko wrote:
> >
> > On Mon, Aug 24, 2026 at 8:57=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > force_exit_sig(SIGILL) can't be ignored too. But I am fine either way=
.
> >
> > Current SIGILL sending is already pretty bad behavior that bites us
> > periodically, instead of doubling down on killing the user space
> > process because something about installing uprobe goes wrong, let's
> > think about a bit less destructive way to do this. Mark uprobe for a
> > particular process as defunct or "detaching it", or something along
> > those lines. But not just kill innocent processes.
>
> Well. Yes, SIGILL sending acts as BUG_ON(), this is not nice and

The problem is that this is actually not a bug but a very real and
expected behavior with user-space using fibers or coroutines. Any
suggestions how we can make this less violent, as it's actually quite
dangerous and kills production applications when someone (unknowingly)
tries to uretprobe trace them...

> probably we can improve the current code. And, just in case, as for
> uprobe_copy_process() in particular I agree that Option B (make fork()
> fail) is better.
>
> But what, say, uprobe_handle_trampoline() can do if ->return_instances
> is NULL? Either we have a kernel bug, or the probed task does something
> wrong. In both cases it is better to kill the task with pr_warn() and
> generate the core dump.

I don't remember all the code paths, but just shooting in the dark
there, we can always poison a pointer to distinguish or something? or
just assume kernel bugs do not happen and ignore NULL. Or something
along those lines.

>
> Oleg.
>
