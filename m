Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E91A9FA8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747248; cv=none; b=TeRCaK/oXNR3hUwDPOIDLi4t14QiwUOMe6zysdguyWrhrQUL6Sfo5UlPx8mow7YI4Uv4HTzzaDxvFOu6JdlQJcM+JjAhBXAswRMJWYNT9kSscWtMn3YDMv9uAjXU59kaei3BktDoR6CFc/7CUYFmpkifTB1pcQH95JjGuMip098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747248; c=relaxed/simple;
	bh=L6jzwQGVVcWIIO7+gX8ZgqRPVVFH7OzGRqe+Ia90DU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nmw5wd9hR4Lz1Zn2LUEovjGXqJ3W2uudLGbJ2B0YHq/QR3bocLYmCI5MMBfDtGJHxmrg0UqWy0KazzvKqGLG4RjSrTWFJ1S3YyTyWAWv4fyFqVE4bNwYfsqTzwp4WuDeyDSC5GhS+s+gJTp5HHgHRmWygyz1GQC4gRr2uw0WVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkCb2CXQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkCb2CXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761747244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz02NyUjFvvwgxoacij+FT8GFgL/ftCgtOYuG6E4VVc=;
	b=UkCb2CXQcl192ure5BpZ3obXlhOBcAKK3XZzGYzheZOm6KsKzuk9IMSFoKN8RTjPVZp5dv
	51lhaVtLPUDm0sJwLLgO/qzcIp+Z/B7pgwXrcDU4qJ4NCLn0NMVGQrTpPlcMnTe6MZCder
	m26lG8vhhyGalC3mW1eF4WM5zM3kYt4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-aT8Bjc-cMAmXlhYquegLsQ-1; Wed, 29 Oct 2025 10:14:03 -0400
X-MC-Unique: aT8Bjc-cMAmXlhYquegLsQ-1
X-Mimecast-MFC-AGG-ID: aT8Bjc-cMAmXlhYquegLsQ_1761747242
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47717c2737bso5170935e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747242; x=1762352042;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYXy/T5OYgT19DHuKKWwDf9vfL9WSRPLsc+nPGT92ds=;
        b=TNKb0cTjniFTSFDtQvSXG4fxcn/byigiZdAdyTcpLmbX3KxH7L1rR4QW3IDyeVbDA1
         VmTDJBkjyL+X2H+Wariz3SF1w6QjDNbtAaRE6whV/olf3AXA00PM2BVe40EKPc6+wjHz
         6KuGxm5xK2oYYVSRBCgeUVUWMiO8YQoViRd8AVPewMuss189Volda8uJJohWZ3yeAeUz
         IUbgrvXoqkRYXSCY16GqLQbPeuDm2d8PaF96XABXfGB5N7NQLu5bcOc6ti+Lr+Afu7i9
         Ty9Av1tEGAaPVpowabNUibodCixGss+j/1Z/F9KDKeM81vQsJ25AFvQkITnZsXQN6Dxo
         zshQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ibss/GArJEF6DUA+RJ+zk/BI6T8IxzuwA4Jb0HM16uQ3Sv+vQQWpidbdGbpD+sFKCCE1GqyQXZaLiWHRRKgXQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvqxGsMYrKSXpi61gaQDJMxcwBUSmpfAbn60drgdZKRhEBlJg
	YCW8eSojQrwtPu2SWT4FaEg5Tmud6F8YoqTX61QE+VLwl7lKBD7yRnDQ1mMCgVcZv2ps4z49UpJ
	TR46Q6GpYocazHaK8lx2sm4BtyzHSevMMV2dosQFa2HcopCgFMPcmm0hR10w7TUVW6MMHfiqbag
	==
