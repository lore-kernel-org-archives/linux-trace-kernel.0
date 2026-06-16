Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49442DFF2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608465; cv=none; b=eJJ0WwcEGRKryi2CwUYhlbgyfOjzuj/iaWvhl7/IbSC6M+9oClD21TPVySW187BUyQkvHtzKeD4lmyRydX1BHMJj8mHyOtCn236G0qm49Ij1iRQA9/qrtr0RPSNtHUOHPCPvsdHA1KHmZgllIDTVPdfPgMTTR6H71W+R0q1hZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608465; c=relaxed/simple;
	bh=OQ7dkFnQJlc0ejXfMEENqq9M1D366YdvQk/DHWariCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hgb/vQiTD7mu4obc3GeHYIaZOKLnBM1yWWX3BWg7G/EDLjlUNhnG3JWWrCKiDMFoJ84pUvE/+jSlezwc6gkGUUZARHHJkzWeUENcOAqz+CfZH23Gqya7F/Z75tRaxSFUVEvnH/a3h2w5XVth1QT3v7Zg3q31Sep2L2PWt137Jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1jzqPRg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1jzqPRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781608463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6naCJKi/lyJIy5fzCdFSeiS5sUypi98L+LX13ZNgRaM=;
	b=W1jzqPRgR5RoN99kcijqfXjj8nmomFozAJPcbcof24zgINW4S5dJ+UuY2m2NO++clwz2Ku
	bdptV4kGTKy67LY16PrQJ455jcGXwy0EVZ8B/m1wF/FjBIFCLkFrgZ46dD/rJpdArY4fp1
	KxegEixw+OcjdcCErLpazOHyi1dZqj8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-fpH-k-wpMnKN0nieBysEoA-1; Tue, 16 Jun 2026 07:14:20 -0400
X-MC-Unique: fpH-k-wpMnKN0nieBysEoA-1
X-Mimecast-MFC-AGG-ID: fpH-k-wpMnKN0nieBysEoA_1781608459
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b61243easo47452885e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 04:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608459; x=1782213259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6naCJKi/lyJIy5fzCdFSeiS5sUypi98L+LX13ZNgRaM=;
        b=VVNcK2YJNW+K1Ot4nMXkKQ578B/6kpA5CGzSEe1ge5ZKIFj5GlWBnEksD4xb9epF9n
         ryRNiVs2mDk+hGtREdcTUetWFekSTAYMj7xwBd3JVTAWa1UrYQ2+q/PKnzWpJf4fDsta
         rYe057olUQAyfpLlqNQwZYomR81qltYn0oZJZiZg4dFhmLfMxtck+j6Pfr3nVJzFvfA8
         2uNwc0EIEs7muyHPV4X9TOUGY0QYVjeOcAEgqam1/u9bGoPY9Oa1njqHDwkntao/dutm
         mSLueY4tajprCNURSQ/M2dcXUy77Sq0z7pHoKMj1ik3FHThw0rbb3ueLWEeTartgg1BU
         TXGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cj08v3aSeFvucufAxoc9OH0p+g68g4znYf5nf8GEWITVG+Z/tf2pzODIa/6V0kbco+mFA9+PZDGXHySaqwE0ycHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwprJiS77n/KB5SVAvToa7LDtbT5dLitwxUl4l/SDNR4IuSssn2
	6TeNN6phGBoklduYIJmUQKL7S5PndSO3/jQ5g7XER84Ren5jfiePoWUtJZQlXySaSOMa6aqcXmN
	xe/Os73b8+JiiwF6aGrn78kQ3WLYVaqSLz7uvs/e8/nbX2FxiU30+6EzEF1h80ODqh4DTq+CkPY
	oWK391mg==
