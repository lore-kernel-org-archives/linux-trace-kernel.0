Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912D36998A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317455; cv=none; b=noXZGavSITDsNOvi9Nc7aWR0NVuXdFREEwc0K9KpR0iiCJYvmV/ub2VswrkF1prlsCqZe9jiY3llovxnrvpltPKiaHN5ob6gFGmcB8Iut9+YVkw93VQLUYhp0kMyQvk7thBGHlvlGQ4piQHdu23aisWQAKOfs1zuqQVDyCa8iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317455; c=relaxed/simple;
	bh=MgBKdwoWoHdzh9jZIzaoKkX+8CoGhX3iGiNHp2j/RxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrRXo5CSQOtxzCl74o4rwE9wxsByZf1ykbYrGyniWZCsoz8x9KMo/tOaFJ6d0z6xiqM46lFgP3lTZE29qYcUa5NmONCydbEG5k4kiHMcXp6GtT5k9kG4vAwsWtMmsspCrwPcplNRnS3/C4zwWekxGWudlSJp4aPvVcrc1zm54ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGcnIpot; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGcnIpot"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so514834a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789317453; x=1789922253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xjaPdN09ksi9J3CF6A7zEbIFkfemb4BduJXQXSfH/J8=;
        b=kGcnIpotCLFLPVb9qy02Tf8S1f7MLw2fxL78heDulw5ERsy9y56EgaHzCu0iPZxIEw
         0+gAQDbU/PNXRGgZHBa+HJfp5EfSrvDnXfhHA/gJKf0exoVfjmsluPzKLS2lzDkRIcuQ
         Z6jZrzN9cPtp4ibNYCDqcf2cqjcHb3MClaArtYwQC9CPUJwGH3VW4s8CmtfiWIkZ7oVD
         oKru8umCi1Fqq/at73o2pfldmKOdJLvJQNYdc0Ni99mYKORm3yWHPYdCyDKhptjpC67C
         jb6RrimiL2QGugbCfOJohC1oQcqu1o5HJMUR9D9eUTJ0MPSKiMd7pwvsOWzOJjZWIgwu
         Igdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789317453; x=1789922253;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xjaPdN09ksi9J3CF6A7zEbIFkfemb4BduJXQXSfH/J8=;
        b=rr24KHztkCluSr+SXdHz0utPomaYCHIclq/AJnODauVEm3LDONEeQEPuR1sbXVIwjw
         vJBCaEogAFQrCQ6i59CFACIDmLMu/D7sfpyhEB7DhGi7dCc6zGvlT4gSU84IiJLwl3Wi
         O8gpb8SFdmioTgkX3Tlh+16sxvWrEzKT3GXfssEcFGtazW9aWL8pfIJPlXB1267vjqO1
         uSKbCGaKFh0cxlIi+9nGBdcBwM6CeHYXNYoW6jw5txOpyBxIgl1Tp2NJL12rEk3oOT3A
         Kfs03QiuMH0OIo9vulydL5jzmyhKysaWxtNqeH7xPr6tvBvjqrXH6qSeRDEU1dFpkI1z
         HZvg==
X-Forwarded-Encrypted: i=1; AKwUvBzf+i/LX+7zswgt52Sxv7K0NNw6EqBb8/E3VeIJ+gykQjZ5XKcA7Y8Nonw2SK8EfE2Fkilkmo+WLmXjLrqWeUDZBPw=@vger.kernel.org
X-Gm-Message-State: AFuF++lTcUHL7U7MExYBEtwB0q5nkBmY7I4j3DC4DzW0K//LxrIf76Vh
	rVTbqpFRJLEu4Dzxl7hR0X4z+jFTbfillOYK455RAqn5L6BkWFBkaw8=
X-Gm-Gg: AYBFou0s29r0KCnQSthOh1nmp6WRRIvsq3k2DvFo18QD8n85yjUI5Nk4tw8O8Vodg5E
	HfN8PZ0vztRFWFRd3SrHH2Jvi2iErhWv+rl0mgTAIEnLTODC9B2BoU5jH9uwHPNH1xdabaWmo29
	34sP5XZb01V7ulInp+tIuzodzAbKCvVZzf+c2rwxl2gV9204tsEGbkRWkQINKOAtXSlqvgUbB8N
	m5YMDmRtWPa4xwwwT/APJrln3+JYNaT05lPzflWoqjdycOxTPSjLaMThoQbBG4laHnCF9e5RkpA
	SmfFL4YJKYWohMcOGxiU6WqDArAYqQzfpp17rvRxXSA4iExeZglSo07ysqAQLdz9WUc8Sk/fzyN
	UTlkXczHmf7hgnw+6kd4poZ9/VwpxFjhLInbW7xRI0TR8smNXn0vIaE9DAMjd+LGhc2ojbZDGT7
	hdHOwuWTG8a/gO2HhzFLiBnlSEWOrQ3LhX9UOaY6BVwLx9zSDfKhvFTowPozUbAV34ITa5qIemw
	q3cJojNU4CjJcKr4El5Uxl/Eg==
X-Received: by 2002:a17:90b:2f84:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39dd5570100mr3291656a91.6.1789317453244;
        Sun, 13 Sep 2026 09:37:33 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94bb0119sm16698818a91.2.2026.09.13.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 09:37:32 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Xiang Gao <gaoxiang17@xiaomi.com>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Xiang Gao <gxxa03070307@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: add ring-buffer memory usage statistics in tracefs
Date: Mon, 14 Sep 2026 01:37:25 +0900
Message-ID: <20260913163725.755443-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911155017.3377254-2-gaoxiang17@xiaomi.com>
References: <20260911155017.3377254-1-gaoxiang17@xiaomi.com> <20260911155017.3377254-2-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Fri, Sep 11, 2026 at 11:50:16PM +0800, Xiang Gao wrote:
> +	/* The cached read page, if present, is a full sub-buffer page. */
> +	if (cpu_buffer->free_page)
> +		size += subbuf_size;

Have you compile-tested this one? free_page is a struct, not a pointer:

  kernel/trace/ring_buffer.c:6594:13: error: used struct type value where scalar is required
   6594 |         if (cpu_buffer->free_page)
        |             ^~~~~~~~~~

cpu_buffer->free_page.data should do it.

> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		for_each_tracing_cpu(cpu)
> +			trace_array_buffer_memory(tr, cpu, &stats.buffers,
> +						  &stats.snapshot);
> +	}

With that fixed the walk does match the changelog, but temp_buffer is out
of its reach. tracer_alloc_buffers() allocates it and never attaches it to
a trace array, so it is not on ftrace_trace_arrays, and its pages are the
kind you are counting: sub-buffers and a reader page from the page
allocator, not remote and not slab.

It is three sub-buffers per CPU at order 0 and is never resized, so it
disappears into the noise once a real buffer is sized up. At rest it does
not. On an 8 CPU x86_64 guest the file reports

  buffers: 96

while temp_buffer holds another 96K. Freeing it hands back 24 pages, which
is what ring_buffer_memory_size() predicts for it.

Was that deliberate? For lost RAM accounting I would have expected it in.
