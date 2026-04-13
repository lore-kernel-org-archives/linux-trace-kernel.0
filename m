Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EA3A782A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068379; cv=none; b=BkRfi2lQ8OFCjzFqCRTlTePTC6IpXyxnkzCH4tiyssod3l94MzWGQpiF34+vHNs7ICJZwtOe6taYaEmc+cn0BZmWD+Qo4CV2F4rP+6mgS9eYcV9cfkKX251u6+DUw+1batwZbvbMFFfEYNZw+mE5nyAXUI06rTZWlP7Hg4c2zRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068379; c=relaxed/simple;
	bh=tcvjKHPqcWoPsOONsm5GCPjUJnTSvseVaCQMx4noQpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Is8QoQhwSZWs8SZC4csLxzDjdUJw9upMwLYxP370RCgDlry3GDylbCcdGpmwJT1NkLR1m78Y74vLguYspzvSJbkHRRtOR0jxcy5VTShB2QdGhiK1lHrEHmLWVsNT08n6YwLAvvqBikmD5ZZ5rvf2h4JCWVAcL29eL0pfjEb4MqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrBc7y+z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrBc7y+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776068376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tcvjKHPqcWoPsOONsm5GCPjUJnTSvseVaCQMx4noQpA=;
	b=TrBc7y+zACDeXJXVPZakzRnxUAOLVGvC15Fj1D3VvnWqsK6Vc1ONBkd1o+PjXgLw/lbZR+
	f7H11SveE2Rk5IGFIK1MWejyGChhE5ph0bse6U7u2p3VGVVbYE0edIGj3KTlhL2NB8BK9f
	up7zIVyhT6DnTdSUmVNvsO3pgH5mR4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-tM2H7aWKOzy_aq3rwHsdwQ-1; Mon, 13 Apr 2026 04:19:33 -0400
X-MC-Unique: tM2H7aWKOzy_aq3rwHsdwQ-1
X-Mimecast-MFC-AGG-ID: tM2H7aWKOzy_aq3rwHsdwQ_1776068372
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488ba2919b9so27365405e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 01:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068372; x=1776673172;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmMy5pwfWIKm0sICiknZ66RitSHNtSjbkUjOxwmD6Zg=;
        b=phDK7V6zRhN4VP7xrKvY/05apr1vOe4qZIbQVZHxhJuIST3BRzcrujJ/SjdOdmvcF5
         qeoVlEGOXX2KxYV6BesZRNsh+51KEJCQaI3Wn70bcgrgbqLcHG6HjMY5BA6YDSGLHeXu
         J52Isco/1hoG/rShAirIBAmWHbcp1WFWd/l+dVUGNmJYQmwf5yUBoNKMs3GnjktpOu/y
         hHa8f4gFVog92vPMOqEtx3qvYLj+nHL8xag4Yd0Lu/zU5FLGmhsYf7B6e5YOeGV7tItZ
         hQiTvroX+vGlJmPZYBe32NnMNkoQklQ6FRirdQT5DNZsYNHIitOcmr55BTLGAirPWhOu
         QIyw==
X-Gm-Message-State: AOJu0YzoA7hyMSDIxfnj2C1I8JkYDg3/Cq8mIds6MWpfK56SJu7yvAjC
	EZ985t+eAzITsQbNrQ60m0Lr83bNe0/yqxFanzAcJdxhbFHQBAJq1zK9B4s9i3YXLWYiFunAhBT
	C+Nj4y7wg3Exme90N6LcJnTZ18/icyfEfYUKkMWN6HyzipbRnKadWJem02eMLmQlPNI0mDYBuYg
	==
X-Gm-Gg: AeBDietBerrxkzyEdJmg0QbqbJ/qELy3cO0LOTWLTzVg49LCmycnDuI22GO0ym4fHqm
	ZvoDFR7sHpBxlE+rxRJUWdoG63YpeeLlJck9cYqmj2/NQ+f9mwyFy9vIpH0aJvs78eUmcspmKom
	OaqMkvv/4I0I1g21DLWjVrFe2zcvBIvoURXzAvOLK8wfs6p3PqjNuXnAq9TLuHJvq9/Ttbwo9Xe
	Uut2JUu0RF0eYCYnOGerf+HvKZ2GYqLBAkK4YEfvhAMZgs7oFaqQIoKigvILlwp+Pa8fWLQTD0T
	j9obGxmJgP4Abr5kYnsIYMpood/oPX0650sGue9aCB92w55niq8/68riAPPkJpl9Vs0Hpec22vw
	McCofug2ZWIwkSdct5WW1lRQoTt4/4FQT151rzSEYQDpyauwOSAM8Rx0/bckR+l/qFnTunnWzad
	mkicpWCYgd2lSLTzY=
