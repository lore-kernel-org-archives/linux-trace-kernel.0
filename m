Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008CA14F126
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895879; cv=none; b=cMVneU4xq9vPbAj7lOsYaQY4cM0BaRcgjezc5ytZxYaorubMUakDELIpUVmcdAShUoIqTVHJ1wZgvH487E5zzVGFY06hK2DwrdVdvC6Py321/EdkcU+QpC1tRkVlXcUCG6dU/fFj3WsQrwRFZbrueHETN3gpxnhKB8BH0HvfEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895879; c=relaxed/simple;
	bh=yr8blPON0L8P6faR6pLzwU3dmLpW8EC1e3+KwFABKmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdAzG66iqBwA5caGPlOEEdoxeaxWucMeIZo26wmFsHE8XEXOPdr4ZdNyypt5G0OOvrBsNaqxJk75VwMIehJQga0JQS/al6/FV5Jb7sfuqzeXpW2wDGQiUEbzVVZiBhMyz/s0b+ZnpHJbW7ibsIYsqLQQX9hs9eTf8IrmrTqQie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcuyeuBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcuyeuBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728895877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7/G9qjRc6DyR0entz/ZvDY60uf5EECcVMa5L7fmUew=;
	b=WcuyeuBdw6v85cP6lzlA/TC7hUYQsIZZMCzD4nUaJC71uHMQMMCOSUDX51G+HWiQd/f3AH
	7Xtar2azpiw0kpngRufQUbSUIlojpNqJIsWi/N1Ji1KdFOHP7LCErQmwIL1p8aXD4LbQvc
	IBu5i/chYQUA/hUnQ4YmcPH+ZtIS9i8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-TKsBfMINN_ewq6z_4LInHA-1; Mon, 14 Oct 2024 04:51:15 -0400
X-MC-Unique: TKsBfMINN_ewq6z_4LInHA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a0c259715so65331366b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895874; x=1729500674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7/G9qjRc6DyR0entz/ZvDY60uf5EECcVMa5L7fmUew=;
        b=iMzmOcpSbu3WkdXaAp72uYETuBeaYV2C800EL6aVjtKrMQ5GQ0GhnCRQFIFdDp94XM
         UpWoXV7G3zuvPXRfrNGPhYwETfs3r3s5H/Zuw8hG6/oc7iZov25wiXy3WIWtP6z3KE5h
         hwIkUoUPtTkgryjN2cquHJY1zvS25Gw74aKMf6MWGufBWSVIMQcl7nBwaRAvLUQjOPd+
         vYbywXlFtb93y73SWszYBEcQ7lAm+RRwDiKBTTdiFT/n+NnbZqAitwZ7ffwatOkfJn69
         LHjI0TqwYRak8cyNjyFfkv1XvjD7rLVBXU4gyUOnHwUkLsTzAvCPD29wHKZ6H83seWlw
         O1Xg==
X-Gm-Message-State: AOJu0YzOzqZZofCyJ2nXLW/gbJYpzZ/iEn2rWZLq0ZPZeDKlse7FGQpC
	WMYzTdwWO+k2iNFL5BlLPj21TbSqWC6P2LQFs7OiwSahcBAwT5G5MFCwe0zXm9G4dduv3Xx8ToE
	86J5yz79pcfk1KPRkviABjKRBv1y7u/W/f4AVOfzEpbq4pdHP3mJn93ftUfjwHEZ5t0gUpJIVqL
	iU/yLYWf2ZPfl06PafUOj1hLvuOYBZ4gYHDHKl83T6tKpk
X-Received: by 2002:a17:907:7b88:b0:a9a:10c9:f4b8 with SMTP id a640c23a62f3a-a9a10ca327bmr172559966b.61.1728895874183;
        Mon, 14 Oct 2024 01:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjgrPcRB8qL1BCORcd6LLNPIYfGiH0I6bA48XxuMvHS623UpcCYWn4+4A32e189SaQH8bJHzuvCKdRCsZa8d4=
X-Received: by 2002:a17:907:7b88:b0:a9a:10c9:f4b8 with SMTP id
 a640c23a62f3a-a9a10ca327bmr172557966b.61.1728895873783; Mon, 14 Oct 2024
 01:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <HAxOlk1o3vhrAUlyVMtrSLGP39PFS1TLfGT9C9pB6cXgQpGB_fiNeGSuWS_4-4zeMxunluuBnkc4Y-k_c0qrlstVpYQvgfkJN2p_VnfMO-k=@protonmail.com>
