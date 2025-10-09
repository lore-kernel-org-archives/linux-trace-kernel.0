Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A02EB5CF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021173; cv=none; b=ojg/PmxtJ5Bws4j5li5i9Y7JCZD97BVOIIvHlOf1rlVQQ+zHylJaVufHQ+NNjKKF6ThSX/7xhJVRI/PhxjfdqLDEiwmbXRH0ant+DzlBX8kSGIAlt8jF+eVPetHPMCPNCYmmLMAmTz0D4aaBckSvZRXkHZpPGBevbwUTCSjT9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021173; c=relaxed/simple;
	bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu0lmnPYPMtoN3+PgBhJ91gf7O4vPFDZX4J1tGp2lVgskdrXDJEzy8zpmXgpKMUoOw8AtORS+y2KJCPBS5RBtkpxPi1rsyycciiaDN1fN6On6Bm84727OfIZJ78IZZj03QhxJHskvh/nJ6FvzOEWoxqanL9l/VRIe5pu2aezPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/skoLTt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/skoLTt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1116314f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760021170; x=1760625970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
        b=l/skoLTtsSA/UucDQVOiNHWgsEYQRCcS8ZWkc1mASOSqv71aYtwFAo6ksTccoWzYug
         amOJ1P/8mPT4NyxzR+gFcl8iqWBPsb6zDsNDOB+nKSoSLuu46i/FKa+M3Hx8eSc1AT+4
         ilRN2Zl4DapRlxp8w9Sp0fRsuf7gnEddd893M38CXJs4Jv4QzOP+5vG1ELbSepxF30nM
         7jmTEnGX7MwTA/03p/IRive3bLnAKvwF++uv9k/p9b1yK3Bk0S2OT39SzpMywoq956G/
         TfN4GFfC/3AWg3AU3QSdrl/XCYKSog+STmZWpEajdH5E7lFh+FwgfjoAd8yW499Xifjb
         LZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760021170; x=1760625970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YF/kfrhlYkqcLi1GXYGGuwKlO6FjjUxn/YQCxguAYc=;
        b=ULBZwjnzeEkZurPCMaCqvtA7JLHDKTYA3yhfzyb6IbaqAu7MjztqwCQz20pNwZyq8G
         w6kSX7tEZGnc+TmNZ22vadyOb6KGDdtuPObDzWDLEzV6V/cmqfvC0OUZ7pRtmFJzrW7H
         RikjBeAqyLcuHDVE4Am/mYzLxYvR8UturPyw5YcgdcRn+netgMHGkPoVfevR3mc8BWwo
         17bIFzZ+U4pq6Uvd2HHQhocIQGlS67dmphzLQ6rkGHl4b9zQPnl5QwJxTzyx8m4scrgN
         5AWrardQGyVwKtLFAeLqXFVDmlAHXnEju2Wlg1avmkst85G+Dxyzudd+HCybBj8Tdxyo
         KcwA==
X-Forwarded-Encrypted: i=1; AJvYcCU/D3kAVwa+3UCbsVOlytyGIF3nnT8jLjHiyhw1Or5N9vV2a8i0dFe9jZiUaOeCGqH63VI2iVPPQ3cLQUfjwpp7zXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/D6Gvw6GCoO3W2/njKuk4D7ycQd6q8dXC3Y3vxNYSTv8gxx5
	3KHXXS9zamZ7gBkFrDlsz0QMvS8uqEEZgZ9E4sI4K9NDDQLGfTXLsT6WhOJBwy8AdZQJ2cxN/SK
	eClTQsD+Ne4IXlFhRxNYC+8Fn3i1TvGM=
X-Gm-Gg: ASbGncvWgoPNryFIsAeLOnXES2BDJlNgBq4uvFdYqxpLnMCmO5tzCgu+mLi4+h8HUJk
	A50Tra2ghbfjU8t/yydmf69Zc+hcR9xlQgytm3gb9d5Kcew3T+VToXfZ7hShHKW527B9+7r4POM
	Z3dIssPD5jpuOTB3EQ/whGOPlce9h+D5O286L9PV7hteXVVXFOUviKw39BlZg7/dy8VmIQzAdgF
	s9Ivajwa8/FGhshZFgyv62Rcqx7TsnKieoagQYk0mahc8NtLneqFh826A6CxIxZuYJ90mso+aE=
X-Google-Smtp-Source: AGHT+IECWjhaZNmV1ojdHkxqbAFOmHEINNvUEgcQdI2hfmscAMsefgN2+U5CxgJIIoAua19jxGu56fLuuqU2fY9/gjg=
X-Received: by 2002:a05:6000:26cc:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-4266e8d9301mr5195008f8f.49.1760021169790; Thu, 09 Oct 2025
 07:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com> <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
In-Reply-To: <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Oct 2025 07:45:58 -0700
X-Gm-Features: AS18NWBEI8kqkZPKzG96GE2ZCLB20iemRBfaDjOtbeNUARLINqO3dUs7B56pY3o
Message-ID: <CAADnVQK8Rw19Z6ib0CfK0cMHUsYBuhEv8_464knZ4qFZ6Gfv2g@mail.gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:15=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
> The verifier can rewrite 'bpf_reg_aux()' into the following instructions:
>
> dst_reg =3D BPF_REG_AUX;
> BPF_REG_AUX =3D 0; /* clear BPF_REG_AUX */
>
> As for the architecture-specific implementation, BPF_REG_AUX can be
> mapped to an appropriate register per arch =E2=80=94 for example, r11 on =
x86_64.

it's taken. There are no free registers.
