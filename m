Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95351E230E;
	Mon,  7 Jul 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903009; cv=none; b=GHuYTKw3FB2AJJ7CEhAnsiv9MXeURN7UTSAONuku3B1jDbLDL9r+fr8gf96QhFNbSYQP5HCwR1EMIzsrzD7OX9OIQzeggOk0ANVbcPRFJa8XMUxuKsWZr1BvwrbY+My+jrJvt66pT2JN6N2BqUFSe2EGlHJGlOARXsxZnyuZqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903009; c=relaxed/simple;
	bh=CP+o2IJZeuKmu3xcodnBUxSMPnReNDSaWruj5R4STAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nraG9JZp9pUGAxv9cGjbE+y3CEW3+w6s5zRBGe4Ai/8OfP65F8XIV0XCgPWerAc3aopssmtbc+U8RlSmOwRLcSQWrkYOeKwxwt07L9AwMJBAk9gykH75iFsUaZjsAvyAoHEfnDCP6ZAV/8hsoLdgl6tgewc2MFWRKyp8etVHaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHQokKQS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHQokKQS"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e740a09eae0so3235618276.1;
        Mon, 07 Jul 2025 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751903006; x=1752507806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8J7mBthu19mcZj/JguMENIJNkZ8LvL2vXjI2w8Tuk0=;
        b=ZHQokKQSyDn4rFJ8He1t/gBIaYEmWTP8hmubU01feYSKLksWS0gaB+pG0vaz1eU9R6
         btk856qyQfxq+S9/1mZ+Kov55yPJKMtPKheyVyUSkzRQHGtWvAZDW02c5Q2KKcJmG5wH
         vKYOd4ie2N5+XGF5hW7vwi0rj54eHNi5lRy8AmKJiKfCgJ/Jb0sBw19rBb8bZGx132w6
         NNNLtMtk+Pi84wCmJEJSt+2eLYJgRVt7ror7KmDMQv63C0J33b1XdZXvt9wuNyKdVwof
         93NxKNiC1Oj/vYtS64vdlEpgzzXdMXoYRvqWRJ+dzcYL5ExSesIRjoBMKvYsm9YxhAxY
         aavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903006; x=1752507806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8J7mBthu19mcZj/JguMENIJNkZ8LvL2vXjI2w8Tuk0=;
        b=T9CV5t1eP+LsN7U8EqUOAhz5Ka5wwCO2nVmyyM141Svs1mEHDF0ujEgi+MW/4tRJ5v
         BvFtYQTpklrNH4cpfJelMTyXic5AOkHKTiaiYFimqUlu1LE4DuVSOxD44sdHVPXaoGSp
         u9/un+wLhE7HR93MZjkx/CFj2U7TQ1ANNdExDsVw7WRsucUU8MeM09mNFoe0KYYxv9DE
         g423BHvUHNnMf9YGS/+DkkZUs4NMrupGLOLnWieVX9f3QQnMsbZfhDc2keQG/CwcIlQs
         OMGLtNrHqO5axcAo2PzzpvW0CpkJP/QAGQNnJkieMAoeZLnZroS52QK37qlNcQK45YTx
         uGig==
X-Forwarded-Encrypted: i=1; AJvYcCUrQpK2tGaSJp7Nz/KRMRBK37jG4Si7IWzlEyaG51gkmEL6NKeTFkJ+YwWswzBPjfQjxmG3GjZzOKRn6OQ=@vger.kernel.org, AJvYcCX5TwZUVoGcjr9wJAP2tD72De6W0or5L2BRLHga1RJmqeVhBFTHVAGIFyN6AA+Q/p59wLsyw/Kb42g/VZNf5rdYjxU4@vger.kernel.org, AJvYcCXgs8AgCBciWE/jDE8UbE3tgRd+D3fO03Swu4IUVTM5my6thekSEPPHaHGNyIPO7elz+EC5nTsUBsMob+4l/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMK6qv5n7kQwtZhJs7eZ9wfguxJ4YU9iIsW8jl28XKBGrK0ERp
	TE8G+hXgnmUZRLm9LrMbDTMLIYnnfiesH4ltoDukSf01dWsknPCCOVwMnqWBaI4Bv59f0PZU9aX
	clyeOC3OfUQ8u6hVvPYmDQuqJADhPwJ8=
