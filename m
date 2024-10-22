Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C49DDC1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585829; cv=none; b=o7f1XTGNcCDg+NEWs+pwmh9aLw3wV8NpHAnXWoDfSKr7gqL0vzomYvFEqjEET8qB8M5WYhyo5b3vpMMlDYecEp5xiW1LXyOwcjCmkSVprv+mo/Ap1hXlvznsu4ZKO9bx65MLoZJvtTFjOqyDdRVDqe9UIleNgOmm0iMyV5uXBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585829; c=relaxed/simple;
	bh=iWvGO9uYNRA6rs8CudgTvRjKBP18DP4ytaTcowfWNio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDlGSkahhRD30TmUx0uiJCEOW2Vx7OHlNWXzv/gqZiE8omBvHZGs6S7H6s0+ivAvMDu+EBjbRdFoaLUuTuHNsNJFauoAOZ8FYgmW7nyym7T1uFCC1doMJjh2/qQSYzjT1cQybdIR/7sb578hxFn0lMo3wLQegccmPykC9Un/sdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gaac3Q0H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaac3Q0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729585826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZWqvMWje2mdmMMuJtKHJzOVBsHUAZ+wKvim28vpaDY=;
	b=gaac3Q0H9XHZ+zTzJuZ+fbrZbC9+ZDk+3BGATl7caIwa0NGhpSnNr/ijrckzIWjSHN/O/C
	8H/Iw2rHC8X41kMKYjnaZYnxUEHNP2e6Y4pTo8uY98OH7dYbLO9ZhSOb4MEKclTuILD/PB
	dEfojjM0SlE0jKuQ3z+GEvwsQ+KMDrA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-Yk5QDaVoPpqd6caftdfNNA-1; Tue, 22 Oct 2024 04:30:23 -0400
X-MC-Unique: Yk5QDaVoPpqd6caftdfNNA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a23eada74so363258866b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585822; x=1730190622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZWqvMWje2mdmMMuJtKHJzOVBsHUAZ+wKvim28vpaDY=;
        b=W0hTJRPDog30/wiv3aifrU4sm3iQ5QGcpUn/Oa2S14DhyoqbWAUSNYDrpjhVFDeeG9
         7QgCmWgJs2gaHrZ7oha91u49sX1XI9WmGend4AdaCbKHHqEhkUW+2moASQzK1SOmRalu
         uazPky0WjefNlxRlSx6jRSrqWR1m2GwTN4ClYPXBJ3xiocrjcN/gTQt/2y6S8nXusvuz
         I/3pbyA52pTcmOZxDPHau9je2yWlNEz8pJkeTLVImP9KpzlPZ7LjGrp2Xb1j1axZy/bg
         aV4awG1pAmYBAunxZozTrlvzRXq/Zce1+ZQAsae/++Fn1F7iVJUpiNwwsU5ymXxnMfM7
         Ztvw==
X-Forwarded-Encrypted: i=1; AJvYcCW9KzgKZ0NTPXej0eyM/tKvZJuKBy6fEXDsl3fJFhOIa3Q+4FcVMGuqr2whIhfNFdfCqd8oNq9SbIyo8D2S8vC/6l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqaG/RTRnIUiG3M19k3Y1rH+qGGbMIFiyd/fCZ++C57XDw4XO
	briUDNKnRLbOx/Jn3J1t5IGL5sJ3DVN15xXB7N2gaRc+w05fRNVizZi0fpgFWTB5VAZdE4YwvUX
	EThGbyMQ99omTWejHAdHUm+3seg0O+u65O2FK9nbJgg1EcowOHDycFlaik1Y3kO9PhiTQB1wfRl
	Y36FP10LAPl+8dta+soUAjScuF+9yaD7NHBJFG3O5Oedlu
X-Received: by 2002:a17:907:6e8d:b0:a9a:dc3:c86e with SMTP id a640c23a62f3a-a9aace25527mr166308566b.11.1729585822085;
        Tue, 22 Oct 2024 01:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRyAjZc7is+FtVdvisqTmnsQFG2L5kkwggXtst2PrYAdxiDhmZHSYD6B08tKIinZeybQvmxIVuvtZvYDiYZWg=
