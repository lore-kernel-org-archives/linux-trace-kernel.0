Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92106312821
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455574; cv=none; b=G+1/bahNMRTeKceSq5EIs4MzSxFfaN4bJ7SS6CS1Nej4xJn1UMPOD0DBWIhee9ccLw2yWwnB0s4E4I4Pkmey7xRXCHnHF39SNbxARoWLby79SJY5NghnBPEOv+0gDXKsVTQNmUdhxVq97TqrgEi1lMYf3lDPS0NiiTYIRV9vepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455574; c=relaxed/simple;
	bh=zb6o9BBzMA6ybYP4rPtrVGFRzAZAk6RHKlRdzBd4wb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOi9D9Gor1kmJbRmuu9CoijbpJGK8ZQyoYvuT7/ATk3mmnTEu8mhI9pi3/trAQx7xdpc4zN/RQln11lVoJAyWyYCFnAX/NCTiA0SHQhOwrme3pSgJ020P5Ony1LDuo93VmKPAgic0GKGFbnFN7pv5AhlaYZGPwxE44csSiRaplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RweqxQ+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RweqxQ+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760455571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPklb6K1+lkU1jV8UO4c/obMd20v1vJ9fV4tt0H1zPw=;
	b=RweqxQ+V0ktjKiFe9JID4OkFsr51HG2RWDe52/tDj9HfpOdbUz2ReLjxtBgQmlrHm7XOKE
	5FfuReY2J/QsCpjPv0x9ETfBZD5qoUHuXUnZb9Vpa1Br2DxIo8Mj3rEa1yeTDXT3Rrrwqn
	P4DJQZcRlFkROtdwiEiAlI/AObZHZT0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-uF2rWyXMP4C-IONQUKbF_A-1; Tue, 14 Oct 2025 11:26:08 -0400
X-MC-Unique: uF2rWyXMP4C-IONQUKbF_A-1
X-Mimecast-MFC-AGG-ID: uF2rWyXMP4C-IONQUKbF_A_1760455567
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e7a2c3773so28335145e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455567; x=1761060367;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPklb6K1+lkU1jV8UO4c/obMd20v1vJ9fV4tt0H1zPw=;
        b=WstYrURg3STujMk2xnba5wmaMIBchrgcyifqGdBKvEu5E+oP4uICW8w/GXON0JOUSU
         Oy1vvRq0imxZCShIdENBhrzWPe3Pvv5XM6CmUy+MF0nQiVEvBSIhJIdntQH3MIIM7LMJ
         YRY1ajMlN7POSAcdUQ9F/EPScpPMKiYxmVN2G6rNEhP1m6jjYLTbSdhU09fDhgulPNl1
         CT8tLt03D3awEbGnVZMi5/NKOfBboGm6p/eZ4zBDTT3/cLczCTAtlOg/akQY3rPSqluQ
         6DOUO1WcwzFEcd4IFb0jwLu7Ed4Q6UyIc4uTq7H1X7X2dfILZUjEZglBvj48/HFLEAmn
         G8/g==
X-Forwarded-Encrypted: i=1; AJvYcCWVrWH6gyy6Rxs9a95S9MvkLzEy96GtfglKRGwKcAUa9vKilsGIDaenDLHAjl7UFDOSLlPSMiVps5w/AKFI640n2WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6+LCPBZATeRG4oQl4ghGIt39a7+e/SPtSvzKnEoWJVKzilHe
	ofaGjvGJ4F5sykn431Se2e2YWcqgUdAWHc5CyjxrxPe1SfWAs3l9Zkl3ob9zh/AAD+C6BUUORfT
	DjVijAvsXc8EQgacvYPHajkY18E10HZLcQ4I/7C7xs+lv7biiSAdC1fPSVi1TFHs5vPGdHMaeBw
	==
X-Gm-Gg: ASbGncvgocoXkZQVvNhr4iDJJGjQXp3My4xEbJQR0q+2PvlfdxPUxYOci9RMSAtVmyA
	3AGvEDY5fI95yWS3mG8vSQCCoWYBgmfc3iU7U8IfVfHqUgrMmp6qddHdLLc88f7AEezzMy8+jlj
	DgPIqGKhhRqqh7jBLVDONEu7hqYm1w24tPPOLWHaKw0vX8neMxqVC+7MNW5JtK4AQKmYVFxDFXA
	t4dqz9fPGhrtPJMsTnO68bKM0ADMQV3+/LrVq1Fp2PoUsdTNm0tr5ApGQhTgBuBS19SOb7W8hct
	JaQLJGvlT0EkIlFSgXtAmfc6z2dGEOCOLpEvftxsFge4hDAdQCuJkIAI0axp5fYHMhjnmQhuW0L
	ElxrCvFQkAfFvucFRyQaSQH9W0Q==
X-Received: by 2002:a05:600c:8115:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa9ec7556mr181898885e9.13.1760455566795;
        Tue, 14 Oct 2025 08:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW593XOgtaLpqw6H4D31qH5lmbNbujonLfE4h+J4hQ9AwSFy0g3uK3ztnKvCXj4YJKI0uSVg==
X-Received: by 2002:a05:600c:8115:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa9ec7556mr181898575e9.13.1760455566403;
        Tue, 14 Oct 2025 08:26:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3b9sm24483884f8f.11.2025.10.14.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:26:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Clark
 Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
Date: Tue, 14 Oct 2025 17:26:04 +0200
Message-ID: <xhsmhzf9tld2r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zC7UF45O-M6apOiSCuQmn8QZcdKMm6eYNQyKksBji6I_1760455567
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 14/10/25 14:58, Juri Lelli wrote:
>> Noise
>> +++++
>>
>> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
>> RHEL10 userspace.
>>
>> Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
>> and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:
>>
>> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
>>                 -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
>>                 rteval --onlyload --loads-cpulist=$HK_CPUS \
>>                 --hackbench-runlowmem=True --duration=$DURATION
>>
>> This only records IPIs sent to isolated CPUs, so any event there is interference
>> (with a bit of fuzz at the start/end of the workload when spawning the
>> processes). All tests were done with a duration of 6 hours.
>>
>> v6.17
>> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
>> o About one interfering IPI just shy of every 2 minutes
>>
>> v6.17 + patches
>> o Zilch!
>
> Nice. :)
>
> About performance, can we assume housekeeping CPUs are not affected by
> the change (they don't seem to use the trick anyway) or do we want/need
> to collect some numbers on them as well just in case (maybe more
> throughput oriented)?
>

So for the text_poke IPI yes, because this is all done through
context_tracking which doesn't imply housekeeping CPUs.

For the TLB flush faff the HK CPUs get two extra writes per kernel entry
cycle (one at entry and one at exit, for that stupid signal) which I expect
to be noticeable but small-ish. I can definitely go and measure that.

> Thanks,
> Juri

