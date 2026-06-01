Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257137DE97
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321424; cv=none; b=odJtRyziHZ4SsExvsS+aKEgup7ZrQZ9TcIwHGFCr0nzK6/T5LwjB+EznNUBUFLcSUt0oSPps/JHHRj6wOZmv+OlUbeaPly0pks8gO2l35Sf3uZc+LTyit2I4l/OuprlHagsWeJGkYTXmHCL/baPFKreA1whpnCtdy4vdvJ7DtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321424; c=relaxed/simple;
	bh=XctDHplCrXNftIKrjgdo+FW362BBcXlaxQIHv8POUOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S80k2QafRs1hW7cumq2+cjnpClPnjI2dixqswhiy+skZd4kJ7A3fhAubxRGGVEL9I3wKTvAsl7DVsWk0hsyCrzErPkAVSnZsHryTcK6e3qZMHCjBbSIAGt4o8J63JsByt36yLXpW08gwQEjQfXniiKyByQECgAKXpkCUWDiQRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHTaEHHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHTaEHHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780321421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scZqgTcmiR5cRMGwnsbCk/nsKb3cDzIp5qhkGWo+7Rw=;
	b=SHTaEHHfSX9nxL2TVBkl/eT52wUbv4RBWyEKsZdu4W9MraNvmGMGfk9Wc0Oq8CmbukIWOC
	L+YSB22rB3QF3uhA3hSG8GgEK36yObQERWhtukWJXhwnqNUZMTOF4IzEn3PhPXhUqz7ogi
	AwLVA4NXfiARfxOmOjPoHOaKPo/Vuc8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-RMtTDZEHOCSAIuRX9hmntg-1; Mon, 01 Jun 2026 09:43:39 -0400
X-MC-Unique: RMtTDZEHOCSAIuRX9hmntg-1
X-Mimecast-MFC-AGG-ID: RMtTDZEHOCSAIuRX9hmntg_1780321416
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-396774b3452so7588641fa.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 06:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321416; x=1780926216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scZqgTcmiR5cRMGwnsbCk/nsKb3cDzIp5qhkGWo+7Rw=;
        b=DI0WIJYAozKgHMhkXvuy8q8s2Qyo857M87WTMgeCDubxUotGdYnGk7stNGmIGyqZ63
         ZOXIBsVkjqj22svqTyAH2WBkaLD3IXnyq60R2uE9H83UMsFNDfDmDIfBkNjGpxtQLo+7
         KfXn3EOOvB9oIEEP0biU8gTw+FmjcgLSEKlowhWkUvWq6hr+Tp2M1QkB0aoSib+fQXYD
         +2AoUlhmZHhb6FP+L9Ql0DFnEs/0IJwihzRvELUP/eHWz4c8QdzKcQcr+sfzNGl7YcdD
         5ShoDmtDzcDikN5WwJMXkERiAyDE6Wj9FrPjEQRwFlHYiylDRzHAxIrz4Pzu9OwN5uog
         E5hw==
X-Forwarded-Encrypted: i=1; AFNElJ8rlRXg3IIqKVzZyh+RVHJicN65jybOItOmtyHmP5jDPKzWU8Lbj0dleXt4yf1hsK2lWcTnbFCJzoITpEoAnxgAJIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52FUPMw7Fwve1dlgxmND8mzZA4ZnahMpCOR2w4/LGWbbHmW9A
	Tf4Qgp934pkejNmWoruUDWf495vCCOZwBTdoJJn7Rfx/gO0T6dsaR/Ms6Dw+9hAo1GumtW/ePiH
	BDJfWsOLjeI7mp06cjyIiEQVdB72LXBncHQr1rlMQ4Ps5/ae+3ipkgDVOK2a9OSALodCe8zdfiO
	twXQd/znO4BvoPHmmVKJxdnGt+vVo2p1f+zpr8lixO8y3bBBLiLEPTUhXv
X-Gm-Gg: Acq92OFRBXjKF8uEKoRTagVSFt65yFZRKBSnnPNyTHM6j9umRq2HuSwXVmxDZjkQ3/w
	AGHxS8LnpNyZEZbgzS+mx0yChtVnAmr8LpJADf+MkAsOOsRydhDJkU0fEJi8coAw+Zbvi9G+DLv
	p+6dbQ8/7hlWYcE/3gExYgRbmIdIqt01l+9dr4fr3jZpbvzbUVktS97MT/vPDM01sYJ9DVl78Vh
	/UlNy7JP8hKrS01
X-Received: by 2002:a2e:8202:0:b0:395:940a:d855 with SMTP id 38308e7fff4ca-39664e2b3e6mr22160081fa.5.1780321415488;
        Mon, 01 Jun 2026 06:43:35 -0700 (PDT)
X-Received: by 2002:a2e:8202:0:b0:395:940a:d855 with SMTP id
 38308e7fff4ca-39664e2b3e6mr22160001fa.5.1780321414933; Mon, 01 Jun 2026
 06:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahMmN4PdsJzr_Va-@decadent.org.uk>
