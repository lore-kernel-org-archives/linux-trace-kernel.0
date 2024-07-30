Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41B1A2C1E;
	Tue, 30 Jul 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352143; cv=none; b=FWxGWe7rxODkCbOdr6ECe+0INz8xgQLb0ql27V8rDR2VVWtXI4SE6pL3boaIEhBQIN3v0CU4svscHCpUO94VQ+Iilu2Y8Jkgz2Ap0r02sxVdwBDFFAIDFUcyMi0RSqJNT4mGW7jZTrCwnUjR8nAaf2elvrDkP70jMPZ7pzdPk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352143; c=relaxed/simple;
	bh=8ENJOjZwJdGgNFQOL8N6OJHTAv8NY+3Jqa9OsnFVcBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd5RG8R6AV3FZz56z3JNrwySrYw3h/Ni199U557hyEFUrkNfXrOcx7s9BzZmSD/MvEafLe1bfK/hcH4Xrc2bgBTwLlUs7K1GC+UrcdOEsfPxHgAIRj1SNmNz5tyYAoY/uj2elK6B92vZJP8uLdTuoh/s8p7DMA4cOuYPyVmCOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXCctCsa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXCctCsa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb510cd097so3408253a91.1;
        Tue, 30 Jul 2024 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352141; x=1722956941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiEQQfSFvVIlUjdarShKIntPOK/qyPeJHSyrwGVtIbs=;
        b=FXCctCsayOZNnuuSdPncFPrOOdmitTQHxmnDj71ZMSgAsbr9Ep83X8kq/xJr47gprI
         bQtbiXR7mqQekSHiLTV7H1SF/pfk6Ik5iZ9ZWPx5ixPg7pGTQKkVSoApP/unXlGisQwE
         QTCWkZFvpURbwHebEOyESjSEWqB+Ne45S8EsgHw2Srm02/JcFzR9W9Pl1wxdCsL9RfN9
         Sili3FrtgxfJ+N7MJkz/q4NVNzmfzJwwcIY/IYT8OvAGS7rB+937AIR5dN5xUYhqXyD2
         2iP6uHrR8ZMl5h5Be3D24LhjSuS5vao+aK47/t5Pr+UmL2lAS3FSB9jTg9rYRCaXk4+8
         tNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352141; x=1722956941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiEQQfSFvVIlUjdarShKIntPOK/qyPeJHSyrwGVtIbs=;
        b=dkbrbFg2Cne46sMWjiSEAfQL9K2NSiteWWOJqMX0MLfcOJFalr8tK+/2NZaGihd0es
         ElmoZcpUIAPnOHoOFuD7btDC6E30ndaGJC1bn0zoOlhz+H/9rC829vp+LjbktxkNoNBt
         ZJBgDVXOuX60bimu5JTyXUI378joA7k5Nn8gUMtkSdXIDBgQ0g7+6LtX8EQVJIuvcYw4
         gzq1NrE275iErjgR6qlajfDZFxJqlDXdgVTn9VYaUNSQc8bL8TKJrHfcnGu+CewYAqbY
         INT/2OOPfDxV7ZYFOcAEc9/muS90FuxXhiEJ7PACKI8XIDutJFuNqEpWthOJ6P0KbmRS
         v7wg==
X-Forwarded-Encrypted: i=1; AJvYcCUocgXN76FLLF10CVVcuEU18x1Y+rdyqoK51+poLLeEdNN8vegHwYFku0GEGypG8doHfZFAnbDgG06Xn15zRf12H98DmpDDHCclCc93ooYXj6RJgCh+r6T8uStTGmkH8G7K5xSs/rJepg2mb8fv2Qc0
X-Gm-Message-State: AOJu0YxyU2TfEU83koh23nAZCfUYEzyxauCCuHSRhG3yH+L44ZabLlAi
	B5JuAuAgWcnB34qxFYIgF4iqMZlWbwDihsQByffaZ4cHW7LOQTFcsbN58JOBD69IlJd4aiEN8To
	tQ2gtWe6QenHrdn96FSiLY9jfkgc=
X-Google-Smtp-Source: AGHT+IGlO6F6UOrUzQz8J2QDhkFJHgPfixGJLN9Qvf4u+3VqNqRQOQE9sqawX452qNdusKAUSXmkFBKym34FJXwOlSE=
X-Received: by 2002:a17:90a:5d17:b0:2c9:a151:44fb with SMTP id
 98e67ed59e1d1-2cf7e1fad43mr13111838a91.22.1722352141201; Tue, 30 Jul 2024
 08:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730123421.GA9085@redhat.com> <20240730123457.GA9108@redhat.com>
In-Reply-To: <20240730123457.GA9108@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 08:08:49 -0700
Message-ID: <CAEf4BzZ=vMh9=t3iH+pqwTDaYGfXvuF-0BqaLsOgAx2qV7Vqzw@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: shift put_uprobe() from delete_uprobe() to uprobe_unregister()
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Kill the extra get_uprobe() + put_uprobe() in uprobe_unregister() and
> move the possibly final put_uprobe() from delete_uprobe() to its only
> caller, uprobe_unregister().
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/events/uprobes.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>

LGTM as well.

BTW, do you have anything against me changing refcounting so that
uprobes_tree itself doesn't hold a refcount, and all the refcounting
is done based on consumers holding implicit refcount and whatever
temporary get/put uprobe is necessary for runtime uprobe/uretprobe
functioning.

I can do that with a simple refcount_t and refcount_inc_not_zero(), no
fancy custom refcounting. This schema makes most sense to me, it will
also simplify registration by avoiding that annoying
is_uprobe_active() check + retry. Thoughts?

All that would be additional on top of your change. BTW, do you plan
any more clean ups like this? It's a bit of a moving target because of
your refactoring, so I'd appreciate some stability to build upon :)

Also, can you please push this and your previous patch set into some
branch somewhere I can pull from, preferably based on the latest
linux-trace's probes/for-next? Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index c06e1a5f1783..f88b7ff20587 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -939,7 +939,6 @@ static void delete_uprobe(struct uprobe *uprobe)
>         rb_erase(&uprobe->rb_node, &uprobes_tree);
>         write_unlock(&uprobes_treelock);
>         RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> -       put_uprobe(uprobe);
>  }
>
>  struct map_info {
> @@ -1094,7 +1093,6 @@ void uprobe_unregister(struct uprobe *uprobe, struc=
t uprobe_consumer *uc)
>  {
>         int err;
>
> -       get_uprobe(uprobe);
>         down_write(&uprobe->register_rwsem);
>         if (WARN_ON(!consumer_del(uprobe, uc)))
>                 err =3D -ENOENT;
> @@ -1102,10 +1100,16 @@ void uprobe_unregister(struct uprobe *uprobe, str=
uct uprobe_consumer *uc)
>                 err =3D register_for_each_vma(uprobe, NULL);
>
>         /* TODO : cant unregister? schedule a worker thread */
> -       if (!err && !uprobe->consumers)
> -               delete_uprobe(uprobe);
> +       if (!err) {
> +               if (!uprobe->consumers)
> +                       delete_uprobe(uprobe);
> +               else
> +                       err =3D -EBUSY;

This bit is weird because really it's not an error... but this makes
this change simpler and moves put_uprobe outside of rwsem. With my
proposed change to refcounting schema this would be unnecessary, but
let's see what you think.

> +       }
>         up_write(&uprobe->register_rwsem);
> -       put_uprobe(uprobe);
> +
> +       if (!err)
> +               put_uprobe(uprobe);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister);
>
> --
> 2.25.1.362.g51ebf55
>
