Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B455309DDB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066841; cv=pass; b=AgLZgYel7VDcnG/bmosyvl4NBv3xpqo1SQ4zNjiDRTxpyDw+7OQ/L/1fYgA0LVGOJU3TkhrgpJ8DuUBdQoSr+3Qq0oQn4PPB++FnzfDBTl3ULi8migrktcWX2Js9KSPqFvfz02boKtZLIzeiCy7vKb0RZauK4KuWaooHwW1bn6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066841; c=relaxed/simple;
	bh=XTlTr8YQOXmzitxjPpyK2Xq/F2QYKxjL9DWYrv2FS24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJVqvy1QhisbK0iQq7vNHzFHYECMdQ/vhaF0rutWeztBkWbs7WaAvVOmA/rk3+vnr1xKOwVQan1S/YkvMnf5YWkfio6gFPp+aphgRBPWAcV/RwZsSG57vN/mFwFBo+PemtY1zJTvU/w1WM0+RYeZBf9hNHbGAzQfR4ggr3wMwNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mupJ3m+n; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mupJ3m+n"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2591757fbso15585ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 11:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775066839; cv=none;
        d=google.com; s=arc-20240605;
        b=VaoiLqukNXaSwNSwJ74CpWed0N0INII+E2kUtv0EtzZa8+G5yrAPRKgs1hpQnQl7/G
         8sd8mO7eXfy9aFtTzMb0Jq0nCBn4D5XRuzJ3i6HG1ne9n1D6fLyy+POxwCJZtITHi6rp
         O1qIBt1cGGbAh/APnO/1Bm8Y7jkG/CbCx+t8J1mftZl8tleMy6Q2fAWlfUklUHuVVLTj
         0yzMKnTyY6lnI/rYfN54RiWQGcLjKRlU86AqW7Xe71KmFhSta/s4AETAfAYkMM6kPNly
         BE8j5mZshmmnskzBzpF4mbu5iUE76pe/c+hQgUhds9Hb2qEGXhv8MU/Naf1r+O7zEi8o
         NF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xINK8C/6vaB9JKV4qpp3uRlYtel8DKPI8RfVKcH9Qrs=;
        fh=emgppWrdNXBxtRWXFCxKyVB3OoRAwesUAeaoFLOCdGc=;
        b=DY1I6pahRt6CYNLk+bxlmoStX0CBg414e0bgwLto8jpnbwf2uE9Lo4HLwksSeAqOOV
         3tEW2BCVj9dw2YvzH0CmulFIGwaDHQFnhakQKQrJsav1DxV3Io9wNnVJoEWZfQjhSfuI
         ilBH/L++Xaz4H6gjV9XyisrgeY+HJax4NdaC7BXv856p4NFBLBgH08IHgHChVmd0U8Fn
         S2JE6GGsehTAeQmTTk/NeoWXbpynUD2OmXCM5toDr6PHoA449eA6lOwj1nbv7d/xaokM
         gsL92twDQZHROArdwr/rY6OYfibAf+e2HJitoMKVYC/dNz6QOKUfMSEUHzZWo93g7GLl
         SheA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775066839; x=1775671639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xINK8C/6vaB9JKV4qpp3uRlYtel8DKPI8RfVKcH9Qrs=;
        b=mupJ3m+nLyjWTjeoskYynIo4DKWtMNbjggA/5xUN+eOOj+OLCvpona3g2EaH/Do+Od
         HcLLartdGckBjBteb0SfJjPv9MeHPWCyiXG3fJ1FK0VFJp9nMFC7jgpQeHffOjn+FK6z
         s3W4swBF+XM49adAaetTzJ8/E+riMERH7WLj/rjgaoXr47VaAbjki9Pl/l7CQSaIqEbp
         6lEFdK1mfbF96PJn0riyjmOO34MZAicvl4M+y4UFeZ2h3s6dibCo+bYrIdrGCS1a+oXX
         H1iRmj+4APvkpkx3sI4w3Ik09GRjbVA1f34tj1woZPBQE8J5y128v7JNMhFNzGR8LytS
         5+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775066839; x=1775671639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xINK8C/6vaB9JKV4qpp3uRlYtel8DKPI8RfVKcH9Qrs=;
        b=r2RIzpB/5pJYHJmVuYxDX3bVAxh/ZS88aZBK3QgBnT6i+RfxDsjRMdZtJl9zqtYm43
         Yh6Ro/4omPqO0gpMqCrm3PI6WqIfUitLw0QjzykSLykMpD85FHdaAZZLCrKbWsyRB+eS
         CGfLltNpplFjo1+tVfsN4fyj3CLZ6G68Go9a2Aw7RbNLDCBYQZNItziznQUHkmmWhWUe
         xRPrZxLKLmgUK2H0fPg8oHyIr9Jp7WM1rdvIk0dHZEBvh0bIhyrKkzNP6KN0x9OEwVsg
         rvInkXgb3C6AnmntucXkAYp4suio9as0EiJKUQ1NY4HIFzX/G6ohXIv4CPPR21o5TULx
         4FRg==