In-Reply-To: <ahMmN4PdsJzr_Va-@decadent.org.uk>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 1 Jun 2026 15:43:23 +0200
X-Gm-Features: AVHnY4LdhRxBA41ZfDNggHv_WGZHKfAXMu3NM4WVCboKgZ_L5X6QuaLXlt4-4gM
Message-ID: <CAP4=nvTJaA3H02x5C49gEHPXwZfwqJ_3Wo2vDKOuLxwZB=xgJw@mail.gmail.com>
Subject: Re: [PATCH RESEND] rtla: Fix output files in source tree
To: Ben Hutchings <benh@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fYOESrO-_Ywsu5okj3asrjr2-HLjN3o0Cqgci33zHjI_1780321416
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 24. 5. 2026 v 18:24 odes=C3=ADlatel Ben Hutchings <benh@debian.org> naps=
al:
>
> Some output files (src/timerlat.bpf.o, src/timerlat.skel.h,
> example/timerlat_bpf_action.o, tests/bpf/bpf_action_map.o) are
> currently generated in the source tree, preventing a fully out-of-tree
> build.  To fix this:
>
> - Add $(OUTPUT) to their filenames in the relevant Makefile rules, and
>   create subdirectories as needed
> - Add $(OUTPUT)src to the include path
> - Add ${OUTPUT} to the BPF object filename in tests/timerlat.t
>
> Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples"=
)
> Fixes: 0304a3b7ec9a ("rtla/timerlat: Add example for BPF action program")
> Fixes: 5525aebd4e0c ("rtla/tests: Test BPF action program")
> Signed-off-by: Ben Hutchings <benh@debian.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/tracing/rtla/Makefile         | 31 ++++++++++++++++++-----------
>  tools/tracing/rtla/tests/timerlat.t |  4 ++--
>  2 files changed, 21 insertions(+), 14 deletions(-)
>

It seems that I did take building out-of-tree into account in my
latest build changes (in the libsubcmd migration; actually I even
fixed some smaller bits in v3 after seeing your patch), but not for
earlier generated files. Thanks for catching that.

Can you please rebase this on top of linux-trace/tools/for-next [1]?
There have been quite a lot of changes queued to the next cycle that
conflict now with this patch, namely:

1. changes to the Makefile coming from [3], conflicting around
INCLUDES and RTLA_IN rule
2. changes in runtime tests (highlighted below)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/l=
og/?h=3Dtools/for-next

> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 45690ee14544..f54da7be735d 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -66,30 +66,37 @@ ifeq ($(config),1)
>    include Makefile.config
>  endif
>
> +INCLUDES       =3D -I$(OUTPUT)src
> +

INCLUDES is currently unset by the Makefile, and there are users that
pass it to "make", e.g. [2].

Ideally, the name for user-specific includes would be EXTRA_INCLUDES
or something like that, and INCLUDES would be used for the generated
include files, but the name has already been set since the beginning
of rtla, so this has to be named "GEN_INCLUDES" (or similar) instead.
Otherwise, a user setting INCLUDES will override the -I$(OUTPUT)src
and out-of-tree build would fail.

[2] https://gitlab.com/cki-project/kernel-ark/-/blob/4dda3a32c5ef22768f6daa=
126a595974955e3c10/redhat/kernel.spec.template#L3375

>  CFLAGS         +=3D $(INCLUDES) $(LIB_INCLUDES)
>
>  export CFLAGS OUTPUT srctree
>
>  ifeq ($(BUILD_BPF_SKEL),1)
> -src/timerlat.bpf.o: src/timerlat.bpf.c
> +$(OUTPUT)src/timerlat.bpf.o: src/timerlat.bpf.c
> +       mkdir -p $(@D)

The mkdir will always echo when building the file, it'd be better to
use $(Q)$(MKDIR) here (and in the other rules below) like in the new
LIBSUBCMD_DIR and LIB_DIR rules [3].

Also, could the mkdir be separated into a target here, too? E.g.:

SRC_OUTPUT =3D $(OUTPUT)src/
$(SRC_OUTPUT):
  $(Q)$(MKDIR) -p $@

and then include it as order-only prerequisite:

$(SRC_OUTPUT)timerlat.bpf.o: src/timerlat.bpf.c | $(SRC_OUTPUT)
  $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@

That will remove the need to duplicate the mkdir command, plus the
SRC_OUTPUT variable can be used in place of $(OUTPUT)src for all
generated / non-build rules.

[3] https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/t=
ree/tools/tracing/rtla/Makefile?h=3Dtools/for-next&id=3Ddb956bcf8d681b5a01e=
be04c79f6a7b29b9934f9#n144

