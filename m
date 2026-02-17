Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB925D1E9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771297804; cv=pass; b=lBFrlv+YHTxw2960B5qruuNE5cNMeREs0kWV+6yF4sQy2Ntc/BHPAMoxclaRDK26sCA6rFvNbwVWxqEGfa/yarYnuCFn3So6pzlv73aQjupvUKpAXOdDblE89BylF/C6qk9kO2yK72JPWe7o4Bsx8jfnMQqYZ+oOvfiofdui8wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771297804; c=relaxed/simple;
	bh=ofPs2sqR/7hFSXuz8Pb2PYyB7YnqTqlvrNO3he9vatU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoVNeqrZ+AhUqEhyVQDu8O/8GL7nXI4x9572eb5y1Uy/ZJj0kJkwrCYmAQZvkWqyLUkeSd6Y9o4KiuYtcsbOMW+5nYvL/T7HocqY6wxB+i8edNLeNq2+AHZcRgJTlJPyDfqgy4AmfYO8xhckEjaKtg9eHYdm6ai8jiZXQrRhgwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqwrfUNn; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqwrfUNn"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so6145308a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 19:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771297801; cv=none;
        d=google.com; s=arc-20240605;
        b=A+ERTljWEeiMM7e4tQLV0MowQjYgZQyC+Ot/ZAbeOGZAwEcn8R6s2NAxswgbqFLDcd
         AZ0wjAY92c946bVvCCHyTEQGL8kGem1rDzudEhKYEDMhI/jWXAS1TvKs8Z2qKXFif+Az
         TTTYdN5+6lwqOhIN7S691k2mv83dNj3diNFQ7PZpEGe5AffR7cNPpiHiwg/JSOgFfoxq
         oIZJTo7fP4jt0GClaPU9JTzwGvsDuvqIsir+eKxIKOMmq0eq9qey5w0/rcbAYpT1gCV+
         CNLmcjbvxxXBXRi3FKmXoHD5jJ9lIiYX80K69+wmtrMuCpPuTcwkszWJ8RiW5Mmv3xQG
         eeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVeS1RzWbIrQEXUvoiGlAynfQkUjpWHptVhp2OcNuKw=;
        fh=SFXLy/7slB7FgjAKTKbiPnrwv4J+btEVNHTUE9tyX6s=;
        b=jPExAb+jMpxPFoY4LM0AcZyxQPjrKJoNZxpql4w3JM2cYbwnT1JLrF//voXON9byq3
         84FwHG66NsyjY9dHOKNMq7oav4moPybZnGRpKz+2kyKVMINTMRi9Z5nV2UQaeDmWvtIS
         P/AunZ3p+3tLOJp3eq1JM55KWuFdNAKhpg7FzXWgIWr0xQROGAo57sXDYv0YZVlJBJUz
         AHKlUaExihg00dNcR1Ud3ezju+l4cqVmL7xkARxsF79ek6WN0tJ+Gf2nMIWX2HYx6W4/
         KEPZqYItMeiFqo4oqmoWmVM2EwNsVKyBlAxKjmJCwJPexWsrxU5bk62K0xlqX1wWnSDa
         sEpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771297801; x=1771902601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVeS1RzWbIrQEXUvoiGlAynfQkUjpWHptVhp2OcNuKw=;
        b=GqwrfUNn/EMjm7EBLBVbsb38DtRmBhmaTwjH6pZWNaRELoIZDCr/iXUlwO25X2jSwO
         nhvxlzLDtwIYfJeZPNDQ4LGeV43it7pJyScxqOHfk+BDbSSzGD84TlRmo1W47XfJTo+x
         VYEtBy6V9sSdXTQM8X/gRK+BW6UjwO20/HNuZ1m/oZN1/soC2TKEmEl45iyu/W/kxH+5
         QBqm8QJLnht4RiOE0ty7Yu+q/FG0/GI+GFGZDoknGdg4Gcnla8EAQiWEhv9xiuAMvN0t
         t9VULSYTmSwajzX6MTWmv2JlFKaBMjP2aBfYvZqTrQGFzd2rCLBUy/G93W4k3sAM2JkB
         D5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771297801; x=1771902601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVeS1RzWbIrQEXUvoiGlAynfQkUjpWHptVhp2OcNuKw=;
        b=WHm7g76OW+kttjTdRt7MgEKeM07rfcefnTGpaEnU7uHCRCIGmSKJZLFsYyJvuzSF08
         acR8xZrg1XwjSeShrwdvKJsLckzYdrPbIumPnsO54HuKgRLjMVOrNYltTkxw9zdrxnZl
         coWQg+1rlxkgKexd6/4+o+O3AvVBJ9C4/ex+ht3yqNXXAskros4rhzhWwTD0JpG0qhgl
         HBehDVy3+5anto0P15vpkFePm0MwstUbT5nD8v0Vn2HZxdTZbrfTeAKb1lcQaMtM/416
         jHP9aB6ZJRZnD2njRJ6C98O8arrxYAeUo43ovSesEAULSZeUMtraetOLbz7yZT90bZqM
         EBTw==
X-Gm-Message-State: AOJu0YyTciWO2oDQaD2F2i19pHKWK9XCmjMRpitAX6Osmb8M0+9nRWys
	Znq0vQBmLSSsmUdOZ4zqaR8QqslBtRNmzOJa1lU+qEKCI5ukjrl7S6i1UxlhkBk0RPDsy+FH9Wu
	9WasnQNB5rQ2NaQRWpS4oEwu3CDBtSK8=
