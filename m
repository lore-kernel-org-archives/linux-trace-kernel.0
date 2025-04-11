Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AA1DD0F2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363705; cv=none; b=bw/Jl2smsyo+pXvAa1APigHqBi2LfFmUssGgD4TPxKdDUDgkk/KWt1ao4Ccy6bxj0FRDA5i89mGypQ9WfZNd2clXG2wMB2jo54Qrc0ZWq3pdk3NPHLCXh+syUA6Z9hE+BoXj4xJRhg8Hccb0uOR/3XX5G9rZ5Fk5tqxXBaTmHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363705; c=relaxed/simple;
	bh=GB3fR/d4uOOhcjjcZFYSOxX6NOupDAuzhUiUS5UjAz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QftnUXOL6+SOX/18KPHRXEa38rE83Hg9aGKFagAw3BYLtZ7eCH8HrbG8lDCw9UVRzwLbbEXyJHc9h2ZJNFW8xODX1ICx9bJYu6prfpARTnBjjJEpgXpAm6be4iduVgT5gg/gqZK/y05yycU8E/6PUmmgvTx61eOMyI1Vv6XVRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3eJ++dt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3eJ++dt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744363702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GB3fR/d4uOOhcjjcZFYSOxX6NOupDAuzhUiUS5UjAz4=;
	b=U3eJ++dtlsQHtjhJATnz/NSzWPBYmfynSojRrPJre5mmdxhv5M4Q54SmeMbXf+LtJGoMHp
	CprHVo3UCJ4/Fos1/XT4N4GB9sIC0OMBAzRG+Lr/NzYuGrtKLjIDPFIvTSf94BT1EcpcdG
	H0N3wC7ZhqtfIinJ5eFgpPIttz4NVXs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-i6PvnkWiOw2tdMqY6CPwrw-1; Fri, 11 Apr 2025 05:28:19 -0400
X-MC-Unique: i6PvnkWiOw2tdMqY6CPwrw-1
X-Mimecast-MFC-AGG-ID: i6PvnkWiOw2tdMqY6CPwrw_1744363698
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947a0919aso12243065e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744363698; x=1744968498;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GB3fR/d4uOOhcjjcZFYSOxX6NOupDAuzhUiUS5UjAz4=;
        b=npC8Vxbyg03Bq95sewILKpG02SIk2vDoY9aGzInYILOx1fduQS5/+kvUYunO4wNjkw
         453uXLtucHsGTkvlfSdgOETSjhwUhH1Ga82qpBkMVhCBwKLG4lVaQPfSlYh2gzd0qQuB
         vZP3gVa/y29vz5ypXaapm/NUesVYIoxBoquQ+exm09Pi9fFkj0xM+9X0Griy8tQnnwPt
         M2IVEcU9GNLirwn271rdvjUpMmJ0BM+M3VUgnM6U1VCyD2rDqJ506REw7HCatwOARw6W
         x8uYlk/VWGjDBqY2JOBxM/yQw+bIqKcyeARNueCauX6LkIJc82RYBJd3VM3ZOpDqyupO
         RiLA==
X-Forwarded-Encrypted: i=1; AJvYcCUEY5cG8ogXpbLcOlBjoyS5LJybbZPLQD+gbVU0V74WY/KU0brQJEQpym2bgQk50H41rFaCjeiNvc8TZ9/c4NRybWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTWlIG8hugiVbOjlPPYAHZm2Cf/ybiQVWdeUFjXUNrU/+X/Xm
	TlfC4/Fl3EoQzoNSwOanBlJOcK5Nd+5DfFx6ONh9CwRW5JyXi3Q2tqoXSRkZykJx6w/0cooFmMq
	Z1C5aptiakGKAQYhLvvEwEa+hF9HqSSjJxMWzjTnUAViEWc/rdY472qpPkOu00TIzr6eV9A==
X-Gm-Gg: ASbGnctxwnACYCv9Qjx31vqC7zO5E/2oEN1xA5iVXBMUYF3Qy6LLQ/W+2bs03JFziUr
	NbjwmEVonauKnBM3e93QmToNXSa1nxFZA4SXZckCI//fYBosz1CiXWAojepYnvCTnTunvdDjvxo
	wh1OLCb74iVtbOk5qY7n9skrnESmGZrvoa356dqWJI84lBpyr3/6SamNI7ZtcSlgIwQo5knENGs
	NTyPMsKaGH2AM2rS6MaDJhkXAgw4CYXxPQUF7BEuYp+qGToYmtItepKIAzbjXtvCXfYnLu0O9FE
	vRmU4aqhF3a3QIxEBOugJ2I7i1jvxvvZx3QBEA==
X-Received: by 2002:a05:6000:2c5:b0:39c:30f1:be8a with SMTP id ffacd0b85a97d-39ea52117d8mr1453467f8f.18.1744363697713;
        Fri, 11 Apr 2025 02:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWYQpYmbXkd0V6Txw1PpBadqqXlstQkd8R9y2WHe+r6euYoYIS+kDVUzeqDq/HI/oHPxggSQ==
X-Received: by 2002:a05:6000:2c5:b0:39c:30f1:be8a with SMTP id ffacd0b85a97d-39ea52117d8mr1453444f8f.18.1744363697371;
        Fri, 11 Apr 2025 02:28:17 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae978023sm1451830f8f.47.2025.04.11.02.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 02:28:17 -0700 (PDT)
