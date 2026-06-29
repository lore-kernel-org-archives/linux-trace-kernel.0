Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7A3C10AF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716710; cv=none; b=L9H3uBtqgIBOXk6bCLqM+PZKuTSAJIAZV2QkXXsR7+tWBJiiDxE6evBQctlTrCLT71nttnLn97/srPWeVpb5VbDz7QqDbAy5/EJFu76wBUpkcChM3XCfx1hJHwa0ydYzmIXwLZM9VFiznjN0vsbl07wvZMroFsJWY0/IN0FhMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716710; c=relaxed/simple;
	bh=2TvZSbaJeZDt0QtZWKzlxR6n2gFDfREHIGZZ3L4ieGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsyXUhgU4YS5OC2Ppkstc1W438s0XvnJ9TTTcSb+wrIxDoPfcoEPDNI5wz5mQhNE3tlfb8bfK0oAWE9gXN6Dh0bgA72Skss1BNy4nFn9F9OT/tD+3YszDnQtsYO1ELvv1jX9o8XSNq9Tt8KHQpYQJgF77APQyaliKr6NR5xcnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqJzf3AX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqJzf3AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782716708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2TvZSbaJeZDt0QtZWKzlxR6n2gFDfREHIGZZ3L4ieGk=;
	b=PqJzf3AXVGQc3sfrfzDYHfVhz+22c79B22xLMqY+d5VYdAUxmsibem7g7oK4f8M0YJsvpK
	aNK5+fbjaLydXUUaDwaItYaoVchkC24QCvt+aLuIR9M2OtXnSGojr8dYlFJql3H13iJ94l
	8tlJOthr4urAmjS2M75PaTAgOsJ9J5I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-AXdTEnHcNC-kc84iriRS2A-1; Mon, 29 Jun 2026 03:05:03 -0400
X-MC-Unique: AXdTEnHcNC-kc84iriRS2A-1
X-Mimecast-MFC-AGG-ID: AXdTEnHcNC-kc84iriRS2A_1782716702
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-470cb859d96so1158794f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 00:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716702; x=1783321502;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApRfeIMP2d5U5s8s5CxROo3JDafbwy3URSsiSmHVeIE=;
        b=X56kTyCQNPsoy2BX0DXD0t36dIFbwncbK0xvZ4Rv4Ot/AakTnj+O5/23DsT11jdQwv
         mERkeSyT7oeNwWZPb9UG/1Ujq/IwAGlMa4XaYH16Xe/+OuR7AohJSaEeS1E7NiRJr3eP
         7sVXL2PU5UYoexzr9L95/FaqDcPpLnZ6eKfqHPYd9o6Rw0qeVUggoxeHq9byKdmxLMU+
         NjORVTBWv1UizcLazSuXY0r/qVYbNs1JmDkO8iipOkezDsiUFs7njZu8BCrxs1iuzkqn
         S7l/bw9CMB37L8zkrr45tL3N/xaZ3zXAAIfmC9p5AH6tFK/f5lg5vmoE348PNnA/9zci
         hy8g==
X-Forwarded-Encrypted: i=1; AHgh+RoV//FmwnPA4I5YhVdD8XfV/MK8vfdXdxAIiAg61Mvck2n978tc60E79dFfzbm7NhX0kp9dX5U3vcl//XQso3LISnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGhl3527jyYQVh0FxWR2HfW0NQkIuuvXr1At1MZF47Q8J2Tem
	gyHFX4qIr9wda1WY/OGChjxh+601DWN+mxuWSSth2cOUhB1odKv1uuOGoKbEPOi4SmUami/OlYT
	wh+YqR6U3e9vWygmblgg/4SH+lWwVe+EZ1qJVHNjzBt/jHIlcn6vqUsTh2TQFUencihr+dolOGH
	h4UMSfehOX