X-Gm-Gg: AZuq6aIsiOmYf53HFCRlODQwXjq/lQlge651a6X29TtfeY+vDxmjaW0iFIJVCMU58XU
	mux9As8moFj4siFOLz4KcrfwCub7LoYv9fFTPKFt9qm1LnUWkfnpbTdJLSO8+VeEwH+1j5XIhpU
	PocbVJH/xR7BFu1Mk1QKUpMUFW59m7GQnCx3BYT9NCvHicvRe0oZ15THFIlUPO5my9Cotgg6hJ6
	DhfM2oWMCrHtNvdnPZ9ZjM/RGpdDDO5cpPE20IMBa4GAGVmvL8OT9WNKF/HSq6u+uQUCA5VmFhP
	iAPhGijUHilbZ6kPOfI=
X-Received: by 2002:a05:6402:5188:b0:64d:3b22:a5c2 with SMTP id
 4fb4d7f45d1cf-65bc7a80278mr4801989a12.25.1771297801216; Mon, 16 Feb 2026
 19:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAErzpmtMrHWQVAQx=jiq_sWo=+c_JOUoQmPafo-fq+Q3qi+BBw@mail.gmail.com>
 <20260216100935.645ea614@gandalf.local.home>
In-Reply-To: <20260216100935.645ea614@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 17 Feb 2026 11:09:50 +0800
X-Gm-Features: AaiRm50Qgnq07VEQRvnHb6bNZ0CQFbIYHHaMWNzoRqZ0rSkmR22MjGt03FSzRTA
Message-ID: <CAErzpmuP4cwHwykGYryCnLuBhBUUgUduWW-gcziGMFXr-G_h9w@mail.gmail.com>
Subject: Re: Enhancing Conditional Filtering for Function Graph Tracer
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 11:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Sat, 14 Feb 2026 18:36:24 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > To simplify implementation, I propose extending a new trigger type
> > (e.g., "funcgraph").
> > In ftrace_graph_ignore_func, we could look up the corresponding trace_f=
probe and
> > trace_event_file based on trace->func, then decide whether to trace
> > the function using
> > a helper like the following:
> >
> > static bool ftrace_graph_filter(struct trace_fprobe *tf, struct
> > ftrace_regs *fregs,
> >                                struct trace_event_file *trace_file)
> > {
> >     struct fentry_trace_entry_head *entry;
> >     struct trace_event_buffer fbuffer;
> >     struct event_trigger_data *data;
> >     int dsize;
> >
> >     dsize =3D __get_data_size(&tf->tp, fregs, NULL);
> >     entry =3D trace_event_buffer_reserve(&fbuffer, trace_file,
> >                                        sizeof(*entry) + tf->tp.size + d=
size);
> >     if (!entry)
> >         return false;
> >
> >     entry =3D ring_buffer_event_data(fbuffer.event);
> >     store_trace_args(&entry[1], &tf->tp, fregs, NULL, sizeof(*entry), d=
size);
> >
> >     list_for_each_entry_rcu(data, &trace_file->triggers, list) {
> >         if (data->cmd_ops->trigger_type =3D=3D TRIGGER_TYPE_FUNCGRAPH) =
{
> >             struct event_filter *filter =3D rcu_dereference_sched(data-=
>filter);
> >             if (filter && filter_match_preds(filter, entry))
> >                 return true; // Allow tracing
> >         }
> >     }
> >     return false; // Skip tracing
> > }
> >
> > Does this approach make sense? Any suggestions or concerns?
>
> My biggest concern is with performance. You want to run this against all
> functions being traced?
>
> How is this different than just using fprobes?

Thanks, my initial thought was to extend the functionality of set_graph_fun=
ction
for more granular tracing control. For instance, consider the function:

vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *=
pos):

1. Enable tracing when count exceeds a threshold (e.g., 4KB):

echo 'vfs_write if count >=3D 4096' > set_graph_function

2. Filter by PID and CPU:

echo 'vfs_write if pid =3D=3D 3456 && cpu =3D=3D 4' > set_graph_function

To implement this, we would need data structures like trace_probe,
trace_event_call, and trace_event_file. Reusing trace_fprobe might
reduce redundant implementation, however, it's unclear whether this
approach is feasible without introducing unforeseen complexities.

To minimize performance overhead, an intermediate data structure
could be introduced when writing to set_graph_function. For example:

struct funcgraph_data {
    unsigned long entry_ip;            // Entry address of vfs_write
    struct trace_event_file *file;     // Associated trace event file
};

This structure would be added to a hash table (funcgraph_hash). At the
entry point of each instrumented function, the execution flow would
proceed as follows:

ftrace_graph_func
 =E2=86=92 function_graph_enter_regs
      =E2=86=92 trace_graph_entry_args
           =E2=86=92 graph_entry
               =E2=86=92 ftrace_graph_ignore_fun
                   =E2=86=92 ftrace_graph_filter(struct ftrace_graph_ent *t=
race)

Within ftrace_graph_filter, the hash table funcgraph_hash is first queried
using trace->func. If a matching funcgraph_data is found,
ftrace_graph_filter is subsequently invoked with funcgraph_data->file
to apply the filter logic.

>
> -- Steve
