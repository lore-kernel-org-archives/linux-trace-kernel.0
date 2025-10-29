Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB82EC092
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732991; cv=none; b=giqP3CPGtY90GSRlMdTjorkM6ZnvrGTh+9WfqkB36dDuqHjQwAzV0OhiIpNDOrZI6nsuL1YkidxC19u7baxr6CkVaLrXERXxsFh2ch8S6AkmsyQRabFf7gCgDhCSmEkGARFCGdkMceSYAT0UUo5i55SYvSUEYCo33txcLcPZLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732991; c=relaxed/simple;
	bh=y4PwAyJZ8Gj6V27puxA2P2xQYlP9Ps1a+TkaNWf53EQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZXv6BDdOhuTAlzvo+qw7+vwk+C5+QlkgxhVhEObr+it1b6zIB8DWPaUsLpedVyihcI+gQo2oalBiTdNJTHMJrf6qdCVXKcJQnPPsJXEeWNoS+KOVQ7wVy/6aJiTrGQxVk6N+Mm53alThIXscG+dCNBmNwdwd8Z7pV95KoVi577w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqrYHnG6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqrYHnG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSbP/XItnE8Eu8etTuS9l9QrebV4lnCgmZKR5M55TVw=;
	b=ZqrYHnG6uTAFwmnP6tmJy8mSZJK/L3heXRjZoSfvJQVdauA1HD9VHLJ9QltBNHg0eYG3MN
	5wGntkCfAgOLVOg+8SBcqBxdPrlOg/xvt51VYgSqNcTJ6S7q2u4bUDd+QsGdm2255y9IRV
	jahGgeKp65t70SfpXvO78nJ43UVRvOE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-z5c9Q7ohNiGHCAdKrQT1Ng-1; Wed, 29 Oct 2025 06:16:27 -0400
X-MC-Unique: z5c9Q7ohNiGHCAdKrQT1Ng-1
X-Mimecast-MFC-AGG-ID: z5c9Q7ohNiGHCAdKrQT1Ng_1761732986
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so83692365e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732986; x=1762337786;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/btFKEFxhLEeC8J1xdXSDjZgEcY68zMIb5ZfPzXsUAI=;
        b=T5HzF3eGQrpkIypScS7F0qApbfWS9u9h81veZMXFYk7Tf5QZWiFMcW6QM3KcuqYOL5
         A1dGA2skZpmXsBoZFtNuivgIPEKe+LTL7X3c5r7q6kHfVDkCejHVSGgdDTKpJzWlx/nh
         VKrDWIeBSL/nYmaudHtsHw7D97fHgd6NN7aUIr06zDYP518UnWC7oVSbxejRqBj7JQAW
         bW8FiuQWP25LWFp2X+aNIJqxB+JGczC7bqwhKNY2G0WokAxRuLWy/nvcUgJQ3lO4ePro
         vmwcvWgGLEGviMCruKP4tNDQ/Nv6M0TRch3Yc1v0MypTOeD2Wa2akPAJHFYorWNT+9Vc
         Fcpw==
X-Forwarded-Encrypted: i=1; AJvYcCVqNyKkPlfsXXrrHIwrXA7ewq8VgW4vBXlJhziFp0sJvK4vyT0YF79jMq8MPQR/Z3XnKgnuVIS6Scox2oca3DBNM20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+7D5utwbPnoynCjH09F3itI3gCB8BNjh0JS0WBNHVQ9ZCZ7T
	+4SUjnYXXBCzluc3Q6fV0+t+ZE15lkM8FobqyfJ4/kpMO//E2vC+mbd4Ei8BwwivT7KgnPETzvq
	FhVyXjhny0L0gfBUCh37aKxo6BWA7t4bZcLWto8+mHHb/5BKZ9522ENs4aXpsOZ8ioNGXLC79/g
	==
X-Gm-Gg: ASbGncuxT1RPVrm8mbvELsS5ClrN5px81bTFIwbpSscvRXYqiepnSMet9mAZ4WaIBOU
	RmAmyhndulsMZe5lWQfipKmmFWDeaw9glY+SNy3kZHUqMdgDjqQg3319atHztaUsRVZCLJCykxa
	1btLA/LnpyckQNE/Zzy0pSQA8tx1c/Ew3hMXfaYDnmNMlx4/zYAK6PdpM+D2MVasCkDxwp5+uaP
	4gyRDD5XNXZnYH9q7HDFKC9WhgTzbGk0rkFoAPcVfCwwdJZ6shNroCytP75izcmZP2Ki8X0FRYD
	8bjLXMS1bJNl09pXoUlX71q1uI33JQ/gp6FwXh1GFfJd6uoOFDvSACdh5VwoNahX7usvdy9xmg4
	wMuK1g9Rx06ebNeMdoBwoZHqIiSstLewNfuMNH4wrhi/k2VzaxWLtY1rgp7T6
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr13218565e9.23.1761732986074;
        Wed, 29 Oct 2025 03:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENaoAuowDmNKRs2e7mInj3dgyeHZe08An/EQmhaeEKImjMyXA9vgcPYVOhC1MZ8t+wInccTA==
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr13218175e9.23.1761732985564;
        Wed, 29 Oct 2025 03:16:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm25828786f8f.6.2025.10.29.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:16:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <aQDoVAs5UZwQo-ds@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:16:23 +0100
Message-ID: <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GVhYNuuNB791kXomdXMS3_FH77rJEl0W-2bjKkUy_SU_1761732986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 16:59, Frederic Weisbecker wrote:
> Le Fri, Oct 10, 2025 at 05:38:37PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> @@ -171,8 +172,27 @@ For 32-bit we have the following conventions - kern=
el is built with
>>      andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
>>  .endm
>>
>> -.macro COALESCE_TLBI
>> +.macro COALESCE_TLBI scratch_reg:req
>>  #ifdef CONFIG_COALESCE_TLBI
>> +=09/* No point in doing this for housekeeping CPUs */
>> +=09movslq  PER_CPU_VAR(cpu_number), \scratch_reg
>> +=09bt=09\scratch_reg, tick_nohz_full_mask(%rip)
>> +=09jnc=09.Lend_tlbi_\@
>
> I assume it's not possible to have a static call/branch to
> take care of all this ?
>

I think technically yes, but that would have to be a per-cpu patchable
location, which would mean something like each CPU having its own copy of
that text page... Unless there's some existing way to statically optimize

  if (cpumask_test_cpu(smp_processor_id(), mask))

where @mask is a boot-time constant (i.e. the nohz_full mask).

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs

