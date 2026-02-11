Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756434F256
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Feb 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797816; cv=none; b=hPc6L8doDSVMtxT2GOYCHAyEsO2v83f6Hq/kgeHOYxPHZ8GEGJ2wuP6bF6tPbkw7m+1zyEX/efRzzglg2AaZmRpw9kWrG7og2L/SNNQ5l7+eeYRSc5Rkzj8uLyzERztkO54d93hzVJUtRI9qr24okfCm3DfKhezim09PLnklprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797816; c=relaxed/simple;
	bh=NiHEKNGKnSGeH3FyeVbc6gUW1/MQxMwwkjnhJPIxE+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAin2YrP54au9sYJSZ7TXXUGQqp7GL5TbKgTi6+0kb9TlG6VdzlhAz/6QlMyU/AEBFi3Dd/ecMpRLgVIsqRlIV4ivteWvVgjoJ3Xd/t0uPyV2kFv6GYVJTtgaWKGqRHBdPMLs9JaZB3Z19ZW54Ez25wxsIB6WhBfmLrLLz9BtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+bIBJpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+bIBJpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770797813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NiHEKNGKnSGeH3FyeVbc6gUW1/MQxMwwkjnhJPIxE+k=;
	b=b+bIBJpyugtV0258GpsJ/hxnqwuM4eqtZNYQ/2Rb+M4ArAW5xHW3G5A/a15+fCNsOo6NVy
	//njf9jtztBqdB6UMdBF4zbr2uOQnzYhkkdfompVf2EHdiovAQ5N3PrKGk4Fkz6HSMfMg+
	+NDIg2DiGIVdmX2uU1c+VdTyuUo72yo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-fGoAwk9zPjapdhN5zbFWdw-1; Wed, 11 Feb 2026 03:16:52 -0500
X-MC-Unique: fGoAwk9zPjapdhN5zbFWdw-1
X-Mimecast-MFC-AGG-ID: fGoAwk9zPjapdhN5zbFWdw_1770797811
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806fce5ab1so35721765e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Feb 2026 00:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770797811; x=1771402611;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SX4sleE5xgzwOzs5l1BotG3ooT9aeHoVAoWb2ZNeBo=;
        b=TQ2HMnf5vw89+VASgbvuWfzDn5vBxPQEhWATLioMJEqLKOP0qZ4CLYAUsNGUV41bHy
         k5qcXkATQgGGUYIzasYMVxYbcz4FsorwBkfX/o8LQWBAGpgtcoL4NQrIgsurLO575/LX
         lSha2/w+6QxcqTSulzFLwAwc4a5mSwb3PP2cQR5oQTr+qmdrLLMxjRC9XUKbsmAq6b/i
         VIxCB1W66hHXidIoIE/k/48smdCwEySBM5ll9wdwPp8UUPUSQX09ynvYW16jAmOYC9CU
         faKpgusdxIaCsQ07r+IjspiAZx+MPOxqwfgAJvMJdj+SUHQNXfnTkSmKnZ7S+7d9SKMY
         ijvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGXLrrjQLA51H/5mJ6iv+r77ncFHErAk2lqs53CXNSmHu3WVlwQnnOs1mdJIbiVVmFt401jyPH/rKJps4Pf+2k3Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdzhMPBHBTYXugoefJEXSEQj8476BEPx0UfF9hl1ZILB/JdRN
	X8i842ya9qA9QDUjKph6xe319tp3hRZ92AakO9jCWEuEZek5UnsgWg+a6Js84YUcJJ7qaQiqdWo
	7eX50Yn0JIPZtnYoSspz2GRABXS2PIwdSHYSvdG/d5K8u2zyhxuMCAXHCtuX/d4sHZSMHTTSEr+
	mElzBpinjr
X-Gm-Gg: AZuq6aIlBxUhlZOW2iIZonZ9OX96BMLSvoMm19+bXkZ+uu4NgIdMMxxCUG7EpST+E+B
	Ci02aM9PNYHZ9vmM7M8WpYdMRLKKCTfAOkRLSVnSRm0qMDIxgeFtR6eqzBlKCjdAejERi6vyhRD
	8bQGKyLSI2BefcDpIpRvILvbb8DWekzQtdkx0E+H37rOZozFfG1LDv/3r7sjQ8yuxdWHC3c9YIp
	tkfiBe2UCPZjnU8+5OnyGg2tOPGi5Hqa3FW6wZynEI2ynVLKZDJ8/NfAur/s5n5Adw7IALMIBOC
	b5MaRe4SzW4LJbzRqWKuS51CKOv62ge/mKZxypg5XYO7/dYVge3zYnxrQU5z5y4BkO3GNrsdIGd
	ndp6W1eTNh81cmqkt4ZiS6EgLfto93/7fnKX3o37wTcFUmNNpdfGkj8AIZ7buTQCacGwZ7rnhhF
	L0n5WH+60q5iQHmsIa2DxG
