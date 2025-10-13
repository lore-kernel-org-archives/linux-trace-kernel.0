Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A502E9EC2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340633; cv=none; b=hrT17CKBtJxZRz2ZmTlaA8lfIwxqaCe+E0IlJVzpuB+/BWFdA8yiZqo32x6OhyjSL2vjBoMXC2BNc2XX2bjw9pwSCxTGQRUXvItsGu09eD3urwFv+CnRY05teEFPamYmgJY/6gIxg3ufybF1yzL2OOKS2FuhvQKhMyjOtFceaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340633; c=relaxed/simple;
	bh=D1eFUuam1cYs9U7/aNjqT6bbyRqFFlkxOA0Boid2Crk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cK88gtDCola+TtTTwWwe3m4q60LoB1rKDKH4LD6GT1nfFhXkB/qWqBn8RWu9z42AANN2BkVfpR1PC+wM+Yxq3BmLW+QETMTWV8FONpNfjppaLAboaDulyfuTBnEGNlOyX9Cj11PAk2xIVhjMgbBg8sDZMlVJa0rZLDPD88+E39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoukNKY2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoukNKY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760340630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D1eFUuam1cYs9U7/aNjqT6bbyRqFFlkxOA0Boid2Crk=;
	b=eoukNKY22VtsYBzr4/W6qX1jN5tvjKCMIPm9jc6oboO8bqBFmI9mBmvuR7Ge08TQzbaJYz
	uC51rj5hrW5QXT2k1sOqlRqKt5xEbM3axuegwZTBwZahysDizrWxPNrvWIu+f1KvsbkZ8n
	YT0FssW9VMKggcJxCki9pfPOENYukzU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-cJRxYRIMMsmsf4PMUSFF1w-1; Mon, 13 Oct 2025 03:30:29 -0400
X-MC-Unique: cJRxYRIMMsmsf4PMUSFF1w-1
X-Mimecast-MFC-AGG-ID: cJRxYRIMMsmsf4PMUSFF1w_1760340628
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso14494485e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760340628; x=1760945428;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvcrm6KIUPUNpc7xmiZElApRSjY4cVtEn4dAkTy/70Q=;
        b=K8lrkVWmJ6GcVaefyANNIKQXWCfHDs/T7a2cPJF+YrzRBbxJF67DXMBJa8RWgAM/dd
         RkQGBxe0wpGYOxneSA2vJyOOkPe5qIwHDxdmtmMR07Lv1YxK6QZ8pDsasIj+QM4lBQ13
         jazYvHvxQq3SxSa7TWDIaeEQqZh3eqZAZPCFtMJrKMaI9hrHtqvqCR0XRs+BL9r5NxsQ
         nPvsq+xyP0y9UtDBjfTbtfeD5qgmier2DjwN15e6/oySecOzKiwRkvhmKE3LSezx5Y4o
         w/BidXZ0+3PaWNMHLxy0BHvxHnPTTqdlh7tMONS8tn4eauBpMM7n3nSXjtbLZb4/0UZA
         VjmA==
X-Forwarded-Encrypted: i=1; AJvYcCUGGzAnaZnnPLTc9+ua8i64B1vq9YPAXyqoNCEEMYdW9VuavH/MjcOcbKzbcoYhbeyJxMcqKotKQuTvl5UnVBGDn94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxet+OWWvX6CZvxUzwIqjA/+Qr19ZF9ocgzOJbxHwh9kRzFWrKN
	th8i9haALYpUuzMXL/7+VtxqiQZuzQ7GxJ4i8qTYDchfs8+Qn7BqLL+YiwptvlqrSUdWZ0Doqhc
	mFnHvPH+s9qXXzhhNa6+TwzLKuQ2Ag5PaiO7vYykEOpP0P842OdZeZeoXJ5LLGBt+C8qPCd7I+g
	==
