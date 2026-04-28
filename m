Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7A1DB551;
	Tue, 28 Apr 2026 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402304; cv=none; b=abcZw2zfsLPtT//v7+kMEL9w8gj4y8B/D4Lb590qWl3ZQ7puaOf1M1rGvFSPRQHAmJRCQ5pM7wX6il2JC9knHIBcUMKismUD/q87dtv20gVO139QD93XeD5fIY7OahF2YD/2/6uFDSUO41B39LuhqSzwdhHOD7kNMGVe/IkN0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402304; c=relaxed/simple;
	bh=g6ikfoU1LHUCrwqZ6C3hHdK5O+DERhnchdkznqb6v1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pv2KmS1ootc9LL2Qvh4lGC856lLE3M4IyB0BQ5rHBwe6PoitabAsqKm+NpGloIVHT34SYf7Rj+85DSwX2caB0dEtdWa6UX2f5q5T8kZSUqYaMdu2zTm2kG8s6B4BaoIeI/nxQnENSZAY3PY1A7irTbrbQsvI6Kf9MA8yDH9KAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 51BF81C0619;
	Tue, 28 Apr 2026 18:51:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id F3B2120030;
	Tue, 28 Apr 2026 18:51:36 +0000 (UTC)
Date: Tue, 28 Apr 2026 14:51:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "open list:SCHEDULER"
 <linux-kernel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>, acme@kernel.org, williams@redhat.com,
 gmonaco@redhat.com
Subject: Re: [PATCH v3 1/4] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <20260428145151.3860aa04@gandalf.local.home>
In-Reply-To: <abQsFM9tFPr3Mrtt@fedora>
References: <20260311125021.197638-1-wander@redhat.com>
	<20260311125021.197638-2-wander@redhat.com>
	<20260311193503.GS606826@noisy.programming.kicks-ass.net>
	<abLzS0T_wEt_SkL6@fedora>
	<20260313090404.GK606826@noisy.programming.kicks-ass.net>
	<abQsFM9tFPr3Mrtt@fedora>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: fezgicd8abfznjtxik31r639hekhshtq
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: F3B2120030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0KAD7ph+3Vtklma4cWlGaZGDvjoax82U=
X-HE-Tag: 1777402296-843016
X-HE-Meta: U2FsdGVkX18rpObsFDcJUYY+/Q4809Xfdt7wG4uYomPQx79R5RIrySqRo1FCLoe7aIb1u/K8QFhrRjHFzvKVHbOLgajiPVCguro/oHAlRvuRKaR9DxswMYuVU/ssYHy1DrqrrLyNbhDeY33FGFORzFwlFM3AD30FctZ6ZXF68JdNkc+3KklnplMs7FMMHZous+suFYISo+hoKPGS7/qVN6YTh9OCo+PzkWkkINDDyiSMVzIBOKfvSQlYRXtlXI0P/2qnUEuhUXeVCHceU0omvUqIawBk++ZImz/1d2zfaT+//OEnaLZFItnwaclnrLy+lkWRcZICCXbPBinNBE3Nqpwd9d8+Ja1L

On Fri, 13 Mar 2026 12:36:10 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> On Fri, Mar 13, 2026 at 10:04:04AM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 12, 2026 at 02:19:15PM -0300, Wander Lairson Costa wrote:
> >  =20
> > > > That's significant bloat, for really very little gain. Realistically
> > > > nobody is going to need these.
> > > >  =20
> > >=20
> > > Of course, I can't speak for others, but more than once I debugged is=
sues
> > > that those tracepoints had made my life far easier. Those cases convi=
nced
> > > me that such a feature would be worth it. But if you don't see
> > > value and will reject the patches no matter what, nothing can be done,
> > > and I will have to accept defeat. =20
> >=20
> > If distros are going to enable this, I suppose I'm not going to stop
> > this. But I do very much worry about the general bloat of things, there
> > are a *LOT* of preempt_{dis,en}able() sites.
> >  =20
>=20
> We plan to enable these tracepoints in the RHEL kernel-rt to track
> extended non-preemptible states that cause high latencies. These
> issues occasionally surface in customer OpenShift deployments, where
> deploying a custom debug kernel is highly impractical. Having these
> tracepoints available in the distribution kernel would be handful for
> debugging these production systems. That said, I expect enabling this
> feature to be the exception rather than the rule =E2=80=94 most distribut=
ion
> kernels would leave it disabled.

Is this work going to continue? Or should I just change the status to
"reject" in patchwork?

-- Steve
