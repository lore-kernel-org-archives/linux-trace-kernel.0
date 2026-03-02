Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903740148E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464304; cv=none; b=kSQdn6rhKaC4kkSbiNJZ6d2hmQvC/+RDXliCS6D6gJ9bcJmVAgkHWbVQmMfAupP6hvBXqkHVM4/ZhTUXVZG8CBznGl8F0eh+2E2yotZI3cp+xTwnegMVWb/aWn8R+TVnvT9MH0O6RWZIWkBRd2sbpG2jg13hYsjtXWn/IIenCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464304; c=relaxed/simple;
	bh=XXK9tfrn3MZSIw/AyURtYgBgJiBl45NLP03lEhvn26o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aODJQj0wrbPkn5bLP9mmEDnOnclQNsf0SYE/tHSzRPIAy1BlVeT8t8PK9Z2uNczbDHZTJeaLNQCSRuOjXaRpoYREzEfzge9KfVC0wfruSeTD2FgTWpopXr0xqBMg5YTB493ErbI6+xmSB5zsvr74CL4JvFwJggj3CXEvyRYkM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPEJkyuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPEJkyuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772464302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1vJVu5iP1VQasC7zVKwon6G0qPbadtj2uWnfDdV9MCQ=;
	b=LPEJkyuPofMcJce8XytDZD+vff3uUAZb9DzxAY9CI3GhgjE1qedXN3r1DWlNKEWuWNQXa4
	10UdOs+U2cCdAt53e/8vHfPQYbi+SVABF0dUppl98HCDiBqGB1Ug/0tvoUPWA8dvTJaOoN
	pDbuXNMh2Q0YZpgOc2bHbOimSdIJMO4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-p2btmlqjNySV__pLah7I_w-1; Mon, 02 Mar 2026 10:11:41 -0500
X-MC-Unique: p2btmlqjNySV__pLah7I_w-1
X-Mimecast-MFC-AGG-ID: p2btmlqjNySV__pLah7I_w_1772464300
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-483a2db68caso38000595e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 07:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464300; x=1773069100;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fR0fvLxS9OT19o4gHC8nFDyqzxeV7tuHCO9Mj5KxIFo=;
        b=p2xvj2rUn0oT0mviC6GFiOnXiioxpD9x+vQSQSobaIlDtqJVY0uFvgccuL0CQkmcis
         mTlkDcKJUP6S6MqJ0fktO4EKhZo1ipF8g9B+r8Dzt6c4LXTfc50N3GFYOM1oUjkirQiL
         rlwjPRqXBSGh4t6obhcxuYPLE9jiytmpHRp4LQ3y90hYvH7vzd/xzBTzzy0O2ZBA7g2C
         FAYnIvudnZmLAgpgc8eJhYlPgSRfKb3bCkiV8wqkdPFgQgWTQ0I+QPO7QxZxuz9UKr+5
         JaoWZPmB8cMmgpvEhQdssoXw72AAhCMUPRm+pLQg4oSVIa3ok/0/SHbLM/Gt6VnnPig6
         GxMg==
X-Forwarded-Encrypted: i=1; AJvYcCUuM3GhghiOZKLGbvFUCgSIOr4xUN3NBAXUbc39FnAtfyhSb6KgdwskQT4MxrkrbyfWiBuJ7CHXIgE5omjb+jdrcWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVbi0RZpOO/nDQKW4lGWQcJQ8oryKLwYgiEn+a566/tDurS8A
	Jtho5A868ULrDJo5TkfWQ4906QW0218w5HV3Pw1YcNyN3fn5s0F2hSldDSGeTx0N10qDvCDyapq
	qdk52OXRE+K7er5N13kFAUX4SGMuYs4IMnlXFejopsCFbe4HHoCYE6JyPAdeG4PymRmQ4mZ7/rQ
	==
X-Gm-Gg: ATEYQzytHmw6FReBAzyqdAHpCJE48nedbUBgmaP2hATFzmz4tkZp4XoL+YBygGciOSl
	eeeyV4Z7L6WP88maZQ7+8ghCDKSaHI2NbJ6jtR5OY4/Ee2BH3/8Vy/m+dXVE3P4Ld+b0pTkf4Ji
	eV2O+pJ7A1MoaPN/mdSDIZr5vizqen6sNiRqLdZ87XUdL96hbhak0ZylEgxoUMpxBC9yHqIIKiE
	RV08BRkW87xpf5otXsGsVsE7JjT/RG9yiXDcJTIkwFBz1p6XUfrqCkfcs0GAIeqEtO4NrDWAU3Q
	ctRju04kntqCWNcSGOEVlWCg3fisa75HSj1EkvN677BwCjEa+XzGpLXl9lhfsO2B1LoUhZRq3Z9
	P2q3wanr8Pn6y0fk9R8yKfulcy5lnXG3yQgf6YFS7pNUYclV3U3VumHhYIMPAjiKNK+91zM/HmO
	ep71cHcuDfiBSOlqs=
X-Received: by 2002:a05:600c:c059:20b0:483:709e:f239 with SMTP id 5b1f17b1804b1-483c9beacf1mr153607095e9.22.1772464299858;
        Mon, 02 Mar 2026 07:11:39 -0800 (PST)
X-Received: by 2002:a05:600c:c059:20b0:483:709e:f239 with SMTP id 5b1f17b1804b1-483c9beacf1mr153606585e9.22.1772464299371;
        Mon, 02 Mar 2026 07:11:39 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770c2sm281641905e9.10.2026.03.02.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:11:38 -0800 (PST)
Message-ID: <4369c322cd0626844ace0f42c55ec2cd9890cda0.camel@redhat.com>
Subject: Re: [PATCH v6 15/16] rv: Add deadline monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Jonathan
 Corbet	 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Peter
 Zijlstra	 <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 02 Mar 2026 16:11:36 +0100
In-Reply-To: <aaWgvBXaNg48qYRl@jlelli-thinkpadt14gen4.remote.csb>
References: <20260225095122.80683-1-gmonaco@redhat.com>
	 <20260225095122.80683-16-gmonaco@redhat.com>
	 <aaWgvBXaNg48qYRl@jlelli-thinkpadt14gen4.remote.csb>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EKSa5EUe46Ooq8g6ItPhIBY4T65Buc-ecxCRhatVigE_1772464300
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-03-02 at 15:37 +0100, Juri Lelli wrote:
> > +=09if (!pid)
> > +=09=09*p =3D current;
> > +=09else {
> > +=09=09/*
> > +=09=09 * Required for find_task_by_vpid, make sure the caller
> > doesn't
> > +=09=09 * need to get_task_struct().
> > +=09=09 */
> > +=09=09guard(rcu)();
> > +=09=09*p =3D find_task_by_vpid(pid);
> > +=09=09if (unlikely(!*p))
> > +=09=09=09return -EINVAL;
> > +=09}
>=20
> Not sure I get this comment. RCU is released when the function returns,
> but then the task pointer is dereferenced by callers?

The idea was that the caller should ensure there's no need to do
get_task_struct() (which is fine within the syscall, I'm assuming).

But looking at it again, that's not even necessary as long as the caller lo=
cked
RCU, which they should do instead of guarding here.

So yeah, the comment is misleading and I should just do:

  guard(rcu)();
  extract_params(...);

Thanks for the observation,
Gabriele

