Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F712A1C7;
	Tue, 30 Jul 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351671; cv=none; b=suIohhibBquYtKcURYQx/Gklh4l/bahXsP+7GUHzgLgSa2ofCBB/mp7FiZqIDLf72RQn1oemQVzGPEw0bcjgoNqjxaahjdswTOpeFEuqnmDnxI+HwnReY13CL8RUl+qGwPp0GcM6wjYOJT6xSR9KzBnELYml10om7nYZfQJwVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351671; c=relaxed/simple;
	bh=j2kcCboMR5Rhb1/mHRYSxmbZjT89UOEP4J9cH0mzlNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrQA8xPEzjM2Sbn8qY2g3WLaBEDgBdmXO6A+3hbKkfgzg+HaD90sFzPrkxsfsbmO+qoSuvm551K8vCRH/kOIPtvVt+M86DDtutf4ZjldWLICLdTVq/ceJ2LWz1stq8dSckIQhPDoZEYX3MEnkuKdIQVYdJSVBwA9X0sh59KsGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5iWenDP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5iWenDP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc5239faebso28839495ad.1;
        Tue, 30 Jul 2024 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722351669; x=1722956469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZesiVrRNJp8rIjtaqy6O2hv8WkNzQU4Ni/NwPdEkSQ=;
        b=V5iWenDPDwCFnzCvBTQ76j1fLN1Sf53zXRKax9GUlBzwv8KyDL9d1YpV1LQNFK2fha
         MG4vD7O57zcV9dSKz5+HGpq3E6a4HfungrHM0OW29afDaBSlFSH4cHmYfwO9HuD7cWOw
         /IImXdHmv5KyVrItRMvtnBA+rE0hI5NqLBQtQ+Gs0jjhEAlb3L/QmQ7TZitNVTccxA43
         HhvxR5yBhs+gO1C+Iq38dIh4wn4pbiYxsLdb20+S0QcvHDKWzcSC1OBjv5mwLTl0NoCX
         vPuZfyX8gT8Bgxh894ks4cONce/YXBUTQn9TsaqdNrTiKjevyhnODD38YEMtUrby3dyW
         ab1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351669; x=1722956469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZesiVrRNJp8rIjtaqy6O2hv8WkNzQU4Ni/NwPdEkSQ=;
        b=FvZ71eLxhLvsq5X3aimEnZkcdPvuZaehrQx7Hnk5cqkPUGZ+vu+s0HjxozD9+5uxj9
         W8VD1Pi0W5QH3dXMnoMtWg+xsu9m6dbJwdJn9wjEV3KtmavXgWjXAA0ZEcwenlNyyF75
         lRPTZLSOVlPlk06KGWm7QnpVHvdBbE7lyMeLF89LMyl74J2mIrEeG3aZAIE8nHh9sQjV
         OMkLG5sDFP640/pUKakkzWQvsChTQNuacjSKQvtiJjWrkbFyAMLLiICJdoR9A6Pf52+0
         M9G5yahSG37fkAjZ7IECQNLrjTst1JOZxqLXDJKwZi3vN4hlmWgvabdq2Z+dVtE0Blgt
         mEOw==
X-Forwarded-Encrypted: i=1; AJvYcCVL6oLWhiOr3SPHgPQXv7beCSYs3rkG/VUOIkv6cwHzpeSoCBshRSXqMR05z+jem3cxTZs6K8rd3kVFEBMFmpE9xNkUEEtFIi2Ox6Xj2p9tZeQ0itBByNDIPR3sb3oBYy/iMoeNkoiQaiqtfrgZy4mz
X-Gm-Message-State: AOJu0YxrrPxqy/jx18IGmQSSqcWxq1cXLpPBVNmjgJy7bztmZLXBbExY
	j17bLZlemCzMeDggmiUomsULkWICd6DdsaAEhwi0N9AMUQ3T8OTY1Rm3t2/BQMRb36dU242DAZX
	vaPBGwbnLDBsb+ZBpuQX+BbR9ZIctnGV8
X-Google-Smtp-Source: AGHT+IEvFBm8THSAoNlLCuFQCtC8Bpr3mG0mLNomGsUm5mfhR2GPbp6EU9ie9/y9wULGYr6l2lGsBIQ62m7BsphMURM=
X-Received: by 2002:a17:90a:66c9:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2cf7e1c06e4mr8298736a91.11.1722351667125; Tue, 30 Jul 2024
 08:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730123421.GA9085@redhat.com> <20240730123447.GA9099@redhat.com>
In-Reply-To: <20240730123447.GA9099@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 08:00:55 -0700
Message-ID: <CAEf4BzYP_WqC=+ntYw6YE83hZWi6qnPvSoTb4qt+Py-FyHcmew@mail.gmail.com>
Subject: Re: [PATCH 1/3] uprobes: change uprobe_register() to use
 uprobe_unregister() instead of __uprobe_unregister()
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:34=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> If register_for_each_vma() fails uprobe_register() can safely drop
> uprobe->register_rwsem and use uprobe_unregister(). There is no worry
> about the races with another register/unregister, consumer_add() was
> already called so this case doesn't differ from _unregister() right
> after the successful _register().
>
> Yes this means the extra up_write() + down_write(), but this is the
> slow and unlikely case anyway.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/events/uprobes.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>

Yep, makes total sense, in my local patches I basically already done
that as well.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 974474680820..5ea0aabe8774 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1174,16 +1174,18 @@ struct uprobe *uprobe_register(struct inode *inod=
e,
>         if (likely(uprobe_is_active(uprobe))) {
>                 consumer_add(uprobe, uc);
>                 ret =3D register_for_each_vma(uprobe, uc);
> -               if (ret)
> -                       __uprobe_unregister(uprobe, uc);
>         }
>         up_write(&uprobe->register_rwsem);
>         put_uprobe(uprobe);
>
> -       if (unlikely(ret =3D=3D -EAGAIN))
> -               goto retry;
> +       if (ret) {
> +               if (unlikely(ret =3D=3D -EAGAIN))
> +                       goto retry;
> +               uprobe_unregister(uprobe, uc);
> +               return ERR_PTR(ret);
> +       }
>
> -       return ret ? ERR_PTR(ret) : uprobe;
> +       return uprobe;
>  }
>  EXPORT_SYMBOL_GPL(uprobe_register);
>
> --
> 2.25.1.362.g51ebf55
>