X-Received: by 2002:a17:907:6e8d:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-a9aace25527mr166307066b.11.1729585821767; Tue, 22 Oct 2024
 01:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Q_k1s4hBtUy2px8ou0QKenjEK2_T_LoV8IxAE79aBakBogb-7uHp2fpET3oWtI1t3dy8uKjWeRzQOdKNzIzOOpyM4OjutJOriZ9TrGY6b-g=@protonmail.com>
In-Reply-To: <Q_k1s4hBtUy2px8ou0QKenjEK2_T_LoV8IxAE79aBakBogb-7uHp2fpET3oWtI1t3dy8uKjWeRzQOdKNzIzOOpyM4OjutJOriZ9TrGY6b-g=@protonmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 22 Oct 2024 10:30:11 +0200
Message-ID: <CAP4=nvTLV_ftWrqqvvT_US4MbUvQ1sUGy5mgOH+Kik31AXSdeQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/rtla: Improve exception handling in timerlat_load.py
To: furkanonder <furkanonder@protonmail.com>
Cc: "lgoncalv@redhat.com" <lgoncalv@redhat.com>, "jkacur@redhat.com" <jkacur@redhat.com>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 21. 10. 2024 v 17:14 odes=C3=ADlatel furkanonder
<furkanonder@protonmail.com> napsal:
>
> The enhancements made to timerlat_load.py are intended to improve the scr=
ipt's exception handling.
>
> Summary of the changes:
>   - Specific exceptions are now caught for CPU affinity and priority
>     settings, with clearer error messages provided.
>   - The timerlat file descriptor opening now includes handling for
>     PermissionError and OSError, with informative messages.
>   - In the infinite loop, generic exceptions have been replaced with
>     specific types like KeyboardInterrupt and IOError, improving feedback=
.
>
>  Before:
>     $ sudo python timerlat_load.py 122
>     Error setting affinity
>  After:
>     $ sudo python timerlat_load.py 122
>     Error setting affinity: [Errno 22] Invalid argument
>
>  Before:
>     $ sudo python timerlat_load.py 1 -p 950
>     Error setting priority
>  After:
>     $ sudo python timerlat_load.py 1 -p 950
>     Error setting priority: [Errno 22] Invalid argument
>
>  Before:
>     $ python timerlat_load.py 1
>     Error opening timerlat fd, did you run timerlat -U?
>  After:
>     $ python timerlat_load.py 1
>     Permission denied. Please check your access rights.
>
> Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
> ---
>  tools/tracing/rtla/sample/timerlat_load.py | 37 +++++++++++++++++++++---=
-------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/r=
tla/sample/timerlat_load.py
> index d7341ed5127a..a819c3588073 100644
> --- a/tools/tracing/rtla/sample/timerlat_load.py
> +++ b/tools/tracing/rtla/sample/timerlat_load.py
> @@ -31,43 +31,48 @@ args =3D parser.parse_args()
>
>  try:
>      affinity_mask =3D {args.cpu}
> -except:
> -    print("Invalid cpu: " + args.cpu)
> -    exit(1)
> -
> -try:
>      os.sched_setaffinity(0, affinity_mask)
> -except:
> -    print("Error setting affinity")
> -    exit(1)
> +except Exception as e:
> +    print(f"Error setting affinity: {e}")
> +    sys.exit(1)
>
>  if args.prio:
>      try:
>          param =3D os.sched_param(args.prio)
>          os.sched_setscheduler(0, os.SCHED_FIFO, param)
> -    except:
> -        print("Error setting priority")
> -        exit(1)
> +    except Exception as e:
> +        print(f"Error setting priority: {e}")
> +        sys.exit(1)
>
>  try:
>      timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu=
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
>      data_fd =3D open("/dev/full", 'r')
> -except:
> -    print("Error opening data fd")
> +except Exception as e:
> +    print(f"Error opening data fd: {e}")
> +    sys.exit(1)
>
>  while True:
>      try:
>          timerlat_fd.read(1)
>          data_fd.read(20 * 1024 * 1024)
> -    except:
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
> --
> 2.46.2
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

