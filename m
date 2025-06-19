Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5C21D3E7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Jun 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352872; cv=none; b=XBP8AtHerFGjKYarO9EZ6f2GkphkkACggR0xYnBR5W9h4NZU0WAIcPJ5lzR9dsDgpazU/0v/jJpKapw/SE3S7361sS8FXX7u2bBCaXBdVZtL48DMaPBsyrMvpGPdfTp7aRFWDA+AyeG3iBGwnCpeemxPr+rpGrwqm57l9xE+ulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352872; c=relaxed/simple;
	bh=B5xc4Im05++LMRdzad+5xNIee+4aqUsqqP5r2J93OA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebOlWxF4abI4ZeWbXfRSfBwINt3wvZ20fBCHuWHFP6e90xWEhflb3WWF/YPMDBApF0AXIipP5T1ybtmud4x35uPH73G6ZM4cTgcWll5B9NrE2PNmv0LDGKUOtTRl/periIwX6L1ABsg3DQwwi0VGZ+xDDHaC8NzbjjtSMvKeuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+UViXE9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+UViXE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750352868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjyIhtiRnhSBaob8GERBPEKyHALfv30BI7kLfLtsO80=;
	b=D+UViXE9ZhqsaJYnHHui6y9FCQTVjZ50w8QrYkYurKUqGmkk8DYppYsTIZRMGab5DsxZeR
	VnQOhkSj0LGyA61wQIpRMfZl6pt79rsCHeA7NdH1W77qRUz0BOVhSOSglBLU/4Oan6vCke
	OHc+IT9QspXy4yHozIAisO68z7+o2Mo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Sm3vJqWTON-n4J9FvLyuew-1; Thu, 19 Jun 2025 13:07:47 -0400
X-MC-Unique: Sm3vJqWTON-n4J9FvLyuew-1
X-Mimecast-MFC-AGG-ID: Sm3vJqWTON-n4J9FvLyuew_1750352867
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a42c569a9aso15506191cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Jun 2025 10:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352867; x=1750957667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjyIhtiRnhSBaob8GERBPEKyHALfv30BI7kLfLtsO80=;
        b=eprzbYVUkzQ19m0/Hf17PiDocWuiPrtSwdWvuQWvZrBUQ5PsYmV4GJgwaWBV2uTowc
         LytFq/3METXVqflVKDR+T2vcx5BNqktrfuIpnBvZsieJVpIYyh24vt+XmbuejHHINXRf
         2h9i1SyXCU/ihRomWBs8JLcPRYt28puGdS2dDcgRUspXZICGnvVlNdWB9KKvNlej/92R
         VamvBlY2uGgueLSHp/6bcuCnsHXUQgPySey3/yoNcy5l4zSffqyDEoVm8dDQIALI6x0Q
         6JXNxwKnXL6Fmk3vdAqLX5Q6/QVB74Hhlko7Ak3k0hmupPiJPUdMyQNeikoda2G8ReRx
         77MA==
X-Forwarded-Encrypted: i=1; AJvYcCUsuOJi30Ic1wgGwbc7QTVGdoO1oxQuemjNhWeMixbZT2evykH4QzRkHu2U8ZTlE5c8Pp5YIkAAtEOy04ekbnvilfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1KZfoXcuPp1sFlEJyubPwTqgaYE6QhCCiLnYFfkY/aUvJKW9
	Jpn3lY9vciJJoBSfjCRvZ+b2VSSpEMAM/ZHyaBw89dNFS+6dW3D7OGzHZGZE4xFpSKhNbY18WJZ
	RaCLaPEO6HoUpkBM8XuUe7JivTWDtBnIRCS6abqE8YpxE3iNlDDv/YsAYM8yeG+gqacbxOASGTn
	lEYO4JIyVp6+K8d6bPhrPBOldaSplNcub4RsiYv1Q8DVPUo29arB34h4jV2A9OI7JB3Jo=
X-Gm-Gg: ASbGncv2YcqLhXvNH6aNesN1+8JT4v/EWhG3uvre2Bz7GeHH8Buxbra/kDrD43xCD3z
	KhP3tEn42OQ86aeS3VrQdA+z4oHXj4pnOvYcbCnS4odczY6ARQvrycKnpfmb+El8rMD+GDbUASa
	Ju9Ug=
X-Received: by 2002:a05:622a:19a6:b0:4a7:8af:3372 with SMTP id d75a77b69052e-4a76e188722mr49519031cf.1.1750352866768;
        Thu, 19 Jun 2025 10:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSmzCND1WCN9txyruppfLoZ6hfmgwfWopqcmajFZQtgBnUJsRuaTRf7kq/mh+lvzQ9HZm6xdYEe9rxcT0QBgw=
X-Received: by 2002:a05:622a:19a6:b0:4a7:8af:3372 with SMTP id
 d75a77b69052e-4a76e188722mr49518651cf.1.1750352866365; Thu, 19 Jun 2025
 10:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612104349.5047-1-gpaoloni@redhat.com> <20250612104349.5047-2-gpaoloni@redhat.com>
 <20250613114527.7e27a9a0ecc2b59d98677b0c@kernel.org>
In-Reply-To: <20250613114527.7e27a9a0ecc2b59d98677b0c@kernel.org>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Thu, 19 Jun 2025 19:07:33 +0200
X-Gm-Features: AX0GCFvxdyIr50kq-ajUHcRRD0JDOX9DLGaUyoN1IXHTnqLROGXdeqmRnZ5jTng
Message-ID: <CA+wEVJa0jL-JH_4=5sR+Mvb26n4mPPudmOL0LRBDV54nMZcw8g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] tracing: fixes of ftrace_enable_fops
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	acarmina@redhat.com, chuck.wolber@boeing.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -l0rZq7ByENSIpdvfa9Z5VtRHLfmpWijw_0T2FlxRlI_1750352867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami

