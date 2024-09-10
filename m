Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429112E48;
	Tue, 10 Sep 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948956; cv=none; b=QPrbfoyHPkRBp3GpBGtURHhLC2bMFkDUUmrMI5bGQj6wWyhvTAgtezfSeoJNv2+vI3cv4a+J56mHM8/Y6fjZwQzI3+zsfwLQZpQ82J1gdq5+huK2hI/CbszfIdgzJtpnFWjhSTi0WtOXkuzEP8mG+QKwRA8ESx1JZhjac/tosBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948956; c=relaxed/simple;
	bh=O9Fjr/NdnkZ6L2A92vilkJZ2RrVg4nmEu7IwS8hKB2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxC14QdBEcmCRsSkf25WTrVFDP0doIm84xe3ZuUYpPrBG6hffnO4MWETsPYoloz4ZlRMMtGJxl+P1m7aU55BEsPcuJ+KdqkDDiD1Ezype53HZLjakw4axPr81jLvqUJoWXYmUcskuyNTgvrtIGXKUafd9W+Mh/drNXn9Qds1ijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx05BgOM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx05BgOM"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so2363497a12.2;
        Mon, 09 Sep 2024 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725948953; x=1726553753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdT7dMC/o3p9lUJ163/gFFKSEgLc+DjHXP9xt/udZig=;
        b=Zx05BgOMVbrxJQpf8QmkOj0NL3wHdxY/Jy3zSbUjF5dfTSAQq4zgzCaHSxZabNr52D
         5eahOgrPJag2XVdk7B+jpc/IdKGn8pzDN2kFCZUKz3L8GARbsaQRBkjL8o/MfMYbGloe
         /cLIxQ/tdcY67eDNmgaKuOHNcxcMPn20nFei1P+Em1PBOvg8Zy7Ak/ntFWkwSPawPF8q
         ZoTkRXK5xtLVuIsO/ipEnECfor9WlAn6ndJgFlGmiz57cxt2oP6iJl5osj6DG14ydBwB
         wdZywGAeuyLBJCiewPYYuuvJAuQ+f/u/Fnbp7mGyCRQGnBd4jBbGFAWoipqfjhMkbb0A
         5IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725948953; x=1726553753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdT7dMC/o3p9lUJ163/gFFKSEgLc+DjHXP9xt/udZig=;
        b=IwO+CF0Txqo5YEFUWKP4pGYd3chbwyqd+qY5ys2Wuy3ONMbx4c8vElLxVgDvM0MfLQ
         mo0JatHRWy0nN7ZEDsvr7H5VhJCZexNvP4ZtQ5ndezY3U4pE++6JRt5CgRPEWcM6W3lC
         oQ2oAyr+vJHV+VrH0Xl1fyIy5Ng2vXzHSGH6Up3RU8tX+UxAxm4/e/tO1qRfxjjzW74B
         EC8mve8Y3DvJn8zgVYCW0dWdrK3wYiviAenpNJTchkzd3tcXoygWc6myn7J9zjxR3E5g
         fYVsJ+++SVOL8ZMY1NSR/lQfj2H1BJDRvtfQE/ArClyxV4YkuezMVvGMkU0HyN1myI/P
         x+4w==
X-Forwarded-Encrypted: i=1; AJvYcCU8mxAyAXYfqxT3laARg58VXxy9WlOio/lRE6LN2G4RjVr+80FlLuqVnA4ukcTYHppT2BfrdStTISg7Kxw=@vger.kernel.org, AJvYcCWVTZLwBhwi3nOnmoYciu1gtOEVKal6gDUD4+I2RXzuzhiatKF/n4qQeaNjeDX0l0XjjCg9VbB7bY1WTces/nx9XnsB@vger.kernel.org
X-Gm-Message-State: AOJu0YydfJXdy41xaCQL4MTIgvGWdasRsQjbgUyb1MzpkNzwFNsx/HWr
	hGdCn4r0zzAbcjviN74RA6bb9EJNl8QkJ2vlMNTb97KhedJ1Gl9g8mzclprQpKAx6CxFT/PV+5L
	vI+Qr/87KjqNUudLgh+EV7b+X/60=
