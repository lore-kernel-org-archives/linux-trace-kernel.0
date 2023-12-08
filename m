Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhVevluX"
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664B6E9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:52:28 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-42542b1ed5dso14713201cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702054347; x=1702659147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCwpDcUhOmDqjvrlR1SNfeF5wJTZtg8zSBwCC0FJlGs=;
        b=RhVevluXToi4hwt4IiT6Qg4LS6Yd0XNckkPCw2KSLY4QFLPPQp7tmSPgbJAQ2+6TRL
         0we1xrWpOdk7FDza2DUjJ3qAVcp/8W+Cgr2/XN5Fpuk4aPCTx6BzAMM2jV5YfHLLRsgk
         EhORT/iJHP0OxgqQEiDnvEaUyAvAMY9SoRU3AnpYJC5d1T76GkUgeaiW+4XBo14iLPSI
         uiwEOumfwTvcG2wwhtyMUQWmaM4Nu9FrGoKL/LqQpzlTwk56BxL63s5U2Z0lA/U3VjUL
         fdbbzzsN8vRX42faSTYFvaecJl+HPjNkxGBA/aZOLZNZNQaATOQhZkTxT/1P+Tutw6Fv
         ww7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702054347; x=1702659147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCwpDcUhOmDqjvrlR1SNfeF5wJTZtg8zSBwCC0FJlGs=;
        b=ZJxSDSFDfo28Pc3hsCP3xxLYjoccClXl+P6dUcooI1Gnny9jTC8QULQxdpbuodueAl
         Cm5fZ15sexmq1WLr4DzEzwKk3w4wHBrWS2uSz71XxuDjV2+Wwj+fPwzfuUoBshHcvSXj
         DlsyKd0HBvOr5B6jWpEsTjKiD5J0rpQY/SqzSfXTC1jb48HYFWEHQ86T4pA2S1C2RjNx
         r+mV3EAKVhjXjkQVU5SuHqJB1Y27vj3id+Fd45kkiu38g4oOtNgcmLeJxuW72JOZMH7n
         5XlKpGqMfFu6I8q/bO3YSycN27ypKoHwxtHGbQJBoP7Iqso48/Qeb16SWSa3RTMq9H8v
         /yLA==
X-Gm-Message-State: AOJu0YzreTpoEjzVaPi8G/3O9TG7lhMq3Oj+e6egoPwL7ip4FfIC+zun
	aqnzccqEOvIOmo/mmfR9YAUVBh8xSgtk63jtGxdiMg==
X-Google-Smtp-Source: AGHT+IG/Qa2CsBPsTo8laLu1WyqkZnjskF+ulvDFcaMMAjoQPlLNPVr7WYr7dMHEv6WOe9zUYJ/8giXe+mG6gU/3KR8=
X-Received: by 2002:a05:6214:4013:b0:67a:ccb7:4fe0 with SMTP id
 kd19-20020a056214401300b0067accb74fe0mr319829qvb.82.1702054347432; Fri, 08
 Dec 2023 08:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-10-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-10-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 17:51:51 +0100
Message-ID: <CAG_fn=X-jgQo9p205h+G=omdN-u3n5bUAGZ6u3W7=8bo966gfg@mail.gmail.com>
Subject: Re: [PATCH v2 09/33] kmsan: Introduce kmsan_memmove_metadata()
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

On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> It is useful to manually copy metadata in order to describe the effects
> of memmove()-like logic in uninstrumented code or inline asm. Introduce
> kmsan_memmove_metadata() for this purpose.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  include/linux/kmsan-checks.h | 14 ++++++++++++++
>  mm/kmsan/hooks.c             | 11 +++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
> index c4cae333deec..5218973f0ad0 100644
> --- a/include/linux/kmsan-checks.h
> +++ b/include/linux/kmsan-checks.h
> @@ -61,6 +61,17 @@ void kmsan_check_memory(const void *address, size_t si=
ze);
>  void kmsan_copy_to_user(void __user *to, const void *from, size_t to_cop=
y,
>                         size_t left);
>
> +/**
> + * kmsan_memmove_metadata() - Copy kernel memory range metadata.
> + * @dst: start of the destination kernel memory range.
> + * @src: start of the source kernel memory range.
> + * @n:   size of the memory ranges.
> + *
> + * KMSAN will treat the destination range as if its contents were memmov=
e()d
> + * from the source range.
> + */
> +void kmsan_memmove_metadata(void *dst, const void *src, size_t n);

As noted in patch 18/33, I am pretty sure we shouldn't need this function.
