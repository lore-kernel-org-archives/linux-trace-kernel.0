Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4303EFFDB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672895; cv=none; b=nOIIqNWoENKdR/M/r15URttFjvTsSu9n7vbqQ9mqAlyPzzDP72dFt/vfDh1dhT+0rQ9clgvv/4Z9SLqjw1ECa5XIJlKUJDSCq5WOeZB+FOJxYAw1+1D8TfsnneAQH45MRD0qbyxAbveZPkTqSyhnotRRJ7gevD23KFnAIoOVv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672895; c=relaxed/simple;
	bh=OI6vZMxTu6pN9CeOFlTYwvTpQF8ytBKQzoHYrEpHfxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1or2RxOsw1mPq1j0na0+F2q8MkVyZkNxSPJJRczyC4iPLcrMXb1buboV2iSIVcp2W2TVTC8nKzz1AlooHOezakynQqhz1AdnR0y7eNyE9Aeb71XR5fkFYY25P9dZi/5byaULjuJdBsfruNV1C6HgxVDZhGNy6HpZfBGmokBwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBZDBdkT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBZDBdkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783672893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OI6vZMxTu6pN9CeOFlTYwvTpQF8ytBKQzoHYrEpHfxA=;
	b=YBZDBdkTFnQRyP3NseX4c9Z8qW7I/L48TPPTnBLu3HN4f+xhrMUm1OcDGL+GEZpTgQjgz5
	xu+HL7H5edsDx5NFED/qdUP4QPLhDzjTOPlA7YPGo4vwC1kgLE5uGUDzT2L6VBNEwyjOSX
	bHBkZd91PhyUPYF9phNvBpThNLYVaPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-oSOcNpb3PImXxD8k6rgnkg-1; Fri, 10 Jul 2026 04:41:32 -0400
X-MC-Unique: oSOcNpb3PImXxD8k6rgnkg-1
X-Mimecast-MFC-AGG-ID: oSOcNpb3PImXxD8k6rgnkg_1783672891
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bdf90adaso6021355e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 01:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672891; x=1784277691;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OI6vZMxTu6pN9CeOFlTYwvTpQF8ytBKQzoHYrEpHfxA=;
        b=lQHDg56hSN39KYz6A1ja0PJQa1UDp/dXgnNfcC01seehDHriHUWqu5pgzvDtfDbFb6
         maISmcib8fhFSHIPfvNABlXghxS6mrIotrnovXamSDyIqAjAHUN1fVJDfd0QM84gIXHN
         hXLXdtSraP85nAabkM+DKotuJQOCEuhhNVL0KcZgLnrav+oM85cDEwsbTyeimgjMRsb1
         0UXFjd8V5vtOnlNEhqfs9sheAaByX3YZklQxUntDriACTLDC60PgobowW7jcfMqBszc5
         9unhmoitojXrINqF8kIGERDz7FWhY6dgRI1NnXO4OOYMwVOzM6Yd1yvO44lgQNbDkPWj
         WXQw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/Vti0/oy7MCgKx+6GrNWOEtwTFsk3vlsdsM+uLq5tL6spNU2phOBeKY54n3hieUFEowse5EmpWG/IckNXurFVG3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwesIusZKn3RarFtmO/YdQSSuyFFVPA+DJHSwJ67Cl3C8iqRT4
	kq/U2WbJKsknqDuKp5F+fx02dwQiS1MyHaqOA0oJhT+YvyQy7O9RonqUGA3pGETp1TjEQyZ/QHz
	wrzW4WgZdYSiyUjM8CXhjZeZlV7die3S5mmhIqBpBYyEqNtyNa2i3TSEn6metwX/zElCnEHfkSA
	==
X-Gm-Gg: AfdE7cm2cu33hTkYmSDrx/NhYDC6d2ud8+jl1Jkk32bQqGvUaSJ4OX1iv2xXZgdrVBu
	Poqdp/y+bFYMzoWLJLhKe6bmyfABfl8JaGdZ0uojcijFaOT5dR4Up+cADuOE8VGf2E+X445AoHo
	uQtGH+8G0ZjL3c+/o4donC2iL399Ff1d7ZYiYUdumfZ0OB9sLb9LVuJE0QWZ31/Pyzxome0nvQn
	neLNA/U6eMNQcJlIzrVQlTT5lNMb0yQKYtDepBD2Drxa4j996i7k/WPSSethA67YREk4nvPJG+n
	ZVi5TbzG81G+lZY30iS5vSlLTaZCX3j4UTTkSvAfBJ/pg5pU3SEiZRv21quAnWUdmD4xfP7cbVt
	vejMIoN4hlYDj6VvH5nMdwD268ueEbHzxhkmCZC70BcwZk4GteJ3uz/jn+a6OC4dj6tVDnIIPCK
	4w81MB
X-Received: by 2002:a05:600c:828c:b0:493:bed9:b53d with SMTP id 5b1f17b1804b1-493e68ee07cmr92567665e9.31.1783672890908;
        Fri, 10 Jul 2026 01:41:30 -0700 (PDT)
X-Received: by 2002:a05:600c:828c:b0:493:bed9:b53d with SMTP id 5b1f17b1804b1-493e68ee07cmr92567485e9.31.1783672890572;
        Fri, 10 Jul 2026 01:41:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm119685795e9.6.2026.07.10.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:41:28 -0700 (PDT)
Message-ID: <dc79a18f0ff50c4715a998c00e249255dae7b7c7.camel@redhat.com>
Subject: Re: [PATCH v3 16/17] selftests/verification: Rearrange the
 wwnr_printk test
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
	 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
	 <wen.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, Shuah Khan
	 <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Date: Fri, 10 Jul 2026 10:41:26 +0200
In-Reply-To: <87zezzxt9a.fsf@yellow.woof>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-17-gmonaco@redhat.com> <87zezzxt9a.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l5F2AL5sFwI1YllXqngSAFTH4n3H5LHUNUSbK5YHCz4_1783672891
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-10 at 08:18 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Simplify the test and run the steps expecting no reaction before the on=
e
> > expecting reactions.
>=20
> This requirement is not clear from the code. I fear a new developer who
> wants to introduce a new test case will easily trip over this, or even
> us a few months from now.
>=20
> Instead of this, how about each test case discards or ignores all
> previous reactions?

Fair points, the issue is that we are hammering wwnr, on some systems we ma=
y
still see printks for long after the monitor was disabled, I tried that gre=
p -m1
trick to mitigate that.

To ignore all previous reactions reliably we need to wait for the buffers t=
o
flush, something like waiting for a full second for nothing new on the
ringbuffer perhaps. I could think of that or at least make this more clear =
with
comments.

Thanks,
Gabriele

