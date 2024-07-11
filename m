Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38216DEB2;
	Thu, 11 Jul 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717933; cv=none; b=HSZdbpSnry4uRJT9kFhyY9VnXrdcmQFfIF01YpRHD+V6ZaMMVkQuVZWHqryeI5weJnAG5ZpTmGr0U0t0VSyO/RgCYaTYrJ5W86m6ltQTN32/dlC/vVNWUspx+qKfL/ph2Jwjvretv6V/8RH/ZVcfPHJOR2YgZL5B39HdDMCDx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717933; c=relaxed/simple;
	bh=5YIqNKwyUr+LG6yUl04mH/OQyT4FdO5vSgs3hwM55I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/f1Mpm5LBO7N1DtXoblQRNZRAusA7JGB/JeNYdZVtkBNv3NCXJCpAoqeZmwwaFwjLZsly5vu+JHAE+jQHLhfAQK1RahLvPUDqtxZs8cgHooY9ksce9WhLNZ56NNozwSrTm4PQdI2GaRNmbU0N7x8ICkjZPT3UU9kRc9v7+0zMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+j50o02; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+j50o02"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7611b6a617cso850354a12.3;
        Thu, 11 Jul 2024 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720717931; x=1721322731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8FKh1codzdsvdDdcwzA56jGoX640hJ0GFCrKgUVpxc=;
        b=Q+j50o02gOE4ypwdedtfu1m7jsyfyWQsw/LTVi+cOF9SxrGKWrgvfap1LKI5Z0hua0
         l5BD80ViOQ5gxx0bKVhdE/gZwIj1iPuwcsTHJvLe/cPqxRTbB/+IXqWjZ/mLfiPOJ283
         0xUZ8XUPu+ZMA9Az+G/j4ROBxjaYNgH99xSXCDJsuQKbZRJvWF6byHoTA0TSWPqwpbA6
         qLR63m4I7pA51E09tO6E5J5rUuTnMLEKyqcXkHbv8/jC7gmkSj4aiOwHni32MWpvdbCy
         du/3Ad+pksHrwpRJRFWN8V5vK+piee/2r4gHGWTb7+Zm1gkTZoRiQkW8iCNpuzQ/VuyT
         C6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717931; x=1721322731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8FKh1codzdsvdDdcwzA56jGoX640hJ0GFCrKgUVpxc=;
        b=pPEbjpQv1b3zxyiFRb/fSHwkquqvmgWyWEVINRfZbjvUTk5N2tZGuO9SI8u2v8eny6
         zeKyoMt8UDjbHmSby7xf0/kPgM4svdPHLo73s3U1nsO+dMND+d6Tu1h5qHkqTwKkQXlR
         P0BmphOS921m3Y176o9GnqByGVMT6yAr1g7fR4r7CjhvuuSg3dT0Vl60VH2gNqrY5zN+
         GFm6L76xRqFsud3LPehDQF+tJ+4Ln5qiD+W4lXQuG8ParDxyI99nbbeg4hKthLKWHK0o
         /h3p2mzzPcc6oslYttQ7BEDsDyqDS74E88RVGdVLm/6qVLZJFORnTseK7Ls1fV8r1/D1
         9paQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOkIKptQ9qJh3w6W3uuZS7NqRQ//hKWRql12lg/2e/6XixR5VnS0PyCNt5EWXDFt6lzY1KqkqhV79UPmNRE8PZ+udGFJOG04Wxg2usXkM/p0g5v0QoFQMG/6lSHoS9cC1of4MW12ff+4nop3186aYH
X-Gm-Message-State: AOJu0YwWjbR/SzeyWfYPmDEumbhxIfT9+PWDzx1fZOvxxJqmGxyQAWNm
	a2Ho+a+mrln02YZPCL1hUsqhW38icfkSw3Iwhr2YeG9UX8VSoNJEsLLoCFgZzPeyiaeYJO/Sq3Z
	Ro6pUxz/T04pEAE9vGxFjzevN3Jc=
X-Google-Smtp-Source: AGHT+IEXzsRL6ePSLYpXeg43d3J9B8DS4lHxsJA1VKNfsJe+PrY7j7Hl0j8NkYgMtVTyShQUgXo0PXxEB2CxxwdWORw=
X-Received: by 2002:a17:90a:f0d6:b0:2c8:6a9d:5060 with SMTP id
 98e67ed59e1d1-2ca35be1129mr7306896a91.7.1720717931172; Thu, 11 Jul 2024
 10:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140017.GA1074@redhat.com> <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com> <20240711092619.GA18031@redhat.com>
In-Reply-To: <20240711092619.GA18031@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 11 Jul 2024 10:11:58 -0700
Message-ID: <CAEf4Bzb0ErnW0o09fk2TCJnY3LNW7U4aB0YcUJqKjfNH+m-uyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe *
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, clm@meta.com, 
	jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org, rostedt@goodmis.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:28=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/10, Oleg Nesterov wrote:
> >
> > -void uprobe_unregister(struct inode *inode, loff_t offset, struct upro=
be_consumer *uc)
> > +void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *=
uc)
> >  {
> > -     struct uprobe *uprobe;
> > -
> > -     uprobe =3D find_uprobe(inode, offset);
> > -     if (WARN_ON(!uprobe))
> > -             return;
> > -
> >       down_write(&uprobe->register_rwsem);
> >       __uprobe_unregister(uprobe, uc);
> >       up_write(&uprobe->register_rwsem);
> > -     put_uprobe(uprobe);
>
> OK, this is obviously wrong, needs get_uprobe/put_uprobe. __uprobe_unregi=
ster()
> can free this uprobe, so up_write(&uprobe->register_rwsem) is not safe.

uprobe_register(), given it returns an uprobe instance to the caller
should keep refcount on it (it belongs to uprobe_consumer). That's
what I did for my patches, are you going to do that as well?

We basically do the same thing, just interfaces look a bit different.


>
> I'll send V2 on top of Peter's new version.
>
> Oleg.
>
