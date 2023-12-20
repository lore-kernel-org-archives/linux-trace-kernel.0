Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB9210F8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLsOLMp6"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f0d22e4faso40027156d6.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703070308; x=1703675108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRuOb3thPKxS5ftTwWuPZVBwpG9dfs4GXpoJ1hD7vC0=;
        b=ZLsOLMp6hN5xMThNv+as6Ms91ht4Hg8idXzILP4u9tIFPo+5rHRXxllusclBYIXajE
         Taub7AAXqVnoQI3f+fLXz1Gp0AxFveNNF0bNkr8eTL/zMqrVufk8w5ZNjCo+t1tZ8qv8
         t8z5nthKMJW+gMkBUyv+fkxw3IDtvvaXbfvz6qO0TtjPZ/NLkiMZzcomXP3VmwV5CiRQ
         UTKG35J2uNwTtYgyXGpycBAz1Ubbiix2cIl1KNmNuETV61LRgb3U//dbRzVATravzLY2
         7cwjvRQh5zkoshl6AuNy4Yj/qGDO3V1Z+x9I8CvRuIbJouB2zBFCjxFaSRojVcxHE5UK
         ufRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070308; x=1703675108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRuOb3thPKxS5ftTwWuPZVBwpG9dfs4GXpoJ1hD7vC0=;
        b=JJ1f7fCObsLhL3QDWAQZ/CI8UsG3qG4uzcdVJ0yHh36yKgs9StpwBd5zYL94wlQMIo
         QmMDcdI1TJkjMwLhpCWbfKRdX7HcqQQO3JorHPFYwEUHvJ1tONx/5f1NiVHcDBhwkHx7
         Q0gSHZoU6U54lqLRxhEqmLojgEPQ1Ou8kQQPLcD94oQdSdr15VYrM0j2r2il3eEX+Okg
         WVOLDDU6aKcdfQ20U3OfX6EvQ8BZ7Bv8QZzDrlybW6oKccBriGNv2fNuoEZTy5FYBfv8
         JaVKc5niQKZZfy3CeO48G9KCIWC3y7OLuu3GKGZ6iCzf3Jg85zU20man0WgBWmaDWod6
         zUvA==
X-Gm-Message-State: AOJu0YysMgnWeBgEH7RrNhsnxs+6Tgkm19vbSqbtroXOawCBtMED9oPf
	1Qhoa8qgANWYHqZeWKrC3NFD07fNMqINQ3g6Q2E8qg==
X-Google-Smtp-Source: AGHT+IGM1DvhNsHIpLRzl7TLlRhf+sSCR6McpSC15tKPCcbFJwj7U8mFeDmNKOAesBXFyLQOLaIWCh6aAZXNFJ7pswI=
X-Received: by 2002:ad4:5dca:0:b0:67f:143d:b8ca with SMTP id
 m10-20020ad45dca000000b0067f143db8camr12635720qvh.44.1703070308403; Wed, 20
 Dec 2023 03:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213233605.661251-1-iii@linux.ibm.com> <20231213233605.661251-25-iii@linux.ibm.com>
In-Reply-To: <20231213233605.661251-25-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Dec 2023 12:04:28 +0100
Message-ID: <CAG_fn=X_MejbvJRG7qYih+qrL6D0hrJW7czfAJbOdY5ES4JyiA@mail.gmail.com>
Subject: Re: [PATCH v3 24/34] s390/cpumf: Unpoison STCCTM output buffer
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

On Thu, Dec 14, 2023 at 12:37=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> stcctm() uses the "Q" constraint for dest, therefore KMSAN does not
> understand that it fills multiple doublewords pointed to by dest, not
> just one. This results in false positives.
>
> Unpoison the whole dest manually with kmsan_unpoison_memory().
>
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