X-Received: by 2002:a05:600c:c0c9:b0:487:1826:d89b with SMTP id 5b1f17b1804b1-488d67e262cmr110720545e9.9.1776068371769;
        Mon, 13 Apr 2026 01:19:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c9:b0:487:1826:d89b with SMTP id 5b1f17b1804b1-488d67e262cmr110720215e9.9.1776068371293;
        Mon, 13 Apr 2026 01:19:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4a46sm195475725e9.4.2026.04.13.01.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:19:30 -0700 (PDT)
Message-ID: <6f183cc9d2befcdaec3901be31f7af6c6bbb5022.camel@redhat.com>
Subject: Re: [RFC PATCH 1/4] rv/tlob: Add tlob model DOT file
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Apr 2026 10:19:29 +0200
In-Reply-To: <64122474633aa17d872a7dc6233d7794e80f2784.1776020428.git.wen.yang@linux.dev>
References: <cover.1776020428.git.wen.yang@linux.dev>
	 <64122474633aa17d872a7dc6233d7794e80f2784.1776020428.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0zpwPiq2roZKnGgeaWWkHsWWjn4T-d8PcGtZA9T0tqY_1776068372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 03:27 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add the Graphviz DOT specification for the tlob (task latency over
> budget) deterministic automaton.
>=20
> The model has three states: unmonitored, on_cpu, and off_cpu.
> trace_start transitions from unmonitored to on_cpu; switch_out and
> switch_in cycle between on_cpu and off_cpu; trace_stop and
> budget_expired return to unmonitored from either active state.
> unmonitored is the sole accepting state.
>=20
> switch_in, switch_out, and sched_wakeup self-loop in unmonitored;
> sched_wakeup self-loops in on_cpu; switch_out and sched_wakeup
> self-loop in off_cpu.
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

Interesting monitor! Thanks.
I'm going to go through it more in details later, but let me share some ini=
tial
comments.

> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0tools/verification/models/tlob.dot | 25 +++++++++++++++++++++++++
> =C2=A02 files changed, 28 insertions(+)
> =C2=A0create mode 100644 tools/verification/models/tlob.dot
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9fbb619c6..c2c56236c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23242,7 +23242,10 @@ S:=09Maintained
> =C2=A0F:=09Documentation/trace/rv/
> =C2=A0F:=09include/linux/rv.h
> =C2=A0F:=09include/rv/
> +F:=09include/uapi/linux/rv.h
> =C2=A0F:=09kernel/trace/rv/
> +F:=09samples/rv/
> +F:=09tools/testing/selftests/rv/
> =C2=A0F:=09tools/testing/selftests/verification/
> =C2=A0F:=09tools/verification/

This change doesn't belong here, the patch itself is not adding those file,=
 you
should probably move it later.

> =C2=A0
> diff --git a/tools/verification/models/tlob.dot
> b/tools/verification/models/tlob.dot
> new file mode 100644
> index 000000000..df34a14b8
> --- /dev/null
> +++ b/tools/verification/models/tlob.dot
> @@ -0,0 +1,25 @@
> +digraph state_automaton {
> +=09center =3D true;
> +=09size =3D "7,11";
> +=09{node [shape =3D plaintext, style=3Dinvis, label=3D""]
> "__init_unmonitored"};
> +=09{node [shape =3D ellipse] "unmonitored"};
> +=09{node [shape =3D plaintext] "unmonitored"};
> +=09{node [shape =3D plaintext] "on_cpu"};
> +=09{node [shape =3D plaintext] "off_cpu"};
> +=09"__init_unmonitored" -> "unmonitored";
> +=09"unmonitored" [label =3D "unmonitored", color =3D green3];
> +=09"unmonitored" -> "on_cpu" [ label =3D "trace_start" ];
> +=09"unmonitored" -> "unmonitored" [ label =3D
> "switch_in\nswitch_out\nsched_wakeup" ];
> +=09"on_cpu" [label =3D "on_cpu"];
> +=09"on_cpu" -> "off_cpu" [ label =3D "switch_out" ];
> +=09"on_cpu" -> "unmonitored" [ label =3D "trace_stop\nbudget_expired" ];
> +=09"on_cpu" -> "on_cpu" [ label =3D "sched_wakeup" ];
> +=09"off_cpu" [label =3D "off_cpu"];
> +=09"off_cpu" -> "on_cpu" [ label =3D "switch_in" ];
> +=09"off_cpu" -> "unmonitored" [ label =3D "trace_stop\nbudget_expired" ]=
;
> +=09"off_cpu" -> "off_cpu" [ label =3D "switch_out\nsched_wakeup" ];
> +=09{ rank =3D min ;
> +=09=09"__init_unmonitored";
> +=09=09"unmonitored";
> +=09}
> +}

