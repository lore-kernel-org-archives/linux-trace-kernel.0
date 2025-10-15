Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BADA17597
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534183; cv=none; b=ZAh4ySsj3kBhQlVxPYOaoV2SHJZwMvR3hDknJkFMNQPp3JlJfoRJZJMf8ZGVbUDdSnmrUMAwvOt6bld1R9hDZPXn7GXJUPy2sdSp2efXydY6LNf6b0vyb1ga2PxT2Z+CE+HcFvaPmYepFpp40qu/+pPs8BnwMXVrdxcgO0QJK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534183; c=relaxed/simple;
	bh=M7sveWIwSyElJMftUtieF2H/cZGlYIv8nec0oGZVR9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSNiG/rDP/PC6IvzQ2WjBvsVa1dQyXl2yV9ZYL/Ke/pkP4I6Pxh8QtWGfxGfa4lbuxV4omYYN1C99iMyEGHIu94L9/HZu2CNbJ3iofQnLoA4pJnb0NX3/Fs4s+yLE9+d5SlJg7smgkgwEGmKxTEpxLYU7dUdPeXPr7qq+GAXKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR0F3Rd1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR0F3Rd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760534180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD6dvIl7J8wWJkas/YONpCBWDBu3WvjIWx4zsxh951U=;
	b=OR0F3Rd18+UXyS/ur6I8fgwRmdEiRYxrMTXOkYqtRytU9ouhAtC8UH26QlGdqvgXFeJppJ
	IQkA7GCJAB1qGi+Nh5Rb911P4iicIptHyWaEnQca9KHpjMbRHRlqKmjohv4ZhnCUQzkw1f
	xx1lGccBp0u1AiUu/w0gSwcnXcrbjng=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-6O9gqVF3PcivejrzvTaA-w-1; Wed, 15 Oct 2025 09:16:19 -0400
X-MC-Unique: 6O9gqVF3PcivejrzvTaA-w-1
X-Mimecast-MFC-AGG-ID: 6O9gqVF3PcivejrzvTaA-w_1760534177
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso5281229f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534177; x=1761138977;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yD6dvIl7J8wWJkas/YONpCBWDBu3WvjIWx4zsxh951U=;
        b=QVTKcZZwD7PoqKf6mKMZ0Ttlmvf95Z32MAaiVrScPV+tzYsxnCx5l8hrmnrNuqHJyk
         5d5eUGTeun+I/iYjUueB5gtanrlvRRrfw1ikDTS01xjhJHwt5MDj0UajBQOteANES7My
         FZxnyHadabHQuqe+a+EihiksRavhLSKlhHhQoHQgeUuZWGgocbedqqtHPOfnCzL65nwt
         6laksOC25dWGjLDkqsnGMkG/ucvtsl4LCCpPzGLW8kdLkSysJsgeuM7vCSwuGlJllmHy
         LjnglgW8AjBUnVIPejxhEp/5YFKnT+BTHRVj9cKbz3qCY6QD/yRF9NNbO5Bv0Arpku2g
         g+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXNOxY3QTsZV+2tzjX1Tdc4M7rsEQVMrccPv1I1u/7pW7ucPuRo5awAInKACf0HFAyE8/A/hGutvN0qFelpd+CzV9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbQ1YozTquUR943REqavuBgJvOXzotO41ocpABTi2to+Irs2M
	Vv9pq2+npuWG0t5MqHfSEoEecn/HRHboKEoNBO6DCJdnnChi4Ywxmfp5fcWZptlvZTO6iLYT+oQ
	yPzekzFSlaaALs6blKhjTucDwjA3AOXOc5ChkUFPBhyrSJ7zZLch8jKPCL3Nz3BMD06zaDLCZZQ
	==
