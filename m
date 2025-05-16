Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5B231838
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434144; cv=none; b=R3EtLshtJER3sut/2v0qSNyWgl0NctxpBU7Pi3LgnWg+JzXKfE5tP4qQvm/0OKzGzNscxLUTrYnHMmBJn2SYtAqihoqW99ULwHZXKA4sE8J5PFwYhN5Xo5cqQXqPb3yhtUp/qc8r+3N03lq/ZQrHDBD1mlqNf/Eo5hRdDk3v03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434144; c=relaxed/simple;
	bh=4aS/MJ652v81b0RnjTHvc021sMU1JhBt0gI30JgFrA0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pzsKoWTTKV6GH4LQtMZb4jh4EnLWmcxHNlKJDgaj4zPLWGWOBqHo14D3yGW2K48jb4oaT9pOZQhc+ULbJUYABSeqKNujTr+pYRfszKovXigPR1IQAaTe1RBGWT2zjntN8Ku2KdF0QPDKISJlzlvTcBCaiR32zbqQjrvJAM9kz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PY2hhApc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PY2hhApc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747434141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fonpJMpGpr/dkcO22JHooEc+eK9j6Tfx1lgo9aG2Wo=;
	b=PY2hhApcj/MrVWCj8HzI72I1z8eN7wIRoCQ/Le0UfGnFqQYxk1RWY0l/SOLxyxO+pCvFBw
	L/3zeq4tyWC+AQqq1pi1IMiI1VX2oVbEoLQF//PlnaExsdEzQhZn7rhZZg+w+U8g9c9+Ha
	N99qw0PRQZyfcQ8NSpJvXVT9DgjhL20=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-8O7aW82iNQeHLEkKoMf7Rw-1; Fri, 16 May 2025 18:22:20 -0400
X-MC-Unique: 8O7aW82iNQeHLEkKoMf7Rw-1
X-Mimecast-MFC-AGG-ID: 8O7aW82iNQeHLEkKoMf7Rw_1747434139
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f541b32bffso66531416d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 15:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747434139; x=1748038939;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fonpJMpGpr/dkcO22JHooEc+eK9j6Tfx1lgo9aG2Wo=;
        b=AO/fQQDaYnfrAbDQU41/uR+FAvJ8ngK5bTUqyTXdzpdHO1YK6PdE8DuuExXk5xd1Gp
         m0KiU3oj+9d1wphQqeP+o/4AZA48iVSP+pbaiEtWapRUuG9gvut4id7dhvGO37k8CbNI
         tUzHtVmuwqM5c5Pqyt77tHSv/MjibRPeqGMLshlwFTRmJmbldGsBk6RzZZDLETJOgH3z
         xEDRSzlwd08kz7W1jMYwvqorDEFRcKshKrZb5p40vVpsY/WTrEVBY6awfXfzKqQO6IJn
         kfTIIdvywDl3XSdReGQHaJRp9kCtjSU3seGMeYhtsUUFf0z6hqoi6qwUKvw7o5abqx+k
         Nh3g==
X-Forwarded-Encrypted: i=1; AJvYcCU/+bQO/Z5ehrNyHySerS0+hKvuxaaQkkGnkm56cn0dWXSHhxpkONHk9mfVMWyfKzi85nz8hecwAv85R19Kaen99JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6H62owdH1y73qyMy0nbLjv5dr9wzcP3qrKs6ZPUG2Qc/qmFja
	/AGMu3lyQBDZ443fwSTI87eB45K640uNqc0dWG6wry7DTs2fMhUHOZxz9OsnrwxvYJkBdcqM0d4
	mSiDQKRwsz1gKPFrAmf4mNx0XqZkpo+mV4wH/U9sv5MhxiD9sEpicTriR/7QpECcvVOQ4HPFL7w
	==
X-Gm-Gg: ASbGnctIXB+z8eq5ZP9X90LKEA4xUutRTnHvty5qG1L90OdIE870mPPzXf0/JlUI7o+
	cKiYYqP59mUBI8wU+/kDhLVsZc/HSQr1ttPBSyntPs5sosACdPdss29AJVmetzb9pkp+qR8Imxn
	Ssbm7opsludSRLBiYFl8OMbHMYD348qrvD6AzI8eOlWCjWX3ugf42II9whlhmcjsvK+0TKzyWp9
	Ncm9VJ8GZdCyAb3kdjWbY/m+MTuN1g6gKZwVckjuW4hDJ7WO0Ue1BpBFOF19v71/8PQkpx7aCY=
X-Received: by 2002:a05:6214:2403:b0:6e8:fee2:aadf with SMTP id 6a1803df08f44-6f8b2d0fd02mr86426246d6.31.1747434139531;
        Fri, 16 May 2025 15:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUrIn6rP4ZNfERrYkRl25vG/F/VaADk30h1GiuVp53YChPZqS3M4vyh1WQawf5RzAp5rxlgQ==
X-Received: by 2002:a05:6214:2403:b0:6e8:fee2:aadf with SMTP id 6a1803df08f44-6f8b2d0fd02mr86425186d6.31.1747434137591;
        Fri, 16 May 2025 15:22:17 -0700 (PDT)
Received: from fionn ([76.71.123.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b08ac212sm17299626d6.36.2025.05.16.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 15:22:17 -0700 (PDT)
Date: Fri, 16 May 2025 18:22:06 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH] rtla: Define _GNU_SOURCE in timerlat_bpf.c
In-Reply-To: <20250430144651.621766-1-tglozar@redhat.com>
Message-ID: <5c64d78a-1650-5404-c2cb-8190627d10fc@redhat.com>
References: <20250430144651.621766-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O-9udHsvmgGPM7xPXYDY6FJH7zNudyJmMn-GU_WL__Q_1747434139
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Wed, 30 Apr 2025, Tomas Glozar wrote:

> Newer versions of glibc include a definition of struct sched_attr in
> bits/sched.h (included through sched.h which is included by rtla).
> Commit 0eecee340672 ("tools/rtla: fix collision with glibc
> sched_attr/sched_set_attr") has modified the definition of struct
> sched_attr in utils.h, so that it is only applied with older versions of
> glibc that do not define it, in order to prevent build failure.
> 
> The definition in bits/sched.h depends on _GNU_SOURCE.
> timerlat_bpf.c does not define _GNU_SOURCE, making it fall back to the
> definition in utils.h. The latter has two fields less, leading to
> shifted offsets of struct timerlat_params in timerlat_bpf_init.
> 
> Because of the shift, timerlat_bpf_init incorrectly reads
> params->entries as 0 for timerlat-hist and disables the creation of
> histogram maps, causing breakage in BPF sample collection mode:
> 
> $ rtla timerlat hist -d 1s
> Error pulling BPF data
> 
> Fix the issue by also defining _GNU_SOURCE in timerlat_bpf.c.
> 
> Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_bpf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
> index 5abee884037a..0bc44ce5d69b 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.c
> +++ b/tools/tracing/rtla/src/timerlat_bpf.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #ifdef HAVE_BPF_SKEL
> +#define _GNU_SOURCE
>  #include "timerlat.h"
>  #include "timerlat_bpf.h"
>  #include "timerlat.skel.h"
> -- 

This works, and we need it, so
Reviewed-by: John Kacur <jkacur@redhat.com>
--
Question for Tomas, should we spend sometime to make this work for older 
versions of glibc without a definition of struct sched_attr?