X-Forwarded-Encrypted: i=1; AJvYcCVVECkSXaQdd5Z/lIDlzUzPeWtY21c2vZxi35B77ecnSCtqhY84JNhQYqcddyIXpcN0pDIdue5/Dl0kR+SCAs6ONmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS5zxnMDHF+s41jBkJysPmZXCFpyG/L/jiqkTMbTA3h2seuORX
	IE0rxR+V+SZIvncKyiuqWGcyYrqgKc78QKEyd9WdEm7j5np7OO6LOoJFfSTSZhhxcErLzO5JV9M
	72ZVFQU4hmQKqZek5fkZFBxmGu/FIufFkw71cnuOE
X-Gm-Gg: ATEYQzx3alh2OuaIh6KW2rW1FaGVkDgXrpZTRN6GgCihC23ah4viU9SFHIevO3kQ/ak
	YOuro42j8cTRWGD8DfYzOLjZZBV6MO9E/CCvYEJTReRyBwdOdUa/rN012Qanrb3aibx3X2RakqP
	2cCpN7snTOvL7q9kIhU7PWYTYS6nZsJLr764oSU+eFMWeOEDa77SZvTIc82XoR3PqHevmh6O4Bg
	H7vaq9HKXTXZBPjECTdFudN4J2IBxEV3bu/JpLgFS39+XkvoxCu2S79krMkOl84nrABhLYm+OCB
	9WF8IJ2zC7HLeVjDAcw86XyEdMCiQ/bYlLIp
X-Received: by 2002:a17:902:ccd0:b0:2b0:b458:2dc3 with SMTP id
 d9443c01a7336-2b276126f0emr223795ad.21.1775066838303; Wed, 01 Apr 2026
 11:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331181349.062575155@kernel.org> <20260331181432.995263521@kernel.org>
In-Reply-To: <20260331181432.995263521@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 11:07:07 -0700
X-Gm-Features: AQROBzBhlxj8XzCMjMYFW3UW08ozZkyTyS8j7oIjxR7W1afbMudbU8_igfOd0mk
Message-ID: <CAP-5=fWxhLrMTwteTedGVeUg8uz=xzF+_3Q4qFnxB=TaKR9D8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] tracing: Have futex syscall trace event show
 specific user data
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Brian Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>, 
	Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:13=E2=80=AFAM Steven Rostedt <rostedt@kernel.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Add specific reporting of the futex system call. This allows for debuggin=
