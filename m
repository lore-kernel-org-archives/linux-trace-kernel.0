Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A2239086
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338680; cv=none; b=p0gwP9xdAdeIGAf+yQ8DPxVlFzNIMCXACQaCk0pEB9bnBZ6L/yn6jM4wUWoNbCg2KC0+n8zPe7yx0bc5NKM4xfUZgsx3Apnj2Xl1TBC/BCkDdoxHgULkbK6X3ktF37zozCxA8Z0vRubal3QWNGVI011BNZLPmJRJTB69GX5U/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338680; c=relaxed/simple;
	bh=8BUy/DlnXFwDpANRZOOtzUxjbSJftZsc9GiewZUjuuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmLzGtoACdFr3PVMR89XZxjjmDY6ubbPq0+JF4Y+nQgIgKy0mLIsfV83WwnhNpYXhyzBB8zhO1dVjerwlFCVsWE3dQjmMHGUq2qcgChZ40qSZRaYYtaKYJWeg1/3l7lI97N+QRy/wLys9TxaHqr9DiAud28LPFja67QutrTh3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQTEQOnb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQTEQOnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764338677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aYbQOviV9G6U7vQC1wZCjsv5aDiytW/O4hn4aGzwt0=;
	b=MQTEQOnbjxB8XkXK5f5y8HXxi6ZVNGziEt9opY6Zayzza9347rAzA8Uh6XFGVAYsEKaMzr
	urLETukck3W2A93l1WMisHnj1JDSekBwFZxgtZ6Rs8fjloWZoYZXXnKLb655yFiPgnq2/I
	DE8qPhATyuBKS7db+3qIP/zHb3zgetQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-eNfVLwBbPAuZ6ifNiwyhxQ-1; Fri, 28 Nov 2025 09:04:36 -0500
X-MC-Unique: eNfVLwBbPAuZ6ifNiwyhxQ-1
X-Mimecast-MFC-AGG-ID: eNfVLwBbPAuZ6ifNiwyhxQ_1764338675
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59584152ed3so1294012e87.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 06:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764338675; x=1764943475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aYbQOviV9G6U7vQC1wZCjsv5aDiytW/O4hn4aGzwt0=;
        b=HY6T+sODNjSwcdH2LRdB955SR49lOUFEYJ6IPmmbISlI2IoXe0LUKyRjyOkqGCxiEv
         GZrG7JeP90P1fF+tsNhF9WbOPRH9ZCedSOQ0l65syFv+Y8toLtLflFEdfrhw+un9ncWb
         5ZO914cgRaT8pw+msl2syNP0jc4Fgk7zJbakXIqRAbvX3BdWbDQy2JKbNywhY3ZbKKxn
         6vac5NYpNSKYL8Il1xX/RY5WYll3ReYmHFvMTukE1MguaaTDP5A4s+1fa+Wir0kG4rac
         GGkzPYi+LNByI1IEI4PNsQdKKrs5DXiISNUbCVLi/rErqMPJk2+0BKBGJVeCcAEmb8xc
         9GAg==
X-Forwarded-Encrypted: i=1; AJvYcCWabxaLCdyCdmwups6CNJXVRL3bk7zdsqOf/AsVz91lPS4IvRiAeue4L0KWyOos2QEfyNSa4NLXwg3EQO86BMYVE2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRL8JkTsaa2txEAOfP9kcuOdmm1PAPAofXy8p6sk0tW8WVA0/c
	Dpz1XYDWfMDBSu5DmSmWGFoatr+5PRIvkd8sXLSkS81P05Unonwj+jcLkx4td/6ADuplCTiiZGq
	SXaDyrEIZGFDtnlzXhZSh487qNArsuprnN95TQD1Or/rlpRlL7B6Iy4r0B7qTM6vKQLCmjyqiGt
	VWkWpRe5mBQCB727yXm2l2FhRPH9Vd+1HKI7Ko/qm7tvDqEMVB
X-Gm-Gg: ASbGncvsgSngoH1dGbVC38qqffBMEPMb8pZHmhDrvwi3n0yFfmtyFmfhO1oTw2lXxG7
	Myh47iUSolPiTE5nX2ypfPY9S/RFjX4h8v9YthdlpWnWmKCQCneXoEMq3rdGVCVRB47o6pj9guY
	9J6f56FRE0Bi/YdmeCoAAKARVstctLOSs1f1by7nMat6kWrFGczPDqcr455xfKUW5wIA==
X-Received: by 2002:a05:6512:3c98:b0:595:7c47:cd47 with SMTP id 2adb3069b0e04-596a3e983camr10042589e87.2.1764338674903;
        Fri, 28 Nov 2025 06:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz66R88yyrnFnHjZ3XK8T/KldcTjOaeEpw5lXyP8wGGA8SNJySTlDwLR+bs2xmbBIFPh69rhXpxTJeYQlaS0s=
X-Received: by 2002:a05:6512:3c98:b0:595:7c47:cd47 with SMTP id
 2adb3069b0e04-596a3e983camr10042564e87.2.1764338674340; Fri, 28 Nov 2025
 06:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-9-wander@redhat.com>
 <CADDUTFz_gU0C8uqwDS3ewFRUxk7nbkGv1UU09Omjy0Ew2wB5VQ@mail.gmail.com>
In-Reply-To: <CADDUTFz_gU0C8uqwDS3ewFRUxk7nbkGv1UU09Omjy0Ew2wB5VQ@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 28 Nov 2025 11:04:23 -0300
X-Gm-Features: AWmQ_blHLGrvmJS-VExLZPhZncF8FW2knptR9rNbECwrzHFDz6oKpDascdVpK0c
Message-ID: <CAAq0SUmsdk=uQ7NcjWHZDetm__q5CPxe+H-U01GefJXASN=6HQ@mail.gmail.com>
Subject: Re: [rtla 08/13] rtla: Use standard exit codes for result enum
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: le7OWMQcGFONd_KejZ3G9sway8MARBzeROyPv4TkqgQ_1764338675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 10:18=E2=80=AFAM Costa Shulyupin <costa.shul@redhat=
.com> wrote:
>
> On Mon, 17 Nov 2025 at 20:56, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> >
> >
> > -       PASSED =3D 0, /* same as EXIT_SUCCESS */
> > -       ERROR =3D 1,  /* same as EXIT_FAILURE, an error in arguments */
> > -       FAILED =3D 2, /* test hit the stop tracing condition */
> > +       PASSED  =3D EXIT_SUCCESS,
> > +       ERROR   =3D EXIT_FAILURE,
> > +       FAILED, /* test hit the stop tracing condition */
>
> The exit codes are defined as numbers internationally because it provides=
 direct translation from numbers to codes and vice versa. Additional indire=
ction doesn't add to readability.
>

I believe that where it is written "internationally" reads
"intentionally" (happens to me all the time). The main motivation is
to use the standard C library exit codes when calling exit().

> Costa
>
>
> ________________________________
> Hi Wander,
>
> Additional indirection does not add to readability.
>
> Thanks,
> Costa