X-Google-Smtp-Source: AGHT+IExFH6YmvnjVUKe2/8vjiXm9aRhAyU/uSIIy5dkpGXJag/GUGhZ929URqHV5/LXlmTmtetgmL5xisEU04a5VzA=
X-Received: by 2002:a05:6402:4402:b0:5c2:6e61:fa87 with SMTP id
 4fb4d7f45d1cf-5c3dc7b7ed2mr13103043a12.23.1725948951693; Mon, 09 Sep 2024
 23:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908142544.1409032-1-dolinux.peng@gmail.com> <20240909110415.33cb5f22@gandalf.local.home>
In-Reply-To: <20240909110415.33cb5f22@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 10 Sep 2024 14:15:39 +0800
Message-ID: <CAErzpmtJHhZpFg0sHtffexM0Lu6y2xzbVZ1SXGxKob_Dz0+Bfw@mail.gmail.com>
Subject: Re: [RFC PATCH] function_graph: Support recording and printing the
 function return address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:04=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun,  8 Sep 2024 07:25:44 -0700
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> Hi Donglin!
>
> > When using function_graph tracer to analyze the flow of kernel function
> > execution, it is often necessary to quickly locate the exact line of co=
de
> > where the call occurs. While this may be easy at times, it can be more
> > time-consuming when some functions are inlined or the flow is too long.
> >
> > This feature aims to simplify the process by recording the return addre=
ss
> > of traced funcions and printing it when outputing trace logs.
> >
> > To distinguish the return value, 'V=3D' is used as the prefix for the k=
ernel
> > return value, and 'A=3D' is used as the prefix for the return address i=
n trace
> > logs. A new trace option named 'funcgraph-retaddr' has been added, and =
the
> > option 'sym-addr' can control the format of the return address.
> >
> > See below logs with both funcgraph-retval and funcgraph-retaddr enabled=
.
> >
> > 4)               |  load_elf_binary() { /* A=3Dbprm_execve+0x249/0x600 =
*/
>
> I wonder if we should make this look more like the function tracer when i=
t
> shows the parent. That is:
>
>   4)               |  load_elf_binary() { /* <-bprm_execve+0x249/0x600 */

Nice, Is it necessary to add a prefix letter for the return value? For
example, when
 both funcgraph-retval and funcgraph-retaddr are enabled, like this:

         avc_policy_seqno(); /* <-selinux_file_permission+0x107/0x140 V=3D0=
x0 */

>
> > 4)               |    load_elf_phdrs() { /* A=3Dload_elf_binary+0x84/0x=
1730 */
> > 4)               |      __kmalloc_noprof() { /* A=3Dload_elf_phdrs+0x4a=
/0xb0 */
> > 4) + 47.910 us   |        __cond_resched(); /* V=3D0x0 A=3D__kmalloc_no=
prof+0x28c/0x390 */
> > 4) ! 204.142 us  |      } /* __kmalloc_noprof V=3D0xffff888201e32c00 */
> > 4)               |      kernel_read() { /* A=3Dload_elf_phdrs+0x6c/0xb0=
 */
> > 4)               |        rw_verify_area() { /* A=3Dkernel_read+0x2b/0x=
50 */
> > 4)               |          security_file_permission() {
> > 4)               |            selinux_file_permission() { /* A=3Dsecuri=
ty_file_permission+0x26/0x40 */
> > 4)               |              __inode_security_revalidate() { /* A=3D=
selinux_file_permission+0x6d/0x140 */
> > 4)   1.182 us    |                __cond_resched(); /* V=3D0x0 A=3D__in=
ode_security_revalidate+0x5f/0x80 */
> > 4)   4.138 us    |              } /* __inode_security_revalidate V=3D0x=
0 */
> > 4)   1.513 us    |              avc_policy_seqno(); /* V=3D0x0 A=3Dseli=
nux_file_permission+0x107/0x140 */
> > 4) + 12.133 us   |            } /* selinux_file_permission V=3D0x0 */
> > 4) + 39.834 us   |          } /* security_file_permission V=3D0x0 */
> > 4) + 42.710 us   |        } /* rw_verify_area V=3D0x0 */
> >
> > Then, we can use the faddr2line to locate the source code, for example:
> >
> > $ ./scripts/faddr2line ./vmlinux load_elf_phdrs+0x6c/0xb0
> > load_elf_phdrs+0x6c/0xb0:
> > elf_read at fs/binfmt_elf.c:471
> > (inlined by) load_elf_phdrs at fs/binfmt_elf.c:531
> >
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> >  include/linux/ftrace.h               |   1 +
> >  kernel/trace/fgraph.c                |   1 +
> >  kernel/trace/trace.h                 |   1 +
> >  kernel/trace/trace_entries.h         |  19 ++++-
> >  kernel/trace/trace_functions_graph.c | 105 ++++++++++++++++++---------
> >  5 files changed, 92 insertions(+), 35 deletions(-)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index fd5e84d0ec47..bdf51163b3b8 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -1011,6 +1011,7 @@ static inline void ftrace_init(void) { }
> >   */
> >  struct ftrace_graph_ent {
> >       unsigned long func; /* Current function */
> > +     unsigned long retaddr;  /* Return address */
> >       int depth;
> >  } __packed;
> >
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index d7d4fb403f6f..fcc4162c10f6 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -622,6 +622,7 @@ int function_graph_enter(unsigned long ret, unsigne=
d long func,
> >
> >       trace.func =3D func;
> >       trace.depth =3D ++current->curr_ret_depth;
> > +     trace.retaddr =3D ret;
> >
> >       offset =3D ftrace_push_return_trace(ret, func, frame_pointer, ret=
p, 0);
> >       if (offset < 0)
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index bd3e3069300e..87e02815b030 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -870,6 +870,7 @@ static __always_inline bool ftrace_hash_empty(struc=
t ftrace_hash *hash)
> >  #define TRACE_GRAPH_GRAPH_TIME          0x400
> >  #define TRACE_GRAPH_PRINT_RETVAL        0x800
> >  #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
> > +#define TRACE_GRAPH_PRINT_RETADDR       0x2000
> >  #define TRACE_GRAPH_PRINT_FILL_SHIFT 28
> >  #define TRACE_GRAPH_PRINT_FILL_MASK  (0x3 << TRACE_GRAPH_PRINT_FILL_SH=
IFT)
> >
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.=
h
> > index c47422b20908..8b8753319dd3 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -71,6 +71,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
> >       perf_ftrace_event_register
> >  );
> >
> > +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> >  /* Function call entry */
> >  FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> >
> > @@ -79,6 +80,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent=
_entry,
> >       F_STRUCT(
> >               __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
> >               __field_packed( unsigned long,  graph_ent,      func     =
       )
> > +             __field_packed( unsigned long,  graph_ent,      retaddr  =
       )
> >               __field_packed( int,            graph_ent,      depth    =
       )
> >       ),
> >
>
> Let's make this a new event, so that when this option is not enabled, we
> don't waste the ring buffer. For function tracing, every element added to
> the event will add megabytes extra to the ring buffer.
>
> It should be possible to switch what event gets created at the time of th=
e
> trace. Even calling different functions to do it.

