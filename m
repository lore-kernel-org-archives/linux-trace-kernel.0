Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20897368974
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787791313; cv=none; b=tQ4B/98Cju5t7RtKjbX8KgFzno9Y4PQjaELQXNP3aC5hUIXdwEiqJM756r6EB/8ZifzsTMS5TncuIzZYlPxYZYS1Xrlez5pfuhaj8w1opAfTIZPgCmXBB0cobFX2EOMjbSpDkj/feQLz2cjtvpUwCyeMJZ+3qlICtlMY7Th8Cw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787791313; c=relaxed/simple;
	bh=Q4mCk+bDxvLmed9HE+r122Jun2S+D6BfTY6PxWJJGGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX++KASs9oOOIjiUrl2z57Ty9ZNKTINSv6KSSW0x+m2SoD/MIgnrXqw7T4c3YQQCqHBlflL68MOQW50DLhZ+SYZADfZzQss74Y/TuSe13KBmhkt9V7r8nz37N0X1EhS8GVQLXXUQM234N/YEoICVb0pZMhzJrgi5Q6GJa/XfrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=2Bd5YG/d; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="2Bd5YG/d"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 33690120268;
	Thu, 27 Aug 2026 00:41:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 8C9AE20026;
	Thu, 27 Aug 2026 00:41:45 +0000 (UTC)
Date: Wed, 26 Aug 2026 20:41:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment
Message-ID: <20260826204144.73f89699@fedora>
In-Reply-To: <588ce7912915573ccba7439d7e50a90d7941c764.camel@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
	<20260824211544.3984835-2-crwood@redhat.com>
	<20260824213037.F41B11F000E9@smtp.kernel.org>
	<20260826153132.1333fac6@gandalf.local.home>
	<588ce7912915573ccba7439d7e50a90d7941c764.camel@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i9mzzaowpwj9rm7rijyb57kw9ano5u13
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8C9AE20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+KbKiQmYmCfx9BIzC5w8LNXUZW+Ypqp64=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Ev6a+8iRkV2YP1SE7eFYyB2JggOsFEQUP4GAetf/URU=; b=2Bd5YG/dncrfD/Cp8RJdJDHgVl9uIwawmB8ji1trFp5SQQli9fyieNsO89xIP9DKk/p6HnjomTgwnudAlx1P6JQRs6UBt+AnlpCNh/UAkpMv+lAdD8n0/kydpPKm29DzFJtkyt8UceCV3acwf4qp+J4GWnmmBqOjtMcW9KLjME0=
X-HE-Tag: 1787791305-56214
X-HE-Meta: U2FsdGVkX18uBUkZr8Z6X4Fit7tQmbPqRGFV0K9AV5bjMnAr7QDMlqRTmJkwTgzeAVGKuTktUZ050tbpazKGe7CZN6PK0yGSlZZRR/b5ErZKv/WMxBk9a4p46TSVno5hI3bn/dKSkW1xsMcREU8cGVPkQB+qBEccsGkvdi6Sgmfq75Hx3C0r204cFvj0mn86n37k6do2SEAw2iLoMqweLS5kS4Qc6VGRpWei2UxgdiQ06gWZdHS3q/GSamsKrewYK4JXc7Ve/SBC8x0NVHZHRAypxP9kMiGiQmPj4oDxgU5+EcVXlz+2ISVoLqfSWSVTqnMHDsBWtkgyXLTj+WMdSd4k2LRlIraF

On Wed, 26 Aug 2026 16:19:29 -0500
Crystal Wood <crwood@redhat.com> wrote:

> > 
> > It has some tests I ran along with tracing that detected issues. Of course,
> > everything needs to be run with lockdep enabled too.  
> 
> I did run with lockdep (and some custom hacky state tracking) but
> forcing migration is a hole in my test coverage.
> 
> Is there a particular test you're suggesting?

I think I mostly did:

  $ while true; do rtla timerlat top -u -q & PID=$!; sleep 5;

or variations of it. IIRC, that would cause a lockdep splat here or
there.

-- Steve
