Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ie7q4YNN"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796901B2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:45:23 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d13ac2796so3038406d6.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700127922; x=1700732722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuV5LSK+LTxWeRbqVFyqwK6y6J/MVZo38WZUFkMurd4=;
        b=ie7q4YNNpOmZWVVFQ4eh3GLCWwkUKfB8/4+ZVt+6UczviZrpiElYcAc86/h4dmzgl4
         4fFjDwB4iNAmEW8MfPJHlX5V7kQWQyPLS+pmd0vYSkXUIrTtxaVIOUO/oEPQbYTx31va
         8qTqcXetDJNg/rWBsjGku2+rW8cbZCeaLdxMwySx58y5k80Nbltu7jcClKt/qmUfensN
         L5XWH4KTJ9pJ4KjnHL1nkgjOQlh635gi6neceX/GNyaYCA2Lz32NjDGZYR0KVYmbR/pZ
         tx+fkh4enMIRp2lfoHjOYlKaEHOH3DuoW4B70kuqMNroWZUJnEdDd95UBp4xmR7trMsZ
         wcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127922; x=1700732722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuV5LSK+LTxWeRbqVFyqwK6y6J/MVZo38WZUFkMurd4=;
        b=EoJhlFCq0uysj60aRUzJiwSV3m97Jhy7job/oLXAYfcgtPoMC87KfyJHKHGmwg90EY
         zaGCkD6Ab9V8Z87Oj678Ng5v+ND5SI2iR7cygkO1oHuyCLRvsEmnA5YdV1Nl5/wsyDjG
         IJX8ynN1U0ftU7ZsMWkCExh4Twqp+X2pELllM1QkVQ0TYQl9TAmWk9996oOv3hE/8e8A
         gJALy6KaOgrqcCxpDtUxYGj5r+yZKOJYxeBQvcjac8ebkcMRauNcxLj6quLVMz7A6L50
         kAM/I/1e7g7SwMdpBEy/e1zSlN2fh0aWP3OdUx7BygZ2W6l8UKGZpRIZR1dSun+dm18O
         u/UA==
X-Gm-Message-State: AOJu0Yy4J7MBjFI0hLb9g4xUavb1irBCNIvOR5HeOyy6LqK+4ljdvPbD
	vLqclIjwvF8vJh7/NC+JiQH1R+EH6CO31Ap9IiXtjQ==
X-Google-Smtp-Source: AGHT+IEZe2pBqGaIQDwerQVIP7hrHF/NMnZNmo8au4Dfrdlz3uGifZ2pJ0NnPGfwguQfG35pdHrd/w8j19ygDJMsLmM=
X-Received: by 2002:ad4:4d11:0:b0:672:ab2:d9d9 with SMTP id
 l17-20020ad44d11000000b006720ab2d9d9mr8242754qvl.29.1700127922512; Thu, 16
 Nov 2023 01:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-9-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-9-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 10:44:46 +0100
Message-ID: <CAG_fn=U8r0cZ2ZG5dr-Um9Un=S_go7-PixFXJ-PkXCMyL7VY5g@mail.gmail.com>
Subject: Re: [PATCH 08/32] kmsan: Remove an x86-specific #include from kmsan.h
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
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Replace the x86-specific asm/pgtable_64_types.h #include with the
> linux/pgtable.h one, which all architectures have.
>
> Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see the comment below)

>
> -#include <asm/pgtable_64_types.h>
> +#include <linux/pgtable.h>

For the sake of consistency with other KMSAN code, please keep the
headers sorted alphabetically.
