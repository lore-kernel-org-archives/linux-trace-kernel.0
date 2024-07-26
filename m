Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBDD13C9CD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997036; cv=none; b=n5xtgWzSOp6zdc5vZcueqaCSd7Dlmwb+YEEgaKc5KshaBkX6UqPFyGLuF7B39f17le8Pxp+Ks7acgW+ubAH5bdhQPvXdTSsv4nA8Z3LgiPzCQg8i5UbhcRN5pLo+epzFCt2v6uJQbj6qmJmbB/8n3RCGNUQgJ3ohyAmPE2h4msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997036; c=relaxed/simple;
	bh=q6Gwtss3pvnFcF/qkSJd20jqPuiCyMwdizvyf7ygzqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNNs8F53kbvN/aG3+ssw2R7Ohojhs1p7p9i9cIZmt2fB31wH6Tq1LB6Yc/DWsIyHvWZv16J305TGv+Ujc5WYoRgnJpZd6dZz8r9W7SNDZR10hDXP7rIZ+U0cjslMP+n5vRuWINRWnpTLAX0GKFIXR8gar81b5bXSpKrnWTWAteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M6FgHhOr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M6FgHhOr"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f025bc147so1638079e87.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721997033; x=1722601833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MkoL6imQpG1KUTejyUrTfPNQmWj1rXtOt1VDTD28qg=;
        b=M6FgHhOrJW43fOsJjgvDzk8ZBbrPOZmAtKLR47dSG51Rn3jfQbMZtTbIL1J0lmJkT7
         OsvKaug0y/Qc6z6DqXxPozyFqSlwGh2vgJI3AKC589DZig7/UiOg56wgjBaUyEskH0jN
         bkAlg+QY9j5k5HKZNYXf4dx3r9G6nWHIDCPZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721997033; x=1722601833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MkoL6imQpG1KUTejyUrTfPNQmWj1rXtOt1VDTD28qg=;
        b=SgiQzZECbscBqmVU0jay4LYVVnAobMhu/NJj1VDRfvM6M2KR/PzJuccvglVDdRGY5e
         GrUnO0ENpvmEWBJLoGWD1B3iD2MXsYwNs842K+lrEgyw1Wc/R72eFqNQP3Q/kuM2t4Ko
         E+wu5JAY4dRaQYmJ4GRm4X4Hj22KPsnHM2rFlvIMXzmyAfYUDSHFA7FTR//sLqqCU3Br
         jVn0iT38pu2snujnOA4B0o4dV1qZeJFcImhmdQ6nlGbpRbQAwKmf+Z7EUY7mDgax+LsT
         PMNUqJn5pW7Ggp4FJtnhLcFwLit1ZP3+SdVsSKPp9jf1LWRbZIvmkYr/WUt+r04CP/J5
         VtWA==
X-Forwarded-Encrypted: i=1; AJvYcCXikATUmyM5+W9jytBc5LNOQYIAkJLWrOKn5opjw831ivIcw9Rp7QlRm7IXZvrT5mtGpI4LIHSSQ5OkdhAfD0kJTP+w5w+NXEF3h7ZIrtkSF2w0
X-Gm-Message-State: AOJu0YwHl0KQ03o76jve3U7gENJw3rCJXzdLBswL6KLY0KWc1+JXEdM0
	Z+zCjNEMvEMw77FmYOmuL9CAiDyGXTQn9dLPmB8j0QWLBhrc09sBd9UXki6enUvJfIRZaN+1S5K
	UKywutIZQd4uvxIRExowgquLiXU/HOwuS8bqi
X-Google-Smtp-Source: AGHT+IHkiXxBHJEZwIYGFtIgX4qqpAl+b/dQWWfKIM/DLi0NsWavT/GbnRBQVEJVmYB4jXGauKqc1dPkgIpA6XtKiyk=
X-Received: by 2002:a05:6512:280c:b0:52c:e09c:b747 with SMTP id
 2adb3069b0e04-52fd3f1fb23mr4108542e87.27.1721997032594; Fri, 26 Jul 2024
 05:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725201517.3c52e4b0@gandalf.local.home>
In-Reply-To: <20240725201517.3c52e4b0@gandalf.local.home>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Fri, 26 Jul 2024 18:00:18 +0530
Message-ID: <CAD2QZ9b7=Y_x6o6R2UGwDRCky522A0fbiX_BxrY9w2LPyd=0sw@mail.gmail.com>
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mathias Krause <minipli@grsecurity.net>, 
	=?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	regressions@leemhuis.info, Dan Carpenter <dan.carpenter@linaro.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:45=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> When eventfs was introduced, special care had to be done to coordinate th=
