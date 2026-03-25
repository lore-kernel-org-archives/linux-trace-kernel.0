Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE641F4168;
	Wed, 25 Mar 2026 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774399615; cv=none; b=m3S3+MlKIKKgzTKasv/pt4dkFisscg2OyhU/71C1KIH+CBMbbsRijLQZHzsNMFKCu3sNNcWyJDndk4klhocKgTXQ3OyX2bZNKSC9NKgswqcdhkpfgErYeIIYU1T8QaDAjmjqHRT3MEXUVgii/oBiDBzJyVSh592YV9cJrDkJ0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774399615; c=relaxed/simple;
	bh=2+Lxd+RbR/KCMM/mCiFwBha3oJ54xbhcylmXJP/QBdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiEPesR5Hskxby3z3FG+9SNERKiXFf8ZRGJ/k/ztyLts/sm3MRBbO7BTvFEV0n3WXb0Wg5dh9lkiCVBMiO3N8JAp26Y0vVdKnhQdSRXwFmawOLxS5cdHwqX7CKvsrZgS+iro+VbgjUyxAdH0yLfPR4h9Y5pIuLLA2V2uMaE5yh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 01D201A05E0;
	Wed, 25 Mar 2026 00:46:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 365E720018;
	Wed, 25 Mar 2026 00:46:45 +0000 (UTC)
Date: Tue, 24 Mar 2026 20:47:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v12 0/4] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260324204727.427846d4@gandalf.local.home>
In-Reply-To: <20260324203941.2bd628d9@gandalf.local.home>
References: <177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com>
	<20260324172557.04cfc2a9@gandalf.local.home>
	<20260325085644.4310a1295b0b962ed87b5b60@kernel.org>
	<20260325091304.c94f4e9505660202f96006a1@kernel.org>
	<20260324203941.2bd628d9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 365E720018
X-Rspamd-Server: rspamout06
X-Stat-Signature: 5djcig9qrz7eoymix1xdbozfp1d1tmda
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+gP9kKurv16gy8NN1rcqqkMjYATSKYRP8=
X-HE-Tag: 1774399605-664353
X-HE-Meta: U2FsdGVkX1+kdalMUHMupzHVgSfYMERUbmamMqLZ6CiwfvcUo/A2aFjrbL0t751YTP8lUtICP29eLKBMYXq55a3lXEqIHtuw6AmEraqxywW0mzWOuJXL8hYcMIxtE/VbQ7jHO75pAQ5AC72RWBZbHJ1KnysTp/rARgta+Ue3qbCpRQp3QZW3N2uf223u2rU0jX22NEbeZfVjcw0+org5ULwARafQYRD88piZr0KU/B6SXTY4RLkHd+vAAsLa1Cjro79md1+QWeXMiYLFhlgCKzLx+RrtBdKi2XvRFljJJVOmAvqYmpRh5Ph6bNIz+rDbjZZkivQuj1gX+Qmua+WvMvZ0T59tg//qG00ueRGTQ9MkU1B32cYLWLheGedR3UGTX7X70xhHL5BzArH3oXoKAQ==

On Tue, 24 Mar 2026 20:39:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 25 Mar 2026 09:13:04 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > I found the branch does not have a fix [1] and it makes a conflict with
> > [2/4]. Can you update it to merge the trace/fixes branch?
> > 
> > [1] f35dbac69421 ("ring-buffer: Fix to update per-subbuf entries of persistent ring buffer")
> > 
> > I can send a series on ring-buffer/for-next but I think it may
> > cause the same conflict on git-pull later.  
> 
> Ah crap. OK, let me merge in that commit to the for-next branch, and then see if it works.
> 
> Thanks for letting me know.

OK, refresh the ring-buffer/for-next branch and it has the fix merged.

There's still a small conflict (with a header file include). Could you
rebase on that?

Thanks,

-- Steve
