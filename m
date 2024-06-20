Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4551AE84E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895562; cv=none; b=KYg3sqXd/FIhyDL4JM6uw0XJPas41nPPyjFYUgLy53bcPU+7g/S9/isN2/fo/EQG4Ic9IAxtwRZWEVo/DYPJKf1LfdCCFm5s9g77WYH6PA6eG3mbe3BfbN5FEEbV8nT54Cfv+2RkWG9CNJHrQpke9f/rJlzGALnFxEPbRzo4iUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895562; c=relaxed/simple;
	bh=wQFe7+FoQAQ/Ej8PGtCjqCQeTZhNJNzpwjveIE3kwow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYSWL+6M57/7DeV7FvwSd5VF6hkimmny8Pa3XW2+RPBkCiVa4WzICb1Sx3/uxPX5UWTbIW9XQuJH3VysaJ9U+vHmITAkaDaB8VhIZDX662P55AsN/tmhelrTec1eNbFDegHWXS0S2bJURjBfMxomlOXRzrzxS3Wy5BVgWRddy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sguj/13v; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sguj/13v"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-795524bb6d9so61664685a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718895558; x=1719500358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQFe7+FoQAQ/Ej8PGtCjqCQeTZhNJNzpwjveIE3kwow=;
        b=sguj/13vZL7ZJZO5z8sfE8DrKVERNW1EI60r5Q0WJ9TVYC6W4m34sdO+iOboFKkfQ+
         +Z0qBYrCevIxss2U6ib2gKp6C/8ayxteSLNgQLdIXa+DmtZ8ETGf67wOliFCGRmjU854
         GtQ68KVtCjwZkAbaLx4tUOII3g+agxv9tzSq4ccANHhir7PyNwHR2DsZD2gK2OjiJIJj
         6a//RI74MW5DaByoXfw+CG/c6dxOmGPbBK6IJtyMrECTBEJiiKB7tpGCQ6VPlo3MT2Fv
         vvTF/SV9DrVOY/S3TAq+BuSw2OYFpYjUTaNfi6mG2+3tHOvCnOUngqGL9N1oU3gy64K8
         7wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895558; x=1719500358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQFe7+FoQAQ/Ej8PGtCjqCQeTZhNJNzpwjveIE3kwow=;
        b=EZFaaaxeR5CKBM3yXRzXBa7m+aXJyv31KcQg0JVn+CB0x8P6FdGr1iZ/HJm3oXGCCM
         kxj4x+/zP3vC2cs1bs6H1kkW5qFUD5C/6rkMx43NKTy/XbiQWXquD6nnYxWMbydAncOj
         EfA9XjtgSLifOysHGvZmOu82f2nIM48DNo4PbmmbzHC716nqgd2zZSNMH1brfveggUNo
         zEAxDjLc7VCN8CQyPZeJyDll8jE6fWABwvi2c6gDOtkAl3XACdSyFeh6TYklVyrinWwW
         eAntt+/qyPcQh+s0mg8VvUJmgAfIKDxgrgM1Qp+D5zZonS7SxM+q7pF7m8eEbcKMRs8F
         UxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUlwtFcieQyMXsPrH+IlIi2SJsqpjaldNGKjDl47uuI/kE5W0o5HJuA4zfWIuVAnL2FJictfjLPwhAHhb/UEAYS+w51zYGKOomjEX2M5ysPRMr
X-Gm-Message-State: AOJu0YxJbti11xUfEc1E6/w9eztv2pK7iPP/UpQHRVTi1YGERqI/0v2n
	3C1a/7IKBD8sq6gQSP2uJ5ur4J4wQuL0RFCVY04rW+u1p3ZN4Z2K/6SLwNLMfB7CuyHa0QkjVfT
	8Uzr3X9aHYk66lpCCGOsq5JzaHU+oxGw/NkAF
X-Google-Smtp-Source: AGHT+IGeRuqV+cE/BwKBYEq3GJ1OZf5EGVZmjN41sQI94tB6oOMgdyEKTDLMRa7DT6aOW38eJ9+FxzAOQmbOR+cC/uI=
X-Received: by 2002:a05:6214:14e3:b0:6b0:914d:4a56 with SMTP id
 6a1803df08f44-6b501e9f7e5mr56738086d6.40.1718895558286; Thu, 20 Jun 2024
 07:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-14-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-14-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 16:58:37 +0200
Message-ID: <CAG_fn=V2n_pwdKBK1jwvZ9Aw_M9-UgZ7xho2KS0uUddHWe6H+w@mail.gmail.com>
Subject: Re: [PATCH v5 13/37] kmsan: Support SLAB_POISON
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

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> kmsan_slab_free() to poison the freed memory, and by preventing
> init_object() from unpoisoning new allocations by using __memset().
>
> There are two alternatives to this approach. First, init_object()
> can be marked with __no_sanitize_memory. This annotation should be used
> with great care, because it drops all instrumentation from the
> function, and any shadow writes will be lost. Even though this is not a
> concern with the current init_object() implementation, this may change
> in the future.
>
> Second, kmsan_poison_memory() calls may be added after memset() calls.
> The downside is that init_object() is called from
> free_debug_processing(), in which case poisoning will erase the
> distinction between simply uninitialized memory and UAF.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
