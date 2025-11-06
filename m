Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C38326D43
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423362; cv=none; b=hLYjX5ht/p2shbCmOqdvhnZvzkHB/+hIrBgTJYz8engCm5sc35TnkA7X0GuXYWyx6IiCyOQvxCX8n6tpic+r3Mkk+Zj2QyfZiUlrNS5yIP69BQKoEEBOHyiNqP33tIeWi+BI3sYtO295rGxBQf3iosSnVVZjvdmrN2HzEK/XlgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423362; c=relaxed/simple;
	bh=BYltfSMqnA7SOq+qPW36sjrfm2FOG2DWsVcGzNNuODA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rOlZGE5oWq8bltkFVkbOvAYJ5nV7Gj1FfJ8oUKn6PUZh8aTqHbtiCbG0dZMNjZczRx4QksIDEm1C5ewDt57cDMOYJ/aojHEL5J7t16Fu8G1A+PHGibCeZq6DomRvntv7jSRZ4auwuaXj04Er8lwDZcyKu9lipXHmWVrKM259Vjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMYqbBsj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMYqbBsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762423359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVdSTjzPPKZ2l7IW0u0zSr5SxYY9yMb26AdkoDhOwNg=;
	b=CMYqbBsjNkomkR72XZPvcFlZL/71qwiKhMykVHEXh0NQYzBMWXxJOZJhuIwx3LeklxZ1es
	AQ/TwTtd6UX0xWuxXCliREa40K1QwIMAfPBissOQdcfCnkL4gv1OcFIEKOXOP+l6WLwLs3
	xnXvl+7eZ6+hc6zNjDIajro72eBsj3Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-dR6Hc_IaOte89Y5nlurHHg-1; Thu, 06 Nov 2025 05:02:38 -0500
X-MC-Unique: dR6Hc_IaOte89Y5nlurHHg-1
X-Mimecast-MFC-AGG-ID: dR6Hc_IaOte89Y5nlurHHg_1762423357
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c9024a1dso447336f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423357; x=1763028157;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvrt5C8X1gp1kp6b+KY8cbLTeVcvbbT6G6kNQJkblK8=;
        b=pFJKpwPKRp0BAaJFazwwzHXBKZVx351b4rwZUMPliu/7bAexS8+ZZsvQhtBUgmhX6g
         735cbtsGEOrpi1LkYwC3iC64fuYMc/6LwxntUwGV7z24YTVcXlpX9A3Ksf20Jkd/Qhrk
         c7r4CuhNI9Wrj509vNfGkwdCTgIy7EtRCfPYx/gfckKLfFFrB08tloVTUhkboWLMR5xV
         x/z5t7KVf/7UicdCMKGH8B48D885n4PQyzTCigfaI08kZRjIDmqe3TWh1fOHnvkqMXMB
         sMsLarOVoyioO08zvSHuyow9GWt6ciG/+sCkS+CO/7cvlo3awcWFXrHmVkOzudi8Ioxk
         nwTA==
X-Forwarded-Encrypted: i=1; AJvYcCVzjxfqEI1jv0T8p14/80nVrHvsI65hEH+JYp/+wwqel8V1/iVred8vWW9hdHOQX/We5A2uBdDhJEfhrStXRJnKpho=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQ+Db1M2kUzsD7HiY5IFl13akIcTr6GzKKI16kWX1fBmnWA4s
	d1hLa9CEJ/KgByy78qqkbe3epBUPXOE89HTL9Jwv4ASSckSjPnzBhPjztn/cYZrISEnpPCjerYe
	JpDJ4eqCDC57EW/Z+wBotf0dvktmfoGGMBL19q/REHBaQkqR0sdDDFv+lIpWczp9vq3AdcQcVcg
	==
X-Gm-Gg: ASbGncuK5KXdZs/+PODtMv3fCY54KAzab8uS99bmyu6ewazPoc2YBcRMDd5GcG4LWJZ
	bujzYXBtWkHBDtWP8P3S8x/pNAAvHifPQ4IDmT81UM7xEP3uDHopD98frELJWyJ6/VzEFiXYB7T
	1RnVkYQ+yOF33YdX9wX+ZRxVQmrXmjcvY+lyHB60MQw0CdNlfI7BNYash+7BjPVPi0/nqalPkVV
	pS1CDydBjWWAWOMwmtbcKXyY0/YezBVu4WAwLE7qN8qTrgpr+mX790hlgIi2pJQRZ6cugalTpM0
	nEj0JioqRgsc1ZwRLaW/LcRZlX78wGkHyo0Wk/5OKujiZ0xsGJhCjlInAdp7+Bbvcq0zOd7T7K+
	Jyjzq0v7DCcE4jWZNBv3oIbB8oPb6AN7gPl/WXSe/EzCYqlcpcI7DCBBcRn3v
