Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793919289;
	b=tG4pel6pbSENfL47UY+xYR4HhAlJKVkZ6clkGQjr8n+QMf0SQS5q4dmkeW1RWCZ5mvrW
	 KM2lQedo4upq0esmUxwGHlb/gxjWbNSR1dw1xRQYr/u4UufzTrRZxXZjQE5/4eRMjAz97
	 2pDuppCYoKtU0m2+s8m29awZgVkw7bMzsGa70cJQoNNSSJq1/+/SmLdAUWFDCbGvzmVAI
	 VskSvvfl8Mwfb/oJN9RYVCPEgRbuBwwiWjM6SYSaLBpRQJxv1EeG9wCCJS1PUk8E+8UAv
	 6ZXcfeTNEGGQNwjwMDPSXHNOrpv4JpDMygW1hT6SGO+Od98/UXdhqoKEP7qXbc164og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
	b=WGtuOu6kMureyF2r4GDgJ54Jd/2Q4ybw3tGJouB6fBKLvX88NXe/bH9CDeoCX6Xws0U7
	 eNyP9P8H11HrLDcHW++/v++FiW1RvmgJxDc/N21WZTykrS0CgtS4ZlnZceHu7G0dEFpLK
	 Z1YPrRXNP+y0I3WMSYzti++jZ2wG4X+u/ayL53ICxcWpouYE39GocQVLecRxZYFMcZDqL
	 VP8QY+aT8aCeI23OWMr5kkzlLCLGi8FPQqjIQ5FPZvG/tKzqtCSSdlyTPvTxkakoGJrgr
	 fa/kyWGEnlknhgADBoQoCRur71MuC86AvCzXUItL2Cx4dlFG1AJFUPCHtdXCt3R1lKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv5Nue57;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AF606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 22:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D2AF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jv5Nue57
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9d7791b00so316925ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 14:54:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793919288; cv=none;
        d=google.com; s=arc-20260327;
        b=TiEOWPEeQRV6v8cNCRsVCRSxcdbdsXBejSNJV7lFOv3Ay4Muo/gMC/GTnaGOrIALz3
         xP2ohHO5ckmfvf7qWY/RhjjDV4x+i3YXJcJuVyPPA0NfphWlpb17Tx4z6GLYFY3UmhxH
         TopZCf05f3lhgDrjurnm2pucq/C+RrzuBz8oFSuxp8OsEK7V7GCX5t2tsmiuLAju/zF9
         HjuSCu/nDePB/Q/XxBdi/S74cmmTEabpjNELwUqi/CpzjCG7Qdb8nfca1soLqRmsNBlT
         uNfNZ3RyPWh0RGo+yY6wvvB88bx735iFoXo96Oz//Gi5C3K63r+KC9vJzkxFnWVVMOyN
         Lvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
        fh=5GfbuPp9JsN2pJguAFY1UO5Cl6Vvtx7rJNKfSY7sXL8=;
        b=FCJIWb1rL/WlgGAY6wOcNByHUcyfMXDwGQVuvOHK6od5Wf81FW1Icftepaphm0CTAE
         kAeGYzpJijTpdUmxJ6uAXKp6vJTwytrSjdSYBruS4DSvd7qS2nltUw3fgzrJl8skwuNz
         R96vEzmD9iK/NSC8WMR9xBJu4icYQZ2/KgFtZB3pOsUbn8mvYkCAn4sCHF+c3jPZcaqS
         zZuuK9HvklzJoTYwlrRo61LAf/+g3PpHXWkqTIKhIWYxuwLA9f9/2vFjibDHJb/5Hi+d
         rbCXUs5NyXS9STNaeNHPffrLc+ECCIQaFIs3honHqetDiAwRWck5v5Dh08PDsPZOl70P
         lUpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793919288; x=1794524088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
        b=Jv5Nue57QjLkhMOEGuHs72frjV/ATniu1inojeuyfPkxMSjJgzY8tebX3s5VEt8P2M
         5zk79Uevpau03DtEKgmydD39Tj+kq1mm8pJ3xYPkFc3lo63wbGviTt7xGz2nkQjTWgme
         XZosPj/bHU4nk/vkXbgbH1DqTm2RdwSeIX2H3aB3tXuPraNBn0/VZGHwBP8W+HvX6wpN
         cQGsBUj+EezVKnGRxvepwdJN5B9CD+NqeIcjKdhFZgQHf6FtucQaQmKlT/r3Gt24fCRj
         uz6NppJAdxkzJP2Oo7zejufT3sR4pe3Kn6HPckZhMX9zdTnVv/XXjr20+UyoaaPwNtCV
         tJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793919288; x=1794524088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53u7WY1TsnwmHunThsglDcDwR3ZhmgG0Jw62kG2eqzQ=;
        b=NTz/cxa/Sa9Ag0j45hNJcESOISyHRu3SmS/XOGDgwzRlKM4TlvLrIF4TVAUqq3A03F
         gBHb2XKiQvnEY7YD+C2kA6TnSdjhC6fxxHJHWml++iJ4V4Z6Id1XxblO7gqFqLwqp++2
         FEfY476UrctcxJYWqSmoN1Z3I34YpyqBe4IgXAOllgfD4UXQFYvdqoiyFsFnnU0dHxaN
         /pnXTYI8wW7zASU0e3UPWAAFLhujrJG90tOJLrLdKxGFNFgM+b8+4sYTzU2UeqkeBEKR
         xOkPNlQ8yWJYj5nDjJC0oCg89g884IMBvn2amkTTtjMIrJHgir4Flc9GmVZ5vK5V9/In
         17Ig==
