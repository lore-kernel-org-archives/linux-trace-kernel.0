Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B82D9481
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282729; cv=none; b=W6DqjLlAlKc/kZtgNi1cz+2gf1sG9QLX2JOaXEsFRiN1fxXAiaIxwwkMvbhRrfjFnU1s/CbHls5irl0nI43cEO3hPk0DSJT4wyKMfVPXTqjor8M6AU/EQinwrSjt3tm7A62eGVEIWt2vqEw7W4QAcaz7E1VgcLSz02p/CXSGsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282729; c=relaxed/simple;
	bh=jA9yJBSY0yhA3S7ojMChktmJ2Oj4GkzERv22rNH0FDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/B7aytjghveHbuXryf8/7TyWspjRk0aoytSJ1FGKqyjCNo7BJGZ6TklLaTQ/2TyUGFvIN67t37e1hf9kgK0t2p5vBZG4l/Zu0WP+QBFQ9i1cRVcRvw6GkGTh/pAbKJLBbOpSyad6bonKS91jiZmXcYshWmQEqMgvHPTGD6SL1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpQD+2iE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpQD+2iE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777282727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jA9yJBSY0yhA3S7ojMChktmJ2Oj4GkzERv22rNH0FDI=;
	b=OpQD+2iEKA1Pahp0wTFiB6K/eBtOKs7Jp911N6pxxkgrm21Z9CYgieehbBR9BL/IQL9I0B
	EXAUDoq/0B0FOKHrMrr3kOhZDQFZFjHLV28wCIozXlyLag1v/49oBzyLflECet773sXRrX
	IqHZ6qO/ECmMWEKsVT9Y8Y9LkCFSb+A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-SlvdlXwaPy6Xf8naFpGBtg-1; Mon, 27 Apr 2026 05:38:46 -0400
X-MC-Unique: SlvdlXwaPy6Xf8naFpGBtg-1
X-Mimecast-MFC-AGG-ID: SlvdlXwaPy6Xf8naFpGBtg_1777282725
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50edf01172bso193245001cf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 02:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282725; x=1777887525;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rbb6dZ+OQZmYPJpAzgaZi1oQBe8+pr+bTgI/6IMw+Q=;
        b=tGam5MCYabriAA+fpoiO1yWx/Eu80YbbQ7S/+mQZS8Df1aMM2LnIMLBw0X6mxe17iD
         iRJv0Q70jgHxOt0Hw2cEX1kLrTRkgQEsIE7k3xDf2nU14iRzmgYnr/iC/PLpNQm16fNz
         Ov5pgJJjJUAVk0FVtmwo2NvgihsuGQMDryGogzqTMqRIruDN1LpONvWJNADoY+/6QUX3
         mAY3PrITYEnIlDJFKg5FGqvi4o0X9tLYAl1JwZrgKEZzuM/iA5Bjg2+TRDC468yMkkL+
         PP+keldaO0WZZeMg8zSznOhttvflI52I5gvROQAy9BRDw3AodnOC9620vU/1dd6xSNpi
         o19g==
X-Forwarded-Encrypted: i=1; AFNElJ8/QPVZalhNtjcsK4rCRD2mZaHci3+AQYBLWIgcciV9bZ+EgeMRtINfSd86/yFro6QBFC47+S/MhuqJJqAB4c50Y5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXl3aNkvqiR2Nk/pIpoSL1vSdJebqEQ05Nb61FlUUSqLmqqqM
	v7etX5gcYs+iRewSrG3XaY3DamsDnTI4KMQM2XqqMdu4RcwzjV4wxFUHY8M6jk8o0i905DZWgjn
	3BLbbSjhplSyQ8olc4Juu2vMGBWU7epxuz3LC3PcBsp/8x0uVJpQQ4zByU37WzhL0+Z85OZ91kA
	==
X-Gm-Gg: AeBDietv/Te+MJmf92TVhfIm0Qo2GlMmT8Me0wiKyjNWka4A3Xm6uKv3/IjCoXvoi6D
	TWjQdKCB2VQCfhTWIYpcL9boMgA2kbByaTvQDbq1YaLAdmju1FURRLRH9dMoI05vMOYiWAR4h/u
	2L/CWtMbmZOIo6WxfxW2ROS620hdfiIW1HncxtB6lXmxY+E/gA3SPUepNJlNb1u1EUrx5+cxhU5
	NiyhcaRqtZ9x+5/4uoFjDJyoJbrHkj3lTPWXMMhU0F+jP25oo0F6auN+kF4q0VldcrapljDujXo
	rrrdmIFKQX4r1O3HfAtnzks9TDD5lHb/J9gcS+4rnvnUeW9+5mKffxQoBSnhSIpieqwgx7BAk7L
	V1C3fhojSQRbNkR1TUKKdaOGhLLrEgsQi4aPX
X-Received: by 2002:ac8:5807:0:b0:50d:8350:9a15 with SMTP id d75a77b69052e-50e3669c4edmr686780491cf.0.1777282725385;
        Mon, 27 Apr 2026 02:38:45 -0700 (PDT)
X-Received: by 2002:ac8:5807:0:b0:50d:8350:9a15 with SMTP id d75a77b69052e-50e3669c4edmr686780221cf.0.1777282724910;
        Mon, 27 Apr 2026 02:38:44 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fc91de051sm122402911cf.2.2026.04.27.02.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:38:44 -0700 (PDT)
