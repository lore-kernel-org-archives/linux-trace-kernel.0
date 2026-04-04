Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0B224B05
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Apr 2026 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775282601; cv=pass; b=MHxH/qpHvUzOFxlEh/CCzxnfUTPI8yYA9IC3ZNbvZdHJYwAOga4+hu3k70G0NFij32gINaWJqN3/gea3dZGlPSuK5j3fjlGriWMztL/RD8tUl0rcraq8vw9DreMOvcDrFbT8SZgxq7CJ/Uiafx+HedvpQXApkTWXFcdm05SIFnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775282601; c=relaxed/simple;
	bh=5bCiR83ba0E37Y1PxMMXSbCKQgCoihKPmM2s11zD6FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE8dinYBCr1DpOkPiEFdQucGMB7MY/6LCOdDXLTAhV+mfsmfU2XUSIR15Yc/pqFGe4S0pQ4C6aARcjCAC8zRTE1aRRA2lrYX6bfWg+YPg4fgaSaCcw0NA0bQ2skrk0PGQeYVokRI1HFJC48tNLv2PM6YOl2vRHgRLr+osg4gqJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA9uw6Eu; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA9uw6Eu"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1611038eec.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 23:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775282599; cv=none;
        d=google.com; s=arc-20240605;
        b=TErpP0Jp5kcomML6zew36r96rK1dE/A+aGa+799SQ5m0uf9Wyi7wu0dJyvDzJevgKK
         Eq8E0vXsMTs6ClYSzS8s7jmeC09dDzjNWZypA5YUoMo/PSsS8YLb9Ri7zzz82bs8IcgO
         ckbyXU2sBh+tBHIBqNC1eI8FrUSH+YZEfp/dJkAJsYBxjwmKiAXnHvRAF8Q6upDuPqxw
         UcRP0WiYdwRoZav4bE19jLNHjSr2Q+nXOGwBfVJvsyBFMZrtxsTyQ64KGt0BCy83z3V/
         N/ZdjzHqSB9xLEH4uLjEAQSxddUkVTmKSwDFGzW27WFcS6UvuvDBVqvXqXXnBCKdRcl0
         GDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Hnk2uwgFOcenfVnfWw0iATy8CzvS5zNI8mkkI03Dqg=;
        fh=C2DhANR1jN/I7UEy0O2ubLUKi9DXh0PGX6H0YaGY6h0=;
        b=kUSpqdsAQ3ku9+otnZU+1fxTWquBVWMeJp8qa48Mh6nkjX+1/OKuKeLVH70uljfpbA
         sB9GPDguNtUDP2p/z4BKJge5WN9oDbvpOLp5Q8teDwT2WscJoOv9hHUfqpavcdKrTD0Z
         /xvdkb3v90maPenmy2jWGg4ozu8YwHy2B5IaiVl9kZmZAGYCS9H3ox4cnR7y0iFF1aD1
         f80ZGkqasyAMNXIuWtdS1+e7tkWaafNdpWLGTORJ5lzWdplfalg0I/0jkWZKSZd1wlSu
         baVi/0jk1cgW4/gP783fQHr1c4F41HEuUjbCe+jOe6AE9M+AD1P1hIPOR4R62BIDBCDk
         cCBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775282599; x=1775887399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Hnk2uwgFOcenfVnfWw0iATy8CzvS5zNI8mkkI03Dqg=;
        b=AA9uw6EugEudDWpBrIoUmT9mxUvBDQouKLLT4S+rKJQywJO8JGCn10MFhZh0Xd8lMv
         Gf0LZYmgvYFbsVjzKdToeYTF+EF1qsSg5cK2L1jaE8nQWPicp5fwc+PGYgGeTtJ/GSlf
         W/p8NJtXk5FtMgnMg6JDedjujlb6mbkG56oFewQgkX0druSwLhb1OELuAuaCaxlOqWAx
         aMwRR5vgzBIiE4L23cCt1YqTvosFQs70rIhgDdkpE6NpCo5fwdxvySAdeuRmdWD1NEId
         ijLwcJKytnUoL2DG6ee0FnYsUJQqm4YwnyIUrrUI7w/ylToVW3YI//O/NbxADiUwORcY
         qyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775282599; x=1775887399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Hnk2uwgFOcenfVnfWw0iATy8CzvS5zNI8mkkI03Dqg=;
        b=AMY8KJwg8U6CHXbiZbe28JpkptUa516akEYTcsJz2p5ONKjtupC2Tbx4Lh70+pDPp+
         UOmNkBak7kIlrCNuJmkuhZX8ALFSkthCfGhCpTlyOKi+/k1DTJ62Q4CO+caZ5aQEJjsr
         DpEEiMO49YJKqN+J+5pTm5Q1ZrnUVfMpnADyNwFIIBkRsyM8KocY6YV/PMgjc/MVy+Ep
         /u23O/yGJQKSynel2Jac/v+yjTvEFgLPIVmwY7UAEp2xEVTFmwxEQyo7wjktXlKdJQQh
         rD6Lh3bZzsSh7EUektkNcFuBIEieHKDcGJL1PcTqb4AAd6G4jlnRvX2RQwlK6+mGxTUb
         Yoig==
X-Forwarded-Encrypted: i=1; AJvYcCX5aBRqRK/2DHMDBa/hkaTZyopw8SXcmbm8thWFfahIuc63y/etAKTCh0xzvY8BdEyyQBRywFp6DJP41HPS0ZkGLHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNvuGnnHl+n+bdcv661g1V10EFxeXS93aMrtnOaATndAS8hBs
	4zN8gZULZpfk2SvoseExsjPW9chP4IPhF+ozwUrn/VbYrXtnryIOXzqAuc6ZERqDhYm6HD4fx3N
	VAqIiD7c4kWgN426hmxWew3FKElMzdNDe7W9dIX0=