g
> the futex code a bit easier. Instead of just showing the values passed
> into the futex system call, read the value of the user space memory
> pointed to by the addr parameter.
>
> Also make the op parameter more readable by parsing the values to show
> what the command is:
>
>  futex_requeue_p-3251    [002] .....  2101.068479: sys_futex(uaddr: 0x55e=
79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
>  futex_requeue_p-3248    [001] .....  2101.068970: sys_futex(uaddr: 0x7f8=
59072f990 (0xcb2), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, val: 3250)

nit: Would this read better if `val` were also hex?
futex_requeue_p-3248    [001] .....  2101.068970: sys_futex(uaddr:
0x7f859072f990 (0xcb2), FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, val:
0xcb2)
The val matching the value in uaddr is the condition necessary for the
futex to sleep.

>  futex_requeue_p-3252    [005] .....  2101.069108: sys_futex(uaddr: 0x55e=
79a4da838 (0), FUTEX_WAIT_REQUEUE_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: =
0x7ffe61076aa0, uaddr2: 0x55e79a4da834, uaddr2: 94453214586932, val3: 0)
>  futex_requeue_p-3252    [005] .....  2101.069410: sys_futex(uaddr: 0x55e=
79a4da834 (0x80000cb1), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v2: https://patch.msgid.link/20260310201036.542627924@kerne=
l.org
>
> - Removed unused "buf" variable (kernel test robot)
>
> - Iterate __futex_cmds[] make the print statement.
>   Note this required exposing __futex_cmds[] to trace_syscall.c
>
> - Added back val statement (with the move to futex/syscall.c the
>   third parameter was dropped).
>
>  include/linux/futex.h         |   8 +-
>  kernel/futex/syscalls.c       |  97 +++++++++++++++++++++++
>  kernel/trace/trace_syscalls.c | 144 +++++++++++++++++++++++++++++++++-
>  3 files changed, 245 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/futex.h b/include/linux/futex.h
> index 9e9750f04980..7eaf01ff68cf 100644
> --- a/include/linux/futex.h
> +++ b/include/linux/futex.h
> @@ -82,6 +82,11 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktim=
e_t *timeout,
>               u32 __user *uaddr2, u32 val2, u32 val3);
>  int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned lo=
ng arg4);
>
> +#ifdef CONFIG_FTRACE_SYSCALLS
> +void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *=
args, u32 *ptr);
> +extern const char * __futex_cmds[];
> +#endif
> +
>  #ifdef CONFIG_FUTEX_PRIVATE_HASH
>  int futex_hash_allocate_default(void);
>  void futex_hash_free(struct mm_struct *mm);
> @@ -114,7 +119,8 @@ static inline int futex_hash_allocate_default(void)
>  }
>  static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
>  static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
> -
> +static inline void futex_print_syscall(struct seq_buf *s, int nr_args,
> +                                      unsigned long *args, u32 *ptr) { }
>  #endif
>
>  #endif
> diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
> index 743c7a728237..3ba8ca017c9c 100644
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -171,6 +171,18 @@ static __always_inline bool futex_cmd_has_timeout(u3=
2 cmd)
>         return false;
>  }
>
> +static __always_inline bool futex_cmd_has_addr2(u32 cmd)
> +{
> +       switch (cmd) {
> +       case FUTEX_REQUEUE:
> +       case FUTEX_CMP_REQUEUE:
> +       case FUTEX_WAKE_OP:
> +       case FUTEX_WAIT_REQUEUE_PI:
> +               return true;
> +       }
> +       return false;
> +}
> +
>  static __always_inline int
>  futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
>  {
> @@ -207,6 +219,91 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op,=
 u32, val,
>         return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime,=
 val3);
