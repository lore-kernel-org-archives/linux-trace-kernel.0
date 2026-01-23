Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EDC2D0605
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171212; cv=none; b=H49MXxGvKBhqvreRo9QcgzKh7YjohwuYG5rrimsvGdnVm3nZwAU90mYWV1fmQXqfwE0Y1K+gzF0Gh2Ms6QF+8F80a8n/TzEM6zXnUYfYjulC6NcdJ9HjI4+mS8trESGuDLIVhjLuI+GLhDj3YueRJfAGVW6P30Euuw2PVXNS150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171212; c=relaxed/simple;
	bh=QeD1TYjFxayYg14f0fV4inrfOgKhQgi+K/KjaHS2PqQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKQYo1yW6cNezuV9Glp0laql/lQcz/NEv7jBaXDTEScnKCWefDnKADsghDPl9QWn9ayhce0R9htDdQ44Fwjpf2keeWlOCVtGmLfDforDzGSZMiHxlfgywjSXWBlB6Ws2hkrb/p+bQSo7cz5leUMdujOEm9eI+M1s0e30Ph7mIaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3yQbZMe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3yQbZMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769171210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QeD1TYjFxayYg14f0fV4inrfOgKhQgi+K/KjaHS2PqQ=;
	b=d3yQbZMe19wdVp8bobDnK95UM1HG/u96zsYBE8Hr/ucMx1g7ihifXrNjaDBneIUsiD19WT
	3iG05zwQwaCKO8v4bp5+FRptGWd7SVQ6T+ZOAd5zjYVn2ERtEIEbGNKhT13o3xa4uUTQXY
	Jd82YW/sWQbOxNoqRJjxKeDbb2uC6wg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-v2wPUA6LPimJbP2mu-peQA-1; Fri, 23 Jan 2026 07:26:49 -0500
X-MC-Unique: v2wPUA6LPimJbP2mu-peQA-1
X-Mimecast-MFC-AGG-ID: v2wPUA6LPimJbP2mu-peQA_1769171208
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso17234895e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 04:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769171208; x=1769776008;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeD1TYjFxayYg14f0fV4inrfOgKhQgi+K/KjaHS2PqQ=;
        b=o9WfUxjGC5uVIq/iSoyFOjOYeZ7xtgBtkdnohrG8XKvKQ+30HpMPTDZ0BHHSYVjEwZ
         ABN2ueXv60RQ7hrqDFDjrFL0sDUslpECjqnJYP/lxGse5/phWQosehE54skmpOp9icMS
         456E8KJy6VwWVj29LfwlnEQEw4RdOSJEDoDPPckyNmWuDF0LemV1zXoP322B0tB73itB
         bthAtcf/Q1JedXY+3ySWCsvOTAxkItuXvpEQ9awZ7bs0gPETTHs71nSs4L/p14a1sqv3
         yyrspp2W1qMcV9QsMCIt4wt+S2mF2ro/IQgLMm7Qpc2ZmltVmfxtyUwu/mfF3gx71dcn
         xlxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX01yryUrhygG5VJUCAHbUhnVlipu8IsSwPdPdZv9UjNQTKqYh9KVbWHaYvg3S8cGJcXrKgYJzHlCU92iBNIooglbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbTmBJ3GLXcvdOyFoWaE10XlcJdheHNH5FJaFBQNBU1plvlX5
	01HwIZnNNETbkp7/4iXyd0eLE8PIW6deycb0P8RvtsiLZXSMWOcUvUQE12KOKX7+LNyzl8qp4a6
	Fz5jxfLFIFkfPVq4Tl62xTItDHTLEAuHb9PX/gCHTrDkP1BGt3Z6ztokO59vflU8RI63CTFkHkA
	==
X-Gm-Gg: AZuq6aKuLNgaDoZHm2o8HC2bk2eYxHrF9lktWbO58JBdO2qmLq+Fkuo8KysM64oQcpk
	fLfWP7v39BrTEb+1vrZGx8nBCrNhjO/1/1bEPwvwT+JDS8SmQLYoeMv2TWeNaHW5mOyMfyVot3v
	qYzH9N1j+DSHj6ig7C8p56OFUbxIWCQ+xZHr2c10dpUSHOyWd0bpS/Ytq+DNIvpj5ssRSZC11km
	gBcKQIij+RxoGEX6vOAsmjCVoPsof46JJjaXB4QTbYdreIy7rTHSaV++tIMEtjSef9jJkandmCI
	mv+8WB2Th8Z76gktCqSpGPteHTKO7COx4G0LZvOe/+Jr75jptYMuorlkoICW5utiXN7mMC61ZMI
	jjBoYTt0Rt9difFtdaioXEz3kRt5Ndx2EIQTVoaMEpHT0ceemYBzp9rSksVk8B7+p/FXEZjNwBG
	2QdJoOrTti
X-Received: by 2002:a05:600c:4f48:b0:477:63b5:6f76 with SMTP id 5b1f17b1804b1-4804c9b8854mr50670035e9.25.1769171207964;
        Fri, 23 Jan 2026 04:26:47 -0800 (PST)
X-Received: by 2002:a05:600c:4f48:b0:477:63b5:6f76 with SMTP id 5b1f17b1804b1-4804c9b8854mr50669735e9.25.1769171207565;
        Fri, 23 Jan 2026 04:26:47 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84588fsm55069225e9.2.2026.01.23.04.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:26:47 -0800 (PST)
Message-ID: <c866db81d6213862baf4a4d3d9f2f013b7ef058b.camel@redhat.com>
Subject: Re: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to
 ltl2k
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Fri, 23 Jan 2026 13:26:45 +0100
In-Reply-To: <aXNkusXPp9MyRX9y@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-19-wander@redhat.com>
	 <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
	 <aXESFlL56FA0PyTZ@fedora> <aXIhSGAQvflGAEsN@fedora>
	 <ed5ffb1045a5d0734947019ad31b9bf46bdca3ab.camel@redhat.com>
	 <aXNkusXPp9MyRX9y@fedora>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O2ctuk-PWN-mkPOtTbSNKw5JLjCYi4EWouqWYR8mZvk_1769171208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-23 at 09:19 -0300, Wander Lairson Costa wrote:
> On Thu, Jan 22, 2026 at 02:49:59PM +0100, Gabriele Monaco wrote:
> > Why fill_tracepoint_args_skel() is not required by LTL is an implementa=
tion
> > detail, so that stub could even stay, in case future monitors are going=
 to
> > need
> > the entire thing.
> > Though I still find it cleaner to move that away too until there's a ne=
ed
> > for it
> > shared in Monitor.
>=20
> I didn't catch what is included in "that"...

Right, it ended up quite cryptic, I meant fill_tracepoint_args_skel() could=
 stay
in Monitor although not all Monitors need it, though I honestly prefer to m=
ove
it away and not rely on the stub.=20

> > What do you think?
>=20
> I agreed. fill_tracepoint_args_skel() makes sense in the Monitor class.
> If a derived class doesn't need it, it is an implementation detail.
>=20

But I get your stance and agree with that too, where fill_tracepoint_args_s=
kel()
goes is just nitpicking at this point.

Thanks,
Gabriele

