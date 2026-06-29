Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8314071C8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739165; cv=pass; b=sR6sU0csgSUdlCzdkDG9J7oAE+gU35A0mnKeyhsHDf6d/ggS+mIU4/vh0sT1bd8iG1inObulT/POGgQacDoZBm541z17cbgygYkPenB6pD8ujHWnVD236gab3Xa2iLh5AWcsuSOFNfyuGhJGXX+dYNNyBJewgrncUjYZXZkR7H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739165; c=relaxed/simple;
	bh=VgXa8OotkXsc5lVCPZMWPb/vLUr+lpZ4UKRyqgNrIWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl20epOaOOFmAdbkbh0GqurXYfb9tZ1hnnc/+u4QfvEQFSWrVpKLMq50a+DCG8+lZgQUZhX5qLgvq6rFWyvkm903i2lFBqm3hPXRQPjZsXjl7t4aRv27PKhAngecMkLTMobbzoQHb+uSPqRJt9UzsUjgPAA4IR5BOXye33YBSeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw3zWm9x; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw3zWm9x"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso4778084a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 06:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782739162; cv=none;
        d=google.com; s=arc-20260327;
        b=ZWwLrpagKz4S9XFgGlFxHTW3Jti7j8Ddy6nE4HAcKupqhfchQ2CGm3AGMKYTJdifzm
         OVU0De9w6Jgy7TwEUeaOZPbXGTNfy3yxAwqVJS1W6hChrnDRXoXJDqlAG108W6sh6FNX
         6KpsYrSISzxmyMPL1NJrabPjIWXW1Obbf/6JqfOuZPwy5aLtVFfACHJ+TTj+kIBaXFRk
         3YPhcYyXn3kRRX3NpfUCrKo4PQkXiDHA3qz+2bJnRXjTmJHoueLERZCu/Lp9AlRBcxgq
         fZMtIaG3ZNjEs+T5w23QXnnwDyIBti8AxVwtKfP0XMS+bIpY21ta9xZHRIJrj97gsZom
         qmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3h/W0XWiSvohOP1AjCLVTKYd/vmWZejhF/L+6OXH4M=;
        fh=xpXLgpmhhGhE2Yo1wBxhIwWQc53Rpgc22TjfG4Uam84=;
        b=qEkPYhfGunt183hTMte/KxEk4TpAIxIwT60/z0YuYx8O4T0IGbvySn9do9PjKIsE6z
         1scuNY6C8NNz+V+V6aU9Y9kmblJ0o69oMU4BGCl5LANXCChqdPKeEVYftSGAJOuR8AYa
         WjToQICfCXWdDpwjsYsJch9S8dhWblHLPINxJXvotLzYlo+p5kYjGD2Xxp/fGiV9YZ+L
         iDZzO69kp8wO9jzVm4EQAJILFkZUCe5+028J0CtSaYPnpRJk9QBwDbCgPNn0H/bPm9yx
         uLtpeF91W4yLGrjrwYX7Mzs6lXovUNEyM73eEiHLO2RrXM4AJaqeHvJ9zDM7dlE6pXvU
         ZNcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739162; x=1783343962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3h/W0XWiSvohOP1AjCLVTKYd/vmWZejhF/L+6OXH4M=;
        b=Uw3zWm9xfKNptCshwtZQ+04/6HVNoduo30w/Yk2BCUqs8ab3PinjCQFJ1cmpLdv39I
         nHxebEL2cPXcXHmNg7SElzgCH4PEw50+ywc44X3sojqzIsMD6uvCQWfp8WhmYVF0za/o
         8+m+qZ7VHkP1uDpsrId1fak+Ip+wXPjoY/XTPVrZWNLF5PmQBnrsrPek+l1DDwBTFXDM
         PepYW/gns+9SXUr8kcAZlUd+nV2OZjxsid9d0+bGFT3zWj5fMRYUQjk1O3WcjJUjICFS
         vEisrTZHo4geiinEiqysYA4sgIH/Zz2F8s5bRamhvr60Bvc8QrG0ZXw6pBpOR2NAu5zk
         cSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739162; x=1783343962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3h/W0XWiSvohOP1AjCLVTKYd/vmWZejhF/L+6OXH4M=;
        b=eRxre2ed7MdNsg9rebn6w3c3AdSTxUr0Xmy4mZNv0PokYb3/ec3vrl30nT9x0YOFAN
         OJpPUagcdcJDF1zmUMr9fbgScJ4rPnux7d67JHywC4xL1txTlLsn+2XQwZaYyUpAP6LB
         sJ8Xkvc12uqjQhUtEjLfVHMWTQuA1JOqK5jggK0lwyr4e6WPRXfHOLRzaB01WdO0uAf6
         t5vsDfJsLqY1YJT09DCFxBQkbhyoD0SCm5GO9Fkxb/oQe2VRW6TmtkI3YO8K39tVtmB1
         CPP3u5M/kzZIcShfgPWNi+NvkL/l9knq/B4PYDxTIP3nw/cLIJWgy/oxLGs+G5hmBiv7
         /npw==
