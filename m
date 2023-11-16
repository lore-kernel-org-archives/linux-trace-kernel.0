Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nF+ikcHl"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D7A1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:42:59 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d13ac2796so2818416d6.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700124179; x=1700728979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm7nK+NtRd4bAMB5kW+BiMwXh44U1dcDR7sRoBwvzjA=;
        b=nF+ikcHl03m7jOFzOAk/aLqZezXmQgj0b9DWtjCdLAwRSJxsX8BuMwqSwQfhoNEU2Y
         T5t05s7fvpTrjEQj+Nb4F1+FgXrP2A62wROKfW/m50hPu3RXEI9l1N/vP93IH3TSDgfl
         IsaP87awPArZPPTL+1gI7x2wVNO/F5TV0KHkG7fey69OTSCGxuTU4O1IE6dqJ0s2fYCw
         38SYX8eXQE17rVXnSYKhcVbmPq/UiAsRVKBgjUneJVoTrDm7H+ekYFrL70NS0ytb7VXr
         4FbT/QqWjpoLpXwCFwXPSPaLl1fINFPVZgU9xhjNvv7pUSn5CxGNniMqzW/2ByH99lHn
         /vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124179; x=1700728979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm7nK+NtRd4bAMB5kW+BiMwXh44U1dcDR7sRoBwvzjA=;
        b=OaKviQrTCO3rXxtmDEFcjZqLrDCqDLk1bNNENlJwQA3rJ4PD7oIm3v/7FV473VTXT5
         j2CNrr7uerr25Eb2kS3ZVGZ63jREhX3lvavb4n5NtQqUkfU1OHRVQDbIAmGWLGTpCd4k
         7rN2TGvgTpJReyo5l/P6UJ6i7dEV7/V+iHAXumS9yDzuLWomADADv9r1dA2bgW0C6Jja
         RBP4GOcZeVj6iOC3BPGgotD8yFGYzFJCEudbhsCim8JKVRIku9Zlo1EZjz5XDv/7ZzA/
         xcpUaRPWGtgox1peq8w7JOSe3YQaM5yn51vvoTD95XV9wXnhv0EL3Y8z4ByKfsCpr+cH
         LzwQ==
X-Gm-Message-State: AOJu0Yz5sPFAf2Hxh/8XnwP0PKRPoRA+FgYW5esNJdbm74ommeDTdyob
	C1DDyU99kfpB/saiM/o6xb0+sdP0AD0JG00rozmW/w==
X-Google-Smtp-Source: AGHT+IH6qhh+dNSCS8qlmsj8ih0YO9KvQIu5BurzqUnTPk5VIq6JplJrO+8kjsmK6Xqo+e4Abaw23H8ROYFxm8aLIFw=
X-Received: by 2002:a0c:fbc2:0:b0:670:6340:2b03 with SMTP id
 n2-20020a0cfbc2000000b0067063402b03mr7946532qvp.21.1700124178734; Thu, 16 Nov
 2023 00:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-1-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 09:42:18 +0100
Message-ID: <CAG_fn=U+X=EE9SSb61E=QDReBXn6PGiX4gJnMfNKsTwQ6saKcA@mail.gmail.com>
Subject: Re: [PATCH 00/32] kmsan: Enable on s390
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
> Hi,
>
> This series provides the minimal support for Kernel Memory Sanitizer on
> s390. Kernel Memory Sanitizer is clang-only instrumentation for finding
> accesses to uninitialized memory. The clang support for s390 has already
> been merged [1].
>
> With this series, I can successfully boot s390 defconfig and
> debug_defconfig with kmsan.panic=3D1. The tool found one real
> s390-specific bug (fixed in master).
>
> Best regards,
> Ilya

Hi Ilya,

This is really impressive!
Can you please share some instructions on how to run KMSAN in QEMU?
I've never touched s390, but I'm assuming it should be possible?
