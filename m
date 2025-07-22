Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285D268683;
	Tue, 22 Jul 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198196; cv=none; b=i6wBNzHB/qzxquuvSOJiNpEBh/rpwxQcye9tCijbSZH6HqmEQvR1ZpYWg1TrysSJBD+sDDbKFL2xTDc8MwdUjLIx6qX6Nv+889mWpVvaicV5L5q6gDvRwn+SZgtNhalGwP5dxu/WGMWV3DsR6czQmTbr/ZwUi16Gk6ZED/2SK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198196; c=relaxed/simple;
	bh=wKCcCfvxKLI0mGtJPej/peeX+5Wyb20tFd1tXxnEOKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ypa4J6PP2KsT/oWacGJFCctfCbodRJT8D5kGRNDNQbDk6F7fDvqsuOH/Dwl6YPuxZHI7iPlRXRvAdcnonvVyVO0thW4bfmRp/F12aOfhqrofoIttsvGMawL//qwIUt3r9zSQWOo/flaWqUb9BB2W/qj1ufUKwvnI0AIeLZQduiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 3F4D51DA7A0;
	Tue, 22 Jul 2025 15:29:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 0899318;
	Tue, 22 Jul 2025 15:29:48 +0000 (UTC)
Date: Tue, 22 Jul 2025 11:29:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v2 9/9] Documentation/rtla: Add actions feature
Message-ID: <20250722112926.17ea1c65@batman.local.home>
In-Reply-To: <CAP4=nvQWCWAOefHAqA82-VDb-00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
	<20250626123405.1496931-10-tglozar@redhat.com>
	<20250721183606.0489b1cd@gandalf.local.home>
	<CAP4=nvQWCWAOefHAqA82-VDb-00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nftzeu9n61phu6uujp8tt5hew7hnfi6j
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0899318
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+1LscZVNRDhiJPTyMhlB9R1chrXZz/CJI=
X-HE-Tag: 1753198188-360740
X-HE-Meta: U2FsdGVkX1+5Cqw0b/vK0sAryyrWJNVIBCX/W1WP6cx5faPfFxE+VQTwYorF7AZ4Lx9DLNkSJf6Ifczk8yF3IuhP/OMgzvMMGl+zUQpihygOjv8qvMuK2SZGJKaFR4nlletVMH3x+11A+xRQWKuVS7a3mymy3dAM64576cPkQ16kUAbMHSKx2uBzBQjjMC+ZqEydJolijj/Zpdhe+0L2H0+xgZ4vZkhUYjV2v1fYiDzSmWmQ/3kgonTRDpO7BOq2AyVnCP5C7/dxVq0/glvObR8k9tGfBPJh9pKWA2Znets4nKfLlP35t/5ExwI8ngTer8/PY7nm1znINf2zG6g+8lcj6X6s2c3Q

On Tue, 22 Jul 2025 09:03:24 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> Of course, this is just an implementational limitation of the timerlat
> tracer. If timerlat had an event (like osnoise's "sample_threshold")
> triggered on threshold overflow and if it is possible to wait on it
> even without BPF, rtla could wait on that for both BPF and non-BPF
> mode instead of what it is currently doing.

Right. Is this something you may want?

-- Steve
