Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBB392B63
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096463; cv=none; b=nA1nfy+1lQWpXiCzF44D8vhTPlAHMGU30rqcw0IOC2kDXy9iVixmVwTTx7slIC/EqhjN3Gc++/BWEDgux+1xvDg5d3JQiMf+i5s+Na7zV/RSr7lbxcZIMJLcVmS5WZ9nuzz0rWz85SUAMXrDpzm7Kr3jeEMIRYc5If0wMMOIT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096463; c=relaxed/simple;
	bh=32WIzyncw7lgz1H9nylt0N4ChcLVpA6Agznde0kBtXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUvgTk9PY2RIvgKbTwF5fCoQrZwKgAswjL//U+ZlZWa/6QR5VOFJ/FxaMi//tRCsN2wqugpHKIhIgx/UPYSarykWUkkbZbluIUx90up1QtF1A6VacLIiEPRqxEP0y7VDN+QmuIjP5MxpUYEh+1aLMPmIqQNh+ZV7sOnbfMVjTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxlSQGxt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxlSQGxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769096459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=32WIzyncw7lgz1H9nylt0N4ChcLVpA6Agznde0kBtXM=;
	b=XxlSQGxtyAeSU3JrOFGxOo59iPj1U/lC8FzOcwXQbeEoEEe5y6/k5QUzm9eiyUsrEjLPH9
	cyduOFeeOV9LY3yh7+Cdfa+Y/7y2ks3wPToAnlvT6wK/vCj3f129JaEqSkfJ1oRIsQaTRb
	LfZ2hMCVKLrUVYyWpW/RLkeq5rB/Fvg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-ea82vsk-PHiXQc-5GBTHWQ-1; Thu, 22 Jan 2026 10:40:58 -0500
X-MC-Unique: ea82vsk-PHiXQc-5GBTHWQ-1
X-Mimecast-MFC-AGG-ID: ea82vsk-PHiXQc-5GBTHWQ_1769096457
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso9920695e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 07:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096457; x=1769701257;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32WIzyncw7lgz1H9nylt0N4ChcLVpA6Agznde0kBtXM=;
        b=Nm20uRjHATeQLhD7gIk0IouYsv3PScaxgCYoO/vxnpr/+NjqGaJ6RGNK8mACZ3wPjr
         yjcaaJ/4ymTsux56yeRHvZ248AcgIEjnTNBKkwpPpL+zcIgZfIv/frHW5TmMOxsE5pM1
         RREsOEHg2Js1UkZS6fbc6TXivj6CXlTPcEoZdoBoOYJHFW0e1Em8e8WhjQHKFfgEtSZ6
         Rh0nhTRkMlDRhPNm4609G+uqOxmUO27ywgcKvE32ncOVeoa2sBM1fUiX50mVdICuo3AW
         b+gAJ32SSRQEtXoSUalAXBPTlnzAD+DoQYCDo+NsrVCz3FsDXt0kIyepxy0Paw3jCL6u
         74LA==
X-Forwarded-Encrypted: i=1; AJvYcCW2WYVyF7/tCxOb4snKHusNvcaHUm8miVUjr8MG4mWu9vox2TUSvUHOkbTQTALGlCk+NhIwZQ71RpykQZw4ho2NEjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0+AyjynKEhm7jm3tjfC8wG03/ziFRZorxWDUbTn//7NH2dzv
	V7AU+lkEit/w/gXOKJzslcP/8z2HsL+XSX3w9dxgvx/rImXv1/+cl9A/IFnGgLNxeXPW3tZ6Wq5
	pioa/wF8TdPnlquxcrUnP+3CpJCW8FesHZdoZvBRg7ai7KsKuM6mk3wHpWSFd6hUt8i89A0O5BQ
	==
X-Gm-Gg: AZuq6aJF0diyN1Ap/o/td7SzZltaLVkOLzQ06dh9FeU8jwRV0nI4jf2Xd+0zarWdPeC
	0OiF6ymx9GozEPdj34jLGscKDfxySPG1h4EEP4KT52Fv+V/BdDtoGKCjEJGawdrqxXd9Mxt76az
	tz0qR42U69eobJpL8GnWITCR7fdmK74QINaYHjxWB6Sn99tePThx/lO/uTZd0Eex+9xa+xGnUXE
	GqqUft8n4+MCNTsKAm1m2IZyL8fd/mo93U18Sfv3BTO6MfzeGdAVO7nwe3jTwMwmlj0dwc/+6bU
	QR/haF0PaVLc1jhIu+aB9wsEf6eCO5l0e9W7lortAzslwG//F633n0Lb096qf9BYzFdCn/gCXRL
	tLM+RPIGzI98Yng+ey43Ow6G2bHwmcEUxJKghr4zKj0rEgRqCOU3aeJHkIfUMhRggbDF19dpz/V
	wR5Pykoo/v
X-Received: by 2002:a05:600c:524f:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-4804c9b8d7amr443645e9.29.1769096457178;
        Thu, 22 Jan 2026 07:40:57 -0800 (PST)
X-Received: by 2002:a05:600c:524f:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-4804c9b8d7amr443345e9.29.1769096456756;
        Thu, 22 Jan 2026 07:40:56 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf385sm72306495e9.13.2026.01.22.07.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:40:56 -0800 (PST)
Message-ID: <182e75fa8339adb4f90f7c2837ce985ac98e1b80.camel@redhat.com>
Subject: Re: [PATCH 20/26] rv/rvgen: refactor automata.py to use
 iterator-based parsing
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list
	 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
	 <linux-trace-kernel@vger.kernel.org>
Date: Thu, 22 Jan 2026 16:40:55 +0100
In-Reply-To: <875x8tirtl.fsf@yellow.woof>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-21-wander@redhat.com>
	 <b024746953391fbe87427f994a973a212c2fb445.camel@redhat.com>
	 <875x8tirtl.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: tm5ax4D0KXAEj3mIBKM8oBtUJCjtlksnuOp8Hyf0ENM_1769096457
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-22 at 16:35 +0100, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Just know that this parser is already quite fragile and we are planning=
 a
> > major
> > refactor using ply with a well-defined grammar and tokenizer, like how =
the
> > LTL
> > parser is implemented.
>=20
> I will get to it after your hybrid automaton stuff is merged, I don't
> want to deal with conflict.
>=20
> Nam

Definitely, that isn't a priority.

By the way, I just noticed the ply repo got archived on Github [1], I wonde=
r
this endeavour is wise, although ply seems quite ubiquitous so someone may =
step
up and fork the project.

[1] - https://github.com/dabeaz/ply#important-notice---december-21-2025

