Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCA283FDD
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Mar 2026 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774109328; cv=none; b=ACO87x9M6xlEpfOgUajXdHijRcg4JwFlzRV3Tx7trZNPDgddz6A1fBmSOFKcE1QtlcaGrPDBpXg8c07B/+1CD2uk4T+AZgvuEe8hJFhvQrcWvVaSL8dLt9XdFZGcos1vZzIt3NPClMSPYqzSJsCoXNid/Rnhv9g6ZTQrmd+/50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774109328; c=relaxed/simple;
	bh=iG7fQBUq6AV5Pl+IRaBFIukp4ILZYZNf0kT6rUelntE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KavLYVABbmzijZ97u9A6Xva9bo76FvFq+/vdZ+m569w6cl/Nf4XguqQ19F2iwmtcb+2oXeXD5qnAgFQBgWKRIAjDA2MTUYoafmvznB9NXknaYg7QzUmtZ4vPKi7ntNSF3RDzt1rsQLVL3u50jyfWQ16UoR/Jf2Z9LifFipzqPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tif755z2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tif755z2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774109326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5Gn2W2nUjRCGyIbKZ4RgXOOpfdeMeWuqEVTqDlQkd4=;
	b=Tif755z2H8/psNjhsIcEwvTVnu7Xa/TJ5ZZkS7K335ERZIZcckUQ6J5svB5zepIzCIwnSN
	cWsqKv+iqpgFpp1L3+1V0f561bhnVJWHYRJTxilGrl68bgyMGwtm4TFdOZOFmPlXcQ899t
	8Ep7mM+RcXhrInCepq9sly3QNQCATdE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-DxlQUueoO6ST6UnUc5aEXA-1; Sat, 21 Mar 2026 12:08:45 -0400
X-MC-Unique: DxlQUueoO6ST6UnUc5aEXA-1
X-Mimecast-MFC-AGG-ID: DxlQUueoO6ST6UnUc5aEXA_1774109324
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-66794cee91cso3287958a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Mar 2026 09:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774109324; x=1774714124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5Gn2W2nUjRCGyIbKZ4RgXOOpfdeMeWuqEVTqDlQkd4=;
        b=CbYUhU2VJfAS0VdQ1n2ffAwfp6loQ8uhEH1OSRqHAT1DcIU33RnJeUgMnfGJGaSXna
         /eDccNrU0RzVeRKolveghd1EOR1viisnZm0IALa7nP1GFYKOGcXBhoTwd8DgVdvqblXn
         fjdaUU1bwy75iZJJ3kz47pOw62YYbS/pCovpQ5Bj757hyQw3GJ03dzueTdp0/nxI9J88
         iG02p+GbeHgwhtbcgFHoX8wOGGkG3peR5/WAbCSJW7ylGI9HY4zbjhsOp7MitRkYZ/BJ
         JjCvEuzKq424Ql3RRP/71S7hYjrEO9IoMPRGzIvVyauVxwhMBYF9NUnzCJoanAEpFqHA
         lDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW30N7zvz2hTKmnseE/FhTK5zTaNlb0ik7xkcYLi3uO5iTtYF8ePybAFp2lffmPds4SDRfma2/iK4+7gWsglx4nYIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6x0SXPRP1hP2FY6e7AA3dPfCrHcVSVgj+oD0CpxWaXBJPA5f
	06ZxinDaTcsr8ic9lPDktXWv4Muk1ScLtINfXJb2HGrNyuok6ZYlUR1Pi+uL4LRx3fgbY0d8ivw
	74dDpswU0mb88IPppCqA55+x6GsoqbaBJ4HGbdxe4UTV6R2rLOGOlEFmacdobnv4xgNXmmQPHVW
	1eeUUcUyVImcjS3KFOZDCBdc7KRVCfcNvhcmV2Fn/A66yYGaOH
X-Gm-Gg: ATEYQzzoO4GyC3iiHZkPLKuqOyuIt64x3XHBQjLUX27QDOBEJ6XEzepfKE1Md2MNQRt
	LrcJzQ/Wwwcm1AV4lrxKRqOXQlRL5qvpov5+rXdZX+1OZQkEMje6Yp09gnsYDAnfOYHAAXFoR4W
	SR50SNiu3oQtMNBnwEkyzZ6C+/vhl6OvRWkQks2OSDF5wHgvxbjJQ52PyX2YYo/YBeP4G1v7nOU
	K+qnbPsgH88sHCfP3s3RwCyLR1Nu8z3sny7Odg=