Message-ID: <76fb702caa9aa7cd18deaea4fd7e2cbf32a76f44.camel@redhat.com>
Subject: Re: [PATCH] tools/rv: harden monitor name lookup bounds checks
From: Gabriele Monaco <gmonaco@redhat.com>
To: unknownbbqrx <dev@unknownbbqr.xyz>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 11:38:42 +0200
In-Reply-To: <69972ccf-31ee-4906-9907-0ead76bd60b9@smtp-relay.sendinblue.com>
References: <69972ccf-31ee-4906-9907-0ead76bd60b9@smtp-relay.sendinblue.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DJsLqdcxPb9Ka_e2lsTzrl9YA0zvga5CyglPpc32KVw_1777282725
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-23 at 17:44 +0300, unknownbbqrx wrote:
>=20
> Bound monitor-name derived copies in __ikm_find_monitor_name() and
> avoid unbounded writes from sprintf()/memcpy().
>=20
> Pass the output buffer size from the caller, validate extracted line
> length from rv/available_monitors, and use snprintf() with truncation
> checks when building container monitor names.
>=20
> Signed-off-by: unknownbbqrx <dev@unknownbbqr.xyz>

Hi,

thanks for the fix, however __ikm_find_monitor_name() is already a bit
sloppy (strstr can take any substring as a valid monitor) so I have a
patch to refactor it, which I'm about to send.
This will make your fix obsolete so I'm likely not going to take this
patch.

Thanks anyway,
Gabriele

> ---
> =C2=A0tools/verification/rv/src/in_kernel.c | 34 +++++++++++++++++++++---=
-
> --
> =C2=A01 file changed, 27 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/verification/rv/src/in_kernel.c
> b/tools/verification/rv/src/in_kernel.c
> index d32453824..f17eac9b6 100644
> --- a/tools/verification/rv/src/in_kernel.c
> +++ b/tools/verification/rv/src/in_kernel.c
> @@ -56,9 +56,12 @@ static int __ikm_read_enable(char *monitor_name)
> =C2=A0 * The string out_name is populated with the full name, which can b=
e
> =C2=A0 * equal to monitor_name or container/monitor_name if nested
> =C2=A0 */
> -static int __ikm_find_monitor_name(char *monitor_name, char
> *out_name)
> +static int __ikm_find_monitor_name(char *monitor_name, char
> *out_name,
> +=09=09=09=09=C2=A0 size_t out_name_size)
> =C2=A0{
> -=09char *available_monitors, container[MAX_DA_NAME_LEN+1],
> *cursor, *end;
> +=09char *available_monitors, container[MAX_DA_NAME_LEN + 2],
> *cursor, *end;
> +=09size_t len;
> +=09int n;
> =C2=A0=09int retval =3D 1;
> =C2=A0
> =C2=A0=09available_monitors =3D tracefs_instance_file_read(NULL,
> "rv/available_monitors", NULL);
> @@ -72,17 +75,34 @@ static int __ikm_find_monitor_name(char
> *monitor_name, char *out_name)
> =C2=A0=09}
> =C2=A0
> =C2=A0=09for (; cursor > available_monitors; cursor--)
> -=09=09if (*(cursor-1) =3D=3D '\n')
> +=09=09if (*(cursor - 1) =3D=3D '\n')
> =C2=A0=09=09=09break;
> +
> =C2=A0=09end =3D strstr(cursor, "\n");
> -=09memcpy(out_name, cursor, end-cursor);
> -=09out_name[end-cursor] =3D '\0';
> +=09if (!end) {
> +=09=09retval =3D -1;
> +=09=09goto out_free;
> +=09}
> +
> +=09len =3D end - cursor;
> +=09if (len >=3D out_name_size) {
> +=09=09retval =3D -1;
> +=09=09goto out_free;
> +=09}
> +
> +=09memcpy(out_name, cursor, len);
> +=09out_name[len] =3D '\0';
> =C2=A0
> =C2=A0=09cursor =3D strstr(out_name, ":");
> =C2=A0=09if (cursor)
> =C2=A0=09=09*cursor =3D '/';
> =C2=A0=09else {
> -=09=09sprintf(container, "%s:", monitor_name);
> +=09=09n =3D snprintf(container, sizeof(container), "%s:",
> monitor_name);
> +=09=09if (n < 0 || (size_t)n >=3D sizeof(container)) {
> +=09=09=09retval =3D -1;
> +=09=09=09goto out_free;
> +=09=09}
> +
> =C2=A0=09=09if (strstr(available_monitors, container))
> =C2=A0=09=09=09config_is_container =3D 1;
> =C2=A0=09}
> @@ -782,7 +802,7 @@ int ikm_run_monitor(char *monitor_name, int argc,
> char **argv)
> =C2=A0=09else
> =C2=A0=09=09nested_name =3D monitor_name;
> =C2=A0
> -=09retval =3D __ikm_find_monitor_name(monitor_name, full_name);
> +=09retval =3D __ikm_find_monitor_name(monitor_name, full_name,
> sizeof(full_name));
> =C2=A0=09if (!retval)
> =C2=A0=09=09return 0;
> =C2=A0=09if (retval < 0) {
>=20
> base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
> prerequisite-patch-id: b61dd51dee390277603975bf729a687113185c3a

