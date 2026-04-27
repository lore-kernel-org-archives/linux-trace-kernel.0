Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC203B3BEF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283885; cv=none; b=VbU/mQjfHQHshPaXRZ0Fc+q8LI7xKzRvT7SaZ54du/1QFl9oIHdCAIp3tuwHb9FcDE6dCaUKh7mK0vEwLJa7ALNTVhjELYpgDjj81TgYFB8hOPIRhTQV7Ni+aqAeL+sa0u6cAX4rXids72b2KdUUfw9kD2fI8xbbDFMUYYg5Za4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283885; c=relaxed/simple;
	bh=UBAKpwSgVQhj2CDVJ5Ec6/hyakm5YYHivnrEGULpfaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM+7tDWZH+tQV8VtM35jalxSPy6P/nmBAyeWOq/Rbtd3rfIZN1hbevrd9fKF3x6TbYwcDMLKazW7cdmSAVZa7x7ocWSoKen2vS6FdFfBljnO7Ecr84bgbv808IOuspqPPb2FeHOjSxJ/8oW3JJG6ip9ObvJogVhCGT2nk4ouSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IU0L6WPK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IU0L6WPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777283882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBAKpwSgVQhj2CDVJ5Ec6/hyakm5YYHivnrEGULpfaU=;
	b=IU0L6WPKTqdos/WA9bSa0Eq3WbZD9uAHQt64KgGiBiXOne6hZJ8oYw9qLMXfn1YYRDrhDi
	8NgaT8IbIkmRmRrXKi1XnU7OiMy4aLnTF+yhnzRki80NKtqjm/O02v5jVpqhf3cUB5EWCb
	MMtmZ1oGdV97qh+oVtFm+u/6HZrCSlM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-o0-XZzQdN8qlioj6g-2HEA-1; Mon, 27 Apr 2026 05:58:01 -0400
X-MC-Unique: o0-XZzQdN8qlioj6g-2HEA-1
X-Mimecast-MFC-AGG-ID: o0-XZzQdN8qlioj6g-2HEA_1777283880
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so8016504f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 02:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777283880; x=1777888680;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBAKpwSgVQhj2CDVJ5Ec6/hyakm5YYHivnrEGULpfaU=;
        b=h3Ic4V4Zijju77qI5pVG9d1EEXwCpaS1fZzrLaiqc1JPSoWaI+nD6u8RrCUURGv6g4
         t5lwyJQcD8iNzo67/PtMDuXR9pRhU7XP95Qut39aZz/2x728NSMKInHaSDcVYyOA7WqW
         OitBYBNuTYpqD8KgHDQDeI1QJhQsV8EIVpcexAD483/WvBQs4TPwEJOUaW3gUwnAjaSF
         stmkN3CU+2AqYBEHU6ZmV+/BX84GYMSgbsKfIP07vjxHxOdop9zYb99e6OoWTtJIozuj
         BnZmxnIloAoh6/IsEyPMVzcjgIgi+KxF/IxSczTQusqOY66H7EslpDRrq14HNTHSkhd9
         r9rg==
X-Forwarded-Encrypted: i=1; AFNElJ9ONeiAu3AvjDU2KOGZzxu22TgIwksKYnUdPVdOV1IopUZY2TK4tz+ACNcItDSsEGpvzuWp63O/v7wbZtSvLK6LYm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGW6YltDtQIZXf2ZEKRYiQ7oYpNsEjttDPpxTCNcfNvwz1tFp
	tZ5PL4ODJmJU5XWhapyEsomkj/QzMtJKm//YIq8s1KNHAS8QHU7X6S7TfErKPePGB6ukZyWNsKV
	V7AN44jCY6aMhKB9HC/CUF7Tro1lFyi+oPL9Q+pBA5gREwAPUVrtPGg+9miYob7FiiIqhnnkjVK
	p7OqJ6hA==
X-Gm-Gg: AeBDiet8Ej61W6NYnoxkJYnwwbhoX2AUbwoT7GosxIOmFzbVVYevfNGOR0tw1M/0Scx
	vtGwT61UaZC9ezM9UGf2gKcIgGIrfvrfqswKKKRgxNdB50Rv1YzmqWS9tLjbnBl/2gFAd/tbmvw
	mSyXl9rCTPcJM4o19NwRzUH83wAq8BXhVkeCWCiG70QZuc8o7zlZk3ZYkGbiuxuixjxb92BUIR/
	/OWAQhKD1T9aR7NU0ZGaJHd3aD6H0IUl3IoaBQkrfEORZBiBQ5T7WK/ydzANJ1Ji4CqgqxZksU5
	nZWbG1my1jm7fzEJqlnR4Ma+/4XA7mqJt5hcyr8qN++Z53CHp87y9zdw3JpHsZeaYll3E9MsJAf
	LQJSeU2fKxV3lUNp+jFMqkQ1RwB4vZNCe7OxB
X-Received: by 2002:a5d:5d88:0:b0:43d:6e0:9458 with SMTP id ffacd0b85a97d-43fe3e0c779mr65091408f8f.39.1777283879964;
        Mon, 27 Apr 2026 02:57:59 -0700 (PDT)
X-Received: by 2002:a5d:5d88:0:b0:43d:6e0:9458 with SMTP id ffacd0b85a97d-43fe3e0c779mr65091370f8f.39.1777283879422;
        Mon, 27 Apr 2026 02:57:59 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm77141294f8f.33.2026.04.27.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:57:59 -0700 (PDT)
Message-ID: <6d7e529c7cb0ad599669e3f33e5b6168e92a8861.camel@redhat.com>
Subject: Re: [PATCH] Documentation/rv: Replace stale website link
From: Gabriele Monaco <gmonaco@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>, rdunlap@infradead.org, Steven Rostedt
	 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk, skhan@linuxfoundation.org
Date: Mon, 27 Apr 2026 11:57:57 +0200
In-Reply-To: <875x5crb4g.fsf@trenco.lwn.net>
References: <b845c448-1655-4860-9b6d-93d6f8426740@infradead.org>
	 <20260427085526.111835-1-gmonaco@redhat.com>
	 <875x5crb4g.fsf@trenco.lwn.net>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yOh2eCHRKMs8I_bBDPELmyOMkiHrcsnsYFGiptQb2TQ_1777283880
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-27 at 03:44 -0600, Jonathan Corbet wrote:
> Since, as you say, it can be found online, is there a reason not to
> include a link here?

Mmh, perhaps being overly cautious for the link not to break again?

The paper is published so I assume it's always going to be available in
some way. It is currently hosted by the university at [1], which may be
unlikely to change, and can be found via DOI at [2], which should never
change (at least that's what I believe a DOI is for) but brings to the
publisher's website rather than the open-access PDF.

I think the reference to the paper I included is robust yet easy to use
with any scientific or even general purpose search engine. But if you
believe using either of the two links is more appropriate, I can send a
V2 with the change.

Thanks,
Gabriele

[1] -
https://www.iris.sssup.it/bitstream/11382/533630/1/Elsevier-JSA-2020.pdf
[2] - https://doi.org/10.1016/j.sysarc.2020.101729

