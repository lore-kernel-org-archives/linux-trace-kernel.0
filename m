Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E01356777
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727291; cv=none; b=TaA79Dt+Os0TgYzNY72+GpCNzqA59iJghVAYblycZD3vy1qa8pOZA/YHW4GDGHE2Xe9s38pttLGo0rNxYp3ZJgyLXZYiyX9oNmE3W8r5tqB6zl4ecgxPctyCRYS4AOkcTpx/3NCZnJa5BkGR3KaQ4ieUrFvSCs7u+3366HutZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727291; c=relaxed/simple;
	bh=iblGXWEmCOxgxwx+j9enVC/1edjmwR+nlgBiufBwX/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfPp5Tt0QRaqVBb/1FT3hdGs7cd/vux2wl4PmARjXDRM4UaFBirTBnI2YdDptsMDcYKvSAkpekkk7hVK6cHhl8kZisHfPksV5sAQFR061U/ricFDbUxy79HLcAEGmzEahvuMSZ7URJFtfE1uTJAhN8WN0/iDcWCpjRUHjJLgAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahcmLNU5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahcmLNU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784727288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CsGTo/oB6e5sqB3MKjCy0f/2tCeVuRl34uqskiH1thc=;
	b=ahcmLNU5oACh8SiUdWtHRCdsiRExIBOzUs7Fx0LxNVoa6eUErJiyNXuev9rL6kNVB6T4bz
	yjM7WSIpBQ+HizLEKH8sKqwoPsNIf5+Q5L+GgvwJ/E+tvIt1/2319NW3sIAY/kVWUDZVSA
	lx7xqhwJboE8+yVbTaC/vJ6gYRd0R88=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374--GOZixTbOoO9Kp7NydS0TA-1; Wed, 22 Jul 2026 09:34:42 -0400
X-MC-Unique: -GOZixTbOoO9Kp7NydS0TA-1
X-Mimecast-MFC-AGG-ID: -GOZixTbOoO9Kp7NydS0TA_1784727280
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c4715cf0eso25298966b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 06:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727280; x=1785332080;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/w/wBY9t5dDN+MLETgUfbSF251jpxw/mntes/3fk13k=;
        b=ASVyvjG7VybYgBNI5vBCkgofBI2qRrbvEX+L6wtahkiBMbYz2s73pjdFBfTnONjxWj
         sBYuNSNQczMz7Lj8NpTCXnaONp793JKzkXYw4Tz6tSCDWcQrfm1rOvJX8KsdLXyKAV98
         7Av/2CUb9Fu7+6ZY98kxVqejTl0uWQ1vi8UH2xd+2i3RZHmGJE8mvA3t5Vk3u+6FHQNa
         4RPV0OXRhQimiIHPyp8TeDH0brTg/wcsFBaJsnFfNHSCzqF71CoDSfzwzvKfAzJ470os
         oSHzNnEJmTYQe4fBbMI/kFmPW9WWYepFVOfdeohDXxIyimvb2OpoUzTkwjbp0Jz2OXNM
         NkgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqU12sNsSh89elGZxQPR2apdW4OpZbEWtfINJk6ad+bShKlpUM9cOq58MBiYvbqArKaYY86XUA2AjzhUNOabhDKta8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwQTx2VCzxGhrQEBeZT/HXm1lnCGJN5XOSUE0o0+19QiTCnfj
	Xf1a9Cwt9QH9a/M6xzie78TUrL4uuzgsF5CYHSw2gUBCt6VWcrL/IlEGuA+e1HdbtRW7efRNwaS
	koePtopN2FW9QoPufNK0hsQ1oat+b7soFpO3fVjKj9QtkK1kSYvZzqHOb0W/oFIddf5RzB4NcNt
	N4XU3PWiBV