X-Gm-Gg: ASbGncvtiA8U4NZ2+4+m8DPQKzGD4SeIrW6s7Ha84tldWjqNQjbKdKAsWrsAiCfWOMj
	uGLAd9Qj3zncFmAVCstTCEwkH+UxEm+IiY8uq7SOPwHHJk6SYbpGR45DSoo781eTtIXt+IyROgM
	VXMDVZMu2RySxl+M12koPPoKMRra5LsvWD1CQm8p1u2lalAkH7uEt+m2QwmvTBeh6Hfdsh20dag
	BpYBPewmocnH2wU20qLCrloQ9rzGKT2csEXqZZmloM8p67PPUgXFbaXoXObGcDYAHJcau0htYAa
	/GWv/mY+WSwj71raU0gda5MlWTk9hBmrRJpnxQbt3F/0xa9qSWRADsSCBNT/Vy8z0LzWbJlr+30
	2scAqHbYKKSKQwATMTl11bYhnq4yeNdRvCP2q8l8Ivu28GTCxWLGurPEr/BF6
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr30985845e9.8.1761747241984;
        Wed, 29 Oct 2025 07:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ZXdnOISpERgBiJ9ZdxsqH+M706mFK4IVywCP8xRKb07Mt6iBAhayCrF0GEYoqONAFcNsMA==
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr30985385e9.8.1761747241429;
        Wed, 29 Oct 2025 07:14:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47719004d79sm45516125e9.5.2025.10.29.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:14:00 -0700 (PDT)
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
In-Reply-To: <aQHtBudA4aw4a3gT@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
 <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQHtBudA4aw4a3gT@localhost.localdomain>
Date: Wed, 29 Oct 2025 15:13:59 +0100
Message-ID: <xhsmhwm4dpzh4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tjPG2JsK9OKoCUQpatD7DPr4J3ygIZdDiC-A_YsDsMg_1761747242
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 11:31, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 11:16:23AM +0100, Valentin Schneider a =C3=A9crit=
 :
>> On 28/10/25 16:59, Frederic Weisbecker wrote:
>> > Le Fri, Oct 10, 2025 at 05:38:37PM +0200, Valentin Schneider a =C3=A9c=
rit :
>> >> @@ -171,8 +172,27 @@ For 32-bit we have the following conventions - k=
ernel is built with
>> >>      andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
>> >>  .endm
>> >>
>> >> -.macro COALESCE_TLBI
>> >> +.macro COALESCE_TLBI scratch_reg:req
>> >>  #ifdef CONFIG_COALESCE_TLBI
>> >> +=09/* No point in doing this for housekeeping CPUs */
>> >> +=09movslq  PER_CPU_VAR(cpu_number), \scratch_reg
>> >> +=09bt=09\scratch_reg, tick_nohz_full_mask(%rip)
>> >> +=09jnc=09.Lend_tlbi_\@
>> >
>> > I assume it's not possible to have a static call/branch to
>> > take care of all this ?
>> >
>>
>> I think technically yes, but that would have to be a per-cpu patchable
>> location, which would mean something like each CPU having its own copy o=
f
>> that text page... Unless there's some existing way to statically optimiz=
e
>>
>>   if (cpumask_test_cpu(smp_processor_id(), mask))
>>
>> where @mask is a boot-time constant (i.e. the nohz_full mask).
>
> Or just check housekeeping_overriden static key before everything. This o=
ne is
> enabled only if either nohz_full, isolcpus or cpuset isolated partition (=
well,
> it's on the way for the last one) are running, but those are all niche, w=
hich
> means you spare 99.999% kernel usecases.
>

Oh right, if NOHZ_FULL is actually in use.

Yeah that housekeeping key could do since, at least for the cmdline
approach, it's set during start_kernel(). I need to have a think about the
runtime cpuset case.

Given we have ALTERNATIVE's in there I assume something like a
boot-time-driven static key could do, but I haven't found out yet if and
how that can be shoved in an ASM file.

> Thanks.
>
>>
>> > Thanks.
>> >
>> > --
>> > Frederic Weisbecker
>> > SUSE Labs
>>
>>
>
> --
> Frederic Weisbecker
> SUSE Labs

