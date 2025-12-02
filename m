Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0582FD1A5
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657708; cv=none; b=n0k421fdp1Cjpyv4Hz3dY07VpsdLetQ/ZQEgXJQGnsx72OqAaSFDU5v0rUBEJWD5v+Eb6nDXhY0npXVlf985K1SAYmA8isoe/pXMtaPFusc1PR+EsF0W9vBQ5qHG8keiVh9BcIi6evWbF7LzIcTa61EQZi0h1BKWYxBrBVstGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657708; c=relaxed/simple;
	bh=Hai1TcPQOKf1uaa49H412cyjjDU49X5uOvuGPOGDSeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKOMLBVzk87lDFZ0U8AOOgKbeEyMHO24qqw82lgfPcwvBLDbN2ArIBz22V8xuO29my6/YAgN3IllJQ8iifVrundY3BvAsnchO6ACLjvOAPowAwTMyJYuFI0PlL11ps2Tm5OVyB0yu7uk1fdWJ5yJBbIFZXJEShJWukS0go+PPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akVB2A13; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akVB2A13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764657705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=49VrYK15cdFiRV0c8Ms3/BqF7Fte0UtvKvhmXKoE+jk=;
	b=akVB2A13B82qE3OEjGhMo3DezwjNFtw4OwsXtXUmqSLsQ9pocpNx9LzzdkQiAGDwNDWFuW
	bAHGibKD6PQwk6lSSftBzFCff5VCFbiZy5mxmsHHxNxl6+n5yz7R4m8ki8Ft2biLBcIZ5G
	WEOsiw8hjm6znkfIFs7qTUF4WFwdHJU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-2BSK61unNCKk-d_C38jPjA-1; Tue, 02 Dec 2025 01:41:44 -0500
X-MC-Unique: 2BSK61unNCKk-d_C38jPjA-1
X-Mimecast-MFC-AGG-ID: 2BSK61unNCKk-d_C38jPjA_1764657703
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9351ffc9218so1887953241.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 22:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764657703; x=1765262503;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49VrYK15cdFiRV0c8Ms3/BqF7Fte0UtvKvhmXKoE+jk=;
        b=umSeQvBX//cj6MucT/a5zZ5vWTTekwaIRK+nci6FD/Xx6QEeYmbvBe4zoB/xnb6bcp
         X3l4P3lQnYVLvU7mUIOPXvns2t/qNKUlB4VSdSBbHety/OKmAAsAEB3rqeHTA7fMcKnG
         FID3yS9XOxpM2PThxuohQleZd2FnKYHFaXusbPDfWg6k+tXwuwAlf53idcV6L+IfJtGO
         uqoiS/2nYpw0VQ753ZUh1fEzBU8Q/SyEAm8vUv+DN1R+f/YyB7vcZ2kNmO+cMw2Tip/9
         SBm6m/Yu4TRHOq184tJDCyrY7ZFXk8CM/hso/Sxggtqliy6bMYZi4fhK0nC7hyzRtVfu
         b1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlzGRJRH/odSMjKBCZ2UL5Y1ylTC8AR1FFSPU3ICvZND0JHfr8hWrI9V446S1LzHyo9pIpA5LCmL7vdR7wcpeZdfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37S+qB8f9+hi2ewBcJPmj+9AeNc4l3yXl7CqBcWZ0rSlYHlV7
	Eq/1NwK5Hzd8+k2jQWpZUE06zpZnC5eMGHKmp79mA595gwDF41nwqm4T/KhWRlJuXrQnjHCj+Pm
	E3kX7w1yUSNhFFn5ln+8Ag49b3ADGF1eXx5+MmBSdc7G/9O2CqH1VghHEOjw7qM90F/mpfE+0Cg
	==
