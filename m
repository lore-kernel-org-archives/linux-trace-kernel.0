Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4114B945
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269576; cv=none; b=eDUHzWMwLSAFPL65aUpoT10eWWcGqdUgphVXmeQH3DsBisv2RGnWzePukQiM6OraehRqTaMycbEG29DLPRLYXuOhzNMbv9G8FhBWIZcF4V9Sf2WBKBIPHoaAYPWBKpOtVix1ZrpzzFjxfUPoD0taivA71p8LA/FKWNBMGZ1kxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269576; c=relaxed/simple;
	bh=Zjc/ukGYviU6e9aVM8L8Zjtty0hNQpOZXKBc9NxwJp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTd8ipf2q5rxp4rIUeoZwBYzWX7uUWOBqKeDmny21Olcmknsso49Rp3Wv3+7G2fONzBTy35KSP+1Ako8Px83AgAmOhCb8EqSNPIC1/F34exxyPhf9vdaLa3kYM8iHcEtPnfyZotbBYT4LdYzrkIpahROELsTcqhe6J5CEwRvZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCNu2G3x; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCNu2G3x"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc5c180a72so2404143a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 12:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738269572; x=1738874372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjc/ukGYviU6e9aVM8L8Zjtty0hNQpOZXKBc9NxwJp0=;
        b=bCNu2G3xtBTaB9c5N9vtPo/9JNZsYdyMy8UaOKvc1CBds3Z6VWCbtsxYZU5oR5hJRi
         5qhbVMsmSfmECg6DKZrvEyenSQUYhqmC3uzU6UKwtn/U9/+jjSo5Hh2VFwuB0d/Rbcb8
         uX7EbZf3NksmpwfTBTv3Fncda/jRmu6oIRYut7pGXDXdN+EFW8YdqRGPwJtDmSB8CIDw
         bw+c9CBLAZcvDE1QQBwm873t1QEgwtuQ5lU5WZ8LKdCWbty4BND5WFTOiAw04HabVUzA
         bHTgH8Au+WT+sUxbKlVWlFuOcFSVo0ZRcp4vYAn3P9dapSHOHigl94Xq4ewHiZZX8RfH
         v3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738269572; x=1738874372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjc/ukGYviU6e9aVM8L8Zjtty0hNQpOZXKBc9NxwJp0=;
        b=MthMfgae2rwDAR7QFNagT9lvmSakyLHIgGeQKhjXQdiu/PGjY/Oz/tIXSoK9WXjORZ
         IYdb6wmPRkntVR1Tg4MX/7qGYx6HbqPCE/o23YJ8aC5SucQ59fScxiWvWDvghO4Q7YmG
         4F4+iWPrDnSRa+EQZjapMa0IY7QJOH0ixS50z2RMgF7HtKVkGkBPonKrCHOpCtzg3u+s
         uZoshxUA/7R4ZREWJ0B6+lJyLwR2vrW1VUhkDtES4m+RQEQmHFWzIpa5Ye1lQezx67hH
         yr3sLQd40feDvihQtTp3LND64iebUDYlP5CESngg4bah19bnekMGASQoIFhwaT9XAvec
         5GnA==
X-Forwarded-Encrypted: i=1; AJvYcCU2IlOCYKOSP9pU7SjSQ3M/pHYegV2Vg1I/tQ/0JtYco8jakqQlrb8MorA4zHf78IIGrf0uMzPOuY5TFnd3DLAWV8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+u7O5UrXO1xioARjJmoFmCJYqQb3TUEHuWSZb0H+I9ncBQXlc
	x91qeYpAae7Y7UXfTP6I3fHtnHxdtnbKQRnICCh+EvxzT0eRTZ4ut3qltl7pDsH8ETq2IAlfGH8
	+y/JksrPzhjrlZK1QwPIQU/B5bKE1uC3fiFlf
X-Gm-Gg: ASbGncvMPnY9e4Nqx7VIld5OtkzBGXM7MjUw28RcLqVVY9JxQw5dVaMp1n6ShKrk6dA
	4X5MgiYl8oX7Sa/r+A7rBT5uSYJKUrMKJtyyz3Ig8mBeqGPUd1ky+Ki2ZZ2nU+xrDL/+YwM/i3n
	RcnAB5J+pzDvXSFWmJRcGr3yP9OuamTw==
X-Google-Smtp-Source: AGHT+IGrgFfO/K+h4P6zJOggzHtL/MGdhzkU7jyuReGUYiXkVzMuxOLtpvutFaZEw44utsgnrxP3JQA41Hof3U2VRwU=
X-Received: by 2002:a17:906:f74a:b0:ab6:d688:257c with SMTP id
 a640c23a62f3a-ab6d68826e5mr639571966b.43.1738269571901; Thu, 30 Jan 2025
 12:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com> <20250130100050.1868208-12-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250130100050.1868208-12-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 30 Jan 2025 13:38:55 -0700
X-Gm-Features: AWEUYZk2YQUyps1dQbKiaYF6w_rV2K1IgcShMby4WAMvmMJrPU_zLRbp4lsvUNA
Message-ID: <CAOUHufa9VWCsVyAdgtdJ-5cgCUkot+tdD9huU1NAAmDSKzi6tQ@mail.gmail.com>
Subject: Re: [PATCHv3 11/11] mm: Rename PG_dropbehind to PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 3:01=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Now as PG_reclaim is gone, its name can be reclaimed for better
> use :)
>
> Rename PG_dropbehind to PG_reclaim and rename all helpers around it.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>
