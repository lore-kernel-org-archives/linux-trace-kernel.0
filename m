Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D527617BB1F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871386; cv=none; b=Oc7Dn5JHlL+td6Y0nfwll7JVNWRfZnhU1BudOvLqV3c5Xrs52LaiYWNSB7JU6P3NV1ChJVYrT4xsqJH/tX/oCzbCQIwH6NaAowvM9l0c0AmkeCVSO2+t+Cfsy2/hw2bPRPaUHOZBsvBQFfQZCBc2LVHKPSSD09juYHmzebSB6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871386; c=relaxed/simple;
	bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4HEgXfDiTbe7IF5hXTai2hixyb8NKH5rSOKtmxgeiGhZySsoJJ4M889GXpRjs7mMtl9XurWK4UuDxTIhYaXshEdef/K17zIDlvRpo0mRkwVj08PBz2plMydEirfmE0tzOHvLOM6dP6xgp0C/0H3BM1BIP8RpV/yzPzsUCyX/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2iSSOuOA; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2iSSOuOA"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-795482e114cso50474385a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718871383; x=1719476183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
        b=2iSSOuOAH3soyq+uvu7LCrAOdIcXdgkvo1xwzMtJW0z+FjyOhO9zR0q5nlgUCxTs0C
         Oh8QB4Kgs9qJFJCVPqSuUljttuW5QaPe8SqOHsj4r87kWfMFtB+kSRpl66TT8q/RDPm4
         /mFqLJ+HxAjmMvT28ONTxe2XpRuKDImlJKTfVQWepoMrG9Wc3ZbGt+xvuzWfbO6D575H
         L83NZlTHRRzamKaEq0Fi7F2fSFuFvXnTzxNbn7sJnSdSt9WOeO4JUQt3f1utCEHMB2lS
         9rzPsLwcDsylmMiVceraGj94uknu3PYN1SePqlVzrKjZwfwMpU4ql5OKGZmfUexWgn10
         +hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871383; x=1719476183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dft9k4QwVExtZF9VSHXeFnA6FpkqOsI1kNGDVc3SntM=;
        b=HOnUvIBwSecTbTnVLBWZE20gSg7srrPT+mDN+l2jDFyMae61wKOm90+V2a0C39+NSJ
         L3SkvvPCP3bweOEAAQXXNON/8ZTXUXXYyMekJenvsT2LQmxzuIKh13BVf1DtxJTxr6o+
         tEdZJXeyli881NmVXzHFCZLy0a1R2I87kW7Ow99kBCb8+pcWxcfhQ/G266gzMf4/C1PB
         JtXuvR/L01f1GJ2aESbpVDbMjMRNeg3yy40Ku1T+vSK/gd52JS2hXCdLMI/v1c8D0tiA
         8JZ7axOdA0+UKKVkPJpY4zsA+k/dHM4iwI+cb+/kMX85YelRX1bt0E7GhaRVGJDg+mMK
         wclQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlH2HqlueJvWV2jfcwSETKDISavoDC/eBjyhQnq8a8mdewXeotmF6Ya/Mmt9HzD5ppC/61DpmTi8H/0YRSwHmoGCPrXpepG6goldLUzpN64DqN
X-Gm-Message-State: AOJu0YzYyFMvK2siNqY+jgLAbItVoM0JYQqKGGWdstEQ6QDtXLmvhXLh
	tklJ1Msbq27wkgH1hBRFb2DpfwUjjJr5fU0gsYu3VemSNJObVj3E2rjT96sa97M/2JYVAd0lwh0
	XR5wa5CYO3LVfgZQyukadve8nKXdJo+Au8E07
X-Google-Smtp-Source: AGHT+IE5Z0Cd5ZP1M5xJnwi7ge1Xv70m2SCP04JaV06E3n16w03DHPIGim1lZXVI8vYMw81NuCMEEgRnPM+mT8nDGyU=
X-Received: by 2002:a0c:ea85:0:b0:6b4:f980:9f2b with SMTP id
 6a1803df08f44-6b501e2487fmr52257526d6.15.1718871383512; Thu, 20 Jun 2024
 01:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-35-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-35-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:15:46 +0200
Message-ID: <CAG_fn=VfeugzYZ05O-XCo5GJA9m2S76VrwS7yc3uPYM6zUpKXQ@mail.gmail.com>
Subject: Re: [PATCH v5 34/37] s390/uaccess: Add the missing
 linux/instrumented.h #include
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> uaccess.h uses instrument_get_user() and instrument_put_user(), which
> are defined in linux/instrumented.h. Currently we get this header from
> somewhere else by accident; prefer to be explicit about it and include
> it directly.
>
> Suggested-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
