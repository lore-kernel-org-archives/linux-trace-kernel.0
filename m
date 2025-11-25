Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E808248B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031601; cv=none; b=joFiQw36jjrKO0Mt6h3EL7EoYO78hB3lVptTvQKAxhzsbQNHYHkX+jKHxvNwKDyw6BUMItEzb2oo3inT1iDIQveFkuQilnHhWuMoFN9HsOEEgBPgNMkPjK4ChTBWe6CLRozxJw0iCyJHQ4O3IQHzpRnUmTh0GZpN+mnpI7Brixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031601; c=relaxed/simple;
	bh=02AI4RQiKKF15WGFKXLLq5sNxTkuOlaxKrGUIQCWiVw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHVbbw8hxSGO32qrZltXUrj5HjqvCT834AlM5ckmNEKOT/pkKqEPUG/KVxJikeZag+wVoxwpXtubJXbxcBkKEUaVD/otrjuky0AdTZ5Yv0WPALLQ782WyvDaEBJ1ADWWw/3zsIbM14IjAFIk/bftplB3VhBIAPJNqoGmj0RA9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5QrNqzA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5QrNqzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764031599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYlCMCAO0HqOKGki0s/7Cz1W6C8GEu6uMR0TbHrkLWo=;
	b=J5QrNqzACghMRlqc39kJwxmBySAnrVDD6ClnKx7b7AMzz3BqAq9fUO9l06v2VXjwQ6QSfE
	RnkGHdMRti83gSnuVloF7f67678l7We1Iyv4sywRvNjf16IxhU+8b473owyPNB/ksgluAD
	vyndya9PgPy1rABXrIhwphGSLEowj1U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-bo3co_0jOWil8L6_Xtborg-1; Mon, 24 Nov 2025 19:46:35 -0500
X-MC-Unique: bo3co_0jOWil8L6_Xtborg-1
X-Mimecast-MFC-AGG-ID: bo3co_0jOWil8L6_Xtborg_1764031595
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-880444afa2cso64746926d6.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 16:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764031595; x=1764636395;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYQVballiQUNa7s18X6oVPWwoZUsXRJUaKrTG/soO4I=;
        b=H6Iq4d1vUbFPKVBht+QiXD2MYIeOp7V4FtWDjaLV9UwAtJy6WFKMhIlgWd6KOGLIM3
         25NdLgT5M/Px8QhphZkbvot8yLSLfbLGTZAFgOCgzOBnOHGIEdKEZDuadcwYs+jBf0yT
         wkDNwmpfV/TxQfsTyXhaIszbLaBPAnPmgKQA+DTAuhrN15VYAi3HSMsFjpO6v5QErY7b
         8YF3ZVfFzjTv8V8jjNeqiY1OS69qdhELHloNkTEjxIExeS+AdP5jE3gzwvcrfC6Okb1Y
         rAw4VDAVm10na+AIAePZDnh5XMDe38vHpx8Ezd0LMDxMRcUn3oHTsWeUIJLkqlFjhCLq
         CoRA==
X-Forwarded-Encrypted: i=1; AJvYcCUiUVU0L3nX440fbLyFnGuSJTO7Jn47Li8D/N2rAhs4i6rDVQFU99NL6SbF4vLRou+VOdu0tpNPeGSKO+BKbcDQMos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSEMdk/6FPGqjkahcqgmJRSChtbyLVZsf3Kc3IZskSGTFAp5M
	V3KMKtLnBnar3TZUYQolTXjsiukhhAwfMLnDHIXCDgDbuw/wOCEhl3mS9QyPykoRNy1YFfyKntz
	CcIW13sbgYix/TyDCJ34Ukzi7xg9fswkRzWxhbqxbev6tCVOkpnrM2AVymIfN6rUZ6IMd9sg+TA
	==
X-Gm-Gg: ASbGncsGqIQ1/F1YtOgcIj3J/JBoa3yT1HU0uaw2d0SYmypiuNnIbQpsBvw53xC5NHp
	dUH0IhQUl755/E4btpYqEgj5JVhLd2z3LKRBid3Gv5bEiAUb3pfMYEaL6owQO/bsJ10XdxddpdY
	C07yO+6Gb7CXGmQ6JYfZh9hGfzWOUKyc62y3BwPwFzCjs53IHpwpLniz+hoeH0JhO28pqZui9vS
	IoPwLsYEN0GtscYCZTHLyoVHPcwxsqQyvyg3/qMk75SHN/gI4u+oUlx4treBbVyACg1feryNEVZ
	yKYwVPXLXULULjgOfTiKkTcyejnxNPRtBz6NIX5sMCmxxht6T3UCBtkMUjdgqjzghhbULuSXQC8
	3YkQSYITpXn2KI3ISJEstscuThI4tnJvqhDI1RrVzrA==
X-Received: by 2002:a05:6214:3286:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-8863af9e4e2mr14512246d6.43.1764031595190;
        Mon, 24 Nov 2025 16:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1IIBLslO2enBnltrjevE+RfgzVlbb9qwoLOv7Ks1RpjPqjqO5ugdNzJyrbWT1YPDsV4Kegw==
X-Received: by 2002:a05:6214:3286:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-8863af9e4e2mr14511936d6.43.1764031594723;
        Mon, 24 Nov 2025 16:46:34 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e46a4b2sm110780436d6.19.2025.11.24.16.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 16:46:34 -0800 (PST)
Message-ID: <e96f06667d07fe7f207fc8769218967d22cf7634.camel@redhat.com>
Subject: Re: [rtla 05/13] rtla: Simplify argument parsing
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, Costa
 Shulyupin	 <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "open list:Real-time Linux Analysis (RTLA) tools"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Mon, 24 Nov 2025 18:46:33 -0600
In-Reply-To: <20251117184409.42831-6-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
	 <20251117184409.42831-6-wander@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bGE_XwElfGnO3pjzvhMF-hYoQgA3XgRsUBQoL7clnn0_1764031595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:

> =20
> +/*
> + * extract_arg - extract argument value from option token
> + * @token: option token (e.g., "file=3Dtrace.txt")
> + * @opt: option name to match (e.g., "file")
> + *
> + * Returns pointer to argument value after "=3D" if token matches "opt=
=3D",
> + * otherwise returns NULL.
> + */
> +#define extract_arg(token, opt) (=09=09=09=09\
> +=09strlen(token) > STRING_LENGTH(opt "=3D") &&=09=09\
> +=09!strncmp_static(token, opt "=3D")=09=09=09=09\
> +=09=09? (token) + STRING_LENGTH(opt "=3D") : NULL )

This could be implemented as a function (albeit without the
concatenation trick)... but if it must be a macro, at least encase it
with ({ }) so it behaves more like a function.

> +
>  /*
>   * actions_parse - add an action based on text specification
>   */
>  int
>  actions_parse(struct actions *self, const char *trigger, const char *tra=
cefn)
>  {
> +
>  =09enum action_type type =3D ACTION_NONE;

Why this blank line?


> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index 160491f5de91c..f7ff548f7fba7 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -13,8 +13,18 @@
>  #define MAX_NICE=09=0920
>  #define MIN_NICE=09=09-19
> =20
> -#define container_of(ptr, type, member)({=09=09=09\
> -=09const typeof(((type *)0)->member) *__mptr =3D (ptr);=09\
[snip]
> +#define container_of(ptr, type, member)({=09=09=09=09\
> +=09const typeof(((type *)0)->member) *__mptr =3D (ptr);=09=09\
>  =09(type *)((char *)__mptr - offsetof(type, member)) ; })

It's easier to review patches when they don't make unrelated aesthetic
changes...

-Crystal

