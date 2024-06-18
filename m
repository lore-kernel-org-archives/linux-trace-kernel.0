Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25241CE9E2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702828; cv=none; b=CrHnEqsuzSpANs+JKohmR3XSK7hCNOC6oQd0e5/1fPPa6vyHTjxgzzYA1BKUxrj4eifeHIYHmsjhPbEJ7Le3HOqeAhNXepd9Y9ARxpPhc3w1HmBw5rGRTvf2Wu/JqWLQaWfk2jiPI1Itz299sfKTOwPkZpDcBpmilNUdPh3Ik1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702828; c=relaxed/simple;
	bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfauTZTpHfH/JppjSfzt/TxC0Y3jOjkA5n6pXzXLT7Niro8Tb3/iR5X/i1HJVkIo7IgGtKIwBUqAfhPxylGOuGry8Kb6PZR+14Mf4BBDNf2D+el1667ydXV14/Cx/ovu5+2oVqXyl1FuXGZPC1o9sicYjCUgm7JTx8V8Dua/kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huOg/vor; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huOg/vor"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-795482e114cso441691185a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718702826; x=1719307626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
        b=huOg/vorR3YTqG+1X95HfNzG5wPbQpgY4knV5mwPbe1kboc6s+AHfXSs1xlxg2W83E
         FpMEpHhkgNDyzT32O6VQ5gpZBD0aKxREqcdEAct/EZjYR5nE5UljBprPHp25Yi3tTrTW
         vnT/WVX3E85rA0vD9A6Tg/5DWr7bNFmOaNDEOWR9gTdi8yOb0VQrLJYS5auDv2XmRRBF
         mjxeMe9IJm6uDBNq++N8DyqTArzbcT96DzV9dYoHiU/ilp8jEauFnPd0WCr0S0k7LZBC
         3Nt5kgY2pdkk//VimcM3MAiMIYz91h+6kqk0838u8yrJnijEAvYq3gqbAigOH40iRwXu
         w8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702826; x=1719307626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
        b=d2AC10nPzWsNWvmstg/j2nJhfe6tJaWpwFMjl6zoxuWWBDDJi16nxARt9lNdsZcbj/
         BFflC6pmghA5m7K0poZyJmrh/An7udcXtwyoqAD06IgrDnzbCWAmDi7Ay3g3Z3szoMsf
         WbNB17onasdveZK2a5SXHjoWX92scL1JxiDTq1r48SiojQL3BqywDmS+Av1U/m/FKtWw
         cHinLyeAf5mg7kdNBi89B9cmG17olliaqF0+TpcTnf9gmPu9GwWmO4cG/sDS2jeRs/Ul
         ti2Y8aBP9eyHZ93avmDotDCUhDORUmO3Uju3z4XNkj5rKCm7sQpAEZtaCpIoqOXnNGMH
         SSTA==
X-Forwarded-Encrypted: i=1; AJvYcCVB8kT7ZGemcz/sKyZ/a0pBIw3eeFIH1utgBXJT+gdnbBS0/e5aqwhRvEyoKxqUY47QXNkrRSz7OmuqstRP+EGq3zPDuf0jVwIg5oetW6tdwCdS
X-Gm-Message-State: AOJu0YyLqGcYa5Bv5AgE6aB89RFF1c3IMb3c1vntiE9L1gGguSwu5NWd
	f6Q3NAUawEixcrhfZ/Le2e87XQr5Dv4SJDfORXDCDMFB/29Jp0Ir/Wbbl1fd3DQlnqCXuCNRDuW
	/8YxVemCNVi7cz7WN0xPeeFzhLIoM3qFeQEs6
X-Google-Smtp-Source: AGHT+IE/yIrzcpOv3eiTPoXN3cwGJ3TQnnFMvA5d279z/tiAN3Xspn0UhsEikZvmg+vlTu/xFiTY3m/3H4pxUpWqwP4=
X-Received: by 2002:a05:6214:1249:b0:6b2:cf8b:21db with SMTP id
 6a1803df08f44-6b2cf8b2252mr79472176d6.53.1718702825469; Tue, 18 Jun 2024
 02:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-27-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-27-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 11:26:29 +0200
Message-ID: <CAG_fn=VVGwxBUH=3HrVHhNs6AQFMqFgw7JDLqUFBTv13FOd5cQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/35] s390/diag: Unpoison diag224() output buffer
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

On Thu, Jun 13, 2024 at 5:40=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Diagnose 224 stores 4k bytes, which currently cannot be deduced from
> the inline assembly constraints. This leads to KMSAN false positives.
>
> Fix the constraints by using a 4k-sized struct instead of a raw
> pointer. While at it, prettify them too.
>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