X-Received: by 2002:a05:600c:a00f:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4835b90c8f2mr19871405e9.9.1770797810760;
        Wed, 11 Feb 2026 00:16:50 -0800 (PST)
X-Received: by 2002:a05:600c:a00f:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4835b90c8f2mr19871115e9.9.1770797810288;
        Wed, 11 Feb 2026 00:16:50 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d9895b1sm24073995e9.1.2026.02.11.00.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:16:49 -0800 (PST)
Message-ID: <ada4f1dc5ca34d8adf3d68396080e6d2e5e834eb.camel@redhat.com>
Subject: Re: [PATCH 1/2] selftests/tracing: Fix to make --logdir option work
 again
From: Gabriele Monaco <gmonaco@redhat.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt
	 <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Wed, 11 Feb 2026 09:16:48 +0100
In-Reply-To: <177071725191.2369897.14781037901532893911.stgit@mhiramat.tok.corp.google.com>
References: <177071725191.2369897.14781037901532893911.stgit@mhiramat.tok.corp.google.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xiR0g432Zq_lZ90POuuWAvMa8ObDS1VP7Wb76rta2Ac_1770797811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-02-10 at 18:54 +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Since commit a0aa283c53a7 ("selftest/ftrace: Generalise ftracetest to
> use with RV") moved the default LOG_DIR setting after --logdir option
> parser, it overwrites the user given LOG_DIR.
> This fixes it to check the --logdir option parameter when setting new
> default LOG_DIR with a new TOP_DIR.
>=20
> Fixes: a0aa283c53a7 ("selftest/ftrace: Generalise ftracetest to use with =
RV")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

Thanks for catching this! I should have tested all the options..
The fix works fine on my side.

Tested-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0tools/testing/selftests/ftrace/ftracetest |=C2=A0=C2=A0 18 ++++++++=
++++------
> =C2=A01 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/ftrace/ftracetest
> b/tools/testing/selftests/ftrace/ftracetest
> index 3230bd54dba8..0a56bf209f6c 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -130,8 +130,7 @@ parse_opts() { # opts
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift 1
> =C2=A0=C2=A0=C2=A0=C2=A0 ;;
> =C2=A0=C2=A0=C2=A0=C2=A0 --logdir|-l)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOG_DIR=3D$2
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LINK_PTR=3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 USER_LOG_DIR=3D$2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift 2
> =C2=A0=C2=A0=C2=A0=C2=A0 ;;
> =C2=A0=C2=A0=C2=A0=C2=A0 --rv)
> @@ -199,6 +198,7 @@ fi
> =C2=A0TOP_DIR=3D`absdir $0`
> =C2=A0TEST_DIR=3D$TOP_DIR/test.d
> =C2=A0TEST_CASES=3D`find_testcases $TEST_DIR`
> +USER_LOG_DIR=3D
> =C2=A0KEEP_LOG=3D0
> =C2=A0KTAP=3D0
> =C2=A0DEBUG=3D0
> @@ -210,12 +210,18 @@ RV_TEST=3D0
> =C2=A0# Parse command-line options
> =C2=A0parse_opts $*
> =C2=A0
> +[ $DEBUG -ne 0 ] && set -x
> +
> +# TOP_DIR can be changed for rv. Setting log directory.
> =C2=A0LOG_TOP_DIR=3D$TOP_DIR/logs
> =C2=A0LOG_DATE=3D`date +%Y%m%d-%H%M%S`
> -LOG_DIR=3D$LOG_TOP_DIR/$LOG_DATE/
> -LINK_PTR=3D$LOG_TOP_DIR/latest
> -
> -[ $DEBUG -ne 0 ] && set -x
> +if [ -n "$USER_LOG_DIR" ]; then
> +=C2=A0 LOG_DIR=3D$USER_LOG_DIR
> +=C2=A0 LINK_PTR=3D
> +else
> +=C2=A0 LOG_DIR=3D$LOG_TOP_DIR/$LOG_DATE/
> +=C2=A0 LINK_PTR=3D$LOG_TOP_DIR/latest
> +fi
> =C2=A0
> =C2=A0if [ $RV_TEST -ne 0 ]; then
> =C2=A0=09TRACING_DIR=3D$TRACING_DIR/rv