X-Gm-Gg: AR+sD111IqZrgoxP6pV90VfrcnSI5HhFKMyKfcldqQAtrQF4lo+fR+Q2QOV42y4/kFD
	Xa/kTrjQYPIQzYlimSjPLmasQ+pjoPqg6ClQaGcZBZe+1TI7e2cmbtVANwcSFzI7DuPdmaAfDw/
	1WnGAqPWZVIFNJyOfgajmYPWvk8uoaQMWFZJHTg5SJaaZ3jVvkNpOHB8/X4YG6+/1KVcYbntG/O
	xjY0i7i5tu8EC3Ch7aOKfFFD4DUoZaef/Br+HAl5m+gEEpsNEBlGwYEgUiyEJrxSl88rVeUffc+
	UNXUAJHFR+6NLIIN8Xwsq7RK4DfxdPPSHQt3VMVol7jR7IjePBWxpMz+XH6LgVSEGdDdmkQGN0Q
	Om9sjpSqYM83YS4hRiy3BPmq56EMPmrv4wlogloPvBlMbGCtUjEvNjBlA4RUnE+48KbCjCw==
X-Received: by 2002:a17:907:c012:b0:c11:ff2c:4f33 with SMTP id a640c23a62f3a-c16b47c7127mr828214666b.45.1784727280110;
        Wed, 22 Jul 2026 06:34:40 -0700 (PDT)
X-Received: by 2002:a17:907:c012:b0:c11:ff2c:4f33 with SMTP id a640c23a62f3a-c16b47c7127mr828213466b.45.1784727279562;
        Wed, 22 Jul 2026 06:34:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a76fcdsm107368266b.4.2026.07.22.06.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:34:39 -0700 (PDT)
Message-ID: <1aeb814fd0cf348a8cb30cf6c411036aeacc35d9.camel@redhat.com>
Subject: Re: [PATCH v4 8/8] selftests/verification: add tlob selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 15:34:37 +0200
In-Reply-To: <4eb9a676efe90de8dfc1a9188d6ea81336e65e63.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <4eb9a676efe90de8dfc1a9188d6ea81336e65e63.1783524627.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wQL0__0gcGtlNSW_GICSftPcLpizRLGcC5hINuj0ins_1784727280
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add seven ftrace-style test scripts for the tlob RV monitor under
> tools/testing/selftests/verification/test.d/tlob/.=C2=A0 The tests cover
> uprobe binding management, budget violation detection, and per-state
> time accounting.
>=20
> Helper binaries tlob_target and tlob_sym are included in the same
> directory so the suite is self-contained.=C2=A0 tlob_sym resolves ELF
> symbol offsets for uprobe registration; tlob_target provides busy-spin,
> sleep, and preempt workloads.
>=20
> ftracetest is updated to walk up the directory tree when searching for
> test.d/functions, so monitor subdirectories can be passed as the test
> directory without placing a dummy functions shim in each new directory.

