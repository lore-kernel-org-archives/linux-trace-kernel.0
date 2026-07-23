Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72F396D28;
	Thu, 23 Jul 2026 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831022; cv=pass; b=CCG/kBnjwIy99RIblrybR9ieIeDIcYoPfhCo+A27RTVTyew2gCEvZm/TUew7WL1NDvKQxMfuQA4ivU1NUgCUGpHeP+IPnQT79cBqAXIym3c3xKqWVlUnZtuv5RBUrAkJ1uwq6vh/j4x5GMWuOaKFAijeGV7EYHINeA4LXmXikm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831022; c=relaxed/simple;
	bh=3uNhk8Gqcqp+3jBTlAy7Jda+kQOTFmW/SAR5QS/3qxo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WEoHyRU83V99/VQHa9c2BaDoAaeEdvDG1Kw/O67DEQvd0OuVUQhgPLm3mji5RApgHJMIaVkfYVBRvlqJUPVCW8QEPiX+p2/nv3NuALt4by8o3yi4suJsY2417lmFL+gpkAEWuM17soVhNi9tpUP8JzDbIOR9+bFY0VJdc9TCCCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=iM9vBO6d; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="iM9vBO6d"
ARC-Seal: i=1; a=rsa-sha256; t=1784830944; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=ZgRGsO1vp6I1TA9lbR1q6pJfXbhHuLjaFrYZd8qa+XXlXa80NrxDt7Cqc5/Yt5Z7UTLtKiLJ+hgvsbwP4zywt3gpGimYObhfJyu3/YMjIzfOA6AaGo9MJXYP11iSrZUs7tSrhR7122sbkBhG/1EiH1DwJSom7/1Okx/ee30NJi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784830944; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FA4mBsQKWU8EQ2CYmvf4S68ZIMYsAwryF0Kpl/acuZg=; 
	b=MP2bNNy8+PQBX7WOQxriWaQLWkosAV0VtpMatnrve8Dbo29zb/lvcoKEr4xMTgaX5+tLVAwpT9vVbQXg/MzTo5E8A3chDfi/2kPKZ8uBAS83cH/J+rdUwuDzj3mHNRqkPT5CF4pLZTiU5HX3+tasGEKC05DKcpdWrVxBRfEU67s=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784830944;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FA4mBsQKWU8EQ2CYmvf4S68ZIMYsAwryF0Kpl/acuZg=;
	b=iM9vBO6dIzMfZnoQW8s4KKgA/LgKEm6GHomoRfr8+/P46orAUQ775dRIJKK7tATu
	xJTCJLZnGs2a7VoSXHV8I8WGK9MD/fqSboFx/9n7GPSgY5ESzFBXSdT2D3LIIua4mex
	YalR7HXYecgJlrwIgxEzJLuUCRPeHjLS3GEHsxUU=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1784830943510389.2736694427938; Thu, 23 Jul 2026 23:52:23 +0530 (IST)
Received: from  [14.139.128.54] by mail.zoho.in
	with HTTP;Thu, 23 Jul 2026 23:52:23 +0530 (IST)
Date: Thu, 23 Jul 2026 23:52:23 +0530
From: Aditya Sharma <adi.sharma@zohomail.in>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@kernel.org>,
	"Lorenzo Stoakes" <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	"Vlastimil Babka" <vbabka@kernel.org>,
	"Mike Rapoport" <rppt@kernel.org>,
	"Suren Baghdasaryan" <surenb@google.com>,
	"Michal Hocko" <mhocko@suse.com>,
	"David Rientjes" <rientjes@google.com>,
	"Shakeel Butt" <shakeel.butt@linux.dev>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>,
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
	"Kees Cook" <kees@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>,
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>,
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
	"Valentin Schneider" <vschneid@redhat.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	"linux-mm" <linux-mm@kvack.org>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"imbrenda" <imbrenda@linux.ibm.com>
Message-ID: <19f9036e10d.333785164640.2738459517257915395@zohomail.in>
In-Reply-To: <20260721171724.56f1aad5@gandalf.local.home>
References: <20260719185409.409685-1-adi.sharma@zohomail.in> <20260719185409.409685-7-adi.sharma@zohomail.in> <20260721171724.56f1aad5@gandalf.local.home>
Subject: Re: [RFC PATCH 6/7] mm: add tracepoints and vmstat counters for
 async teardown
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

 > > +    TP_STRUCT__entry(
 > > +        __field(struct mm_struct *, mm)
 > > +        __field(int, pid)
 > > +        __array(char, comm, TASK_COMM_LEN)
 > 
 > There's an effort to make comm size more dynamic and we want to prevent more
 > memcpy of the comm based on TASK_COMM_LEN. Please change the above to:
 > 
 >         __string(comm, comm);
 > 
 > 
 > > +        __field(unsigned long, rss)
 > > +        __field(int, node)
 > > +    ),
 > > +
 > > +    TP_fast_assign(
 > > +        __entry->mm = mm;
 > > +        __entry->pid = current->pid;
 > > +        memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 > 
 > And this to:
 > 
 >         __assign_str(comm);
 > 
 > > +        __entry->rss = rss;
 > > +        __entry->node = numa_node_id();
 > > +    ),
 > > +
 > > +    TP_printk("mm=%p pid=%d comm=%s rss=%lukB node=%d",
 > > +        __entry->mm,
 > > +        __entry->pid,
 > > +        __entry->comm,
 > 
 > and this to:
 > 
 >         __get_str(comm),
 > 

Noted.

Thanks

Aditya