X-Gm-Gg: AfdE7clkl6BVDnykJ1W7g9oZwJhdbW4twjA7x8lvEzOhJeauME5/cAPGadMs3PjEik3
	q6wKVIPC+AJUqRRRet9hv/Em3GxgJVbrqk67D752Kcjy6aAEiDC9Gbu5KZ0C7WTxLJiaD/0NKkQ
	eM3A0XdiGIjqQFnf5fTSINmk4ce6X/zQIZUUP7dbQ0JzOOu2hYTqJfRvgJqU4eXExBFhCqzF7Aw
	FzGar743tGK/2T5OroYpMwKl6nrvKOBxohA+g7KnFgVHaTeLioGrl468aVSFXk54iNHlxnDdPMt
	U+DT+aNOKwctOOjDCOAGtY2fY8PJ7HARUj3a+3hv8DaAV7rb98hFXnEb65IaG9+t5IFMm5GvH+T
	D5oIw0EMazry8vurZUMcpOOADyJNsjl8pXkyb5CGKDJ6yTzR0q8KVB5G8DqXTZ4SJ8XqKT1xQyD
	ewTff7
X-Received: by 2002:a05:6000:2283:b0:473:1ccc:15bf with SMTP id ffacd0b85a97d-4731ccc1722mr5730470f8f.42.1782716702432;
        Mon, 29 Jun 2026 00:05:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2283:b0:473:1ccc:15bf with SMTP id ffacd0b85a97d-4731ccc1722mr5730418f8f.42.1782716701970;
        Mon, 29 Jun 2026 00:05:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f978dc0a9sm23663882f8f.15.2026.06.29.00.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:04:59 -0700 (PDT)
Message-ID: <ed538f5f3a0976ea8a0be66b20a446442f7260c1.camel@redhat.com>
Subject: Re: [PATCH v3 14/17] verification/rvgen: Add selftests for rvgen
 kunit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 29 Jun 2026 09:04:57 +0200
In-Reply-To: <53f2d13c-cc1d-48fd-95f0-2c1ff1edfc88@linux.dev>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-15-gmonaco@redhat.com>
	 <53f2d13c-cc1d-48fd-95f0-2c1ff1edfc88@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cUkDas34fZwvgJ9F1Ngbn2BP2eSP0FMARKVbS8GFUk0_1782716702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-29 at 01:06 +0800, Wen Yang wrote:
> On 6/25/26 20:14, Gabriele Monaco wrote:
> > +static void handle_example_event(void *data, /* XXX: fill header */)
> > +{
> > +=09ltl_atom_update(task, LTL_EVENT_A, true/false);
> > +}
> > +
> > +static int enable_test_ltl_kunit(void)
> > +{
> > +=09int retval;
> > +
> > +=09retval =3D ltl_monitor_init();
> > +=09if (retval)
> > +=09=09return retval;
> > +
> > +=09rv_attach_trace_probe("test_ltl_kunit", /* XXX: tracepoint */,
> > handle_example_event);
> > +
> > +=09return 0;
> > +}
> > +
> > +static void disable_test_ltl_kunit(void)
> > +{
> > +=09rv_detach_trace_probe("test_ltl_kunit", /* XXX: tracepoint */,
> > handle_sample_event);
> > +
>=20
> one typo:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle_sample_event should be =
handle_example_event.

Keep in mind that those files are not ready to build, users need to
touch them anyway after generation from rvgen. Nevertheless, this has
been inconsistent for a while and I should fix it.

> > +=09ltl_monitor_destroy();
> > +}
...
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR(/* TODO */);
>=20
> Please use a valid string here.

Likewise, this is not supposed to build, we are just validating what
rvgen produces and that's the expected output, the user will need to
fill it with an appropriate string.

LTL uses a different approach compared to DA/HA in this template, I'm not
sure it's worth aligning the two..

Thanks,
Gabriele

> > +MODULE_DESCRIPTION("test_ltl_kunit: auto-generated");