X-Gm-Gg: ASbGnctKQea+3qsZQgWJ9RdAhnB9CiolvG372mulynTCOh5Qphmy+epmu+PCHYtHp7p
	uoA49M4i9vVfOXQS78DqbyvlseMOkxGKdcfWCQPdd3OvoSvRbzbUOd2jA2rcfnPGSSV0d8YfA8N
	A6Yn/tw2RpXsLavsevvl9iERmsQmcc4wlr3ZU4XKF8tnQeXdU3Kov3iEZje+TED5LwTyXoxSXdc
	Pwi
X-Google-Smtp-Source: AGHT+IHqUB9q+QVNbKJo4Uvz5BjRd+loZsudS2WgTk/kpT3zX4uCKd6Exm4IiGxGmfWLlUL4z5y4wWJVU2duqemF/uE=
X-Received: by 2002:a05:690c:b1d:b0:70e:2d3d:ace6 with SMTP id
 00721157ae682-7176c9f96e9mr123304777b3.15.1751903006482; Mon, 07 Jul 2025
 08:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704134943.3524829-1-rppt@kernel.org> <20250704134943.3524829-4-rppt@kernel.org>
 <CAKQ1sVN9KZYt=M5cst+BonDMVL_wO3sbhgZ+JPzc=Rw9Qfz9tw@mail.gmail.com>
In-Reply-To: <CAKQ1sVN9KZYt=M5cst+BonDMVL_wO3sbhgZ+JPzc=Rw9Qfz9tw@mail.gmail.com>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Mon, 7 Jul 2025 17:43:15 +0200
X-Gm-Features: Ac12FXy94qZ_PO7wGP4tzdITQI0MX7kQaRgg6hDYlF5DovWOqRQJpEBlnBEJBtk
Message-ID: <CAKQ1sVNmf7KSpB1wJ1f2Vjn4cwKpctycg2Rq_fGjVo8BPf9_-g@mail.gmail.com>
Subject: Re: [PATCH 3/8] execmem: rework execmem_cache_free()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Daniel Gomez <da.gomez@samsung.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 5:32=E2=80=AFPM Yann Ylavic <ylavic.dev@gmail.com> w=
rote:
>
> On Fri, Jul 4, 2025 at 3:54=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
> > +
> > +static void execmem_cache_free_slow(struct work_struct *work)
> > +{
> > +       struct maple_tree *busy_areas =3D &execmem_cache.busy_areas;
> > +       MA_STATE(mas, busy_areas, 0, ULONG_MAX);
> > +       void *area;
> > +
> > +       guard(mutex)(&execmem_cache.mutex);
> > +
> > +       if (!execmem_cache.pending_free_cnt)
> > +               return;
> > +
> > +       mas_for_each(&mas, area, ULONG_MAX) {
> > +               if (!is_pending_free(area))
> > +                       continue;
> > +
> > +               pending_free_clear(area);
>
> Probably:
>                   area =3D pending_free_clear(area);
> ?

Likewise in execmem_cache_free_slow() btw.

>
> > +               if (__execmem_cache_free(&mas, area, GFP_KERNEL))
> > +                       continue;
> > +
> > +               execmem_cache.pending_free_cnt--;
> > +       }
> > +
> > +       if (execmem_cache.pending_free_cnt)
> > +               schedule_delayed_work(&execmem_cache_free_work, FREE_DE=
LAY);
> > +       else
> > +               schedule_work(&execmem_cache_clean_work);
> > +}
>
>
> Regards;
> Yann.
