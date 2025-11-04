Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC742E612E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255346; cv=none; b=BNPZOx3ddijq00TjACU6DIQOiyJLO8ppv/KRnk1vHI6NJk9M0kVEr67KHLMeBe4FP41vjR3GOQltz+pHLf24HVhqXLLhyx+6X7bS/+5JKNqhZzKXFjLcO43HfMEQJQXDZy7gjQVNIr9GTQtpfMv2oHXwNg5WevHiGH+D0gcDAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255346; c=relaxed/simple;
	bh=50x9iL/Y/BljBKuXl4bSN56iD5/TTDcB13FlDryEG7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1Gk6S6Cbo6DN0RoP9QOtwAKElQKjPKDIX6IepNIW52jhghLujECV5jw8hq+Lw8tsg7X0N/EDvywn/O1dnKbLczfVCXIcd5XmBt64xHRZ7qdYScZ3svAz7QvSpJjyuhK8ExVcm+0FC2zz0JzMK53hukh3vdFBLZv4YMGPvfJpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlzFl/TP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlzFl/TP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762255343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QOiwR+3npBDpnhOAXG48/ro8cjEOatu32+L6Iae+fU8=;
	b=ZlzFl/TP1mL7TarPQommwGhVGc9QrFGu+qeu8ruRfucmrrTpGsFddufRSRcXkErfTZopil
	94vPgb3diaQ27Dap16QuFOG0yBGttqSwMwD8vL16AhEjMsG1oEkNZy1b6NME6NmKkiqoc9
	kR+k4ZFhiJ2+zeP8eyqeoFtjCv3OUhA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-OX-uAnzuNrOrXdiqog2IIA-1; Tue,
 04 Nov 2025 06:22:17 -0500
X-MC-Unique: OX-uAnzuNrOrXdiqog2IIA-1
X-Mimecast-MFC-AGG-ID: OX-uAnzuNrOrXdiqog2IIA_1762255334
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6596818002C1;
	Tue,  4 Nov 2025 11:22:13 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.33.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B895630001A1;
	Tue,  4 Nov 2025 11:22:04 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jens Remus <jremus@linux.ibm.com>,  Steven Rostedt <rostedt@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  x86@kernel.org,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Josh Poimboeuf <jpoimboe@kernel.org>,
  Ingo Molnar <mingo@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Arnaldo
 Carvalho de Melo <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Andrii Nakryiko
 <andrii@kernel.org>,  Indu Bhagat <indu.bhagat@oracle.com>,  "Jose E.
 Marchesi" <jemarch@gnu.org>,  Beau Belgrave <beaub@linux.microsoft.com>,
  Linus Torvalds <torvalds@linux-foundation.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Sam James <sam@gentoo.org>,  Kees Cook
 <kees@kernel.org>,  Carlos O'Donell <codonell@redhat.com>,  Heiko Carstens
 <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v16 0/4] perf: Support the deferred unwinding
 infrastructure
In-Reply-To: <20251024145156.GM4068168@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Fri, 24 Oct 2025 16:51:56 +0200")
References: <20251007214008.080852573@kernel.org>
	<20251023150002.GR4067720@noisy.programming.kicks-ass.net>
	<20251024092926.GI4068168@noisy.programming.kicks-ass.net>
	<20251024104119.GJ4068168@noisy.programming.kicks-ass.net>
	<a59509f0-5888-4663-9e82-98e27fc3e813@linux.ibm.com>
	<20251024140815.GE3245006@noisy.programming.kicks-ass.net>
	<20251024145156.GM4068168@noisy.programming.kicks-ass.net>
Date: Tue, 04 Nov 2025 12:22:01 +0100
Message-ID: <lhuldkmujom.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Peter Zijlstra:

> +/*
> + * Heuristic-based check if uprobe is installed at the function entry.
> + *
> + * Under assumption of user code being compiled with frame pointers,
> + * `push %rbp/%ebp` is a good indicator that we indeed are.
> + *
> + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
> + * If we get this wrong, captured stack trace might have one extra bogus
> + * entry, but the rest of stack trace will still be meaningful.
> + */
> +bool is_uprobe_at_func_entry(struct pt_regs *regs)

Is this specifically for uprobes?  Wouldn't it make sense to tell the
kernel when the uprobe is installed whether the frame pointer has been
set up at this point?  Userspace can typically figure this out easily
enough (it's not much more difficult to find the address of the
function).

Thanks,
Florian

