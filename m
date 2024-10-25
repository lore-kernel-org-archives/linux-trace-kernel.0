Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F51D222F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895494; cv=none; b=FajNnrEZGLnUknhv7nB23hJMk90ARA/20bGSvMBkcQTkg7FQqrxJthH9KMINIcI7Ial57RVWomvF4xQ69jy9WYwV5MLOE0QkdY+e+nwvD201Dk/vi3aRMAxH04hFckpYSQQcy/nPnsaFmjgzjyt+cuP19BfdNwMni+6KdCN4ybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895494; c=relaxed/simple;
	bh=peaXwBeqvzMzdpHMpSvYdZXIArGq+jxUk3/8YEbSynA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaodlHGzoiFOouZX4zY0W3w0vaQyH2EMhIKPxbvMiflx+//rsBpPKcDuIVTx7aPggJjziAgSbrlTeAx0wA5n5ugDf/Ki4L9PEB5LCFBOdw64S6qhICa4t8EL42TRUWaWC8yojiOQQOmjFdixXsv77J7eT3APs/8jy7CMsbhuZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GfD0Ef31; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GfD0Ef31"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3165087e87.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729895490; x=1730500290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugvXr99oNQyERXTPqzKhuTsXIZd9WkdB8xJoxbh67vA=;
        b=GfD0Ef3164OR7MqcTSYW/8Xo+MckY/bmvj/qM56fY6J6/hE9WeOgxBcC1lfzhyXF7p
         OTghAwJnfsFRgwuk6rw4ft1447QcL/oGDfQj2xfOFG5HLmn2LtXUIGmJb+G7WnngjT0W
         oDdkRZanZyjQQWhJGDTJ7yOMNuVcZOBZAqhvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895490; x=1730500290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugvXr99oNQyERXTPqzKhuTsXIZd9WkdB8xJoxbh67vA=;
        b=Ljj/ZikkuWteJ9OowgOWoXlYVOPkg4jWuZikGTTK8Jmz09o/aP3cy9W9H8wEBBBVWq
         caXN+X5BwNPLgKpBbniFvrlqmIw3Rk6svO0Mzj0K2AGAQlHiLUHvYCgZEIh/GFB07NLQ
         04b9877y5f9q+4c1Hv4L2Q8pdfYdkzOl5/BgIwyFqPPAvTIEs9hURY9dIIsNG+Z2BKFw
         ohDBFYRdSn7oao7ILyaxMLCmAR5Z6+ap7a4ikNWFUDq2t3or3ZccJTOnO0O8FpQQ4MvG
         b+ofWYLbUBC9i5M1j7iTguE6z8V6Y85JE3fhNscUQAJbmnvI5CRFJTmicq5tGPurNxx4
         x2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw5vtImJxKUm2sMicPqRKc/IH7IVZz0FbV6zGfw8C9UkOV0VJR6FhJyoSAYna98x7RPCxK9zGEyHcQmTypI+tLufo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZo6kcVO6NtKSVnDAX4HR4+EV1He4YZQOYMALAV5976idqDmQ
	TQPhUAxxPdtvcnFgfPgWMgbjcqd/qnLZWE9Yw1L3GFFrFPYFccO9rDSbOZT1esxVG7A9gKrHwrc
	9Wg==
X-Google-Smtp-Source: AGHT+IG4l41NNkw5Pfj/g/LvagYfv/dxf0uEt24RcX138LwOG58dnHBSwqHO6C/qo8P9ZZC5Ni0fRg==
X-Received: by 2002:a05:6512:3b2b:b0:539:e1ea:c298 with SMTP id 2adb3069b0e04-53b348cbb37mr377983e87.22.1729895489552;
        Fri, 25 Oct 2024 15:31:29 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1af508sm323650e87.163.2024.10.25.15.31.28
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:31:29 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso24356321fa.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfQtlusy5/6PzvjHlf73ZXL0PR+UDUFmAYktKSkjfGFgCp+3VAfZrrQu75QWh0KrcSHUZtmYHHetNVsjkgiHzOAvg=@vger.kernel.org
X-Received: by 2002:a2e:be20:0:b0:2fb:5a19:5b9b with SMTP id
 38308e7fff4ca-2fcbdf5dademr3775951fa.8.1729895487832; Fri, 25 Oct 2024
 15:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021211221.GA835676@lichtman.org>
In-Reply-To: <20241021211221.GA835676@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 15:31:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-BYpZb60Ap1xHXdoDtf=2UhTD=MQc8Lw=WkRmY=+wWQ@mail.gmail.com>
Message-ID: <CAD=FV=X-BYpZb60Ap1xHXdoDtf=2UhTD=MQc8Lw=WkRmY=+wWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace the use of simple_strtol/ul functions with kstrto
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2024 at 2:12=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these function successfully returning even when the
> output does not match the input string.
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch series replaces uses of the simple_strto* series of function
> with the safer  kstrto* alternatives.
>
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Yuran Pereira (2):
>   kdb: Replace the use of simple_strto with safer kstrto in kdb_main
>   trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
>
> v2: Nir Lichtman (2): Removed confusing support for hex number inputs wit=
h no preceding "0x", and other CR fixes
>
>  kernel/debug/kdb/kdb_main.c | 69 +++++++++--------------------------
>  kernel/trace/trace_kdb.c    | 15 +++-----                             2 =
files changed, 23 insertions(+), 61 deletions(-)

FWIW, something about the way you're sending your patches is broken.
Both patch #1 and patch #2 are supposed to be "In-Reply-To" the cover
letter. You should use a tool like "b4" or "patman" to help you post
patches.

With what you have if I try to apply your series by pointing at the
cover letter:

--

$ b4 am 20241021211221.GA835676@lichtman.org
Analyzing 1 messages in the thread
No patches found.

--

...and if I try with patch #1:

--

$ b4 am 20241021211451.GB835676@lichtman.org
Grabbing thread from
lore.kernel.org/all/20241021211451.GB835676@lichtman.org/t.mbox.gz
Analyzing 1 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v2 1/2] kdb: Replace the use of simple_strto with safer
kstrto in kdb_main
    =E2=9C=93 Signed: DKIM/lichtman.org
  ERROR: missing [2/2]!
---
Total patches: 1
---
WARNING: Thread incomplete!
 Link: https://lore.kernel.org/r/20241021211451.GB835676@lichtman.org
 Base: applies clean to current tree
       git checkout -b v2_20241021_nir_lichtman_org HEAD
       git am ./v2_20241021_nir_kdb_replace_the_use_of_simple_strto_with_sa=
fer_kstrto_in_kdb_main.mbx

--

If they were properly posted b4 would be able to find all of them.

-Doug
