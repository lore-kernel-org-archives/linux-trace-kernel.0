Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC283BD63B;
	Mon, 20 Jul 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572804; cv=pass; b=Un5T37ZXKWsjjWC6ASsh4oCXSEmNUf3dQf5IH/GsSK9M9GnjqWaAsOIHoDBq0RZtZQCwsfUEv4rgN1RRxbJK7t9hWZAKLyrnQDY5CAGPAx7J7XBHfXT5EeSV0fImj8If+fTquAri+98VKb6Q4laqKw4TNzdryZSbEkmrEUapxKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572804; c=relaxed/simple;
	bh=eXbTc3VgPltAbeLC9B4nVCob7/M1HGp/H6H9uX6m+hg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RE9JMx6P4+DQP6wVt6lpa92RNVI3o3FlWDdOPfxA0rkx/s6PBA5a1BBhw4rStt0nvFUnWNPWeHyvO1hDGVbuNnpoYHJqoG10qYlJSF6fo1YUCmwncoGxnJ/kMUA/zn1pUpo5H2+7u0/SpPGQTWBjl9rEPUI7fda/1tCXusvWqeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=OzPsWnZa; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="OzPsWnZa"
ARC-Seal: i=1; a=rsa-sha256; t=1784572726; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=U2EgM9/PGsGpsyyKeNNu6jaQm9AzraiBZ/qzEN7iX/ESZa71d0KhTONzaf9D+qNC1sVXALdndY1BIoC2apXDmGASMt9NZW6pjufNqIkXS+5CcqFv+G2HYWf3qb/Z7+X/h/X8X+K3HpYHTigQwVUyn5EQy3M7793DYx0pDR7gA3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784572726; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=21jF7uNT/UmoujGO3hllhCYF5UQ/NYJ1eORppVbnz3U=; 
	b=a39cNvHHF6/npwftmelrS7iHwHh7849NCClNN9lnGlDR+Y3ZTMroVa3NuU3wkEP3KpaeVMvN3dCrgOZI/ZjKQefipdxsHNuaesCKFrz1A1HucDs09yObReTgCKWwQsnOZiYE+WdS00RJyxfXHAtGkIB4KA8EylgdhYW9zx8XXoY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784572726;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=21jF7uNT/UmoujGO3hllhCYF5UQ/NYJ1eORppVbnz3U=;
	b=OzPsWnZaTFinUg8fqmdvc4CoGzw2y4Q1rmzG7ffv6R/AiDxxENsZ4eYQ9hCEPsKH
	u7BRdu92RM9ztWderErMLNTYgQvdZCfJFAGIbXF7QBw5l1zF8Qyui0wpa278PWMpAef
	5X7mfHqjOg92+A5ZAFdLw7BjK1Msxzxm7eqebHS8=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1784572726154850.5205242083554; Tue, 21 Jul 2026 00:08:46 +0530 (IST)
Received: from  [14.139.128.24] by mail.zoho.in
	with HTTP;Tue, 21 Jul 2026 00:08:46 +0530 (IST)
Date: Tue, 21 Jul 2026 00:08:46 +0530
From: Aditya Sharma <adi.sharma@zohomail.in>
To: "Liam R . Howlett" <liam@infradead.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@kernel.org>,
	"Lorenzo Stoakes" <ljs@kernel.org>,
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
Message-ID: <19f80d2cb7e.2efd096643510.6776299399502503493@zohomail.in>
In-Reply-To: <ljr2jkxomq4ccgzq2ip3c66mjdryomhl2gxkswv4wzry5ye2ax@xaehxzjkkk3m>
References: <20260719185409.409685-1-adi.sharma@zohomail.in> <ljr2jkxomq4ccgzq2ip3c66mjdryomhl2gxkswv4wzry5ye2ax@xaehxzjkkk3m>
Subject: Re: [RFC PATCH 0/7] mm: defer address-space teardown of large
 exiting processes to a kthread
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



Sent using Zoho Mail


From: Liam R . Howlett <liam@infradead.org>
To: "Aditya Sharma"<adi.sharma@zohomail.in>
Cc: "Andrew Morton"<akpm@linux-foundation.org>, "David Hildenbrand"<david@k=
ernel.org>, "Lorenzo Stoakes"<ljs@kernel.org>, "Vlastimil Babka"<vbabka@ker=
nel.org>, "Mike Rapoport"<rppt@kernel.org>, "Suren Baghdasaryan"<surenb@goo=
gle.com>, "Michal Hocko"<mhocko@suse.com>, "David Rientjes"<rientjes@google=
.com>, "Shakeel Butt"<shakeel.butt@linux.dev>, "Jonathan Corbet"<corbet@lwn=
.net>, "Shuah Khan"<skhan@linuxfoundation.org>, "Steven Rostedt"<rostedt@go=
odmis.org>, "Masami Hiramatsu"<mhiramat@kernel.org>, "Mathieu Desnoyers"<ma=
thieu.desnoyers@efficios.com>, "Kees Cook"<kees@kernel.org>, "Ingo Molnar"<=
mingo@redhat.com>, "Peter Zijlstra"<peterz@infradead.org>, "Juri Lelli"<jur=
i.lelli@redhat.com>, "Vincent Guittot"<vincent.guittot@linaro.org>, "Dietma=
r Eggemann"<dietmar.eggemann@arm.com>, "Ben Segall"<bsegall@google.com>, "M=
el Gorman"<mgorman@suse.de>, "Valentin Schneider"<vschneid@redhat.com>, "K =
Prateek Nayak"<kprateek.nayak@amd.com>, <linux-mm@kvack.org>, <linux-doc@vg=
er.kernel.org>, <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.ke=
rnel.org>, <imbrenda@linux.ibm.com>
Date: Mon, 20 Jul 2026 03:58:47 +0530
Subject: Re: [RFC PATCH 0/7] mm: defer address-space teardown of large exit=
ing processes to a kthread


 > This reads like it was written by an AI, but there is no assisted-by
 > tags.  Which AI did you use to generate these patches and/or cover
 > letter?

