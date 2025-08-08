Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB942E36E2;
	Fri,  8 Aug 2025 05:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754629991; cv=none; b=D541EizXhE779t6ZMaV4XUNiMjtLZMZ+//HAjj9qgNHlBlUW00wNFr4EloYr16GOnX/W8kHnyWpeVu619L4+fgW6Vf1kfASViVMSN/SkT04YFtZfHzUjuEFLDDCgjCRQPwtMl+ezJXLTK63uMKfThC9lNeKhsm6bD+54oLmR+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754629991; c=relaxed/simple;
	bh=dmIwJzT96cC1HvfFO2mT8P4nn889ip+AFviqKz+52rQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eyZkLav6/usPTEh6+uH1hp1DADVzqYHfL4cuaUffw+/DK3vIj18qC97a5geq/3JEGMQrsPK01tLs61rXiVUOB+0sGmQnEXhD81doyOSkdHLbnJiTnBMT9mCAT0Kg6rNl1aeCgX90ckhgfwN+oLp3o3V0tm9xvsl+hAQ66u7OReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3tVkzJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=grdIYdE0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3tVkzJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="grdIYdE0"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754629988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmIwJzT96cC1HvfFO2mT8P4nn889ip+AFviqKz+52rQ=;
	b=N3tVkzJ7j5wldmI674hcohoB/enBrLFxsjMtIVecvsirTz1V3nZLa9Xt0sbz3O4rD4RyHH
	ijPx8cODJjguUXwKdFIpWPfQSVsaB4z7ahO+5RVxBwNERR0Lcxki6utGhoqNLW0zuCQa7C
	ngpx95UYF8BbPfQPdzZ18v0LB1l2bw1ta0n3F60wGrmsE4nCgmyAAG5Vt33iuRFF7T2+Sk
	sgsTWikw3cwGvEHwCruN3FapdlaLK+nLEUh7YYR+iDa/yvn8+AXcWbL8nel7B7/khPHAnV
	fPJbX+Nl4J7OR9gs+TW6cBTXxugH+i/WkgtFmnZXy1d6djxozRnylA5PkBJ8Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754629988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmIwJzT96cC1HvfFO2mT8P4nn889ip+AFviqKz+52rQ=;
	b=grdIYdE0A6eVNQQd4u4dukqepCVZGF0VRO3o+zeQv2m9exoDW80raOwzl4u7557u7EpqYU
	bGeMRIgBd0TIJqDA==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
In-Reply-To: <957660bfb5c291b5bece9e557f30866728b9aed0.camel@redhat.com>
References: <cover.1754466623.git.namcao@linutronix.de>
 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
 <957660bfb5c291b5bece9e557f30866728b9aed0.camel@redhat.com>
Date: Fri, 08 Aug 2025 07:13:07 +0200
Message-ID: <87ldnupfa4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gabriele Monaco <gmonaco@redhat.com> writes:

> On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
>> Add "real-time scheduling" monitor, which validates that SCHED_RR and
>> SCHED_FIFO tasks are scheduled before tasks with normal and
>> extensible scheduling policies
>>=20
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> ---
>> v2:
>> =C2=A0 - use the new tracepoints
>> =C2=A0 - move to be under the rtapp container monitor
>> =C2=A0 - re-generate with the modified scripts
>> =C2=A0 - fixup incorrect enqueued status
>> ---
>> =C2=A0Documentation/trace/rv/monitor_sched.rst |=C2=A0 19 +++
>> =C2=A0tools/verification/models/sched/rts.ltl=C2=A0 |=C2=A0=C2=A0 5 +
>
> You moved it under rtapp, you probably want to move the LTL model and
> the descriptions there too.

Ah, missed this one, thanks for pointing it out.

Nam
