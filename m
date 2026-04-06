Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1017D2
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460670; cv=pass; b=k0k5nz/McPOVEHxaXbi4OxE6d0kHJFECRFFkuRXCdUyY9xDNc9c+IAzGde7Gzygl9DIn4LMjn9bSmh9LY8DoCo4eox9xjPwUcd2yBmTS6PwRcphMo4OOF6OSWpCrt/4somCF6NewTX3v09plbP+DIMx5pB+N26o6ETvkC+h4k1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460670; c=relaxed/simple;
	bh=YzUbsrcUMLFWfbV/WWy+jgSQC2cg55IseBM6KZDm0EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0d2es2mVwZmcabW/QvCjKuxObIjMYcY+hHDCAY7qBSyAAWRLed+IIgfqNNC0guUR5w9ko1pNMbKl8AT/AJOgilQNcg8P54ZNMKxpBa8PNpB33R4G96PvxXm3bj4U58rNXKyXALK20G3XIbXlAtfuxbblKiUoo5Fv9M2IRENgDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEo3pKQJ; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEo3pKQJ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so8623774eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 00:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775460668; cv=none;
        d=google.com; s=arc-20240605;
        b=H55Usce0FZQd3sJtM8RFcOW9K3Fnsevfe8ONAImbOTo/2nwUi6qE18NzbxoUt+/mlI
         63u7RezhMA8jW8+2Qry1pFulvG+nIRu0akkQ/lpBMkukpcp01Jm6bYrTnWwpbcwRJGu+
         d1t9BsKjD3PPaaq1tn7AQsz4uZ9ZkmFQKzeGg30Gk4qN+EJMksBiQYDe+jqxuC1CudVT
         YLSzy6VSyErBraca0Ts58t0jHtpfKXuV1LI1bHHO7a9h2lYCdStThayggqoBDttCmEhL
         Ti334L0WFg+QNpppc084ehxvZV54cELM1egpHIo6QUKpnnTBydRNKJGBG2cbSMsj+FpZ
         0+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LH8AqPak6tOK7FQxahQQVwaPu3XIfFt7kuJIPVCo+Ls=;
        fh=NgXGJav/Jowh9DyRmingLWlwLA8vY29uGzfQ3uPpWjE=;
        b=PKnuOU/Y1in4Oh/Mv1If7isdERbvCTCb3LqGwRIbUdjJYaRbiwk/O14YCWZXh7UO48
         UvcBwCZsRp4fqURKDtk+4yQDxJXiMVYjI4MLD3GF3TZsRCrY3AmHgoHGF9iPudIr86x2
         3zjcPg1pnbKzHtSEe5iv0ETtkgCPiTdkD6xkPqMwUdw9xvXXmqGG8RgcAvm+ab3S2xXa
         lQvYjFsbcrL/56P/jzsTnlValHEFcu/7+GI0y/cjLkFAeQQh4uNZEOBkx361CN4nceHQ
         JSBLxDDitaOlbzQLUvC3b9OGsnGyuYzCLtkflN7q0OA9PDYtNEmx9drNu76DZFnNkdXE
         qAXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775460668; x=1776065468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH8AqPak6tOK7FQxahQQVwaPu3XIfFt7kuJIPVCo+Ls=;
        b=PEo3pKQJucPvhYNSEK1GfPAFgrpeGLcN/H8CCt38uTAdI4AMzgQiqbkiA/QVUMpg2J
         d2Lg6m6Q5vvu1dcDZQZqavajdtYJkmsh2fbc446pIJ2ynq/fW5V/rJvpfGf4xCPOBYYE
         q2VbVwFnPcvyZXyEWr88NvpIUH3n0UMFw3JHffCohQcWcn37h8Lnw0XIPwq71A3cOZ7Q
         INuZ3TM8AfR8h87DZxln1XwiNa9MmgicS2HQ/UVyg+R2KisgawVFqobtXP4sxB6/BKN+
         9CbxIk34MA+VnTbO8MhWziE0m6zt+byov3gfnbvpWEXC5QyOwgcp29T0A3cf5NjQqWwI
         P+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775460668; x=1776065468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LH8AqPak6tOK7FQxahQQVwaPu3XIfFt7kuJIPVCo+Ls=;
        b=ZRg3j/ZHoNiYtrR9z/oMxbIQoo724cW4rk05q2MurtlKInf+ArUSCPaqndaybw75bq
         ybf+hBlb7hUs8RczSwd4BGPRDPAx1v2YlwVoxEW6KcovGpsMRY4TPt8dEaY0y7dEbF8C
         gusflF8GAXPAYY001s47pmGJeUNNwWXlyCdGRtMjV9XVYJWJJIbCZaK8IQOvnuVt0Ydj
         YBH+/IPWaNaIxpAH0G0FZfNQVqzqgWwhuGsGGeqMfOTQ320e4UBq8CFUtfEX5j9/Lxi5
         eXPLb+z1S8z25rXA93jLUeo7SXZnZliSVLHuuyDLv8OEL3OB+9N1gtxHq9QE1K49MafC
         ZJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+mId1RSLvbWScCSynku+cEVgfg0YlPzIRgamOUk+WtdMbbgoXDGmTZWTxNmmuWUTJKEp4ZRPf0FAq6gUHmea03Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7Xo13/ySzXTepc4JRX/EgA2XToObSBHJBAa9MNpAmXzlqqUD
	381ZaITMyDub26uTTuw4g5AbKNN5nfDywOroTueC8wOzkQg5FFicZwQXYjj835EFzc7pyEGSR5c
	JJw69eksHnK92tKikAcmepgBFx/HnQtvZSwlaRVY=
