Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402E1E51EA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472981; cv=none; b=XXsWjJhbMbMnJO/rPFefwmeeWcP38ZNW3faXua+w7kxtO7D7SMkx2PDEWTvLU6GeY1O7rlPWA2IFtxyKXip3p+0huUfgVcOKmwYiOJYtW27m1LmD0rHFfvDTcM66SU91A5+5CGTfBf+txC39V14C1cox/QrgMuHZGp1aC95E5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472981; c=relaxed/simple;
	bh=taTmYLMYRDfFm4NBKQbuKwOttb328flU4PmRzffMVAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QqElmAtBieh0FHlWtEenw9vRFrIPPEbhShuJ2ZXaRnLT2uNLCbNobmA+04aJBKFC028Y33hi180667Jh++vxxEhx573/7jbADOJ7/HmQK9Yiyj2v28zMoUv5QOmE9EB72LL0sVGvbmxiNXSP8ey/E2WCC48+MpQnKwRJYaWiWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lb0rfTtx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb0rfTtx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751472978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUninp5wGMjquocMkAIa/PTc0iwtvwY50xvcvANHDtg=;
	b=Lb0rfTtxGvSYp4usZMXj/1QPZ7KI3aWCgWMT7MZLDyKsUaivVis7ZcidUBFoBc4INUZZSo
	UzB8KDNS5VZLo/BRQtI5dFxUqxQrCGyc2g2T3goAfgfveFmGVM6z8GAdKAgt8t7SZpbp6i
	d9c1M3ZLyja1b1hvdjfMqcHTQzP5iUQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-PLEiV_DoPyuy7CeyJWIF6A-1; Wed, 02 Jul 2025 12:16:17 -0400
X-MC-Unique: PLEiV_DoPyuy7CeyJWIF6A-1
X-Mimecast-MFC-AGG-ID: PLEiV_DoPyuy7CeyJWIF6A_1751472977
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a587a96f0aso134712061cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 09:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472977; x=1752077777;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUninp5wGMjquocMkAIa/PTc0iwtvwY50xvcvANHDtg=;
        b=ICtQvpy3ujLglsvS9cEKo20s3ocuf+T/9trcJNy4+KaeX7CCPpX5MvmhVkd5UG0y9W
         XXYYVf85wL2efTjtYOllfEh8FnQMIS3LXPILtlQKG6/L3t37RTWkWvffzSuCesnM+x9C
         2Wwn1dESXBue7dJHw/ZRsZb7mR8Ep/LBTUhe9E9X2LIhEFecZr/Af0KwLAf9G331ekFZ
         shlFAwW8PP9Fxdcg9z6fXpruQqb0L3Va2LCCSWtYGfb8ZC4Rfk3z12MyKA5Iwv8/8ewq
         YYCaJPcYl29guDKIgKxJebKbCQwJVUh4yN7qpvqhY9iq4qFH1VucLiLWTlV6ln87X2n9
         dJMw==
X-Forwarded-Encrypted: i=1; AJvYcCVS6nli8hgbpnG3xrewZAwFQvDlGUjRITalSbh+U4Oozf5VWFzHownYCJkxaK9NZNpkk/p0UGeYEpZMBpV9oeS8Xmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XJbGb+BR+EHpr6FOhCT0O5SbzA/2n3eXF2SyG/QqCgfa+DdO
	3lNb51g3gSqwRO9RLmT6MR5ymzEhGCb9Q9V1xDoWVlO1wK8dVBUGQV8uDFI4HRLmpt1Z3g7gYkH
	YL11SGkT7DLeJKYJcurmhcB0Ku7N96c8GNNucji6H01akbmIfmTlpKBA60T/PKyPe189Z6GoaaZ
	Jx3TY6IsmTUmFl91a5YE2xQLqH1N35m+DyDxzahR7euF0maVt1
X-Gm-Gg: ASbGncszdKLykXbiysmPuAue2kQYZeK+bTrnZ2L4z4B0KhwdHD0q45b91UmGs5/tWgj
	Id3mjKF2Tmn/44451juwxQTuQAJ3MYrGiGcGUzFNQ904ecQgJL87FwEMS8uVGZA/+EZrV+AQ04t
	lVDRjVJwErzrGKeueDmutSMUB5OUTfx97oQusy
X-Received: by 2002:ac8:5794:0:b0:4a7:f9ab:7895 with SMTP id d75a77b69052e-4a9768f3b25mr50452191cf.4.1751472975952;
        Wed, 02 Jul 2025 09:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvKyRKCLRLm2WbzwC/qF+d+i4Jbpo0K5fF7x90LiP9fg5t8kISSbYTeD7jnOqtqQBqbELpy03URhK9mvcAeh4=
X-Received: by 2002:ac8:5794:0:b0:4a7:f9ab:7895 with SMTP id
 d75a77b69052e-4a9768f3b25mr50451831cf.4.1751472975498; Wed, 02 Jul 2025
 09:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630142032.3322-1-gpaoloni@redhat.com>
In-Reply-To: <20250630142032.3322-1-gpaoloni@redhat.com>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 2 Jul 2025 18:16:04 +0200
X-Gm-Features: Ac12FXz6osJN9CD-Rxb-aaU5vWZ5zeiiA0fABrg3h6zv6IoLgNn86rYdrSaO3Og
Message-ID: <CA+wEVJZ-z7LY-pKqDXDQu19V8hc9nhWhbXY9mJ5dB5LuRfF-UQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] tracing: add testable specifications for event_enable_write/read
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v7L84KRO8vMWSBoh5EcUyUhEmsN08OU50CwnKj8Tj7U_1751472977
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 4:20=E2=80=AFPM Gabriele Paoloni <gpaoloni@redhat.c=
om> wrote:
>
> This patch implements the documentation of event_enable_write and
> event_enable_read in the form of testable function's expectations.
>
> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
> Following the discussion in v1 (see [1]), v3 adds improvements with
> the "Context" specifications and the definition of the assumptions
> of use for the correct invocation of the documented functions.
>
> [1] https://lore.kernel.org/linux-trace-kernel/20250612104349.5047-1-gpao=
loni@redhat.com/
>
> v3 has been sent as in v2 there is a mistake in the return value
> specifications of event_enable_read

