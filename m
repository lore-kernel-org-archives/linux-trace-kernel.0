Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F0314A95
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359878; cv=none; b=naXurxvfYLR0nLHUSPTyHhBwEaw0FNTuYDVtVtkwHMlImjM2RYzQhdftrcrYR/eNJ+rfRUAc8r8YTY0vYmKNj6jrBa/++OoIAoEQsRfZsvNHOQWXgHO62BJfeJpGXbZV/2oKpHslmUAxxoFcBKbg4IQjqcEFMM/G0uCgJ/yBBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359878; c=relaxed/simple;
	bh=z2Ddo9KGHO2cRfukz3n2HSveP3TR5UuZXIcomOdpHeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQsmMPLZ2oc/HzItHzjQioytp1C5WOXPh8bihe/hEifkdG4TGI5nbnBfz0R9c/EfuVfU+cvWbazJaXqSCCBljBrIiPfmxVnDSeZtnE2yEAPquaAsYMEYtt0MLwiC/7Jpt1Xru2s4yGkncBKiPSkUmliH+uLXF7B8rNQqfz5hpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsibnOTX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsibnOTX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762359875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pRDkw3OiFwhnb76GBtLAGbxTsylSIgAC6rXytdCdKE=;
	b=dsibnOTX1vhCWey85izUGyetA4hdx+49xNpwToWVcFcLao1MuAX3uj8gUVP5E7eWKHjq5n
	8MFpaYBhwXJDddkE05plPeji2bNM9FWK01eC6vwf2r+k8ENppGQP0nmbRFdGz6T6o1OonR
	C99DR7LrKAEkexIg97WE6Y+BMd/1giE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-g1W9jiImMC6MQDkIBcKbOA-1; Wed, 05 Nov 2025 11:24:34 -0500
X-MC-Unique: g1W9jiImMC6MQDkIBcKbOA-1
X-Mimecast-MFC-AGG-ID: g1W9jiImMC6MQDkIBcKbOA_1762359873
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775e54a70aso9539935e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359873; x=1762964673;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPk6YcBuruLXQ/o+Uci3gsoXIOQlnGdWukNwLQbwsoc=;
        b=U/oCxbQqmT4h1pQ8SfWxSHgaru7XynS98huShlCyqU0iMTR9HQsRfoqkLy5F/ToGkB
         0sC6CETTGvD+mRpPG2ImTB2JelKhQu3wYXXo239G93ly9YaLe70yFuPu/KpX3ZusABVg
         5zXbKfppC6Q9VdcgwHWoHQQrQRYzcMS05sV0wjhZAt9orE1GpVXTTVf7n8W3VyZSmF63
         iJ8GdXzACf3CT3MeHLoJBtpnOPm1kUZ1fw0AlF9Adn3Q5PoO0Nobd0SzP8MzJ9Vtsamw
         NK3eDw3UU7YjXcM8nIWXCgSrvKadfGcZQifeBC1Cvot8iD7KZjA10xdtVjBDm6CcLyRX
         2OwA==
X-Forwarded-Encrypted: i=1; AJvYcCVQXbKWu0dJ9QI32zlEnMxZSZkb0/m3nVN+75nmypWljykdlWycJMMZkIuCRSJSZlI1BB2kCv6NZzlHNuEjEHa+EGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAr4VvsLqGCQuzy5qF8LXNrSeKoHGvmlXpqD8f0hrQkC4G1crj
	UgXaiOc2MlN2McrbMtZ/4z9Lmpo2I8qK9GfzzYrNHzKoHE70bjAWqDXKO3xts/hXVYJEstHkEVd
	+Th27jgmS5CyAASG2lDDWRIEMzPck/YeJjkPPfPImqixawbRcwwPzRQnuP2BxInXKrsHcBuyVsw
	==
