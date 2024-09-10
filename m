Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD3757EB;
	Tue, 10 Sep 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930475; cv=none; b=ugqHaZX/Y0hUV8Lal52yunRTT5cvzAz3oKmWipDHuPcfeCOsNoJZx1OU7pDOxbtABMSiqIA6X+d8u8fbJY//JyHlP7Muk0M0iL24p5oensykK22B4vVyaUl7iPoUUUV4I+Dqhpzb/qZlQT8Yru9sCpn5jEb59163VSgUG80TStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930475; c=relaxed/simple;
	bh=mp4CcRydjn0mStYV+6XbBLDjp/PudkdR1p3z9kOiHtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXBYYHqD4UaRjEsbacjxEUvYgjsL+3gJM9FhuF8Vc1GF8y0Iymd0ZYmATY5/X8N1EuhufqnBQEGOeW1u5UQJ8MKECyPoGki/GU055XO7bfVgGEjkEdbgjBUC1Uondg6mmiSCb19YZedeoXGkORqRVDWQcao4bFvkADgmmeCtrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Za/tyWzm; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za/tyWzm"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-501274e2c29so1470795e0c.3;
        Mon, 09 Sep 2024 18:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725930472; x=1726535272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW3Pn4mq0GNLE0pC0+xgLS+v2msNvlVAJm6ZwMqloRI=;
        b=Za/tyWzmlYb7qPBLX2sBvkSZXUgxjYnAkUuwErjHgH0zWIs+fvYZzmbNpoc86XCgak
         kmqlxDcq+m+XjxBvd06A9D/8cpAj9O+jwYKq7JmkuLgSDIJLZxfAUIZ8/CpbFEf3UpI3
         HJndoeBwnIiJOHQHi3KW+LZ9hylodb+KBW7ibxmyvwVaeiwE2m8RGX+O187jq+Cvurqv
         Arwvc/g2dLqTBk6V8eNTgdcRN5HkQ1oey8HmI6iz0pMPuhbhv4aAtV4OINF1t7LyCA9N
         eG4cy9G3lRRirG50hGEb5m0HcqqCa55wsAlX+uH8wg4syyfK4h7p5EFe0uhCPzRz+1nO
         cFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725930472; x=1726535272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW3Pn4mq0GNLE0pC0+xgLS+v2msNvlVAJm6ZwMqloRI=;
        b=sVIwnv6MAT1WKlHiiytnv2moI1QFhKvDmBRTy9Bp6SQB2zCfzyXGZQE6mhJqxP8yTr
         kUumKf60a7hQos/4XicTAsC6ON6yAu86zka6vRkoAQOKCNBT01uiBDRNjwJAUH38y4hZ
         IHS0RO1h0alugBnElNUBYc13e2+rOWFNGMxO6qkPJXAsBFEQuJRzJmNaGDD0A5LyUJmz
         WL81/xMxahKka7R3Kuy9aqsn44e/ihaa7POYaemp/Ug+aLsutSFy2/QLyPcs6EuYxust
         dM+FMRQQq3gj0Pja9SqFQ/vA06DfDl6neiggUjL1K/Z6886hLRlHwGz23+8rDhfOphBF
         nALA==
X-Forwarded-Encrypted: i=1; AJvYcCW0u6ZBT1VWNI08YZWMoQynXrCeAJ8woSbd5+aBLL6cWTHgDXJhjiYPdqA0xBRXdWEzgor2w/CJu3GtwWAOocNqc71q@vger.kernel.org, AJvYcCWb2BXn1iUnARcfuvki0TmWyomZ6vK0FBCZn25zSOTiDd0O9PQ/YG5lJUebFV7+rR1z+scceqDFMkqaiJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsYPiKjPkGllTSvdx+Vlvw126Zhi1q7ONHzB1rdiZ06kjfP7s
	fQGcfIe0Lxa+RuBxSScBj26HuQydVvCLckxuCmoCxXh+XdWf5T9w9uJWv4387bTqLoOVlHBXuCq
	nOYBm7COXhtd+j+Hq01V6NMC6b+Q=
X-Google-Smtp-Source: AGHT+IEBp3X/UWW6yY/UWQMMaEyL6XiiT028Nah7B+QRocDkx7cGztWwN4z4iHgcc+k5KJlsNx8PpYN43o2hbUOaryI=
X-Received: by 2002:a05:6122:2021:b0:4fc:da8f:c8c4 with SMTP id
 71dfb90a1353d-5022146e600mr14892280e0c.12.1725930471497; Mon, 09 Sep 2024
 18:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908142544.1409032-1-dolinux.peng@gmail.com>
