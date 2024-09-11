Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401B748A;
	Wed, 11 Sep 2024 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726030922; cv=none; b=f3Wv4eIJNNRCRvIjhgoV1+0R/IjxTA0/r5ZT0gKNwoxIYuPOtk9EtUHpNbWg3Qo3pRDiRveL/flVPpY3yFQCWIQkt8FioTuVfgntL8xU/09rFH6CvtiSbSsPaMQbpSikDVRcUdrFvuZHJAW0i17j82WW0xgABVUIEWKQpuB6GOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726030922; c=relaxed/simple;
	bh=GR03gk6l/4yIvEanNyYHAWaaQVnuLtoTZlnpwAHeNro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTTyWXJXzVmrwpmt2D5sQVNH86AGE9u/rLzpkf0i+0LpoYjB/qQR48dYmdYLlkJ6mLRnnBeL38Pl5S7IbWsP4lsypOuF9+ZjzPQGw8y5H3p3M81bB+r6GL2yDYwBtOQHe32cP5smSvCz6+AiU5VxRcQMLTYBIXy8PhGEQ3qFBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmcbyhzS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmcbyhzS"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso1841851a12.1;
        Tue, 10 Sep 2024 22:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726030919; x=1726635719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y9WGvN4gCJZlWmeipDMEUKxZ6qFuoA/tJ0u/3oEbPE=;
        b=DmcbyhzSzA7Zu2FuJgknXaOPDwW1NLRQI/UEdGyENMkyZdxxmpjOv2P2xzIXucnUd3
         r72hXYuYN809ny76vQcXmtUDVjggk26jHyiEYD5/SehoR+t3Jh88hElhEHEAZFzuio2t
         vwUrd+xhBD6lhtUeD7/9JNONn+dS+ktejj3P9RGEjdj7Qz+bLX0683tFsFBIqdirOrFF
         7NStCEJovLNPZdYp+dxgbXyrLNmbdIXs+rymNRWPtdiJTclrm71xT4gckLAQ9oS4DmQx
         ar42eftQEckd4mSBnEe5JCUcE22HHQ8J6HcZ0E5o00SSNhcZfMnu28OGGRdb+I4crGxV
         G9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726030919; x=1726635719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3y9WGvN4gCJZlWmeipDMEUKxZ6qFuoA/tJ0u/3oEbPE=;
        b=wMMc3ACtbfj6i7xMIj0jyebFF6XTmJLdgpYJkZPNwykwjq7oFKb9nvRk4m9fyBJPA/
         y0ecgYQf9s+qV0dMpSzLC46UChFf9ETK/D9wEhbGrlVRCaLmP/mWuq3ajqgpBS/2y6KH
         ITlBgwBjHKpX1Ub9ajaMKYkCtKe+jLfhP83RCRUsqsGCqrlijdNJxNWOFEjLWX2HcAF5
         smL0PpPX98IMg1dWFXBZX5O8z2T+h31dnj85WlKqzNixiRZ/9HCGUHKjE8DqOBp4C8sN
         mRDGNAz2tAXKLbVMPQ/YaouExjdl9Zce1U9EjL194a27lVkv/zwAsd0sWI5E+jS+s5I/
         yKoA==
X-Forwarded-Encrypted: i=1; AJvYcCUP++yJCU4ABJEoe30kGXrZnWoHTSAp4N2nx4N3pcT4rO77kJ5qGW538RnCUrKIw7sjCg1FLKHPSU+l8lw=@vger.kernel.org, AJvYcCWQu+c0dK/onu5OBl7QkjWEsa1DqZ1cOy42+TUtjTgas9Fm9WltLWurjCvNfD+zIBARd6UoYZ35bDA+yoiJ0ynKFq0l@vger.kernel.org
X-Gm-Message-State: AOJu0YwVakl5z5GTfNLUpahzcQepdmQYNhT3QqGOrfK8uXk7wN5ThOqp
	6WYIo6RBBmex6OAQi29yREuAX2mbvXpDLpxDr/DuNQ5SKFM8/o2dd72rKAbteuQw/cYPe8LOvDc
	i6tPGibja4wjkGs3D5t9SzCYcQ5M=
X-Google-Smtp-Source: AGHT+IFv4KG/qOrb+mXNnO6ScWxmZtswlWxiJPynO52N6MZsl01Dtqkf5+8xYwDe1BBhNQOy4dVhYsUFA60FsJQinjc=
X-Received: by 2002:a05:6402:2345:b0:5c2:5c56:c31b with SMTP id
 4fb4d7f45d1cf-5c40bc5cc87mr1215565a12.30.1726030918048; Tue, 10 Sep 2024
 22:01:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908142544.1409032-1-dolinux.peng@gmail.com>
 <20240909110415.33cb5f22@gandalf.local.home> <CAErzpmtJHhZpFg0sHtffexM0Lu6y2xzbVZ1SXGxKob_Dz0+Bfw@mail.gmail.com>
 <20240910125033.0a3986fa@gandalf.local.home>
In-Reply-To: <20240910125033.0a3986fa@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 11 Sep 2024 13:01:32 +0800
Message-ID: <CAErzpmtz185jYSzVcDCFiVwB5b9J7nBQB-_=j7Q4_TxwjRwpTg@mail.gmail.com>
Subject: Re: [RFC PATCH] function_graph: Support recording and printing the
 function return address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:50=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 10 Sep 2024 14:15:39 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > >
> > > > See below logs with both funcgraph-retval and funcgraph-retaddr ena=
bled.
> > > >
> > > > 4)               |  load_elf_binary() { /* A=3Dbprm_execve+0x249/0x=
600 */
> > >
> > > I wonder if we should make this look more like the function tracer wh=
en it
> > > shows the parent. That is:
> > >
> > >   4)               |  load_elf_binary() { /* <-bprm_execve+0x249/0x60=
0 */
> >
> > Nice, Is it necessary to add a prefix letter for the return value? For
> > example, when
> >  both funcgraph-retval and funcgraph-retaddr are enabled, like this:
> >
> >          avc_policy_seqno(); /* <-selinux_file_permission+0x107/0x140 V=
=3D0x0 */
>
> How about:
>
> >          avc_policy_seqno(); /* <-selinux_file_permission+0x107/0x140 r=
et=3D0x0 */
>
> As "ret" is more obvious than "V".

I agree, and will modify it, thanks.

>
> >
> > >
> > > > 4)               |    load_elf_phdrs() { /* A=3Dload_elf_binary+0x8=
4/0x1730 */
> > > > 4)               |      __kmalloc_noprof() { /* A=3Dload_elf_phdrs+=
0x4a/0xb0 */
> > > > 4) + 47.910 us   |        __cond_resched(); /* V=3D0x0 A=3D__kmallo=
c_noprof+0x28c/0x390 */
> > > > 4) ! 204.142 us  |      } /* __kmalloc_noprof V=3D0xffff888201e32c0=
0 */
> > > > 4)               |      kernel_read() { /* A=3Dload_elf_phdrs+0x6c/=
0xb0 */
> > > > 4)               |        rw_verify_area() { /* A=3Dkernel_read+0x2=
b/0x50 */
> > > > 4)               |          security_file_permission() {
> > > > 4)               |            selinux_file_permission() { /* A=3Dse=
curity_file_permission+0x26/0x40 */
> > > > 4)               |              __inode_security_revalidate() { /* =
A=3Dselinux_file_permission+0x6d/0x140 */
> > > > 4)   1.182 us    |                __cond_resched(); /* V=3D0x0 A=3D=
__inode_security_revalidate+0x5f/0x80 */
> > > > 4)   4.138 us    |              } /* __inode_security_revalidate V=
=3D0x0 */
> > > > 4)   1.513 us    |              avc_policy_seqno(); /* V=3D0x0 A=3D=
selinux_file_permission+0x107/0x140 */
> > > > 4) + 12.133 us   |            } /* selinux_file_permission V=3D0x0 =
*/
> > > > 4) + 39.834 us   |          } /* security_file_permission V=3D0x0 *=
/
> > > > 4) + 42.710 us   |        } /* rw_verify_area V=3D0x0 */
> > > >
>
> > > > +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > > >  /* Function call entry */
> > > >  FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> > > >
> > > > @@ -79,6 +80,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph=
_ent_entry,
> > > >       F_STRUCT(
> > > >               __field_struct( struct ftrace_graph_ent,        graph=
_ent       )
> > > >               __field_packed( unsigned long,  graph_ent,      func =
           )
> > > > +             __field_packed( unsigned long,  graph_ent,      retad=
dr         )
> > > >               __field_packed( int,            graph_ent,      depth=
           )
> > > >       ),
> > > >
> > >
> > > Let's make this a new event, so that when this option is not enabled,=
 we
> > > don't waste the ring buffer. For function tracing, every element adde=
d to
> > > the event will add megabytes extra to the ring buffer.
> > >
> > > It should be possible to switch what event gets created at the time o=
f the
> > > trace. Even calling different functions to do it.
> >
> > Sounds good, we may create a new event as follows:
> >
> > struct ftrace_graph_ent {
> > unsigned long func; /* Current function */
> > unsigned long retaddr;
> > int depth;
> > } __packed;
> >
> > FTRACE_ENTRY_PACKED(funcgraph_retaddr_entry, ftrace_graph_ent_readdr_en=
try,
> >
> > TRACE_GRAPH_RETADDR_ENT,
> >
> > F_STRUCT(
> > __field_struct( struct ftrace_graph_retaddr_ent, graph_retaddr_ent )
> > __field_packed( unsigned long, graph_retaddr_ent, func )
> > __field_packed( unsigned long, graph_retaddr_ent, retaddr )
> > __field_packed( int, graph_retaddr_ent, depth )
> > ),
> >
> > F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
>
> Why not add the ret in the printk?
>
>   F_printk("--> %ps (%d) <-%ps", (void *)__entry->func, __entry->depth, (=
void *)__entry->retaddr)
>
> Then user space parsing tools could use this by default, when it doesn't
> know how to parse it.

Thanks, I will modify it.

>
> > );
> >
> > If we were to introduce another new feature such as funcgraph-args whic=
h
> > adds a `ftrace_regs` to the `ftrace_graph_ent`, would it be necessary t=
o
> > create yet another new event?
>
> Probably yes.
>
> >
> >  In the scenario where both funcgrah-retaddr and funcgraph-args are ena=
bled,
> > it is possible that an additional new event may also be required.
>
> Yes, that would likely be another event.
>
> -- Steve
