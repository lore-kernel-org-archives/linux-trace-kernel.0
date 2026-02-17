Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7874238C03
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771297797; cv=pass; b=S6SYdhLHatS6Qmu6lCAtlLO2dNB6gOL6uazdND4zWpnlCSOo2mwxg/+dxLQuI3Maj6YAxjpFk1UPAcY8YR8uhYpeJB8jdwGlTI1+c38BIBVf9Ei5Mof87B+uMBsZf3JXdaVDEZZa0EEUow0eK60/ChAuvJt7V36VvwoqCHgKqxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771297797; c=relaxed/simple;
	bh=WNJ7CArScZ/+Vc2sAVn4A+RrE6Rft2bUxLR+tPKvz+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyHz3mUflCtxNuq9WBMLueb34wq3VXld+2grYqGmn2sDHy1smXi+eP68/n3xfGFl54x4Nk7sBWNxrzDk/uyRbyaOAATaYQ6yTiiLirT7jx1DQGz8VbWEoBR+0udDnihOo0fDQB+ojdF5AL/GQRMdtVLGRF6JhVVsAeq/tA7dwDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtX//paM; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtX//paM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so2711205a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 19:09:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771297794; cv=none;
        d=google.com; s=arc-20240605;
        b=liP3cPbERJ32NydhFxquo53qaJ0LjCFhc2MjJlC8doZo8lyC0QdR6/uj4Etoz1vrPL
         8NR1cTVDbyhp0/QyX4Zxd9sANN48FccnTDeUULmqvT+4oBoo9lfT3VEePYpvshXFuIFX
         KhSzPzIu74RlI9R1W8pbKjZt/zIA819MoOLgXcB15Sc8Yn1ADBebiEIpcoByDzIZStV+
         pU6pg5/GSHhsr/yNUCTM/a1I+ibo8HhV/6qUM9DMi+naWrM0tzxb9r4va6qnQtEb7tCB
         1Nx9UxsFGdENWCwIPDnJYWB0wqTzhElw1OD3wUUk2YUfu8PT2qYWyjqUyadH8VJiYN0W
         DbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AtABjezky6jspX54oKQuWBarwSsaWGJQ+140qN8QzQQ=;
        fh=mUYO/DvgIStqDUgmHtD6VqZ6DQ9ZQz28yqzkQIYrqGU=;
        b=AC/uS4F39wCP+Co+xkVCHOF56nekPP+dslrJwwn6vI14Ml6OP5JenA35HqnMh5iPgi
         bUHT+ur5NhSh5DYCL5aXv3fOVokkR43mCjTxWuXCHPxciHusKfMaLt79pIcRfA0o9zvb
         5NPSyyjSu1rajCsLv2qnEYRu7WlIlfiNPXBaPK6+b8A87/yXDQODqV+H2MV9O15CJD2w
         mTHLCf25tN9vO2J2Q7w6tBPWlpQdpD1vU80SBQmG6Na5QZcO3tklLemp/EXe4pTmgc7J
         lsr4QmN3inwm6bt0wfJFNerQTKYEzTwhvQRsu2k2lDbbfku/DEf6N/ltxwCmTfH3iDDu
         MayA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771297794; x=1771902594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtABjezky6jspX54oKQuWBarwSsaWGJQ+140qN8QzQQ=;
        b=XtX//paM8awkoxcrn3X/bNUL5sXOe/mwl7oMfWVIvf0sDegP6Dny8TeQ/Gw5trKZ+x
         O1xU73mRjjm7pDbAyTX3ifxA0yLSdnIMVt9KZXMXCrTH2ZD2WL6T2rlKMcLVjYcnj848
         Jk0wAlgR2K02qtdMfqddLACLWQi0rtt5vLj3zHHk/ZKZyUbsZGl0umGaOu0nf+DX+vPH
         SRWGIQk5O4T5AbPH5+j3jSDWRATxHWMx2nzreUSwPnLTEaGsPz1I2WK9bFy0FRLCbW/j
         20CFkmccXmin+91X05R5SiSoOrbUTOkylk0ydwqfxmgFl4Xl1Y0zu3osq0MKp1oZGkFb
         CAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771297794; x=1771902594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtABjezky6jspX54oKQuWBarwSsaWGJQ+140qN8QzQQ=;
        b=eqNX+/wk9C61x95zf2ZaGZqqb5cdw7lasfD2qSjoXKbwTbajjT/IqA6pk9lMJXBEFT
         bS1EUWndCyDv+tFpeKBjmoJBb293lqiRqetPZd+4VNRvw3FUPaHlOT2/a9GnCsJ3Z6EJ
         qCjrmdgv6mPSk5lmYsgC5ycEgz46v05V4QU/mda3Mrro2tHvHsIh2LeWY7v2IvUTYcDP
         /jwcRqq1Cawzl8VhRQueQsjLAr0su4ikSuv88sOLI07POLFjOsieCraSYuByLWFrrbLv
         kJHqTrGWwLP1iEOr4XQDTUaVO6W0WLXW627eHkCgNKrIZ9OshNWPCjp54vwzPJscrmZx
         A1TA==
