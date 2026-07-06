Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA151C84A0
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350052; cv=none; b=mRSU+ZcvYqxYHCYzVQM+R05RTAWd95Jr/J6kj73WDIoEqs+sh9vpHNkcgyVFYVsybPPigazCkoxx61DetFwBWee+angV9fdztZCsp3p1swRm3qwm+Q8ylqMsx4Z2mGCa1p9Yczg0HQKY05nfjalSeDbypgZUIO1J/l19Ny+J02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350052; c=relaxed/simple;
	bh=QtwZc80/lu7+P0WgmV+/KjEa3xqRWGgir61mh14Au/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3rXbQM1pCzL3B/cddPOYlz3Uu5rvaBG1rIOLiXN78TMR5uC2zSEZdvF7kJNiBDrt8dwtml70Lnfz/w/l+TJv0KxILrIcK8IQgabbhAcewh6pEufm+9SKufKtaeVX3pMtYfv07pwpi3JccrNsJA3ISFwLB4dWwR2pohzMvQq2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTL1q7KE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTL1q7KE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783350049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QtwZc80/lu7+P0WgmV+/KjEa3xqRWGgir61mh14Au/w=;
	b=BTL1q7KEQysMV601lXG3TJZrq5L92o2Gnot9cd4QAakXkH3Pfy3ncwAY1nBQzhuk+g6O7A
	GUN8evoITaqo6Tbt69B7XWi5W5QbeSbUAMyDEgZkbEkM6u66YRG85x/T12copZ0KGStXKR
	yWcwoFHklRt65HVHeUkJNxQtBJtyhUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-VcVhfVLBNeuNbR4SpXFhrQ-1; Mon, 06 Jul 2026 11:00:48 -0400
X-MC-Unique: VcVhfVLBNeuNbR4SpXFhrQ-1
X-Mimecast-MFC-AGG-ID: VcVhfVLBNeuNbR4SpXFhrQ_1783350047
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493b786d550so33674245e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 08:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350047; x=1783954847;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWPAPea/4nYf8fBZI2bdCug+P82JPz4RYQoXBwMUFNk=;
        b=nC9r4Xtpf750xfS8d3z40f+xqdoMnv3CuD/sA3ZvBDfJwZ5k+aDgPjN1kCuhu6kUPr
         QjNOpHZo8dEOGC21Ib0y/iGDV1Az75KIiVc+Mb6xnLNpSzu59M+BkWVLjKGgzGm1Wmao
         gB/hmqRmr2nuhQUVHm83gt7ZET1N7/pm9XIoWaMIQn7D+NIt18ELMRuYDoQIiGJtkJqn
         +826nm65OLRojWbJkwdZo/mFy6d/bOYQcwAxd9r7UsZrjrSLvnWAtOx8er0i5qmfLbqT
         VArK5TRPPNARuTKCjSqKf3EnB3qmHRqCiX8cPbS3/2s4V5pqljko2nEEU/i3wIt/vvEE
         comw==
X-Forwarded-Encrypted: i=1; AHgh+RrzcLO/v1GmV2sTOtQTtCW0hAf8KRuDbSMZ5h484OraCm+Qs5B947XHI1v5JUeRJL8L3ggdJdAJ3ryf0Bv0pU7odi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZ7mjhuRiBGEdtkzca3rf59aC/J/LOKWqlINQkiM8oUZGnK4p
	yQ7Xu4pLXi5LqITHF+JbDQWb/yOvURi7vr3Rd7GrOmE+U83hzpzt6zLJs/OPOMiUn/pXLce9cls
	TMobAJl1YaiOt84jyqlIcLocHheVLxF9iB+A1Oa+78zXy3ftOyRgS0mNMWIR7BZPF7/doTJSPKg
	==
X-Gm-Gg: AfdE7ckJiRo6LFZQrBd4LzyDP1Y+1hYZ6yn5GwBig+Np7uQF23pK4lhhEe5746WGOjZ
	sTJ0IOqxlEFD6IMqOW4M/sWHU/GYtyjZFbKe3cQ8R/EXxra5gZI5mWV/AQoXBMwqdVITn2/eNmw
	rH+ITvVaSSpps9GqDzgk099DNDD1T1zN83ZVv0Z7ADTq5Dq8+85Ef5yZ3gQyRVlmKg1+O94c2gk
	eyYIsG0pELyAY46tKQnO/LFb/kPK++WwU0UU0a0mwarYbuAvzrJojNV9na+1az2CgI7DxMEovWb
	xR6B8ouK2Fl9+fQfaqVQfyX9o/ZhNcY2d9sHyD/zecul1oL0/mzgx6yMGNd4GGx45knldvyicxA
	wswDxPoyL2F1QQm2lpGXUpvjJmihul5hh374UrWHtkcu0Pk2qzFOn+gaExw5jJv3fbNK7cp1Y/c
	0d0mYH
X-Received: by 2002:a05:600c:848d:b0:493:adc3:cced with SMTP id 5b1f17b1804b1-493df0b4e28mr10439535e9.34.1783350047241;
        Mon, 06 Jul 2026 08:00:47 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:493:adc3:cced with SMTP id 5b1f17b1804b1-493df0b4e28mr10439015e9.34.1783350046859;
        Mon, 06 Jul 2026 08:00:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm641026435e9.0.2026.07.06.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:00:46 -0700 (PDT)
Message-ID: <c8c7568dd9293b0a718584c1aa193692c128d77d.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv/reactors: add KUnit tests for reactor_panic
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Jul 2026 17:00:44 +0200
In-Reply-To: <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
	 <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: 3kY9PWnLzk7ygYa8ycARtVyTQFmvYOFN4dAYUxrvetI_1783350047
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-06-16 at 00:44 +0800, wen.yang@linux.dev wrote:
> +/*
> + * Test 2: panic notifier chain is reachable.
> + *
> + * vpanic() calls atomic_notifier_call_chain(&panic_notifier_list, ...).
> + * Drive the chain directly to verify panic notifiers receive the
> notification =E2=80=94
> + * the observable side-effect of reactor_panic without halting the syste=
m.
> + */
> +static void test_panic_notifier_called(struct kunit *test)
> +{
> +=09atomic_notifier_chain_register(&panic_notifier_list, &mock_panic_nb);
> +=09atomic_notifier_call_chain(&panic_notifier_list, 0,
> +=09=09=09=09=C2=A0=C2=A0 "panic violation message");
> +=09atomic_notifier_chain_unregister(&panic_notifier_list,
> &mock_panic_nb);

I just realised this isn't even testing the reactor, it's testing the
notifier_chain thing, I don't think we really need this here or am I missin=
g
something?

Thanks,
Gabriele

> +
> +=09KUNIT_EXPECT_TRUE(test, panic_test_state.notifier_called);
> +}
> +
> +static struct kunit_case reactor_panic_kunit_cases[] =3D {
> +=09KUNIT_CASE(test_panic_register_unregister),
> +=09KUNIT_CASE(test_panic_notifier_called),
> +=09{}
> +};
> +
> +static struct kunit_suite reactor_panic_kunit_suite =3D {
> +=09.name=09=09=3D "rv_reactor_panic",
> +=09.init=09=09=3D reactor_panic_kunit_init,
> +=09.test_cases=09=3D reactor_panic_kunit_cases,
> +};
> +
> +kunit_test_suite(reactor_panic_kunit_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for reactor_panic");

