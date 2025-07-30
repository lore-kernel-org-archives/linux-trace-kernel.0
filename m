Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF80481A3;
	Wed, 30 Jul 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888191; cv=none; b=Tkwl19cdeTF488CrbxlL8McDMhv+u8Srdwzeisq5q8Wt5nz65RiqVypkJaCE2XkFWp5I/ucy2qngVLAnTEPG3b9jYBy1QFQQzALlQYbWWXod2cXSyBTjyGmhixGWUNcbee+dRlDnucrVI9nMZxEPJ9PBeUrYuXcV0OwMnHhWFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888191; c=relaxed/simple;
	bh=P+71rJwivA7LrqeziBuJ+xJ1lA6/s7LcVIshHpqtCD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsfanVB+kHe+7w+OGyEyngw2MOIcdT2tKOs2FHq+xtuq7ySADtBqVrrcrAEcm7uoPLrWPUpT65gzt+y6f5E1jqUMp8d5ZCMaFFPwdh7C5fm1I7LuRxvOh70ffgkCNqoRaz90IG5DK+AeNtdwE1ykhELV3KklCKFu2cow3dPDqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vF1S2nDQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMpadHSt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vF1S2nDQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMpadHSt"
Date: Wed, 30 Jul 2025 17:09:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753888187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlnXIP/OxpkTTqF3JlbMGyhxUu+zw1hkC/BN7ioKaNY=;
	b=vF1S2nDQVjCDgG8BzAQM73DNzwhfzRftd163VYneDuXUobff4d5bf6LZX8qQcL9PG+lp+d
	ky4Py1kxonpB64p6rQDhymrFDUcAw4TE6JwfMjrbk6ufyS/1A+nQpNebXLTAszC53q1FdT
	J5KfAuIqaXELB7DhCmeLFksEY12Rhq2JteOz0Xv0L1EDxWvMIqhpmk55TLgJ4l+klrVQJC
	OBJ6QG2lXC32Lxf1rOODEDvZ93bFHaiDFQ3xMiap0pgxvwK62yIfFFrHpy2Wit8K7CyH6v
	wuVSuHjO1p6M4PNCWFOk5pFBMwDufuWkFqIkk1UIgujC8tJ6pWZkDrHfPcVl8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753888187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlnXIP/OxpkTTqF3JlbMGyhxUu+zw1hkC/BN7ioKaNY=;
	b=LMpadHSthgJz7YXJk4TT3TnPV80EgWvjBN15MIIV8+k0o6Lk7RA7Ybw4TWzJIsivUBEAIt
	JKirGe2nORfWDKAQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v5 7/9] rv: Replace tss and sncid monitors with more
 complete sts
Message-ID: <20250730150946.HdhW6QPa@linutronix.de>
References: <20250728135022.255578-1-gmonaco@redhat.com>
 <20250728135022.255578-8-gmonaco@redhat.com>
 <20250728155332.sbkepHj7@linutronix.de>
 <76d7e572aae2ccd1699a461aded7a6146f6d8215.camel@redhat.com>
 <20250729092510._Hq3RWF_@linutronix.de>
 <20250729093717.3AqIu_f0@linutronix.de>
 <5803d2623278c7516406534b035a641abfdecee6.camel@redhat.com>
 <20250730125224.ScWqm03r@linutronix.de>
 <20250730141643.RD-uucXa@linutronix.de>
 <20250730144450.rpfei2in@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730144450.rpfei2in@linutronix.de>

Here is a deeper log, CPU3 only:

 illegal-1091    [003] d....   112.407127: da_event_sts: can_sched x irq_disable -> cant_sched
 illegal-1091    [003] d....   112.407163: da_event_sts: cant_sched x irq_enable -> can_sched (final)
 illegal-1091    [003] d....   112.407177: da_event_sts: can_sched x irq_disable -> cant_sched
 illegal-1091    [003] d....   112.407186: da_event_sts: cant_sched x irq_enable -> can_sched (final)
 illegal-1091    [003] d....   112.407196: da_event_sts: can_sched x irq_disable -> cant_sched
 illegal-1091    [003] d....   112.407203: da_event_sts: cant_sched x irq_enable -> can_sched (final)
 illegal-1091    [003] d....   112.407212: da_event_sts: can_sched x irq_disable -> cant_sched
 illegal-1091    [003] d....   112.407218: da_event_sts: cant_sched x irq_enable -> can_sched (final)
 illegal-1091    [003] d....   112.407227: da_event_sts: can_sched x irq_disable -> cant_sched
 illegal-1091    [003] d....   112.407234: da_event_sts: cant_sched x irq_enable -> can_sched (final)
 illegal-1091    [003] d....   112.407254: da_event_sts: can_sched x irq_disable -> cant_sched
 illegal-1091    [003] d....   112.407261: da_event_sts: cant_sched x irq_enable -> can_sched (final)
 illegal-1091    [003] .....   112.407271: da_event_sts: can_sched x schedule_entry -> scheduling
 illegal-1091    [003] d....   112.407312: da_event_sts: scheduling x irq_disable -> disable_to_switch
 illegal-1091    [003] d.h..   112.407332: da_event_sts: disable_to_switch x irq_entry -> in_irq
 illegal-1091    [003] dns..   112.407418: da_event_sts: in_irq x irq_enable -> scheduling
 illegal-1091    [003] dns..   112.407431: da_event_sts: scheduling x irq_disable -> disable_to_switch
 illegal-1091    [003] dns..   112.407438: da_event_sts: disable_to_switch x irq_enable -> enable_to_exit
 illegal-1091    [003] dns..   112.407448: da_event_sts: enable_to_exit x irq_disable -> enable_to_exit
 illegal-1091    [003] dns..   112.407460: da_event_sts: enable_to_exit x irq_enable -> enable_to_exit
 illegal-1091    [003] dns..   112.407472: da_event_sts: enable_to_exit x irq_disable -> enable_to_exit
 illegal-1091    [003] dn...   112.407481: da_event_sts: enable_to_exit x irq_enable -> enable_to_exit
 illegal-1091    [003] dn...   112.407492: da_event_sts: enable_to_exit x irq_disable -> enable_to_exit
 illegal-1091    [003] d....   112.410126: da_event_sts: rv: monitor sts does not allow event sched_switch on state enable_to_exit
