Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05624C0431
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336674; cv=none; b=iWo1rf+Y42UP4zIGRqcV9Sugr4uOu82MVpO5TpsF+vylB1orz8iYeCtErSSongC3yEIbU3JGY4ZjfJbnJHz/vOCK/TtAElY4dKap/9s/z2gJX/d3hz3JhjvcB8olyNqRZaZ+U1ka8wsAgQa/s1v7LdmL/PTI5WCNFoBhe+N+wm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336674; c=relaxed/simple;
	bh=kSvkCUdzOU4y6Z/U3RtuFqdEwxLpWtZD30RELNFIgcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IA+Fi4VxIGotR+F25Ma5lMOEvbBJO1C0gNbwmOWLw8meozGBglevK0F3/um5eLgnbhlX+enOoMCQPdmyKUfc02w1GOobGAnVwvFcR/08HMnOf/zrbvk3tJRkrYtc8BvHn6NnVAicaS75IGC41nQkAeT2SCUNtXu7fpTSn+DWpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRxfCTp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRxfCTp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785336668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSvkCUdzOU4y6Z/U3RtuFqdEwxLpWtZD30RELNFIgcM=;
	b=gRxfCTp64XU5byWdrM1ItNNDEphIudeks6CuTTOEki0zQx7rHFuUAiLMectgNFrqySzyvA
	XvTFk78vkby2BYTExsvM7afN+M2Ei94rWGrWb94o046kqwzJB7RGr/ajeDbhQUfm6YXuwm
	+EqSR96IR7NdS7ATp+3n06H/658qIGU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-C159r7ScNx-RdzfbMcU82w-1; Wed, 29 Jul 2026 10:51:04 -0400
X-MC-Unique: C159r7ScNx-RdzfbMcU82w-1
X-Mimecast-MFC-AGG-ID: C159r7ScNx-RdzfbMcU82w_1785336663
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15cec1ccb6so114688166b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 07:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336663; x=1785941463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSvkCUdzOU4y6Z/U3RtuFqdEwxLpWtZD30RELNFIgcM=;
        b=rkotDwS+Ys3HQU6baAqVXv90Qop+rykp0X49YeIS6W4lpj6WNkUE9m04TtNV/RKLha
         FaARtScTgNMr9oYSmudcFzDdxMKIqKVUtS4ftCbAjFvickqPEW8RKYLVHXmnerTmzNdq
         R8P4Zt8AIBJXyT0Tq7yUxiH1gF+Tlc6Y9yLJiBroX2iERFBU1O8elE6SkBsJNqrsRF/v
         3gpVqpY6KTMbGCkTgNwTahMTOxphJlkUhERjrNk1mPot4gZ+qyqra9qodB5QZXfWDqns
         QIKimRg306mfmkwuimYNKfm2av7j08AdUtH5npCGEVwFTQrPLmUr5IYwCungLI8h2VZm
         i2Fw==
X-Forwarded-Encrypted: i=1; AHgh+RpyjOVlQ+3yoAp5YNHEBO6PN6dVgk6sDqHkN34c/4yIPgbeltpj53k8GyX871xoCU8uLNCimbwFqQ0v5AXuBBmb/0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWJv0YVpXG3BPnpwa5TCGyY27J8u/5tWDmZ2e+gbbO49nDAcH
	Bv5K2Swu5Orevi0FtE7SlrZnmFOkAJyGI6eVYJ8PyvU8+xhqoJxOkLt2QIQ1qSWnUZCv0H3+D9D
	FnPhNSZ1gsiqXyQyefIh1dx+vdNaeNh+/WgpWR78qhqXw/yT1chFdIubkTv4+JTurTaOUNMIC6d
	80IgswgxSOk8vZJREJicIcl8QohUtRlfdXlSF2oR54vii78Lrx
X-Gm-Gg: AR+sD13QMcY0idF2yuCD5o42AzNDRS/zl4OWWT1V0Oql1OZQXaWLkaIhKBVevPrH0KM
	TKW53xSNjEY/CzHyZqZ78ZS6KTm14jcx2sBDF66b8b65LpcP9Wa3Nll6fRA46HpX02kbtmOEPkX
	8KQ0UTeoS1ZANDcH9MSH7NvtYvNRw4MNUUEZFynAyLTHqN4BFi8snQ5cLC9y/fsK3wunqKWBAps
	AqjAv9AwJXqsPyqADzjgD4QGbug//8NUkcGPeGha0FzoCk=
X-Received: by 2002:a17:906:ee8e:b0:c15:9709:fb9b with SMTP id a640c23a62f3a-c1f721721d9mr400206366b.44.1785336663141;
        Wed, 29 Jul 2026 07:51:03 -0700 (PDT)
X-Received: by 2002:a17:906:ee8e:b0:c15:9709:fb9b with SMTP id
 a640c23a62f3a-c1f721721d9mr400202766b.44.1785336662594; Wed, 29 Jul 2026
 07:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724170132.3783816-1-murp@redhat.com> <20260724172024.0648C1F000E9@smtp.kernel.org>
 <CALYDSrQhUbKDHsPnQqp0K4WMe2iZC-G1nGrLT6eQ9doCqdVXKQ@mail.gmail.com>
 <CANiq72nJ=7TAjtArF2VzDZqwKDcuMFjeisD25R2GuA0NiJwk-Q@mail.gmail.com> <ttiwqgc@ub.hpns>
In-Reply-To: <ttiwqgc@ub.hpns>
From: Paul Murphy <paumurph@redhat.com>
Date: Wed, 29 Jul 2026 09:50:51 -0500
X-Gm-Features: AUfX_myhMuZmpek9DD990HKFWALYcBn_pw4bUkQiobwgWdJq2-vFJFMPfLONtM8
Message-ID: <CALYDSrQ=d3Y6yOt99rOnw6dDonf-4M=yY=gCP0cAuu99bpzdsg@mail.gmail.com>
Subject: Re: [PATCH] rust: enable fentry support
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, sashiko-reviews@lists.linux.dev, 
	Paul Murphy <murp@redhat.com>, ojeda@kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-trace-kernel@vger.kernel.org, Jan Polensky <japo@linux.ibm.com>, 
	Eddy Stefes <eddy@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gzNvtN4wTECBJNQ96ZObcUSh_ein-ctViLdaUwT58wk_1785336663
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 5:58=E2=80=AFPM Vasily Gorbik <gor@linux.ibm.com> w=
rote:

> So I do not think -mrecord-mcount Rust support is only needed for
> s390. The Rust build path needs an equivalent of -mrecord-mcount when
> FTRACE_MCOUNT_USE_CC is selected. And additionally an equivalent of
> -mnop-mcount for s390 (this is debatable, we could check if this brings
> us much or we could drop it).

Right, as background, the llvm x86 maintainer were uninterested in
supporting these options [1] when I created the PR. I think the
argument is roughly that these options are bespoke features for
building this project. mrecordmcount already does that, independent of
the compiler. I think some llvm maintainers hold the opinion that
patchable-function-entries is already a sufficient replacement for
fentry.

Digging through commit history, the answer is unsurprisingly that
using recordmcount is slower. It's certainly more convenient to have
the compiler record them.

[1] https://github.com/llvm/llvm-project/pull/184641