X-Forwarded-Encrypted: i=1; AHgh+RrK2pozGUBX4mhyUbdTQC9n7Jdk4+X+as1oB/oUtuO9uJXWOtJbMA3fs6UZIrJ097qYGLMTvH9rwDMpB4wCJr+YwWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lo+egDVnLV25srx5fToPZwWHoc7mJsseavDTsivfLBTp6LlF
	Ki7McJB5jig6HmkKxUKB31sZ/vrrm5EtwA80Ibhoyvb7c05BUUXF+r3OyZyO00obyXgHNhp4SQw
	jBpbmoqoVETbJ2P0DL44rV4/fAFF/2U0=
X-Gm-Gg: AfdE7clV2uQlXig6nikAbkWNatvtT7gtuzVKmxHZYM6kBKwKId4kkY7pSHVnG0/TKmv
	Iq1D0ch4Y9xpEpHp9cn3/ko6GnG4PMzBzeH5aRIiZb7Jb5VnODXH7kxC6eCWd0a+LbWvHRu9jlF
	hBjZytfHUsHWL+WL1Gj0OML0Xaj48NYlSCLZuxWJ34kjmuwIYOLB4YhtiocMKuvdhz46ZLS4S9O
	pJN2tZzZ/Gymh/5+NA0NtZAhi1MLMcm62X6Mjul71zzf7VgPMWXgOXnoibqykanQTLHUBdENQ==
X-Received: by 2002:a05:6402:a503:10b0:698:2f6d:cce with SMTP id
 4fb4d7f45d1cf-6982f6d0eb5mr3376940a12.4.1782739162411; Mon, 29 Jun 2026
 06:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
 <20251215034153.2367756-3-dolinux.peng@gmail.com> <20260513104758.6e64167e@gandalf.local.home>
In-Reply-To: <20260513104758.6e64167e@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 29 Jun 2026 21:19:11 +0800
X-Gm-Features: AVVi8CdmaMPz_fYrc-qy_9xfZZ5838GuDYDgMwYiajdRa56XDo91baTVPU0Vm5s
Message-ID: <CAErzpmt2wr8AYmfUvR5=Wm8JcLeCJ=W+Uhk5ZkzSKikaUzhn4w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fgraph: Enhance funcgraph-retval with BTF-based
 type-aware output
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:47=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Mon, 15 Dec 2025 11:41:52 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > The current funcgraph-retval implementation suffers from two accuracy
> > issues:
> >
> > 1. Void-returning functions still print a return value, creating
> >    misleading noise in the trace output.
> >
> > 2. For functions returning narrower types (e.g., char, short), the
> >    displayed value can be incorrect because high bits of the register
> >    may contain undefined data.
> >
> > This patch addresses both problems by leveraging BTF to obtain the exac=
t
> > return type of each traced kernel function. The key changes are:
> >
> > 1. Void function filtering: Functions with void return type no longer
> >    display any return value in the trace output, eliminating unnecessar=
y
> >    clutter.
> >
> > 2. Type-aware value formatting: The return value is now properly trunca=
ted
> >    to match the actual width of the return type before being displayed.
> >    Additionally, the value is formatted according to its type for bette=
r
> >    human readability.
> >
> > Here is an output comparison:
> >
> > Before:
> >  # perf ftrace -G vfs_read --graph-opts retval
> >  ...
> >  1)               |   touch_atime() {
> >  1)               |     atime_needs_update() {
> >  1)   0.069 us    |       make_vfsuid(); /* ret=3D0x0 */
> >  1)   0.067 us    |       make_vfsgid(); /* ret=3D0x0 */
> >  1)               |       current_time() {
> >  1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=3D0=
x187f886aec3ed6f5 */
> >  1)   0.352 us    |       } /* current_time ret=3D0x69380753 */
> >  1)   0.792 us    |     } /* atime_needs_update ret=3D0x0 */
> >  1)   0.937 us    |   } /* touch_atime ret=3D0x0 */
> >
> > After:
> >  # perf ftrace -G vfs_read --graph-opts retval
> >  ...
> >  2)               |   touch_atime() {
> >  2)               |     atime_needs_update() {
> >  2)   0.070 us    |       make_vfsuid(); /* ret=3D0x0 */
> >  2)   0.070 us    |       make_vfsgid(); /* ret=3D0x0 */
> >  2)               |       current_time() {
> >  2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
> >  2)   0.312 us    |       } /* current_time ret=3D0x69380649(trunc) */
> >  2)   0.753 us    |     } /* atime_needs_update ret=3Dfalse */
> >  2)   0.899 us    |   } /* touch_atime */
> >
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  kernel/trace/trace_functions_graph.c | 124 ++++++++++++++++++++++++---
> >  1 file changed, 111 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_=
functions_graph.c
> > index 17c75cf2348e..46b66b1cfc16 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -15,6 +15,7 @@
> >
> >  #include "trace.h"
> >  #include "trace_output.h"
> > +#include "trace_btf.h"
> >
> >  /* When set, irq functions might be ignored */
> >  static int ftrace_graph_skip_irqs;
> > @@ -120,6 +121,13 @@ enum {
> >       FLAGS_FILL_END   =3D 3 << TRACE_GRAPH_PRINT_FILL_SHIFT,
> >  };
> >
> > +enum {
> > +     RETVAL_FMT_HEX   =3D BIT(0),
> > +     RETVAL_FMT_DEC   =3D BIT(1),
> > +     RETVAL_FMT_BOOL  =3D BIT(2),
> > +     RETVAL_FMT_TRUNC =3D BIT(3),
> > +};
> > +
> >  static void
> >  print_graph_duration(struct trace_array *tr, unsigned long long durati=
on,
> >                    struct trace_seq *s, u32 flags);
> > @@ -865,6 +873,73 @@ static void print_graph_retaddr(struct trace_seq *=
s, struct fgraph_retaddr_ent_e
> >
> >  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_G=
RAPH_RETADDR)
> >
> > +static void trim_retval(unsigned long func, unsigned long *retval, boo=
l *print_retval,
> > +                     int *fmt)
>
> This function should really be in trace_btf.c and a stub when btf is not
> enabled.