X-Gm-Gg: ASbGnctJ4sTcFdJplDa57HGt85AUxlHz0K6BYojVC/0Bu4mQHlmq5Bgo2R9B/gjBIu/
	in7BwSYDsn8MM6kXZoHGXzqbK2vJkVjb2l00n9HqAZWUlBWCrBVNUESeyRY7PUmYB4/s9VLeFdk
	10F/7N3NspH6HkF5MQ76CJdHsIIpbvYEtI7bha6F/Y5F7k+5ZvQyfUnN5IUuohY0hSA0eHxpica
	F18Vf/wmrUxEje6OEri0oawnoU7AUlMQQZStof2ib2s8WZkIMO1JfbpxVtSnaGd0JxDyn3ai7S6
	twzOzn+jIHG6Y/6fsAJPBeAkvvNvOPUvgfHoOV9AJEJl4f16Sf3H7/tfQV55KeYuu03rDPTNJAI
	TPX+aeIuy6rHvKkGllRTkqpMfhg==
X-Received: by 2002:a05:6000:248a:b0:3f2:dc6e:6a89 with SMTP id ffacd0b85a97d-4266e8e4c29mr18416305f8f.57.1760534177088;
        Wed, 15 Oct 2025 06:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcUjf8Yi428dP9FWOn2X364zzJqp12CDvIxSjruyz4UDGZF5I3K12BFelQ7PlgEZWXYUZIhg==
X-Received: by 2002:a05:6000:248a:b0:3f2:dc6e:6a89 with SMTP id ffacd0b85a97d-4266e8e4c29mr18416272f8f.57.1760534176503;
        Wed, 15 Oct 2025 06:16:16 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57ccb1sm28976327f8f.8.2025.10.15.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:16:15 -0700 (PDT)
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
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn
 <jannh@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Oleg
 Nesterov <oleg@redhat.com>, Clark
 Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <xhsmhzf9tld2r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
 <xhsmhzf9tld2r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Wed, 15 Oct 2025 15:16:13 +0200
Message-ID: <xhsmhwm4wl2zm.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z9Di3cOmTZkKTz7_u5cODT0vGcLa35a2_Ju9dOsCCd0_1760534177
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/10/25 17:26, Valentin Schneider wrote:
> On 14/10/25 14:58, Juri Lelli wrote:
>>> Noise
>>> +++++
>>>
>>> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
>>> RHEL10 userspace.
>>>
>>> Workload is using rteval (kernel compilation + hackbench) on housekeepi=
ng CPUs
>>> and a dummy stay-in-userspace loop on the isolated CPUs. The main invoc=
ation is:
>>>
>>> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}=
" \
>>>                 -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
>>>                 rteval --onlyload --loads-cpulist=3D$HK_CPUS \
>>>                 --hackbench-runlowmem=3DTrue --duration=3D$DURATION
>>>
>>> This only records IPIs sent to isolated CPUs, so any event there is int=
erference
>>> (with a bit of fuzz at the start/end of the workload when spawning the
>>> processes). All tests were done with a duration of 6 hours.
>>>
>>> v6.17
>>> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
>>> o About one interfering IPI just shy of every 2 minutes
>>>
>>> v6.17 + patches
>>> o Zilch!
>>
>> Nice. :)
>>
>> About performance, can we assume housekeeping CPUs are not affected by
>> the change (they don't seem to use the trick anyway) or do we want/need
>> to collect some numbers on them as well just in case (maybe more
>> throughput oriented)?
>>
>
> So for the text_poke IPI yes, because this is all done through
> context_tracking which doesn't imply housekeeping CPUs.
>
> For the TLB flush faff the HK CPUs get two extra writes per kernel entry
> cycle (one at entry and one at exit, for that stupid signal) which I expe=
ct
> to be noticeable but small-ish. I can definitely go and measure that.
>

On that same Xeon E5-2699 system with the same tuning, the average time
taken for 300M gettid syscalls on housekeeping CPUs is
  v6.17:          698.64ns =C2=B1 2.35ns
  v6.17 + series: 702.60ns =C2=B1 3.43ns

So noticeable (~.6% worse) but not horrible?

>> Thanks,
>> Juri