X-Forwarded-Encrypted: i=1; AKwUvBwjtzhawr4VlkktXsJmyskJpOqjnNgrvGEL7m1SlG7wML7nj0yU5hECeQAcHjfM3x0uP8BpSDjWgxzyQE0kjPhuoIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9R5TZQuXTDICxy3UdDIcKScOEt4Eu1WCnEfQQWeDny6YQM3fww
	ReRaYkI3YaYe2rYHA/dSEsxdSvfAxOZqJ6Mm6SlQHxAUbRK/EF9tzQX+Eeu+pK8oumt88R4J8sh
	f9vPJ9yr8L++QSJkObzZumkap9wojiT8=
X-Gm-Gg: AYBFou0bCVmKJgiNEpJybXfhadFX7Ud16flqV0cSjnYpjrGB89tOz/ftXdW2Bm7AcdN
	j/eZTIwe99y5crC7GWGkHm23Xa+u7IvgDhr6vt6HhYpLVI4e3loB8cUEhoVo8Hm9qv2ftkpVvLx
	73sC2QgzJb8vx1ORT1TXRdAmwn5k61daXwhzqWDrRn+wu2TPIS1lcX9Js7rkTDRkKwCpHBmiZ9Q
	1FdE9+cTYgKsqX94Fh8RTvu7RqR3fxPjsjdzrrFaaWiQmkFoJzzYXhhgn3A77FG0ca9XU9H1umP
	TMxhVai/CXoxn8J/9FNNH4G4xJejOWrNi2LXiERwwQy/dAqRBgsV7WwbhTDXP7oE9m1vMof6+gX
	KPOfdcfbPC4UhhMikJiUivSE2L55UbqGqD2zrLuBdjYFqDJnsUwMq/Vq9k2+rZkTsXIMoWXbnAp
	wdFOkRSbyW8ut356NgfOT7I/Daskobz9I6eg==
X-Received: by 2002:a17:903:f8b:b0:2dd:ad73:5b6d with SMTP id
 d9443c01a7336-2ed40ad432cmr11270975ad.29.1793919287795; Thu, 05 Nov 2026
 14:54:47 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105093212.826479-1-yangfeng59949@163.com> <20261105093212.826479-2-yangfeng59949@163.com>
In-Reply-To: <20261105093212.826479-2-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Nov 2026 14:54:35 -0800
X-Gm-Features: AclHuK-DzSYkqcsqv4sSPpyPME2cg_aHhMiCicQL_nOHKzRgCizS-_dThi2hBRo
Message-ID: <CAEf4Bzaq7y9q-M94X-z7sBquXuB8yUOjFC+TAZ0C1+VxriLd8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test faulting build IDs
 from a sleepable raw tracepoint
To: Feng Yang <yangfeng59949@163.com>
Cc: song@kernel.org, jolsa@kernel.org, ihor.solodrai@linux.dev, 
	kpsingh@kernel.org, matt@bobrowski.net, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:33=E2=80=AFAM Feng Yang <yangfeng59949@163.com> wr=
ote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> Extend the build_id test with a sleepable raw tracepoint on sys_enter.
> A helper process pages out the build ID page and issues a getpid()
> syscall; the BPF program filters on the target tgid and syscall id,
> records only the first hit, and captures the user stack with
> BPF_F_USER_BUILD_ID.  The test asserts that one of the frames carries
> uprobe_multi's build ID.
>
> Frame 0 is libc's syscall wrapper, so reaching uprobe_multi needs user
> stack unwinding; build uprobe_multi with -mbackchain on s390, where the
> unwinder follows backchains.  The non-sleepable control requires at least
> one BPF_STACK_BUILD_ID_IP frame, so it cannot pass just because the walk
> never reached uprobe_multi.
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/Makefile          |   4 +-
>  .../selftests/bpf/prog_tests/build_id.c       | 134 ++++++++++++++++++
>  .../selftests/bpf/progs/test_build_id.c       |  46 ++++++
>  tools/testing/selftests/bpf/uprobe_multi.c    |  37 ++++-
>  4 files changed, 216 insertions(+), 5 deletions(-)

this looks like an overkill, existing uprobe-based tests seem more
straightforward, is there a problem following the same pattern?

for instance, why did we not need run_uprobe_multi_syscall() before?

pw-bot: cr

>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 77682bf28c6e..367166383246 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -650,7 +650,9 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
>

[...]