>  }
>
> +#ifdef CONFIG_FTRACE_SYSCALLS
> +
> +/* End with NULL for iterators */
> +const char * __futex_cmds[] =3D
> +{
> +       "FUTEX_WAIT", "FUTEX_WAKE", "FUTEX_FD", "FUTEX_REQUEUE",
> +       "FUTEX_CMP_REQUEUE", "FUTEX_WAKE_OP", "FUTEX_LOCK_PI",
> +       "FUTEX_UNLOCK_PI", "FUTEX_TRYLOCK_PI", "FUTEX_WAIT_BITSET",
> +       "FUTEX_WAKE_BITSET", "FUTEX_WAIT_REQUEUE_PI", "FUTEX_CMP_REQUEUE_=
PI",
> +       "FUTEX_LOCK_PI2", NULL
> +};
> +
> +void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *=
args, u32 *ptr)
> +{
> +       unsigned int op, cmd;
> +       bool done =3D false;
> +
> +       for (int i =3D 0; !done && i < nr_args; i++) {
> +
> +               if (seq_buf_has_overflowed(s))
> +                       break;
> +
> +               switch (i) {
> +               case 0:
> +                       seq_buf_printf(s, "uaddr: 0x%lx", args[i]);
> +                       if (ptr) {
> +                               u32 val =3D *ptr;
> +                               if (val < 10)
> +                                       seq_buf_printf(s, " (%u)", val);
> +                               else
> +                                       seq_buf_printf(s, " (0x%x)", val)=
;
> +                       }
> +                       continue;
> +               case 1:
> +                       op =3D args[i];
> +                       cmd =3D op & FUTEX_CMD_MASK;
> +                       if (cmd <=3D FUTEX_LOCK_PI2)
> +                               seq_buf_printf(s, ", %s", __futex_cmds[cm=
d]);
> +                       else
> +                               seq_buf_puts(s, ", UNKNOWN");
> +
> +                       if (op & FUTEX_PRIVATE_FLAG)
> +                               seq_buf_puts(s, "|FUTEX_PRIVATE_FLAG");
> +                       if (op & FUTEX_CLOCK_REALTIME)
> +                               seq_buf_puts(s, "|FUTEX_CLOCK_REALTIME");
> +                       continue;
> +               case 2:
> +                       if (args[i] < 10)
> +                               seq_buf_printf(s, ", val: %ld", args[i]);
> +                       else
> +                               seq_buf_printf(s, ", val: 0x%lx", args[i]=
);

I'm confused why this hex formatting didn't appear in the sample output.

Thanks,
Ian

> +                       continue;
> +               case 3:
> +                       if (!futex_cmd_has_timeout(cmd)) {
> +
> +                               if (!futex_cmd_has_addr2(cmd)) {
> +                                       done =3D true;
> +                                       continue;
> +                               }
> +
> +                               seq_buf_printf(s, ", val2: 0x%x", (u32)(l=
ong)args[i]);
> +                               continue;
> +                       }
> +
> +                       if (!args[i])
> +                               continue;
> +
> +                       seq_buf_printf(s, ", timespec: 0x%lx", args[i]);
> +                       continue;
> +               case 4:
> +                       if (!futex_cmd_has_addr2(cmd)) {
> +                               done =3D true;
> +                               continue;
> +                       }
> +                       seq_buf_printf(s, ", uaddr2: 0x%lx", args[i]);
> +                       continue;
> +               case 5:
> +                       seq_buf_printf(s, ", val3: %lu", args[i]);
> +                       done =3D true;
> +                       continue;
> +               }
> +       }
> +}
> +#endif
> +
>  /**
>   * futex_parse_waitv - Parse a waitv array from userspace
>   * @futexv:    Kernel side list of waiters to be filled
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
> index 37317b81fcda..f8213d772f89 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -6,11 +6,13 @@
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>      /* for MODULE_NAME_LEN via KSYM_SYMBOL_LE=
N */
> +#include <linux/futex.h>
>  #include <linux/ftrace.h>
>  #include <linux/perf_event.h>
>  #include <linux/xarray.h>
>  #include <asm/syscall.h>
>
> +
>  #include "trace_output.h"
>  #include "trace.h"
>
> @@ -237,6 +239,27 @@ sys_enter_openat_print(struct syscall_trace_enter *t=
race, struct syscall_metadat
>         return trace_handle_return(s);
>  }
>
> +static enum print_line_t
> +sys_enter_futex_print(struct syscall_trace_enter *trace, struct syscall_=
metadata *entry,
> +                     struct trace_seq *s, struct trace_event *event, int=
 ent_size)