In-Reply-To: <20240908142544.1409032-1-dolinux.peng@gmail.com>
From: Jeff Xie <xiehuan09@gmail.com>
Date: Tue, 10 Sep 2024 09:07:39 +0800
Message-ID: <CAEr6+EDqReXpDUgOQpa5DZKArvf55Te_nynTnGe2C+zoY7n6XQ@mail.gmail.com>
Subject: Re: [RFC PATCH] function_graph: Support recording and printing the
 function return address
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 10:26=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> When using function_graph tracer to analyze the flow of kernel function
> execution, it is often necessary to quickly locate the exact line of code
> where the call occurs. While this may be easy at times, it can be more
> time-consuming when some functions are inlined or the flow is too long.
>
> This feature aims to simplify the process by recording the return address
> of traced funcions and printing it when outputing trace logs.
>
> To distinguish the return value, 'V=3D' is used as the prefix for the ker=
nel
> return value, and 'A=3D' is used as the prefix for the return address in =
trace
> logs. A new trace option named 'funcgraph-retaddr' has been added, and th=
e
> option 'sym-addr' can control the format of the return address.
>
> See below logs with both funcgraph-retval and funcgraph-retaddr enabled.
>
> 4)               |  load_elf_binary() { /* A=3Dbprm_execve+0x249/0x600 */
> 4)               |    load_elf_phdrs() { /* A=3Dload_elf_binary+0x84/0x17=
30 */
> 4)               |      __kmalloc_noprof() { /* A=3Dload_elf_phdrs+0x4a/0=
xb0 */
> 4) + 47.910 us   |        __cond_resched(); /* V=3D0x0 A=3D__kmalloc_nopr=
of+0x28c/0x390 */
> 4) ! 204.142 us  |      } /* __kmalloc_noprof V=3D0xffff888201e32c00 */
> 4)               |      kernel_read() { /* A=3Dload_elf_phdrs+0x6c/0xb0 *=
/
> 4)               |        rw_verify_area() { /* A=3Dkernel_read+0x2b/0x50=
 */
> 4)               |          security_file_permission() {
> 4)               |            selinux_file_permission() { /* A=3Dsecurity=
_file_permission+0x26/0x40 */
> 4)               |              __inode_security_revalidate() { /* A=3Dse=
linux_file_permission+0x6d/0x140 */
> 4)   1.182 us    |                __cond_resched(); /* V=3D0x0 A=3D__inod=
e_security_revalidate+0x5f/0x80 */
> 4)   4.138 us    |              } /* __inode_security_revalidate V=3D0x0 =
*/
> 4)   1.513 us    |              avc_policy_seqno(); /* V=3D0x0 A=3Dselinu=
x_file_permission+0x107/0x140 */
> 4) + 12.133 us   |            } /* selinux_file_permission V=3D0x0 */
> 4) + 39.834 us   |          } /* security_file_permission V=3D0x0 */
> 4) + 42.710 us   |        } /* rw_verify_area V=3D0x0 */
>
> Then, we can use the faddr2line to locate the source code, for example:
>
> $ ./scripts/faddr2line ./vmlinux load_elf_phdrs+0x6c/0xb0
> load_elf_phdrs+0x6c/0xb0:
> elf_read at fs/binfmt_elf.c:471
> (inlined by) load_elf_phdrs at fs/binfmt_elf.c:531

That's a great idea; I often use it that way. However, I used both the
function tracer and the function graph simultaneously
because the function tracer can also show context messages, such as
displaying 'd.h3.'

Example:
<idle>-0 [001] d.h3. 41.119330: __napi_schedule+0x4/0x90 <-e1000_intr+0x8d/=
0x110

I suggest that we consider displaying the results of both the function
tracer and the function graph together in the same instance ;-)

> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  include/linux/ftrace.h               |   1 +
>  kernel/trace/fgraph.c                |   1 +
>  kernel/trace/trace.h                 |   1 +
>  kernel/trace/trace_entries.h         |  19 ++++-
>  kernel/trace/trace_functions_graph.c | 105 ++++++++++++++++++---------
>  5 files changed, 92 insertions(+), 35 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index fd5e84d0ec47..bdf51163b3b8 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1011,6 +1011,7 @@ static inline void ftrace_init(void) { }
>   */
>  struct ftrace_graph_ent {
>         unsigned long func; /* Current function */
> +       unsigned long retaddr;  /* Return address */
>         int depth;
>  } __packed;
>
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d7d4fb403f6f..fcc4162c10f6 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -622,6 +622,7 @@ int function_graph_enter(unsigned long ret, unsigned =
long func,
>
>         trace.func =3D func;
>         trace.depth =3D ++current->curr_ret_depth;
> +       trace.retaddr =3D ret;
>
>         offset =3D ftrace_push_return_trace(ret, func, frame_pointer, ret=
p, 0);
>         if (offset < 0)
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index bd3e3069300e..87e02815b030 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -870,6 +870,7 @@ static __always_inline bool ftrace_hash_empty(struct =
ftrace_hash *hash)
>  #define TRACE_GRAPH_GRAPH_TIME          0x400
>  #define TRACE_GRAPH_PRINT_RETVAL        0x800
>  #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
> +#define TRACE_GRAPH_PRINT_RETADDR       0x2000
>  #define TRACE_GRAPH_PRINT_FILL_SHIFT   28
>  #define TRACE_GRAPH_PRINT_FILL_MASK    (0x3 << TRACE_GRAPH_PRINT_FILL_SH=
IFT)
>
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index c47422b20908..8b8753319dd3 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -71,6 +71,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
>         perf_ftrace_event_register
>  );
>
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  /* Function call entry */
>  FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
>
> @@ -79,6 +80,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_e=
ntry,
>         F_STRUCT(
>                 __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
>                 __field_packed( unsigned long,  graph_ent,      func     =
       )
> +               __field_packed( unsigned long,  graph_ent,      retaddr  =
       )
>                 __field_packed( int,            graph_ent,      depth    =
       )
>         ),
>
> @@ -86,8 +88,6 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_e=
ntry,
>  );
>
>  /* Function return entry */
> -#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> -
>  FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>
>         TRACE_GRAPH_RET,
> @@ -110,6 +110,21 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret=
_entry,
>
>  #else
>
> +/* Function call entry */
> +FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> +
> +       TRACE_GRAPH_ENT,
> +
> +       F_STRUCT(
> +               __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
> +               __field_packed( unsigned long,  graph_ent,      func     =
       )
> +               __field_packed( int,            graph_ent,      depth    =
       )
> +       ),
> +
> +       F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
> +);
> +
> +/* Function return entry */
>  FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>
>         TRACE_GRAPH_RET,
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_fu=
nctions_graph.c
> index 13d0387ac6a6..655535d57763 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -63,6 +63,8 @@ static struct tracer_opt trace_opts[] =3D {
>         { TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
>         /* Display function return value in hexadecimal format ? */
>         { TRACER_OPT(funcgraph-retval-hex, TRACE_GRAPH_PRINT_RETVAL_HEX) =
},
> +       /* Display function return address ? */
> +       { TRACER_OPT(funcgraph-retaddr, TRACE_GRAPH_PRINT_RETADDR) },
>  #endif
>         /* Include sleep time (scheduled out) between entry and return */
>         { TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
> @@ -651,50 +653,86 @@ print_graph_duration(struct trace_array *tr, unsign=
ed long long duration,
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>
>  #define __TRACE_GRAPH_PRINT_RETVAL TRACE_GRAPH_PRINT_RETVAL
> +#define __TRACE_GRAPH_PRINT_RETADDR TRACE_GRAPH_PRINT_RETADDR
>
> -static void print_graph_retval(struct trace_seq *s, unsigned long retval=
,
> -                               bool leaf, void *func, bool hex_format)
> +static bool print_graph_retaddr(struct trace_seq *s, struct ftrace_graph=
_ent *graph_ent,
> +                               u32 trace_flags, bool comment)
>  {
> -       unsigned long err_code =3D 0;
> +       if (unlikely(graph_ent->retaddr =3D=3D
> +                (unsigned long)dereference_kernel_function_descriptor(re=
turn_to_handler)))
> +               return false;
>
> -       if (retval =3D=3D 0 || hex_format)
> -               goto done;
> +       if (comment)
> +               trace_seq_puts(s, " /*");
>
> -       /* Check if the return value matches the negative format */
> -       if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> -               (((u64)retval) >> 32) =3D=3D 0) {
> -               /* sign extension */
> -               err_code =3D (unsigned long)(s32)retval;
> -       } else {
> -               err_code =3D retval;
> +       trace_seq_puts(s, " A=3D");
> +       seq_print_ip_sym(s, graph_ent->retaddr, trace_flags | TRACE_ITER_=
SYM_OFFSET);
> +
> +       if (comment)
> +               trace_seq_puts(s, " */");
> +
> +       return true;
> +}
> +
> +static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_=
ent *graph_ent,
> +                               struct ftrace_graph_ret *graph_ret,
> +                               u32 opt_flags, u32 trace_flags)
> +{
> +       unsigned long err_code =3D 0;
> +       unsigned long retval =3D graph_ret->retval;
> +       bool hex_format =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
> +       bool print_retaddr =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
> +       bool print_retval =3D !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL);
> +       void *func =3D (void *)graph_ret->func;
> +
> +       if (print_retval && retval && !hex_format) {
> +               /* Check if the return value matches the negative format =
*/
> +               if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> +                       (((u64)retval) >> 32) =3D=3D 0) {
> +                       err_code =3D sign_extend64(retval, 31);
> +               } else {
> +                       err_code =3D retval;
> +               }
> +
> +               if (!IS_ERR_VALUE(err_code))
> +                       err_code =3D 0;
>         }
>
> -       if (!IS_ERR_VALUE(err_code))
> -               err_code =3D 0;
> +       if (print_retaddr && graph_ent && unlikely(graph_ent->retaddr =3D=
=3D
> +                (unsigned long)dereference_kernel_function_descriptor(re=
turn_to_handler)))
> +               print_retaddr =3D false;
>
> -done:
> -       if (leaf) {
> -               if (hex_format || (err_code =3D=3D 0))
> -                       trace_seq_printf(s, "%ps(); /* =3D 0x%lx */\n",
> -                                       func, retval);
> +       if (graph_ent) {
> +               trace_seq_printf(s, "%ps();", func);
> +               if (print_retval || print_retaddr)
> +                       trace_seq_puts(s, " /*");
>                 else
> -                       trace_seq_printf(s, "%ps(); /* =3D %ld */\n",
> -                                       func, err_code);
> +                       trace_seq_putc(s, '\n');
>         } else {
> +               print_retaddr =3D false;
> +               trace_seq_printf(s, "} /* %ps", func);
> +       }
> +
> +       if (print_retval) {
>                 if (hex_format || (err_code =3D=3D 0))
> -                       trace_seq_printf(s, "} /* %ps =3D 0x%lx */\n",
> -                                       func, retval);
> +                       trace_seq_printf(s, " V=3D0x%lx", retval);
>                 else
> -                       trace_seq_printf(s, "} /* %ps =3D %ld */\n",
> -                                       func, err_code);
> +                       trace_seq_printf(s, " V=3D%ld", err_code);
>         }
> +
> +       if (print_retaddr)
> +               print_graph_retaddr(s, graph_ent, trace_flags, false);
> +
> +       if (!graph_ent || print_retval || print_retaddr)
> +               trace_seq_puts(s, " */\n");
>  }
>
>  #else
>
>  #define __TRACE_GRAPH_PRINT_RETVAL 0
> +#define __TRACE_GRAPH_PRINT_RETADDR 0
>
> -#define print_graph_retval(_seq, _retval, _leaf, _func, _format) do {} w=
hile (0)
> +#define print_graph_retval(_seq, _ent, _ret, _opt_flags, _trace_flags) d=
o {} while (0)
>
>  #endif
>
> @@ -746,9 +784,8 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>          * Write out the function return value if the option function-ret=
val is
>          * enabled.
>          */
> -       if (flags & __TRACE_GRAPH_PRINT_RETVAL)
> -               print_graph_retval(s, graph_ret->retval, true, (void *)ca=
ll->func,
> -                               !!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX))=
;
> +       if (flags & (__TRACE_GRAPH_PRINT_RETVAL | __TRACE_GRAPH_PRINT_RET=
ADDR))
> +               print_graph_retval(s, call, graph_ret, flags, tr->trace_f=
lags);
>         else
>                 trace_seq_printf(s, "%ps();\n", (void *)call->func);
>
> @@ -788,7 +825,10 @@ print_graph_entry_nested(struct trace_iterator *iter=
,
>         for (i =3D 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
>                 trace_seq_putc(s, ' ');
>
> -       trace_seq_printf(s, "%ps() {\n", (void *)call->func);
> +       trace_seq_printf(s, "%ps() {", (void *)call->func);
> +       if (flags & __TRACE_GRAPH_PRINT_RETADDR)
> +               print_graph_retaddr(s, call, tr->trace_flags, true);
> +       trace_seq_putc(s, '\n');
>
>         if (trace_seq_has_overflowed(s))
>                 return TRACE_TYPE_PARTIAL_LINE;
> @@ -1032,9 +1072,8 @@ print_graph_return(struct ftrace_graph_ret *trace, =
struct trace_seq *s,
>          * Always write out the function name and its return value if the
>          * function-retval option is enabled.
>          */
> -       if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
> -               print_graph_retval(s, trace->retval, false, (void *)trace=
->func,
> -                       !!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
> +       if (flags & (__TRACE_GRAPH_PRINT_RETVAL | __TRACE_GRAPH_PRINT_RET=
ADDR)) {
> +               print_graph_retval(s, NULL, trace, flags, tr->trace_flags=
);
>         } else {
>                 /*
>                  * If the return function does not have a matching entry,
> --
> 2.25.1
>
>


--=20
Thanks,
JeffXie
