Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653D1AD9D3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893134; cv=none; b=n4LIZwiFpInHBON8Lwlh/lvMUR+S4l+3n3E0nMiI+EEXVcY2HzOAdkeGmhs4ePm7PmjmbxcLCHDXIBasLTZLSHLxE5HvivPe5GtSx55FSTfQncaiddusORN91t2T64hewXJytErGwzRRL7tevaxjd0fIjOpGaTuXBDmE6ZLNt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893134; c=relaxed/simple;
	bh=1amn1rnBy31jrBxkOTLIJmYrX46YHZ7vfnEFlIGg+oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8BFwZwA8GYSsg8niGHHtYi/OyYj9bh+mTUpAYjBNGapJa6jhElQhL/K4hxao5I0D0OvquG+TKTWmBIwDAJpErEq4CbKLtyn0FEKZ9v3g8/AUbhXVVY0IVC0D4O4B33ZeIA5m2J9yuOpqKGTcKkrJuSA+G3MdzHkGyLP8cXw+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e86Ig/Mq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e86Ig/Mq"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-795fb13b256so154159185a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718893132; x=1719497932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVpLK2lHnHY7pIeS6zCf+0/9yVq/jqYVxmvNvh0uGr0=;
        b=e86Ig/Mq+ZtP4M62FXk6PdJ4Hhwl/JZCPmMWkATuBFqNcPa4V6xqB0mPR1s7mbvF/b
         VffA/Wy3FcENjHxvRJiJDhxY1nb/zV7IVkKX5WSVqQ11UMwJ+QxIIfNV61a7UI4Q5xA0
         eOpYPOqexCi4EgWjY+uCtU18N1634FpI08ChlD4wAlrYpuwN3jfAilbEyJEJO7A67Rab
         mNXvWnnvV8BQ5VHPmUHHlRT8iNh5+bjlqDUTZWkO62MfDwjuWav8coMDGEC07MsGdPcf
         HFynlBI6hd3Owkj0fOuKeE0binzA43UidzNrGD5cqDH9lWbYVziiCNq8VrIFL+42Yqsn
         hsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893132; x=1719497932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVpLK2lHnHY7pIeS6zCf+0/9yVq/jqYVxmvNvh0uGr0=;
        b=PGm28eYcvIXQxErkf0RHGkLT3olQTH2RQrxB9gk9ZObdx1242lAPoNFxhl1yQWuJxE
         9nzoKyHl6kF3gZpSGTcinGpy8iF3v1so3l90CUNvRgYVG4+P0qJ6cJ/vUxgQskptBuiD
         hufFxzdW6eYTXt5Qw0YaEbOvJNspkeXFN/3aSZAHM2VBot3FaXYAJ6Fk31Ag/W39olgl
         6Xe/dzzquRp0ch0zeSM+nyRCZ3TbxcUx55vRfoYzK8/6XqEI7y+8rO3aTv/kBo96CruI
         uAbB7+8V3W1gpDs/a4217fdYbTzFL5ztjYYl++az2revQJ2ZT2X7tR3G0K/ga5pqJJFk
         pezA==
X-Forwarded-Encrypted: i=1; AJvYcCVr99gaXjLMxen6O9rAFpD4fhredWOlK4ju97GaBkXGzk4HoVAfqJSfY+VaSyTQRzqtwB0TiWL/++ZAN9zFiMwWF6ILZlJ69oJ0gO3DEBFQqr+i
X-Gm-Message-State: AOJu0YzybbNvGmaNV5iGjRIdXRWcw6oDK2qbckCK78FBHuiyqktM9roz
	1dFmkZnA+Y+Iy0VhflpNhwadlA9dQLgA3dfUfo+lKHWT/V3dKPmy6/eTQTQj9wDWcF0McfhvH8E
	NYGcoRiTWwG3+9sT+jvAH9HM1VEaUPMyuyr4s
X-Google-Smtp-Source: AGHT+IHtcnbXmLmpEfj+IiY5XUc5XEkQvdka2ksT8Hxxn2saxQ3/KSY2Ox1gfyNah9/uoeZO0QSSo5ueNjvRU+cQOC8=
X-Received: by 2002:ad4:5969:0:b0:6b0:8ac1:26bc with SMTP id
 6a1803df08f44-6b2e2312207mr142468546d6.14.1718893131865; Thu, 20 Jun 2024
 07:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-37-iii@linux.ibm.com>
 <ZnP1dwNycehZyjkQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com> <f6ab5d6e0aa90ad85e239a2da9252930ca9a70c3.camel@linux.ibm.com>
In-Reply-To: <f6ab5d6e0aa90ad85e239a2da9252930ca9a70c3.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 16:18:15 +0200
Message-ID: <CAG_fn=V-_8q2FDEDtvcNmS3rizPEM-RX+vHPrus4ECNx6AZfGg@mail.gmail.com>
Subject: Re: [PATCH v5 36/37] s390/kmsan: Implement the architecture-specific functions
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

On Thu, Jun 20, 2024 at 3:38=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Thu, 2024-06-20 at 11:25 +0200, Alexander Gordeev wrote:
> > On Wed, Jun 19, 2024 at 05:44:11PM +0200, Ilya Leoshkevich wrote:
> >
> > Hi Ilya,
> >
> > > +static inline bool is_lowcore_addr(void *addr)
> > > +{
> > > +   return addr >=3D (void *)&S390_lowcore &&
> > > +          addr < (void *)(&S390_lowcore + 1);
> > > +}
> > > +
> > > +static inline void *arch_kmsan_get_meta_or_null(void *addr, bool
> > > is_origin)
> > > +{
> > > +   if (is_lowcore_addr(addr)) {
> > > +           /*
> > > +            * Different lowcores accessed via S390_lowcore
> > > are described
> > > +            * by the same struct page. Resolve the prefix
> > > manually in
> > > +            * order to get a distinct struct page.
> > > +            */
> >
> > > +           addr +=3D (void
> > > *)lowcore_ptr[raw_smp_processor_id()] -
> > > +                   (void *)&S390_lowcore;
> >
> > If I am not mistaken neither raw_smp_processor_id() itself, nor
> > lowcore_ptr[raw_smp_processor_id()] are atomic. Should the preemption
> > be disabled while the addr is calculated?
> >
> > But then the question arises - how meaningful the returned value is?
> > AFAICT kmsan_get_metadata() is called from a preemptable context.
> > So if the CPU is changed - how useful the previous CPU lowcore meta
> > is?
>
> This code path will only be triggered by instrumented code that
> accesses lowcore. That code is supposed to disable preemption;
> if it didn't, it's a bug in that code and it should be fixed there.
>
> >
> > Is it a memory block that needs to be ignored instead?
> >
> > > +           if (WARN_ON_ONCE(is_lowcore_addr(addr)))
> > > +                   return NULL;
> >
> > lowcore_ptr[] pointing into S390_lowcore is rather a bug.
>
> Right, but AFAIK BUG() calls are discouraged. I guess in a debug tool
> the rules are more relaxed, but we can recover from this condition here
> easily, that's why I still went for WARN_ON_ONCE().

We have KMSAN_WARN_ON() for that, sorry for not pointing it out
earlier: https://elixir.bootlin.com/linux/latest/source/mm/kmsan/kmsan.h#L4=
6
