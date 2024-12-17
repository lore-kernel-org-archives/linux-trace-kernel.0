Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FF3E49D;
	Tue, 17 Dec 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442984; cv=none; b=Huo4HOvIBGyqSaZtazAQcQgKkTIZb35iRbNDaa82QhBw2qUSoHA98Wpw3KStXElZBKPjGfZRCWI8uFm0w53Tk0oO4LrHaDwfze/kj47Efonl1H1joYmTj3eFDYAiRYGrHxrAvaZBuDEIWYokfHFUNUC5F6eFWV1ZiqkeSpUrQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442984; c=relaxed/simple;
	bh=MANkfU86brZqQ6fYLavORJQ/GnRpq2p22/A6njWrwIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jc6fV+KO1AmqaHlDeTmOBIL3gnUxyNrw8ospTNDN1PTogjM8pIbUUirur9OigPIpljkMQzf+7iiwScd1g1EkB8Ptx4MdjVK+baoYO4ceKF4q2MtxMdU/g2PJ7zmryEsBIrlPXqIV0mORygm8y2VzgsuaC98Nx92Fhkroopxm9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+NLiLGM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+NLiLGM"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2979035a12.3;
        Tue, 17 Dec 2024 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734442982; x=1735047782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkIq8q3L8rJGyueaNhKKxXEE17k+mgKtdHU5gacy0ek=;
        b=b+NLiLGM6fsZiIwuXFVb2/judxSQ17GBnYAqqlFW/B2zJYWDhkZePP9YxoHE9gv+fz
         Z1UWUmFxYfd+pR3FW9XQtbnxwz0rnxpRf93HzH/HVD6hsuV2y0bKpxBjYGOUc+UWhVGV
         d7dcZuzibYDQwMHnQc2wFCf+dVo7D9L2ZY4wzWOBsSCk8DBESQQr92vlvoARUfAMOPOh
         3wR5sHdUET4SrrVQx1/gr1f5vz0OUZb/HtvO5itOwxmHfShB/bYivrXrJYPS/C1ruYx3
         7K8wCBrMJ+btMDEUY5h9Xhuc6RG9KZjJqzp44YbievpdIXHv34y1gdzlxz5IAz+533eI
         +AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734442982; x=1735047782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkIq8q3L8rJGyueaNhKKxXEE17k+mgKtdHU5gacy0ek=;
        b=o/r4CYNEkspprRwkoR13tL95nAsLwUuoiAOipWtjomOSKGfTU+234wTzzWJeV5MlW7
         ZxgDGVZmOGhkkY4ZNu6PEkIS3BzuD3xl4u8EcbIYylGFTPaDglPzsN0ReD/x58lCZYEn
         VCeOfxtypWjYQWeqr1FulFm2egAqRTXeZ7XNbfTniEgxLzfE4fGA9z5YQxgYHQs4Tcl+
         uMF+JjgUxlsYbe0VcvoGC7n41wu2KAESOfUAAffh5BdkiYjoHhNH+75pWb+KAHF0pERe
         a7acMUTQrSay55iE7Iv831g6VUitGNPaiBnhT4ysNqEXrLmwEmd/yudbjBBs99ldtqny
         iV5g==
X-Forwarded-Encrypted: i=1; AJvYcCU3L6tL55dw78MqFVFPacP8K5TtQfhcDtwm9z4TZiU9e04vpXTHfL4vJe3KGFLMxRsueN3pUj+8HZr1YiG/7CVHiL8a@vger.kernel.org, AJvYcCX+fH7OcNd4UVjqy1yLsgLv8sWt0mUM2L2NevlDcDKaeLDK48JM5sYaECSL6sBKGGB1qkCYqdlZEXuhOvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3GHJCPSDgI0depXTo6tzGWKITlEHZJvgALdiZMillfPJhPrT
	xaFcOT9Ahq0wpxuDJVsak+tCoRXeqGW5TI/9KaPn8tnqhTi5Zb3dqjEQ5KMQeYuHGVMTebEr3t6
	V1yHuU7d2PxSmTpYqvbnsYso+gZo=
X-Gm-Gg: ASbGncsOjaev5d0/4jRLq0mTi7ZPjTYe0jfx7G8IKqnxinNSjMSMD5Yg49mC9JzjAuE
	emBBGTWU2nujWuwC2ogB6BGEoFtvGGFLs6arra/Mo
X-Google-Smtp-Source: AGHT+IGi1xeCLzYpI9IUs7Cxa3BTl64nW6CdU0gPYtNrYByOcHi/Uerf0EvuXh2hO3PajPYio3YmU2nSUx1MndD3SPI=
X-Received: by 2002:a17:90b:1c03:b0:2ee:c457:bf91 with SMTP id
 98e67ed59e1d1-2f2d7d9cff9mr5318156a91.10.1734442981931; Tue, 17 Dec 2024
 05:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z2BpY5LimG7E3LpC@google.com> <24508411-0980-43EE-8224-C3B81E456AFF@gmail.com>
 <Z2E4cWMkzGqAafFQ@google.com>
