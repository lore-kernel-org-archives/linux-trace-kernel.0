Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445007;
	b=LZzJmpzsuM0HvvTPVIAzdqlJ1GlU7OyP0NqR1JVeS9Bs7BxTUhUMI1rQSiqmRObOPdrH
	 NoMGV0hugBkym52WjKWVY3ioFGY39u+is/9It8jFtsVqPnjOTx+k9fb7qPpwzUrwRGODa
	 K9edcq6MCoQ/mOJeBJ35+O7YKTQWndeMbBPhY+HbgsqgbZAvLlno12Lp+zPfdzAWbmr/T
	 /57HE/DELCU8FL1qnzorDL5e48fXhDOO+sk9xSs4YyiaUrKtFg14jH9al0PNW0XbAK3kr
	 PlG/c8UXQetOYu28imJd1lsc5qfFUyw57Cnkpy0ne3eJr+g4VEHcK9X4oZXL5PCtkPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445007;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=pdcWROCO3O0LeKiFXMJqWflTzNA/CicS+wgfgye+MdY=;
	b=bukfKOPkkwnhHsrcX063HT8wJcVPkTW0NHAjq9frF12M3GfdxvH/ml3kfNE25roxUUCo
	 XK9S7Ki6efGZg6/7+QKanVo8FZElVxEajoCSJVSBHmFnNZ3fHiaRi7rj/3WfrDhCdltbt
	 RYhqK8lGSTaGuifqVphAmY9N4WxIONuuw2mQ1l/Gz1N4jjEGB8OcXe4g997N4/V4BujUY
	 J/pMNG32QKOCGEp0ATppcUfDhjWOntIt9YHujHtKRpsvmR9rbiOg3u4VZQeszmQUtIsy9
	 TZPim+9XEqmLf6yoKY4KVqz7WZ9IFHr4C/yxRZtM5oMQkNuZ6hXwwPwxlskWLgwqWlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CVFYpkIF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB66606A31F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 14:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB66606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CVFYpkIF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795445005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pdcWROCO3O0LeKiFXMJqWflTzNA/CicS+wgfgye+MdY=;
	b=CVFYpkIFrBWibMZPbRc7ZrQNEbD0PisStdr9k8xC0r4tUq5g0FRY0xoC3JjTikXFnqD02F
	BAYuOWQfODkxW+DzHci99j5uGSIvTG9q1UbOOWALxJQX11R0+OhmbEAkUeZElcHQezVI0B
	lR/jGr8lUouDGI/jhXXGlUrx1hL7sXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-KHo87BHxMrKK9stwaYlYZg-1; Mon, 23 Nov 2026 14:43:23 +0000
X-MC-Unique: KHo87BHxMrKK9stwaYlYZg-1
X-Mimecast-MFC-AGG-ID: KHo87BHxMrKK9stwaYlYZg_1795445002
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb68d624baso5675855e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 06:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445002; x=1796049802;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pdcWROCO3O0LeKiFXMJqWflTzNA/CicS+wgfgye+MdY=;
        b=kuhsuIwQkqLuYImILNFWEp5FwmtOkTMUoUAnuqXZLmTzhRxuOAPRm5p/9iZptKe87n
         H6sz39FcYjTz7vGrofkxfriplqxsUsEkTIUft8N+864X/iw9B9blN/7Ha4/kTypABK1w
         Q69EQekdgjWPUQehzUe4f0xKgtzIoXRNMxEKUKBo8nbRJGlkuJFG6+SKEY7FPYOS7mzY
         KZcLQ8T+mf2lgNffZpwoIWI0o69qb2WwoO6TXsfjMv+kN9pDfFUQI0fHI58nuKMeh5yG
         AO382so9jUTLT0VPuh/tbLEWPz1hlIQkhtupkki7DMj/YqF2wfoPCHRZbiOLYrkwSARy
         JrWg==
