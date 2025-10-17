Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866622BE02A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694819; cv=none; b=splRDzJ4u1gwjmd6yM/0gG/C8x3RzcJp0ZXF2VMETGIhj8t9Xb3sx9cwzpsPFi5fzdWbwuBml3n249vC8Syv6yygHGuAnX8LwDoVLXj2wFHIEgZqcv4xdSayRj9EyKSdQ5GDT17wIM0HWMJhVbRddrBHH/B5XWiSSHgYMGfq2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694819; c=relaxed/simple;
	bh=KrHjLjMduf6FgkomhnO5FBQ767ZzztcQTAJjtuZ1AKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjFX98ZHrQ2hFs0teRJjCqcRbem6E259vwvJaf8ufFsAL3kVoh+k55Vdl0+t6Ve02PrRynYzF3iQKpv7ki7BZ5FC7FBfDBxarlwQZ3fL91SbTmB7E2imLfoQuyNy/2WjjHEqLi925fG0awgoKjOrJhzwIvsuU2aRw+1fHwaM9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVmy1HMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVmy1HMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760694816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0DlN+TetVvDLJy3Oca2Jis/iZUW2CVvAH2lvQ+2XWd8=;
	b=VVmy1HMoipf5l+dGwumJ5OLCDt0V03W/WkD08/86iEkVd+ZdT5Wfwm+n79e/Vv56+m9RY3
	BASw0HjNQeenqCx34QWK+LJ8yyuHRhYR3CNkzIRfMwdO8DPP5szed6OOrNuR42CBAldk0f
	PL2hn/2NfVW2D9sf7VCLaoSKWJyqabA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-BrSVnfg9NUOsQ_-XAxfhcA-1; Fri, 17 Oct 2025 05:53:35 -0400
X-MC-Unique: BrSVnfg9NUOsQ_-XAxfhcA-1
X-Mimecast-MFC-AGG-ID: BrSVnfg9NUOsQ_-XAxfhcA_1760694814
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so2755450f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694814; x=1761299614;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DlN+TetVvDLJy3Oca2Jis/iZUW2CVvAH2lvQ+2XWd8=;
        b=LJrQzvBidym24BT8vNetMP6uxlCdkV+GlLX/7mXBQnDYsF6U5sUjDq/TTKhHPy1+Wx
         PRAt43PlSgVwaqIxCaOuEhkMQVi6vhprVwkJMs8j0eCoofozpClYz8C2fm15gI512KPk
         VloARBX7PRnKtHfrBjVPjLOtGZFnJF8mBG9xPWFcCIOQFbQ6/4r577RseRYbkoTsy3Se
         2QUCTLmDbAz58j9MgWAZnTBQK4/2h5lMLIKgGIwTa54LrkUoeFeVWWULiB6WMGx4JbZS
         VylXfpGGIzZYbFTmGQPB0cRP9Nq0uvl0JoON1xsNKYe0RtS3a+b4hHAq5MRvB567W679
         5QWw==
X-Forwarded-Encrypted: i=1; AJvYcCVYxNSqV7eFiIz301kg54Q45sSHtsjiFieZekjDz+GVjWxKlnec6h6OEhKhOs0XpaY5T6Ym+b9htJ3T1L0SzdydWWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8o+MhGBwUYSpIZlGsBlLfuvlLeCCDV/7w+TGg41DbaYRMxYm
	YamGwbZdSb1QacbJFBlbCeS7MLXIkpY/Jnjllsn+i1kH0nilcHmh76LngdxBdBzHKGkBcEzHA2R
	VunFmAmIH5vpZzF2VTLrVNuMH+GdmS42fV6Sy+eGnMkuvCz9qYhoQY61R0V66DPQMAVjvnq7wpg
	==
X-Gm-Gg: ASbGncsAq+48S4wIRO/pqD0As+LGIApvpbYgwi7QNK1AdkU22AtBfgLUgy/jY/Rg7wi
	u6xs+KvUoK4pVWmuUAcCMmHIg1qVeSXWx3ky7VAjIXnRL96Le5qOBnV+jvRa3qpH0rCvYkhHhHR
	oCJPXS8ys6DcXSolRkAYS1zB87iQO99XHjbapmfoIEQv/oW9FsLZpjsqAExiNFb+vjTnARXupkE
	6u4rX7ZL9N68Fs3gGfWgry4aG6rPZyN2MaTzeQrnL7huS9OWLIy72VykMKN+RWKtcggb8UTHQzw
	i3FX/ck7Orw2JF60JTim1LrfHuH+CU1pGBeiUekVyiRNRGEnSN10fGjvOPVyAZTHKj6Y7oyuaxp
	tnzKruaXLBlIrks6Ec0v9t/40
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr23446935e9.27.1760694814033;
        Fri, 17 Oct 2025 02:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7402xyRnw4HcIyhbz1exHXe6Hqqxxq0TgVQu99XfFQVaLsM1t6f2xEYJ5p3QoSdq35UrlVQ==
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr23446695e9.27.1760694813527;
        Fri, 17 Oct 2025 02:53:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm39455850f8f.42.2025.10.17.02.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:53:33 -0700 (PDT)
Message-ID: <352b71331769747895c86c78521975c56f27ea93.camel@redhat.com>
Subject: Re: [PATCH v2 12/20] verification/rvgen: Add support for Hybrid
 Automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 17 Oct 2025 11:53:32 +0200
In-Reply-To: <87ikgdx41h.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-13-gmonaco@redhat.com> <87ikgdx41h.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: WrmOh9xPb8k_yBWM8-WpP-KPQ4mIpHbonGtcxLeaAms_1760694814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-17 at 11:37 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +            if any(u in self.env_types.values() for u in ["ns", "us", =
"ms",
> > "s"]):
> > +                buff.append("#define HA_CLK_NS")
>
> That any() twisted my brain. Does the following work?
>
>     if not {"ns", "us", "ms", "s"}.isdisjoint(self.env_types.values())
>

Yeah that should do, thanks for the suggestion!

> > +        match unit:
> > +            case "us":
> > +                value *=3D 1000
> > +            case "ms":
> > +                value *=3D 1000000
> > +            case "s":
> > +                value *=3D 1000000000
>
> Use 10**9 instead, so that we don't have to count the zeroes.

Right, that's not C.. Will fix.

Thanks,
Gabriele