X-Gm-Gg: ASbGncvgVgLF9SPibECUqqNN47r+HOZnL/amvCWhXYkcSzD1C7QSgLLvPzx0S30eKwO
	0Qu3Q9wS5AaT2haE4ihHcpeHCPfs3JNGjQ20MW2AWhmCu83ox6ldf3RblygyTgQkn7ColheT6k5
	LIYgUuoz8GJywVm0uuLF1M6/4V8seToplikEQcT3x/OV+IxtiKDfp3qEEuH0mgcv9Mkjoi2rRo7
	2gm1EBDVcId3oAuxGikag0PqAUf9ZL3E6GPLoFwH/52ffqELfExxs4tQzuaDiOfvi3IqSxlt7tZ
	4fG4cZ0q+d2aUcSPXumkc1Oz2+dtmPQ/f4PhpFbqkERsMt1hLww4IAb4cfTALPbJDHfa5QByW5A
	nbICnbprwKAmddnZtuLplXNH0jInEeeGwAQ7OFUSp9lwYrNz0X/qEeF/Lv/jj
X-Received: by 2002:a05:6000:2907:b0:429:d4c2:cadb with SMTP id ffacd0b85a97d-429e3311ac6mr3563194f8f.58.1762359873172;
        Wed, 05 Nov 2025 08:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL75fsQ0H2l1YahgWByyszuFW6670iMBa0il80FwPsU0pgmLcV2khMdpXTiSamLH801kgv9g==
X-Received: by 2002:a05:6000:2907:b0:429:d4c2:cadb with SMTP id ffacd0b85a97d-429e3311ac6mr3563132f8f.58.1762359872637;
        Wed, 05 Nov 2025 08:24:32 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fd2a7sm11003113f8f.39.2025.11.05.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:24:31 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aQJLpSYz3jdazzdb@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
 <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQJLpSYz3jdazzdb@localhost.localdomain>
Date: Wed, 05 Nov 2025 17:24:29 +0100
Message-ID: <xhsmh8qgk5txe.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9bhaPM-b2TJXvTDzoBGrb648BPmN5zzmM3tcuAtaihY_1762359873
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 18:15, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 11:32:58AM +0100, Valentin Schneider a =C3=A9crit=
 :
>> I need to have a think about that one; one pain point I see is the conte=
xt
>> tracking work has to be NMI safe since e.g. an NMI can take us out of
>> userspace. Another is that NOHZ-full CPUs need to be special cased in th=
e
>> stop machine queueing / completion.
>>
>> /me goes fetch a new notebook
>
> Something like the below (untested) ?
>

Some minor nits below but otherwise that looks promising.

One problem I'm having however is reasoning about the danger zone; what
forbidden actions could a NO_HZ_FULL CPU take when entering the kernel
while take_cpu_down() is happening?

I'm actually not familiar with why we actually use stop_machine() for CPU
hotplug; I see things like CPUHP_AP_SMPCFD_DYING::smpcfd_dying_cpu() or
CPUHP_AP_TICK_DYING::tick_cpu_dying() expect other CPUs to be patiently
spinning in multi_cpu_stop(), and I *think* nothing in the entry code up to
context_tracking entry would disrupt that, but it's not a small thing to
reason about.

AFAICT we need to reason about every .teardown callback from
CPUHP_TEARDOWN_CPU to CPUHP_AP_OFFLINE and their explicit & implicit
dependencies on other CPUs being STOP'd.

> @@ -176,6 +177,68 @@ struct multi_stop_data {
>       atomic_t=09=09thread_ack;
>  };
>
> +static DEFINE_PER_CPU(int, stop_machine_poll);
> +
> +void stop_machine_poll_wait(void)

That needs to be noinstr, and AFAICT there's no problem with doing just tha=
t.

> +{
> +=09int *poll =3D this_cpu_ptr(&stop_machine_poll);
> +
> +=09while (*poll)
> +=09=09cpu_relax();
> +=09/* Enforce the work in stop machine to be visible */
> +=09smp_mb();
> +}
> +
> +static void stop_machine_poll_start(struct multi_stop_data *msdata)
> +{
> +=09int cpu;
> +
> +=09if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))

I think that wants a negation

> +=09=09return;
> +
> +=09/* Random target can't be known in advance */
> +=09if (!msdata->active_cpus)
> +=09=09return;