X-Gm-Gg: AeBDiev7exeC3XwQNU4Cy3QEQ+bLCn/e0AX7Z1/oLyEXRklVdLYmhgSLH6oJeVwJ8A0
	SyKaAA7D9FBTq8LU346K7/G4iZlRcrHgYkYwXmcg2P+jA39leV47wNcLw/Tn6sUe5LltR5i67WS
	ikDid4I9LxP/UotT7HHV87RjVUyUwr59tW3c1KKffTx7nkv5lYtbwD67DGlaNI7mpvfOFxATxKh
	MdCrubmpDc2NoQq6aHBV0X7z2DHxIJsP7Oko2JtrpdfhRkI1P+tAkIIuL8rfnawmGVlcUwDIuKy
	SeLet8oIXyUjPUyrpLFtflNhXLsIPiLcxLZpWAU=
X-Received: by 2002:a05:7300:a98f:b0:2c0:c6f6:b075 with SMTP id
 5a478bee46e88-2cad6baf6bfmr3941739eec.8.1775282599285; Fri, 03 Apr 2026
 23:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402195405.21316-1-abhijithsriram95@gmail.com> <20260404091806.4e1cf73d2775d128f1dc5277@kernel.org>
In-Reply-To: <20260404091806.4e1cf73d2775d128f1dc5277@kernel.org>
From: Abhijith Sriram <abhijithsriram95@gmail.com>
Date: Sat, 4 Apr 2026 08:03:07 +0200
X-Gm-Features: AQROBzA0Wmjfr82akYGeYiPtzlWdlgC5RrL8NK3NCovVA1XDqZbLDd-v9gmAi-s
Message-ID: <CAMTgpFfAmzXxjtZXbtLyZL62dAWOmyhNkwJLkgQy7Lcv+VrjLA@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: fixed static warnings
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"open list:TRACING" <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 2:18=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Thu,  2 Apr 2026 21:54:04 +0200
> abhijithsriram95@gmail.com wrote:
>
> > From: Abhijith Sriram <abhijithsriram95@gmail.com>
> >
> > The change in the function argument description
> > was due to the static code checker script reading
> > the word filter back to back
> >
> > Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> > ---
> >  kernel/trace/trace_events_trigger.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_e=
vents_trigger.c
> > index 655db2e82513..477d8dee3362 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *f=
ile,
> >  }
> >  EXPORT_SYMBOL_GPL(event_triggers_post_call);
> >
> > -#define SHOW_AVAILABLE_TRIGGERS      (void *)(1UL)
> > +#define SHOW_AVAILABLE_TRIGGERS      ((void *)(1UL))
>
> This is OK.
>
> >
> >  static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
> >  {
> > @@ -325,6 +325,7 @@ static const struct seq_operations event_triggers_s=
eq_ops =3D {
> >  static int event_trigger_regex_open(struct inode *inode, struct file *=
file)
> >  {
> >       int ret;
> > +     struct seq_file *m =3D NULL;
> >
> >       ret =3D security_locked_down(LOCKDOWN_TRACEFS);
> >       if (ret)
> > @@ -351,7 +352,7 @@ static int event_trigger_regex_open(struct inode *i=
node, struct file *file)
> >       if (file->f_mode & FMODE_READ) {
> >               ret =3D seq_open(file, &event_triggers_seq_ops);
> >               if (!ret) {
> > -                     struct seq_file *m =3D file->private_data;
> > +                     *m =3D file->private_data;
>
> Why is this change required?
The original warning says "missing blank line after declaration". I
thought it was cleaner to have the
declaration in the beginning of the function. I made a mistake here
which I fixed in the version 2 of
the patch, please have a look here:
https://lore.kernel.org/linux-trace-kernel/20260403071108.23422-2-abhijiths=
riram95@gmail.com/T/#u
>
> >                       m->private =3D file;
> >               }
> >       }
> > @@ -388,9 +389,9 @@ static ssize_t event_trigger_regex_write(struct fil=
e *file,
> >                                        const char __user *ubuf,
> >                                        size_t cnt, loff_t *ppos)
> >  {
> > +     char *buf __free(kfree) =3D NULL;
> >       struct trace_event_file *event_file;
> >       ssize_t ret;
> > -     char *buf __free(kfree) =3D NULL;
>
> What is this change?
The same missing blank lines after declaration was triggered here,
even though there is a blank line after the char *buf.
If I do give an empty line then there is another error "Trailing white
space". So I  reordered it and the warning disappeared.
This change I am not super sure since it is usually recommended that
variables of larger size are declared first
for padding purposes. What do you think?
>
> Thanks,
>
> >
> >       if (!cnt)
> >               return 0;
> > @@ -633,6 +634,7 @@ clear_event_triggers(struct trace_array *tr)
> >
> >       list_for_each_entry(file, &tr->events, list) {
> >               struct event_trigger_data *data, *n;
> > +
> >               list_for_each_entry_safe(data, n, &file->triggers, list) =
{
> >                       trace_event_trigger_enable_disable(file, 0);
> >                       list_del_rcu(&data->list);
> > @@ -785,7 +787,7 @@ static void unregister_trigger(char *glob,
> >   *   cmd               - the trigger command name
> >   *   glob              - the trigger command name optionally prefaced =
with '!'
> >   *   param_and_filter  - text following cmd and ':'
> > - *   param             - text following cmd and ':' and stripped of fi=
lter
> > + *   param             - text following cmd and ':' and filter removed
> >   *   filter            - the optional filter text following (and inclu=
ding) 'if'
> >   *
> >   * To illustrate the use of these components, here are some concrete
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
--=20
Regards
Abhijith Sriram
