Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91336C0CB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385841; cv=none; b=X3qt4d881dzCNrU8dx5nx3y8W4tfhurvajNTILY4eU0LweQD1uuM784K0SQMDUkBM31TO7De2x5r+4P9eN74y8hKrv6QFqcSa5aYbwAS1AXn7QgkBcO27sVNBqs/2bCyZmHdvKhmmLKnKA5BwlQIg6AzkApTixSg0ocLOds6TzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385841; c=relaxed/simple;
	bh=MSrTGWWpgUjiHy5RmLk5jTgqEhy8M/PxWixGV5VxN/A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=l+hwMzhI4lZDUrOunZ8n+OP+R0NgBsz2btXjZ6G6cDCn+EO+yWb7mr5J+Te1la3DC/IXwZUYIHJuJ/QZlcEbWzl0y9WNHAe8dZOFSV2+1A4YfIKX6N1zcM5p7jNu6fQ7uqVZwfhoF7Xm25K3LvAb0VqAW8/f+d35PlM2icxS2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCXTnsFv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCXTnsFv"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b611274bso1166548f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773385838; x=1773990638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSrTGWWpgUjiHy5RmLk5jTgqEhy8M/PxWixGV5VxN/A=;
        b=GCXTnsFvbiI5fFN8iVVrFqP1pA2/OaNjDupIldZcph4yge9hS5+TO+vQ6NPn9kOrOc
         yVK7adFVg189OUvP30ADyknPaK89keJQoKX70dxOGRCMHjypWh8vCVhrIBHQqte4Va+S
         9D9lNJb4PdNtmbb/fVIpO8DU6JoUDZrfTlJCwdaLZQkNgvoP0MzY9qbBDMVsOHoDVAuC
         xTNqOCJn1U1RwEpVpJ+R3FsEWkHToI/UOgueXiwdfZYN+RRPhZ3vqdOgXlAmogaoeajg
         bPT4PhJbnHuMCv/RK58iLLhh4cBnah+88u9isoX+Lr4NQ+wKPiHFCv4ZzLuA37Th1aS+
         Lexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385838; x=1773990638;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSrTGWWpgUjiHy5RmLk5jTgqEhy8M/PxWixGV5VxN/A=;
        b=amFEeGg0HMJKjeKNNvQt9lLcBp7gX6FCIr8EWShz/hPLKrsDuNGF/SX+ET717QgLb1
         wQbcApmT04Nd0Cfc4NugvakdxAspfpy817fAIoy5Od9p1bYNLUN/f2ZBDYmHr2I7wZGh
         53zzgul7M+XQ9HElYLC2F9jpWYh0BfzUxStbl65NPenEhhFalrQ0nvoqyNO3GhTP6nQ4
         XYEXV6+ef7tOvdD5XRt9YBGlP3xx22gKMBS6f52hLtY6BoNfuh0+aP/xnD5p884kezLe
         Q6pJu8QJ2gdznJKlCmQvjhD/Vf4VowVsVQf8NFnBFXRtEt+7lcpAjNZ73fkcbmaBR01n
         bpJg==
X-Forwarded-Encrypted: i=1; AJvYcCXh8TRrUes0lbco4nBCKc983xMdUUYnjWqIkkYzqwMIrGJOBqZdQYRDXI1D4d+4LVIH0mtPIO99WZax2vGaHolYM7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4vyOFEdQtCCCAh8CQ223KLN3uBPm88lfS1ySOfbdEDZ4lP8k
	082UsVsecIWZlfimTqj33kGC21XZlaI84kniybbcEumbvJlXwuVPnfcp
X-Gm-Gg: ATEYQzw6HTk/OibqbSE+9rRpeGhpv+HGP5Wdn3/i52VqGtHzrEyFsZfbv1lwujoTHRI
	cRY3fHG1cl098URYEKQOvXKmkb4G2D3VJVHh7auQ9HeYsu8l54rMZICWAQWSfZPPOn91bYNBDv5
	tCo+VCWGbXeassaXBPgmT0MaB6WZMK162pJ71ilmo0YAuzlnYUE1T1ImBUoo7li5zQsVvlr+pQ0
	D4N4jPmWtwQSQ83qW+FSa/5qZEebNAusUJx/WBtV1YbKRivbJIX9XtSwK7yCmsDbvA/RvTv/GXW
	fL+U0zNs0t6I67yBqkFBS0uRiJsvNnJcL/jL4fq2G3sgTgRQ2KY+F1Gryz9bb5jYs8iidYNFuCZ
	cHcR96zuJmEvHp6QzfnouchR6u1muackRkgcQ9uqDXGzzY/I/bHsSiWA6Rx6Z5OYT+1epsGE2Xq
	5KtKq88ymI/eNhPxitdSfvVUV/1Zw=
X-Received: by 2002:a05:6000:24c1:b0:439:ca36:f06 with SMTP id ffacd0b85a97d-43a04d8dea3mr4437139f8f.16.1773385837445;
        Fri, 13 Mar 2026 00:10:37 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ad9asm15805120f8f.7.2026.03.13.00.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 00:10:37 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:10:35 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Law <objecting@objecting.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Message-ID: <8cb35f58-f54b-4690-a9e6-fb6c0064ca33@gmail.com>
