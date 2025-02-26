Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE521C9EE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585533; cv=none; b=OQNWus9AJghFvIIk0I6KFVc/8VcnlT+FA0BhN3kZgApBJScxkChub04xIcwzTylZOg4p7YX2f1sX+VpP/Cof2LFeWY1TORIaQ+Ca1wSDaFiKeUe0ljPtqsxUBW4Sh/Pu5aI9WmyUCqq7W2UjMAFY1IMM06lcOXKY6uj9HOQhiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585533; c=relaxed/simple;
	bh=mM3hDiHpBSmKILPkBX6OHeUMagubawojwUE8PdvBAAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ9J/3puKAQO//etzI52joR2/com9PFkuGlVTLbG5iRR/BH+4fsXL5xZOFbrEoV1MdLt2FPjnWQoohxSrTOScmmqro4jAdTsbph7jygOMe6LWAh+l26VQjcZz03ApwtkFU5BdQMIRZBzPfPc3MC1XGXR9MZZOcB8oVP9Ij29nnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGTefUsB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGTefUsB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740585530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7sz7icioz09gsYo4+0sb7OK453jEJXRkoeOgkSSMe8=;
	b=eGTefUsB99Sfmi2QWUADEATyJptSR6b3JI+ZUBeusJ//jw5lEmGVBO43KNpwzFwsRz67Jg
	0W3+kdNpuHWFm/YjzCBuBw5x5WDSfxwBpMvIRkCdu1g5UgPIyR5XHSypPGJSj6BwyvA8fd
	2lLsqZ6VfUgu3L8YqaejuK3Gac8WeyI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-yuNvTlUxP9SNCcPeTDCMNw-1; Wed, 26 Feb 2025 10:58:49 -0500
X-MC-Unique: yuNvTlUxP9SNCcPeTDCMNw-1
X-Mimecast-MFC-AGG-ID: yuNvTlUxP9SNCcPeTDCMNw_1740585528
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so769136566b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585528; x=1741190328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7sz7icioz09gsYo4+0sb7OK453jEJXRkoeOgkSSMe8=;
        b=Sk3g16fCiaKiUI6WYyEwg3FEKpd365Z6KTy9zoqY5MlhNFI3eritRZdHlzrhH6OHch
         4LjSIv+lainb4gUNAbvxQqLUhzFUE+Uxmd15l2X4vSZXREWkO5N1Sz0CwVplpDfxNPx+
         OI5dW814hiTbmyXOnOq3rNJwsfdNbdyhNNt0JJOMsWW6GyeGEQNL3/AXhtF9Vy/tRXm1
         PFDZJd35Gf+CP5HdOuwCpAbe17A7pCQ8qzC7lAhOtk8pGUHz1Lb0ttfvofGlRIhcnYXl
         HX+hkXyXtziCqnVymgekzTynzS7rgEZB7rkphXIZKsZWWFi1LXY2VS3q7oAJG4aPk3tw
         BelQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCM0QsVYsSx5/agoHYWjSR8zdm20acaz6jYO9ljx8TNqznTX7qDVaBjK6UvjCOLCB2ohpq89LFfXgaJFw8mPtN2qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjn/2/eckM19fnfCvTzWhsIB6vuXo7JSka7/KIbwv0qxEDGqSm
	tjQlYRZnT+qB+ohEfumCRLfN7UOfxz6Z/UXxYgn9kYepF3DiiTIYAvxoRnH4rufGcGX1SH/bZ3T
	95sfOI3DiRNB3GMUUGoWkEJAd5ivcO6x9Hpb6fBnB38kk+rWadSRim+uAzvH4W62+vPfLf/TqPQ
	SCKjWVnfcU/VryyuI0IMdWZIIgcAVH1wm+RTcfX7/EJL7I
X-Gm-Gg: ASbGnct5OPt/e9ZSCPFCs5VVAs5jfkNFwGO6DL0tH1be2IrmaGbkyxQ+7fpUcgtON7e
	Fttrid3bS0qdFlHgBB+MJZYM8Pcy1pcoyIjGlehWfLoYdm/2LaGGryVcO2kj8vFl4hU7rs6/eIm
	rfsfoYyMLAJU+go+AMLYLyp+V5oIk=
X-Received: by 2002:a17:907:3e8f:b0:ab6:c4e0:2d18 with SMTP id a640c23a62f3a-abed0ce6817mr811336266b.16.1740585528092;
        Wed, 26 Feb 2025 07:58:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgpx9WBd221DBgH7nEbyacMDn9H3O6xcej+Kyl1SltNnmGjCAnJR60vZ99bsRgpI2Tcbke/4nEm3ytgoPIHT0=
X-Received: by 2002:a17:907:3e8f:b0:ab6:c4e0:2d18 with SMTP id
 a640c23a62f3a-abed0ce6817mr811333866b.16.1740585527757; Wed, 26 Feb 2025
 07:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225125356.29236cd1@gandalf.local.home>
