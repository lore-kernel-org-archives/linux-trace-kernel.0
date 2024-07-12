Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA98173355;
	Fri, 12 Jul 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798181; cv=none; b=MAX3spxzefOmf3f+YfqiEMMywRApKgT/k+1n5Yuuln1k1tayoNU7bfiCk3n/gJ0RInWGqNqDuZgNRaGlrnF7NSgcUh4LZ+dHdUDa65XD+GbORZ2ad8176rNQfomAhtepGrUxxbrVv6XIaMwfJ34yKAJ+kUiWFmkyICOOetfbxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798181; c=relaxed/simple;
	bh=HPOa7SO7k3gMpMxm2fStIX1ktgAqbZGZTR/v8zwBfK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9R8hz6S46XFmE6Gx12WN/ubMRWRhWYKPsmvSRlETuv3QPO+rl4vlzTneQJTc3ZSgTxfVBQqbVW7xxou3mfYT2aHKqcpy01L70SiSRJCfQyDfrWoB//2G26Lc0+ezjd8/mqQGtGXVkWGvngiMYU4sDgKFkGwrUFP83Hyxwhk7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQPQ6hsD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQPQ6hsD"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so3499302e87.3;
        Fri, 12 Jul 2024 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720798178; x=1721402978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaX0XYEC7+5BC2mmjhTtFBMlwPorZ67nD0Jvqe+jk94=;
        b=bQPQ6hsDFJaf4nBVRyxVJtxdty5L4gwK9HqVuwLUFmL6quXMjD9E69jcLXD4/1MdII
         5evOqU+zZIOKZ2Ebiz+arK7IJsWR/lG8fS2b5tGIHhGAhWExEq4hy3oVnt/PY1Cef7EP
         pzenLabj56VxdJRUbh+oNmIW6fMLVBeaUDDpwcjR4GKufUs9Pd/qL4zDQsmjBwSU+1aI
         C8Q+UjH4c1Wjo3/EUfmm2T1flFBiUoClZxy2KlOp/mzpwLSgPEaD+oU/Hxf7NniSyMKK
         /4GTHEkz0pbo/qEFJiDHTVx2i8NCI8Ku0Qk8cB4A1dvfbyIULk1rtbss1B1At8XqqiA9
         6WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720798178; x=1721402978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaX0XYEC7+5BC2mmjhTtFBMlwPorZ67nD0Jvqe+jk94=;
        b=mhhaCgsYcfM/gKjcmuvU8uVDssbou+MIwE6JodOk13QLNWDGKzta/wXhs84u4zfrP5
         OrMVJvmMBMKS58PzbyFApQAM3enPXoBhJR4QOBmIu4gZeX8fkaG1vbXmvoehdBgs1pp9
         nkCyYf8jedldBupc/7yeIIXndvqFd/QkZ0zWjs4GMNbNh64j7MbUmAPCh2BNKzbtXdIU
         OMAiZGorvJsHGi8C1gT06j+LF8arnFTawdOZ+NELTVrlIOV/YLzcDiH7PZBnIwuZoXoe
         wexTh7Jd+gvJL4viK17R4oZKG5EizxGQLv8IhL7N5DGLm0Hz467RDf/foooZ7IekgrHn
         c+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdME+dB9P5XmcUfjYMSvz+GuzM1Q98wUnYip+9Esho2xg66FlkgdDyg48Lspm1ID8aMkKR7T/9iyJjLE6JYKn5mbGcHbzxI+VjdS4zMutJwuSwM+JX+/HLttYEALXXG/lYlmpV6OgK+/WJrI3R3qy
X-Gm-Message-State: AOJu0Yw5PiMOKDd2bd+wjkmCTnXWvj+zhTCm+GZNtNbH0lS497SWOQX2
	XW9bjNxmUUMnQZmxX4GIthAtwE3pGgJri1qZp3eNVkKJpT6lqLJq/t6AHkVMINaCjdg2OIUPcLE
	rqrOrsjVAxDmU5gNbi1+mwUf37Ag=
X-Google-Smtp-Source: AGHT+IGCLqcRVIjkEweK3/aJoRkXomVZUL7NSVyAYSUancplZJbd0v8xwYtl00L4HXyB8SfTVbQss29eUX0O33rWZDQ=
X-Received: by 2002:a05:6512:2349:b0:52c:a20e:4da4 with SMTP id
 2adb3069b0e04-52eb99d6033mr11893379e87.57.1720798178042; Fri, 12 Jul 2024
 08:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
 <20240712131016.GI27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240712131016.GI27299@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 08:29:21 -0700
