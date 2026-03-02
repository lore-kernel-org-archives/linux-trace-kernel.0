Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB454A13BF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483320; cv=pass; b=jNjzKqFRpUIWPFXqr5ESNHrQNsTb1mQVF5c/YYfAj76fBhsu81LWZroLPsSJ1Kv6OkOyY8wwv01dmFgJPIEZcdqs7EAshQ3rVq4QE9TDKrK11sUyZVE14zXJG9BjKIwOnNGeD81JQfzmtK1JZQJdtVQf73ClQTWq0agO3yFGdDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483320; c=relaxed/simple;
	bh=xcLeKxJcbIzTqj/N2zI1Wj83EQurlJMimD7K1I1wg5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkYQJV8GtLPHgxlfrE7kibDRJkOec8P95Gh4MjpQEMW4Rfnm++9wgfctcDv8T7kWWfTbXs7ucVdzgpKqzbbDvBmXfJQjUiT8gbh3nzyQ08I4kWBCc5uBdw0BLkcsxHZDzfAc7DwqbGKUk1/uyYhrwGxKAtxGHm5mQf/YhaVBrPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiDc1vEt; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiDc1vEt"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-386fb2c31e2so85728931fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 12:28:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772483317; cv=none;
        d=google.com; s=arc-20240605;
        b=XRCZA5ZpPrV6auCBLhuxuxJfoDn2sshgsjVVB8A5VP4mCfI/oLUZlCKggWf3y8DWNU
         5VJr5hdwj8ABMH5/V6n5lyd78Ip8MUiDq2IMaKwV77plNlr49ptgrtUlCctJu9D4PbMp
         g/CRJQ06If6j1Am1iYNLqZfaNaaRe+lOTBdUhWd/TlKt7BhZp19hE5sdz8C0DMpwaHMH
         DkM2nbo9cY8fuOZ+QnuMTIHFmKYWmoM/nWeSuFWQ+laPOLM0nG0hmE2/zNhU/gKfGm/f
         QXJR+y6IERUMnwsy22kUnhEL2Dsjy/3KxcE+dfFQ8bOnNDg+FYszkt5sh60UzniElNy9
         O/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cy1Nwb53qJSiFJvxOZ86G+ObjYxLuYx8l1yPKp3EqhM=;
        fh=pAYvXZFveecy9oyCMAi32vmpESj3TbFyVxH21imrNyM=;
        b=WBIySYhnk9c0IwQst2QODQ5x5hGk/71DonjerJ5rOQm8q5jSpyyR5/GZ1edpWt9b7U
         f0MAQtVVk0BTEvr+W14tIQpD3lbxD6kLDvaTC1WWurlLpAt/9dhPmAmqhxNmG94X80vL
         hgaaoJCUvW3m2VIFkeeN3rlViss2FjRCjHPzxZs7g+WT9cNKEB/RwO7q4X08PZgapL5h
         OgCquzppKyAMMGkLSl/Q2iC+Gl2PWEWraSq6bmR3jw4qo3ESfaqWbeSg1s186isJLY3b
         RKbLB3KKb9EKLXk1H/eaoTXA3X2bR7s/oU+oeSs7xPpTs27oQByYWSu/nRsl6/2Ch3ZX
         JlvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772483317; x=1773088117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy1Nwb53qJSiFJvxOZ86G+ObjYxLuYx8l1yPKp3EqhM=;
        b=hiDc1vEtpVMYvmlbweTtixPny5qSsxVurarrAsBYdJ507NoWcjNCtUrHd2sqCejtd2
         lp9hP+YyBs7n2v3Jn3YYI1+Kqh5jN9WknstuvEThAxJAaURS18VrtfHd3rtcCoHSc+5g
         +9L3Kq9cQT1Lx1D2jYcibdqWkoiCkseWiBC799fZ+CCU+TecHvsmTt0YhK3ltzrZeDob
         X2dUtZG5HiQv2X8XE704I+0+44WNjwDkInTro3uCQE8ms+5joiIQ0nGNIUQRn8CV7y1Z
         a1HuLKqU0AN3nAyNH71xFJPoXMVAS/wyWWcMyqAVraOUZD9al4gGWE+U2CJkgeIuJSaX
         FKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772483317; x=1773088117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cy1Nwb53qJSiFJvxOZ86G+ObjYxLuYx8l1yPKp3EqhM=;
        b=XqRUkAcSUiRIIugjB5Mo49OxRx9FxmAiQ4RQqUA8q1DFfSc1cZ9caENK7Jc6cFPXae
         i6UccvNaKzmWbg6C+Y/DcyyZUhqYfFpNR+skJt0/OrYHZEF83DkFMI0AY5EerQsYs1cc
         4GBKz3XvTPsPWIjIq9O7yrDeHzE0fxWQjhqdktmTUwratGrfxmWJHc1HlkW1bORRPuJT
         eWK/UEUkMGjRLsbWMNKMHU5T62m0UtzhZxYcSXd3HLasRFOWqYsBDRmRXPjou6NVqJgw
         iflkktEpq78VCjftxSOz7SfFpfjcsYXBKfCacFoa6hz+QbQ53R0tegj14nDuFAat2whE
         7X9w==