In-Reply-To: <Z2E4cWMkzGqAafFQ@google.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 17 Dec 2024 22:42:53 +0900
Message-ID: <CAO9qdTGwQJvVZt2HtnBUdJGLti0ZWuPeqVFginJYcwY2xLnwRg@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: fix array bounds checking
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Vincent Donnefort <vdonnefort@google.com> wrote:
>
> On Tue, Dec 17, 2024 at 10:28:49AM +0900, Jeongjun Park wrote:
> >
> >
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > =EF=BB=BFOn Tue, Dec 17, 2024 at 01:49:30AM +0900, Jeongjun Park wrot=
e:
> > >> If there is a case where the variable s is greater than or equal to =
nr_subbufs
> > >> before entering the loop, oob read or use-after-free will occur. Thi=
s problem
> > >> occurs because the variable s is used as an index to dereference the
> > >> struct page before the variable value range check. This logic preven=
ts the
> > >> wrong address value from being copied to the pages array through the=
 subsequent
> > >> range check, but oob read still occurs, so the code needs to be modi=
fied.
> > >
> > > Hi Jeongjun, thanks for the patch.
> > >
> > > Did you find a reproducer for that problem or has it just been found =
by code
> > > inspection?
> > >
> > > As discussed here [1], s >=3D nr_subbufs should really never happen a=
s we already
> > > cap nr_pages.
> > >
> > > [1] https://lore.kernel.org/all/78e20e98-bdfc-4d7b-a59c-988b81fcc58b@=
redhat.com/,
> >
> > I didn't find the bug caused by this separately, but I found it while a=
nalyzing
> > the code. However, since it has been confirmed that syzbot
> > has a reproducer that generates oob and uaf, this will definitely be
> > reproduced.
>
> Could you share that reproducer? Or at least the steps. As this situation=
 should
> never happen a, follow-up fix will be necessary.

[1] When tested with a reproducer, pgoff was 8, subbuf_order was 0, and
subbuf_pages was 1. However, nr_subbufs was 3, so oob-read or uaf occurred.

[1] : https://syzkaller.appspot.com/text?tag=3DReproC&x=3D14514730580000

>
> >
> > The reason I suggested this patch is because I think the logic of the c=
ode
> > is a bit inappropriate. Normally, a range check is performed before usi=
ng
> > a specific variable as an index of an array. Of course, in this loop, t=
he page
> > structure pointer that was oob-read will not be copied to the pages arr=
ay,
> > but I don't think it's very appropriate to read the array using a varia=
ble
> > value that may be out of range as an index before the range check.
> > Therefore, I suggest patching it like this.
>
> Of course, no question about that.
>
> >
> > >
> > >>
> > >> Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping f=
unctions")
> > >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > >> ---
> > >> kernel/trace/ring_buffer.c | 10 +++++-----
> > >> 1 file changed, 5 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > >> index 7e257e855dd1..83da74bf7bd6 100644
> > >> --- a/kernel/trace/ring_buffer.c
> > >> +++ b/kernel/trace/ring_buffer.c
> > >> @@ -6994,9 +6994,9 @@ static int __rb_map_vma(struct ring_buffer_per=
_cpu *cpu_buffer,
> > >> {
> > >>    unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff =3D vma->=
vm_pgoff;
> > >>    unsigned int subbuf_pages, subbuf_order;
> > >> -    struct page **pages;
> > >> +    struct page **pages, *page;
> > >>    int p =3D 0, s =3D 0;
> > >> -    int err;
> > >> +    int err, off;
> > >>
> > >>    /* Refuse MP_PRIVATE or writable mappings */
> > >>    if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> > >> @@ -7055,14 +7055,14 @@ static int __rb_map_vma(struct ring_buffer_p=
er_cpu *cpu_buffer,
> > >>    }
> > >>
> > >>    while (p < nr_pages) {
> > >> -        struct page *page =3D virt_to_page((void *)cpu_buffer->subb=
uf_ids[s]);
> > >> -        int off =3D 0;
> > >> -
> > >
> > > I believe we can keep the struct page and off declaration within the =
while loop.
> >
> > The reason I modified it this way is that, since this loop will always =
be
> > entered if there are no other issues, these variables will be used in
> > many situations, so I think it is quite inefficient to continue to decl=
are variables
> > in a loop where you don't know how many times it will be repeated.
> > So, I think that declaring variables in advance and then continuously i=
nitializing
> > their values is advantageous in terms of performance and there are
> > no other issues. What do you think?
>
> I'm pretty sure the compiler would do the right thing here and no additio=
nal
> step would result from declaring both variables inside the loop.

Okay. In that case, I will just remove the variable declaration related pat=
ches
and send you the v2 patch right away.

Regards,

Jeongjun Park

>
> >
> > Regards,
> >
> > Jeongjun Park
> >
> > >
> > >>        if (WARN_ON_ONCE(s >=3D nr_subbufs)) {
> > >>            err =3D -EINVAL;
> > >>            goto out;
> > >>        }
> > >>
> > >> +        page =3D virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> > >> +        off =3D 0;
> > >> +
> > >>        for (; off < (1 << (subbuf_order)); off++, page++) {
> > >>            if (p >=3D nr_pages)
> > >>                break;
> > >> --
