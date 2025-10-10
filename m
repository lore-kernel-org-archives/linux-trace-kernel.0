Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCAE1DDC3F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101377; cv=none; b=ezSoHniVLJBCQGa/xTXwZEUrHbgTiTrSZ5//iNbULnMreDquyosibeTwP8r0OMF4pAZiUYewvgS+NPBAUfJsDyhYRYaxd0lv7u1E4WbNgTcxJgLfTkkCQ5A2+z5VlmYBW/b5qdLVfLZIKX2rVzP03XvLkrw+LpThAPGph0v3YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101377; c=relaxed/simple;
	bh=FnimfbU2FanRO/TFNV/nIlg6CaWFEdZfo2qAFRmfFTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWbMKWpTmSBb2HXjyIZZpTygUMtFOsXRpX9KRcINgaek7ro728yCgcomNSlW62OMwE+JQlq4DcNwurdHt4Gm1sFTzMVP2GLCxnFpAqe4QpIit7+K0pgJCqcxOfEK3O2VBFp5jLtU8dp6fwyKGjKrpNP4hmheQrQ9o8viC/XZ6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDluU58A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDluU58A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760101375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FnimfbU2FanRO/TFNV/nIlg6CaWFEdZfo2qAFRmfFTw=;
	b=DDluU58AyztwY/tjcYgKVN84m6CqVmRnDKLV2jMjiIjKVkMGX9uz0Si9cs7bXjO0l0NecJ
	7qLWe+i4yDO5De8uZ3UPk+G+t+BIkU2eF1FS/ObIRisu/shLjRdq4w3pF2Q16Q3qlOUT+t
	TcXPpDcSHGJSh+/msCSF6uGC9MIOMks=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-gOQ8DLN4PHeBEFVXIbzRGg-1; Fri, 10 Oct 2025 09:02:54 -0400
X-MC-Unique: gOQ8DLN4PHeBEFVXIbzRGg-1
X-Mimecast-MFC-AGG-ID: gOQ8DLN4PHeBEFVXIbzRGg_1760101373
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88375756116so1034605485a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101373; x=1760706173;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnimfbU2FanRO/TFNV/nIlg6CaWFEdZfo2qAFRmfFTw=;
        b=nhwX2SozB7r5/9tUxfRC9Z24xJygJpIMR7gqcTVrI20HJzGd5j71Ni4Y3+W+5McjsD
         UX+VSro/CPyaTUpwa9maVi9XvWv0dAGBSH6VOBUpK5bwtLJ7KOfT4gNqOXos9tqFy45g
         8Ow1Tl1d4MCef5J20IDP/CN86n5I0rAbn1i0zR3edU6pYuMt9rj41cpeycEq9bOvQrQ1
         yN7Rxe/AfDcS4vIYVd0XbBZshuvqh3zMqwlRUgyV1e3EC1h5eIGefafZt/et4Ji5e6gO
         n8nJBUQdF6QNro3RLG65l8ybN6cwBEP3NXSNb72Yf+c48ucPkfoZWTfgjSCVuJBNEoij
         q2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXc8cFrxqltlY4vQF6yNiU0DtWv2HVfv04MfmWf4SYt3YwwUbE8jHhT4zjdxGzkSIPbpU6SAf9XKFdZ0ElWPCRofWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/9jr9be0JdjSGiQ8sO14U0wjIk5rKwS7pDFSa3XY8/eC28tF
	SieZd7m4ouZJbRDxhV3KSr/XE4vnhzCQQrlJFS6zvvVjiWxM075LB0KjMzvyHDW0+hdZURWWLIW
	EF/T+7f68EVBia4pL3KWOYhCC89ilVbkwHPNizXbQ9tAYuUoUlEaOUKocFixQohJIehegXTvitg
	==
X-Gm-Gg: ASbGncuga6AsMepqNwUE6QFk1lWGKjlMsmJixo08uG6PtynnlLesvY3S7RE6CU1wrBy
	9og2vhM4VGhxHqeLtWgO+oozEa8k+NG/sxaxYpB/xNX/xRj3+a23AAABEDZgs39pXeXbgmm/3ny
	7WTk3EUQuQDPqNquQLlWvIKQhIF2UdvHw69oVB2yj6aZ91NZ0fR6Tepu8No4vKzalxFf0iR5qqe
	bx+QlkhWrkyzeVeSaZBMaFxyd7d1L6bHxNJOwW6GVl28BUS6vdyVkyJ+WM94oiNb3iLAF5GvCzH
	3FUpWaJRXgS1z8IwFwuZi7aCRsuX4y2OVKN/Nwt3Tb2BaEo8o2Fj6DERvpCyi+Ge/+e0
X-Received: by 2002:a05:620a:3955:b0:800:367d:b9cf with SMTP id af79cd13be357-88352ab0a0amr1681030685a.38.1760101373412;
        Fri, 10 Oct 2025 06:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnBnL7bmfY10viDPL7rL1Bs4KKFHHbDdLEX0MPg+8h0pURGT9gfkD0AmyKBdVqjSuBGaneJA==
X-Received: by 2002:a05:620a:3955:b0:800:367d:b9cf with SMTP id af79cd13be357-88352ab0a0amr1681019385a.38.1760101372490;
        Fri, 10 Oct 2025 06:02:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ac935sm402758185a.15.2025.10.10.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:02:51 -0700 (PDT)
Message-ID: <0f438533d0a0189efb4649dfac3190196330868e.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Date: Fri, 10 Oct 2025 15:02:42 +0200
In-Reply-To: <20251010125823-9bcb33be-96b9-4753-8ae0-11576f0e8d40@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
	 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
	 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
	 <87ikgxqrna.fsf@yellow.woof>
	 <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
	 <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
	 <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>
	 <20251010125823-9bcb33be-96b9-4753-8ae0-11576f0e8d40@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: JrCtPO2uXhKNao5zdYPCHNfx3zANRAg_K4uk9dwWWlo_1760101373
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 13:02 +0200, Thomas Wei=C3=9Fschuh wrote:
> > So if I get it correctly, you are both "voting" for removing reactors i=
n
> > favour
> > of tracepoint-only error reporting.
> > Am I getting this right?
>=20
> No, it is a suggestion for a cleanup/optimization where reactors are not
> directly called from the monitors but instead from a tracepoint which is
> triggered from the monitors. It would decouple the monitor and reactor
> subsystems.

Right, now I understand this better. Interesting idea, we can give it a tho=
ught.

Thanks,
Gabriele