> +{
> +       void *end =3D (void *)trace + ent_size;
> +       void *ptr;
> +
> +       /* Set ptr to the user space copied area */
> +       ptr =3D (void *)trace->args + sizeof(unsigned long) * entry->nb_a=
rgs;
> +       if (ptr + 4 > end)
> +               ptr =3D NULL;
> +
> +       trace_seq_printf(s, "%s(", entry->name);
> +
> +       futex_print_syscall(&s->seq, entry->nb_args, trace->args, ptr);
> +
> +       trace_seq_puts(s, ")\n");
> +
> +       return trace_handle_return(s);
> +}
> +
>  static enum print_line_t
>  print_syscall_enter(struct trace_iterator *iter, int flags,
>                     struct trace_event *event)
> @@ -267,6 +290,10 @@ print_syscall_enter(struct trace_iterator *iter, int=
 flags,
>                 if (!tr || !(tr->trace_flags & TRACE_ITER(VERBOSE)))
>                         return sys_enter_openat_print(trace, entry, s, ev=
ent);
>                 break;
> +       case __NR_futex:
> +               if (!tr || !(tr->trace_flags & TRACE_ITER(VERBOSE)))
> +                       return sys_enter_futex_print(trace, entry, s, eve=
nt, iter->ent_size);
> +               break;
>         default:
>                 break;
>         }
> @@ -437,6 +464,48 @@ sys_enter_openat_print_fmt(struct syscall_metadata *=
entry, char *buf, int len)
>         return pos;
>  }
>
> +static int __init
> +sys_enter_futex_print_fmt(struct syscall_metadata *entry, char *buf, int=
 len)
