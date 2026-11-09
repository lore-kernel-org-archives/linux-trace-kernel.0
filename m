Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185249;
	b=FkyWyafUFt7cHoGo1aZCjM111yCQBUZqRgaqfbDaiPO2uOVQ3131MBLsEO1UEwY6JvFt
	 m8rcNi4gZ51GWd9YeLQIUuo/u0s9VOJUspMKbILLO5TcNwsBYXvDvWukAEWhWL2DATN48
	 1JVe2Wg8AOtGVTnw1PKU5tETz5CYCH93Se7zFrib0JbwR2kuUr57JF/ji2eyPtmduvqWu
	 xTM95ynhRjMjAD1Um7Cfs1XTbnCUAITih1XxZWxXbUrPK4PFbp7fIDQOQ3KS2ZoOZo2Im
	 ttt+pnCMdC6rsTuz5isOgoibfunNgexd+p3tBsXq7m8gkUGjiZZ5qaEFiSZaTNSsevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=23t6IVDbT2Ob9CsJOC8vIobPRm925WN5LySUff0XbtY=;
	b=xNFsh0E63JBmZadQ3MLA7McIlbyMBr032wvhAqLpVav1y64qjyuXlV2GZNdcyF1hgh4G
	 PlyLPKZVl3mTUP32K98V/kYQFB9qFiX/UCiCfquN9SrfM7tgLEYQcWmdLawDjg3cDQdF9
	 mZ+H3Z+4I7+7hIKQTSnoH1ZZvhZ/P8d/TMmw+nQInHGlNb3LkrbLg/zLxfDC++7qDbzWC
	 8PH/cbcSxfYxjDGJPC6fdcLQmmUZ7khOwYUZYxLkZdD/D0WGEyiLJnBls9SLDTTXw6TvW
	 dipWQIxEuqUerRqA2ls5DS8S05I4fZKsp89+fq6mt6gIMFjcHFxtwSxBfeeND2rw4fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLgBcTm1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30B606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLgBcTm1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613931F0089F;
	Mon,  9 Nov 2026 00:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185248;
	bh=23t6IVDbT2Ob9CsJOC8vIobPRm925WN5LySUff0XbtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLgBcTm1DGB0rj/L86P1T0L2vxObSUGtFNgrBmDcWRQ+oJo8xrSUQ1LUtwnxtcAal
	 iHX07MJ2iCwqvnsTUPelcwcbSL4DeXHv0lkFrZ4efbDIwTM4GZhcZZ0JUeR5wjM3jn
	 VaFafmnzjZ1mxYKmCZe/yY5i0mTSpAFAvLLImYQ+RzLMNq4ukU77c10jb1YtGOF6/v
	 iofo4pkU3+9HLqZFz6ur1qvOWrEona0+DhKWZDWBcj4O3pPxpibTQ47jwzDDO19yzU
	 ZmYoOJZnBAQ4uIEHQnxRyaacTKYJMBK0XJ29MleMJOQwjr180kohcbyaLVy6wu7mTt
	 LXEzVoOVXTxoA==
Message-ID: <sashiko-outbox-204257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] tracing/probes: Validate command prefix in
 kprobe, uprobe, and eprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179418418328.227715.10680131052179044845.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
 <179418418328.227715.10680131052179044845.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:47:27 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] tracing/uprobes: memory leak in __trace_uprobe_create() [1]
--

commit d4f1d831d5c45144f78113e0b3ef37e7d6dc9844
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe

This commit validates trailing characters after the command prefix in
kprobe, uprobe, and eprobe creation, rejecting invalid characters with
BAD_MAXACT instead of silently ignoring them.

> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 14ac52aebe346..3745eb07bd14e 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -616,9 +616,6 @@ static int __trace_uprobe_create(int argc, const char=
 **argv)
>  		return -E2BIG;
>  	}
> =20
> -	if (argv[0][1] =3D=3D ':')
> -		event =3D &argv[0][2];
> -
>  	if (!strchr(argv[1], '/'))
>  		return -ECANCELED;
> =20
> @@ -631,6 +628,15 @@ static int __trace_uprobe_create(int argc, const cha=
r **argv)
>  	if (!arg || !isdigit(arg[1]))
>  		return -ECANCELED;
> =20
> +	if (argv[0][1] !=3D '\0') {
> +		if (argv[0][1] !=3D ':') {
> +			trace_probe_log_set_index(0);
> +			trace_probe_log_err(1, BAD_MAXACT);
> +			return -EINVAL;
> +		}
> +		event =3D &argv[0][2];
> +	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can __trace_uprobe_create=
()
leak tail [1] when generating a default event name?

kernel/trace/trace_uprobe.c:__trace_uprobe_create() {
	...
	if (!event) {
		char *tail;
		...
		tail =3D kstrdup(kbasename(filename), GFP_KERNEL);
		if (!tail)
			return -ENOMEM;
		...
		buf =3D kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
		if (!buf)
			return -ENOMEM;
		...
		kfree(tail);
	}
	...
}

When event is NULL and allocating buf fails, __trace_uprobe_create() returns
-ENOMEM without freeing tail (which is not declared with __free(kfree)).

[1] https://sashiko.dev/#/bug/linux-160fa01f-1d70-4f17-984f-1bbf039dd3df

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179418408457.227715=
.1485179201014819821.stgit@devnote2?part=3D11
