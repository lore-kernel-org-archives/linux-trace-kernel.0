Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ch3RRNhB"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3DD1AB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:28:07 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a82c2eb50cso5982767b3.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700126886; x=1700731686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHxIHoAh95uWA47oz0tiRhia9t+geZSbB1hJPltpI8c=;
        b=ch3RRNhBLIKaqi8d4YxOUKmkZ5zxpFPePDX6KtMB5Hz0S9SolhGqomXBh+NXOJIvP9
         SbILxIzy8dFpSwoyUoKFIp8kDKYa4+jQPaROI1TBiDAoshOKO+LY3jyH80tfAiAcV/j/
         y8OfkdexkgqUveusw1ZX1T9ohkszUG/BYyJQWoR+TSVg2WridYWJgg73k1b5RDmA5wb9
         8+P8FRzLXyB9Ota6cbAixFRzov5CiqXhLDb2t4mpcPwKu4rFQjCKPy+JlaSHPt8nx1+n
         jewPnjr2AEsKN+MxlY9QALFZQL0BGs9Y5tCeJs4F6yNo3jevA9+Q0Ennszh87utFrkBl
         EOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126886; x=1700731686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHxIHoAh95uWA47oz0tiRhia9t+geZSbB1hJPltpI8c=;
        b=QV25Fcb4aB8KDybKSD0R8icWSdSFye9eO/PZL9UwKxiFlG1LZA7GZ9S0svE8koH19T
         TKMsQfe1RtBqeCBpsGOs+Lfm8JVlTdEnJhDo3SKx6SyM1GfX4lSqeC7F6KDwpjFamxPv
         muboFsAzNdiAJ32Lwm6LkwBaers6YJnbMhYS5RwCWqP/JsaBHQg7GqNvNKFV9NJNrrLc
         y+5wjpV2CBP/AeKxPKOfJRNYKxuh5vzYJvDclvMsHgf4ZR55Wtq9EmFk5VEy5+qkCTb5
         Z36hcNshwT/l8zgtFLXuYzo32iMO1HgtaalSnOTPwtf/r2/JBQnlJmDxRoALsa3D9Cer
         r2Ew==
X-Gm-Message-State: AOJu0YzZIMiIuB8MHDZMjit8UDEIWoEOkZt6oWhDI4fEF/lDhl1ZVWhA
	qjtg+Rg0o3s7r3uQI71p4BsRly2zTU7ZVhPpahbTDA==
X-Google-Smtp-Source: AGHT+IGR97YS05lsiSAJeEb41aiAbQ6qZIt7JBWSuXrTHq8koWoVZZ9M66uBhv2IyyKsBQgWAzIxwe5MzNYvs6e6U84=
X-Received: by 2002:a25:2487:0:b0:d9c:cc27:cc4a with SMTP id
 k129-20020a252487000000b00d9ccc27cc4amr11964662ybk.32.1700126886326; Thu, 16
 Nov 2023 01:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-3-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-3-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 10:27:26 +0100
Message-ID: <CAG_fn=WYywAHC_KfZjk2Wqv6RmZQe1wiAAryN4BC6QZBA3FJDw@mail.gmail.com>
Subject: Re: [PATCH 02/32] kmsan: Make the tests compatible with kmsan.panic=1
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Marco Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Pekka Enberg <penberg@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> It's useful to have both tests and kmsan.panic=3D1 during development,
> but right now the warnings, that the tests cause, lead to kernel
> panics.
>
> Temporarily set kmsan.panic=3D0 for the duration of the KMSAN testing.

Nice!

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