> +{
> +       int pos =3D 0;
> +
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       "\"uaddr: 0x%%lx (0x%%lx) cmd=3D%%s%%s%%s");
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       "  val: 0x%%x timeout/val2: 0x%%llx");
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       " uaddr2: 0x%%lx val3: 0x%%x\", ");
> +
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       " REC->uaddr,");
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       " REC->__value,");
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       "  __print_symbolic(REC->op & 0x%x, ", FUTEX_CMD_=
MASK);
> +
> +       for (int i =3D 0; __futex_cmds[i]; i++) {
> +               pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                               "%s{%d, \"%s\"} ",
> +                               i ? "," : "", i, __futex_cmds[i]);
> +       }
> +
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO, "), ");
> +
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       " (REC->op & %d) ? \"|FUTEX_PRIVATE_FLAG\" : \"\"=
,",
> +                       FUTEX_PRIVATE_FLAG);
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       " (REC->op & %d) ? \"|FUTEX_CLOCK_REALTIME\" : \"=
\",",
> +                       FUTEX_CLOCK_REALTIME);
> +
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       " REC->val, REC->utime,");
> +
> +       pos +=3D snprintf(buf + pos, LEN_OR_ZERO,
> +                       " REC->uaddr, REC->val3");
> +       return pos;
> +}
> +
>  static int __init
>  __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len=
)
>  {
> @@ -447,6 +516,8 @@ __set_enter_print_fmt(struct syscall_metadata *entry,=
 char *buf, int len)
>         switch (entry->syscall_nr) {
>         case __NR_openat:
>                 return sys_enter_openat_print_fmt(entry, buf, len);
> +       case __NR_futex:
> +               return sys_enter_futex_print_fmt(entry, buf, len);
>         default:
>                 break;
>         }
> @@ -523,6 +594,21 @@ static void __init free_syscall_print_fmt(struct tra=
ce_event_call *call)
>                 kfree(call->print_fmt);
>  }
>
> +static int __init futex_fields(struct trace_event_call *call, int offset=
)
> +{
> +       char *arg;
> +       int ret;
> +
> +       arg =3D kstrdup("__value", GFP_KERNEL);
> +       if (WARN_ON_ONCE(!arg))
> +               return -ENOMEM;
> +       ret =3D trace_define_field(call, "u32", arg, offset, sizeof(int),=
 0,
> +                                FILTER_OTHER);
> +       if (ret)
> +               kfree(arg);
> +       return ret;
> +}
> +
>  static int __init syscall_enter_define_fields(struct trace_event_call *c=
all)
>  {
>         struct syscall_trace_enter trace;
> @@ -544,6 +630,9 @@ static int __init syscall_enter_define_fields(struct =
trace_event_call *call)
>                 offset +=3D sizeof(unsigned long);
>         }
>
> +       if (!ret && meta->syscall_nr =3D=3D __NR_futex)
> +               return futex_fields(call, offset);
> +
>         if (ret || !meta->user_mask)
>                 return ret;
>
> @@ -689,6 +778,45 @@ static int syscall_copy_user_array(char *buf, const =
char __user *ptr,
>         return 0;
>  }
>
> +static int
> +syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf=
_size)
> +{
> +       struct syscall_user_buffer *sbuf;
> +       const char __user *ptr;
> +
> +       /* buf_size of zero means user doesn't want user space read */
> +       if (!buf_size)
> +               return -1;
> +
> +       /* If the syscall_buffer is NULL, tracing is being shutdown */
> +       sbuf =3D READ_ONCE(syscall_buffer);
> +       if (!sbuf)
> +               return -1;
> +
> +       ptr =3D (char __user *)args[0];
> +
> +       *buffer =3D trace_user_fault_read(&sbuf->buf, ptr, 4, NULL, NULL)=
;
> +       if (!*buffer)
> +               return -1;
> +
> +       /* Add room for the value */
> +       *size +=3D 4;
> +
> +       return 0;
> +}
> +
> +static void syscall_put_futex(struct syscall_metadata *sys_data,
> +                             struct syscall_trace_enter *entry,
> +                             char *buffer)
> +{
> +       u32 *ptr;
> +
> +       /* Place the futex key into the storage */
> +       ptr =3D (void *)entry->args + sizeof(unsigned long) * sys_data->n=
b_args;
> +
> +       *ptr =3D *(u32 *)buffer;
> +}
> +
>  static char *sys_fault_user(unsigned int buf_size,
>                             struct syscall_metadata *sys_data,
>                             struct syscall_user_buffer *sbuf,
> @@ -905,6 +1033,9 @@ static void ftrace_syscall_enter(void *data, struct =
pt_regs *regs, long id)
>                 if (syscall_get_data(sys_data, args, &user_ptr,
>                                      &size, user_sizes, &uargs, tr->sysca=
ll_buf_sz) < 0)
>                         return;
> +       } else if (syscall_nr =3D=3D __NR_futex) {
> +               if (syscall_get_futex(args, &user_ptr, &size, tr->syscall=
_buf_sz) < 0)
> +                       return;
>         }
>
>         size +=3D sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_a=
rgs;
> @@ -921,6 +1052,9 @@ static void ftrace_syscall_enter(void *data, struct =
pt_regs *regs, long id)
>         if (mayfault)
>                 syscall_put_data(sys_data, entry, user_ptr, size, user_si=
zes, uargs);
>
> +       else if (syscall_nr =3D=3D __NR_futex)
> +               syscall_put_futex(sys_data, entry, user_ptr);
> +
>         trace_event_buffer_commit(&fbuffer);
>  }
>
> @@ -971,14 +1105,18 @@ static int reg_event_syscall_enter(struct trace_ev=
ent_file *file,
>  {
>         struct syscall_metadata *sys_data =3D call->data;
>         struct trace_array *tr =3D file->tr;
> +       bool enable_faults;
>         int ret =3D 0;
>         int num;
>
>         num =3D sys_data->syscall_nr;
>         if (WARN_ON_ONCE(num < 0 || num >=3D NR_syscalls))
>                 return -ENOSYS;
> +
> +       enable_faults =3D sys_data->user_mask || num =3D=3D __NR_futex;
> +
>         guard(mutex)(&syscall_trace_lock);
> -       if (sys_data->user_mask) {
> +       if (enable_faults) {
>                 ret =3D syscall_fault_buffer_enable();
>                 if (ret < 0)
>                         return ret;
> @@ -986,7 +1124,7 @@ static int reg_event_syscall_enter(struct trace_even=
t_file *file,
>         if (!tr->sys_refcount_enter) {
>                 ret =3D register_trace_sys_enter(ftrace_syscall_enter, tr=
);
>                 if (ret < 0) {
> -                       if (sys_data->user_mask)
> +                       if (enable_faults)
>                                 syscall_fault_buffer_disable();
>                         return ret;
>                 }
> @@ -1011,7 +1149,7 @@ static void unreg_event_syscall_enter(struct trace_=
event_file *file,
>         WRITE_ONCE(tr->enter_syscall_files[num], NULL);
>         if (!tr->sys_refcount_enter)
>                 unregister_trace_sys_enter(ftrace_syscall_enter, tr);
> -       if (sys_data->user_mask)
> +       if (sys_data->user_mask || num =3D=3D __NR_futex)
>                 syscall_fault_buffer_disable();
>  }
>
> --
> 2.51.0
>
>
