Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFE1E1C19
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498797; cv=none; b=Un832/VqYtGGOQbNXgOx9K9jq489L9yJ8pC249pBrK7R6u9U7K82ZuWTWr+i6R+b/SkN9ooRXOBmXMZGNN/vbjD7R2rrfTGOYISf2oKLEiUueNPFEZLMG5brIyLL90PcKO/A5QXVCgqMXY2L4C+OZGTiMKeiX52oM0iEyWRJ/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498797; c=relaxed/simple;
	bh=XQE4+o5Jhg26i6Ph4bWW2HYpvKo9hE//uLA4Yn9DZHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5GPAVOC5+IRoAfaJvcf33qSkV+t481JPxtHwL5dk7+DxFQaMWl27jW57XRdFc7Q4B20/kOEb/cOmpqehfCDuMdq86g1As0sj1R+Jy3taAFt+1xS4cABczOWSRFBG4Vu2k8IkGXDCVkGuSHVqOuvlkrq3+5e0Qku3K6UWFUDfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAZey+4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAZey+4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729498794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCzxaZHuJmQ7sQb0GCsFk1hnF/RY3/2sDzQoDoTh0Ss=;
	b=JAZey+4epW4EVoiK+UKiToxS71HS7Jp07/V859M3wQWi81mLE6uSUmJh2as86XwzBuUv+P
	2Cyrxpp+PxBqX4aL4BahcYCS8GE5/6UTHKvfa8vCX8fCOGSgHDD4tpOySyGgVk4fhcwHk+
	3Fya2D/PnkszZpUUFDrF+v6S/zJkuL0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-8cu-lhjJNx-kJ9ZCRAAfeA-1; Mon, 21 Oct 2024 04:19:50 -0400
X-MC-Unique: 8cu-lhjJNx-kJ9ZCRAAfeA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539e75025f9so2290966e87.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498788; x=1730103588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCzxaZHuJmQ7sQb0GCsFk1hnF/RY3/2sDzQoDoTh0Ss=;
        b=pPxWQpgqNRrDpyrjcPW8MnE1ajcV0Z+3CO/j4FEtzk8pY5GNJLkIE/Q2O1DfAGLhm6
         PRnFX02mhVNyT9yIzXiRdxiaEnEhHdC6A+o8tl2+bMkl/umxGpnhI5BYwnPKy5i4a43+
         9QgFlRXzPQy76YWyj8NKcyogGV93RoVVpavBNHKEJQwGnK4OsR0iKpb1IWvw1Mrxkwnb
         VX9DV8m44rwtSSQWCPUqtJ3D/u1JEOnHce1kax1Xh7/jd8LHvDucu6wB8zpdFCFLItPJ
         xtncYayAxqGqnLFoiidx6N6g6QHnGCmBCJWWmTrdet/JnlNIPGmJKdGZC8w1RaOxtg31
         MyLA==
X-Gm-Message-State: AOJu0YwHv9hH/8rCS43TvlxvFRBAoZkoUgYvt7DaJQb3UDaA/jj701QS
	tfHTe4il6ZYE80qpvLR/dDoazRGwWyM1drXc/Ja4CdGrGnJSBRB8txmKvq3NuXYecRASSHqiS/f
	du/AUySF9Ox496mQetObuZrCZW1brc6rRtgLoMtbfjuYzcCHZdJL6HSuSLJvB2NZ/+XBQg5PuhS
	kQp2W8naWR5MN3HgTNmGwCa2cNOff1TUcHJSr2xLPZt+cnxThOokUd
X-Received: by 2002:a05:6512:3d05:b0:534:3cdc:dbef with SMTP id 2adb3069b0e04-53a154b2c68mr4330727e87.43.1729498787797;
        Mon, 21 Oct 2024 01:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF509YFDLSswl3HVzTDdMNIp7EjfHGgAwE0IKgNDU6hYCeqRxx2s9afWUCzix9guQVPbBXQ9yXPOZJRdgBBDxs=