X-Gm-Gg: ASbGncsrvNedq7Om91PlxFD2XaWzxbrioH514k9+6LuNjxdpOSo/gqMOre47uNL68oP
	5vTQ9meqcdkzr3JwA/39I+uv7htPOFjGyeOUmHJvc9RKSlWWbeKSiC6h8//4KB/J80SrFZ+VwCR
	sc95buewKhqHTdsCm2Ob0rsFMisVD4XG7LNhjceVhiboX8r+ofExijGPgJbCy7uY2L+Xtbb6Xdv
	wtTxMZFg2CVQJBFBYAOI5kj0pYN4LryZttqG8maNbDeMi8i5JC6IDPPF0mB3E/DZd2EpuZiLKrM
	DZvSEE27AUiw+dEIH29+uP154kU7gFdwLpaK+2vV8kRD2+R/rMM6qXU9wOd65W+8XQ==
X-Received: by 2002:a05:600d:824b:b0:46f:c55e:a687 with SMTP id 5b1f17b1804b1-46fc55ea6f7mr15279295e9.7.1760340627732;
        Mon, 13 Oct 2025 00:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC/F6R+8hlK3CtQbemkFUUvDibbdW2qqB3BO9HixY7B8LvjUh+PY8O3sgUpuovPDwK9I3d/A==
X-Received: by 2002:a05:600d:824b:b0:46f:c55e:a687 with SMTP id 5b1f17b1804b1-46fc55ea6f7mr15279035e9.7.1760340627301;
        Mon, 13 Oct 2025 00:30:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2c1asm121363435e9.1.2025.10.13.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 00:30:26 -0700 (PDT)
Message-ID: <646db9e9d956f009d53bfabf8b8287c034279066.camel@redhat.com>
Subject: Re: [PATCH v2 20/20] rv: Add deadline monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 13 Oct 2025 09:30:24 +0200
In-Reply-To: <87a51yyf0o.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-21-gmonaco@redhat.com> <87a51yyf0o.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KpQzf0U166u_OXizOPMWGjgO_yemEez1C9nhbye44yA_1760340628
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 17:04 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +/*
> > + * Dummy values if not available
> > + */
> > +#ifndef __NR_sched_setscheduler
> > +#define __NR_sched_setscheduler -1
> > +#endif
> > +#ifndef __NR_sched_setattr
> > +#define __NR_sched_setattr -2
> > +#endif
>=20
> You can use __COUNTER__ intead, would make it easier to add to or remove
> from this list later on.

Right, good point.

> > +static void handle_syscall(void *data, struct pt_regs *regs, long id)
> > +{
> > +=09struct task_struct *p;
> > +=09int new_policy =3D -1;
> > +
> > +=09new_policy =3D extract_params(regs, id, &p);
> > +=09if (new_policy < 0 || new_policy =3D=3D p->policy)
> > +=09=09return;
> > +=09if (p->policy =3D=3D SCHED_DEADLINE)
> > +=09=09da_reset(EXPAND_ID(&p->dl, DL_TASK));
> > +=09else if (new_policy =3D=3D SCHED_DEADLINE)
> > +=09=09da_create_conditional(EXPAND_ID(&p->dl, DL_TASK),
> > GFP_NOWAIT);
> > +}
>=20
> What if the syscall fails for any reason? Wouldn't the monitor stores
> incorrect information?

Yes, that could happen, this seems an issue only in the throttle monitor wh=
en
failing a DEADLINE->NORMAL, other cases are at most resetting the monitor.

In this case, the monitor is really saying: a deadline task is no longer
deadline, so its runtime should be counted as fair server. If the syscall d=
oes
fail, we are assuming the fair server as armed (not running) for a bit more=
.

Here I couldn't find a nice way to handle this: if I attach only to the sys=
call
return, I see if it succeeded but I lost the previous policy, attaching to =
both
(and keep a per-cpu storage just for this process) seems a bit overcomplica=
ted.
I see this can potentially lead to errors in the monitor, but I'm not sure =
the
extra complexity is worth it here, considering this failure might only happ=
en if
a user really makes wrong calls.
I tried to avoid creating a new tracepoint on a successful policy change.

What do you think?

Thanks,
Gabriele