Message-ID: <99fd51dd68f7f95fe4eb0363577876f7d6cbd737.camel@redhat.com>
Subject: Re: [PATCH v2 10/22] Documentation/rv: Prepare monitor synthesis
 document for LTL inclusion
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Fri, 11 Apr 2025 11:28:15 +0200
In-Reply-To: <e2572077addfccd2005e90c884271079d260ddca.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <e2572077addfccd2005e90c884271079d260ddca.1744355018.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kQugwwWKaEPV6vTr9OzIofuWSjUoXm2WWpT3PDqJMNk_1744363698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> Monitor synthesis from deterministic automaton and linear temporal
> logic
> have a lot in common. Therefore a single document should describe
> both.
>=20
> Change da_monitor_synthesis.rst to monitor_synthesis.rst. LTL monitor
> synthesis will be added to this file by a follow-up commit.
>=20
> This makes the diff far easier to read. If renaming and adding LTL
> info is
> done in a single commit, git wouldn't recognize it as a rename, but a
> file
> removal and a file addition.
>=20
> While at it, correct the old dot2k commands to the new rvgen
> commands.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0...or_synthesis.rst =3D> monitor_synthesis.rst} | 20 +++++++++-----=
---
> --
> =C2=A02 files changed, 11 insertions(+), 11 deletions(-)
> =C2=A0rename Documentation/trace/rv/{da_monitor_synthesis.rst =3D>
> monitor_synthesis.rst} (92%)
>=20
> diff --git a/Documentation/trace/rv/index.rst
> b/Documentation/trace/rv/index.rst
> index e80e0057feb4..8e411b76ec82 100644
> --- a/Documentation/trace/rv/index.rst
> +++ b/Documentation/trace/rv/index.rst
> @@ -8,7 +8,7 @@ Runtime Verification
> =C2=A0
> =C2=A0=C2=A0=C2=A0 runtime-verification.rst
> =C2=A0=C2=A0=C2=A0 deterministic_automata.rst
> -=C2=A0=C2=A0 da_monitor_synthesis.rst
> +=C2=A0=C2=A0 monitor_synthesis.rst
> =C2=A0=C2=A0=C2=A0 da_monitor_instrumentation.rst
> =C2=A0=C2=A0=C2=A0 monitor_wip.rst
> =C2=A0=C2=A0=C2=A0 monitor_wwnr.rst
> diff --git a/Documentation/trace/rv/da_monitor_synthesis.rst
> b/Documentation/trace/rv/monitor_synthesis.rst
> similarity index 92%
> rename from Documentation/trace/rv/da_monitor_synthesis.rst
> rename to Documentation/trace/rv/monitor_synthesis.rst
> index 0a92729c8a9b..7d848e204687 100644
> --- a/Documentation/trace/rv/da_monitor_synthesis.rst
> +++ b/Documentation/trace/rv/monitor_synthesis.rst
> @@ -1,5 +1,5 @@
> -Deterministic Automata Monitor Synthesis
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Runtime verification Monitor Synthesis
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+Runtime Verification Monitor Synthesis

The title is capitalised here.

The rest looks good, thanks.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0
> =C2=A0The starting point for the application of runtime verification (RV)
> techniques
> =C2=A0is the *specification* or *modeling* of the desired (or undesired)
> behavior
> @@ -36,24 +36,24 @@ below::
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 +----> pa=
nic ?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------> <user-s=
pecified>
> =C2=A0
> -DA monitor synthesis
> +RV monitor synthesis
> =C2=A0--------------------
> =C2=A0
> =C2=A0The synthesis of automata-based models into the Linux *RV monitor*
> abstraction
> -is automated by the dot2k tool and the rv/da_monitor.h header file
> that
> +is automated by the rvgen tool and the rv/da_monitor.h header file
> that
> =C2=A0contains a set of macros that automatically generate the monitor's
> code.
> =C2=A0
> -dot2k
> +rvgen
> =C2=A0-----
> =C2=A0
> -The dot2k utility leverages dot2c by converting an automaton model
> in
> +The rvgen utility leverages dot2c by converting an automaton model
> in
> =C2=A0the DOT format into the C representation [1] and creating the
> skeleton of
> =C2=A0a kernel monitor in C.
> =C2=A0
> =C2=A0For example, it is possible to transform the wip.dot model present
> in
> =C2=A0[1] into a per-cpu monitor with the following command::
> =C2=A0
> -=C2=A0 $ dot2k -d wip.dot -t per_cpu
> +=C2=A0 $ rvgen monitor -c da -s wip.dot -t per_cpu
> =C2=A0
> =C2=A0This will create a directory named wip/ with the following files:
> =C2=A0
> @@ -87,7 +87,7 @@ the second for monitors with per-cpu instances, and
> the third with per-task
> =C2=A0instances.
> =C2=A0
> =C2=A0In all cases, the 'name' argument is a string that identifies the
> monitor, and
> -the 'type' argument is the data type used by dot2k on the
> representation of
> +the 'type' argument is the data type used by rvgen on the
> representation of
> =C2=A0the model in C.
> =C2=A0
> =C2=A0For example, the wip model with two states and three events can be
> @@ -134,7 +134,7 @@ Final remarks
> =C2=A0-------------
> =C2=A0
> =C2=A0With the monitor synthesis in place using the rv/da_monitor.h and
> -dot2k, the developer's work should be limited to the instrumentation
> +rvgen, the developer's work should be limited to the instrumentation
> =C2=A0of the system, increasing the confidence in the overall approach.
> =C2=A0
> =C2=A0[1] For details about deterministic automata format and the
> translation
> @@ -142,6 +142,6 @@ from one representation to another, see::
> =C2=A0
> =C2=A0=C2=A0 Documentation/trace/rv/deterministic_automata.rst
> =C2=A0
> -[2] dot2k appends the monitor's name suffix to the events enums to
> +[2] rvgen appends the monitor's name suffix to the events enums to
> =C2=A0avoid conflicting variables when exporting the global vmlinux.h
> =C2=A0use by BPF programs.

