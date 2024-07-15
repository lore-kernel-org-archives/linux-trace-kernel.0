Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830517BB4;
	Mon, 15 Jul 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063609; cv=none; b=Skng5rDlPZMj0T4p14ib6838VtOQ8r1xiEQfacaFqNA4Oj+cOa1p37kP1S8qZz6yFnUBIeL+lzQkwZsHwja+T4QW4DCQPqm+2J+/aYpiVBhZgcoYfryWs9sRJPQct7luzNeDWveQ+hOi3rOChefaSKKuAaEv4REvZ72zbYcyuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063609; c=relaxed/simple;
	bh=ToyDY2GJHUSzmGIMw6C9J6PHdvvxMBv4VCSXZlwXWVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjRAANJtTMTLp6lJSf7M9Z1qaF0YDlDwaKaiekb6oEzwh3jtTLX+Dv6XYJRTD0AdpUtWADdPv93xCLG+3J4nLr1getgnh3yYcLmvT4KbzS8K2m9JKVJv3R66uvv90QMlg/54lr1jVjtW8mPk+JHJwbRzIGhtGWaDrnRkoXqb/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiUQMlCt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiUQMlCt"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-78aeee1068aso1939537a12.2;
        Mon, 15 Jul 2024 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721063607; x=1721668407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmve5Pgom/RNA/I+ArMsB4iJ1Fmflyafvmw7oAQ2pjs=;
        b=fiUQMlCtqGL4zpakVMJaOxBsNVndq4bZkmP2s0a/OOFJvd+putWjXdqoBgBXtZbIg+
         s+sXWe7C2V1CsMXIPDC0jIkD+2tUpjboHJ9ctCBseHx7DYseezoHUcILyHeMFfaU+dCd
         OntqhA1f9t6rjqABIS6d8uKLCZBCPNNl3P3XJfrx1aJ5EgXYxW/muMAqKRIeEW4RL8yU
         gdYebJmdl+Qg6xkkr2r20tXraxdrSgeeSl257nSSkV3yrCRNdmLMv5Dzt/fVAxQaNCcT
         zzteOz9qRyk/IvhMpfpVnNp6diYWvWmDUwRLjPzI3/qKWCE9A6KZZlBnU6XP+/4b1x9G
         lfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063607; x=1721668407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmve5Pgom/RNA/I+ArMsB4iJ1Fmflyafvmw7oAQ2pjs=;
        b=ZhUNENPeJp17juTx0alv3gjtnt41ZlicFiwPwB3t/fYjGEHZSe75JZOi+7vgTLj6FV
         VMi1E9MWJ8KwCXW1r3m4D3x3CyJq9sFsDqpHf1ORLpsL6AfZryuFPr7Izy0X8Hb4MELX
         iyrKfGvS0nGlzzODXc9T5a5My9Z+BFkqOCWWZAhh6MtWH4s1pZy9tpgDiis3ot7qLIfj
         M14D21KCpJ9bDuvlCRXWgeFHox5WCK1c75VQK7kveTiEAgKEUnO+G/a//pcoORQG2s02
         VNNEaijpW0OXNd9isdwlOrU87w+kV9Fp032M92r9olL4XC40h9Dmu1jIX4Ov8Foy+9v/
         r4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYMc47uxHkxx/zmFO7VNOBj3Q2Ji3MIrcQlv+DRpgJUbcN5zgk21a6IDe0ZoH2m7UeGhIJ3RSefmvsJ3N+18ot6BE5PFecHH77qCAkXEcye9IcW1bDkstXjGs9o6fch/N5dOS9t7o7ZdhurqAxOYXX
X-Gm-Message-State: AOJu0Yxse+/1vFiwu+pDJ/XzluQL9fo3nehu2SH7X/dAUolkPUw+mC8/
	x4XvohMuRKr3N/O3P3rFJp4zkbs1fPyhuhWQrbf18OZgr4Qo2vei4oH1uEf1FpN9peyqI7J4V4U
	ux3UPHcLIIkMOh0Q5MchDI1wb61Q=
X-Google-Smtp-Source: AGHT+IFtmqOvgWYZ98cfSUB0ddYCIleqfcRrm2OJ3m1eoM1lsMpb2EXPy5skW+GxVwn+ZNslbWgoWnBm0HpOkK2rQ+g=
X-Received: by 2002:a05:6a21:78c:b0:1c0:f648:8571 with SMTP id
 adf61e73a8af0-1c3ee50fd32mr631369637.4.1721063607532; Mon, 15 Jul 2024
 10:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110400.529465037@infradead.org>
 <CAEf4BzZLW+Dez6-WOe1jtCEjC8n6vUqcewWAYViquT4Cc6AA0Q@mail.gmail.com> <20240715112135.GC14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715112135.GC14400@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Jul 2024 10:13:15 -0700
Message-ID: <CAEf4Bzb5kv=9GSGw86YzkbpdD_E81Yfk_xNoBYwuSfeEMbThbg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] rbtree: Provide rb_find_rcu() / rb_find_add_rcu()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:21=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Jul 12, 2024 at 01:23:43PM -0700, Andrii Nakryiko wrote:
> > On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > Much like latch_tree, add two RCU methods for the regular RB-tree,
> > > which can be used in conjunction with a seqcount to provide lockless
> > > lookups.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  include/linux/rbtree.h |   67 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >  1 file changed, 67 insertions(+)
> > >
> > > --- a/include/linux/rbtree.h
> > > +++ b/include/linux/rbtree.h
> > > @@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
> > >  }
> > >
> > >  /**
> > > + * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
> > > + * @node: node to look-for / insert
> > > + * @tree: tree to search / modify
> > > + * @cmp: operator defining the node order
> > > + *
> > > + * Adds a Store-Release for link_node.
> > > + *
> > > + * Returns the rb_node matching @node, or NULL when no match is foun=
d and @node
> > > + * is inserted.
> > > + */
> > > +static __always_inline struct rb_node *
> > > +rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
> > > +               int (*cmp)(struct rb_node *, const struct rb_node *))
> >
> > I don't get the point of the RCU version of rb_find_add as RCU itself
> > doesn't provide enough protection for modification of the tree, right?
> > So in uprobes code you do rb_find_add_rcu() under uprobes_treelock +
> > uprobes_seqcount locks. Wouldn't it be just as fine to do plain
> > non-RCU rb_find_add() in that case? After all, you do plain rb_erase
> > under the same set of locks.
> >
> > So what's the point of this one?
>
> The store-release when adding it to the tree. Without that it becomes
> possible to find the entry while the entry itself is incomplete.
>
> Eg. something like:
>
>  entry.foo =3D A
>  rb_find_add(&entry->node, &my_tree, my_cmp);
>
> vs
>
>  rcu_read_lock();
>  entry =3D rb_find_rcu(...);
>  assert(entry->foo =3D=3D A);
>
> might fail. Because there is nothing ordering the foo store and the
> rb-node add.
>
>

Ah, I see, thanks for the explanation. That's what "Adds a
Store-Release for link_node." in the comment means, I see.