e
> freeing of the file meta data with the files that are exposed to user
> space. The file meta data would have a ref count that is set when the fil=
e
> is created and would be decremented and freed after the last user that
> opened the file closed it. When the file meta data was to be freed, it
> would set a flag (EVENT_FILE_FL_FREED) to denote that the file is freed,
> and any new references made (like new opens or reads) would fail as it is
> marked freed. This allowed other meta data to be freed after this flag wa=
s
> set (under the event_mutex).
>
> All the files that were dynamically created in the events directory had a
> pointer to the file meta data and would call event_release() when the las=
t
> reference to the user space file was closed. This would be the time that =
it
> is safe to free the file meta data.
>
> A short cut was made for the "format" file. It's i_private would point to
> the "call" entry directly and not point to the file's meta data. This is
> because all format files are the same for the same "call", so it was
> thought there was no reason to differentiate them.  The other files
> maintain state (like the "enable", "trigger", etc). But this meant if the
> file were to disappear, the "format" file would be unaware of it.
>
> This fixes two bugs in the same code. One is a race that could be trigger
> via the user_events test (that would create dynamic events and free them)=
,
> and running a loop that would read the user_events format files:
>
> In one console run:
>
>  # cd tools/testing/selftests/user_events
>  # while true; do ./ftrace_test; done
>
> And in another console run:
>
>  # cd /sys/kernel/tracing/
>  # while true; do cat events/user_events/__test_event/format; done 2>/dev=
/null
>
> With KASAN memory checking, it would trigger a use-after-free bug. This w=
as
> because the format file was not checking the file's meta data flag
> "EVENT_FILE_FL_FREED", so it would access the event that the file meta da=
ta
> pointed to after it was freed.
>
> The second bug is that the dynamic "format" file also registered a callba=
ck
> to decrement the meta data, but the "data" pointer passed to the callback
> was the event itself. Not the meta data to free. This would either cause =
a
> memory leak (the meta data never was freed) or a crash as it could have
> incorrectly freed the event itself.
>
> Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecu=
rity.net/
>
> Cc: stable@vger.kernel.org
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an ev=
entfs_inode")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6ef29eba90ce..852643d957de 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1540,7 +1540,8 @@ enum {
>
>  static void *f_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> -       struct trace_event_call *call =3D event_file_data(m->private);
> +       struct trace_event_file *file =3D event_file_data(m->private);
> +       struct trace_event_call *call =3D file->event_call;
>         struct list_head *common_head =3D &ftrace_common_fields;
>         struct list_head *head =3D trace_get_fields(call);
>         struct list_head *node =3D v;
> @@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, lo=
ff_t *pos)
>
>  static int f_show(struct seq_file *m, void *v)
>  {
> -       struct trace_event_call *call =3D event_file_data(m->private);
> +       struct trace_event_file *file =3D event_file_data(m->private);
> +       struct trace_event_call *call =3D file->event_call;
>         struct ftrace_event_field *field;
>         const char *array_descriptor;
>
> @@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
>
>  static void *f_start(struct seq_file *m, loff_t *pos)
>  {
> +       struct trace_event_file *file;
>         void *p =3D (void *)FORMAT_HEADER;
>         loff_t l =3D 0;
>
>         /* ->stop() is called even if ->start() fails */
>         mutex_lock(&event_mutex);
> -       if (!event_file_data(m->private))
> +       file =3D event_file_data(m->private);
> +       if (!file || (file->flags & EVENT_FILE_FL_FREED))
>                 return ERR_PTR(-ENODEV);

Some doubt:
Because of the same race condition, it may happen that kmem_cache_free(file=
)
was executed while f_start() is waiting to get event_mutex. Once
f_start() acquires
event_mutex, it will access the *file which points to the freed cache.
I am assuming in this case KASAN will not show anything as *file
belongs to cache.

- Ajay

>         while (l < *pos && p)
> @@ -2485,7 +2489,6 @@ static int event_callback(const char *name, umode_t=
 *mode, void **data,
>         if (strcmp(name, "format") =3D=3D 0) {
>                 *mode =3D TRACE_MODE_READ;
>                 *fops =3D &ftrace_event_format_fops;
> -               *data =3D call;
>                 return 1;
>         }
>
> --
> 2.43.0
>
