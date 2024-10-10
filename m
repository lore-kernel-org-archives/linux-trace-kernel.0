Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A81BDAA0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563129; cv=none; b=BD8wcIXmbfZZy9jLGFK3rmjqM8CF/C+XzJu8y8eVequOJc/uITcTbFpqeBtrptPeNQHF6NExOZyMmy4jh5xn5qXQAtvB1QmkYvpCa2T2YCL3KoC0QuouUClJ5emuuUF71zTPufl+JbjmrZFzSfsF2YTtswcLRwaBahUipkqbwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563129; c=relaxed/simple;
	bh=j53k+iqtLH5iTvwrYa1x5su0Idfk7cTjXBsHR1bRjX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fllYh2bX4Gluyc3yNc9YvwwnMWCHDCa4OKVSbVpo7qupsAif+VXk0VsVhybtZ4YlnFUPl5/JkLUjZU5YGew4NMq4HDZ/KXVCqhT30zSGfd1KYkgkajtvlp4SeFluL9d6bc1G7MHnQH5N1h3MtNA1SitqyKG6ANEZsahcojTmGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO6nKgOt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO6nKgOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728563124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lv+b1p0pbHiqbpqU/YpAaDSNyCTb881lQaMqdfivw10=;
	b=YO6nKgOt0HC5YX6KAb/cmU+AbVN8XOqCWDoRQdn3CKip8nTgLQejyhsJqOicQBwpMoq4qC
	V6VqGRQlx2D3IwMXUyTgmyI1i0aPb9O6zFSPittVXVIF35PfPsoIwGgF+jwnb8ag4My9r+
	4Gt16DZsiWwkix2t6ctyeP9adGhwxUM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-GCi4zs2YMvGGI2ZOB4-djA-1; Thu, 10 Oct 2024 08:25:23 -0400
X-MC-Unique: GCi4zs2YMvGGI2ZOB4-djA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c91c5ccdf0so593866a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563122; x=1729167922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lv+b1p0pbHiqbpqU/YpAaDSNyCTb881lQaMqdfivw10=;
        b=rnvAoGTRdVUhkYmJrzGnkzDHZLv2VH5HxrwWzyzhxEsTSqdSUCDPSiIKg2VkOgUgvA
         oozpTBxE59AcqqcFncGZ+pYvBBeICq1YyD2Di0AbP2j31N5UTHc5YWggFh+CgYHTTz71
         7u8JjIu6WQoAh6xhLMEEe1Bm9RdlmOL4YbUUac5jSOEX5e2yj0XX2uJE1J7TpRwkJe1/
         s5jqO5p7mV0+UuTleAD+fin5cqLZPmxQ4S87MB2c6bt/kREswVv/MbSsYaE5SxBeLrwy
         0kthaJ/buf0zc6aQc3owrWAH+AaPXbvEAsPc6h0I2b/3+NWvZ/ss4fhQoyEPks3CBWpg
         RlpA==
X-Forwarded-Encrypted: i=1; AJvYcCUegCGrKTg3YaGTkUob4fJ8j2UpzRaVy+5NiNxoaqLX8k+MtPUdd9CS69dC6oMdCgub18kXdLRg3XEo6xk3bs04f8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADc2JStRshFINRNllbsdHMzApZK2ltHlzF0RSjRsoDDqEMubX
	npLNO1a1+A0j7S3IE+PsePXb6xRD2/X+kFt2rieRT9mykjxL/0XaonDxJhVWPSbpfDtc3bPFoP1
	a8CxIcPReQEbwek+R6BXYZHpWwNEszmQMwM+pvkeB6u0uji0WO7+yejyHTrDR5iblOuDWt/0WhU
	96eSWCw9zXRmAHKyGvJ4y0gnHmWO9HT6JxGWecTrjEFCbo
