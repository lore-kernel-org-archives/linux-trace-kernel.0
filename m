Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D2D56329B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881696; cv=pass; b=GYNJeqwHvSB0NaWBiEcPYoFCDLDUxTbRAJfKBUiF9+bOcOeidFk7t/800cRwYBv2uRhPN5+IRLpNgPvbtGZ8xS/TIyTyBxbKbbbZVoqbiZsTl7b/L7+eap+luViJKTjTI6lU9OWUiFgfLUrn9VnZhSpGWebYYjnullM+oe/yoNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881696; c=relaxed/simple;
	bh=GBED/SDYaogbqorGAh/G24+xZmO8kz03GCogtDApe3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhYHviAP1fi9jXZbSTj3F6FLxcdVo7jJorU5oit8WqrO6CrIH+xo0ITXgUWnOENtW9FbrL5VnAYs6xdzAPHP1j95ozIUsfvoUzyh82yAj88SSmjpv4qMJH+OjowtLDvZevVMZQldPg6tpOXyv44thAVh9Sx1Z3/VRhc8qB4XbCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqBXqJNN; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqBXqJNN"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66e63afda8fso3861033d50.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 08:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881687; cv=none;
        d=google.com; s=arc-20260327;
        b=RsYVHHZl78/RLfc+94CkMk7jJ9vqKoJDpKaPw2/s8Rfi3Te1YVOa4mOgUStLSYnbCH
         oi2Vxkv39CWVDl4aK7Xi9pMqh8PfvOZRGYsKQ4ulEHV6CAQBMEVudVQdvkycyLFM/aJS
         QHl4WC6sZ+SDJD9pFC+plIfddHjasvnop2c3QVQ/Qk5fJSNp20+OQvqczTzFGvJb/msg
         NZ8koNqOlIGq1GsNRRnhgnO6xq3oI9dkQGFaFOPauY3+oScTxppBj1F5ephrm/SamvMl
         1o2cWOkx5PX5x0mgfa6UnNhz6NfK0zwQVR27PC9T/bFizTS2il7Is/5bKpKhyC5nlbUX
         4FnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ag/6JOE4QZd3KV3LuQrhVTWPmbIfMwEdth2tbHfGZAo=;
        fh=C/2jUE2PUu6O+WqQTbcqGhv25fTWZdxYrll9F/Rq67Y=;
        b=KK6iItiOZH8TS4bC0CuNuUimSTaHXJdOelcjJZ1HT0hDxq8CVFa/zGRVnFcNwq9D+3
         K6wzjwyODGygaAhMUxLGZ0/XvVVYRmD5Kg6PKrv0mbVfNzya/eMRq4gYCfVgGQ54DIFy
         JzTnuz9jN7GvMODLAiAb5nurUKGZuFLl0JExPhxYNry175/zsbpI1WnwwdrSC6kFnlKC
         YNa2vn9PWJ1fdAKpUZp1FkCgNHY8zkSrxrJ2pGDxwmth209qEXSrmYBscoYia12yNRad
         uaascVDHQmQdq4ay5AfYq2iYSnCe2UyRoF0MWdQhp2jPD2NQAibIiK0hpc4zBdRNIqgN
         DGMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788881687; x=1789486487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ag/6JOE4QZd3KV3LuQrhVTWPmbIfMwEdth2tbHfGZAo=;
        b=sqBXqJNNTaYB416puoaJHgtHbjRCQvpr2YLhchJl/+tD5OUORC0k/Ns8xqoAikXmdb
         QMqMrBXI8qWW9L8P9erCxAhLQhoLVSxI63idxONwPS/RZuUmk5xxnWEXp67ilkHpIPYs
         w+Fb3KL2b76K8B4StoFp2lqJy7zi/U/KyiXSaboFkCTOSTGR3OGWTEmne8XYY6AMSWLs
         RvSOHBKmTA+oFI8jrvEJM1Fk5n4K8n2mY5Lz23wP33QqSvQbsMuc7UKluHs+Z3lN+Jbb
         volEfeTZV1CEsohp18FmPOscRaIotID2f7hcHWU4WOH4is+x4IwTDcOPSDKdIw7i/RZK
         ONvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881687; x=1789486487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ag/6JOE4QZd3KV3LuQrhVTWPmbIfMwEdth2tbHfGZAo=;
        b=Te0m4cNPk02t8wwXdX3IO9jOd5EndgF9S4Co5SsWflyKLR6JkMvZD0oVJ6fzJgzNdX
         Xmr7+2n0ElLQ68ZgCXLAK/CVzNWDBkHTtU0JFj62qGHUdF6ulWtPq7v9nX9KEoOoc/kh
         Jj4IMTYF4i7guSUE/E7R4Hq8nfiCh8ACcOlk4zSlrDnNM3HMBugKm/XyHzwyYk5yrZjz
         4p+y9cWEkA+6gaWMGVQexZ6C38mIqlLdWMT8Q03V5o8YN+X02wDI3M0fSkzl8c/SqKU8
         XNJ2OW0yeIXBFDr9GTCatY6pZZ/UYBqetwIUyewZcIcPlrjkEwzz/ynLWIexUcwI3G2L
         Oa/Q==