X-Forwarded-Encrypted: i=1; AJvYcCUP14Ldl28XWutW0C845oZIWULFYAOEr3wDD52BIuWWqv6mbKoqaOaQc6UEA1FNljSTaL7Xzbv1jVj+8qXhgfxtsRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQgkp8E29z0vcdz6FVcYlevCLt7shMq36OikhPSrxtONHv4NG
	gsL2iLMnsYnsKU4RcwovI3C5w4+FhtibQzehSppY/lSjAzsE9qZXuMjoNSz4jh0Dch19ejaPU7H
	QPwGux3qfDIIC4X3Y2HZnL2/few04tuUO4L/2GmI=
X-Gm-Gg: ATEYQzxxk6IEOuLUMkeGSPBwmNe/dGmm4FTpDPq31OkhzRGSrxVnaPOuPs5LDzo0sa7
	TOizSMABg/uQ4/Ws98rIbfIfEdFVZXNfvCgNgRW28ZcVh7SpH+xGiGn4JBErW0hd3ZNZ9tbTEeJ
	h1z1v7U36Z3jITvgBurQIKm/8QXNKZ9PAQiP4IWIsAPcYRfjJYeMfCH4kYU1juwn2aFfmllPPR/
	qYHfYd69V1SWMKoHWXqCSgkB4cteuxX7AcRfrCwPYzCS9RutgnS7TzGJatWdFvECfj+9Ov1RjRJ
	KVm2uJP6/R14QeK8Ces=
X-Received: by 2002:a2e:a884:0:b0:386:4776:2a04 with SMTP id
 38308e7fff4ca-389ff144dc0mr91349331fa.16.1772483316631; Mon, 02 Mar 2026
 12:28:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXtAv3u1hgLkBEbEgR3=r_iz3=KrnHB8B-=tg8Q3CEOWAPFiA@mail.gmail.com>
 <05e134d8-f600-4ee6-9ce5-4b2ef199b075@kernel.org>
In-Reply-To: <05e134d8-f600-4ee6-9ce5-4b2ef199b075@kernel.org>
From: Andre Ramos <acastroramos1987@gmail.com>
Date: Mon, 2 Mar 2026 17:28:24 -0300
X-Gm-Features: AaiRm50-wwZDnrdnRB_L5wVboZlzOioJZN31aY0zHl_4JPkDe7dIUnTDL8NUd6E
Message-ID: <CALXtAv1j_6T-Pa6yML41YoAJUGykMxKjMBtLAVGFD0TOOz7U4A@mail.gmail.com>
Subject: Re: [PATCH] mm: add Adaptive Memory Pressure Signaling (AMPRESS)
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 02:00:00PM +0100, David Hildenbrand wrote:
  > Which value does exposing requested_kb really have if there are
  > multiply subscribers to notify? Doesn't quite make sense to even
  > expose that.

  You're right, that's a real design flaw. With N subscribers each
  independently acting on requested_kb, the aggregate reclaim is
  unbounded. The field would need to be either dropped or replaced
  with a hint that scales with subscriber count =E2=80=94 neither of which
  was thought through here.

  > If apps have droppable caches, a better solution might be to use
  > something like MAP_DROPPABLE where possible, still leaving the
  > kernel in charge of when and how much memory to reclaim.

  That's a much cleaner approach. I'll look into MAP_DROPPABLE.
  Thank you for the pointer.

  Andr=C3=A9