X-Received: by 2002:a05:6512:3d05:b0:534:3cdc:dbef with SMTP id
 2adb3069b0e04-53a154b2c68mr4330708e87.43.1729498787207; Mon, 21 Oct 2024
 01:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <I89kxpG3ElxMtO0ctkqvwK_7e-aVqnL2_bprS5snA3hgizDIw-76cJI6Vm4luKoVGwdRtAoHcYnxuYrzEPsMeqipZTYao5fGFs3b1ZTCQRY=@protonmail.com>
In-Reply-To: <I89kxpG3ElxMtO0ctkqvwK_7e-aVqnL2_bprS5snA3hgizDIw-76cJI6Vm4luKoVGwdRtAoHcYnxuYrzEPsMeqipZTYao5fGFs3b1ZTCQRY=@protonmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 21 Oct 2024 10:19:36 +0200
Message-ID: <CAP4=nvR8CzLo1SdJJ67WjpMHGHzb35g1DRXeDPyENLmyvMLsQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools/rtla: Code Cleanup and Readability Improvements
 for timerlat
To: furkanonder <furkanonder@protonmail.com>
Cc: "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 20. 10. 2024 v 22:01 odes=C3=ADlatel furkanonder
<furkanonder@protonmail.com> napsal:
>
> The enhancements made to timerlat_load.py are intended to improve the
> script's robustness and readability.
>
> Summary of the changes:
> - Unnecessary semicolons at the end of lines have been removed.
> - Parentheses surrounding the if statement checking args.prio have been
> eliminated.
> - String concatenation for constructing timerlat_path has been replaced
> with an f-string.
> - Spacing in a multiplication expression has been adjusted for improved
> clarity.
>
> Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
> ---
>  tools/tracing/rtla/sample/timerlat_load.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/r=
tla/sample/timerlat_load.py
> index 8cc5eb2d2e69..785e9a83539a 100644
> --- a/tools/tracing/rtla/sample/timerlat_load.py
> +++ b/tools/tracing/rtla/sample/timerlat_load.py
> @@ -37,12 +37,12 @@ except:
>      exit(1)
>
>  try:
> -    os.sched_setaffinity(0, affinity_mask);
> +    os.sched_setaffinity(0, affinity_mask)
>  except:
>      print("Error setting affinity")
>      exit(1)
>
> -if (args.prio):
> +if args.prio:
>      try:
>          param =3D os.sched_param(int(args.prio))
>          os.sched_setscheduler(0, os.SCHED_FIFO, param)
> @@ -51,21 +51,21 @@ if (args.prio):
>          exit(1)
>
>  try:
> -    timerlat_path =3D "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.c=
pu + "/timerlat_fd"
> +    timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu=
}/timerlat_fd"
>      timerlat_fd =3D open(timerlat_path, 'r')
>  except:
>      print("Error opening timerlat fd, did you run timerlat -U?")
>      exit(1)
>
>  try:
> -    data_fd =3D open("/dev/full", 'r');
> +    data_fd =3D open("/dev/full", 'r')
>  except:
>      print("Error opening data fd")
>
>  while True:
>      try:
>          timerlat_fd.read(1)
> -        data_fd.read(20*1024*1024)
> +        data_fd.read(20 * 1024 * 1024)
>      except:
>          print("Leaving")
>          break
> --
> 2.46.2
>

The code part looks good now, thank you! Just one comment: the commit
titles should include more clearly which part of timerlat it is
changing: timerlat_load.py instead of just timerlat - the latter
sounds like you are changing the code of rtla-timerlat itself (in C)
rather than the example Python script. It is also recommended [1] to
use imperative mood in the commit messages, like this: "tools/rtla:
Improve code readability in timerlat_load.py" (and similarly for the
other patches).

[1] See the for submitting patches at
https://www.kernel.org/doc/html/latest/process/submitting-patches.html,
section Describe your changes.


Tomas

