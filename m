Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421008;
	b=S8DjkRwIZ2rzB2j+hqOI4iDSkz4QOBNKe+jdCri43CHqxlf+TUdOqE/27neS8N2LUJfx
	 pMCzhkSLnSCgoJKlCmPJ8fRMW3jcWhybf0L84BTR1H2zvziMAFUVQyVKtgiaRMVRks9V0
	 pKyKvewQ2yBrr0W4bAO051+yZ6HRF3qYxUCGbCAZKRX1DAsCtwTL0Yx7tD9kvrjazRbs1
	 kUYM7f0XzIPXpeqHOWUecKPb6oOO3WfV6bxcut59u+L0138xkhW8xEz4Juq/VIkpdWLUr
	 LiqUnBSgIeK/yyXzhJRx1rZLsRf/v8yxHeVrKL3FLYQo4qclSOkF15cp2kwBxJ7octw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421008;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=689khxEoDyV88ktk93RsgzcvIyrFI7xnc9/WPz+bKEM=;
	b=liKko6yW3qh0dbhwcBkSZGm+jmkFZeJvcJW134+t9/vcwz/fWE8T27mhVf+vUYC4/yhS
	 TrI7ySM+BZdrKiJjfdJTthOJRa00ATXwhNOY0sPOSinCtwyY7Chfd0OZIAQtY4Pjz8Jjl
	 J4mbyCzvXjIvrB8eDIBbNqHUvaVZoLw2uEQ3dQD5iiTTeerrHrXP39l9kEPImjRAYql82
	 pgqJV23Wky6JjzGZoSjEsgg/xuk9htWQc17JNhRKe6YOdRJIQN1TCbivG+BVOfs6cJEw7
	 lBzIlXLc1kdpip5/j+5Oof0ilIWr1Bd9+uGgTWfgvsZ7qkIM2I+0tJ9uY023b2Pzufg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EiVDozJf;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4303606AE79
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 08:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4303606AE79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EiVDozJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795421006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=689khxEoDyV88ktk93RsgzcvIyrFI7xnc9/WPz+bKEM=;
	b=EiVDozJfA45xXPBBTIOaQvYYxdfovVm7mwhKFWdjqcd+nXRGcXjRFYZfJ3PmaWMbJpyJAB
	lLAJvznmawBprTAXEBf+vXRRNmLV2YFTbG4qoeb2wN9pHllQi6qt1EO/JZphuSzbnpl2sD
	Wlt6/1cKA1SftBeyuvu1f/23l/pxU70=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-qBJa_kpzPH6bdlynAuPjnQ-1; Mon, 23 Nov 2026 08:03:24 +0000
X-MC-Unique: qBJa_kpzPH6bdlynAuPjnQ-1
X-Mimecast-MFC-AGG-ID: qBJa_kpzPH6bdlynAuPjnQ_1795421003
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df02b91f9so2113221f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 00:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795421003; x=1796025803;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=689khxEoDyV88ktk93RsgzcvIyrFI7xnc9/WPz+bKEM=;
        b=Xbk9D+Xa2LyIVAOjmWy8zTTlw9HBDV5ujg2zMf0vIgg39S1o98q8PHffKt1s54Ayq2
         Hrio9SYdyUYFzt9SSmpfpNJthV/I5x+DTQo+vx6GIZH42LAXtT72Io4oCL6X/jHgeKlb
         PTzddqeuzXUJUhc45ji/ZoTkxyc8oM7yNPCyT4x6vPSakH3hOyZdrFP/YkPZNLJHwyEl
         vouru23cNX8eNXeY27her2KBrpHeZ+XW8ZHrB95Cb2xT14qYVvdauUL4U0BMHxwyEgv+
         Lu/+/NJtqSA0q6uCtkV5lP4hfCLaq20TihYbIiJ2t0ITYHVXFggM3QsSSG15W30GstKQ
         oEKQ==
X-Gm-Message-State: APuU4Z/JZZaiaJyPUxK5w3qQLISCOSaOnBaVNhS05HI6TbVxQ+Cgv/xD
	mIeGbQHQBf+kPt2mc+a/7dbQnHDrACKWVSwOm2W7/HldJIl0IqXQjAgyGHv75TtKLXoy6oeVeuO
	AvepvSXjoIVEXZqlqVeSiOhQ9HS/MRWtAfYqbtAAiPhYh0TZSNSkan0idkKESIsgAZuxPp+0jcA
	==
