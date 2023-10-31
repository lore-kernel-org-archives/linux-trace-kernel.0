Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3865110C;
	Tue, 31 Oct 2023 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt51lh9x"
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71132A6;
	Mon, 30 Oct 2023 20:06:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28037d046b0so1507298a91.3;
        Mon, 30 Oct 2023 20:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698721595; x=1699326395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr+Y8+5kvg7Y0t5QR1XaxTE4yYUsjucGRPmZxBOq+yU=;
        b=Qt51lh9xNWL+hTf5yaryaDQudhWyIFrxcV2RHtQRNLMhy1Xcq6D1j/gmrh/SSOcWEx
         i2gRhL/+s8SRbzKW/V245TzC4sXrJN1CngNyed/61WTM8cqw46MhQxN/shPKB39WruTK
         apnAjYtFdm273smbrjXVO+BLkPiz+Hug3xSvMdWm7voS4dsZdO7+0fYLdI4/hmzRrN/P
         8JDF63vSJH8g0zYvsROAB0eaDZcPKY96f+MeB494hE+K2y+bS7t+oSO4ylLa5291BX0W
         xJ9O3i5WqrNfMVUPxMH8H6Jot3wWsWR/o0b6taYm++Bpm9IFCwj4oHnqinXSBQd7rmxr
         ebKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698721595; x=1699326395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dr+Y8+5kvg7Y0t5QR1XaxTE4yYUsjucGRPmZxBOq+yU=;
        b=wcGrSVoCSklgOMa5YZsAvc4zSgB65mnOeI1pi3HSC86Lau51S5VOX2uX3zybSXrqt3
         qeKou5hNzztponevkKmNncyLifQD1XuXOf+ls4PF3PvMN2z4dh7TNAWgTgNWlqKo06ul
         JABqEgUBm4gFB494shten7lZs1le1pq5dmqpY/3OR4K1kP4cLoAKzUxztjDCEZZr48Sp
         JWfVhYIZ7Ldxrv6VSoE2gbQEFEqp8AjaT4f5jMJq0F/+vwdejqSU6S3QRYr3E7lt4Y7C
         8BDHFk6Vbfq0XT8lAi8QXu9fBS2X8p4bF+GQ8BdMnL3ZTK+0UtUJDMNEuMU/BNCn2qgz
         +mzA==
X-Gm-Message-State: AOJu0Yw+6ETPnHSstYMIoo5EA2+9KOQYvSbxg2ez5HwDyIALJdz4MJN3
	LX15j67UScd0mGEPhpP40nCQWnEWVpA51/NJHBAQhtj10oE=
X-Google-Smtp-Source: AGHT+IFs/GUGZuajIAU7JgxywABQmsaTap5YBa9FaeFxtkLSvftTmSx0buQYfJt9pFAb0L+an3nn0kv2bZy8uJ4ExtA=
X-Received: by 2002:a17:90b:111:b0:27d:1339:9176 with SMTP id
 p17-20020a17090b011100b0027d13399176mr8870784pjz.25.1698721594560; Mon, 30
 Oct 2023 20:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+g2S9pkFLRV1foEHpEkaRwjMKOVQTxJrM=-sQsqoud92_WNFw@mail.gmail.com>
In-Reply-To: <CA+g2S9pkFLRV1foEHpEkaRwjMKOVQTxJrM=-sQsqoud92_WNFw@mail.gmail.com>
From: Jeff Xie <xiehuan09@gmail.com>
Date: Tue, 31 Oct 2023 11:06:22 +0800
Message-ID: <CAEr6+EB=zLULsL7whcS1aaCjctec2iasQ2+B1NXDxMXEKkTBoQ@mail.gmail.com>
Subject: Re: Update objtrace usage in Documentation/trace/events.rst
To: renhai_lenovo <kean0048@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bagasdotme@gmail.com, 
	"corbet@lwn.net" <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi renhai,

On Tue, Oct 31, 2023 at 10:46=E2=80=AFAM renhai_lenovo <kean0048@gmail.com>=
 wrote:
>
> Documentation: trace/objtrace: Move the line entering the trace
> directory to the first step, so that the commands in the first step
> can be executed smoothly.
>
>     Signed-off-by: Renhai <rh_king@163.com>
>
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.=
rst
> index 52ac8ca8ab64..d5fadf7966de 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -583,6 +583,7 @@ The following commands are supported:
>
>    .. code-block::
>
> +    # cd /sys/kernel/debug/tracing/
>       # echo 'p bio_add_page arg1=3D$arg1' > ./kprobe_events
>
>    Secondly, we can get the value dynamically based on the object:
> @@ -597,7 +598,6 @@ The following commands are supported:
>       # echo 'objtrace:add:arg1,0x28:u32:1 if comm =3D=3D "cat"' >
> ./events/kprobes/ \
>         p_bio_add_page_0/trigger
>
> -     # cd /sys/kernel/debug/tracing/
>       # echo 'p bio_add_page arg1=3D$arg1' > ./kprobe_events
>       # echo 'objtrace:add:arg1,0x28:u32:1 if comm =3D=3D "cat"' >
> ./events/kprobes/p_bio_add_page_0/trigger

Thank you for your interest in the objtrace function. I am currently
busy with other things.
I will come back soon to update this function. When I update it, I
will add your suggestions.

--=20
Thanks,
JeffXie
