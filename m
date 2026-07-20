Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE253BB10D;
	Mon, 20 Jul 2026 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572304; cv=pass; b=atQ0KcfUsHH/VtZrpHT6p8keYOoOJINELQOf2bU/oiysglZJKgxo5iVihHAq52EQbx+rnYzBAeketSSFZ8H0PZesP6/n91IUFJx4stkxNvfUq93GyzFXYq54Awpb/HoW/C4m/8u9kNl//fYSjqoDNwPCRaVc3q4bU/8GLBBmCUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572304; c=relaxed/simple;
	bh=tJLYFP8WkToo6Lzk/HG0GCiA3d9z2jl2PrOIp1mskxI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NbRAu5hHwaEPxVVWgqc/aYc0o4Rpq8MQ8KhR3nvQFl4+8W5akw8cVQFS3ppCTzgPI1GR5FrbhMAIaRNoFBFdBh2+9vG+TlHTJz2eQrjOQE9byC5s86T/JXkLafoCJzo1TCO7W+hC41KtNgtnaF5TQ9r5DJPXgnm/uweQ38CrH/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=kKnTBaQx; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="kKnTBaQx"
ARC-Seal: i=1; a=rsa-sha256; t=1784572224; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=aQ0WFfaj+RRG5KYT7uo4r4S+tzBtUUAnScyIeeDChof3v/5+jCIBtA0KRtLZZ/bLoJkKj7aIXSoJPnHWLqkbHCjVy4xitSLw88BjLrRlMtCz27hC+K7L3cJY2MVJvbs9aRNM83WVJGzamwYLP3W352CihZ1crlUqLqkE2iWbS3g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784572224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=64nKL4t7ZOMJQeMJXoupi8lChMlperoUGSuRJb+kKxs=; 
	b=gJ2MPLsspdyw//XfJWZkwlydjoflMbpvM7VZZlMX/eRLpYJCcopp9N0XU7g6KWnX88zgf9+vDGp3bvTRU/+HyEJJsz5vCKjAhePMpxTztT1KtatTRR8OpcTy/PkismFR1jAZ1P5PTCDGHCDWEzjhbGZsm0pIgiqTE5/uP2/TRNw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784572224;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=64nKL4t7ZOMJQeMJXoupi8lChMlperoUGSuRJb+kKxs=;
	b=kKnTBaQx1r72oiZf0DMEoii58d21jADdLQk24tPRe+kQL/zQ9iL+nTcmUlukaarG
	/2cRMOkJLd25O0bv0X/DSBTXyNLpq2YTocjessecMpHpBZrfEtdXtDyPfZPO49aVGbk
	a8kqVtKV7IXXDapjlDIAsxrF6bxalRDQNkbAg0JY=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1784572223203771.9033389679731; Tue, 21 Jul 2026 00:00:23 +0530 (IST)
Received: from  [14.139.128.24] by mail.zoho.in
	with HTTP;Tue, 21 Jul 2026 00:00:23 +0530 (IST)
Date: Tue, 21 Jul 2026 00:00:23 +0530
From: Aditya Sharma <adi.sharma@zohomail.in>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
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
	"Steven Rostedt" <rostedt@goodmis.org>,
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
Message-ID: <19f80cb1ed8.13fd666243425.2308143427066829733@zohomail.in>
In-Reply-To: <d1180a70-f4b4-4c22-9ce5-881cb0e2370d@kernel.org>
References: <20260719185409.409685-1-adi.sharma@zohomail.in> <d1180a70-f4b4-4c22-9ce5-881cb0e2370d@kernel.org>
Subject: Re: [RFC PATCH 0/7] mm: defer address-space teardown of large
 exiting processes to a kthread
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



Sent using Zoho Mail


From: David Hildenbrand (Arm) <david@kernel.org>
To: "Aditya Sharma"<adi.sharma@zohomail.in>, "Andrew Morton"<akpm@linux-foundation.org>, "Lorenzo Stoakes"<ljs@kernel.org>, "Liam R . Howlett"<liam@infradead.org>, "Vlastimil Babka"<vbabka@kernel.org>, "Mike Rapoport"<rppt@kernel.org>, "Suren Baghdasaryan"<surenb@google.com>, "Michal Hocko"<mhocko@suse.com>
Cc: "David Rientjes"<rientjes@google.com>, "Shakeel Butt"<shakeel.butt@linux.dev>, "Jonathan Corbet"<corbet@lwn.net>, "Shuah Khan"<skhan@linuxfoundation.org>, "Steven Rostedt"<rostedt@goodmis.org>, "Masami Hiramatsu"<mhiramat@kernel.org>, "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>, "Kees Cook"<kees@kernel.org>, "Ingo Molnar"<mingo@redhat.com>, "Peter Zijlstra"<peterz@infradead.org>, "Juri Lelli"<juri.lelli@redhat.com>, "Vincent Guittot"<vincent.guittot@linaro.org>, "Dietmar Eggemann"<dietmar.eggemann@arm.com>, "Ben Segall"<bsegall@google.com>, "Mel Gorman"<mgorman@suse.de>, "Valentin Schneider"<vschneid@redhat.com>, "K Prateek Nayak"<kprateek.nayak@amd.com>, <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <imbrenda@linux.ibm.com>
Date: Mon, 20 Jul 2026 13:43:34 +0530
Subject: Re: [RFC PATCH 0/7] mm: defer address-space teardown of large exiting processes to a kthread


 > QEMU has an rather short implementation for async teardown using
 > clone(CLONE_VM), which is IIRC essentially the result of Claudios previous
 > kernel work you note below.
 > 
 > So nothing got merged because the problem was solvable in userspace.

Thanks for this. My related works paragraph is wrong on this then. It
says that the s390 case was addressed with KVM specific async destruction,
but what you point to is QEMU's shadow process. I will correct that in v2.

Yeah, that CLONE_VM trick works, so I would measure and compare them
and get back.

I plan to measure:

- Memory return latency
- N concurrent shadow teardowns on N cpus vs the reaper.

One difference between CLONE_VM approach and CONFIG_ASYNC_MM_TEARDOWN
is that the shadow process has to be created by the process that would
be torn down itself. If that same behaviour is wanted on a workload
where we dont own the source, CONFIG_ASYNC_MM_TEARDOWN enables it here
as well. Also, in the QEMU case, it also means that the deferred teardown
decision was made without knowing how large the process might become.
CONFIG_ASYNC_MM_TEARDOWN adds a gate where for the exiting process,
RSS is evaluated againsts the current backlog before queuing it for
async teardown.

I will drop a follow up with numbers

Aditya

