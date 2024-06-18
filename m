Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE81AC792
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704363; cv=none; b=hcx/nXxBJa5kte2ScnKcL3NaGZOGOcuBMzIIlvLkOkQiNkAa/3QgYq+8cuUb2lEVlx5srCel+4NpqscxNDM9abvnAcchUntBp4gTx1ooS20oHzWvmJsEV/OCabLC7871xPXSxCoGS7NC55gNxaevASY5ZpDWDL1u4+pdkkzz09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704363; c=relaxed/simple;
	bh=/lD+4/1pW5cDhxFei3+MLKsCC6iwlHSFD/OS/9oOq0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBNDeMrG0Ggr7rYBZ9BgWZ4t82LmAr6HaNDZdKNIK68UXI0oW5ORYlOnBj7ZXXQa1Sj5bL0/jP9lrV3t2rLykNw04LmkEfI/JlGsddqFAd+uE1RfJsihJW+RB4ck9MgomcZWH8x6Bbn81jq+JDq0ULfK/MsfUnKLXCe2lk11xaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsjrAVmf; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsjrAVmf"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62ce53782f4so53283247b3.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718704361; x=1719309161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lD+4/1pW5cDhxFei3+MLKsCC6iwlHSFD/OS/9oOq0k=;
        b=VsjrAVmfhgKgk0BZz2OIJMF9bkJgUftEQSucdt4LClcFdeaIEazUlInTIYbKQswyIV
         d+4RBPWvUu3nPmnArN0vcFRyv0q+/c/+QqtkfkN++EMG/fbX80mjNeuQZWV88lo0V0yN
         G8ce0zJGquwCtM1xrfKMvuo+U/1xuHM3dkGDswFfwXlPaE4tASod2Dwb1l3J35H+9a4K
         hgtODdwdRk5QVlkwnKqXv/PHSvTHBWfSM27tibrPdCi0jKqihzSbBoAVdgOq+KNfaXws
         P8D6bu6wFEz2B7WXRuDd+YogrqAcVmzM2/x/tHk3/2thUU8MGwh6VJQ/Bg9ccMWw4udb
         cTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704361; x=1719309161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lD+4/1pW5cDhxFei3+MLKsCC6iwlHSFD/OS/9oOq0k=;
        b=pPBBWy0OC0Sf6+M2jm6yeuMNKqGrdSu8byK4oiTJMOCcKsbP7CiRU6QcOx8W4tHfn/
         wkN5SnvnSbxW32t+RX5SopiXTVIQYLXd692GYmxw8/uh9xAYA3V24v6qPMkNRRN3Lg7U
         U2I761ZO78Xyl/GyWJmeoSKO301pz6jZuo8GL25dfdWtQH7vrW7x02u6BQruby670fGD
         hHaMuYqD9pkUB3G92rYL0TuGPMNYuZL+Z8voDQOTKl1Z5kdbcacCXD6OYx+e2dtdgxVk
         U3+MdzParqdl90uyql7F2pq9iLhuBgcrmy20Zh0Q0wPveLq/1cHaDVNnNWgMCKWtLWui
         C/pw==
X-Forwarded-Encrypted: i=1; AJvYcCXmI0RtFn0ywoR5GDKOeO40LJYKq4p/5Xt1IHLdwz6WB5DN8H3y1Z7VUCXJz7hTg2yhBBUi5CO8dJcDgU7qo3h+DJ0KWMULDna+YAWPL9Mgl2ep
X-Gm-Message-State: AOJu0YziRCue4OGCsQUJy5IXDqpv/LEQC3ZFuVCGhbIuwe3YnhGluICY
	VrUAfcYcy7uhajxEK3YTZLFyfRgr9ahmRCFgeNn1cpv7XjjbwBhQAdAFFAF/Plnw1R0Fp28l/i7
	YjxlfvNot8PxPnen9Ig/N3FIV+K5oixtom2O/
X-Google-Smtp-Source: AGHT+IHXX6s3T5giMDf3tx1b3GNQGpbXZt612lcGTYaBiEl87A/J206Ls33wh8SD7x8kKB2X9MD+tfEpY+oW/2ib5Ck=
X-Received: by 2002:a0d:d456:0:b0:632:c442:2316 with SMTP id
 00721157ae682-632c44224b4mr101739057b3.3.1718704360687; Tue, 18 Jun 2024
 02:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-33-iii@linux.ibm.com>
 <CAG_fn=X6wHfmGsVgdqwms_Hk1CQAZ6M5623WyatjVp=Uk-z9pQ@mail.gmail.com> <e91768f518876ec9b53ffa8069b798107434d0dd.camel@linux.ibm.com>
In-Reply-To: <e91768f518876ec9b53ffa8069b798107434d0dd.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 11:52:03 +0200
Message-ID: <CAG_fn=XhWpLKbMO6ZHpnxQDh+PXrTxBnL9X-1zZtBj-CoVk0=g@mail.gmail.com>
Subject: Re: [PATCH v4 32/35] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:40=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> On Tue, 2024-06-18 at 11:24 +0200, Alexander Potapenko wrote:
> > On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm=
.com>
> > wrote:
> > >
> > > put_user() uses inline assembly with precise constraints, so Clang
> > > is
> > > in principle capable of instrumenting it automatically.
> > > Unfortunately,
> > > one of the constraints contains a dereferenced user pointer, and
> > > Clang
> > > does not currently distinguish user and kernel pointers. Therefore
> > > KMSAN attempts to access shadow for user pointers, which is not a
> > > right
> > > thing to do.
> > >
> > > An obvious fix to add __no_sanitize_memory to __put_user_fn() does
> > > not
> > > work, since it's __always_inline. And __always_inline cannot be
> > > removed
> > > due to the __put_user_bad() trick.
> > >
> > > A different obvious fix of using the "a" instead of the "+Q"
> > > constraint
> > > degrades the code quality, which is very important here, since it's
> > > a
> > > hot path.
> > >
> > > Instead, repurpose the __put_user_asm() macro to define
> > > __put_user_{char,short,int,long}_noinstr() functions and mark them
> > > with
> > > __no_sanitize_memory. For the non-KMSAN builds make them
> > > __always_inline in order to keep the generated code quality. Also
> > > define __put_user_{char,short,int,long}() functions, which call the
> > > aforementioned ones and which *are* instrumented, because they call
> > > KMSAN hooks, which may be implemented as macros.
> >
> > I am not really familiar with s390 assembly, but I think you still
> > need to call kmsan_copy_to_user() and kmsan_copy_from_user() to
> > properly initialize the copied data and report infoleaks.
> > Would it be possible to insert calls to linux/instrumented.h hooks
> > into uaccess functions?
>
> Aren't the existing instrument_get_user() / instrument_put_user() calls
> sufficient?

Oh, sorry, I overlooked them. Yes, those should be sufficient.
But you don't include linux/instrumented.h, do you?