I believe this last part deserves its own patch, so ftrace folks won't lose
track of it (and it's probably a good idea for them to Ack it, make sure th=
ey're
Cc'd).

>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0tools/testing/selftests/ftrace/ftracetest=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 18 +-
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0=C2=A0 2 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 19 +-
> =C2=A0.../verification/test.d/tlob/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 28 +++
> =C2=A0.../test.d/tlob/run_tlob_tests.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 90 ++++++++
> =C2=A0.../verification/test.d/tlob/tlob_sym.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 209 ++++++++++++++++++
> =C2=A0.../verification/test.d/tlob/tlob_target.c=C2=A0=C2=A0=C2=A0 | 138 =
++++++++++++
> =C2=A0.../verification/test.d/tlob/uprobe_bind.tc=C2=A0=C2=A0 |=C2=A0 37 =
++++
> =C2=A0.../test.d/tlob/uprobe_detail_running.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 51 +++++
> =C2=A0.../test.d/tlob/uprobe_detail_sleeping.tc=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 50 +++++
> =C2=A0.../test.d/tlob/uprobe_detail_waiting.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 66 ++++++
> =C2=A0.../verification/test.d/tlob/uprobe_multi.tc=C2=A0 |=C2=A0 64 +++++=
+
> =C2=A0.../test.d/tlob/uprobe_no_event.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 ++
> =C2=A0.../test.d/tlob/uprobe_violation.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 67 ++++++
> =C2=A014 files changed, 854 insertions(+), 4 deletions(-)
> =C2=A0create mode 100644 tools/testing/selftests/verification/test.d/tlob=
/Makefile
> =C2=A0create mode 100755
> tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/tlob_target.c
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_running.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleeping.t=
c
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waiting.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_no_event.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
>=20
> diff --git a/tools/testing/selftests/ftrace/ftracetest
> b/tools/testing/selftests/ftrace/ftracetest
> index 0a56bf209f6c..91c007b0a74a 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -159,9 +159,21 @@ parse_opts() { # opts
> =C2=A0=C2=A0 if [ -n "$OPT_TEST_CASES" ]; then
> =C2=A0=C2=A0=C2=A0=C2=A0 TEST_CASES=3D$OPT_TEST_CASES
> =C2=A0=C2=A0 fi
> -=C2=A0 if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ];=
 then
> -=C2=A0=C2=A0=C2=A0 TOP_DIR=3D$OPT_TEST_DIR
> -=C2=A0=C2=A0=C2=A0 TEST_DIR=3D$TOP_DIR/test.d
> +=C2=A0 if [ -n "$OPT_TEST_DIR" ]; then
> +=C2=A0=C2=A0=C2=A0 # Walk up from OPT_TEST_DIR to find the nearest ances=
tor containing
> +=C2=A0=C2=A0=C2=A0 # test.d/functions, allowing monitor subdirectories t=
o be passed
> directly.
> +=C2=A0=C2=A0=C2=A0 dir=3D$OPT_TEST_DIR
> +=C2=A0=C2=A0=C2=A0 while [ "$dir" !=3D "/" ]; do
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -f "$dir/test.d/functions" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TOP_DIR=3D$dir
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_DIR=3D$TOP_DIR/test.d
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dir=3D$(dirname "$dir")
> +=C2=A0=C2=A0=C2=A0 done
> +=C2=A0=C2=A0=C2=A0 if [ -z "$TOP_DIR" ]; then
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errexit "no test.d/functions found above =
$OPT_TEST_DIR"
> +=C2=A0=C2=A0=C2=A0 fi

This won't happen, before calling parse_opts, the script initialises
TOP_DIR to `absdir $0` (ftracetest's folder). You can leave it as it is,
no need to catch an error since it was gracefully continuing anyway.

> =C2=A0=C2=A0 fi
> =C2=A0}
> =C2=A0
> diff --git a/tools/testing/selftests/verification/.gitignore
> b/tools/testing/selftests/verification/.gitignore
> index 2659417cb2c7..cbbd03ee16c7 100644
> --- a/tools/testing/selftests/verification/.gitignore
> +++ b/tools/testing/selftests/verification/.gitignore
> @@ -1,2 +1,4 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0logs
> +test.d/tlob/tlob_sym
> +test.d/tlob/tlob_target
> diff --git a/tools/testing/selftests/verification/Makefile
> b/tools/testing/selftests/verification/Makefile
> index aa8790c22a71..0b32bdfdb8db 100644
> --- a/tools/testing/selftests/verification/Makefile
> +++ b/tools/testing/selftests/verification/Makefile
> @@ -1,8 +1,25 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> -all:
> =C2=A0
> =C2=A0TEST_PROGS :=3D verificationtest-ktap
> =C2=A0TEST_FILES :=3D test.d settings
> =C2=A0EXTRA_CLEAN :=3D $(OUTPUT)/logs/*
> =C2=A0
> +# Subdirectories that provide binaries used by the test runner.
> +# Each entry must contain a Makefile that accepts OUTDIR=3D and
> +# deposits its binaries there.

Does the entry's Makefile support OUTDIR ? It doesn't look like it.

By the way, reimplementing things like this is probably going to break a
few things like installation (e.g. for distros to package the
kselftests) and clean target. Perhaps we could refactor it to use
standard kselftests methods. See my mockup at the end.

> +BUILD_SUBDIRS :=3D test.d/tlob
> +
> =C2=A0include ../lib.mk
> +
> +all: $(patsubst %,_build_%,$(BUILD_SUBDIRS))
> +
> +clean: $(patsubst %,_clean_%,$(BUILD_SUBDIRS))
> +
> +.PHONY: $(patsubst %,_build_%,$(BUILD_SUBDIRS)) \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(patsubst %,_clean_%,$(BUILD=
_SUBDIRS))
> +
> +$(patsubst %,_build_%,$(BUILD_SUBDIRS)): _build_%:
> +=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" TOOLS_INCLUDES=3D"$(TOOLS_INCLUDES=
)"
> +
> +$(patsubst %,_clean_%,$(BUILD_SUBDIRS)): _clean_%:
> +=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" clean
> diff --git a/tools/testing/selftests/verification/test.d/tlob/Makefile
> b/tools/testing/selftests/verification/test.d/tlob/Makefile
> new file mode 100644
> index 000000000000..05a2d2599c4e
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/Makefile
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Builds tlob selftest helper binaries in the directory of this Makefile=
.
> +#
> +# Invoked by ../../Makefile via BUILD_SUBDIRS; outputs tlob_sym and
> +# tlob_target alongside the .tc scripts so they are self-contained.
> +
> +CFLAGS +=3D $(TOOLS_INCLUDES)
> +
> +# For standalone execution via vng
> +FTRACETEST :=3D ../../../ftrace/ftracetest
> +LOGDIR ?=3D ../../logs

Are those needed? They aren't used in the Makefile nor exported to the
executed scripts, I'd just drop them.

> +
> +.PHONY: all
> +all: tlob_sym tlob_target
> +
> +tlob_sym: tlob_sym.c
> +=09$(CC) $(CFLAGS) -o $@ $<
> +
> +tlob_target: tlob_target.c
> +=09$(CC) $(CFLAGS) -o $@ $<
> +
> +.PHONY: run_tests
> +run_tests: all
> +=09@./run_tlob_tests.sh
> +
> +.PHONY: clean
> +clean:
> +=09$(RM) tlob_sym tlob_target
> diff --git
> a/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> new file mode 100755
> index 000000000000..cd949756e713
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> @@ -0,0 +1,90 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Standalone runner for tlob selftests
> +# Usage: ./run_tlob_tests.sh [options]
> +#
> +# Options:
> +#=C2=A0=C2=A0 -v, --verbose=C2=A0=C2=A0=C2=A0 Verbose output
> +#=C2=A0=C2=A0 -k, --keep=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Keep test l=
ogs
> +#=C2=A0=C2=A0 -l, --logdir DIR Log directory (default: ../../logs)
> +#=C2=A0=C2=A0 -h, --help=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Show this h=
elp

I get you want a way to run tlob tests alone, but can we reduce the
amount of code to maintain? Why do we need to parse and forward
arguments? Cannot we just pass "$@" to ftracetest?

See that in my mockup later.

> +
> +set -e
> +
> +SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
> +FTRACETEST=3D"$SCRIPT_DIR/../../../ftrace/ftracetest"
> +LOGDIR=3D"$SCRIPT_DIR/../../logs"
> +VERBOSE=3D""
> +KEEP=3D""
> +EXTRA_ARGS=3D""
> +
> +# Parse arguments
> +while [[ $# -gt 0 ]]; do
> +=C2=A0=C2=A0=C2=A0 case $1 in
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -v|--verbose)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VERBO=
SE=3D"-v"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -k|--keep)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KEEP=
=3D"-k"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -l|--logdir)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOGDI=
R=3D"$2"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift=
 2
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -h|--help)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"Usage: $0 [options]"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
""
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"Options:"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 -v, --verbose=C2=A0=C2=A0=C2=A0 Verbose output"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 -k, --keep=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Keep test logs"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 -l, --logdir DIR Log directory (default: ../../logs)"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 -h, --help=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Show this help"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
""
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"Examples:"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 $0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # Run all tlob tests"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 $0 -v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # Run with verbose output"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 $0 -v -l /tmp/tlob-logs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Custom log =
directory"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
""
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"With vng:"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo =
"=C2=A0 vng -v --rwdir $LOGDIR -- $0"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit =
0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXTRA=
_ARGS=3D"$EXTRA_ARGS $1"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> +=C2=A0=C2=A0=C2=A0 esac
> +done
> +
> +# Build test helpers
> +echo "Building tlob test helpers..."
> +make -C "$SCRIPT_DIR" all
> +
> +# Check ftracetest exists
> +if [ ! -x "$FTRACETEST" ]; then
> +=C2=A0=C2=A0=C2=A0 echo "Error: $FTRACETEST not found or not executable"
> +=C2=A0=C2=A0=C2=A0 echo "Make sure you're running from the correct direc=
tory"
> +=C2=A0=C2=A0=C2=A0 exit 1
> +fi
> +
> +# Create log directory
> +mkdir -p "$LOGDIR"
> +
> +# Run tests
> +echo "Running tlob selftests..."
> +echo "Log directory: $LOGDIR"
> +echo ""
> +
> +# Export RV_BINDIR so test scripts can find tlob_target and tlob_sym
> +export RV_BINDIR=3D"$SCRIPT_DIR"
> +
> +# Pass the test directory, not individual .tc files
> +# ftracetest will discover all .tc files in the directory
> +"$FTRACETEST" -K $VERBOSE $KEEP --rv --logdir "$LOGDIR" \
> +=C2=A0=C2=A0=C2=A0 "$SCRIPT_DIR" $EXTRA_ARGS
> +
> +echo ""
> +echo "Tests completed. Logs saved to: $LOGDIR"

I tried to refactor it to follow more standard selftest building,
avoiding to maintain things ourselves. The only drawback is that you'd
have to move the tlob_*.c files to selftests/verification , then we can
still use RV_BINDIR but support it only via Makefile and
run_tlob_tests.sh (so let's drop defining it in all tests and save
inconvenience if things ever change).

By the way, this isn't necessarily bad, RV_BINDIR is a general term that
any other selftest can end up using (and shouldn't point to tlob's
directory).

I didn't do it to avoid confusion, but it may be more appropriate to
change the name (e.g. RVTEST_ROOT or VERIFICATIONTEST_ROOT)?

Now you won't need separate Makefiles and everything should work
seamlessly.

(I tested this in vng with both your script and the Makefile, but this
is far from a deep testing, it should apply cleanly on your tree)

From 84eff70a20d79d0900714338903c0f5d568a45d9 Mon Sep 17 00:00:00 2001
From: Gabriele Monaco <gmonaco@redhat.com>
Date: Wed, 22 Jul 2026 15:29:21 +0200
Subject: [PATCH] selftests/verification: Simplify tlob tests

Squash this with the other patch should you accept it!
Drop nested Makefile in favour of lib.mk and simplify run_tlob_tests

---
 .../testing/selftests/verification/.gitignore |  4 +-
 tools/testing/selftests/verification/Makefile | 20 +----
 .../verification/test.d/tlob/Makefile         | 28 -------
 .../test.d/tlob/run_tlob_tests.sh             | 79 +------------------
 .../verification/test.d/tlob/uprobe_bind.tc   |  1 -
 .../test.d/tlob/uprobe_detail_running.tc      |  1 -
 .../test.d/tlob/uprobe_detail_sleeping.tc     |  1 -
 .../test.d/tlob/uprobe_detail_waiting.tc      |  1 -
 .../verification/test.d/tlob/uprobe_multi.tc  |  1 -
 .../test.d/tlob/uprobe_violation.tc           |  1 -
 .../verification/{test.d/tlob =3D> }/tlob_sym.c |  0
 .../{test.d/tlob =3D> }/tlob_target.c           |  0
 12 files changed, 9 insertions(+), 128 deletions(-)
 delete mode 100644 tools/testing/selftests/verification/test.d/tlob/Makefi=
le
 rename tools/testing/selftests/verification/{test.d/tlob =3D> }/tlob_sym.c=
 (100%)
 rename tools/testing/selftests/verification/{test.d/tlob =3D> }/tlob_targe=
t.c (100%)

diff --git a/tools/testing/selftests/verification/.gitignore b/tools/testin=
g/selftests/verification/.gitignore
index cbbd03ee16c7..d2f231f1bacb 100644
--- a/tools/testing/selftests/verification/.gitignore
+++ b/tools/testing/selftests/verification/.gitignore
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 logs
-test.d/tlob/tlob_sym
-test.d/tlob/tlob_target
+tlob_sym
+tlob_target
diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/=
selftests/verification/Makefile
index 0b32bdfdb8db..17442e6bb87f 100644
--- a/tools/testing/selftests/verification/Makefile
+++ b/tools/testing/selftests/verification/Makefile
@@ -4,22 +4,8 @@ TEST_PROGS :=3D verificationtest-ktap
 TEST_FILES :=3D test.d settings
 EXTRA_CLEAN :=3D $(OUTPUT)/logs/*
=20
-# Subdirectories that provide binaries used by the test runner.
-# Each entry must contain a Makefile that accepts OUTDIR=3D and
-# deposits its binaries there.
-BUILD_SUBDIRS :=3D test.d/tlob
+TEST_GEN_FILES :=3D tlob_sym tlob_target
=20
-include ../lib.mk
-
-all: $(patsubst %,_build_%,$(BUILD_SUBDIRS))
-
-clean: $(patsubst %,_clean_%,$(BUILD_SUBDIRS))
+export RV_BINDIR :=3D $(OUTPUT)
=20
-.PHONY: $(patsubst %,_build_%,$(BUILD_SUBDIRS)) \
-        $(patsubst %,_clean_%,$(BUILD_SUBDIRS))
-
-$(patsubst %,_build_%,$(BUILD_SUBDIRS)): _build_%:
-=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" TOOLS_INCLUDES=3D"$(TOOLS_INCLUDES)"
-
-$(patsubst %,_clean_%,$(BUILD_SUBDIRS)): _clean_%:
-=09$(MAKE) -C $* OUTDIR=3D"$(OUTPUT)" clean
+include ../lib.mk
diff --git a/tools/testing/selftests/verification/test.d/tlob/Makefile b/to=
ols/testing/selftests/verification/test.d/tlob/Makefile
deleted file mode 100644
index 05a2d2599c4e..000000000000
--- a/tools/testing/selftests/verification/test.d/tlob/Makefile
+++ /dev/null
@@ -1,28 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Builds tlob selftest helper binaries in the directory of this Makefile.
-#
-# Invoked by ../../Makefile via BUILD_SUBDIRS; outputs tlob_sym and
-# tlob_target alongside the .tc scripts so they are self-contained.
-
-CFLAGS +=3D $(TOOLS_INCLUDES)
-
-# For standalone execution via vng
-FTRACETEST :=3D ../../../ftrace/ftracetest
-LOGDIR ?=3D ../../logs
-
-.PHONY: all
-all: tlob_sym tlob_target
-
-tlob_sym: tlob_sym.c
-=09$(CC) $(CFLAGS) -o $@ $<
-
-tlob_target: tlob_target.c
-=09$(CC) $(CFLAGS) -o $@ $<
-
-.PHONY: run_tests
-run_tests: all
-=09@./run_tlob_tests.sh
-
-.PHONY: clean
-clean:
-=09$(RM) tlob_sym tlob_target
diff --git a/tools/testing/selftests/verification/test.d/tlob/run_tlob_test=
s.sh b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
index cd949756e713..6bedb1813891 100755
--- a/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
+++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
@@ -2,89 +2,18 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 # Standalone runner for tlob selftests
-# Usage: ./run_tlob_tests.sh [options]
-#
-# Options:
-#   -v, --verbose    Verbose output
-#   -k, --keep       Keep test logs
-#   -l, --logdir DIR Log directory (default: ../../logs)
-#   -h, --help       Show this help
=20
 set -e
=20
 SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 FTRACETEST=3D"$SCRIPT_DIR/../../../ftrace/ftracetest"
-LOGDIR=3D"$SCRIPT_DIR/../../logs"
-VERBOSE=3D""
-KEEP=3D""
-EXTRA_ARGS=3D""
-
-# Parse arguments
-while [[ $# -gt 0 ]]; do
-    case $1 in
-        -v|--verbose)
-            VERBOSE=3D"-v"
-            shift
-            ;;
-        -k|--keep)
-            KEEP=3D"-k"
-            shift
-            ;;
-        -l|--logdir)
-            LOGDIR=3D"$2"
-            shift 2
-            ;;
-        -h|--help)
-            echo "Usage: $0 [options]"
-            echo ""
-            echo "Options:"
-            echo "  -v, --verbose    Verbose output"
-            echo "  -k, --keep       Keep test logs"
-            echo "  -l, --logdir DIR Log directory (default: ../../logs)"
-            echo "  -h, --help       Show this help"
-            echo ""
-            echo "Examples:"
-            echo "  $0                           # Run all tlob tests"
-            echo "  $0 -v                        # Run with verbose output=
"
-            echo "  $0 -v -l /tmp/tlob-logs      # Custom log directory"
-            echo ""
-            echo "With vng:"
-            echo "  vng -v --rwdir $LOGDIR -- $0"
-            exit 0
-            ;;
-        *)
-            EXTRA_ARGS=3D"$EXTRA_ARGS $1"
-            shift
-            ;;
-    esac
-done
=20
 # Build test helpers
 echo "Building tlob test helpers..."
-make -C "$SCRIPT_DIR" all
-
-# Check ftracetest exists
-if [ ! -x "$FTRACETEST" ]; then
-    echo "Error: $FTRACETEST not found or not executable"
-    echo "Make sure you're running from the correct directory"
-    exit 1
-fi
-
-# Create log directory
-mkdir -p "$LOGDIR"
-
-# Run tests
-echo "Running tlob selftests..."
-echo "Log directory: $LOGDIR"
-echo ""
+make -C "$SCRIPT_DIR/../.." all
=20
 # Export RV_BINDIR so test scripts can find tlob_target and tlob_sym
-export RV_BINDIR=3D"$SCRIPT_DIR"
-
-# Pass the test directory, not individual .tc files
-# ftracetest will discover all .tc files in the directory
-"$FTRACETEST" -K $VERBOSE $KEEP --rv --logdir "$LOGDIR" \
-    "$SCRIPT_DIR" $EXTRA_ARGS
+export RV_BINDIR=3D"$(realpath "$SCRIPT_DIR/../..")"
=20
-echo ""
-echo "Tests completed. Logs saved to: $LOGDIR"
+# Run ftracetest, forwarding all options and passing the test directory
+exec "$FTRACETEST" -K --rv "$SCRIPT_DIR" "$@"
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.t=
c b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
index 4a1c18c7485a..be2f3555c30d 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_bind.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor uprobe binding (visible in monitor file, =
removable, duplicate rejected)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail=
_running.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detai=
l_running.tc
index afca157b5ea4..46c98ea03872 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_runnin=
g.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_runnin=
g.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor detail running (running_ns dominates when=
 task busy-spins between probes)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail=
_sleeping.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_deta=
il_sleeping.tc
index 0a6470b4cadb..7e82c7c7f98b 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleepi=
ng.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_sleepi=
ng.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor detail sleeping (sleeping_ns dominates wh=
en task blocks between probes)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail=
_waiting.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_detai=
l_waiting.tc
index ef22fce700fc..43a33357f5ef 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waitin=
g.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_waitin=
g.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor detail waiting (waiting_ns dominates when=
 task is preempted between probes)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.=
tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
index a798f3e9b3fa..3c606b354ad2 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_multi.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor multiple uprobe bindings (different offse=
ts fire independently)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_violat=
ion.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.=
tc
index 8a94bd679b88..ff8b736932ca 100644
--- a/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
+++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_violation.tc
@@ -3,7 +3,6 @@
 # description: Test tlob monitor budget violation (error_env_tlob and deta=
il_env_tlob fire with correct fields)
 # requires: tlob:monitor
=20
-RV_BINDIR=3D"${RV_BINDIR:-$(realpath "$(dirname "${1:-$0}")")}"
 UPROBE_TARGET=3D"${RV_BINDIR}/tlob_target"
 TLOB_SYM=3D"${RV_BINDIR}/tlob_sym"
 [ -x "$UPROBE_TARGET" ] || exit_unsupported
diff --git a/tools/testing/selftests/verification/test.d/tlob/tlob_sym.c b/=
tools/testing/selftests/verification/tlob_sym.c
similarity index 100%
rename from tools/testing/selftests/verification/test.d/tlob/tlob_sym.c
rename to tools/testing/selftests/verification/tlob_sym.c
diff --git a/tools/testing/selftests/verification/test.d/tlob/tlob_target.c=
 b/tools/testing/selftests/verification/tlob_target.c
similarity index 100%
rename from tools/testing/selftests/verification/test.d/tlob/tlob_target.c
rename to tools/testing/selftests/verification/tlob_target.c
--=20
2.55.0