I used claude opus 4.8 to refine commit messages (the design is mine,=20
the model was used to convey the intentions concretely). Further, I used
claude fable 5 for drafting the cover letter and reviewing the series, wher=
e
it flagged issues (I fixed some of those by hand and some were fixed by fab=
le itself,
which I then reviewed). It also assisted in writing the benchmark harness
behind the numbers and did the litmus test the cover letter mentions. Every=
 numbers
was measured by me, on my hardware. I take full responsibily of the entire=
=20
series.

My bad that I did not add an assisted-by tag. Should have added it to v1
v2 will add it to the patches

 > I do not see a benefit to running the task cleanup 'off the side'.  In
 > modern computers, that may mean switching core types that run at
 > different speeds.

That's why the reaper's affinity is a preference, not a bind (patch 2).
It uses kthread_affine_preferred() with housekeeping mask, so it can be
re-affined. kthread_bind_mask() would have taken that away. On a hybrid cpu=
,
it can be affined(by the (super)user) to whichever cores are appropriate.=
=20

I do not have numbers for P core and E core teardown costs. Will measure an=
d
send them.

 > Regardless of speed, the CPU that will be doing the work is remote to
 > the workload by design, (or may be, depending on the scheduling?).  That
 > is, you are tasking another CPU to do cleanup of local CPU-aware
 > information.. The ideal CPU to do a task exit is the one that's doing it
 > already.

Yes, it does cost something. Five consecutive 4GB inline teardowns in my te=
sting
costed 372ms in exit path, while 440 ms in the case of kthread drain for th=
e same
(five teardowns on another cpu). This cost became 1.18x. For multi gb mms,
the memory to be reaped would be much larger than the cpu cache can hold.
For small mms (< 64 MB, configurable by sysctl), the teardowns happen inlin=
e.=20

The oom_reaper already reaps the victim's address space from a remote conte=
xt,
as returning memory matters more than locality of teardown.

 > There are hidden costs to your approach and I don't really understand
 > how this could possibly speed things up - even parallelized tasks will
 > take more CPU time in total, even if locking issues are avoided.

This is not meant to speed up teardown. Rather the latency for someone wait=
ing
on death is reduced. Killing a 16 GB redis cost 292.97ms before returning t=
o
waitpid(). It costs 0.24 with async teardown. The memory itself was returne=
d
in about 300ms.

"parallelized" - This series does not parallelize the teardown. The design =
is serial.
N procesess exiting together today would tear down concurrently today. The =
reaper here,
uses one thread (nice 19, affined to housekeeping mask).

The numbers in cover letter support that this work is memory bound rather t=
han CPU bound.
In sync case: teardown is around 56 GB/s on my machine (1GB in 18.01 ms and=
 16GB in 282.16ms).
Thirty two concurrent 0.5GB exits reap in 157.42ms (around 101 GB/s). So, a=
 concurrency
of 32 gets about 1.8x. The single reaper thread takes 650ms to clear the sa=
me (about 25 GB/s).
Thus, this serialization took 4x the drain time, but takes peak concurrency=
 down to
one cpu. Memory actully comes back later. Whether that's a good tradeoff, d=
epends on=20
what else we wish to run on the box (open questions #1 in cover letter)

 > Sure, the task waiting for cleanup to complete may think it's done and
 > continue to do the Next Thing - but if it really needs the cleanup to be
 > completed

It is off by default and opt in (sysctl), so anything that depends on the
current semantics, continues to work exactly the same by doing nothing.

Also, mmput_async() already defers the teardown to a workqueue. So, in the =
current
kernel, there already exists a way where continuing to the next thing
does not necessarily mean that the memory is reclaimed.

 > completed then you've just made it impossible to know when it has
 > happened.

There are three vmstat counters and two tracepoint (patch 6).
Someone who opts in to the mechanism, and does need to make sure that the
cleanup is completed, can use the counters and tracepoints.

 > Also, you've just made this extremely hard to debug if something is
 > missed.

There are reap tracepoints that carry the pid, so we can get per pid comple=
tion status.

However, there is no number indicating the current depth of the queue. The =
series addds queued,
sync and rejected counters. Will add a reaped counter in v2 so that current=
 queue depth
can be estimated. Please mention what else tracability can be added to this=
,
and what senairo do you have in mind that these counters and tracepoints mi=
ght not
cover. I can add those to v2 as well.

 > The work that is done in teardown is necessary.  Your time (and tokens?)
 > would be better spent trying to improve what we have to do instead of
 > shifting the work around.

This does not compete with with current teardown path. it goes through the
same exit_mm(). Any future improvements there, also improve the reaper's dr=
ain
times.

Thanks

Aditya
