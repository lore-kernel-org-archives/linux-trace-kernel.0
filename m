Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiRBS8KO"
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E8194
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:33:21 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d30d9f4549so501929a34.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700148801; x=1700753601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jigcuHsKegNHRurmm53lq9/67DRAvCMuAyvTeznimbI=;
        b=uiRBS8KOnWIrrj7bdwYMb3qoAMfVlAjanY7smZKlU9JQlT9Sk08h2lAwMonYctU9zm
         TXg56DxBbAGT4D+LPS0l6CFTNnN8u3bBHG9lsFcKOOb5BnWLbgylyEc/4YYV5B8E68U/
         SNbBjAMmhJVcwo+84k8M8FLecbWq6aKdCTOG+zMcPwNsWRo6tD0UND1ZHCD8TkE/jws/
         U1IdnowuhOFjaUONos+o2kZUVcV5Xo6sMVNfYIANiGGDbkH6AZN/+QWhliap7z1u3rv1
         PeLP+ggFBbNRB/ltjKZjktaQAbMiIePvcWxeBJkuhIa9/3p4Zo0OZ/dRvYsKK2fum1p7
         LMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700148801; x=1700753601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jigcuHsKegNHRurmm53lq9/67DRAvCMuAyvTeznimbI=;
        b=eoNYh5fmjWZmFxBXrCMJfDBxEvFKW7BQez3xUFVYFpNJsmZ8EO8wtzjNQGPZc3cSrP
         2+/BxBY9bBvxKYnKSERhzBP8xDkJ3XoZYgeR/jKadFR9/qWSRI4TVcicIk6nlEcBm7GE
         pTFJjPS1uY2YgkmX2CddPPyoKXMcsb4opJc2uBcZF8K892Fl2IW4gTfGlqZhwzKKgPKd
         8yjzVYuprvPx0IMkwSPM0vqoqbFMN5+kjiFItVDSAPpocGC4O1UohkiOnAQOMXJuLs0q
         ToLtmV2S4BQZFigjeSttnjNr+e9Z0+BEthc1UXTTI1TQuldSxGmUo1PxPzcFbNNsVOuY
         yElA==
X-Gm-Message-State: AOJu0Yw6Aw91DiRpSc0MHhb0bYAs4t20dvifqUzCEZg7jhcjwo/EMVQP
	++TICWlcsoeu6kTz09Zvi0M69eBWHlJoTyueroJFZw==
X-Google-Smtp-Source: AGHT+IHQosnCTeAt9ijWHEBylYqw8hrag8Y1HXVdGjwrtL/nmaov8l5KZvuUY+6ld7/ytSI/9Hxmk/Hk+xIdyevqHGU=
X-Received: by 2002:a9d:4803:0:b0:6d4:733e:e3ec with SMTP id
 c3-20020a9d4803000000b006d4733ee3ecmr9485460otf.37.1700148800736; Thu, 16 Nov
 2023 07:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-29-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-29-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 16:32:39 +0100
Message-ID: <CAG_fn=W2t61Y-ZTgmnu78mpcpPRCzB-hk9YZoD8RXXdaKHV0MQ@mail.gmail.com>
Subject: Re: [PATCH 28/32] s390/traps: Unpoison the kernel_stack_overflow()'s pt_regs
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

On Wed, Nov 15, 2023 at 9:35=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> This is normally done by the generic entry code, but the
> kernel_stack_overflow() flow bypasses it.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  arch/s390/kernel/traps.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 1d2aa448d103..dd7362806dbb 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -27,6 +27,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/cpu.h>
>  #include <linux/entry-common.h>
> +#include <linux/kmsan.h>
>  #include <asm/asm-extable.h>
>  #include <asm/fpu/api.h>
>  #include <asm/vtime.h>
> @@ -260,6 +261,7 @@ static void monitor_event_exception(struct pt_regs *r=
egs)
>
>  void kernel_stack_overflow(struct pt_regs *regs)
>  {
> +       kmsan_unpoison_entry_regs(regs);

I suggest adding a comment here.