>         $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o =
$@
>
> -src/timerlat.skel.h: src/timerlat.bpf.o
> +$(OUTPUT)src/timerlat.skel.h: $(OUTPUT)src/timerlat.bpf.o
> +       mkdir -p $(@D)
>         $(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
>
> -example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> +$(OUTPUT)example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> +       mkdir -p $(@D)
>         $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o =
$@
>
> -tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> +$(OUTPUT)tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> +       mkdir -p $(@D)
>         $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o =
$@
>  else
> -src/timerlat.skel.h:
> -       $(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
> +$(OUTPUT)src/timerlat.skel.h:
> +       mkdir -p $(@D)
> +       $(Q)echo '/* BPF skeleton is disabled */' > $@
>
> -example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> +$(OUTPUT)example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
>         $(Q)echo "BPF skeleton support is disabled, skipping example/time=
rlat_bpf_action.o"
>
> -tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> +$(OUTPUT)tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
>         $(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bp=
f_action_map.o"
>  endif
>
> @@ -103,7 +110,7 @@ static: $(RTLA_IN)
>  rtla.%: fixdep FORCE
>         make -f $(srctree)/tools/build/Makefile.build dir=3D. $@
>
> -$(RTLA_IN): fixdep FORCE src/timerlat.skel.h
> +$(RTLA_IN): fixdep FORCE $(OUTPUT)src/timerlat.skel.h
>         make $(build)=3Drtla
>
>  clean: doc_clean fixdep-clean
> @@ -111,10 +118,10 @@ clean: doc_clean fixdep-clean
>         $(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -nam=
e '\.*.d' -delete
>         $(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
>         $(Q)rm -rf feature
> -       $(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat=
_bpf_action.o
> +       $(Q)rm -f $(OUTPUT)src/timerlat.bpf.o $(OUTPUT)src/timerlat.skel.=
h $(OUTPUT)example/timerlat_bpf_action.o

Maybe instead of adding $(OUTPUT) to all of these files, $(OUTPUT)
could be passed to the "find" command on the first line? Like this:

$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o
-name '\.*.d' -delete

That will also remove the necessity of manually running "rm" on
src/timerlat.bpf.o and src/timerlat.skel.h, only
$(OUTPUT)src/timerlat.skel.h has to stay.

>         $(Q)rm -f $(UNIT_TESTS)

This is correct. $(UNIT_TESTS) is defined in Makefile.unit, like this:

UNIT_TESTS :=3D $(OUTPUT)unit_tests

The cleanup of the newly added LIB_OUTPUT and LIBSUBCMD_OUTPUT should
already be implemented correctly in the target lib_clean /
libsubcmd_clean, no need to change anything for that, either.

>
> -check: $(RTLA) tests/bpf/bpf_action_map.o
> +check: $(RTLA) $(OUTPUT)tests/bpf/bpf_action_map.o
>         RTLA=3D$(RTLA) BPFTOOL=3D$(SYSTEM_BPFTOOL) prove -o -f -v tests/
> -examples: example/timerlat_bpf_action.o
> +examples: $(OUTPUT)example/timerlat_bpf_action.o
>  .PHONY: FORCE clean check
> diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tes=
ts/timerlat.t
> index fd4935fd7b49..e0f3fc4df655 100644
> --- a/tools/tracing/rtla/tests/timerlat.t
> +++ b/tools/tracing/rtla/tests/timerlat.t
> @@ -74,12 +74,12 @@ then
>         # Test BPF action program properly in BPF mode
>         [ -z "$BPFTOOL" ] && BPFTOOL=3Dbpftool
>         check "hist with BPF action program (BPF mode)" \
> -               "timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map=
.o --on-threshold shell,command=3D'$BPFTOOL map dump name rtla_test_map'" \
> +               "timerlat hist -T 2 --bpf-action ${OUTPUT}tests/bpf/bpf_a=
ction_map.o --on-threshold shell,command=3D'$BPFTOOL map dump name rtla_tes=
t_map'" \
>                 2 '"value": 42'
>  else
>         # Test BPF action program failure in non-BPF mode
>         check "hist with BPF action program (non-BPF mode)" \
> -               "timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map=
.o" \
> +               "timerlat hist -T 2 --bpf-action ${OUTPUT}tests/bpf/bpf_a=
ction_map.o" \
>                 1 "BPF actions are not supported in tracefs-only mode"

As mentioned above, this conflicts with [4] from
linux-trace/tools/for-next, as check was replaced with
check_top_q_hist and "timerlat hist" with "timerlat TOOL".

Also note that another patch [5] changes the path to use $testdir
instead of tests, as tests now run in a temporary directory as CWD,
however ${OUTPUT}tests is still the correct path, not $testdir, as it
references a built artifact (unlike the other uses of $testdir, which
reference auxiliary scripts).

[4] https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/c=
ommit/tools/tracing/rtla?h=3Dtools/for-next&id=3Dc15c55c01e48e4639c715370f4=
1d9d4c490f5d23
[5] https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/c=
ommit/tools/tracing/rtla?h=3Dtools/for-next&id=3Dad5b50a0959fb67100ddb93aeb=
0ea40201272cb2

>  fi
>  done

Thanks,
Tomas

