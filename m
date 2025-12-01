Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8631AF36
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602908; cv=none; b=TBv75+9PkGXmXH5PZUYKR/+C0JbSvhZy2r0Vp2a92MH0LyLy5rAIii8IQgoDDmeexu/iXDA3ck+WKp7Q89o4lhh2m6yhIFtxAUtiGKYPDHQ50rrwxYGjaGGmEI1vAq3LOcjDtUwz2DLN3jqk2LmoKImt49FEx8cignr0da7hHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602908; c=relaxed/simple;
	bh=zF7KUZIyBykPGxoMytvOsw1DoXMoEq3cDo/1QhWUT/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnf+zXRNzx4nQUbWHZ6EaEwPI9zCoG2N5fBrPL5C5cDlhTP0UwqvshSZdJvb7P+D1o79jrO6j89YVWfBoc6ftvPvkl4QlJVsUHH+NR9/IxF/jPG5HI/2aSokq9ufetbsG71AkrzywjZxNzrlZ1zAUAnzdNL+qLYvaMMtRE0woI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTGW8pTz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTGW8pTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764602905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zF7KUZIyBykPGxoMytvOsw1DoXMoEq3cDo/1QhWUT/I=;
	b=iTGW8pTz2bhIGfB7x5oWXMxMUH5+gozaKkFkMp+u8ncLrxluDaoCBaVV3L7+4Dx+X6ND1M
	EDwZ3ahfIMS7g+FV+a9y1NDrQ8fJweBEkxOK9ewBR7l1mj7Rac+Z87/UAjXnNzCc112OSO
	JNnXZSXQs8/ptRJAz3Qn1vsAtB0OM/w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-KhC6Adv2PF6Ah7bjoeHqhw-1; Mon, 01 Dec 2025 10:28:24 -0500
X-MC-Unique: KhC6Adv2PF6Ah7bjoeHqhw-1
X-Mimecast-MFC-AGG-ID: KhC6Adv2PF6Ah7bjoeHqhw_1764602903
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47918084ac1so28154555e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 07:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764602903; x=1765207703;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zF7KUZIyBykPGxoMytvOsw1DoXMoEq3cDo/1QhWUT/I=;
        b=rg1NnnFS7OmHctH8GRRSrUa3q9WTG/iFnRBHsNFpvZDy6NUtnvN+Dr7PNB/hAhlbHq
         y8jagsdorny9hNhgBrjfEiIh1gPYxWpdGYYKxiEKXElUt4ijz5wXLhAtJG0v9X95yFaT
         RlWJoCgCE9Xap/FxnG2eeyzVxG+WrVmcToypHStN+PPR3PjxteaxX/grvQuVe4FaDdAg
         jv/foUm39OOcYUGDAP6xiWrCT9YXbqTlWg97gdWm3cz0pAIryBauZDrlNA98euDrTmMX
         BrCkxnU0ig+vFgjrBthHW0RWMbSi6sRz1qv29yFsxXRU46uUPERfY0OaHB+MZD0DV9e/
         wuLw==
X-Forwarded-Encrypted: i=1; AJvYcCXzrCB3Te8LQ6jP0AwFSFRdiQ8m0cjHKSuLeNV/WNTa9VW3IxXessSeltaTP7sxxng/MdI4mNFg6Y7Q7N0g0ifDSxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QBvLoPk/RFLg1ms//VR/ISzU1DTmtEHSX/eolkho9pbuNZWi
	quEkIgtgrGLZBcfSda1/9LqsyFO83BRwAexBjxKzR6flOjOyZKNCqgIqxcuQbsZ4fKNuYKnW7UE
	Cxdm878GVczFks4ptgjLrV43x2loraquW2nygNf00dWLpBpUXK5MEn0O9jM53x2ndicUkpQCLzQ
	==
X-Gm-Gg: ASbGncuaLDbdxEo9DSjUb9My5Zn+VF97JEgqTLeBxmgPxqZYPqqeB5AusUjdbJFxcYG
	y/jD8rWY9lnMhTwj4AcZuk80aY+xyqryYA+wzYm8fgkjhw9Aqr+F8ntbrss3+Qyd85c1DoB6aJH
	9p1w8CGG3szuX2Xo0mXYvA7+iifMogGVviYHyd6xUpIaMRCfvtykK/whfdRrrcxb7xEgi6zWAJ+
	0IAwxuBBN0pMGWo0gtJNdD4yQo5jjF+ottz1Kk5Ro6c0pXgphb/rIBfsn1Y/myAex+sKzoOqrqS
	KrIkadLG+h39ZIbTiNzpsUIzisZAKSgZKHFyM8aw7NWwgt6V5O3ex48y0qufIpiVoo4fBrDLeaz
	0Mpzd8Ia8qy1d0mqKmUxcRd8d/5w+2aslc50=
X-Received: by 2002:a05:600c:4691:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-477c110e521mr387678065e9.11.1764602903226;
        Mon, 01 Dec 2025 07:28:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPxkLJhmaLGc+wegbdURPofklXasw5rJunlsSO3JiqRqUWUcsk+gd6DUiywzkAf67ApjNDVw==
X-Received: by 2002:a05:600c:4691:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-477c110e521mr387677605e9.11.1764602902678;
        Mon, 01 Dec 2025 07:28:22 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add60e2sm305205265e9.6.2025.12.01.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 07:28:22 -0800 (PST)
Message-ID: <8f98932a8fa9c3e63c9a5cb7ba764e9db968bada.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 01 Dec 2025 16:28:21 +0100
In-Reply-To: <20251201102447.53f33be5@gandalf.local.home>
References: <cover.1763370183.git.namcao@linutronix.de>
		<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
		<20251125145736.48c3ed9d@gandalf.local.home>
		<e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
		<20251126095106.7eadaba6@gandalf.local.home>
		<2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
	 <20251201102447.53f33be5@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Hw6-r17sEqIGBtzb_AQJUX53CUJ5nQKMmPAXV7i09g_1764602903
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-01 at 10:24 -0500, Steven Rostedt wrote:
> On Wed, 26 Nov 2025 16:22:17 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > I can send it quickly since you already had a look at those two patches=
.
> > It isn't a big problem you won't have time, though. It can stay for the=
 next
> > round.
>=20
> Did you send them?

I'm stupid, I sent it [1] but the script somehow didn't add you in the To: =
field
and I didn't notice..

I'd say since the merge window is open, this change can wait.

Sorry for that.

Gabriele

[1] - https://lore.kernel.org/lkml/20251126152253.464350-1-gmonaco@redhat.c=
om

