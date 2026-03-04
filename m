Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B133A256C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620229; cv=none; b=JxMHGR8l2oMI3daNHDwqq7g52mgYhuECckaBKe8yHRfBXoOiW3b31s/wsQ30dyDVFLWEygdfTvnPIwHHRCLEkYN5Y1U+UmC01yR3K9JE9dK22wGdo/QAe5L6Z9zhmNCX/mrhXpr3Uw8F6NnKsix3zZHp07bfl42hbPdgEEDSAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620229; c=relaxed/simple;
	bh=uLpdqpGN99/E//Avoz4o9MseQ49WViflUkqW9bUCsnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWh8ctG3lGUe4VAaAGAWDDkPmI/z9scnDXoRpqKvCh415YroZbeD5aAJahXoozpL1dl41hbeFmdWmEVh7aa37rL4b4e2cY9leUJwfdLx5+37MeqsHIASL/3ZNV9i94N3LxqKEX2LICgJoSDl+bxPgyaR1XB+NQcn4YHHEAHahew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fH50IW89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH50IW89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772620227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StCiTICbmC1xh/aY+h5apEqtcUPRVdpBQ7SveVbW1g4=;
	b=fH50IW89MTmXW8rUusZWBQV8nL+Q6VWmwK0r/Mv2bPn6AKiWnERJdtKg+k6slcT1sQmN11
	Eg04G6FlI3nJauFkItQInOVuOvilaBhte4PZlc4H4K1sbOwmUZRcKvC87TCi5+0ABlSkPj
	tZwDznbIdkQpDEaQZt0O1HA98Q1qNsQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-Ax_ZtlfMPwaRkPQxwkuuEw-1; Wed, 04 Mar 2026 05:30:26 -0500
X-MC-Unique: Ax_ZtlfMPwaRkPQxwkuuEw-1
X-Mimecast-MFC-AGG-ID: Ax_ZtlfMPwaRkPQxwkuuEw_1772620225
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b933c3a6c64so621335666b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 02:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772620225; x=1773225025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StCiTICbmC1xh/aY+h5apEqtcUPRVdpBQ7SveVbW1g4=;
        b=aLavKmYSZ+mQL5PtuLI7deOcTKlyDgy8S5yyt7VhCsEJ/f2GNpyaNeNQS0AXFkrNZI
         kh8H8XDT+2m+Levwa013Vm/KGH0bLRTvhSsefsidruvRY2nk4Jvf4I1VAg1QiZNU8edi
         wn0Dbe2Em3svRuGYCW5hX0nRcqQ3NmPg9HfPSu2kDZ1Y65JjfvvkPrYbvxPpIAuFuT+Z
         YKdVJCR1UkGnwcEfHYSIX7ColhhIvXhgwYcSMnplDqaMIiAxC5yngtj3CBDpCXNeePtG
         rHGTeMdskab2Qa8Zc5E4tNVTcK8bhdzWEhbKyxFPuT+3u+i/Ikh67SZUT++v96/qlRqs
         TDXA==
X-Forwarded-Encrypted: i=1; AJvYcCVE62azOHFwgNziPfJfVSYkU386jhVt7Z/RNv6gp051HM9DNahFhD3f0ZGgu9Sjks4jqcE8ohneQRlxqOsRbh+9qy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Sypt4zqGbuinFRxi0xoRRfHFrEXVPID0OyUh3j38o72tXNaS
	QKoLsLwkWqdye7HQdw0kqSHVjPDbkHAw7OJ7zoytfwDrbE4iZGnhsFbGiu5fA2kWuCtIfA0NHHt
	Dytlz8evA0XD/B0wVin142L0uPCZIQXUwEkjtox+sx183acnaTidNSJJi9s/WepwfmDaROyM3bv
	r12uAAULQgXJhA9Jk2xDgC2rKbNHnrJLIrR3t3a3pyB8IFGL77
X-Gm-Gg: ATEYQzxbelug0camqEyHIMGTqyjciLyEAWUUr5fUwYjy5TqimdMj82OZf0Pn3dwpgGP
	Wm+wg8GT3/Ej421F1ADEYYXgfiL4dYDs0uCXgdK7IoyUjKcfWjcu/w56+t/7eg2CVWRstUlR82j
	IRQ289jJF0cmhxwzxZJZ3fP1FpgyRqMHVi9n0mLIIYW1ymL3SerklsASP4cVWelI8kNyLEEoXqB
	cGSvQ==
X-Received: by 2002:a17:907:6d15:b0:b8e:d1f3:4744 with SMTP id a640c23a62f3a-b93f1594108mr84213666b.55.1772620224915;
        Wed, 04 Mar 2026 02:30:24 -0800 (PST)
X-Received: by 2002:a17:907:6d15:b0:b8e:d1f3:4744 with SMTP id
 a640c23a62f3a-b93f1594108mr84210866b.55.1772620224457; Wed, 04 Mar 2026
 02:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-17-wander@redhat.com>
In-Reply-To: <20260115163650.118910-17-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 11:30:13 +0100
X-Gm-Features: AaiRm52jWeoiqQEahwH6YFi5tyb0O1VzmWB8Yo5YKKa3V6s8QIEV42RNHDw4RzU
Message-ID: <CAP4=nvSBEgfJg8qFYakiSfhE-Cp3RF9OoT2NR2qO+oRk+1BGEg@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] rtla/trace: Fix I/O handling in save_trace_to_file()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G5X8P2EAyi8jrhvVZ4imqPidaYAqLJYO-XoLzoPw2-U_1772620225
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:29 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trac=
e.c
> index fed3362527b08..8e93b48d33ef8 100644
> --- a/tools/tracing/rtla/src/trace.c
> +++ b/tools/tracing/rtla/src/trace.c
> @@ -73,6 +73,7 @@ int save_trace_to_file(struct tracefs_instance *inst, c=
onst char *filename)
>         char buffer[4096];
>         int out_fd, in_fd;
>         int retval =3D -1;
> +       ssize_t n_read;
>
>         if (!inst || !filename)
>                 return 0;
> @@ -90,15 +91,30 @@ int save_trace_to_file(struct tracefs_instance *inst,=
 const char *filename)
>                 goto out_close_in;
>         }
>
> -       do {
> -               retval =3D read(in_fd, buffer, sizeof(buffer));
> -               if (retval <=3D 0)
> +       for (;;) {
> +               n_read =3D read(in_fd, buffer, sizeof(buffer));
> +               if (n_read < 0) {
> +                       if (errno =3D=3D EINTR)
> +                               continue;
> +                       err_msg("Error reading trace file: %s\n", strerro=
r(errno));
>                         goto out_close;
> +               }
> +               if (n_read =3D=3D 0)
> +                       break;
>
> -               retval =3D write(out_fd, buffer, retval);
> -               if (retval < 0)
> -                       goto out_close;
> -       } while (retval > 0);
> +               ssize_t n_written =3D 0;

Why break the style of declaring all variables at the beginning of the
function? n_read, added in the same commit, keeps the style.

This also applies to the previous patch.

Tomas