X-Received: by 2002:a05:6402:5050:b0:664:bc6:69a9 with SMTP id 4fb4d7f45d1cf-668c97208femr4586781a12.17.1774109323822;
        Sat, 21 Mar 2026 09:08:43 -0700 (PDT)
X-Received: by 2002:a05:6402:5050:b0:664:bc6:69a9 with SMTP id
 4fb4d7f45d1cf-668c97208femr4586766a12.17.1774109323433; Sat, 21 Mar 2026
 09:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
In-Reply-To: <20260320150651.51057-4-tglozar@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Sat, 21 Mar 2026 18:08:06 +0200
X-Gm-Features: AaiRm531oz0EqyoXJ7hHAU-cWOd72s4QUjMps8WXa2sE_1NLdGfDFvTSqoaWsac
Message-ID: <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wE-i5cfrcOWKuADu4uTiS6tLlFhRC77a-SnWP7Bq_50_1774109324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 17:07, Tomas Glozar <tglozar@redhat.com> wrote:
>> +#define TIMERLAT_OPT_NANO OPT_CALLBACK('n', "nano", params, NULL, \
> +       "display data in nanoseconds", \
> +       opt_nano_cb)

-n/--nano requires value incorrectly

 File: src/cli.c:463
 Cause: TIMERLAT_OPT_NANO used OPT_CALLBACK which expects an argument,
but -n is a flag.
 Fix: Changed to OPT_CALLBACK_NOOPT:

> +               HIST_OPT_NO_IRQ,
--no-irq clashes with auto-negation of --irq

 File: src/cli.c:1042
 Cause: libsubcmd auto-generates --no-X negations for every option.
--no-irq (histogram boolean) collides with the auto-negation of --irq
(stop threshold). The first match wins, so --irq was matched first and
its negation intercepted the call.
 Fix: Moved HIST_OPT_NO_IRQ before RTLA_OPT_STOP('i', "irq", ...) in
the options array so the explicit --no-irq boolean is found first.

> +               HIST_OPT_NO_THREAD,
--no-thread - same issue

 Cause: Same collision between --no-thread boolean and auto-negation
of --thread.
 Fix: Same reordering approach.

Costa and Claude

diff --git a/tools/tracing/rtla/src/cli.c b/tools/tracing/rtla/src/cli.c
index d029a698e8a7..c6b9ed920539 100644
--- a/tools/tracing/rtla/src/cli.c
+++ b/tools/tracing/rtla/src/cli.c
@@ -460,7 +460,7 @@ static int opt_osnoise_on_end_cb(const struct
option *opt, const char *arg, int
  "save the stack trace at the IRQ if a thread latency is higher than
the argument in us", \
  opt_llong_callback)

-#define TIMERLAT_OPT_NANO OPT_CALLBACK('n', "nano", params, NULL, \
+#define TIMERLAT_OPT_NANO OPT_CALLBACK_NOOPT('n', "nano", params, NULL, \
  "display data in nanoseconds", \
  opt_nano_cb)

@@ -1011,6 +1011,12 @@ struct common_params
*timerlat_hist_parse_args(int argc, char **argv)
  cb_data.trace_output = NULL;

  const struct option timerlat_hist_options[] = {
+ OPT_GROUP("Histogram Options:"),
+ HIST_OPT_NO_IRQ,
+ HIST_OPT_NO_THREAD,
+ HIST_OPT_BUCKET_SIZE,
+ HIST_OPT_ENTRIES,
+
  OPT_GROUP("Tracing Options:"),
  TIMERLAT_OPT_PERIOD,
  RTLA_OPT_STOP('i', "irq", "irq latency"),
@@ -1034,11 +1040,7 @@ struct common_params
*timerlat_hist_parse_args(int argc, char **argv)
  RTLA_OPT_KERNEL_THREADS,
  RTLA_OPT_USER_LOAD,

- OPT_GROUP("Histogram Options:"),
- HIST_OPT_BUCKET_SIZE,
- HIST_OPT_ENTRIES,
- HIST_OPT_NO_IRQ,
- HIST_OPT_NO_THREAD,
+ OPT_GROUP(""),
  HIST_OPT_NO_HEADER,
  HIST_OPT_NO_SUMMARY,
 HIST_OPT_NO_INDEX,

