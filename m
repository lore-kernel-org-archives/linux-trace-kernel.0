Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBIfDKvL"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCBACF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:37:04 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67ad891ff36so29672286d6.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702291023; x=1702895823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xZZSpag6K2BrrxUB+HXexjy0tvgok7Hn3gQdazxamw=;
        b=QBIfDKvLL5uUNay6AxyqufLxo9IouB1IBJb06qeRDlxx6PfaEOlVQnVnaG4ZHQLZSA
         2JeeAvRN3w8FZ0Xc/8L8fqtsiCpUNRtyusCfYeV8FTBOevAuI5O7c/e6IhFp+IOKDTtH
         u9KTF7iRydG0e7Xd6caQIQkMoze+rH/2E3M/Dny3LWnh0nxZzc5Tuo/kE2YkbVIPgi6m
         wZVNZtAeBZ5I6e/E//O7SHk/wjKRgwRfefrA36RRCej1YbMUQd7rj5OiY1YRXz084fbY
         G947zyxToqma0CuyasEq6o3dI/WLGwgpVGllUKXfNmHCeAd+SCQWU2GJc5yKTUwJqeu8
         wyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291023; x=1702895823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xZZSpag6K2BrrxUB+HXexjy0tvgok7Hn3gQdazxamw=;
        b=M8ffSoiICC3zoJ1RlKUfONeRSutwIxRNlSLCrZxkdbhJHBF1IC6uqmmh+w8Y+C4qRP
         7P0u9HXwfvpTP17qmUycpimmQECGaTvWCsdYTLVxmLRoe6EIzkyR8G+IXmep65TYXp85
         DZZFbYkj0aDUY0pd4upzeLA5ILt/3R70rOtROHqvPQ6ZD9OZa7CAVHts4UO/FDDDFQFd
         fHplVzOA3m+EP8ulfEj03zEieAmmLDvTPlMxUvo7xMMRSMSaYiklOaZraaVYxJCn3djX
         Tx5H9IABkqE/qkvD8je7pnPtqysA0xhr9RLTKwvcYzQerLjk0dWEuGH7Nf1ToVFExxIA
         XSMA==
X-Gm-Message-State: AOJu0YyJC0H3K6dc0bBGzkVCTePo9K6zKrTFsT/9BKetRNAQF95SKM+y
	VfFGrvHV4CBUZkjyN1L53KigNoz/65a4m+RQViyqWw==
X-Google-Smtp-Source: AGHT+IG2hreF5WUvCkeK9/1PTdi6XuXHKd5OzzWIV9TutEPZLQcFZOECLixwnYp9kHhdQ4NW9Hm2iZIo6eRfJV7Vqu8=
X-Received: by 2002:a05:6214:5cc:b0:67a:97a4:1f73 with SMTP id
 t12-20020a05621405cc00b0067a97a41f73mr5565614qvz.40.1702291023543; Mon, 11
 Dec 2023 02:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-26-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-26-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 11 Dec 2023 11:36:27 +0100
Message-ID: <CAG_fn=W7EQph__sbiBvNdaaSFG3-vweA396Oa81QoXAE8+b9yA@mail.gmail.com>
Subject: Re: [PATCH v2 25/33] s390/cpacf: Unpoison the results of cpacf_trng()
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

On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> Prevent KMSAN from complaining about buffers filled by cpacf_trng()
> being uninitialized.
>
> Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