On Fri, Jun 13, 2025 at 4:45=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Thu, 12 Jun 2025 12:43:48 +0200
> Gabriele Paoloni <gpaoloni@redhat.com> wrote:
>
> > Currently there are different issues associated with ftrace_enable_fops
> > - event_enable_write: *ppos is increased while not used at all in the
> >   write operation itself (following a write, this could lead a read to
> >   fail or report a corrupted event status);
>
> Here, we expected the "enable" file is a pseudo text file. So if
> there is a write, the ppos should be incremented.
>
> > - event_enable_read: cnt < strlen(buf) is allowed and this can lead to
> >   reading an incomplete event status (i.e. not all status characters
> >   are retrieved) and/or reading the status in a non-atomic way (i.e.
> >   the status could change between two consecutive reads);
>
> As I said, the "enable" file is a kind of text file. So reader must read
> it until EOF. If you need to get the consistent result, user should
> use the enough size of buffer.

What I am concerned about are scenarios like the one below:
---
# strace -Tfe trace=3Dopenat,open,read,write scat 1
/sys/kernel/tracing/events/kprobes/ev1/enable
open("/sys/kernel/tracing/events/kprobes/ev1/enable",
O_RDONLY|O_LARGEFILE) =3D 3 <0.000237>
Open /sys/kernel/tracing/events/kprobes/ev1/enable ->fd=3D3
read fd=3D3, 1
read(3, "0", 1)                         =3D 1 <0.000099>
1 bytes Read
30,
read(3, "\n", 1)                        =3D 1 <0.000095>
1 bytes Read
0a,
read(3, "", 1)                          =3D 0 <0.000102>
close fd=3D3
+++ exited with 0 +++
---
So in this case there are 2 consecutive reads byte by byte that
could lead to inconsistent results if in the meantime the event
status has changed.
With the proposed patchset the same test would result in a failure
as per log below:
---
# strace -Tfe trace=3Dopenat,open,read,write scat 1
/sys/kernel/tracing/events/kprobes/ev1/enable
open("/sys/kernel/tracing/events/kprobes/ev1/enable",
O_RDONLY|O_LARGEFILE) =3D 3 <0.000227>
Open /sys/kernel/tracing/events/kprobes/ev1/enable ->fd=3D3
read fd=3D3, 1
read(3, 0x7ffd960234e0, 1)              =3D -1 EINVAL (Invalid argument)
<0.000228>
close fd=3D3
+++ exited with 0 +++
---
On the other side the proposed patchset would be still compatible with
=E2=80=9Ccat=E2=80=9D or =E2=80=9Cscat 2=E2=80=9D commands that continue to=
 work as they do today.

>
> > - .llseek is set to default_llseek: this is wrong since for this
> >   type of files it does not make sense to reposition the ppos offset.
> >   Hence this should be set instead to noop_llseek.
>
> As I said, it is a kind of text file, default_llseek is better.
>
> But, if we change (re-design) what is this "enable" file is,
> we can accept these changes. So this is not a "Fix" but re-design
> of the "enable" file as an interface (as a char device), not a text
> file (or a block device).
>
> I want to keep this as is, same as other tracefs files.

IMO it is a redesign that is enforcing the user to avoid erroneous
usages of enable files (because the reads are either reporting the
whole and correct status of the event or failing to read; also the user
cannot llseek into a position that would lead to not reading or reading
a corrupted status).

On the other hand the proposed re-design is fully compatible with
the current user space commands reading and writing to the enable
files.

If the concern is having inconsistent implementations between tracefs
files, I am happy to extend this patchset to all traces files, however,
before doing so, I would like to have your approval.
Otherwise I will just document the current functions and associated
assumptions of use that the user must comply with in order to avoid
the erroneous behaviour.

Thanks a lot for your inputs and clarifications.
Gab
>
> Thank you,
>
> >
> > This patch fixes all the issues listed above.
> >
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > Tested-by: Alessandro Carminati <acarmina@redhat.com>
> > ---
> >  kernel/trace/trace_events.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 120531268abf..5e84ef01d0c8 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -1798,6 +1798,13 @@ event_enable_read(struct file *filp, char __user=
 *ubuf, size_t cnt,
> >
> >       strcat(buf, "\n");
> >
> > +     /*
> > +      * A requested cnt less than strlen(buf) could lead to a wrong
> > +      * event status being reported.
> > +      */
> > +     if (cnt < strlen(buf))
> > +             return -EINVAL;
> > +
> >       return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf))=
;
> >  }
> >
> > @@ -1833,8 +1840,6 @@ event_enable_write(struct file *filp, const char =
__user *ubuf, size_t cnt,
> >               return -EINVAL;
> >       }
> >
> > -     *ppos +=3D cnt;
> > -
> >       return cnt;
> >  }
> >
> > @@ -2557,7 +2562,7 @@ static const struct file_operations ftrace_enable=
_fops =3D {
> >       .read =3D event_enable_read,
> >       .write =3D event_enable_write,
> >       .release =3D tracing_release_file_tr,
> > -     .llseek =3D default_llseek,
> > +     .llseek =3D noop_llseek,
> >  };
> >
> >  static const struct file_operations ftrace_event_format_fops =3D {
> > --
> > 2.48.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

