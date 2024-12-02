Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE620D507
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150738; cv=none; b=K5BXlMcwQjKPSlw/W+2uW3SRUaMHYdnNFFnl94RGTLwCWAfqS5Xg4AxVCtJDqxrxX6BWVDK8CIaqqjMQU1EywsuuIEDSeEx4/JTh1Sri5K42wvkkkaBTuC0VCQx4SIuo9GZiuI1qh1TZ+JuY9lFEJ71U1LNHFhIoTi2py9dcFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150738; c=relaxed/simple;
	bh=n70OEj1mC+cdL0WdOAR5oKz8bYnGJfdRI3Edu7mnlh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qe8OI9v0lwg3NdmQY8dhtA3SjileEElZokWsMY7SagcW5d6VqYkJj6avdgwbxkBszGqFZSs0MyXXeLYHMQEAonCLfzHy/TgdixOh3Iz0s9RJ5TzXEmfiYrIWXiwz6ctVvqxp2AvDa7rxVAv9S1oD5oJU3XVi2reoqhTtuuvlFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx6/WCps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx6/WCps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W10UJR/Z3Y1g/9yP+6tAwUQlbmi/1LL8javKNMvmKDs=;
	b=hx6/WCpswS6AzSijjuOcC1boRtYqwc1/sxS2mlQfcJX8vt/Us3t7ravaqtrW2BGfQO1OGZ
	8VaAxLxJXGKmX+mhabH1xSrWRqJSapag3apyNoNw2xrSWmdA0Cx1VDJvuodIqn2rfoR6YX
	2r/JjUUsWcxs0G1u98n928J9KuYWeSo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-CjvrPcHwO8ab67M8izodyQ-1; Mon, 02 Dec 2024 09:45:35 -0500
X-MC-Unique: CjvrPcHwO8ab67M8izodyQ-1
X-Mimecast-MFC-AGG-ID: CjvrPcHwO8ab67M8izodyQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa52d371666so404049866b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150734; x=1733755534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W10UJR/Z3Y1g/9yP+6tAwUQlbmi/1LL8javKNMvmKDs=;
        b=m1ddA8fWPotpPFea7l8fH1cVFnWGPzN21BYKIdPmiduVb+qHeUTEtfLbN9JKM1pEU2
         5t51Qoj1XXqakR8tIaWYKvQKa7+d0CtDzF8ScqF5usDTvGbYQzPU1Q4XfXgUXzFEAIgj
         R0YueScGBxaD3eDKfm5vtqKyOgM6wC+rS2iqWnPU63Cu6KgI9qF9HkhnMIbDt324EqwZ
         868Ow8JmbLOu9xfCNUHTjY1NEaqnCGi38g0uS6FSyq4sCkGBqa/dmsASJPTn6uTC7aon
         PYrwjAFpbHiJlNODBdn2YgHfiSY2zskl4xigyR2aJTWCUEphTT235/8DMJwGvk+u9dtL
         U5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXSRP8iwM4k1ZG/TTq/RLf7+0exmvN0o4APzB4q0J57kmUBPlOR3hUpXRRYGlZ4pWzjLU48YGyhDuMWC/RnxBnEsl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1IMTEM2ZqjshqPCYBIvtwDkWzawGd39dmQEyudvfXC01aOD6
	Sn54XSXl5Xg7wc6ElIKsD5ol7ibYm5sU+eqhbW7a/y6oKdr1CLiz5WIZiED5GGgFTQ7xVRTlO81
	x2me1+ih1uYGW81Yiz6auPfKfUO/isiFqeZNonalqWqK+z+ILnVjGk++06je3Cx8YYwJuSuSpai
	20LX/N3FfLlTLo0jOC26LMYDFMuQ/YvIqlW6tUXwSPNSkA
X-Gm-Gg: ASbGncu1ROytddcjCdRtbynDGWESenVjQnIrudZccVdRvU10naOb1idfOrQrOD/PfNW
	f8NCdX4ZZZyq4ISavTd4rFSitdIA04EVoNRYJU1pETqTT0Na3mqFHg4kgpHNLcLI=
