Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzGZGL40"
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165C172B
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:49:32 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67ad277a06bso11754426d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702043371; x=1702648171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyp/ZFyiUOjenQgn6G8kYMLVmsBPMd5m8mXyGEY1Mx8=;
        b=HzGZGL40VCq48hRUv4ni/hFjp8bYozGF/tTJeOdjnidmwhiHA7c/5xRV5VmDuzdIAO
         nKXClPDibILMmg7YfybvldwgIRps0nw/vntbReb+zPihNUhm/90sSGnZbeN1oOvh9Lqb
         8baKHliajyRWOu4i0/v4vnqkMUnaJdBHugn45qz7kDw6C4UKboMz5+yDNagxa1xhbSYA
         LVGbFg4LUi6yekPeRD5NFta3HXo4G+ZI3XSb4bCekE9ocyFl/2cHtpYbsUBGmgv1QvUa
         A8r5ZEntXCy+T4mYu5sdOH+pa9DR7a/bGsj6QsNM++0u5wtlHfYxD8B33Ubto4HDCuIW
         PX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043371; x=1702648171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyp/ZFyiUOjenQgn6G8kYMLVmsBPMd5m8mXyGEY1Mx8=;
        b=QCApsngsM02HWFZAbbMz47+7CWhBIoyDUgp5LAs0VQTGQtp2VSSSIYS/sNZb14i/at
         4GvqILbLlERHutQ5R0VxpZ1MsYHpUmE+DSpFrLyvsy5MmmUhq6wP0UOnm6LkrvYNV4Ci
         GCfJ0S1KIpfX0pqg/hXYfWSl0EOm3MVVnwaoPe+YM7xrjcFZjqlirYGJlXv3bJ3p9vGg
         A8Ug/+aRvUWnoN9B8Tc6OvwR+xnClV4kEkJF8vTyzivq41AMFdxtPSmafe7L1YymLa9x
         KCM67PcOWJJlnBy3lC/E1xFGNleoih1GwsFgG6x3BjB9QIm/w2PRU/9swuQy6DLLXg+P
         ZFxA==
X-Gm-Message-State: AOJu0Yz9HvMW+86SJP2DYo315w2KZHNNTg6dWi24hIhAQwPIXs/yJuFC
	8fGvTDUKz/rE1VTFUG3kFEkM5JjkhKu7uSnI+HZb0g==
X-Google-Smtp-Source: AGHT+IEr68RmSA5aYBUgmYtuiSsf9rYsZogw9kLYvnY2zqG64Y2/8MrVDe8thwflyfC3jwZMQ9WgLXTtXopCNqK1OqA=
X-Received: by 2002:ad4:5de2:0:b0:67a:c8ff:1641 with SMTP id
 jn2-20020ad45de2000000b0067ac8ff1641mr5787725qvb.79.1702043371101; Fri, 08
 Dec 2023 05:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-14-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-14-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 14:48:55 +0100
Message-ID: <CAG_fn=Vaj3hTRAMxUwofpSMPhFBOizDOWR_An-V9qLNQv-suYw@mail.gmail.com>
Subject: Re: [PATCH v2 13/33] kmsan: Introduce memset_no_sanitize_memory()
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

On Tue, Nov 21, 2023 at 11:06=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Add a wrapper for memset() that prevents unpoisoning.

We have __memset() already, won't it work for this case?
On the other hand, I am not sure you want to preserve the redzone in
its previous state (unless it's known to be poisoned).
You might consider explicitly unpoisoning the redzone instead.

...

> +__no_sanitize_memory
> +static inline void *memset_no_sanitize_memory(void *s, int c, size_t n)
> +{
> +       return memset(s, c, n);
> +}

I think depending on the compiler optimizations this might end up
being a call to normal memset, that would still change the shadow
bytes.