X-Received: by 2002:a17:907:9717:b0:a99:425c:c653 with SMTP id a640c23a62f3a-a998d19f934mr532029866b.22.1728563122322;
        Thu, 10 Oct 2024 05:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC/zqiAiWtVMyc2j6Bf9V084EuqKrSc/W1LqvygQRRYH6OYSOoYWk0/MNkbRzT++Y593ecCVmCl1u2bbrtMzs=
X-Received: by 2002:a17:907:9717:b0:a99:425c:c653 with SMTP id
 a640c23a62f3a-a998d19f934mr532027666b.22.1728563121870; Thu, 10 Oct 2024
 05:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
 <45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
In-Reply-To: <45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 10 Oct 2024 14:25:11 +0200
Message-ID: <CAP4=nvRLgwu3y_c_m-SdPxaWm6rO_LVFKK98pkjFiLJ42LqhpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/rtla: fix collision with glibc sched_attr/sched_set_attr
To: Jan Stancek <jstancek@redhat.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jforbes@redhat.com, ezulian@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 10. 10. 2024 v 11:33 odes=C3=ADlatel Jan Stancek <jstancek@redhat.c=
om> napsal:
>
> glibc commit 21571ca0d703 ("Linux: Add the sched_setattr
> and sched_getattr functions") now also provides 'struct sched_attr'
> and sched_setattr() which collide with the ones from rtla.
>
>   In file included from src/trace.c:11:
>   src/utils.h:49:8: error: redefinition of =E2=80=98struct sched_attr=E2=
=80=99
>      49 | struct sched_attr {
>         |        ^~~~~~~~~~
>   In file included from /usr/include/bits/sched.h:60,
>                    from /usr/include/sched.h:43,
>                    from /usr/include/tracefs/tracefs.h:10,
>                    from src/trace.c:4:
>   /usr/include/linux/sched/types.h:98:8: note: originally defined here
>      98 | struct sched_attr {
>         |        ^~~~~~~~~~
>
> Define 'struct sched_attr' conditionally, similar to what strace did:
>   https://lore.kernel.org/all/20240930222913.3981407-1-raj.khem@gmail.com=
/
> and rename rtla's version of sched_setattr() to avoid collision.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 4 ++--
>  tools/tracing/rtla/src/utils.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/util=
s.c
> index 05b2b3fc005e..c62044215a48 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -229,7 +229,7 @@ long parse_ns_duration(char *val)
>
>  #define SCHED_DEADLINE         6
>
> -static inline int sched_setattr(pid_t pid, const struct sched_attr *attr=
,
> +static inline int rtla_sched_setattr(pid_t pid, const struct sched_attr =
*attr,

Hmm, rtla_sched_attr sounds to me like the function does something
specific to rtla. Maybe syscall_sched_attr would be a better name?

>                                 unsigned int flags) {
>         return syscall(__NR_sched_setattr, pid, attr, flags);
>  }
> @@ -239,7 +239,7 @@ int __set_sched_attr(int pid, struct sched_attr *attr=
)
>         int flags =3D 0;
>         int retval;
>
> -       retval =3D sched_setattr(pid, attr, flags);
> +       retval =3D rtla_sched_setattr(pid, attr, flags);
>         if (retval < 0) {
>                 err_msg("Failed to set sched attributes to the pid %d: %s=
\n",
>                         pid, strerror(errno));
> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index d44513e6c66a..99c9cf81bcd0 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -46,6 +46,7 @@ update_sum(unsigned long long *a, unsigned long long *b=
)
>         *a +=3D *b;
>  }
>
> +#ifndef SCHED_ATTR_SIZE_VER0
>  struct sched_attr {
>         uint32_t size;
>         uint32_t sched_policy;
> @@ -56,6 +57,7 @@ struct sched_attr {
>         uint64_t sched_deadline;
>         uint64_t sched_period;
>  };
> +#endif /* SCHED_ATTR_SIZE_VER0 */
>
>  int parse_prio(char *arg, struct sched_attr *sched_param);
>  int parse_cpu_set(char *cpu_list, cpu_set_t *set);
> --
> 2.43.0
>

Apart from that, LGTM.


Tomas

