Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88044308F1D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446691; cv=none; b=eMCuQUWgF5BHTjQK3yzg5E02jB6oN18XC5JbxY/9oQVDAWYFiPv/a3e3gCc+r2vlPW1kgBg6cOGPb+8S4UOB+gg+lW5CS3eQQbLVT4rIK6hvFOdeMDRORNLSetZgKHtJFXy2gXaCw3NTDO8j+v338J4JLbRAv2JWIU8RnmYCb4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446691; c=relaxed/simple;
	bh=K2g5fcbeoiLEypmxm4zdDfAPkL/Zn3ngXE1+qFzQ0Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X6uMlXEp7FKjRDSmBRnnYgB70baAPzHJuXYd0Zxb31ojV9sADqRUuP9bYgGFua8FbF4WGWXOZVAfG/ut2EmRs8rKDxcdArqKPYd9sMtVXjPzy95X8qqcikh1EjS8NOkQ15TzN8FwmCf88gS/GF0uYsAq9CSaGUgnR4/763daZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F25wjcbo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F25wjcbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760446688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+P2Dsj3XLhA6fMrQYgh8OLSwYB2MUOQP3SbJkXqJVA=;
	b=F25wjcbomtI84IuH63y3uCwMe59HV5IiwauKpiD0sHsUdXIpr1gs8FLbLTlt7g7NNTucDn
	pxXrgcizjcEAVg5AzEb65bkVPcHPq0tEww1Mu2shf//a/rTUEZQSXBZS3zxgeS0OdkZFag
	2sqexAC7GHWcCfQQUcgenQ5DS7xbtiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-N5rbdZWsM2eZYIstjL5x-g-1; Tue, 14 Oct 2025 08:58:07 -0400
X-MC-Unique: N5rbdZWsM2eZYIstjL5x-g-1
X-Mimecast-MFC-AGG-ID: N5rbdZWsM2eZYIstjL5x-g_1760446686
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f030846a41so3894281f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446686; x=1761051486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+P2Dsj3XLhA6fMrQYgh8OLSwYB2MUOQP3SbJkXqJVA=;
        b=LwHaX3V+RSP5Am+U2ImS4+yB3L0JFweYc+ONtNfUUB3jCrx7FbYIYk1H1DTRr8pQlG
         +GqSGNApel4rYoT3eLLhPE7BfByce66Ar27zU2dLa4Q+cj4NQAn/EgGKLJCCtXn0QuWH
         lAvrmk/+5dVCrhwnPWIdw0i1dH3qf0H1dgaxBSByfFkQF5LfkDdgGH1Y15wvej5Abt6O
         QeWae3s/UOG9xS5ZwpoFv92dEN/TDf2W8fHZHl8LWHnx9DZPp3bJmW3Z4xbgkItlMy3f
         IgMHL4ODqbkO8ODLmBVzcsOLK5pQcmTm207jgTP7q+rWXB8t6ekuCPacXqZHJ/jDDEur
         kS4w==
X-Forwarded-Encrypted: i=1; AJvYcCXx/HUWuCQDDRrLJi+t63flsMK3mT0fGILOD4G8vMm9QOMNJdkT8fGJfMyJ+qdxsx8kY1hNPAsCLQtoMheEvZmCi+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QTReJWc6e+yDi4JQYgrFRUAD/UNEChrmEjVspftK1SH9/uqQ
	P6UkRiERzhJRHp1z/0KB+hoWaH4X7O3TFVAAzB5K44vtiio58gzautfQmZs3PG5VWvjWBx8EscS
	EbrSvc9GBSqrXu+wZBrLfFSKwdjOW9UXhvjLMHoQb4cuUHEahW2+dOArTY3tkoqies081vhVT+g
	==
X-Gm-Gg: ASbGncuKDX2aujtCTmn9gwMov4f/TtX3l1dlUVH35+69HQY+j5laD6yzYopbxKrOiRG
	H3IFDaK00Ab5pfIUbH28zcBLYWrMr0yFL/RMbvlL26FAvWdloeGLsP0pDvi9A4B8a+dkkosgwWH
	rRoc1TsqiktRUi54Zsw1rJ7gCPlYhuUkF/M20uuTe4g+S9QwXUBnN8x6/ApXeDdz3C+f4fwhCYA
	vIkDRaty2UDlpCfzkL6xvpLRphdy9PNgXccm2TUtC8UatkW/yBLc4VM8cn3s/bmE18LKQ7V3vce
	sxxFRwYo26OQhVmcHn/trSTqJRZVhHeYm/cvI9f0K0GEXr777eFvWGXojrdAfoVM72Pi5l94
X-Received: by 2002:a05:6000:1888:b0:401:c52f:62de with SMTP id ffacd0b85a97d-42666ac39fdmr14487404f8f.12.1760446686041;
        Tue, 14 Oct 2025 05:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAh3YZ5oKpPdr7WASiDkPJn2IILu8/Rh+37A13TS4n2FwBRRVC0ByNWYf0Uu33Aqxt+5Ldeg==
X-Received: by 2002:a05:6000:1888:b0:401:c52f:62de with SMTP id ffacd0b85a97d-42666ac39fdmr14487377f8f.12.1760446685024;
        Tue, 14 Oct 2025 05:58:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm23624651f8f.17.2025.10.14.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:58:04 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:58:01 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zzh0rIrxZspNgYT47AzuILAtjcrPWcR6dlqsoW2SC7Y_1760446686
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 10/10/25 17:38, Valentin Schneider wrote:

...

> Performance
> +++++++++++
> 
> Tested by measuring the duration of 10M `syscall(SYS_getpid)` calls on
> NOHZ_FULL CPUs, with rteval (hackbench + kernel compilation) running on the
> housekeeping CPUs:
> 
> o Xeon E5-2699:   base avg 770ns,  patched avg 1340ns (74% increase)
> o Xeon E7-8890:   base avg 1040ns, patched avg 1320ns (27% increase)
> o Xeon Gold 6248: base avg 270ns,  patched avg 273ns  (.1% increase)
> 
> I don't get that last one, I did spend a ridiculous amount of time making sure
> the flush was being executed, and AFAICT yes, it was. What I take out of this is
> that it can be a pretty massive increase in the entry overhead (for NOHZ_FULL
> CPUs), and that's something I want to hear thoughts on
> 
> Noise
> +++++
> 
> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
> RHEL10 userspace.
> 
> Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
> and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:
> 
> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
> 	           -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
> 		   rteval --onlyload --loads-cpulist=$HK_CPUS \
> 		   --hackbench-runlowmem=True --duration=$DURATION
> 
> This only records IPIs sent to isolated CPUs, so any event there is interference
> (with a bit of fuzz at the start/end of the workload when spawning the
> processes). All tests were done with a duration of 6 hours.
> 
> v6.17
> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
> o About one interfering IPI just shy of every 2 minutes
> 
> v6.17 + patches
> o Zilch!

Nice. :)

About performance, can we assume housekeeping CPUs are not affected by
the change (they don't seem to use the trick anyway) or do we want/need
to collect some numbers on them as well just in case (maybe more
throughput oriented)?

Thanks,
Juri

