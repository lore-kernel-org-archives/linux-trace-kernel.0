Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF1208A0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Dec 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361647; cv=none; b=N+IVHIAjt4t/1l0wG+HYKdPXuNxgQ0iTQN+fnnGjRW1TFjqc7hY3A9C1nAFXb++d2B3xaqximSOqKnpLRMpb3UzAZGcejQC2DgsbChmDei6Hw3uBgCkF1d96wTNOPCVnvxhHyYIY6v9575VEbj5rdNUmSMZkMtUeNj3ZVZfagr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361647; c=relaxed/simple;
	bh=SgowjTQrYekcXyiahCj20togqQfF2xU1QX6ftSI5N/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WalTl7n4rBDEFhEjYusG3Y9QRaioWDXzHJTsrAOfOttdhSfZeD+gXPXGTvMVPFV+VYr2NY8JwxcabmIkjdY8RhQZkbZIW/wSXuaKoer31Mmioptqgnm8xqepLKjlT9fBzL0NDywXw8Gp4/Qqmwd1oF/2fMSrktqjYFdM7MCaty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elES94BW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elES94BW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733361643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4YbcbUu4DyS3JwmAn34bQrphZB0KAFMZkW6h21FvT0=;
	b=elES94BWc7nHiZKpbEILQ6z1QnwlGYX2wFzDBxH1SwZ2Ln5oBL602RqCj8JIk6RAR4DiJC
	eYn8CevrI2M4rYP2FUn5kizyUvZomHrjhUg2HNqKKhRTDBL0H88O9FWBj3OJEhC+EEGmRL
	NJGfvCyksG0yeS/m+GZVzlLq4L0vvpg=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-So9754XlMSW6_aTAxRHV0Q-1; Wed, 04 Dec 2024 20:20:41 -0500
X-MC-Unique: So9754XlMSW6_aTAxRHV0Q-1
X-Mimecast-MFC-AGG-ID: So9754XlMSW6_aTAxRHV0Q
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4adde6b7367so63599137.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Dec 2024 17:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733361641; x=1733966441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4YbcbUu4DyS3JwmAn34bQrphZB0KAFMZkW6h21FvT0=;
        b=fSZZwB0MF74paU+QqJm3ugBdqkAWRtzNmeNxQLN7FPCPgOIpPkOjr+PYWOOvJ9AkrV
         ZEXBB2uWHBXHuX5sbVjrfjbq4Bw4E1PhLOzL5fxyE33wzt0YLJAiY/irunq62rpbHPVI
         /4LzIrvonuV6XwgQRpd/P29J0nKTgeHOGQ5mBgfG9aa1jdBEOiWo8T51M+4GdXqTvpm9
         7qmBEaHaxtgX6Wl1FqNDuOEETLtxMadSUnD50zkOn3ms+0fpQ9QTGzmaPAEKP+hn/PGY
         yv9kByb+LqNkk7ocjXsJ90CjDiycJ1ajfvRnQjxy96aj/YCfQXfQqPoblYX0NZB2soQV
         JxIg==
X-Forwarded-Encrypted: i=1; AJvYcCUcxrVCv5fCEcVSyvGQyrLakFe2XB302azxcjTjDutS020MHYK+CNuiu7znqZVBgbwnXSrwe27291gTGxeA+pwAeSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYN3HfI7OJIl8M8YkyJ0XqCZC0kqa52mCnN68zwYrgJKbzxso
	YcS06lNGOrMS7PCC0Cc9FPj563lIsH/yrqC5y4iBxArIyZo0rEGyO9Pcn4ureKG8PpvblXqA4ag
	70HoBnwmlvHKdPUhU5Zdoe1FQ64STwbun7EnswDWowlWpaJoDyHuUokrPI43QA7zFEBg6HPyH/p
	zKIXeEE39u2nD7f7EkiASWSMc4vzLaU8LOd6EPfXJzSS6F
X-Gm-Gg: ASbGncu1Seo0RHYcWiVNrmFLGiKEdtj4ljBYh/WNwvXHJAPbkUfYqXUTV+5dlzf0j8T
	ocp8rXqkaaXpJ7Sg9ROCu8YSJ2MSQhWrD
X-Received: by 2002:a05:6102:32ca:b0:4af:5568:8f66 with SMTP id ada2fe7eead31-4af973c0ab2mr12081995137.27.1733361641287;
        Wed, 04 Dec 2024 17:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiegenlyEQWaMXSs4vqDqiWlLCU9rLscDG3ExVwTbd0zYuJWToUuNU/bX8vEGXFSmoVDfn4McVLiu08cmJjkM=
X-Received: by 2002:a05:6102:32ca:b0:4af:5568:8f66 with SMTP id
 ada2fe7eead31-4af973c0ab2mr12081985137.27.1733361641045; Wed, 04 Dec 2024
 17:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150450.399005-1-colin.i.king@gmail.com>
In-Reply-To: <20241204150450.399005-1-colin.i.king@gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 5 Dec 2024 09:20:30 +0800
Message-ID: <CAFj5m9JLC9+ao1Bhp0HfdS=7K+iKuAnkrURCd+ajDbqaZ7MYHQ@mail.gmail.com>
Subject: Re: [PATCH][next] blktrace: remove redundant return at end of function
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CycIB9ia54_jn90T-W-8fmOAlBJ3vfYAIdZ_9RdjOTs_1733361641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:05=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> A recent change added return 0 before an existing return statement
> at the end of function blk_trace_setup. The final return is now
> redundant, so remove it.
>
> Fixes: 64d124798244 ("blktrace: move copy_[to|from]_user() out of ->debug=
fs_lock")
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/trace/blktrace.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 18c81e6aa496..3679a6d18934 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -639,8 +639,6 @@ int blk_trace_setup(struct request_queue *q, char *na=
me, dev_t dev,
>                 return -EFAULT;
>         }
>         return 0;
> -
> -       return ret;
>  }
>  EXPORT_SYMBOL_GPL(blk_trace_setup);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

