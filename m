Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwNN4VsE"
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D419B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:46:34 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so551154276.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700127993; x=1700732793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2IE4TMhLsEPKM/hSail2p58dx/qbJfsgHuokbxSXhI=;
        b=fwNN4VsEBk8G0CE69ZjqDJd2/Nfxczd10kYiYELxzMtFKhgZQ1dHCQSbu7413a5E8C
         HZUFtKem9agXLZzG7VI100keMvojDs/du3tcI+IyVdGjOt0HpFnNljo8aJ1GR3kU47aW
         BTxjMsddMRyB9lUmVBSQDmFFUopBgAoDTL7sw0YcbmQ8Pymp15i579D9L8Q4tJI5PlRw
         Ld90NpzN2Q5QzCT+yh9Z8TgikFzdgtQ7xEMDyQwTgGzBmqp8BKDaTyeUWwB/SCDt/Qu+
         fZ8d7lsLjcZ08g4nRZRt6WgLvUHFf87fAkyshcSTONhEpFjssjERBWafNbmypHvkZg76
         G0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127993; x=1700732793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2IE4TMhLsEPKM/hSail2p58dx/qbJfsgHuokbxSXhI=;
        b=BychZGBXDTflxBsSQtwZV635+2J+1I3cXszquU43OA53tBjsDFc2I1pseCk/mA6Zvw
         uwEql2HqqZk/yknWvEUCfEhO9zv0aZD5zlHCECD7doh+RnlsU1zqPBk1rpqDmS+Y4bUv
         k8DRMIJt4cclV8AAmCcZ/REEV6SwuoZArgl9oUdzbX+SKSxdSUdXwvR6dBynurnHafEG
         WGnoXF67KQ6tR8eO+I9CZyJF+tbw+dIYdRub1iMxvtD+j99F/lRyuwdmxy4L37cgqh8x
         DB1o0ZNUCt/seDvhFekpx9VuDSso1jdBM6nEYJ0a6M5ZtSS3haJKhxj0teySbNxkWgUS
         Y22g==
X-Gm-Message-State: AOJu0YydIpwzhNP0rm6D34nraILloMk93BKd5RNpQ0mbFNBvyfJA5qBb
	di2qwWu1rvvIDh7U6BFCVPnoOCgdYx8/nQsdOxNqNw==
X-Google-Smtp-Source: AGHT+IEaGLOE138vjmqsqGe39mSoH/QW0BpxK1QQmicQZENCOk0z+Iv7+fnx4jrisMz1JiuwrRl9i2WhI1MB38wOZNM=
X-Received: by 2002:a25:ad27:0:b0:d9a:5ff4:cfde with SMTP id
 y39-20020a25ad27000000b00d9a5ff4cfdemr15547906ybi.13.1700127993266; Thu, 16
 Nov 2023 01:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-22-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-22-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 10:45:57 +0100
Message-ID: <CAG_fn=UyvxneFvXPyWhsiKQLrRh0aPpPKORh6J5HJ0t2ZHo4jw@mail.gmail.com>
Subject: Re: [PATCH 21/32] s390: Use a larger stack for KMSAN
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
> Adjust the stack size for the KMSAN-enabled kernel like it was done
> for the KASAN-enabled one in commit 7fef92ccadd7 ("s390/kasan: double
> the stack size"). Both tools have similar requirements.
>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