X-Received: by 2002:a17:906:9c2:b0:aa5:225f:1902 with SMTP id a640c23a62f3a-aa580ee048cmr1817439066b.8.1733150733917;
        Mon, 02 Dec 2024 06:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcA/wDe0r3wh7CcYqSoBDkWCwoa5A7JE11X7DdWa0YQ127gdehXm4o9jBtj0pJi92GpZIL1+glwSsQzVTNRV8=
X-Received: by 2002:a17:906:9c2:b0:aa5:225f:1902 with SMTP id
 a640c23a62f3a-aa580ee048cmr1817436966b.8.1733150733572; Mon, 02 Dec 2024
 06:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org> <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org> <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org> <CAP4=nvTjdZRfWtpvM+gThPv6SghW96i9YykA88vAFH5x39GZqw@mail.gmail.com>
 <c2d5cfd5-8bdb-4060-a974-18f9c2b9a2d0@yoseli.org>
In-Reply-To: <c2d5cfd5-8bdb-4060-a974-18f9c2b9a2d0@yoseli.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 2 Dec 2024 15:45:21 +0100
Message-ID: <CAP4=nvQe0KGxUAQSers9GbvZS0sVptbFzXufgGhuxAzVOyicHA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yuTy75Ob4UZcxhtt6OToAjugMWEjkGjA2x1X1g1rdYA_1733150734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

po 2. 12. 2024 v 13:53 odes=C3=ADlatel Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> napsal:
>
> Thanks, I will cook a patch !
>

Thanks!

> > As of the FOPTS changes: are those necessary for rtla to build, or
> > were you just using them for easier debugging? AFAIK rtla shouldn't
> > depend on unwind tables or stack protection for functionality.
>
> Well, my toolchain does not support it, so it fails at link time:
>    LINK    /home/yocto/Projects/wabtec/linux/tools/tracing/rtla/rtla
> /opt/m68k-buildroot-linux-uclibc_sdk-buildroot/bin/../lib/gcc/m68k-buildr=
oot-linux-uclibc/13.3.0/../../../../m68k-buildroot-linux-uclibc/bin/ld:
> /tmp/ccih6k6Z.ltrans0.ltrans.o: in function `err_msg':
> /home/yocto/Projects/wabtec/linux/tools/tracing/rtla/src/utils.c:30:(.tex=
t+0x1a0):
> undefined reference to `__stack_chk_guard'
> /opt/m68k-buildroot-linux-uclibc_sdk-buildroot/bin/../lib/gcc/m68k-buildr=
oot-linux-uclibc/13.3.0/../../../../m68k-buildroot-linux-uclibc/bin/ld:
> /home/yocto/Projects/wabtec/linux/tools/tracing/rtla/src/utils.c:39:(.tex=
t+0x1e0):
> undefined reference to `__stack_chk_guard'
>   <snip>
>
> That's why I removed this option.
>

Sorry, I misread the diff. I thought you were adding options, but you
are just removing  -fstack-protector-strong, right? I believe rtla
should check for the feature first before adding
-fstack-protector-strong, like perf does in
tools/perf/Makefile.config:

ifeq ($(feature-stackprotector-all), 1)
 CORE_CFLAGS +=3D -fstack-protector-all
endif

The feature-stackprotector-all does a test build, if you have a
toolchain where building with -fstack-protector-all is broken for any
reason, it will return 0. You can try doing something similar for
rtla.

Tomas


> >>
> >> But it is not enough, as executing rtla fails with a segfault.
> >> I can dump a core, but I could not manage to build gdb for my board so=
 I
> >> can't debug it (I don't know how to debug a coredump without gdb !).
> >>
> >> JM
> >>
> >
> > I have seen a similar libtraceevent-related rtla segfault recently on
> > ARM64, which was fixed by updating libtraceevent to a version that
> > includes the fix. Such issues are caused by the files for kernel
> > tracepoint tracefs having different contents on different
> > architectures, exposing bugs. I see Steven has already fixed one of
> > the issues on m68k [2].
>
> I will try to use the very last versions of both libtracefs and
> libtracevent and see if it is still happening !
>
> Thanks !
> JM
>

