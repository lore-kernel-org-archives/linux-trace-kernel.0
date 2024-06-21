Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CA16C856
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958128; cv=none; b=roBzThrdKgNCGcf/NIOhfw9AxcLABzSti2E6L81E6cFy7ds96M/RXhMSqQpQMJrumdkWif1EBrhehvoq1tuz34auQzYQAYHdF+gZIJKcSCyjs3HBmYgi6ka8hPKF3NvYSMseGr+kOIuawGnLfeCNh4JSPwVkJIZ5Vlo6EyXBHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958128; c=relaxed/simple;
	bh=GiWp0R3m1O2e8FqlZeCTxBARLk8raP5XQEmY3Orplv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFCmkkX/GEIpW4xNe8w82freBt0FUIogU+3ryA8PbBcABhQH3NKcMPpKbkWCSo0vWnz4v1taS51IZYgEtUpEqq8MLqrjM5nLm2QgBoxCmoV1ACK9hz8oZ7qsToG2ABrHmmUa6JgUW9cGuC7Q/pTUSTWgVO3Y04A6sGa5/PH3jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eG/NfN0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eG/NfN0"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b4fced5999so9153666d6.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718958126; x=1719562926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiWp0R3m1O2e8FqlZeCTxBARLk8raP5XQEmY3Orplv4=;
        b=1eG/NfN0jaGe3ZnPl3fgAgNp62mc8cly+lC3xeN+OUNj6yRKCxL9Ge17+X3kvTHSiT
         V+hiMSSzmNFvrdv165b2RPjJBuIcp5a+g5q+B9PLCNn5UKoGU7GR+mMZM6uPjPeAcOZ1
         LOAg1NdKjyjDDoBwxucx+4Rdz/L15A0eajmAWVzsQdxAAHuf6RNOnzlmAJ9TcTOiBxDt
         NwYGIJXA6dUiMVkALlpy+gbzoEpSlK1UUnPb4IpqmDL/dNov6khWdoR655Apnmb3qjrM
         rsp/XPaTl6WJ3jRykz4kpvZL5Mhr8WQLX81cEN37Oo34MdE7aMCQVdcYdmniima2ht7N
         +aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718958126; x=1719562926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiWp0R3m1O2e8FqlZeCTxBARLk8raP5XQEmY3Orplv4=;
        b=c3Tb5hGKwpFQuI2kPwXJEuisvyBSLBq2e+w7X3C87OZsVD7jnVYf6wBEK8VM7Tzrs4
         xuR0bj8wr/DZdbXYYe71S7JGuVqwSuTgirHR2BSiBvBgQJFvvTxwt1qL2kPm4FiOYThq
         jI69SJSxUleWRcLarUx+NeGDUeoRRU1JRBTsYFqnrcCC5biK91f+HT4GxzhSHcPA34qf
         AsIEed5d0Py+LmZOofKp6XWp+2GNcR/1OZuA8IeAq/Ab3YGVNa9GUz5irzctYdhIZZYT
         4JpOYcxxbDgFSRRuogmAdbVWeWBeLCXsAsULan81cHrgV8LUxmWOBUfdrLAtppSurHnz
         bX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ66OB0x3OYJDP7pdVNgb41WsExik+n93ofr13MwfcF99mZwnE4khzEmZ001/ufaJMyXFEsUR7Fsd8eYqkQa4dFmK5r6cq/ODg4dXv0/UC3cxM
X-Gm-Message-State: AOJu0YwUZq8d8bj4LbZbYEhcOdP5H4FDtmQZ/3p88EPo7KkI2JF9IFzg
	DMSyvN18Z3ZRoriPpe2u7FecBJAQjoqqptvK7d4PB0es+MsWrST0iBwnNIhqUXfaEOdUojCQIDY
	U97oLj7m8Lx0N1R8dGxrxzh0+gu/0iIL3uV6O
X-Google-Smtp-Source: AGHT+IEqLUO3OT9Bhboypnctwqc8Ohld/THbrsKqdROXjqX2LTf1GcH5jlfhi1RSDxSEenbd4gpWPErmzbl81ksieb4=
X-Received: by 2002:ad4:5842:0:b0:6b4:fe1a:9ea9 with SMTP id
 6a1803df08f44-6b501df8ce0mr76732636d6.6.1718958125525; Fri, 21 Jun 2024
 01:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621002616.40684-1-iii@linux.ibm.com> <20240621002616.40684-17-iii@linux.ibm.com>
In-Reply-To: <20240621002616.40684-17-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 21 Jun 2024 10:21:29 +0200
Message-ID: <CAG_fn=XKAdJ_VR8_fsOFSRqZxqGRB+GsHMMQjuy4gQGEGi9aDQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/39] kmsan: Expose KMSAN_WARN_ON()
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

On Fri, Jun 21, 2024 at 2:26=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> KMSAN_WARN_ON() is required for implementing s390-specific KMSAN
> functions, but right now it's available only to the KMSAN internal
> functions. Expose it to subsystems through <linux/kmsan.h>.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
