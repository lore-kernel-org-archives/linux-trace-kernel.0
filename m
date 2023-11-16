Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vf0P6XS1"
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CCA19E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:55:16 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9beb865a40so544037276.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700128516; x=1700733316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baj28rj0m1kOuDCTG+0KHDcj/t1NS6y3cMo9+0jrJJc=;
        b=vf0P6XS1GURBv+HM2aCIjFay7hHaXB+l4txiszJOIazULgEYbTpPZ1Up3L1eNW0Ccp
         6Dxs+ek0YrjL7q41pB6nROmWoaHpFUg/w83yGnlzsjz3m/djJq1Wa2Gc7bztkkYlOWhu
         esR3Gg5TSkWdQFUEWgm0eN6VyNFHT7zJXSYDFPL/AdP3+JxGc7Uw0A56WveGIZN9yPy/
         qmcciiVpbUxy1FIUD/UXPFGZLntDYdp76fnv85TvWI+BQ60Fm5sAhFVnWIe5AtsF2bNb
         FZJ6OUsbI0m4luXUvLPyi40JKDRqn8AowpHgHQn4hyrBq0Bl8dBmSjiecP5PRqphe6Gi
         cZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128516; x=1700733316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baj28rj0m1kOuDCTG+0KHDcj/t1NS6y3cMo9+0jrJJc=;
        b=dreXeYjQhsEV9A7up6+8gKpWw5G/yIfJmGsf5YXQ1C4ylHG5BwdMrQ2fFswH90QQCK
         aEmpxvr6q/+rxuyUtSRJNZf2ttSUYGCnGKwQATrwetpL6NUsvuX5aUPOnlvX63DNAkmg
         WRC7XGhETJd1efRyxAGDJgWjfBAftCQc/E2Slk8TEsCG9KgRaPyvhAVZw2gJddAkrs1H
         uP/eU2MKyzmbI95ImxlS4xxBapoS+BT5oxpXu3UEvAWCHaef88q1NtXQKjQItCQlDgSa
         vxK/cki5z47tLj6SoXHOD02wrPr/juNt//n7Q/KDYfHYYrdHqzpgGd5vFK5TwyU3lLya
         uraw==
X-Gm-Message-State: AOJu0YyD5VTPdkGGbNE87yWqzKcxJc+HnVor0UcoeV7upaD05bJjyyTV
	8FyGP6lHsBtXsuKe5R/DymrJzKi7dXWlbflHaxICWw==
X-Google-Smtp-Source: AGHT+IGkV65U7kgr5HXaKsUiw7kNWRKCsWMB345P39Pcp5E8uxIJFkGoztPTLYzdOJALjwOludoSGKAWKBy3ss7ZSGU=
X-Received: by 2002:a25:7a81:0:b0:d91:1296:947 with SMTP id
 v123-20020a257a81000000b00d9112960947mr13819109ybc.40.1700128515815; Thu, 16
 Nov 2023 01:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-15-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-15-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 10:54:39 +0100
Message-ID: <CAG_fn=WSq_r5ry-0uviR6CUx-6eqXo5tqCtYAL0nE3UYyA4=pg@mail.gmail.com>
Subject: Re: [PATCH 14/32] kmsan: Use ALIGN_DOWN() in kmsan_get_metadata()
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
> Improve the readability by replacing the custom aligning logic with
> ALIGN_DOWN(). Unlike other places where a similar sequence is used,
> there is no size parameter that needs to be adjusted, so the standard
> macro fits.

Good catch, thank you!

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
