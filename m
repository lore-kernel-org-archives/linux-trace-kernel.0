Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CD442C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764155; cv=none; b=f3fi20whs7INs3c/DHuwbV9/ntWXJ4nk0YvN9TbD/OZ1nVHJGNlVBG2xfuVLuxO9MXPGCX7E2MTrvEauznlAFS9PPSuDonVMpoDvJeSW5vEPwDxx7aOrrx81AaygrMIlxk205mMMhvAsaFcyqiZJIh+3v5o4Yx6oXRrhxX1Kv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764155; c=relaxed/simple;
	bh=o8YzxUxFnNxPvWk0LqNOeC1op1tp++oxZzsKSVZ15iI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM4oZU5VYn377kcHFjBcM2JpG5Hs0OLJxBP9EM6JZpVaAyuG7b0rP8XR0+/lyn9BsBC4QA9ay2/8cWlU3EFV9+JJN7FA8cH9iKYfaSyikcL8re5XrsZNiMTYCzew4PltyERPULcXWLghSh/WTXKygd1FEEQBW99GfHzzIpj/l9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENpitpt4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENpitpt4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759764152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o8YzxUxFnNxPvWk0LqNOeC1op1tp++oxZzsKSVZ15iI=;
	b=ENpitpt4pFchXW1VIeOmx3Y+qttK+nVGvGC1w3rnFnIayWNxKhCHdECzkd2latxWotvKgS
	IJs5U1EL/dOIJE2p2z5ttH49cvq9olpcoV0S0cFkeY4vEjMaipnk0X9+DUcRB+O6LEJE8W
	8qYARRpiDIqPLSjV8yhtjCMLhH3/K9Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-cTwBkFjcNVWgtwhNVjOxEw-1; Mon, 06 Oct 2025 11:22:29 -0400
X-MC-Unique: cTwBkFjcNVWgtwhNVjOxEw-1
X-Mimecast-MFC-AGG-ID: cTwBkFjcNVWgtwhNVjOxEw_1759764148
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3d9bf9e1so22443975e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759764148; x=1760368948;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8YzxUxFnNxPvWk0LqNOeC1op1tp++oxZzsKSVZ15iI=;
        b=gfR/IOm5W7HxujqqzDDSSEHXQc7BaCyr8DR9VjrIb+dfsY3DOcwnMeXy6PmEKST31q
         n74EIXe8Nm7EIfDpC/reHwKlptEuo2+m9U2jCtgmemHi9cA+YUxBmrr7WDmRL4gfOsPm
         o79EynfieUJfznZ0fmePn8W09azKD/aF436lJ9pmLlhOdglpvqpkVW1PFxMr6VJQ2uAF
         QDLTIM7l/ypL8/pq/KaeRvFEd/06yXzGp6C8b2UTNz0AfXXyhYE2LmN55hOaGpjesACn
         OGoJjS7dAHkRwehsyP6PJgr6xi6sXrZbEimeyQaBUVdk+psv7OREhieFGhdQIev+HBC0
         3Ovw==
X-Forwarded-Encrypted: i=1; AJvYcCV4YaGd0uKLdcg1EorKqkZ1rXsnAj5Gc9EB7o6FDE92UCEddJ7iQHJhzzeVWvxpQcsIB/KZXFGk1KoYyPnfkiOIWr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMfmn+dIxIHbiY2UGa1o0m81JhJ/9lNZOpzjbA+e7Lw1rLXVt
	8fAYNAi4XSP+z92VdbgjZAOI3CYY8cTjEfEioSTwkhfztY6fLhjEw/u/sdJ9g+Z0WJfPUnbFipI
	M/8KzDzLoui0lsaatVZI9UEqzaMxJ7so/R1rGiiWEib0A4zk63Q7WsTMZKQpjd+g13IJWhCD/dw
	==
X-Gm-Gg: ASbGncv1SNgepApr6hCKmL4+A8EFrNbXZ6UAskicF6DUvrup97ddFJ48sSrPxzMTg6u
	u4SrWJ7U6X7uuyjPr0UAaNzyFr0JGfb7K2e/nhnTBCnvq0Dp88uQSrvZuFgOntCg9++nC+svsMz
	q9fLlYvDmN/ippsOYFnnyHMaxM4coxRnfjkP4vOp7Plfanw2EPqzaucBJMfd/ol+dTrQxFyoaEo
	2Myo7OyD8fVM1kF57yiA4klZh7c40rXY5y3r5mHIoULZlinrouJtvB0o6MttIs4Mn6wJvJoG+io
	F7pxA2pqsBmj03new4v5tcn8mp0hagK+qpnKjzNZjDdNG06pnkAZtBKyuQ9L81Fg36+MHKs=
X-Received: by 2002:a05:600c:5021:b0:46e:6339:79d1 with SMTP id 5b1f17b1804b1-46e71101a47mr89922795e9.5.1759764148425;
        Mon, 06 Oct 2025 08:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2mwPc8nokFrMFFk/wpmeHcRzJl3szCi2nNmnUV6r4dJWW6D8+UGEIG/SOBoDbAm+ZF+g+Ow==
X-Received: by 2002:a05:600c:5021:b0:46e:6339:79d1 with SMTP id 5b1f17b1804b1-46e71101a47mr89922575e9.5.1759764147996;
        Mon, 06 Oct 2025 08:22:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm21313910f8f.26.2025.10.06.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:22:27 -0700 (PDT)
Message-ID: <73ddbbbb06f9c8d3325a58f68c81dd574b3c80e0.camel@redhat.com>
Subject: Re: [PATCH v2 11/20] verification/rvgen: Allow spaces in and events
 strings
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 06 Oct 2025 17:22:26 +0200
In-Reply-To: <87plb0jhdw.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-12-gmonaco@redhat.com> <87v7kxr2fr.fsf@yellow.woof>
	 <b2eccf79b5ab2b0d4b2f02e048938e923aa6e619.camel@redhat.com>
	 <87plb0jhdw.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: 0crqXhrC1ZvPasA6K8VPylxdOTpLX1RWldTZ-wj6UrU_1759764148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-06 at 15:20 +0200, Nam Cao wrote:
> Nah, you can keep it. I was just confused. Now I looked again, it starts
> to make sense.
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20

Alright, thanks!

> I am thinking about converting the entire thing to be ply-based (after
> we are done with this series). It should make things easier to
> follow. Would you object that?

I'm on board with that, I left out some other changes to the parser in ligh=
t of
a major refactoring. I'd just need to see how this thing works but it reall=
y
seems the right thing to do.

Gabriele