X-Gm-Gg: Acq92OFilsnLgS2PISUs/d5Kusx7cTTwFm3ZcVxfPCwSDNxjGwc8NTtD7SPYelKRBHF
	Zrgb0ipDXgnJoX7C4PNhG9Tq6PCnH0FPXppb/PDVWL2N4laI8B5pTxrbkv1R6QBpH2qELn7B1ty
	HNO0l2kdNggoQxv15EBWIc8Te97a9JeaXOw4relKCnuOBmM6wtJAOjO9/aZiVFXS+jwN4xmFbtB
	OghIwI+MYy56zSAP0xv/SjUd3p6MD/O34gDAuXLeiID0Nnb0ss6XqqfV3oMqpLhC0fA5S/QDkUw
	HTc5+dohZEOhVP5GQ5JlVy1e8XOmFHMtxk3VC6KZze+4Mry/sKFS7LADxav+18kGNmi+SvBmj4c
	EODOYzQZ0zyMCMym5TohshFC1MQ==
X-Received: by 2002:a05:600d:8494:20b0:492:2d84:fbd1 with SMTP id 5b1f17b1804b1-4922ff7bc9cmr41223965e9.15.1781608459345;
        Tue, 16 Jun 2026 04:14:19 -0700 (PDT)
X-Received: by 2002:a05:600d:8494:20b0:492:2d84:fbd1 with SMTP id 5b1f17b1804b1-4922ff7bc9cmr41223515e9.15.1781608458868;
        Tue, 16 Jun 2026 04:14:18 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4fd31sm52422755e9.4.2026.06.16.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:14:18 -0700 (PDT)
Message-ID: <90ba0c6d4e6f0706acb78197a1607968472da6bb.camel@redhat.com>
Subject: Re: [PATCH v3 8/9] selftests/verification: fix
 verificationtest-ktap for out-of-tree execution
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 16 Jun 2026 13:14:16 +0200
In-Reply-To: <95e700c62601cf432842269d89a86a492d073f0e.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <95e700c62601cf432842269d89a86a492d073f0e.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bYqppAtv3LgQtDt_noN28eW7ut30joSExNzGRvLRnrw_1781608459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> verificationtest-ktap used CWD-relative paths which broke when
> invoked outside the verification directory (e.g. via vng).

I still don't get this, I even run from my home directory and it works
without this commit:

  make -C linux/tools/testing/selftests/verification/ run_tests=09

It builds and runs your new tests just fine, how exactly do you run
them? vng shouldn't affect this since it runs from the same directory
as overlay mount, what errors are you getting?

The only issue I see is with the read only filesystems since ftracetest
attempts to write logs, but that doesn't seem solved by your commit
either. Adding the appropriate rwdir lets me run them just fine:

  vng -v --rwdir tools/testing/selftests/verification/logs -- make -C tools=
/testing/selftests/verification run_tests

I'm suspecting you're trying to call verificationtest-ktap manually
from somewhere else to call it only on tlob/, but that looks like
asking for troubles. While you're at it I don't see why you don't just
call ftracetest.

Gabriele

>=20
> Resolve paths via realpath "$(dirname "$0")" so the script works
> from any working directory.=C2=A0 Accept an optional subdirectory argumen=
t
> interpreted relative to the script's directory.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0tools/testing/selftests/verification/verificationtest-ktap | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/verification/verificationtest-
> ktap b/tools/testing/selftests/verification/verificationtest-ktap
> index 18f7fe324e2f..055747cef38a 100755
> --- a/tools/testing/selftests/verification/verificationtest-ktap
> +++ b/tools/testing/selftests/verification/verificationtest-ktap
> @@ -5,4 +5,6 @@
> =C2=A0#
> =C2=A0# Copyright (C) Arm Ltd., 2023
> =C2=A0
> -../ftrace/ftracetest -K -v --rv ../verification
> +dir=3D$(realpath "$(dirname "$0")")
> +testdir=3D$(cd "$dir" && realpath "${1:-.}")
> +"$dir/../ftrace/ftracetest" -K -v --rv "$testdir"