Following the detailed review and suggestions from Steven here [ref]
the review of this patch can probably be skipped and I'll work directly
on v4

[ref]: https://lore.kernel.org/linux-trace-kernel/CA+wEVJbjhLmA4ZR5w7s6QDCf=
jET=3DPf2J9PsFhC2wdO1nQ5YY+A@mail.gmail.com/T/#ma46663274411b08c14f380a6936=
3dc6225b09a45

Thanks
Gab



> ---
>  kernel/trace/trace_events.c | 80 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..aa9992b0f43c 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1771,6 +1771,51 @@ static void p_stop(struct seq_file *m, void *p)
>         mutex_unlock(&event_mutex);
>  }
>
> +/**
> + * event_enable_read - read from a trace event file to retrieve its stat=
us.
> + * @filp: file pointer associated with the target trace event;
> + * @ubuf: user space buffer where the event status is copied to;
> + * @cnt: number of bytes to be copied to the user space buffer;
> + * @ppos: the current position in the buffer.
> + *
> + * This is a way for user space executables to retrieve the status of a
> + * specific event
> + *
> + * Function's expectations:
> + * - This function shall lock the global event_mutex before performing a=
ny
> + *   operation on the target event file and unlock it after all operatio=
ns on
> + *   the target event file have completed;
> + * - This function shall retrieve the status flags from the file associa=
ted
> + *   with the target event;
> + * - This function shall format the string to report the event status to=
 user
> + *   space:
> + *   - The first character of the string to be copied to user space shal=
l be
> + *     set to "1" if the enabled flag is set AND the soft_disabled flag =
is not
> + *     set, else it shall be set to "0";
> + *   - The second character of the string to be copied to user space sha=
ll be
> + *     set to "*" if either the soft_disabled flag or the soft_mode flag=
 is
> + *     set, else it shall be set to "\n";
> + *   - The third character of the string to be copied to user space shal=
l b
> + *     set to "\n" if either the soft_disabled flag or the soft_mode fla=
g is
> + *     set, else it shall be set to "0";
> + *   - Any other character in the string to be copied to user space shal=
l be
> + *     set to "0";
> + * - This function shall invoke simple_read_from_buffer() to perform the=
 copy
> + *   of the kernel space string to ubuf.
> + *
> + * Assumptions of Use:
> + * - The caller shall  pass cnt equal or greater than the length of the =
string
> + *   to be copied to user space;
> + * - Any read operation on a file descriptor, unless it is the first ope=
ration
> + *   following a trace event file open, shall be preceded by an lseek
> + *   invocation to reposition the file offset to zero.
> + *
> + * Context: process context, locks and unlocks event_mutex.
> + *
> + * Return: the number of copied bytes on success, -ENODEV if the event f=
ile
> + * cannot be retrieved from the input filp, any error returned by
> + * simple_read_from_buffer.
> + */
>  static ssize_t
>  event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
>                   loff_t *ppos)
> @@ -1801,6 +1846,41 @@ event_enable_read(struct file *filp, char __user *=
ubuf, size_t cnt,
>         return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf))=
;
>  }
>
> +/**
> + * event_enable_write - write to a trace event file to enable/disable it=
.
> + * @filp: file pointer associated with the target trace event;
> + * @ubuf: user space buffer where the enable/disable value is copied fro=
m;
> + * @cnt: number of bytes to be copied from the user space buffer;
> + * @ppos: the current position in the buffer.
> + *
> + * This is a way for user space executables to enable or disable event
> + * recording.
> + *
> + * Function's expectations:
> + * - This function shall copy cnt bytes from the input ubuf buffer to a =
kernel
> + *   space buffer and shall convert the string within the kernel space b=
uffer
> + *   into a decimal base format number;
> + * - This function shall lock the global event_mutex before performing a=
ny
> + *   operation on the target event file and unlock it after all operatio=
ns on
> + *   the target event file have completed;
> + * - This function shall check the size of the per-cpu ring-buffers used=
 for
> + *   the event trace data and, if smaller than TRACE_BUF_SIZE_DEFAULT, e=
xpand
> + *   them to TRACE_BUF_SIZE_DEFAULT bytes (sizes larger than
> + *   TRACE_BUF_SIZE_DEFAULT are not allowed);
> + * - This function shall invoke ftrace_event_enable_disable to enable or
> + *   disable the target trace event according to the value read from use=
r space
> + *   (0 - disable, 1 - enable);
> + * - This function shall increase the file position pointed by ppos by t=
he
> + *   number of bytes specified by cnt;
> + *
> + * Context: process context, locks and unlocks event_mutex.
> + *
> + * Return: the number of written bytes on success, any error returned by
> + * kstrtoul_from_user, -ENODEV if the event file cannot be retrieved fro=
m the
> + * input filp, any error returned by tracing_update_buffers, any error r=
eturned
> + * by ftrace_event_enable_disable, -EINVAL if the value copied from the =
user
> + * space ubuf is different from 0 or 1.
> + */
>  static ssize_t
>  event_enable_write(struct file *filp, const char __user *ubuf, size_t cn=
t,
>                    loff_t *ppos)
> --
> 2.48.1
>