Sounds good, we may create a new event as follows:

struct ftrace_graph_ent {
unsigned long func; /* Current function */
unsigned long retaddr;
int depth;
} __packed;

FTRACE_ENTRY_PACKED(funcgraph_retaddr_entry, ftrace_graph_ent_readdr_entry,

TRACE_GRAPH_RETADDR_ENT,

F_STRUCT(
__field_struct( struct ftrace_graph_retaddr_ent, graph_retaddr_ent )
__field_packed( unsigned long, graph_retaddr_ent, func )
__field_packed( unsigned long, graph_retaddr_ent, retaddr )
__field_packed( int, graph_retaddr_ent, depth )
),

F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
);

If we were to introduce another new feature such as funcgraph-args which
adds a `ftrace_regs` to the `ftrace_graph_ent`, would it be necessary to
create yet another new event?

 In the scenario where both funcgrah-retaddr and funcgraph-args are enabled=
,
it is possible that an additional new event may also be required.

>
> Thanks,
>
> -- Steve
>
>
> > @@ -86,8 +88,6 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent=
_entry,
> >  );
> >
> >  /* Function return entry */
> > -#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> > -
> >  FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
> >
> >       TRACE_GRAPH_RET,
> > @@ -110,6 +110,21 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_r=
et_entry,
> >
> >  #else
> >
> > +/* Function call entry */
> > +FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> > +
> > +     TRACE_GRAPH_ENT,
> > +
> > +     F_STRUCT(
> > +             __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
> > +             __field_packed( unsigned long,  graph_ent,      func     =
       )
> > +             __field_packed( int,            graph_ent,      depth    =
       )
> > +     ),
> > +
> > +     F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
> > +);
> > +
> > +/* Function return entry */
> >  FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
> >
> >       TRACE_GRAPH_RET,
