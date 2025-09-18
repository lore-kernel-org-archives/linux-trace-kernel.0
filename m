Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0E2EBDE6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184589; cv=none; b=uESceBv2gCorLVAKH5u3xN2kB6BiQRR6T5TTysOhGUcOHLw9LLOSLq3pyp8+c4XET7lfOHs9qmvIWu6YEebB2R2wfyUfG/Xkj1G7YRog1RfCqGzRJfZ2gtTQfbCTm5kfxMuDLfolB+RhS4D0hj9UUwebVMULvj3Zxmse7wYtnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184589; c=relaxed/simple;
	bh=Rlr84JJZ62/Nuxw2Fu9RYG036Nc+e4UQUaz7yZ8stIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGZb0Dq5+XmeCyI3J8ZC8Ltu77P4dPHyAFO25osNAuZqbWm3SKoDbdOpX1+QXwdrICM4Zbw1w2CevEfRC+S7wXZAAQdaCuyFGNq15iORDx4arqRchNW/U2se6GAGG4YJkkbyP6pHx8j2+dAYrQywBmQU7TixaSXZoN5Cpez3vMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpjCwDhA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpjCwDhA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758184586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rlr84JJZ62/Nuxw2Fu9RYG036Nc+e4UQUaz7yZ8stIA=;
	b=CpjCwDhAB9dnTSEcaVmvVVZqtT9zdsHAKLBnBFWBcNKpldrK8iJTJweW1CaBB/fVENK22S
	/MJgYHmKetg2r2JRrZoFXxqhSLoGeCwpbRjSqusQU/2hhF3VQfNAzDy+bsBfDwR+BAEJWM
	iKHS26dwuKP6CbzRJsV/Hiz40MYPfqg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-9YtjkweGMvmWOI5PMCHjkw-1; Thu, 18 Sep 2025 04:36:25 -0400
X-MC-Unique: 9YtjkweGMvmWOI5PMCHjkw-1
X-Mimecast-MFC-AGG-ID: 9YtjkweGMvmWOI5PMCHjkw_1758184584
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45cb612d362so3416175e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758184584; x=1758789384;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rlr84JJZ62/Nuxw2Fu9RYG036Nc+e4UQUaz7yZ8stIA=;
        b=XvaDQmHVIQBpxq8VMyFBWQA8nrXg8dVi8OG+PF20pSOWWjQb1wvvGTFYa2m5g1GIRe
         x4kywCPE5akI8Jj4SOT3gmuy/XwVEvRgZlI47uT+hnOFdSGSJinbCrLlKhaeMApENvkK
         NBGItHNeEQG3y0+0P9pIPsEerZgQ/aQZZEIr5IZiVNiB3eey7XxrwxkGV7/eurhvlzw7
         ntitkazGYIKdvfXUgzGzXI6+XCyksckDrBIxnsYGYFBnpEjhDloDb0gkCR5c+yLNyUSo
         dnN8zvyhavQy6z2tzz+9ERf+yl1eSOr7DTGigOVmZaOvuFeFZ8qvkWxBlPEJoj678dAD
         wVMw==
X-Gm-Message-State: AOJu0YyjsRqkNnw2SDZIWZL8nVpYvdlkCRLLem7GR+8mFUp/mJoxRXYq
	M6FuaEgWXgR+9Zgf2FwXIW9mek4ldemlPw/7urpN+wSFFT3q/EZERt9LENeKQrusnUyakXt/eZy
	TtnB1USIu0DjWxTuj368yfbg8AgA0Qzsr3VBUd24x2jZ7BC/x56LE9l08OWh37CyjmZhAJT5c+A
	==
X-Gm-Gg: ASbGnctNO6FLiyAF2UJU28K9W31TD7v/d21Nk0WfSHuo5zGPRorG/L1bFvKukCa3vuU
	+jtWdLqh9zdvujGYDqc5+ACW5C1hEWtUTwEJTkXtpjzzADxkuSfEbdD4R6RJIeJ7GyilDcHsrkz
	+uENHynIr+WblDPeL7ujrQM16qcGX5wrUuOAVDyXCj/TX/dGOokQjhf50ODIDME9IsLZwr/8AJh
	ZdWd14zX2xRwABTsBXbDgqymwW2NdeDe9u16xUgyDi1f5KCCzs+V9RRoE/aR8dpcjoya/Cxzd9F
	n+V5laXiI4gQbFQ5LUy1AnsYnH/v9dA+ivIFLXOdTeHY+mjvBuZMcfzzH8csDuz3uA==
X-Received: by 2002:a05:600c:3509:b0:45f:28d5:fae with SMTP id 5b1f17b1804b1-46201f8a95fmr49233335e9.4.1758184584243;
        Thu, 18 Sep 2025 01:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJwQaWps09FUQbRplYlP73A3sT975M4X7bZCBgs52Sypt9AWp9lkzJwtUN7xK6hJS/87aSuw==
X-Received: by 2002:a05:600c:3509:b0:45f:28d5:fae with SMTP id 5b1f17b1804b1-46201f8a95fmr49233045e9.4.1758184583853;
        Thu, 18 Sep 2025 01:36:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325cec0fsm57279915e9.4.2025.09.18.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:36:23 -0700 (PDT)
Message-ID: <4e8bae6a0ada1d52893381e7542220973f0367fb.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nicolas.bouchinet@oss.cyber.gouv.fr, Xiu Jianfeng
 <xiujianfeng@huaweicloud.com>, 	rostedt@goodmis.org, mhiramat@kernel.org
Date: Thu, 18 Sep 2025 10:36:21 +0200
In-Reply-To: <87wm5x18bf.fsf@yellow.woof>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
	 <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
	 <87wm5x18bf.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: kE2HOxY4NOkWJ5ROr6H9uG3rt4DmT8Px4TSacXqqbbY_1758184584
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-09-17 at 16:07 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > On Wed, 2025-09-17 at 12:57 +0000, Xiu Jianfeng wrote:
> > > From: Xiu Jianfeng <xiujianfeng@huawei.com>
> > >=20
> > > When booting kernel with lockdown=3Dconfidentiality parameter, the
> > > system will hang at rv_register_reactor() due to waiting for
> > > rv_interface_lock, as shown in the following log,
> > >=20
> >=20
> > Thanks for finding this, the problem was already fixed in [1],
> > which is on its way to getting merged.
> >=20
> > [1] -
> > https://lore.kernel.org/all/20250903065112.1878330-1-zhen.ni@easystack.=
cn
>=20
> Yeah, but it is interesting that this is causing real boot problem. I
> thought that commit merely fixes a theoretical bug. I guess this is
> an even stronger motivation to use lock guards.

Yeah totally, I have the feeling that with the kernel there's no such a
thing as a "theoretical bug", kinda like a good consequence of Murphy's
Law.

But I agree, that's something we may want to do sooner than later.
I'm currently not refactoring the RV core so I won't be touching that
for a while, but any patch is more than welcome!

Gabriele

