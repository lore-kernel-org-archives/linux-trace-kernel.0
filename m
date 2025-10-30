Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5034D936;
	Thu, 30 Oct 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818379; cv=none; b=sS06kOlhynvqdy+lUzVAW0nsoKEWGqBdMhHEfSKK8m9vGX7Syl3xJiZecm7r+yDPS5mKDu61JIG5Si8AlHTNdQcdhzVb5VBtT4UG44q7QrsgaIQhEKVAlPk9n45wjlEr2kGB95XWxHaLIJt0ILK2FISJFvFRWmXVpgxOT4RfGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818379; c=relaxed/simple;
	bh=o+Jg5TSAg8pGONPUOkMkz/vBO4GWntCYKr2dmVsl+00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfwbNZb1pnEtDuLBc5H57uepbiR5+ZEXqrpYMMKyQnJn/95dVZRAExo0q6ven/zRDIJIH0F/kcyZB2N5d7AS8PndjkWqWYvgoAqivm5IYaWe0FbBewk8xud8Utd6qqXHoyhdA85s5at+Jv1RK2ujAg8zyQkRpZfFOrzm8KyDNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 7BD3013C056;
	Thu, 30 Oct 2025 09:59:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id ACA1718;
	Thu, 30 Oct 2025 09:59:34 +0000 (UTC)
Date: Thu, 30 Oct 2025 06:00:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood
 <crwood@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/rtla: Fix unassigned nr_cpus
Message-ID: <20251030060016.0d58fe5d@gandalf.local.home>
In-Reply-To: <CAP4=nvTZP+=_hALnW2VB35KWwu5TNJ9m4FS8pLfk3hxFLTTtGg@mail.gmail.com>
References: <20251002170846.437888-1-costa.shul@redhat.com>
	<CAP4=nvTZP+=_hALnW2VB35KWwu5TNJ9m4FS8pLfk3hxFLTTtGg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ACA1718
X-Stat-Signature: zqt9x6cid84ghof7z9k58udg7j5nzs6r
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+A52WeeGRhzV6PG2dzpsv1FTcsIFzJkeo=
X-HE-Tag: 1761818374-58454
X-HE-Meta: U2FsdGVkX19aeonAE0yx95jYmholYzP0a42Zi4LE77RaUDIXi8hiKKy7O6T3MjUZ4c7To881IqtOVHszj1ebp2p/+DT+eduL/kfskWYIxleuLODuyY1zdMSG9oNC+IOiZUKcAwX2LuNXXFLnG5Z9iTU50rrI3s1/qq8G8a3QLSTghTzJ3jxsZ56GtQGtHUS42T5lzkV2wqhZTFjHk/3rBeYhKKAbF8b4JkYZJmdRodaNdDA2OipBNvQju4gCPTVFIMTVYq1iNzbTuOkYNh8w9rlxYvRBydnZCC0G2+6cvUFboamX9ZtbrYAPCK7KuazIe4LPCKuKjXhpB+0GEHcapXWJzXoLqepKanJagKjStMr2DMvRcE3hNw==

On Thu, 30 Oct 2025 10:10:36 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Hi Steven,
>=20
> =C4=8Dt 2. 10. 2025 v 19:09 odes=C3=ADlatel Costa Shulyupin
> <costa.shul@redhat.com> napsal:
> >
> > In recently introduced timerlat_free(),
> > the variable 'nr_cpus' is not assigned.
> >
> > Assign it with sysconf(_SC_NPROCESSORS_CONF) as done elsewhere.
> > Remove the culprit: -Wno-maybe-uninitialized. The rest of the
> > code is clean.
> >
> > Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> > ---
> >  tools/tracing/rtla/Makefile.rtla  | 2 +-
> >  tools/tracing/rtla/src/timerlat.c | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > =20
>=20
> This is another fix of a bug introduced in the 6.18-v1 RTLA code
> consolidation [1], this time affecting the resetting of idle states
> set through --deepest-idle-state. Could you please also add it to your
> RTLA fix queue?
>=20
> Also, this should have:
>=20
> Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between
> osnoise/timerlat and hist/top")
>=20
> [1] https://lore.kernel.org/linux-trace-kernel/20250907022325.243930-1-cr=
wood@redhat.com/T/
>

Thanks,

I'll take a look at this today. We need to start making you a maintainer
for this, so that you only need to send me pull requests.

Do you have a kernel.org account? If not, do you have PGP signatures from
other kernel.org developers to your key?

-- Steve
