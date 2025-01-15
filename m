Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFC1D8DEE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974396; cv=none; b=DCs9HGuYhsqv7CBSU0T2b3nEJyNKUgj59HKBMtEtr0zV0chkZMLpRWjE1yvfahNQc6k3P7W2c8wQmpD2KQI2Q2gFRQ9gXlnPN3T49D3u2ZMrVMYT5D22fZyb7N8OucMbqS63kFRRlTzuyL9AxqzEWDhcS1lyfmFecT95Z/jF7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974396; c=relaxed/simple;
	bh=VdXo8lbXht5SZgkZQ04ipp/CMqgcMbj1MEn0xWqPJMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD81O0Gv5lxmg83vRgYyyF4i030dGijO7CNYS9h63anEkDxiwY4gTy2lhlDbArv4w9fpBVPyfcx8dsqj81o2bSXQjVt029xpT4ZtfpcqnzUQhM1puDxhA8CjgYha9Og2GduAfqxKJ3OPQGziKWlnTKWDYwXKny/JRK3VRtvWQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDFgmcnJ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDFgmcnJ"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85bafa89d73so25313241.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 12:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736974393; x=1737579193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdXo8lbXht5SZgkZQ04ipp/CMqgcMbj1MEn0xWqPJMs=;
        b=UDFgmcnJ09TDFATDfWJzibjN4HOKnt7F0JjQCJligN2bGgmU4dyHkYtckWD/oh+qyH
         TKKrmH1QExYvFdZIAm9E36DTDj1HW3sY/3PYYN+Vu6oOrcWUEluabbWaJCTlgGyeSNke
         KFkUiGQRl1YN00CCg/ns/mkM4r9JgG5Q0yXZeDedJWdzfvcz8HB1Ke/FbE5AbGYV9dMf
         q2cx79dp3lmFlIbtiDRHs4ZQG9dE8AGlJGO4+tLLW5wE9t3hBSDibGIs/Rs5fbtMrRJZ
         QN7D7LGrqxA9uw+xcXfpJELOE2WBugB61rfjVQR5/GoDAbQBlkO/8mNdVHScHQFRDZts
         iFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736974393; x=1737579193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdXo8lbXht5SZgkZQ04ipp/CMqgcMbj1MEn0xWqPJMs=;
        b=kWQVwIK5wVPEIHXpIh+ykMOHgCp1KXPm6JFuayhSoDhlp+rHjBcms64PCP9V/JYYVR
         Y2SUQAnGDsZT1EjOBEF7UD6lCic4AjHoS9O2dubovkB2X9XNQQOebgpSxoTTGPqYzBVk
         kX25IfbXvA4sSpbyJRI7tr6JstU2coIsB/E19RqYOTJiQYeQCyMSGQ43Tfnd9SkONX+1
         JMSrF2n1oZlG8+b6oK6HHZF2x0dhblapWpeGlmBL9ies26J2SSePnQEusQb6y61vf6GD
         DHJA2LJqWDAWPEp4XzE6xaWl8NQh4TpEIERqEfHSWN4AQgPPcKJtLWeczh+TA3nHfUV9
         Cz2w==
X-Forwarded-Encrypted: i=1; AJvYcCXV0lFYWWgQ+5j3cbEGIlD3sEhE41qJUVyOWkIHXB4V8lkFzTRcHxdHWWpoVJkSUtPzJVvSYs5HEMyD3asoHrYMfcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBs9IoaTqFDQHdc8nfgWvTYWB0SfMScBzCyx/dubFAnDsfPq9Y
	sJd2BByIl0iMQ+7CnvEs+nc4XJCveAcNCd8LEM6VhmscmaM6OCYfo0lUosWIAJPqosIXcHcLrfD
	Xp6IubRx2xx2ruB+V1GQPRBmMTrE/3r5f/M+5
X-Gm-Gg: ASbGncuzenpeYPuzaF8HOC/nZoHPfTppQamdI0lHypjYCIiQuOzWOLIK0zE5YX9DVz3
	SwddjkdpbRYhJkHyKnUJM8b7hP2q52S3rgfY2aWCU2AZB4TYNvs5dkXiy2VaeWXWKM+Qq
X-Google-Smtp-Source: AGHT+IE7UsauDDLDB3PU6I85iW+57wTMyoC2RI6ZhjsNUrio1gBO9Rw8foY1mGOBbUURNkj3/A70Nc+YgN9e75p3kqQ=
X-Received: by 2002:a05:6102:ccb:b0:4b6:20a5:776 with SMTP id
 ada2fe7eead31-4b620a50949mr21061479137.17.1736974392789; Wed, 15 Jan 2025
 12:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com> <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 13:52:36 -0700
X-Gm-Features: AbW1kvZLvuakft1NqA0r5gmvnmIH6WfLrEQ0-PFFagHKXbdONcPPwciIY5N5R1w
Message-ID: <CAOUHufa8FZY0tQ8Camv7mHN9tWPYLxcpjt5rFTDLg+NwYULOQQ@mail.gmail.com>
Subject: Re: [PATCHv2 11/11] mm: Rename PG_dropbehind to PG_reclaim
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

On Wed, Jan 15, 2025 at 2:32=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Now as PG_reclaim is gone, its name can be reclaimed for better
> use :)
>
> Rename PG_dropbehind to PG_reclaim and rename all helpers around it.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>
