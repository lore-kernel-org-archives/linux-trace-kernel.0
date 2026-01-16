Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301C30102C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573491; cv=none; b=VEtoC9qe6jd2i8zBcp707CgtxiOCusZ85u+iapie72+ZOTfGlYfRlGf6E1CSDKy7t9TeJOJ9AgQhWXZ7Jk7mbeurGgQ4FJm7r32QPvcJ3Z9YHporn4v7Q8hzhAgJM8JKJMZevCNJJzT6nCyuLxbShV5ZA6YOn7tzcgUdC6hGAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573491; c=relaxed/simple;
	bh=DvLAnx/+ePOpmemDnJKnvPka9u4ZUDf5YvLJgsm3aO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lm9Uupr/uE3oe6NknoABxU/P7xPQmc1+rQPWrBaRyhqGI4xpMtc8sXi1BzU73brgqWp3v+wO0vKCxVtfjjRqjzy7rG9kAlws7E7qJd5VszfdhB2wxyFpJLe+/KbJp57Tp1K61P5HgSQ+QdDp4Akrgyej27HMUaVclFqQsTVAJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuHXDfkM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuHXDfkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DvLAnx/+ePOpmemDnJKnvPka9u4ZUDf5YvLJgsm3aO4=;
	b=GuHXDfkMsSLIeOhkgpKm7OeCP0i1hG72+Cgj5bB4VnCOX4szR6NT4WlM0wqrCnOFADyER1
	FbL1rrcIPNCT0daIqoF4E/WCQUTy8cUHNYZkl10nmiJLmWHzjWMlmVRhy0fVpjI6vGTiuy
	lKVWfYxv54b3gwD9EY3IZ5SuxYShgx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-h0W8Q33OPoe1qRjUy9_Pzg-1; Fri, 16 Jan 2026 09:24:47 -0500
X-MC-Unique: h0W8Q33OPoe1qRjUy9_Pzg-1
X-Mimecast-MFC-AGG-ID: h0W8Q33OPoe1qRjUy9_Pzg_1768573487
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ed980309aso13730425e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 06:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768573486; x=1769178286;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvLAnx/+ePOpmemDnJKnvPka9u4ZUDf5YvLJgsm3aO4=;
        b=QzsyKqGsFNprgpqRrPElHa/ZzP56TRDXdLHpuD7uLWAlGVzE0ObcEog5/bF3BndT0p
         CB6Un/YWUqKHK/7mccN73TYfgCE/YJp7ujXc4RPc6dP4NssoxpRDK2NukKV6hnNfYNuD
         T+6IuT563KTEn+gChwlfvL/51NDSnLqEgCEZMbkOBq5X/bSr2dOnIAbhMrDtmkxX3yP1
         MvwWr3coqwjTrTXv3LMH1aOr9QasiICQEhmUmrRNSHTUQXNtOpVswzqxkRyg8HLmI314
         79VU6BifQ7Ff7mZhCsxEmouGVWBNEkheu+KZqO0dZbYOukSkBRCWzc0syyCoJiBDE7T/
         MbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV15N9wW2jnUeegW1rx6Jr4Acxg+YkOIUqHKTtFSU1JWrBdfonf3cDPz5NUFzDXxXxOhN4sijaHyjdBZHGeVgoBdKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7PtHP57rFCC3W3ZdDmCTv6MK6AIpYKQIQuYnScg7vvgqVjS4
	17WRgaOp8mdRXW2FpN6Oa4IGpnT4Ex6EqiZZKf13x3UkfBsbgAPbZ03QOxn9wkqUm/Lo/zTmAvk
	Rh+/1omygD1TmPhWy3kdMRBtSztYeEhnfvTozQ0Eu2fSzElfief8YDfJxKG/taPClVZbFHQKT8p
	E97qc4AkWo
X-Gm-Gg: AY/fxX6mBRyK311Y6br7q7WurpKKny5PKefpU4aoNCEpdIEj9nqObIQHLvT5kQ1BS1E
	TqwO+/a3+Vs7vQ3VJ/kr4FF6n+ZaQjItL76XTlcgq2FZZ0B8E0ym5MOP5khq5TndhPnz4n1vxKK
	BvTavwuJCtOWP2J1ShaMsYneDyqTIbrWZ9AM4FJPd/QXFFm2Ttd/HdSA3tYP6FNHlnhYSGYowZr
	LKYWNnnZ1HO8gsZWCWPYo6CCUwvgeWYG/Do6Uw8d8ePf5Rj4YUMtJtCSGbyxZbPh/xsifzYStKB
	UO1SF6wsKkbhk0Y9AyrG1k8OM9MWzb1PNmZkABgXDdidaYrBYhoVOS9rdV4TYmXhLKHZpUjAk5x
	aP6APFHdXbVc3KFV+82iwTq/L1pB1mLGRWOTRJTpH+usA0pyPPtTLj487vFEErJCA7YWc8GJxbK
	nQWFdZOpCz
X-Received: by 2002:a05:600c:6749:b0:47d:333d:99c with SMTP id 5b1f17b1804b1-4801e68adc6mr33989735e9.18.1768573486581;
        Fri, 16 Jan 2026 06:24:46 -0800 (PST)
X-Received: by 2002:a05:600c:6749:b0:47d:333d:99c with SMTP id 5b1f17b1804b1-4801e68adc6mr33989475e9.18.1768573486205;
        Fri, 16 Jan 2026 06:24:46 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9fb193sm18645725e9.6.2026.01.16.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 06:24:45 -0800 (PST)
Message-ID: <02e7de82c4093adcbd82aaabaab893f43abcea9c.camel@redhat.com>
Subject: Re: [PATCH v4 08/15] sched: Export hidden tracepoints to modules
From: Gabriele Monaco <gmonaco@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar	
 <tglozar@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur	
 <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Date: Fri, 16 Jan 2026 15:24:43 +0100
In-Reply-To: <20260116140047.GA1129681@pauld.westford.csb>
References: <20260116123911.130300-1-gmonaco@redhat.com>
	 <20260116123911.130300-9-gmonaco@redhat.com>
	 <20260116140047.GA1129681@pauld.westford.csb>
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
X-Mimecast-MFC-PROC-ID: 8q_ThyfSK5xox00i5V-iBotLhglAYjbZgGFE5KPadDw_1768573487
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-16 at 09:00 -0500, Phil Auld wrote:
> Hi Gabriele,
>=20
> On Fri, Jan 16, 2026 at 01:39:04PM +0100 Gabriele Monaco wrote:
> > The tracepoints sched_entry, sched_exit and sched_set_need_resched
> > are not exported to tracefs as trace events, this allows only kernel
> > code to access them. Helper modules like [1] can be used to still have
> > the tracepoints available to ftrace for debugging purposes, but they do
> > rely on the tracepoints being exported.
> >=20
> > Export the 3 not exported tracepoints.
> > Note that sched_set_state is already exported as the macro is called
> > from modules.
> >=20
> > [1] - https://github.com/qais-yousef/sched_tp.git
> >=20
> > Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model"=
)
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> You can probably skip this one now, yes?

Right, I kept it here only to avoid conflicts and didn't mention it in the =
cover
letter.. But yes, since this is part of tip, it can be skipped from the ser=
ies.

Gabriele