In-Reply-To: <177337553551.416919.11217619471547711262.stgit@devnote2>
References: <20260312191143.28719-1-objecting@objecting.org> <177337553551.416919.11217619471547711262.stgit@devnote2>
Subject: Re: [PATCH] bootconfig: Add bootconfig tests about braces
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <8cb35f58-f54b-4690-a9e6-fb6c0064ca33@gmail.com>

13 Mar 2026 04:19:06 Masami Hiramatsu (Google) <mhiramat@kernel.org>:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add more bootconfig tests for checking the error message of
> non closing brace and max number of nested braces.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> .../bootconfig/samples/bad-non-closed-brace.bconf=C2=A0 |=C2=A0=C2=A0=C2=
=A0 4 ++++
> tools/bootconfig/samples/bad-over-max-brace.bconf=C2=A0 |=C2=A0=C2=A0 19 =
+++++++++++++++++++
> .../bootconfig/samples/exp-good-nested-brace.bconf |=C2=A0=C2=A0=C2=A0 1 =
+
> tools/bootconfig/samples/good-nested-brace.bconf=C2=A0=C2=A0 |=C2=A0=C2=
=A0 18 ++++++++++++++++++
> tools/bootconfig/test-bootconfig.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 =
9 +++++++++
> 5 files changed, 51 insertions(+)
> create mode 100644 tools/bootconfig/samples/bad-non-closed-brace.bconf
> create mode 100644 tools/bootconfig/samples/bad-over-max-brace.bconf
> create mode 100644 tools/bootconfig/samples/exp-good-nested-brace.bconf
> create mode 100644 tools/bootconfig/samples/good-nested-brace.bconf
>
> diff --git a/tools/bootconfig/samples/bad-non-closed-brace.bconf b/tools/=
bootconfig/samples/bad-non-closed-brace.bconf
> new file mode 100644
> index 000000000000..6ed9f3363dde
> --- /dev/null
> +++ b/tools/bootconfig/samples/bad-non-closed-brace.bconf
> @@ -0,0 +1,4 @@
> +foo {
> + bar {
> +=C2=A0=C2=A0 buz
> + }
> diff --git a/tools/bootconfig/samples/bad-over-max-brace.bconf b/tools/bo=
otconfig/samples/bad-over-max-brace.bconf
> new file mode 100644
> index 000000000000..74b5dc9e21dc
> --- /dev/null
> +++ b/tools/bootconfig/samples/bad-over-max-brace.bconf
> @@ -0,0 +1,19 @@
> +key1 {
> +key2 {
> +key3 {
> +key4 {
> +key5 {
> +key6 {
> +key7 {
> +key8 {
> +key9 {
> +key10 {
> +key11 {
> +key12 {
> +key13 {
> +key14 {
> +key15 {
> +key16 {
> +key17 {
> +}}}}}}}}}}}}}}}}}
> +
> diff --git a/tools/bootconfig/samples/exp-good-nested-brace.bconf b/tools=
/bootconfig/samples/exp-good-nested-brace.bconf
> new file mode 100644
> index 000000000000..19e0f51b4553
> --- /dev/null
> +++ b/tools/bootconfig/samples/exp-good-nested-brace.bconf
> @@ -0,0 +1 @@
> +key1.key2.key3.key4.key5.key6.key7.key8.key9.key10.key11.key12.key13.key=
14.key15.key16;
> diff --git a/tools/bootconfig/samples/good-nested-brace.bconf b/tools/boo=
tconfig/samples/good-nested-brace.bconf
> new file mode 100644
> index 000000000000..980d094f296e
> --- /dev/null
> +++ b/tools/bootconfig/samples/good-nested-brace.bconf
> @@ -0,0 +1,18 @@
> +key1 {
> +key2 {
> +key3 {
> +key4 {
> +key5 {
> +key6 {
> +key7 {
> +key8 {
> +key9 {
> +key10 {
> +key11 {
> +key12 {
> +key13 {
> +key14 {
> +key15 {
> +key16 {
> +}}}}}}}}}}}}}}}}
> +
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-=
bootconfig.sh
> index be9bd18b1d56..fc69f815ce4a 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -171,6 +171,15 @@ $BOOTCONF $INITRD > $OUTFILE
> xfail grep -q 'val[[:space:]]' $OUTFILE
> xpass grep -q 'val2[[:space:]]' $OUTFILE
>
> +echo "Showing correct line:column of no closing brace"
> +cat > $TEMPCONF << EOF
> +foo {
> +bar {
> +}
> +EOF
> +$BOOTCONF -a $TEMPCONF $INITRD 2> $OUTFILE
> +xpass grep -q "1:1" $OUTFILE
> +
> echo "=3D=3D=3D expected failure cases =3D=3D=3D"
> for i in samples/bad-* ; do
> =C2=A0=C2=A0 xfail $BOOTCONF -a $i $INITRD

Acked-By: Josh Law <objecting@objecting.org>