X-Received: by 2002:a05:6000:2007:b0:429:bd09:e7ce with SMTP id ffacd0b85a97d-429e32e3751mr5572176f8f.18.1762423357254;
        Thu, 06 Nov 2025 02:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFeAmOLmzeYzGPgujTP1e064ll50Q3Ih/Pj2s9y519WV4ZUw6Tz0GJFNvPvZOTYQG+myOLaw==
X-Received: by 2002:a05:6000:2007:b0:429:bd09:e7ce with SMTP id ffacd0b85a97d-429e32e3751mr5572131f8f.18.1762423356748;
        Thu, 06 Nov 2025 02:02:36 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm4112751f8f.29.2025.11.06.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:02:36 -0800 (PST)
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
In-Reply-To: <aQuNdOEmPYkI03my@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
 <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQJLpSYz3jdazzdb@localhost.localdomain>
 <xhsmh8qgk5txe.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQuNdOEmPYkI03my@localhost.localdomain>
Date: Thu, 06 Nov 2025 11:02:34 +0100
Message-ID: <xhsmh5xbn5vid.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CEv6OqKLZFJA0diEYBj_nRcd7lyRJp1gArINuyS37mY_1762423357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/25 18:46, Frederic Weisbecker wrote:
> Le Wed, Nov 05, 2025 at 05:24:29PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> On 29/10/25 18:15, Frederic Weisbecker wrote:
>> > Le Wed, Oct 29, 2025 at 11:32:58AM +0100, Valentin Schneider a =C3=A9c=
rit :
>> >> I need to have a think about that one; one pain point I see is the co=
ntext
>> >> tracking work has to be NMI safe since e.g. an NMI can take us out of
>> >> userspace. Another is that NOHZ-full CPUs need to be special cased in=
 the
>> >> stop machine queueing / completion.
>> >>
>> >> /me goes fetch a new notebook
>> >
>> > Something like the below (untested) ?
>> >
>>
>> Some minor nits below but otherwise that looks promising.
>>
>> One problem I'm having however is reasoning about the danger zone; what
>> forbidden actions could a NO_HZ_FULL CPU take when entering the kernel
>> while take_cpu_down() is happening?
>>
>> I'm actually not familiar with why we actually use stop_machine() for CP=
U
>> hotplug; I see things like CPUHP_AP_SMPCFD_DYING::smpcfd_dying_cpu() or
>> CPUHP_AP_TICK_DYING::tick_cpu_dying() expect other CPUs to be patiently
>> spinning in multi_cpu_stop(), and I *think* nothing in the entry code up=
 to
>> context_tracking entry would disrupt that, but it's not a small thing to
>> reason about.
>>
>> AFAICT we need to reason about every .teardown callback from
>> CPUHP_TEARDOWN_CPU to CPUHP_AP_OFFLINE and their explicit & implicit
>> dependencies on other CPUs being STOP'd.
>
> You're raising a very interesting question. The initial point of stop_mac=
hine()
> is to synchronize this:
>
>     set_cpu_online(cpu, 0)
>     migrate timers;
>     migrate hrtimers;
>     flush IPIs;
>     etc...
>
> against this pattern:
>
>     preempt_disable()
>     if (cpu_online(cpu))
>         queue something; // could be timer, IPI, etc...
>     preempt_enable()
>
> There have been attempts:
>
>       https://lore.kernel.org/all/20241218171531.2217275-1-costa.shul@red=
hat.com/
>
> And really it should be fine to just do:
>
>     set_cpu_online(cpu, 0)
>     synchronize_rcu()
>     migrate / flush stuff
>

That's what I was thinking as well, at the very least for the
cpu_online_mask bit.

> Probably we should try that instead of the busy loop I proposed
> which only papers over the problem.
>
> Of course there are other assumptions. For example the tick
> timekeeper is migrated easily knowing that all online CPUs are
> not idle (cf: tick_cpu_dying()). So I expect a few traps, with RCU
> for example and indeed all these hotplug callbacks must be audited
> one by one.
>
> I'm not entirely unfamiliar with many of them. Let me see what I can do..=
.
>

Here be dragons :-)