X-Gm-Gg: AZFdTZf/L1Z+7v8KiZ1+W7ydhjIwMcm1hAT5gSeD8bC5EEKQHHbxvf+x9RbpM3xi2Ze
	TdSZ91wyh+HeH1ZizUrOB2mKDvZtG38kzlXbNy2p9CfjcnK2OkZFaTxobBbvralIbJ/rOQqrwOq
	HvY0lojkg4ZwSPMt2+W7QpUNoUm8U3RIqg8xjgpk4QMgvSUTVGGIr+r2v91V2vKRwFW9ZI1v4wV
	9BmFBadFHPo7mb0hHjFmODhlDxuKW2fflv3QLo3SVX8nWd4TjA4MTtx0zJWge8/jswTXEgfPT9d
	umrvzNjBaiUtxQ4Qbt95Wss4rBPtV6jjSkQPK5Kp/T0uiwZQSKZKvxYeSjItLMqFC5YHtufbiyp
	cwJcZ7jkGi99XpdMYnBUAVw5YFq/+pdPPAUOpju+NzqjUoaldArvMXonDDuicASU8Dk4s4RYF08
	V4
X-Received: by 2002:a05:6000:1e50:b0:48e:60a7:e0bd with SMTP id ffacd0b85a97d-4abb2ecf9afmr16124937f8f.17.1795421003225;
        Mon, 23 Nov 2026 00:03:23 -0800 (PST)
X-Received: by 2002:a05:6000:1e50:b0:48e:60a7:e0bd with SMTP id ffacd0b85a97d-4abb2ecf9afmr16124900f8f.17.1795421002821;
        Mon, 23 Nov 2026 00:03:22 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm21061138f8f.3.2026.11.23.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:03:22 -0800 (PST)
Message-ID: <7715326a01e3cd906829bde394663d449241f17e.camel@redhat.com>
Subject: Re: [PATCH 1/6] rv: Mark diverged child reactors with a star
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wei Li <liwei1412@hotmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	liwei391@huawei.com
Date: Mon, 23 Nov 2026 09:03:20 +0100
In-Reply-To: <CY8PR19MB700998CE5DB06F45985926E8B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
	 <CY8PR19MB700998CE5DB06F45985926E8B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oWBqEBa0iIYXIkEnRUMPvWErOk24wQmn44o2nRNUOuw_1795421003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-04 at 17:21 +0800, Wei Li wrote:
> From: Wei Li <liwei391@huawei.com>
>=20
> Each nested monitor carries its own reactor pointer. Writing a reactor
> to a single nested monitor leaves the container view unchanged. The user
> cannot see the divergence.
>=20
> Print a "*" after the selected reactor of a container when a nested
> monitor uses a different one.
>=20
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---

This type of notation is new right?
It's a fine addition, but I wonder if the reactor in a container monitor wh=
en
"dirty" means anything: for all we know, all nested monitors could have a
different reactor.

Wouldn't it be clearer to use something like a new line with [mixed] (or an=
y
other notation already used elsewhere)?

Thanks,
Gabriele

> =C2=A0kernel/trace/rv/rv_reactors.c | 20 +++++++++++++++++++-
> =C2=A01 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index 8e57a95d446b..ea52f50e6453 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -134,6 +134,21 @@ static const struct file_operations
> available_reactors_ops =3D {
> =C2=A0=09.release =3D seq_release
> =C2=A0};
> =C2=A0
> +static bool monitor_reactor_is_dirty(struct rv_monitor *mon)
> +{
> +=09struct rv_monitor *p =3D mon;
> +
> +=09if (rv_is_container_monitor(mon))
> +=09=09list_for_each_entry_continue(p, &rv_monitors_list, list) {
> +=09=09=09if (p->parent !=3D mon)
> +=09=09=09=09break;
> +=09=09=09if (p->reactor !=3D mon->reactor)
> +=09=09=09=09return true;
> +=09=09}
> +
> +=09return false;
> +}
> +
> =C2=A0/*
> =C2=A0 * Monitor's reactor file.
> =C2=A0 */
> @@ -143,7 +158,10 @@ static int monitor_reactor_show(struct seq_file *m, =
void
> *p)
> =C2=A0=09struct rv_reactor *reactor =3D container_of(p, struct rv_reactor=
,
> list);
> =C2=A0
> =C2=A0=09if (mon->reactor =3D=3D reactor)
> -=09=09seq_printf(m, "[%s]\n", reactor->name);
> +=09=09if (monitor_reactor_is_dirty(mon))
> +=09=09=09seq_printf(m, "[%s]*\n", reactor->name);
> +=09=09else
> +=09=09=09seq_printf(m, "[%s]\n", reactor->name);
> =C2=A0=09else
> =C2=A0=09=09seq_printf(m, "%s\n", reactor->name);
> =C2=A0=09return 0;