X-Forwarded-Encrypted: i=1; AL+hErHm/htQdE83zyOADW7vb561YmJ/zBpJpN2ojf71Q784C5b5KhOyzWbF0pf6oijAR3c/uOCIyAj69fBp0PUl7+8Q1Go=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Lm9zTpbBmzovJaTFGsAYSOEq2tZ0qwzFW4374wIJYO7vNAxex
	kdiF02sJKSxQmzHujMhu6wtkuf4665lit5cogLq+EMAENAQMfP/zBev5dqdmA5DHFCfEeLeSuqc
	UKa+bGzLZZOYmgm3RNsedUC8YijAWOqY7Kj4YpgJZKmzXouQCPvKlb3A3sfLpFmHkwOrQUnm4GN
	aZlYXyWgNu
X-Gm-Gg: AZFdTZchEAFueOLEsVyGn3wqk6dnF2dpOgZNjkiMZ9xoQ+gS6W/eWOK5a2vGIKNIzmk
	52xBdxiC1FVqCO3kTI9q3eKXP2hkPD18xMxCOnA0yxao3J1LE3cVNycwBrY3IhIj9SKqkfoiPpV
	TNY8UwrpdUwSi9YRm71DxVquqMVw18btIs6P+9OWxM8BXYgKWNDc4T9rxegyYhIf4CQWkG8kXuy
	l6Y9FAdWDhYAXd6lahzS36gbHfFrm6B6uIVpE0S0M6lsUXe7qK2Et9C7H+GBxvQ6p1V+mwX/z3V
	EK6HoDBDJgnaljynsOzjvHOmvrOo+apCfbUqYhxiIwBUI7yql/UMa1eHweaakSGY2veWemGdpFw
	Zfj5ivUH26KUyfUcBm4ZfZwQ7cHiq9ABc0FghJWN2z92c3BBi9FLhjPmWfE/b0CRMUpcFaejuH+
	yl
X-Received: by 2002:a05:600c:4f4a:b0:4bb:6752:8413 with SMTP id 5b1f17b1804b1-4bb8880015bmr273057935e9.8.1795445001899;
        Mon, 23 Nov 2026 06:43:21 -0800 (PST)
X-Received: by 2002:a05:600c:4f4a:b0:4bb:6752:8413 with SMTP id 5b1f17b1804b1-4bb8880015bmr273057625e9.8.1795445001514;
        Mon, 23 Nov 2026 06:43:21 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm18481531f8f.35.2026.11.23.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:43:21 -0800 (PST)
Message-ID: <a0ea5b88df11b325895a446a2e6ed18a60807ea8.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix empty tail container detection
From: Gabriele Monaco <gmonaco@redhat.com>
To: Avi Weiss <thnkslprpt@gmail.com>, rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2026 15:43:20 +0100
In-Reply-To: <20261116084530.87088-1-thnkslprpt@gmail.com>
References: <20261116084530.87088-1-thnkslprpt@gmail.com>
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
X-Mimecast-MFC-PROC-ID: K_dxB-bh-Bs0D0GrAfXbxF87SSn52nQaSL5kzjiLDrg_1795445002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-11-16 at 10:45 +0200, Avi Weiss wrote:
> rv_is_container_monitor() returns false for the last list entry
> before checking its enable callback. With CONFIG_RV_MON_DEADLINE=3Dy
> and CONFIG_RV_MON_NOMISS=3Dn, the empty deadline container can be
> last. Enabling it then calls a NULL callback through
> rv_enable_single(), causing a kernel oops.
>=20
> An empty non-tail container already enables successfully: it is
> marked enabled without activating any child monitors. Preserve this
> behavior regardless of list position by checking the tail entry's
> enable callback. Keep the tail check before list_next_entry() to
> avoid accessing the list head as a monitor.
>=20
> Fixes: 8d7861ac507d ("rv: Fix out-of-bound memory access in
> rv_is_container_monitor()")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---

Well, this is not really a supported configuration, but since we can't easi=
ly
block it in KConfig and your change is neat and simple, it's still a good
addition, thanks.

Acked-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0kernel/trace/rv/rv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 29f155c6968b..a142e877e940 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -222,7 +222,7 @@ bool rv_is_container_monitor(struct rv_monitor *mon)
> =C2=A0=09struct rv_monitor *next;
> =C2=A0
> =C2=A0=09if (list_is_last(&mon->list, &rv_monitors_list))
> -=09=09return false;
> +=09=09return !mon->enable;
> =C2=A0
> =C2=A0=09next =3D list_next_entry(mon, list);
> =C2=A0
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

