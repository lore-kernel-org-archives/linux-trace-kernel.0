Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDD1DB363;
	Fri,  4 Apr 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743769715; cv=none; b=ovpO8gzXv6T6xGzLmgzGy6Xfm4cpB5L5qAWTb/KhoVdUqZwHLVHBiXP2qutTdMbpUCTMJAVjFmHKCyMwlrYMFH6xZfvYpoAVlwp67RuXut9Z4qnjHxKNEnor+9C0BpF6UpHlVQIjHa5xk/42AEXfCC3gQZWR5U6ItnU/8SGLWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743769715; c=relaxed/simple;
	bh=KZjsLs60eKQTbMKVSo/1zmWRNPndmLnFZEn4+d8V3g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCYsbONZYwilsZb43Cr+flA8nH82u4Al+lhHEJ5cibo4zSCpagByvwcsWTkeGskpUIHP7EFkQnd4KA2tWSmJMVRRQQ8Q67F+pdEI4eRlXbeYJLcNEySs8oTAgoPcAyiQFbsBqXlNie/VwbX7zZ6zFSsnkRIkB5ic4VaXuK8XU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiptpWd2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiptpWd2"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecf0e07954so25927736d6.1;
        Fri, 04 Apr 2025 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743769712; x=1744374512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+hauuYwPuT1296IGAMtUlOboJ7YBvYP4aT7j1Si95I=;
        b=AiptpWd282JPs3p9szpJBLA4v7GSy3+u1x57y7wGCQQ70sBwaXV0dP0Gyg3s90kyJ6
         XTdan3KHoKiVBN2Co42bx6b25INFx6lgZw+xq22aSLKqp7nlltel+cOMoueRKYqUd7P6
         ernG33qHYAFOdPA7dTqlCCgVe9+9kDQbxJoEzQNB0JMqjyzTO13SHZkhERzpx+LHIvCm
         Q+srOWCiEMlUmshkfRWxeKhLaJ4FEDpz2lacjICL/86Ee4+3LdoYnh4jbBRYbHxQCgwi
         i6H6/+vQX/y3J22YO91ju6l0/wNB21yQIliH90+Lo+7CfZxmwBswD1CFG9mqRH9veVec
         voUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743769712; x=1744374512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+hauuYwPuT1296IGAMtUlOboJ7YBvYP4aT7j1Si95I=;
        b=et1JxG6+h0t0RttFagcKDhLe+rnxPEC0AmWbe3kvZCmlVY0c21CL8ew0Ey0s1Yr9WT
         0RvcVjdZm6NWZoDLqVtWMZuZJ0yNkfhXJzHJ+g4/SBKAqQQuD+rCQrvbnMvhyJLqSM3Y
         pt/2Cg17sS3+9RdCEE0FOnEmIHS5rfzFdG2VR1SUSZmGAElEoB6kVItKyD481cpo8z3J
         /HCDobsPeqLcYT1xjD99g3bhH/OdE/J7EPY12Mphp2oReGxTbfvNRMW66c4M/fliV8hI
         VSNbAv0I9W6GKbTeguKo3YEm8UaakFduZIFPTL+NxsPxvMpt3N1Tdbbw2rqfrSV8cV1l
         4Kaw==
X-Forwarded-Encrypted: i=1; AJvYcCVT3vAwFIy/3VbkyH5lSM3AdvIaeLt6wDAg0QrRhthsz7QuGxwkTT1uz50zA6gFvvngFylBikwqU9KozkMZ5Sh/82Pr@vger.kernel.org, AJvYcCWPMWLNa0i2l93ERaO8O8Dn13NmSe//7yMtrn1pghT5hnOgABnKaX69lHCTKv0P8B9Q0UeymQrr2a0/ngk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrE5AlAPBF5sao2I9DjM3TdS2a/gmyVtIneOxMwqzDBsqEFYFd
	ihO5L/FTzN3LEwjqkPzW/gL41YeZdOzjE2yKAPWZV9o62Sby8MEveR3AmYdFUuuF0Gbaz0N9GHE
	sLvpCeYf/yeDOlRsHisLvwBnwRMQ=
X-Gm-Gg: ASbGnctyN2BWf7obNG+reQVpT69WuEG41W/p9mj1xUXlgILACY9ScyN0FsIHVHC4RON
	byVEVb+1chxB3lPR+m5pDSlQliiQEbEPi3dSxsYE1S/Pxs6c8qC5JD6z+23cW9mqY1VFmc73jS6
	FCd7+ixZ/bOycy5Vyz5V3wPbodlWO0gwr3Y6AkofbJCVk=
X-Google-Smtp-Source: AGHT+IFPhzwGNtl0IhDD9nLnNfC4N91dZF5GdO3ERI/7YjNI4cm1KUvZsmYpodKH8TzNAWcVFDPCaBzI1mj7/9tdI4c=
X-Received: by 2002:a05:6214:226f:b0:6e8:fb7e:d33a with SMTP id
 6a1803df08f44-6f00def1d0emr38205426d6.22.1743769712357; Fri, 04 Apr 2025
 05:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403191342.1244863-1-devaanshk840@gmail.com> <20250403153651.1188135b@gandalf.local.home>
In-Reply-To: <20250403153651.1188135b@gandalf.local.home>
From: Devaansh Kumar <devaanshk840@gmail.com>
Date: Fri, 4 Apr 2025 17:58:21 +0530
X-Gm-Features: ATxdqUFByqjByFu259uDrwKu8qipavRypzCfuFFHLm4m4OlPj-M7vk1XNsA5pfQ
Message-ID: <CA+RTe_gHo3U-tWM9MA4CMgxM13=biqkqnAbuS5Yuidrono1bvw@mail.gmail.com>
Subject: Re: [PATCH] tracing: Replace deprecated strncpy() with memcpy() for stack_trace_filter_buf
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 01:05, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri,  4 Apr 2025 00:43:40 +0530
> Devaansh Kumar <devaanshk840@gmail.com> wrote:
>
> > @@ -537,14 +538,16 @@ stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
> >       return ret;
> >  }
> >
> > -static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
> > +static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata __nonstring;
> >
> >  static __init int enable_stacktrace(char *str)
> >  {
> >       int len;
> >
> > -     if ((len = str_has_prefix(str, "_filter=")))
> > -             strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
> > +     len = str_has_prefix(str, "_filter=");
> > +
> > +     if (len)
> > +             memcpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
>
> Hmm, this location looks like it can just use strscpy().

Yes strscpy() also works. But since stack_trace_filter_buf is length
bounded, shouldn't memcpy be the right choice?

-- Devaansh Kumar