X-Forwarded-Encrypted: i=1; AJvYcCXHSk41KqTZYV/Ra7Ovqn3x6XO8d2nRKKfAzGL1ae38Fjq39z3s1vMSxVfT2kxHW0ZJecha6dMGImTb6QwMd8A+olU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJFb5OoMvMIhNeauZDQrGHkqtQuiXLyQkWQJxk9uIEfgyVrEc
	6xf9MvpSwZMPlLbW9EnPYL00Aw3hQmm4ICZqItWI2r1diON4i7c+9+yuge0ew/O9k36KQhJ1CKb
	jZB5Jo58MAQhu4S0y82JvgV54Tbo9cMA=
X-Gm-Gg: AZuq6aJXvI8e8FI5VV88Es+zinvJliGiwgerxaMOQbXRbHMOtCH8YtzMk8aSL8SS1kQ
	sZfo1XN/FgUdu3F2FzUCHJOrDO0TYY1yX4UT/dNI0kBNOZ5areDWcdU2/+dVUUN7WRvzRoAEoci
	2h/yRc5LAEcp0fCvB2Rx7Uz21B8MYaVryYVXRY7iBKD5LfutBlAios0TG30/wz8oX13bjzSKvPT
	SyoyGTkV8snDt8Ct/iq9KkIeciZB9/G5Kp+VFflgMeNfE3m9fSLxqqDqlYfLZUjoTj4JzbTDUEP
	0gKn8wbr
X-Received: by 2002:a05:6402:34cd:b0:658:cbf0:6a08 with SMTP id
 4fb4d7f45d1cf-65bc7881b3emr4943695a12.17.1771297793968; Mon, 16 Feb 2026
 19:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAErzpmtMrHWQVAQx=jiq_sWo=+c_JOUoQmPafo-fq+Q3qi+BBw@mail.gmail.com>
 <20260216162716.dc8ec2f3f2fe409b6c11e491@kernel.org>
In-Reply-To: <20260216162716.dc8ec2f3f2fe409b6c11e491@kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 17 Feb 2026 11:09:42 +0800
X-Gm-Features: AaiRm52eNhFxUnDc-5IFjB_-kEm0gFZANns-vh_sOX7__Is6ulViyUIBoOfK0JI
Message-ID: <CAErzpmtXmc_ibbVHXh_k91CJyq52KJ-N4m5fwjw=QVKcSdEdkw@mail.gmail.com>
Subject: Re: Enhancing Conditional Filtering for Function Graph Tracer
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 3:27=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Sat, 14 Feb 2026 18:36:24 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Hi Steve and Masami,
> >
> > I recently had an idea while using the function graph tracer.
> > Currently, it supports basic
> > filtering via set_ftrace_pid(PID-based) and
> > set_graph_function(function name-based).
> > However, this filtering mechanism feels somewhat limited. Given that
> > we already have
> > features like funcgraph-args, I wonder if we could enhance filtering by=
 allowing
> > conditional tracking based on function parameters =E2=80=94 similar to =
how
> > trace events support
> > filters/triggers.
>
> Agreed. I think it is a good idea.
>
> >
> > To simplify implementation, I propose extending a new trigger type
> > (e.g., "funcgraph").
>
> OK, and I think the question is what do we want to filter. As you know,
> the kernel function call-graph is a very context depending. I think we
> may be better to start with specifying the pid filter via the tringger
> instead of enabling/disabling it on all cpus.
>
> echo "funcgraph:setpid:common_pid" >> events/fprobes/func_foo/trigger
>
> Then, we can also specify a specific task's pid too via sched_switch
> events etc. Also we can add "clearpid". Maybe we also need a special
> PID (e.g. -1) for trace no process instead of using tracing_on.

Thanks, I'm uncertain if modifying triggers is the right approach. My initi=
al
thought was to extend the functionality of set_graph_function for more
granular control, similar to how trace events handle filters. For example,
consider the function

vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *=
pos):

1. Enable tracing when countmeets a threshold (e.g., =E2=89=A54KB):

echo 'vfs_write if count >=3D 4096' > set_graph_function

2. Filter by PID and CPU:

echo 'vfs_write if pid =3D=3D 3456 && cpu =3D=3D 4' > set_graph_function

This usage is somewhat similar to the filter/trigger nodes in trace events,
and it targets function entry tracepoints. I'm considering whether we could
base this on trace_fprobe, as it might align more closely with the existing
filter node functionality. I'm unsure which approach is more appropriate.
Do you have any recommendations?

>
> Thank you,
>
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
> >
> > Thanks,
> > Donglin
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