X-Forwarded-Encrypted: i=1; AKwUvByv4GNUELIGRJtmdGCv/UD6g5tH/KrdTNj+B5LOQBvLEHDXAe/D2/xjt+dAe+ZbWcrAoxKqpy/idjmpFprT4wx90mY=@vger.kernel.org
X-Gm-Message-State: AFuF++lKuMTBayw3ivYw0loa7gM7J7JjfzsPKPxrcHaoAz9U+FxU6PJJ
	TlPkwFnV6Sl/Xg/bgQ1AvPHY/vt3l9WG0+YBS1BzyVbmuZxJWp9mso8VoSdVQuAnttReGjx/Yi9
	VJzIOmQ4MmtADOhOknUcnbC9T+Qayj44=
X-Gm-Gg: AYBFou1C9DuGiCtb/BwVmkiYW+afNZG0xUoel9BfnF2YFYg+fCkRORgOICtC8lVOi9V
	lWilKdMTLQyWCEUTAb1ZdrkIchB/zHDiTryZIJZIkfljgGBZUaR3LWmTVi134Woo8by8MAHa/TJ
	kgGOksWMSQmJx3liPbXN1x8unbZq7HjRK8SMUweMGlDDfMc1cg7W8Y4/EA88/Pu0ecB1/MLkJ4r
	cTvkJrpG3QHnJ/SNki1QdcdDQn0FWpJBQWhjhpIMHEewIOiPcD67H+oMPY1Sjr9hDehuq0UjEB2
	RDLoYFTKPVOfLDKVZ8KbIbS+HlXyWGnUK8Cft6eQ0A==
X-Received: by 2002:a05:690e:454b:20b0:66f:c1d5:cf78 with SMTP id
 956f58d0204a3-66fc1d5d05fmr5692554d50.53.1788881686859; Tue, 08 Sep 2026
 08:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905141637.1547429-1-ekffu200098@gmail.com> <20260908104629.e7a85a90e376b843dbc51dc7@kernel.org>
In-Reply-To: <20260908104629.e7a85a90e376b843dbc51dc7@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 9 Sep 2026 00:34:35 +0900
X-Gm-Features: AcwNN1W84vc454fRbDSYQRJZlI-4LhRrNKvccTiKIF0N0VfPexcPXdsUmd59F8E
Message-ID: <CABFDxMEot48G141HrLT-4_H1xKez58UhK8yFMNkWpqT_MOXu7Q@mail.gmail.com>
Subject: Re: [PATCH] bootconfig: remove unreachable index checks in xbc_verify_tree()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 8, 2026 at 10:46=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Sat,  5 Sep 2026 23:16:36 +0900
> Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>
> > xbc_verify_tree() checks that every node's next and child are below
> > xbc_node_num. Both fields store the index of an existing node, which
> > is below xbc_node_num.
>
> This is a kind of foolpoof/defensive checking. (so I call it verify.)
>
> >
> > So remove the checks.
> >
> > No functional change.
>
> Hmm, OK, I think we should decouple the logic/implementation
> verification from runtime verification (e.g. wrong format)
> and move the former to tools/bootconfig.
>
> Thank you,

Thanks for the review, Masami.

To make sure I understand, you mean moving the foolproof check after
xbc_init() in tools/bootconfig?

> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  lib/bootconfig.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > index 89c88e359179..d383430637ee 100644
> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -1005,7 +1005,7 @@ static int __init xbc_close_brace(char **k, char =
*n)
> >
> >  static int __init xbc_verify_tree(void)
> >  {
> > -     int i, depth;
> > +     int depth;
> >       size_t len, wlen;
> >       struct xbc_node *n, *m;
> >
> > @@ -1022,17 +1022,6 @@ static int __init xbc_verify_tree(void)
> >               return -ENOENT;
> >       }
> >
> > -     for (i =3D 0; i < xbc_node_num; i++) {
> > -             if (xbc_nodes[i].next >=3D xbc_node_num) {
> > -                     return xbc_parse_error("No closing brace",
> > -                             xbc_node_get_data(xbc_nodes + i));
> > -             }
> > -             if (xbc_nodes[i].child >=3D xbc_node_num) {
> > -                     return xbc_parse_error("Broken child node",
> > -                             xbc_node_get_data(xbc_nodes + i));
> > -             }
> > -     }
> > -
> >       /* Key tree limitation check */
> >       n =3D &xbc_nodes[0];
> >       depth =3D 1;
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Best regards,
Sang-Heon Jeon