X-Gm-Gg: AeBDievw5O/efrJlj7waju29vbYwFHr4ZyNUG9bkLLI+uOx2+ygjOX2Q26HkOnNz/14
	euemckgcyIrqbkYjU/aqWsdHd8sAcfMxlobfHs5vPc7UuY9DqJwOZJLMcSoqKQ005BJ+ldkShIv
	mW0i9x0NYA4Wm22OTgNGYF+T7tietT8kuSYlGG+oqns1yL6iOo1phNVdX/+eBk5rj4zByf5CSRF
	zSfZuW19rnZx3SJMUhhTeaftDgJt2cGcPBTLOoEgsOur+Fm4ptk0fIwE1WWLoazPU+ITBChcthX
	PTrDrw0BN0p4hIL5ckOXtL6npaiO4PTAQ99mkeA=
X-Received: by 2002:a05:7300:371f:b0:2c5:76d1:7f95 with SMTP id
 5a478bee46e88-2cbfc763331mr5798642eec.28.1775460668229; Mon, 06 Apr 2026
 00:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406060046.223496-2-abhijithsriram95@gmail.com> <20260406161801.d507eeb247eb8b3b17f490a8@kernel.org>
In-Reply-To: <20260406161801.d507eeb247eb8b3b17f490a8@kernel.org>
From: Abhijith Sriram <abhijithsriram95@gmail.com>
Date: Mon, 6 Apr 2026 09:30:56 +0200
X-Gm-Features: AQROBzDgomivwIeILBSqaYRYlqu20xsGlYMsrxer2jx9KG6Wy8GLYiFv7K1_u2o
Message-ID: <CAMTgpFe=cXPZN6niBxs-C5zhzpTtw4oORSA7aUtz1ZAFHR6Mag@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/trace: fixed static warnings
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:18=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon,  6 Apr 2026 08:00:36 +0200
> abhijithsriram95@gmail.com wrote:
>
> > From: Abhijith Sriram <abhijithsriram95@gmail.com>
> >
> > The change in the function argument description
> > was due to the static code checker script reading
> > the word filter back to back
> >
> > Changes in v2:
> > - corrected *m =3D file->private_data to m =3D file->private_data
> >
> > Changes in v3:
> > - reverted the changes for struct seq_file *m and
> >   added a new empty line instead
> >
> > Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> > ---
> >  kernel/trace/trace_events_trigger.c | 8 +++++---
> >  new-changes                         | 6 ++++++
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >  create mode 100644 new-changes
> >
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_e=
vents_trigger.c
> > index 655db2e82513..08adb593fcd9 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *f=
ile,
> >  }
> >  EXPORT_SYMBOL_GPL(event_triggers_post_call);
> >
> > -#define SHOW_AVAILABLE_TRIGGERS      (void *)(1UL)
> > +#define SHOW_AVAILABLE_TRIGGERS      ((void *)(1UL))
> >
> >  static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
> >  {
> > @@ -352,6 +352,7 @@ static int event_trigger_regex_open(struct inode *i=
node, struct file *file)
> >               ret =3D seq_open(file, &event_triggers_seq_ops);
> >               if (!ret) {
> >                       struct seq_file *m =3D file->private_data;
> > +
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
> Again, this is not OK. Even if checkpatch.pl complained against this,
> there should be no problem. Only if you think this is not sorted by
> length, you can do:
Removed it in the new patch
>
>         struct trace_event_file *event_file;
> +       char *buf __free(kfree) =3D NULL;
>         ssize_t ret;
> -       char *buf __free(kfree) =3D NULL;
>
> This change is acceptable as a cosmetic change.
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
> > diff --git a/new-changes b/new-changes
> > new file mode 100644
> > index 000000000000..9e3a24de3033
> > --- /dev/null
> > +++ b/new-changes
> > @@ -0,0 +1,6 @@
> > +Line 25 -> adding const to the pointer address as well.
> > +
> > +linw 1193 -> removing else because there is a return statement in the =
if condition
> > +line 1727 -> adding new line after statement
> > +line 1800 -> reordering to solve missing a blank line warning
> > +line 12364 -> changed the function to kstrtoul
> > \ No newline at end of file
>
> Is this your working note?
> Please remove it.
Removed it in the new patch
>
> Thank you,
>
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
Thank you for your patience. I am still learning and trying to find my hold=
.
Here is the new patch version:
https://lore.kernel.org/linux-trace-kernel/20260406072834.243491-2-abhijith=
sriram95@gmail.com/T/#u
I will do my best to be more careful in the future :)


--=20
Regards
Abhijith Sriram
