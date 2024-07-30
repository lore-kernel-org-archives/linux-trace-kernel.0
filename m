Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3D2A1C7;
	Tue, 30 Jul 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351714; cv=none; b=u5SWVap0nbXD/co7WGtQ17C6iJ1i35twsAI3swp3HHWH5pdqs6AvOWWcxRY1P5BbJ7BdPlAiWUIGbhrlqK9wqQaJxM5Dg9athXkOGaLyjhdUIqhajkxpHD9CU4MwYPfWylPXgl8J73vK9WVWKOsG8vkSbMZjwa7rLDK0GWj+aQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351714; c=relaxed/simple;
	bh=bCaMdh/3xJbPk34aqOq1F0l0pcdFDnh+X+tO5rUbloc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwPPlwMbPUMLWvNnIzqFW54gjdMyeiLHKcrSVcCl2tzZJaaZJ1gNsnjt2Iqv4rDyLgzDY+Ymi8Bvs1mz7+QsEKjsmQg/W5xdOc87ZILLGM8oXXS2kOTtRNqiqFn5kcXir4hGnqwvi9ah7BCui8Ql6ZUdKApot2ku6cqGaFYKAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6CAsSnR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6CAsSnR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd65aaac27so27702335ad.1;
        Tue, 30 Jul 2024 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722351713; x=1722956513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad5cKPPSo8aU812D9D8BD2IIBKW/WiIyOn7ceM9yVQ8=;
        b=a6CAsSnRrexdEgjJZrKI5j/WWrgmfCL/rFNtfnEkoBv97AOmIcj2GMVDnhB0gVDk2y
         UTjW92U2rMI+NghGbub2ZLq6oDj38YczQmZRHNx6gjHmniKRm3ORMtsQsIo5V24ZdWLr
         e/V5fd2XTrcNWdpU88xI90gEsFt/aewgvqDAwd0e7VfBIrwEGOhLPsZ9Khf2PQyGG19e
         VATgAsImDbQWTj9UQ99SWbJAkgAVIAGN/D6qVJ4vD7NSjxd8JhFpGTbSoAfKEzqS96Wl
         PdUq6Y+6qNLcgvItDz1M3CyHTITv8FhngdR83kSi9c4vhrl7YPyCYz7w9v+6QwhndIYe
         7dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351713; x=1722956513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad5cKPPSo8aU812D9D8BD2IIBKW/WiIyOn7ceM9yVQ8=;
        b=wD5OcfyR7fXq4LLrcdZnQTDx1hCcZVxfCf+j0jpxpquC/hedGKteKv/MVMZFXXw0IV
         p0Zo0W63gD1WODK14DrtZmEJw5XAbTYfP/qunbXKtFiskqaO6w9t1t1g2JN54RAfFWAs
         Eh9JZzTv8DlfpHrJu9JnRlMqWc2sH03epfzxAHO9zc/2GVQdom/a7UDROB8Bq7KowOnl
         hc6iCACy9dsnuEYjr/xK+hUyqg2kAWwGHI3FTy+FEuwcLkrLwbEm0fu6qeLuSDgKll+d
         5g8f/rxf+zRAiZ+l2BDq5nSKIjG4sIFWLAyaPmIesDyhze/QEu8TcEPdYhogpdxeNaja
         u2fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMIwzC46HuBnDU7NMZ7Iv4FGrNMEpKgh7+vvzR1gDdM8qLuOSkUIgXRG6xssx5vZii5YU+Sw/PaW1sqRYs/RBO1TnoKJiQTtdlH1ckNWjLSwSjTn1GaZjsuLzhNS8DbqGnT7O2g5ywicOf4WLh2gtu
X-Gm-Message-State: AOJu0YxILkBpMpsB68NGwlxRK0KrhRoIGGH42NSfRQ2h9x6hRM+tBrpR
	Ip1fAngvAhmn/6WfCTSOECSrdMVlaDSusgypdOsH8++soRQPuJMESravJ8pqPzgVrFfozi+ZLNl
	ao6UVsu6AHCOZ2lr5FsnCaSv915w=
X-Google-Smtp-Source: AGHT+IHdqHHyt2vuAPE7HE+48pSbY9YmUCRAbquiO7hmZDvo9TC547JzGtWhThCJt89rMnmpHwqIonwWNS9EIBLluJM=
X-Received: by 2002:a17:90a:a785:b0:2c9:5a71:1500 with SMTP id
 98e67ed59e1d1-2cfca981a8amr3988786a91.0.1722351712389; Tue, 30 Jul 2024
 08:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730123421.GA9085@redhat.com> <20240730123452.GA9102@redhat.com>
In-Reply-To: <20240730123452.GA9102@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 08:01:40 -0700
Message-ID: <CAEf4Bza7FEXZQWx_yKw0tNjEs9s-e75PQUAuFmKOi+yUTpqcDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] uprobes: fold __uprobe_unregister() into uprobe_unregister()
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Fold __uprobe_unregister() into its single caller, uprobe_unregister().
> A separate patch to simplify the next change.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/events/uprobes.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 5ea0aabe8774..c06e1a5f1783 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1085,20 +1085,6 @@ register_for_each_vma(struct uprobe *uprobe, struc=
t uprobe_consumer *new)
>         return err;
>  }
>
> -static void
> -__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> -{
> -       int err;
> -
> -       if (WARN_ON(!consumer_del(uprobe, uc)))
> -               return;
> -
> -       err =3D register_for_each_vma(uprobe, NULL);
> -       /* TODO : cant unregister? schedule a worker thread */
> -       if (!uprobe->consumers && !err)
> -               delete_uprobe(uprobe);
> -}
> -
>  /**
>   * uprobe_unregister - unregister an already registered probe.
>   * @uprobe: uprobe to remove
> @@ -1106,9 +1092,18 @@ __uprobe_unregister(struct uprobe *uprobe, struct =
uprobe_consumer *uc)
>   */
>  void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc=
)
>  {
> +       int err;
> +
>         get_uprobe(uprobe);
>         down_write(&uprobe->register_rwsem);
> -       __uprobe_unregister(uprobe, uc);
> +       if (WARN_ON(!consumer_del(uprobe, uc)))
> +               err =3D -ENOENT;
> +       else
> +               err =3D register_for_each_vma(uprobe, NULL);
> +
> +       /* TODO : cant unregister? schedule a worker thread */
> +       if (!err && !uprobe->consumers)
> +               delete_uprobe(uprobe);
>         up_write(&uprobe->register_rwsem);
>         put_uprobe(uprobe);
>  }
> --
> 2.25.1.362.g51ebf55
>