Message-ID: <CAEf4BzZqKCR-EQz6LTi-YvFY4RnYb_NnQXtwgZCv6aUo7gjkHg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 6:10=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jul 11, 2024 at 09:57:44PM -0700, Andrii Nakryiko wrote:
>
> > Anyways, if you'd like to use it, it's at [0]. All you should need to
> > build and run it is:
> >
> >   $ cd examples/c
> >   $ make -j$(nproc) uprobe-stress
> >   $ sudo ./uprobe-stress -tN -aM -mP -fR
>
> >   [0] https://github.com/libbpf/libbpf-bootstrap/commit/2f88cef90f9728e=
c8c7bee7bd48fdbcf197806c3
>
> So, I cannot clone that [0] URL I had to click around github shite for a
> while to figure out wtf to clone and where your commit lives, turns out
> it is:

Sorry, my bad, it's just "normal" Github stuff, but yes, I also find
it quite confusing, so should have been more explicit that this is
uprobe-stress branch in libbpf/libbpf-bootstrap Github repo.

>
>         $ git clone https://github.com/libbpf/libbpf-bootstrap.git
>         $ cd libbpf-bootstrap
>         $ git checkout uprobe-stress

Yes, sorry, as I said, I should have been more thorough in my
instructions. You did a great job figuring all the above out, the next
step is to make sure all the git submodules are checked out, so, in
addition to the above you are just missing git submodule
initialization:

$ git submodule update --init --recursive
$ cd examples/c
$ make -j%(nproc) uprobe-stress

NOTE: Don't run just `make`, because it will build all the examples,
which have extra dependencies, and we don't want to go over that with
you :) Stick to `make uprobe-stress` to build just an uprobe-stress
binary.

The only extra thing that you might need (if you don't have that
already on your build machine) is development versions of libelf and
zlib, as dependencies of libbpf (that would be elfutils-libelf-devel
and zlib-devel packages in Fedora, I think). libbpf-bootstrap is
trying to be as self-contained and dependency free as possible (which
is also why git submodules).

You were worried about BTF. This tool doesn't need BTF and it should
work without it enabled in kernel config (but if you do want BTF
generation to succeed, I think the only kernel build requirement for
that is up-to-date pahole from dwarves package).

As for the kernel config, I don't think you need anything BPF-specific beyo=
nd:

CONFIG_BPF=3Dy
CONFIG_BPF_EVENTS=3Dy
CONFIG_BPF_SYSCALL=3Dy

But just in case, we maintain a list of kernel configuration that *all
of BPF selftests* require (see [0]), so worst case just append that to
your config (but really, above three is probably all you need,
assuming you have all the non-BPF perf/tracing/uprobe configs
enabled).

  [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests=
/bpf/config

>
> But then I do the above and I'm greeted with:
>
> root@ivb-ep:/usr/src/libbpf-bootstrap/examples/c# make -j40
>   MKDIR    .output
>   MKDIR    .output/libbpf
>   MKDIR    bpftool
>   LIB      libbpf.a
>   BPFTOOL  bpftool/bootstrap/bpftool
> make[1]: *** /usr/src/libbpf-bootstrap/libbpf/src: No such file or direct=
ory.  Stop.
> make: *** [Makefile:87: /usr/src/libbpf-bootstrap/examples/c/.output/libb=
pf.a] Error 2
> make: *** Waiting for unfinished jobs....
> make[1]: *** /usr/src/libbpf-bootstrap/bpftool/src: No such file or direc=
tory.  Stop.
> make: *** [Makefile:95: /usr/src/libbpf-bootstrap/examples/c/.output/bpft=
ool/bootstrap/bpftool] Error 2
>
>
> Now what ?!?
>
> BPF is ever such unusable shite :/ It's very near as bad as qemu.
>

Sorry, not going into discussions about this :) I do agree initial
setup is not straightforward, and this libbpf-bootstrap repo is
actually an attempt to let users start quickly by doing a minimal and
more-or-less straightforward BPF setup (which is why I built
uprobe-stress on top of libbpf-bootstrap setup instead of BPF
selftests; that would be even more painful process for you which I
didn't want to force you through, see above about
selftests/bpf/config).

But just keep in mind that using BPF here isn't some sort of random
choice just because I tend to work mostly with BPF. BPF is the only
interface to multi-uprobe attachment, it's a lightweight and
low-overhead way to know whether uprobes are triggered (I do
memory-mapped sharing of per-cpu counters between BPF/kernel and user
space, no extra syscall overhead, blocking, or unnecessary memory
ordering is added). And in general, whether you like it or not, most
people would never care to use uprobes if not for BPF as an interface
into that.

I'm not trying to convert you into BPF or anything like that, but this
has to use BPF for end-to-end testing.

But you are close, please don't give up!