In-Reply-To: <HAxOlk1o3vhrAUlyVMtrSLGP39PFS1TLfGT9C9pB6cXgQpGB_fiNeGSuWS_4-4zeMxunluuBnkc4Y-k_c0qrlstVpYQvgfkJN2p_VnfMO-k=@protonmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 14 Oct 2024 10:51:03 +0200
Message-ID: <CAP4=nvSUdKDcv_gubLLce9R8gmP_wg3rSV=kiCQG-ojC0S=H8A@mail.gmail.com>
Subject: Re: [PATCH] tools/rtla: Enhance Error Handling and Readability for timerlat
To: furkanonder <furkanonder@protonmail.com>
Cc: "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 5. 10. 2024 v 19:21 odes=C3=ADlatel furkanonder
<furkanonder@protonmail.com> napsal:
>
> The enhancements made to timerlat_load.py focus on improving error
> handling, readability, and overall user experience. These changes aim to
> make the script more robust and easier to maintain while providing cleare=
r
> feedback to users. Key modifications include:
>
> Type Declaration in Argument ParsingType Declaration in Argument Parsing
> Added type declarations for command-line arguments in the argument parser=
.
> This removes the need for manual type checks later in the code, improving
> clarity and safety.
>
> String Formatting
> Replaced string concatenation with an f-string to enhancing readability
> and conciseness.
>
> Enhanced Exception Handling and Consistent Error Reporting
> Specific exceptions are now caught and printed with clearer messages,
> providing context for errors when opening file descriptors. Added
> exception handling for the data file descriptor opening to ensure
> uniformity across the script.
>
>   Before:
>      $ sudo python timerlat_load.py 122
>      Error setting affinity
>   After:
>      $ sudo python timerlat_load.py 122
>      Error setting affinity: [Errno 22] Invalid argument
>
>   Before:
>      $ sudo python timerlat_load.py 1 -p 950
>      Error setting priority
>   After:
>      $ sudo python timerlat_load.py 1 -p 950
>      Error setting priority: [Errno 22] Invalid argument
>
>   Before:
>      $ python timerlat_load.py 1
>      Error opening timerlat fd, did you run timerlat -U?
>   After:
>      $ python timerlat_load.py 1
>      Permission denied. Please check your access rights.
>
> Changes for the read Infinite Loop
> The original generic exception clause has been replaced with more
> specific exception types to provide clearer feedback on errors.
>
> Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
> ---
>  tools/tracing/rtla/sample/timerlat_load.py | 56 +++++++++++++++++++++++-=
-------------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
>
> diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/r=
tla/sample/timerlat_load.py
> index 8cc5eb2d2e69..a819c3588073 100644
> --- a/tools/tracing/rtla/sample/timerlat_load.py
> +++ b/tools/tracing/rtla/sample/timerlat_load.py
> @@ -25,50 +25,54 @@ import sys
>  import os
>
>  parser =3D argparse.ArgumentParser(description=3D'user-space timerlat th=
read in Python')
> -parser.add_argument("cpu", help=3D'CPU to run timerlat thread')
> -parser.add_argument("-p", "--prio", help=3D'FIFO priority')
> -
> +parser.add_argument("cpu", type=3Dint, help=3D'CPU to run timerlat threa=
d')
> +parser.add_argument("-p", "--prio", type=3Dint, help=3D'FIFO priority')
>  args =3D parser.parse_args()
>
>  try:
> -    affinity_mask =3D { int(args.cpu) }
> -except:
> -    print("Invalid cpu: " + args.cpu)
> -    exit(1)
> -
> -try:
> -    os.sched_setaffinity(0, affinity_mask);
> -except:
> -    print("Error setting affinity")
> -    exit(1)
> +    affinity_mask =3D {args.cpu}
> +    os.sched_setaffinity(0, affinity_mask)
> +except Exception as e:
> +    print(f"Error setting affinity: {e}")
> +    sys.exit(1)
>
> -if (args.prio):
> +if args.prio:
>      try:
> -        param =3D os.sched_param(int(args.prio))
> +        param =3D os.sched_param(args.prio)
>          os.sched_setscheduler(0, os.SCHED_FIFO, param)
> -    except:
> -        print("Error setting priority")
> -        exit(1)
> +    except Exception as e:
> +        print(f"Error setting priority: {e}")
> +        sys.exit(1)
>
>  try:
> -    timerlat_path =3D "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.c=
pu + "/timerlat_fd"
> +    timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu=
}/timerlat_fd"
>      timerlat_fd =3D open(timerlat_path, 'r')
> -except:
> +except PermissionError:
> +    print("Permission denied. Please check your access rights.")
> +    sys.exit(1)
> +except OSError:
>      print("Error opening timerlat fd, did you run timerlat -U?")
> -    exit(1)
> +    sys.exit(1)
>
>  try:
> -    data_fd =3D open("/dev/full", 'r');
> -except:
> -    print("Error opening data fd")
> +    data_fd =3D open("/dev/full", 'r')
> +except Exception as e:
> +    print(f"Error opening data fd: {e}")
> +    sys.exit(1)
>
>  while True:
>      try:
>          timerlat_fd.read(1)
> -        data_fd.read(20*1024*1024)
> -    except:
> +        data_fd.read(20 * 1024 * 1024)
> +    except KeyboardInterrupt:
>          print("Leaving")
>          break
> +    except IOError as e:
> +        print(f"I/O error occurred: {e}")
> +        break
> +    except Exception as e:
> +        print(f"Unexpected error: {e}")
> +        break
>
>  timerlat_fd.close()
>  data_fd.close()
>
> --
> 2.46.2
>

Could you please resend your fix with one patch per logical change?
That is one for the code style changes (string formatting and other
minor changes like the removal of redundant brackers), one for better
exception handling, and one for better argument parsing. This will
keep the part which improves code style separate from the parts which
do actual functional changes to the code, which will make future
references to the patches clearer. It will also make the commit
messages shorter and easier to read.

Other than that, LGTM. Note that due to a bug in fb9e90a67ee9
("rtla/timerlat: Make user-space threads the default"), rtla has to be
run with "rtla timerlat top -U -k ..." to work properly with
user-managed userspace workload threads; if -k is not specified, rtla
defaults to -u and will create the workload thread itself, leading to
timerlat_load.py erroring out on timerlat fd open with EBUSY. (I think
this was already mentioned somewhere?)


Tomas