Thanks, I will fix it.

>
> -- Steve
>
> > +{
> > +     const struct btf_type *t;
> > +     char name[KSYM_NAME_LEN];
> > +     struct btf *btf;
> > +     u32 v, msb;
> > +     int kind;
> > +
> > +     if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> > +             return;
> > +
> > +     if (lookup_symbol_name(func, name))
> > +             return;
> > +
> > +     t =3D btf_find_func_proto(name, &btf);
> > +     if (IS_ERR_OR_NULL(t))
> > +             return;
> > +
> > +     t =3D btf_type_skip_modifiers(btf, t->type, NULL);
> > +     kind =3D t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN;
> > +     switch (kind) {
> > +     case BTF_KIND_UNKN:
> > +             *print_retval =3D false;
> > +             break;
> > +     case BTF_KIND_STRUCT:
> > +     case BTF_KIND_UNION:
> > +     case BTF_KIND_ENUM:
> > +     case BTF_KIND_ENUM64:
> > +             if (kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BTF_KIND_U=
NION)
> > +                     *fmt =3D RETVAL_FMT_HEX;
> > +             else
> > +                     *fmt =3D RETVAL_FMT_DEC;
> > +
> > +             if (t->size > sizeof(unsigned long)) {
> > +                     *fmt |=3D RETVAL_FMT_TRUNC;
> > +             } else {
> > +                     msb =3D BITS_PER_BYTE * t->size - 1;
> > +                     *retval &=3D GENMASK(msb, 0);
> > +             }
> > +             break;
> > +     case BTF_KIND_INT:
> > +             v =3D *(u32 *)(t + 1);
> > +             if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_BOOL) {
> > +                     *fmt =3D RETVAL_FMT_BOOL;
> > +                     msb =3D 0;
> > +             } else {
> > +                     if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_SIGNED)
> > +                             *fmt =3D RETVAL_FMT_DEC;
> > +                     else
> > +                             *fmt =3D RETVAL_FMT_HEX;
> > +
> > +                     if (t->size > sizeof(unsigned long)) {
> > +                             *fmt |=3D RETVAL_FMT_TRUNC;
> > +                             msb =3D BITS_PER_LONG - 1;
> > +                     } else {
> > +                             msb =3D BTF_INT_BITS(v) - 1;
> > +                     }
> > +             }
> > +             *retval &=3D GENMASK(msb, 0);
> > +             break;
> > +     default:
> > +             *fmt =3D RETVAL_FMT_HEX;
> > +             break;
> > +     }
> > +}
> > +