X-Gm-Gg: ASbGnctlRzM5lDC/wGak3XdT9owzq6GibfC+Z7ehHfzT/UgXNnncU8obtyXG7i39+xR
	FhLoAJvN6eLJzOonRrJjV30fNIm+WbLPqIWJMeiIuIqia+zbslUrHso3Os4PnMlyKLskq8CuN+h
	Pb2D9n+lKYpKYKPuc0dbfwKyEVCep9LZJ4CMDTK6rHfzKi8fbd0e8CIG1H/m5Agy7Shl+1m33R+
	czlD908DtPrdVN+d+vkjHjm5gCicoObNdtEZRKDcbz1r6ZuW/43acrfTFy1xv/SlaUJ/dSX4AHG
	HyhieMoOwXf970ZXa+j1GXr2+OCWCrb9NnTc7KeqjAfIidAKd3NK9lWA6OBwFDbkDASP9GKk1Zh
	bgOzkTn58OqtGNWtcgS5luzSeAxMNe2dZhOo=
X-Received: by 2002:a05:6102:5ccc:b0:5db:e1ad:770f with SMTP id ada2fe7eead31-5e1de13b836mr16102326137.2.1764657703484;
        Mon, 01 Dec 2025 22:41:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhamUfYQ9Q2zIzUmmCQfk/WwwgPP3XWOeyeSTxNgztBrtuHQyCDQwKgp60d8CwOLKBdPuc+Q==
X-Received: by 2002:a05:6102:5ccc:b0:5db:e1ad:770f with SMTP id ada2fe7eead31-5e1de13b836mr16102322137.2.1764657702933;
        Mon, 01 Dec 2025 22:41:42 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd6ce2180sm6626867241.5.2025.12.01.22.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 22:41:41 -0800 (PST)
Message-ID: <534ed046d7417c60711063d86cf8b594fcf573ec.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 02 Dec 2025 07:41:37 +0100
In-Reply-To: <20251201205132.520eb490@gandalf.local.home>
References: <cover.1763370183.git.namcao@linutronix.de>
	 <dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	 <20251125145736.48c3ed9d@gandalf.local.home>
	 <e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
	 <20251126095106.7eadaba6@gandalf.local.home>
	 <2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
	 <20251201102447.53f33be5@gandalf.local.home>
	 <8f98932a8fa9c3e63c9a5cb7ba764e9db968bada.camel@redhat.com>
	 <20251201203816.5e777f12@gandalf.local.home>
	 <20251201205132.520eb490@gandalf.local.home>
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
X-Mimecast-MFC-PROC-ID: iDuArvEk3tSNpqbt_7gWZel7-2UOAt5hJ2zWw1MnbFA_1764657703
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Mon, 1 Dec 2025 20:38:16 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's best to always use your latest branch that you did your last pull on
> during a release cycle.
>
> I see you based these changes on v6.18-rc7, but your previous pull was
> based on v6.18-rc5. If I were to pull this in, it gets a bit spaghetti li=
ke
> in the merges.
>
> =C2=A0 v6.18-rc5 -> pull1
> =C2=A0 merge <- v6.18-rc7 <- pull2
>
> Where now we have changes between rc5 and rc7.=C2=A0 Was there a reason y=
ou
> based on top of rc7 and not use your last pull?
>
> It's fine sending urgent patches this way, as these tags are in Linus's
> tree and it's just new changes being added. But for a subsytem tree, it's
> best not to pull in Linus's tree unless there's a good reason to do that.

Yeah got it, there was no valid reason for that rebase, I'm going to keep i=
t
stable next time or write it explicitly otherwise.

> What I can do is simply pull the patches on top of your last patch
> directly, and keep the history clean for my pull request to Linus.

I'm pushed the tag rebased on -rc5 (actually on the last PR) just in case i=
t
makes your life easier:


The following changes since commit 69d8895cb9a9f6450374577af8584c2e21cb5a9f=
:

  rv: Add explicit lockdep context for reactors (2025-11-11 13:18:56 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-6.19-n=
ext-2-rc5

for you to fetch changes up to b30f635bb6492f02f2f704b46d898679371015cb:

  rv: Convert to use __free (2025-12-02 07:28:32 +0100)


Thanks,
Gabriele

