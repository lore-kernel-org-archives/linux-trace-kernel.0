Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10F3DF016
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419774; cv=none; b=Ag3X1wVR3AMluzQxc+4Nz9Q2xC+XfzYNODr2e9/CNFcWhoNZ2nr4h5P+1Nw1BGFzKu5TUIPjQ/z7O/l4jOrRhpWJEqyd0q19fp4DE0K8O/eVljKT8OnanFj2ptga1nPgkwyc9MNrsJzPiDRqDwuyY+QNcui4Dqk6new6T/LfKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419774; c=relaxed/simple;
	bh=kpceaR87vNYzTZXA2M9Mrw2OA9s2i+aHadB/k/1AEXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CzJU4STh2S+0KRpwT8zat6WB+xn+IDaIQjIHsoLEoskGFlVZXmXcLtLnj7xh6rssa9mGknyDiUgV8E7zNIrUhBUCynpOv40wR+mI1H+MIaMuVWlYkVpiZ5PjPC++lhT82hdlfqqL2bnXWNe0SfZ9vo1E5s5N5Ld/uj5NCC1Uw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/QMOah8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/QMOah8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783419771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0z1VisFzXLCVk0A+sZPuaxzBcW5LopEzkwOT8VYC8k=;
	b=W/QMOah8pyJVLdSYTgDoz9k2kZs/LH1UyuyeEpxUQwY21W4XzUhDqVFjP+LcAaRKziA5Hy
	a23bM/dUuw+WFtEe0XVefv1YhBo7UE16UJnoH36gPDKFpfyamYEf316xRI76fRZC/x2rkl
	N5g2GgOd6rf5kJH5AwZe8bmsDUZbJ+g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-4gSaXRBvNtWNXfnbN4hTlw-1; Tue, 07 Jul 2026 06:22:50 -0400
X-MC-Unique: 4gSaXRBvNtWNXfnbN4hTlw-1
X-Mimecast-MFC-AGG-ID: 4gSaXRBvNtWNXfnbN4hTlw_1783419769
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15b37e2e64so28975866b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 03:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783419769; x=1784024569;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q0z1VisFzXLCVk0A+sZPuaxzBcW5LopEzkwOT8VYC8k=;
        b=ZUrpF1BwUdMyOk7RZ1OMgyInRXo23KqpnDKGl0i1nIjgcFBblPZF55NX6DV2e65j8d
         LWU8hCt5w3nOLyRsEjiHmuf90ebcH/ladmrTd7wJVYD6MdwO7mKM/xcwbiQIhP098t07
         eh9/iH+S7NVkiClinAw/rtVwLrA37Rx1YQFHVMRdggvjJ2uwqblbL9wx4iIrwQUNa5hd
         NdEfy+LAYnK30yEqaFREPZxgjQb3Kp49wPh0hku+SY2mJkkp7WEVLjldeiCgDac+pBGL
         /eBnh1tf5CiSrzdVhQTSx4UOnoFJd58qICLZSJB5ty6KmVCV3uDOf7E8lWSZOBWbqlWP
         qmkA==
X-Forwarded-Encrypted: i=1; AHgh+RqHB0DdmYBhWaBk3weVu9WHsp9XK8Wjzc11b5jjgQGZglLW5BU4upksLokaGxG6wD/E07LcZ2XLlci3rw+ORJIZB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlQnw0uyLcivDthbfFQ4d9/8fl+nLqRmQqYRAPTgkuB7ZB4wV
	8p5UEPFLzueTgt0qr0xhEDkwaK6MQJDjVmG9eU3TpCud+lnm1hnlyjTQFtvUfSesfVznnUNttlD
	q5Y2+UC8mdWywvCG6X0XE9W5QZen9pG6/iT8O7k1qGYzDHgwrOer9sqDqzJvd4QdKEj2p3CQTAz
	f6cslvcfKAfO5yynoCyS1ucoNuyB1BeSC/KEwV7bMkaSv1B6YZ
X-Gm-Gg: AfdE7ckwCjvBlePhULIwqEpb3PuxI27FOynPNnzXSIGMu2J8+A9N3dAt2e+37SkomHU
	4raydGMF+X0FfpO+zN0fgcROGJgyt8p2g2OThFwO6V+DFCiCXYydPKgUonKOT4ku32hyPZ1tC7F
	Y+1KFj7DxA3+OoPico9D4zLkqRs79JlzzVYo+hmiaHspOSLPUNOI6neZnPCNr0Z7RCndU=
X-Received: by 2002:a17:906:f582:b0:c15:a9a7:8950 with SMTP id a640c23a62f3a-c15a9a7a6a5mr181522166b.7.1783419769458;
        Tue, 07 Jul 2026 03:22:49 -0700 (PDT)
X-Received: by 2002:a17:906:f582:b0:c15:a9a7:8950 with SMTP id
 a640c23a62f3a-c15a9a7a6a5mr181520866b.7.1783419768991; Tue, 07 Jul 2026
 03:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ako2S4mzIqWwYuas@steamhammer.waldi.eu.org>
In-Reply-To: <ako2S4mzIqWwYuas@steamhammer.waldi.eu.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 7 Jul 2026 12:22:37 +0200
X-Gm-Features: AVVi8CfCZlXlKo1oeUOCKTT77kmEJdkBeQjgDD2I2l4l0-CDHLbzUqn6Xj2k1iA
Message-ID: <CAP4=nvTH5HhUk19w06aH6-xqWGOUQKesGbKCfvgpwmefLom0VQ@mail.gmail.com>
Subject: Re: [PATCH] rtla: Also link in ctype.c
To: Bastian Blank <waldi@debian.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WmcERi5YbCodbH1cscHZe87lNMwebwnQdSxCRJ8lv1E_1783419769
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 5. 7. 2026 v 12:55 odes=C3=ADlatel Bastian Blank <waldi@debian.org> naps=
al:
>
> rtla started to only link parts of the tools library.  It now misses the
> ctype information used by all the related string operations.  Just add
> another single file to make it build again.
>
> Signed-off-by: Bastian Blank <waldi@debian.org>
> ---
>  tools/tracing/rtla/Makefile | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>

Thank you. It appears that GCC LTO drops the symbol use of "_ctype",
so I didn't see it earlier. With removed -flto=3Dauto from
Makefile.rtla, I can reproduce it:

 LINK    /linux-7.2-rc2/tools/tracing/rtla/rtla
/usr/bin/x86_64-linux-gnu-ld.bfd:
/linux-7.2-rc2/tools/tracing/rtla/lib/string.o: warning: relocation
against `_ctype' in read-only section `.text'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/linux-7.2-rc2/tools/tracing/rtla/lib/string.o: in function
`skip_spaces':
/linux-7.2-rc2/tools/lib/string.c:126:(.text+0x14c): undefined
reference to `_ctype'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/linux-7.2-rc2/tools/tracing/rtla/lib/string.o: in function `strim':
/linux-7.2-rc2/tools/lib/string.c:149:(.text+0x187): undefined
reference to `_ctype'
/usr/bin/x86_64-linux-gnu-ld.bfd: warning: creating DT_TEXTREL in a PIE
collect2: error: ld returned 1 exit status
make: *** [Makefile:121: /linux-7.2-rc2/tools/tracing/rtla/rtla] Error 1

> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 60a102538988..387bc6cc18f0 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -45,6 +45,9 @@ else
>    LIB_OUTPUT =3D $(CURDIR)/lib
>  endif
>
> +LIB_CTYPE =3D $(LIB_OUTPUT)/ctype.o
> +LIB_CTYPE_SRC =3D $(srctree)/tools/lib/ctype.c
> +
>  LIB_STRING =3D $(LIB_OUTPUT)/string.o
>  LIB_STRING_SRC =3D $(srctree)/tools/lib/string.c
>
> @@ -117,12 +120,12 @@ tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_ma=
p.c
>         $(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bp=
f_action_map.o"
>  endif
>
> -$(RTLA): $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
> -       $(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(LIBSUBCMD) =
$(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
> +$(RTLA): $(RTLA_IN) $(LIBSUBCMD) $(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ER=
ROR_R)
> +       $(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(LIBSUBCMD) =
$(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
>
> -static: $(RTLA_IN) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R)
> +static: $(RTLA_IN) $(LIBSUBCMD) $(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ERR=
OR_R)
>         $(eval LDFLAGS +=3D -static)
> -       $(QUIET_LINK)$(CC) -static $(LDFLAGS) -o $(RTLA)-static $(RTLA_IN=
) $(LIBSUBCMD) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
> +       $(QUIET_LINK)$(CC) -static $(LDFLAGS) -o $(RTLA)-static $(RTLA_IN=
) $(LIBSUBCMD) $(LIB_CTYPE) $(LIB_STRING) $(LIB_STR_ERROR_R) $(EXTLIBS)
>
>  rtla.%: fixdep FORCE
>         make -f $(srctree)/tools/build/Makefile.build dir=3D. $@
> @@ -150,6 +153,9 @@ $(LIB_STR_ERROR_R): $(LIB_STR_ERROR_R_SRC) | $(LIB_OU=
TPUT)
>  $(LIB_STRING): $(LIB_STRING_SRC) | $(LIB_OUTPUT)
>         $(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
>
> +$(LIB_CTYPE): $(LIB_CTYPE_SRC) | $(LIB_OUTPUT)
> +       $(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<
> +
>  libsubcmd-clean:
>         $(call QUIET_CLEAN, libsubcmd)
>         $(Q)$(RM) -r -- $(LIBSUBCMD_OUTPUT)
> --
> 2.53.0
>

The list of libraries is getting a bit long. Maybe it's time to
collapse it into one variable in a future release.

Anyway, I'll take this and attach:

Fixes: 48209d763c22 ("rtla: Add libsubcmd dependency")

Tomas