In-Reply-To: <20250225125356.29236cd1@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 26 Feb 2025 16:58:36 +0100
X-Gm-Features: AQ5f1Jpmgw8B10fvjfktihKyrmOlGZbLgMwGhf7mNM06WMENA8EDPL_1OpW-4QA
Message-ID: <CAP4=nvQdq4CQT9Y1ri8FfPE_rbw0T+-ggeHbKgmasmCD9OYB=A@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix bad hist from corrupting named_triggers list
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CU7-sLerLrTpK8Kv_cz-pKXD_f7DQtWMbNY7VWgkhSU_1740585528
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 2. 2025 v 18:53 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The following commands causes a crash:
>
>  ~# cd /sys/kernel/tracing/events/rcu/rcu_callback
>  ~# echo 'hist:name=3Dbad:keys=3Dcommon_pid:onmax(bogus).save(common_pid)=
' > trigger
>  bash: echo: write error: Invalid argument
>  ~# echo 'hist:name=3Dbad:keys=3Dcommon_pid' > trigger
>
> Because the following occurs:
>
> event_trigger_write() {
>   trigger_process_regex() {
>     event_hist_trigger_parse() {
>
>       data =3D event_trigger_alloc(..);
>
>       event_trigger_register(.., data) {
>         cmd_ops->reg(.., data, ..) [hist_register_trigger()] {
>           data->ops->init() [event_hist_trigger_init()] {
>             save_named_trigger(name, data) {
>               list_add(&data->named_list, &named_triggers);
>             }
>           }
>         }
>       }
>
>       ret =3D create_actions(); (return -EINVAL)
>       if (ret)
>         goto out_unreg;
> [..]
>       ret =3D hist_trigger_enable(data, ...) {
>         list_add_tail_rcu(&data->list, &file->triggers); <<<---- SKIPPED!=
!! (this is important!)
> [..]
>  out_unreg:
>       event_hist_unregister(.., data) {
>         cmd_ops->unreg(.., data, ..) [hist_unregister_trigger()] {
>           list_for_each_entry(iter, &file->triggers, list) {
>             if (!hist_trigger_match(data, iter, named_data, false))   <- =
never matches
>                 continue;
>             [..]
>             test =3D iter;
>           }
>           if (test && test->ops->free) <<<-- test is NULL
>
>             test->ops->free(test) [event_hist_trigger_free()] {
>               [..]
>               if (data->name)
>                 del_named_trigger(data) {
>                   list_del(&data->named_list);  <<<<-- NEVER gets removed=
!
>                 }
>               }
>            }
>          }
>
>          [..]
>          kfree(data); <<<-- frees item but it is still on list
>
> The next time a hist with name is registered, it causes an u-a-f bug and
> the kernel can crash.
>
> Move the code around such that if event_trigger_register() succeeds, the
> next thing called is hist_trigger_enable() which adds it to the list.
>
> A bunch of actions is called if get_named_trigger_data() returns false.
> But that doesn't need to be called after event_trigger_register(), so it
> can be moved up, allowing event_trigger_register() to be called just
> before hist_trigger_enable() keeping them together and allowing the
> file->triggers to be properly populated.
>
> Cc: stable@vger.kernel.org
> Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist t=
riggers")
> Reported-by: Tomas Glozar <tglozar@redhat.com>
> Closes: https://lore.kernel.org/all/CAP4=3DnvTsxjckSBTz=3DOe_UYh8keD9_sZC=
4i++4h72mJLic4_W4A@mail.gmail.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 261163b00137..c32adc372808 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6724,27 +6724,28 @@ static int event_hist_trigger_parse(struct event_=
command *cmd_ops,
>         if (existing_hist_update_only(glob, trigger_data, file))
>                 goto out_free;
>
> -       ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data)=
;
> -       if (ret < 0)
> -               goto out_free;
> +       if (!get_named_trigger_data(trigger_data)) {
>
> -       if (get_named_trigger_data(trigger_data))
> -               goto enable;
> +               ret =3D create_actions(hist_data);
> +               if (ret)
> +                       goto out_free;
>
> -       ret =3D create_actions(hist_data);
> -       if (ret)
> -               goto out_unreg;
> +               if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
> +                       ret =3D save_hist_vars(hist_data);
> +                       if (ret)
> +                               goto out_free;
> +               }
>
> -       if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
> -               ret =3D save_hist_vars(hist_data);
> +               ret =3D tracing_map_init(hist_data->map);
>                 if (ret)
> -                       goto out_unreg;
> +                       goto out_free;
>         }
>
> -       ret =3D tracing_map_init(hist_data->map);
> -       if (ret)
> -               goto out_unreg;
> -enable:
> +       ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data)=
;
> +       if (ret < 0)
> +               goto out_free;
> +
> +
>         ret =3D hist_trigger_enable(trigger_data, file);
>         if (ret)
>                 goto out_unreg;
> --
> 2.47.2
>

Applied this on 6.14.0-rc4 and the problem is gone.

Tested-by: Tomas Glozar <tglozar@redhat.com>

Tomas

